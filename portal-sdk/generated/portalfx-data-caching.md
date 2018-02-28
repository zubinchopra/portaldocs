<a name="the-datacache-class"></a>
## The DataCache class

The Azure Portal FX DataCache class objects are `QueryCache`, `EntityCache` and the `EditScopeCache`.  The `DataCache` classes all share the same API. 

<!--TODO: Determine whether it is more accurate to say the following sentence.
The `DataCache` objects all share the same class within the API. 
  -->

They are a full-featured way of loading and caching data used by blade and part `ViewModels`.

 `QueryCache` queries for a collection of data, whereas  `EntityCache` loads an individual entity. QueryCache takes a generic parameter for the type of object stored in its cache, and a type for the object that defines the query, as in the `WebsiteQuery` example located at `<dir>Client\V1\Data\MasterDetailBrowse\MasterDetailBrowseData.ts`.
 
In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

<a name="the-datacache-class-configuring-the-data-cache"></a>
### Configuring the data cache

Multiple parts or services in an extension will rely on the same set of data. For queries, this may be a list of results, whereas for a details blade, it may be a single entity. In either case, it is critical to ensure that all parts that use a given set of data perform the following actions.

* Use a single HTTP request to access that data
* Read from a single cache of data in memory
* Release that data from memory when it is no longer required

These are all features that `MsPortalFx.Data.QueryCache` and `MsPortalFx.Data.EntityCache` provide. 

<!--TODO: Remove the following placeholder sentence when it is explained in more detail. -->
Because this discussion includes AJAX, TypeScript, and template classes, it does not strictly specify an object-property-method model.

<a name="the-datacache-class-querycache"></a>
### QueryCache

The `QueryCache` object is used to query for a collection of data. The `QueryCache` can be used to cache a list of items. It takes a generic parameter for the type of object stored in its cache, and a type for the object that defines the query, as in the `WebsiteQuery` example.  

The `QueryCache` parameters are as follows.

<!-- TODO: Determine whether the sourceURI and entityTypeName are required paramters.  Per the example given, the other parameters are optional. -->

**DataModels.WebsiteModel**: Optional. The model type for the website. This is usually auto-generated (see TypeMetadata section below).

**WebsiteQuery**: Optional. The type that defines the parameters for the query. This often will include sort order, filter parameters, paging data, etc.

**entityTypeName**: Provides the name of the metadata type. This is usually auto-generated (see TypeMetadata section below).

**sourceUri**: Provides the endpoint which will accept the HTTP request.

**poll**: Optional. A boolean field which determines whether entries in this cache should be refreshed on a timer.  You can use it in conjunction with property pollInterval can be used to override the default poll interval and pollPreservesClientOrdering can be used to preserve the client's existing record order when polling as opposed to using the order from the server response.

**supplyData**: Optional. Allows the extension to override the logic used to perform an AJAX request. Allows for making the AJAX call, and post-processing the data before it is placed into the cache.

When the `QueryCache` that contains the websites is created, two elements are specified.

1. The **entityTypeName** that provides the name of the metadata type. The QueryCache needs to know the shape of the data contained in it, in order to handle the data appropriately. That information is specified with the entity type.

1. The **sourceUri** that provides the endpoint that will accept the HTTP request. This function returns the URI to populate the cache. It is sent a set of parameters that are sent to a `fetch` call. In this case, `runningStatus` is the only parameter. Based on the presence of the `runningStatus` parameter, the URI is modified to query for the correct data.

<!-- TODO:  determine whether "presence" can be changed to "value". Did they mean true if present and false if absent, with false as the default value?  This sentence needs more information. -->

When all of these items are complete, the `QueryCache` is  configured. It will be populated while Views are being created over the cache, and the `fetch()` method is called. 

The sample located at  `<dir>Client\V1\Data\MasterDetailBrowse\MasterDetailBrowseData.ts` creates a `QueryCache` which polls the `sourceUri` endpoint on a timed interval. This code is also included in the following example.

```ts
export interface WebsiteQuery {
    runningStatus: boolean;
}

public websitesQuery = new MsPortalFx.Data.QueryCache<DataModels.WebsiteModel, WebsiteQuery>({
    entityTypeName: DataModels.WebsiteModelType,
    sourceUri: MsPortalFx.Base.Resources.getAppRelativeUri("/api/Websites?runningStatus={0}"),
    poll: true
});
```

<a name="the-datacache-class-entitycache"></a>
### EntityCache
 
<!-- Determine whether a template class can be specified as an object in the content.  Otherwise, find a more definitive term. -->

The `EntityCache` object can be used to cache a single item. 
<!--TODO: Determine whether these parameters can be described as "
a generic parameter for the type of object stored in its cache, "
--> 
It loads data of type `T` according to some extension-specified `TId` type. `EntityCache` is useful for loading data into property views and single-record views. One SDK edition of an example of its use is located at `<dir>Client/V1/MasterDetail/MasterDetailArea.ts`. This code is also included in the following example.

<!-- TODO:  Determine whether EntityCache can be the "type for the object that defines the query, as in the `WebsiteQuery` example". -->

```typescript

this.websiteEntities = new EntityCache<WebsiteModel, number>({
    entityTypeName: SamplesExtension.DataModels.WebsiteModelType,

    // uriFormatter() is a function that helps you fill in the parameters passed by the fetch()
    // call into the URI used to query the backend. In this case websites are identified by a number
    // which uriFormatter() will fill into the id spot of this URI. Again this particular endpoint
    // requires the sessionId parameter as well but yours probably doesn't.
    sourceUri: FxData.uriFormatter(Util.appendSessionId(MsPortalFx.Base.Resources.getAppRelativeUri("/api/Websites/{id}")), true),

    // this property is how the EntityCache looks up a website from the QueryCache. This way we share the same
    // data object across multiple views and make sure updates are reflected across all blades at the same time
    findCachedEntity: {
        queryCache: this.websitesQuery,
        entityMatchesId: (website, id) => {
            return website.id() === id;
        }
    }
});

```

When an EntityCache is instantiated, three elements are specified.

1. The **entityTypeName** that provides the name of the metadata type. The EntityCache needs to know the shape of the data contained in it, in order to reason over the data.

1. The **sourceUri** that provides the endpoint that will accept the HTTP request. This function returns the URI that the cache uses to get the data. It is sent a set of parameters that are sent to a `fetch` call. In this instance, the  `MsPortalFx.Data.uriFormatter()` helper method is used. It fills one or more parameters into the URI provided to it. In this instance there is only  one parameter, the `id` parameter, which is filled into the part of the URI containing `{id}`.

1. The **findCachedEntity** property.  Optional. Allows the lookup of an entity from the `QueryCache`, instead of retrieving the data a second time from the server, which creates a second copy of the data on the client. The **findCachedEntity** also serves as a method, whose two properties are: 1) the `QueryCache` to use and 2) a function that, given an item from the QueryCache, will specify whether this is the object that was requested by the parameters to the `fetch()` call.
    
<a name="the-datacache-class-editscopecache"></a>
### EditScopeCache

The `EditScopeCache` class is less commonly used. It loads and manages instances of `EditScope`, which is a change-tracked, editable model for use in Forms, as specified in [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md).  
