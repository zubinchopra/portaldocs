
<a name="loading-data"></a>
## Loading Data

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

<a name="loading-data-controlling-the-ajax-call-with-supplydata"></a>
### Controlling the AJAX call with <code>supplyData</code>

In the simple case, the `QueryCache` is sent a simple `sourceUri` attribute which it uses to form a request. This request is sent via a `GET`, with a default set of headers. In some cases, developers may wish to manually make the request.  This can be useful for some scenarios, including the following.

* The request needs to be a `POST` instead of `GET`
* Custom HTTP headers should be sent with the request
* The data needs to be processed on the client before placing it inside of the cache

The sample located at `<dir>\Client\V1\Data\SupplyData\SupplyData.ts`  overrides the code that makes the request by using the `supplyData` method. This code is also included in the following example.

```ts
public websitesQuery = new MsPortalFx.Data.QueryCache<SamplesExtension.DataModels.WebsiteModel, any>({
    entityTypeName: SamplesExtension.DataModels.WebsiteModelType,
    sourceUri: MsPortalFx.Data.uriFormatter(Shared.websitesControllerUri),

    // Overriding the supplyData function and supplying our own logic used to perform an ajax
    // request.
    supplyData: (method, uri, headers, data) => {
        // Using MsPortalFx.Base.Net.ajax to perform our custom ajax request
        return MsPortalFx.Base.Net.ajax({
            uri: uri,
            type: "GET",
            dataType: "json",
            cache: false,
            contentType: "application/json"
        }).then((response: any) => {
            // Post processing the response data of the ajax request.
            if (Array.isArray(response) && response.length > 5) {
                return response.slice(5);
            }
            else {
                return response;
            }
        });
    }
});
```

<a name="loading-data-optimize-number-cors-preflight-requests-to-arm-using-invokeapi"></a>
### Optimize number CORS preflight requests to ARM using invokeApi

When CORS is used to call ARM directly from the extension, the browser actually makes two network calls for every one **AJAX** call in the client code. The following examples describe the state before and after invoking API.

<details>
<summary> Before using invokeApi</summary>

The following code illustrates one preflight per request.

```ts
    public resourceEntities = new MsPortalFx.Data.EntityCache<DataModels.RootResource, string>({
        entityTypeName: ExtensionTemplate.DataModels.RootResourceType,
        sourceUri: MsPortalFx.Data.uriFormatter(endpoint + "{id}?" + this._armVersion, false),
        supplyData: (httpMethod: string, uri: string, headers?: StringMap<any>, data?: any, params?: any) => {
            return MsPortalFx.Base.Net.ajax({
                uri: uri,
                type: httpMethod || "GET",
                dataType: "json",
                traditional: true,
                headers: headers,
                contentType: "application/json",
                setAuthorizationHeader: true,
                cache: false,
                data: data
            })
        }
    });

```

This results in a CORS preflight request for each unique uri.  For example, if the user were to browse to two separate resources `aresource` and `otherresource`, it would result in the following requests.

```
Preflight 
    Request
        URL:https://management.azure.com/subscriptions/74b34cf3-8c42-46d8-ac89-f18c83815ea3/resourceGroups/testresourcemove/providers/Microsoft.PortalSdk/rootResources/aresource?api-version=2014-04-01&_=1447122511837 
        Method:OPTIONS
        Accept: */*
    Response
        HTTP/1.1 200 OK
        Access-Control-Allow-Methods: GET,POST,PUT,DELETE,PATCH,OPTIONS,HEAD
        Access-Control-Allow-Origin: *
        Access-Control-Max-Age: 3600
    Request
        URL:https://management.azure.com/subscriptions/74b34cf3-8c42-46d8-ac89-f18c83815ea3/resourceGroups/somerg/providers/Microsoft.PortalSdk/rootResources/otherresource?api-version=2014-04-01&_=1447122511837 
        Method:OPTIONS
        Accept: */*
    Response
        HTTP/1.1 200 OK
        Access-Control-Allow-Methods: GET,POST,PUT,DELETE,PATCH,OPTIONS,HEAD
        Access-Control-Allow-Origin: *
        Access-Control-Max-Age: 3600

Actual CORS request to resource
    Request
        https://management.azure.com/subscriptions/74b34cf3-8c42-46d8-ac89-f18c83815ea3/resourceGroups/somerg/providers/Microsoft.PortalSdk/rootResources/aresource?api-version=2014-04-01&_=1447122511837  HTTP/1.1
        Method:GET
    Response
        HTTP/1.1 200 OK
        ...some resource data..
    Request
        https://management.azure.com/subscriptions/74b34cf3-8c42-46d8-ac89-f18c83815ea3/resourceGroups/somerg/providers/Microsoft.PortalSdk/rootResources/otherresource?api-version=2014-04-01&_=1447122511837  HTTP/1.1
        Method:GET
    Response
        HTTP/1.1 200 OK
        ...some otherresource data..
```

