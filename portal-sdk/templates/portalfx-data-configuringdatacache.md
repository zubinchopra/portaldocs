
## Configuring the data cache

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

Multiple parts or services in an extension will rely on the same set of data. For queries, this may be a list of results, whereas for a details blade, it may be a single entity. In either case, it is critical to ensure that all parts that use a given set of data perform the following actions.

* Use a single HTTP request to access that data
* Read from a single cache of data in memory
* Release that data from memory when it is no longer required

These are all features that `MsPortalFx.Data.QueryCache` and `MsPortalFx.Data.EntityCache` provide. `QueryCache` is used to query for a collection of data. It takes a generic parameter for the type of object stored in its cache, and a type for the object that defines the query.  In the example below, the type for the object that defines the query is  `WebsiteQuery`. `EntityCache` is used to load an individual entity. 

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

The `QueryCache` parameters are as follows.

**DataModels.WebsiteModel**: The model type for the website. This is usually auto-generated (see TypeMetadata section below).

**WebsiteQuery**: The type that defines the parameters for the query. This often will include sort order, filter parameters, paging data, etc.

**entityTypeName**: Provides the name of the metadata type. This is usually auto-generated (see TypeMetadata section below).

**sourceUri**: Provides the endpoint which will accept the HTTP request.

**poll**: A boolean field which determines whether entries in this cache should be refreshed on a timer.  You can use it in conjunction with property pollInterval can be used to override the default poll interval and pollPreservesClientOrdering can be used to preserve the client's existing record order when polling as opposed to using the order from the server response.

**supplyData**: Allows the extension to override the logic used to perform an AJAX request. Allows for making the AJAX call, and post-processing the data before it is placed into the cache.
