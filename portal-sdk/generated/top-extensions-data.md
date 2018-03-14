
<a name="working-with-data"></a>
# Working with data

<!-- required Overview document.  -->
    
<a name="working-with-data-overview"></a>
## Overview

The Azure Portal UX provides unique data access challenges. Many blades and parts may be displayed at the same time, each of which instantiates a new `ViewModel` instance. Each `ViewModel` often needs access to the same or related data. To optimize for these interesting data-access patterns, extensions follow specific patterns that consist of data management and code organization.

The following sections discuss these concepts and how to apply them to an extension.

* **Data management**

    * Shared data access using [data contexts](#data-contexts)

    * Using [data caches](#data-caches) to load and cache data

    * Memory management with [data views](#data-views)

* **Code organization**

    * Organizing the extension source code into [areas](#areas)

All of these data concepts are used to achieve the goals of loading and updating extension data, in addition to efficient  memory  management. For more information about how the pieces fit together and how the resulting construct relates to the conventional MVVM pattern, see the [Data Architecture](https://auxdocs.blob.core.windows.net/media/DataArchitecture.pptx) video that discusses extension blades and parts.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

<a name="working-with-data-overview-data-contexts"></a>
### Data contexts

For each area in an extension, there is a singleton `DataContext` instance that supports access to shared data for the blades and parts implemented in that area. Access to shared data means data loading, caching, refreshing and updating. Whenever multiple blades and parts make use of common server data, the `DataContext` is an ideal place to locate data loading/updating logic for an extension [area](portalfx-extensions-glossary-data.md).

When a blade or part `ViewModel` is instantiated, its constructor is sent a reference to the `DataContext` singleton instance for the associated extension area.  In the blade or part `ViewModel` constructor, the `ViewModel` accesses the data required by that blade or part, as in the code located at `<dir>/Client/V1/MasterDetail/MasterDetailEdit/ViewModels/MasterViewModels.ts`.

```typescript

constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: MasterDetailArea.DataContext) {
    super();

    this.title(ClientResources.masterDetailEditMasterBladeTitle);
    this.subtitle(ClientResources.masterDetailEditMasterBladeSubtitle);

    this._view = dataContext.websitesQuery.createView(container);
    
```

The benefits of centralizing data access in a singleton `DataContext` include the following.
* [Caching and Sharing](#caching-and-sharing)

* [Consistency](#consistency)

* [Fresh data](#fresh-data)

<a name="working-with-data-overview-data-contexts-caching-and-sharing"></a>
##### Caching and Sharing

  The `DataContext` singleton instance will exist for the entire amount of time that the extension is loaded in the browser. Consequently, when a blade is opened, and therefore a new blade `ViewModel` is instantiated, data required by the new blade will often already be loaded and cached in the `DataContext`, as required by some previously opened blade or rendered part.
  
  Not only will this cached data be available immediately,  which optimizes rendering performance and improves perceived responsiveness, but also no new **AJAX** calls are necessary to load the data for the newly-opened blade, which reduces server load and Cost of Goods Sold (COGS).

<a name="working-with-data-overview-data-contexts-consistency"></a>
##### Consistency

  It is very common for multiple blades and parts to render the same data in levels of different detail, or with different presentation. Moreover, there are situations where such blades or parts are displayed on the screen at the same time, or separated in time only by a single user navigation. 

  In such cases, the user expects to see all the blades and parts depicting the exact same state of the user's data. An effective way to achieve this consistency is to load only a single copy of the data, which is what `DataContext` is designed to do.

<a name="working-with-data-overview-data-contexts-fresh-data"></a>
##### Fresh data

  Users expect to see data that always reflects the current state of their data in the cloud, which is neither stale nor out-of-date. Another benefit of loading and caching data in a single location is that the cached data can be regularly updated to accurately reflect the state of server data. 

  For more information on refreshing data, see [portalfx-data-refreshingdata.md](portalfx-data-refreshingdata.md).

<a name="working-with-data-overview-data-contexts-developing-a-datacontext-for-an-area"></a>
#### Developing a DataContext for an area

Typically, the `DataContext` associated with a particular area is instantiated from the `initialize()` method of `<dir>\Client\Program.ts`, which is the entry point of the extension.

```typescript

this.viewModelFactories.V1$MasterDetail().setDataContextFactory<typeof MasterDetailV1>(
    "./V1/MasterDetail/MasterDetailArea",
    (contextModule) => new contextModule.DataContext());

```

There is a single `DataContext` class per area. That class is named `[AreaName]Area.ts`, as in the code located at  `<dir>\Client\V1\MasterDetail\MasterDetailArea.ts`.

```typescript

/**
* Context for data samples.
*/
export class DataContext {
   /**
    * This QueryCache will hold all the website data we get from the website controller.
    */
   public websitesQuery: QueryCache<WebsiteModel, WebsiteQueryParams>;

   /**
    * Provides a cache that will enable retrieving a single website.
    */
   public websiteEntities: EntityCache<WebsiteModel, number>;

   /**
    * Provides a cache for persisting edits against a website.
    */
   public editScopeCache: EditScopeCache<WebsiteModel, number>;

```

The `DataContext` class does not specify the use of any single FX base class or interface. In practice, the members of a DataContext class typically include [data caches](#data-caches) and [data views](#data-views).

<a name="working-with-data-overview-data-caches"></a>
### Data caches
 
  The `DataCache` classes are a full-featured and convenient way to load and cache data required by blade and part `ViewModels`. `DataCache` classes are specified in [portalfx-data-caching.md](portalfx-data-caching.md). 

* **CRUD methods**

  The CRUD methods are Create, Replace, Update, and Delete. Commands for  blades and parts often use these methods to modify server data. These commands should be implemented in methods on the `DataContext` class, where each method can issue **AJAX** calls and reflect server changes in associated DataCaches.

* **QueryCache**

  Loads data of type `Array<T>` according to an extension-specified `TQuery` type. `QueryCache` is useful for loading data for list-like views like Grid, List, Tree, or Chart.

The `DataCache` classes all share the same API. The usage pattern is as follows.

1.  In a `DataContext`, the extension creates and configures `DataCache` instances, as specified in [portalfx-data-caching.md](portalfx-data-caching.md). Configuration includes the following.  

    * How to load data when it is missing from the cache
    * How to implicitly refresh cached data, to keep it consistent with server state

     ```typescript

this.websiteEntities = new MsPortalFx.Data.EntityCache<SamplesExtension.DataModels.WebsiteModel, number>({
    entityTypeName: SamplesExtension.DataModels.WebsiteModelType,
    sourceUri: MsPortalFx.Data.uriFormatter(Util.appendSessionId(DataShared.websiteByIdUri), true),
    findCachedEntity: {
        queryCache: this.websitesQuery,
        entityMatchesId: (website, id) => {
            return website.id() === id;
        }
    }
});

``` 

1. In its constructor, each blade and part `ViewModel` creates a `DataView` with which to load and refresh data for the blade or part.

    ```typescript

this._websiteEntityView = dataContext.websiteEntities.createView(container);

```

1. When the blade or part ViewModel receives its parameters in the `onInputsSet` method, the ViewModel calls the  `dataView.fetch()` method to load data.

```typescript

/**
 * Invoked when the blade's inputs change
 */   
public onInputsSet(inputs: Def.BrowseMasterListViewModel.InputsContract): MsPortalFx.Base.Promise {
    return this._websitesQueryView.fetch({ runningStatus: this.runningStatus.value() });
}

```
  
For more information about employing these concepts, see [portalfx-data-masterdetailsbrowse.md](portalfx-data-masterdetailsbrowse.md).

<a name="working-with-data-overview-data-views"></a>
### Data views

Memory management is very important in the Azure Portal, because overuse by many different extensions has been found to impact the user-perceived responsiveness of the Azure Portal.

Each `DataCache` instance manages a set of [cache entries](portalfx-extensions-glossary-data.md), and the `DataCache` includes automatic mechanisms to manage the number of cache entries present at a given time. This is important because `DataCaches` in the `DataContext` of an `area` will exist in memory for as long as an extension is loaded, and consequently may support blades and parts that come and go as the user navigates in the Azure Portal.  

When a `ViewModel` calls the `fetch()` method for its `DataView`, this `fetch()` call implicitly forms a ref-count to a `DataCache` cache entry, thereby pinning the entry in the DataCache as long as the blade/part `ViewModel` has not been  disposed by the extension. When all blade or part `ViewModels` that hold ref-counts to the same cache entry are disposed indirectly by using via DataView,  the DataCache can elect to evict or discard the cache entry. In this way, the `DataCache` can manage its size automatically, without explicit extension code.
 
<a name="working-with-data-overview-areas"></a>
### Areas

From a code organization standpoint, an area can be defined as a project-level folder. It becomes quite important when data operations are segmented within the extension.

`Areas` are a scheme for organizing and partitioning of extension source code, making it easier to develop an extension with a sizable team. They impact how `DataContexts` are used in an extension. In the same way that extensions employ areas in a way that collects related blades and parts, each area also maintains the data that is required by these blades and parts. Every extension area gets a distinct `DataContext` singleton, and the `DataContext` typically loads/caches/updates the data of a few model types necessary to support the area's blades and parts.  

An area is defined in the extension by using the following steps.

  1. Create a folder in the `Client\` directory of the project that contains the extension. The name of that folder is the name of the area.
  1. In the root of that folder, create a `DataContext` named `<AreaName>Area.ts`, where `<AreaName>` is the name of the folder that was just created, as specified in [#developing-a-datacontext-for-an-area](#developing-a-datacontext-for-an-area). For example, the `DataContext` for the `Security` area in the sample is located at `\Client\Security\SecurityArea.ts`.  

A typical extension resembles the following image.

![alt-text](../media/portalfx-data-context/area.png "Extensions can host multiple areas")



    ## The DataCache class

The Azure Portal FX DataCache class objects are `QueryCache`, `EntityCache` and the `EditScopeCache`.  The `DataCache` classes all share the same API. 

<!--TODO: Determine whether it is more accurate to say the following sentence.
The `DataCache` objects all share the same class within the API. 
  -->

They are a full-featured way of loading and caching data used by blade and part `ViewModels`.

 `QueryCache` queries for a collection of data, whereas  `EntityCache` loads an individual entity. QueryCache takes a generic parameter for the type of object stored in its cache, and a type for the object that defines the query, as in the `WebsiteQuery` example located at `<dir>Client\V1\Data\MasterDetailBrowse\MasterDetailBrowseData.ts`.
 
In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

<a name="working-with-data-overview-configuring-the-data-cache"></a>
### Configuring the data cache

Multiple parts or services in an extension will rely on the same set of data. For queries, this may be a list of results, whereas for a details blade, it may be a single entity. In either case, it is critical to ensure that all parts that use a given set of data perform the following actions.

* Use a single HTTP request to access that data
* Read from a single cache of data in memory
* Release that data from memory when it is no longer required

These are all features that `MsPortalFx.Data.QueryCache` and `MsPortalFx.Data.EntityCache` provide. 

<!--TODO: Remove the following placeholder sentence when it is explained in more detail. -->
Because this discussion includes AJAX, TypeScript, and template classes, it does not strictly specify an object-property-method model.

<a name="working-with-data-overview-querycache"></a>
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

<a name="working-with-data-overview-entitycache"></a>
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
    
<a name="working-with-data-overview-editscopecache"></a>
### EditScopeCache

The `EditScopeCache` class is less commonly used. It loads and manages instances of `EditScope`, which is a change-tracked, editable model for use in Forms, as specified in [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md).  