This is making one preflight request for each `MsPortalFx.Base.Net.ajax` request. In the extreme case, if network latency were the dominant factor this would be a 50% overhead.

</details>
<details>
<summary> After applying the invokeApi optimization</summary>

To apply the `invokeApi` optimization, perform the following two steps.

1. Supply the invokeApi option directly to the `MsPortalFx.Base.Net.ajax({...})` option. This allows the extension to use the fixed endpoint `https://management.azure.com/api/invoke` to which to issue all the requests. The actual path and query string are actually passed as a header `x-ms-path-query`. At the `api/invoke` endpoint, ARM reconstructs the original URL on the server side and processes the request in its original form. 

1. Remove `cache:false`.  This avoids emitting a unique timestamp (i.e., &_=1447122511837) on every request, which invalidates the single-uri benefit that is provided by the `invokeApi`.

The following code demonstrates the application of this optimization.

```ts
    public resourceEntities = new MsPortalFx.Data.EntityCache<DataModels.RootResource, string>({
        entityTypeName: ExtensionTemplate.DataModels.RootResourceType,
        sourceUri: MsPortalFx.Data.uriFormatter(endpoint + "{id}?" + this._armVersion, false),
        supplyData: (httpMethod: string, uri: string, headers?: StringMap<any>, data?: any, params?: any) => {
            return MsPortalFx.Base.Net.ajax({
                uri: uri,
                type: httpMethod || "GET",
                dataType: "json",
                traditional: true,
                headers: headers,
                contentType: "application/json",
                setAuthorizationHeader: true,
                invokeApi: "api/invoke",
                data: data
            })
        }
    });    
```

This code results in the following requests.

```
Preflight 
    Request
        URL: https://management.azure.com/api/invoke HTTP/1.1
        Method:OPTIONS
        Accept: */*
        Access-Control-Request-Headers: accept, accept-language, authorization, content-type, x-ms-client-request-id, x-ms-client-session-id, x-ms-effective-locale, x-ms-path-query
        Access-Control-Request-Method: GET

    Response
        HTTP/1.1 200 OK
        Cache-Control: no-cache, no-store
        Access-Control-Max-Age: 3600
        Access-Control-Allow-Origin: *
        Access-Control-Allow-Methods: GET,POST,PUT,DELETE,PATCH,OPTIONS,HEAD
        Access-Control-Allow-Headers: accept, accept-language, authorization, content-type, x-ms-client-request-id, x-ms-client-session-id, x-ms-effective-locale, x-ms-path-query

Actual Ajax Request
    Request
        URL: https://management.azure.com/api/invoke
        x-ms-path-query: /subscriptions/74b34cf3-8c42-46d8-ac89-f18c83815ea3/resourceGroups/somerg/providers/Microsoft.PortalSdk/rootResources/aresource?api-version=2014-04-01
        Method:GET      
    Response
        HTTP/1.1 200 OK
        ...some aresource data..
    Request
        URL: https://management.azure.com/api/invoke
        x-ms-path-query: /subscriptions/74b34cf3-8c42-46d8-ac89-f18c83815ea3/resourceGroups/somerg/providers/Microsoft.PortalSdk/rootResources/otherresource?api-version=2014-04-01
        Method:GET
    Response
        HTTP/1.1 200 OK
        ...some otherresource data..
```

In the above you will note that:

1. The preflight request is cached for an hour.
1. The request is now always for a single resource `https://management.azure.com/api/invoke`. Because all requests now go through this single endpoint, it results in a single preflight request that is used for all subsequent requests, which is a great improvement on the previous example.
1. The `x-ms-path-query` preserves the request for the original path segments, the query string and the hash from the query cache.

Within the Portal implementation itself, this optimization has been applied to the Hubs extension.

<!-- TODO:  Determine whether the following sentence came from best practices and usabililty studies. -->
 We have observed about 15% gains for the scenarios we tested (resources and resource-groups data load) with normal network latency. As latencies get higher, the benefits should be greater.
</details>

<a name="loading-data-reusing-loaded-or-cached-data-with-findcachedentity"></a>
### Reusing loaded or cached data with <code>findCachedEntity</code>

Browsing resources is a very common activity in the new Azure Portal.  Columns in the resource list should be loaded using a `QueryCache<TEntity, ...>`.  When the user activates a resource list item, the details that are displayed in the resource blade should be loaded using an `EntityCache<TEntity, ...>`, where `TEntity` is often shared between the two data caches.  To display details of a resource, rather than issue an **AJAX** call to load the resource details model into `EntityCache`, use the `findCachedEntity` option to locate this entity that was previously loaded in some other `QueryCache` or that was nested in some other `EntityCache`.

```ts
this.websiteEntities = new MsPortalFx.Data.EntityCache<SamplesExtension.DataModels.WebsiteModel, number>({
    entityTypeName: SamplesExtension.DataModels.WebsiteModelType,
    sourceUri: MsPortalFx.Data.uriFormatter(DataShared.websiteByIdUri),
    findCachedEntity: {
        queryCache: this.websitesQuery,
        entityMatchesId: (website, id) => {
            return website.id() === id;
        }
    }
});

``` 

<a name="loading-data-ignore-redundant-data-with-cachedajax"></a>
### Ignore redundant data with <code>cachedAjax()</code>

If the call to `MsPortalFx.Base.Net.ajax()` is replaced with `MsPortalFx.Base.Net.cachedAjax()`, then a hash is generated on the server to provide change detection.  This not only saves network bandwidth, but it also saves client-side processing.

This capability is built into the SDK as a server-side filter that is activated when the header `x-ms-cache-tag` is present.  This value is a SHA256 hash of the return data plus the query information.  

**NOTE**: If the extension uses a backend server that does not utilize the SDK, then this filter may not be available by default and therefore the calculation may need to be implemented by the service provider.

The hash calculation should ensure uniqueness of the query and result, as in the following example.  

`x-ms-cache-tag = sha256(method + URL + query string + query body + result)`

If the `RequestHeader.x-ms-cache-tag` is equivalent to the  `ResponseHeader.x-ms-cache-tag` then do not return any data and instead return the status `304` `NOT MODIFIED`.

When using `cachedAjax()`, the return data is wrapped in the following interface.

```ts
export interface AjaxCachedResult<T> {
    cachedAjax?: boolean;
    data?: T;
    modified?: boolean;
    textStatus?: string;
    jqXHR?: JQueryXHR<T>;
}
```

The parameters are as follows.

* **cachedAjax**: Serves as a signature to inform the `dataLoader` that this return result was from `cachedAjax()` instead of `ajax()`.

* **data**: Contains the returned data or `null` if the data was not modified.

* **modified**:  Indicates that this is a different result from the previous query and that the `data` attribute represents the current value.

* **textStatus**: A human readable success status indicator.

* **jqXHR**: The **AJAX** result object that contains more details for the call.

The following example shows the same `supplyData` override using the `cachedAjax()` method.

```ts
public websitesQuery = new MsPortalFx.Data.QueryCache<SamplesExtension.DataModels.WebsiteModel, any>({
    entityTypeName: SamplesExtension.DataModels.WebsiteModelType,
    sourceUri: MsPortalFx.Data.uriFormatter(Shared.websitesControllerUri),

    // Overriding the supplyData function and supplying our own logic used to perform an ajax
    // request.
    supplyData: (method, uri, headers, data) => {
        // Using MsPortalFx.Base.Net.cachedAjax to perform our custom ajax request
        return MsPortalFx.Base.Net.cachedAjax({
            uri: uri,
            type: "GET",
            dataType: "json",
            cache: false,
            contentType: "application/json"
        }).then((response: MsPortalFx.Base.Net.AjaxCachedResult<any>) => {
            // Post processing the response data of the ajax request.
            if (response.modified && Array.isArray(response.data) && response.data.length > 5) {
                return response.data = response.data.slice(5);
            }
            return response;
        });
    }
});
```

When `response.modified` is equal to false, then no merge operation is performed.

<a name="loading-data-making-authenticated-ajax-calls"></a>
### Making authenticated AJAX calls

For most services, developers will make Ajax calls from the client to the server. Often the server acts as a proxy, and makes another call to a server-side API which requires authentication. 

**NOTE**: One server-side API is ARM.

When bootstrapping extensions, the portal will send a [JWT token](portalfx-extensions-glossary-data.md) to the extension. That same token can be included in the HTTP headers of a request to ARM, in order to provide end-to-end authentication. To help make those authenticated calls, the portal includes an API which performs Ajax requests, similar to the jQuery `$.ajax()` library named `MsPortalFx.Base.Net.ajax()`. If the extension uses a `DataCache` object,  this class is used by default. However, it can also be used independently, as specified in the example located at 
<!-- TODO:  Determine whether LoaderSampleData.ts is still used or has been replaced.  It is no longer in <SDK>\\Extensions\SamplesExtension\Extension.  The closest match is  Client\V1\Data\SupplyData\Templates\SupplyDataInstructions.html -->
`\Client\Data\Loader\LoaderSampleData.ts`.

 This code is also included in the following example.


```ts
var promise = MsPortalFx.Base.Net.ajax({
    uri: "/api/websites/list",
    type: "GET",
    dataType: "json",
    cache: false,
    contentType: "application/json",
    data: JSON.stringify({ param: "value" })
});
```
