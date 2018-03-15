
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


    
<a name="working-with-data-master-details-browse"></a>
## Master details browse

This scenario describes how to share data across the parent blade and the child blades. In this scenario, the extension retrieves information from the server and displays this data across multiple blades. There are other scenarios in which the one-to-many relationship, or the summary-detail relationship, uses grids to display information from `QueryCache`-`EntityCache` cache objects
in parent-child blades.

In the example code, the information to display in the parent blade is a list of websites. It displays this information in a grid. When the user activates a website, a child blade is opened, and displays detailed information about the activated website. The child blade  is also dependent on the parent blade for specific resources.

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK. The code for this example is located at:
`<dir>\Client\V1\MasterDetail\MasterDetailArea.ts`
`<dir>\Client\V1\MasterDetail\MasterDetailBrowse\MasterDetailBrowse.pdl`
`<dir>\Client\V1\Data\MasterDetailBrowse\MasterDetailBrowseData.ts`
`<dir>\Client\V1\asterDetail\MasterDetailBrowse\ViewModels\DetailViewModels.ts`
`<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`

The `QueryCache` and the `EntityCache` are the two caches that are used in this scenario. The `QueryCache` caches a list of items as specified in [portalfx-data-caching.md#querycache](portalfx-data-caching.md#querycache). The `EntityCache` caches a single item, as specified in [portalfx-data-caching.md#entitycache](portalfx-data-caching.md#entitycache).

The server data is cached using one of the two caches, and then uses that cache to display the websites across the two blades.  The data for both blades is located in the cache, therefore the server is not queried again when it is time to open the second blade. When the data in the cache is updated, that update is displayed across all blades at the same time. Consequently, the Portal always presents a consistent view of the data.

How the extension code uses the sample code is specified in [#the-masterdetail-area-and-datacontext](#the-masterdetail-area-and-datacontext). 
The two primary pieces of code are the following.
* [Implementing the master view](#implementing-the-master-view)
* [Implementing the detail view](#implementing-the-detail-view)


<a name="working-with-data-master-details-browse-the-masterdetail-area-and-datacontext"></a>
### The MasterDetail Area and DataContext

The Portal uses an `Area` to hold the cache and other data objects that are shared across multiple blades. The code for the area is located in its own folder, as specified in [portalfx-data-overview.md#areas](portalfx-data-overview.md#areas). In this example, the area folder is named `MasterDetail` and it is located in the `Client` folder of the extension. 

 Inside the folder, there is a TypeSscript file whose name is a combination of the name of the area and the word 'Area'. The file is named  `MasterDetailArea.ts` and is located at `<dir>Client/V1/MasterDetail/MasterDetailArea.ts`. This code is also included in the following example.

```typescript

this.websitesQuery = new QueryCache<WebsiteModel, WebsiteQueryParams>({
    entityTypeName: SamplesExtension.DataModels.WebsiteModelType,

    // when fetch() is called on the cache the params will be passed to this function and it 
    // should return the right URI for getting the data
    sourceUri: (params: WebsiteQueryParams): string => {
        let uri = MsPortalFx.Base.Resources.getAppRelativeUri("/api/Websites");

        // if runningStatus is null we should get all websites
        // if a value was provided we should get only websites with that running status
        if (params.runningStatus !== null) {
            uri += "?$filter=Running eq " + params.runningStatus;
        }

        // this particular controller expects a sessionId as well but this is not the common case.
        // Unless your controller also requires a sessionId this can be omitted
        return Util.appendSessionId(uri);
    }
});

```

This file contains the `DataContext` class, which is the class that will be sent to all the `ViewModels` associated with the area.  The `DataContext` also contains an `EditScopeCache` which is used in the master detail edit scenario that is located at [portalfx-forms-construction.md](portalfx-forms-construction.md). This code is also included in the following example.

 <!--TODO:  Locate the gitHub copies of the samples. -->

<!-- determine whether an "as specified in portalfx-forms-editscope*" is relevant here.  -->

If this is a new area for the extension, edit the  `Program.ts` file to create the `DataContext` when the extension is loaded. The SDK edition of the `Program.ts` file is located at `<dir>\Client\Program.ts`. For the extension that is being built, find the `initializeDataContexts` method and then use the `setDataContextFactory` method to set the `DataContext`.

<a name="working-with-data-master-details-browse-implementing-the-master-view"></a>
### Implementing the master view

The master view is used to display the data in the caches. The advantage of using views is that they allow the `QueryCache` to handle the caching, refreshing, and evicting of data.

1. Make sure that the PDL that defines the blades specifies the  `Area` so that the `ViewModels` receive the `DataContext`. In the `<Definition>` tag at the top of the PDL file, include an `Area` attribute whose value corresponds to the name of the area that is being built, as in the example located at `<dir>Client/V1/MasterDetail/MasterDetailBrowse/MasterDetailBrowse.pdl`. This code is also included in the following example.

   ```xml

<Definition xmlns="http://schemas.microsoft.com/aux/2013/pdl"
Area="V1/MasterDetail">

``` 

    The `ViewModel` for the list of websites is located in `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`. 

1. Create a view on the `QueryCache`, as in the following example.

     ```typescript

this._websitesQueryView = dataContext.websitesQuery.createView(container);

``` 

   The view is the `fetch()` method that is called to populate the `QueryCache`, and allows the items that are returned by the fetch call to be viewed. 

   **NOTE**:  There may be multiple views over the same `QueryCache`. This  occurs when multiple blades are displayed on the screen at the same time, all of which are using data from the same cache. 

   There are two controls on this blade, both of which use the view that was just created: a grid and the `OptionGroup` control.  

   * The grid displays the data in the `QueryCache`, as specified in [portalfx-data-dataviews.md](portalfx-data-dataviews.md) and in [#fetching-data-for-the-grid](#fetching-data-for-the-grid).

   * The `OptionGroup` control allows the user to select whether to display websites that are in a running state, websites in a stopped state or display both types of sites. The display created by the `OptionGroup` control is specified in [#the-optiongroup-control](#the-optiongroup-control).

<a name="working-with-data-master-details-browse-implementing-the-master-view-fetching-data-for-the-grid"></a>
#### Fetching data for the grid

The observable `items` array of the view is sent to the grid constructor as the `items` parameter, as in the following example.

```typescript

this.grid = new Grid.ViewModel<WebsiteModel, number>(this._lifetime, this._websitesQueryView.items, extensions, extensionsOptions);

```

The `fetch()` command has not yet been issued on the QueryCache. When the command is issued, the view's `items` array will be observably updated, which populates the grid with the results. This occurs by calling the  `fetch()` method on the blade's `onInputsSet()`, which returns the promise shown in the following example.

```typescript

/**
 * Invoked when the blade's inputs change
 */   
public onInputsSet(inputs: Def.BrowseMasterListViewModel.InputsContract): MsPortalFx.Base.Promise {
    return this._websitesQueryView.fetch({ runningStatus: this.runningStatus.value() });
}

```

This will populate the `QueryCache` with items from the server and display them in the grid.

<a name="working-with-data-master-details-browse-implementing-the-master-view-the-optiongroup-control"></a>
#### The OptionGroup control

The  control is initialized, and the extension then subscribes to its value property, as in the following example.

```typescript

this.runningStatus.value.subscribe(this._lifetime, (newValue) => {
    this.grid.loading(true);
    this._websitesQueryView.fetch({ runningStatus: newValue })
        .finally(() => {
            this.grid.loading(false);
        });
});

```

In the subscription, the extension performs the following actions.

1. Put the grid in a loading mode. It will remain in this mode until all of the data is retrieved.
1. Request the new data by calling the `fetch()` method on the data view with new parameters.
1. When the `fetch()` method completes, take the grid out of loading mode.

There is no need to get the results of the fetch and replace the items in the grid because the grid's `items` array has been pointed to the `items` array of the view. The view will update its `items` array as soon as the fetch is complete.

The rest of the code demonstrates that the grid has been configured to activate any of the websites when they are clicked. The `id` of the website that is activated is sent to the details child blade as an input.  For more information about the details child blade, see [#implementing-the-detail-view](#implementing-the-detail-view).

<a name="working-with-data-master-details-browse-implementing-the-detail-view"></a>
### Implementing the detail view

The detail view uses the `EntityCache` that was associated with the  `QueryCache` from the `DataContext` to display the details of a website. 

1. The child blade creates a view on the `EntityCache`, as in the following code.

```typescript

this._websiteEntityView = dataContext.websiteEntities.createView(container);

```

1.  In the `onInputsSet` method, the `fetch` method is called, with the ID of the website to display as a parameter, as in the following example. 

```typescript

/**
* Invoked when the blade's inputs change.
*/
public onInputsSet(inputs: Def.BrowseDetailViewModel.InputsContract): MsPortalFx.Base.Promise {
    return this._websiteEntityView.fetch(inputs.currentItemId);
}

```

1. When the fetch is completed, the data is available in the view's `item` property. This blade uses the `text` data-binding in its HTML template to show the name, id and running status of the website. 

    ## Lifetime Manager

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

The `lifetime manager` ensures that any resources that are specifically associated with a blade are disposed of when the blade is closed. Each blade has its own lifetime manager. Controls, **Knockout** projections and APIs that use a `lifetime manager` will be disposed when the `lifetime manager` is disposed. That means, for the most part, extensions in the Portal implicitly perform efficient memory management.

There are some scenarios that call for more fine-grained memory management. The most common case is the `map()` or `mapInto()` function, especially when it is used with a reactor or control in the callback that generates individual items. These items can be destroyed previous to the closing of the blade by being removed from the source array. When dealing with large amounts of data, especially virtualized data, memory leaks can quickly add up and result in poor extension performance. 

**NOTE**: The  `pureComputed()` method does not use a lifetime manager because it already uses memory as efficiently as possible.  This is by design, therefore it is good practice to use it. Generally, any `computed` the extension creates in a `map()` should be a `pureComputed()` method, instead of a `ko.reactor` method.

For more information on pureComputeds, see [portalfx-blade-viewmodel.md#data-pureComputed](portalfx-blade-viewmodel.md#data-pureComputed).

<a name="working-with-data-master-details-browse-child-lifetime-managers"></a>
### Child lifetime managers

Child lifetime managers exist for the amount of time that is, at most, the lifetime of their parent.  However, child lifetime managers can be disposed before their parent is disposed. When the developer is aware that extension child resources will have lifetimes that are shorter than that of the blade, a child lifetime manager can be created with the  `container.createChildLifetimeManager()` command, and sent to `ViewModel` constructors or anywhere else a lifetime manager object is needed. When the extension completes using those resources, the `dispose()` method can be explicitly called on the child lifetime manager. If the `dispose()` method is not called, the child lifetime manager will be disposed when its parent is disposed to prevent memory leaks.

In this example, a data cache contains data. Each item is displayed as a row in a grid. A button is displayed separately in a section located below the grid. The `mapInto()` function is used to map the data cache items to the grid items, and to create a button and add it to the section.

```ts
let gridItems = this._view.items.mapInto(container, (itemLifetime, item) => {
    let button = new Button.ViewModel(itemLifetime, { label: pureComputed(() => "Button for " + item.name())});
    this.section.children.push(button);
    return {
        name: item.name,
        status: ko.pureComputed(() => item.running() ? "Running" : "Stop")
    };
});
```

In this example, whereever the value of an observable is read in the mapping function, it is  wrapped in a `ko.pureComputed`. This is important and the reasons why are discussed in [portalfx-data-projections.md#data-shaping](portalfx-data-projections.md#data-shaping).

In addition, the `itemLifetime` child lifetime manager that was automatically created by the `mapInto()` function was sent to the mapping function as a parameter, instead of sending the  `container` into the button constructor.

In the case of `map()` and `mapInto()`, the item lifetime manager will be disposed when the associated object is removed from the source array. In the previous example, this means the button `ViewModel` will be disposed at the correct time, but the now disposed button `ViewModel` will still be in the Section. The button has not been removed from the section's `children()` array. 

Fortunately, callbacks can be registered with the lifetime manager to use when it is disposed by using the `registerForDispose` command, as in the following example.

```ts
let gridItems = this._view.items.mapInto(container, (itemLifetime, item) => {
    let button = new Button.ViewModel(itemLifetime, { label: pureComputed(() => "Button for " + item.name())});
    this.section.children.push(button);
    itemLifetime.registerForDispose(() => this.section.children.remove(button));
    return {
        name: item.name,
        status: ko.pureComputed(() => item.running() ? "Running" : "Stop")
    };
});
```

Consequently, the `mapInto` function is working as expected, by using the child lifetime manager and the `registerForDispose` command.

    
<a name="working-with-data-loading-data"></a>
## Loading Data

Loading data is more easily accomplished with the following methods from the `QueryCache` and `EntityCache` objects. The following table includes some performant uses for these methods, but they may be applicable in other ways.

| Method | Purpose | Sample |
| ------ | ------- | ------ |   
| `supplyData` | [Controlling AJAX calls](#controlling-ajax-calls) | `<dir>\Client\V1\Data\SupplyData\SupplyData.ts` |
| `invokeAPI`  | [Optimize CORS preflight requests](#optimize-cors-preflight-requests) | `<dir>\Client\V1\ResourceTypes\Engine\EngineData.ts` |
| `findCachedEntity` | [Reusing loaded or cached data](#reusing-loaded-or-cached-data) | `<dir>\Client\V1\ResourceTypes\Engine\EngineData.ts` |
| `cachedAjax()` | [Ignore redundant data](#ignore-redundant-data)  |  `<dir>\Client\V1\Data\SupplyData\SupplyData.ts` |
| `DataCache` object | [Making authenticated AJAX calls](#making-authenticated-ajax-calls) | `\Client\Data\Loader\LoaderSampleData.ts` |

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

* * *

<a name="working-with-data-loading-data-controlling-ajax-calls"></a>
### Controlling AJAX calls

In this case, the `QueryCache` is sent a `sourceUri` attribute which it uses to form a request. This request is sent by using  a `GET` method, with a default set of headers. In some cases, developers may wish to manually make the request.  This can be useful for some scenarios, including the following.

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

<a name="working-with-data-loading-data-optimize-cors-preflight-requests"></a>
### Optimize CORS preflight requests

The `invokeAPI` method is a great improvement to the preflight request process.

When [CORS](portalfx-extensions-glossary.data.md) is used to call ARM directly from the extension, the browser actually makes two network calls for every one **AJAX** call in the client code.

The `invokeApi` method uses a fixed endpoint and a different type of caching to reduce the number of calls to the server.  Consequently, the extension performance is optimized by using a single URI.

 The following examples describe the state of the code before and after using `invokeAPI`.

<a name="working-with-data-loading-data-optimize-cors-preflight-requests-before-using-invokeapi"></a>
#### Before using invokeApi

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

This code results in one CORS preflight request for each unique uri.  For example, if the user were to browse to two separate resources `aresource` and `otherresource`, it would result in the following requests.

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

This code makes one preflight request for each `MsPortalFx.Base.Net.ajax` request. In the extreme case, if network latency were the dominant factor, this code results in 50% overhead.

<a name="working-with-data-loading-data-optimize-cors-preflight-requests-after-applying-the-invokeapi-optimization"></a>
#### After applying the invokeApi optimization

To apply the `invokeApi` optimization, perform the following two steps.

1. Supply the invokeApi option directly to the `MsPortalFx.Base.Net.ajax({...})` option. This allows the extension to use the fixed endpoint `https://management.azure.com/api/invoke` to which to issue all the requests. The actual path and query string are actually sent as an `x-ms-path-query` header. At the `api/invoke` endpoint, ARM reconstructs the original URL on the server side and processes the request in its original form. 

    <!-- TODO: Determine whether cache:false creates the unique timestamp, or the absence of cache:false creates the unique timestamp  -->

1. Remove `cache:false`.  This avoids emitting a unique timestamp (i.e., &_=1447122511837) on every request, which invalidates the single-uri benefit that is provided by the `invokeApi`.

The sample located at `<dir>\Client\V1\ResourceTypes\Engine\EngineData.ts`  uses the  `invokeApi: "api/invoke"` line of code to supply the invokeApi option directly to the `MsPortalFx.Base.Net.ajax({...})` option. This is similar to the following code, which  also demonstrates the application of this optimization.

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

**NOTE**:

* The preflight request is cached for an hour.
* The request is always for a single resource named `https://management.azure.com/api/invoke`. All requests now go through this single endpoint, therefore a single preflight request is used for all subsequent requests.
* The `x-ms-path-query` preserves the request for the original path segments, the query string and the hash from the query cache.

Within the Portal implementation itself, this optimization has been applied to the Hubs extension.

<!-- TODO:  Determine whether the following sentence came from best practices and usabililty studies. -->

The Azure team observed about 15% gains for the scenarios tested, which were  resources and resource-groups data loads with normal network latency. The benefits should be greater as latencies increase.

<a name="working-with-data-loading-data-reusing-loaded-or-cached-data"></a>
### Reusing loaded or cached data

Browsing resources is a very common activity in the Portal.  Columns in the resource list should be loaded using a `QueryCache<TEntity, ...>`.  When the user activates a resource list item, the details that are displayed in the resource blade should be loaded using an `EntityCache<TEntity, ...>`, where `TEntity` is often shared between the two data caches.

To display details of a resource, use the `findCachedEntity` option to locate an entity that was previously loaded in some other `QueryCache`, or that was nested in some other `EntityCache`. This is preferred instead of issuing an **AJAX** call to load the resource details model into `EntityCache`. The preferred method is in the following code.

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

<a name="working-with-data-loading-data-ignore-redundant-data"></a>
### Ignore redundant data

If the call to `MsPortalFx.Base.Net.ajax()` is replaced with `MsPortalFx.Base.Net.cachedAjax()`, then a hash is generated on the server to provide change detection.  This not only saves network bandwidth, but it also saves client-side processing.

This capability is built into the SDK as a server-side filter that is activated when the header `x-ms-cache-tag` is present.  This value is a SHA256 hash of the return data plus the query information.  

**NOTE**: If the extension uses a server that does not utilize the SDK, then this filter may not be available by default and therefore the calculation may need to be implemented by the service provider.

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

<a name="working-with-data-loading-data-making-authenticated-ajax-calls"></a>
### Making authenticated AJAX calls

For most services, developers will make Ajax calls from the client to the server. Often the server acts as a proxy, and makes another call to a server-side API which requires authentication. 

**NOTE**: One server-side API is ARM.

When bootstrapping extensions, the portal will send a [JWT token](portalfx-extensions-glossary-data.md) to the extension. That same token can be included in the HTTP headers of a request to ARM, in order to provide end-to-end authentication. To help make those authenticated calls, the portal includes an API which performs Ajax requests, similar to the jQuery `$.ajax()` library named `MsPortalFx.Base.Net.ajax()`. If the extension uses a `DataCache` object,  this class is used by default. However, it can also be used independently, as in the example located at 
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


    ## Using DataViews

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

The `QueryView` and `EntityView` cache objects both present data from the cache to the `ViewModel`, and provide reference counting. A `DataView` is created from the `createView` method of the cache object that was used, as in the example located at `<dir>Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`. This example demonstrates a `SaveItemCommand` class that uses the binding between a part and a command. This code is also included in the following example.

```ts
this._websitesQueryView = dataContext.masterDetailBrowseSample.websitesQuery.createView(container);
```

In the previous code, the `container` object acts as a lifetime object. Lifetime objects inform the cache when a given view is currently being displayed on the screen. This allows the shell to make several adjustments for performance, including the following.

* Adjust polling interval when the part is not on the screen
* Automatically dispose of data when the blade containing the part is closed

Creating a `DataView` does not result in a data load operation from the server. The server is only queried when the `fetch` operation of the view is invoked, as in the code located at 
`<dir>Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts` and  in the following example.

```ts
public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
    return this._websitesQueryView.fetch({ runningStatus: inputs.filterRunningStatus.value });
}
```

The `runningStatus` is a filter which will be applied to the query. This allows several views to be created over a single cache, each of which presents a potentially different data set.

<a name="working-with-data-loading-data-observable-map-filter"></a>
### Observable map &amp; filter

In many cases, the developer may want to shape the extension data to fit the view to which it will be bound. Some cases where this is useful are as follows.   

* Shaping data to match the contract of a control, like data points of a chart
* Adding a computed property to a model object
* Filtering data on the client based on a property

The recommended approach to these cases is to use the `map` and `filter` methods from the library that is located at [https://github.com/stevesanderson/knockout-projections](https://github.com/stevesanderson/knockout-projections).

For more information about shaping and filtering your data, see [portalfx-data-projections.md](portalfx-data-projections.md).

<!--TODO:  Determine the meaning of the following comment. -->
<!--
    Base.Net.Ajax
-->


    ## Data shaping
In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

<a name="working-with-data-loading-data-shaping-and-filtering-data"></a>
### Shaping and filtering data

<a name="working-with-data-loading-data-understanding-observable-map-and-mapinto"></a>
### Understanding observable map() and mapInto()

When working with data in a QueryCache, the most common operation is to reshape all the items in the cache into a format that is better for displaying in the UI. For example, **Knockout** observable versions of the `map()` and `mapInto()` methods can be used to accomplish this.

 and some pitfalls to watch out for.

In the following generated data model will accept a QueryCache of `Robot` objects as a parameter. 

<!-- this is generated so I couldn't put comments in to do an include-section -->
```ts
interface Robot {
    name: KnockoutObservable<string>;
    status: KnockoutObservable<string>;
    model: KnockoutObservable<string>;
    manufacturer: KnockoutObservable<string>;
    os: KnockoutObservable<string>;
    specId: KnockoutObservable<string>;
}
```

Each robot will be entered into a grid with three columns. The `name` column and the `status` column are the same data as that of the model, but the third column is a combination of properties from the model object in the `QueryCache`.  The model and manufacturer observables are combined into a single property. The interface for the data to display in the grid is located at `<dir>\Client\V1\Data\Projection\ViewModels\MapAndMapIntoViewModels.ts`. This code is also included in the following example.

```typescript

/**
* Details for the shaped data that is bound to the grid.
*/
export interface RobotDetails {
   name: KnockoutObservableBase<string>;
   status: KnockoutObservableBase<string>;
   modelAndMfg: KnockoutObservableBase<string>;
}

```

An initial implementation of this might resemble the section named "data#buggyMapProjection". The logging portion of the code that includes  `projectionId` and `_logMapFunctionRunning()` are discussed in [](). 

```typescript

var projectedItems = this._view.items.map<RobotDetails>(this._currentProjectionLifetime, (itemLifetime, robot) => {
    var projectionId = this._uuid++;
    this._logMapFunctionRunning(projectionId, robot);
    return <RobotDetails>{
        name: ko.observable(robot.name()),
        status: ko.observable(robot.status()),
        modelAndMfg: ko.observable("{0}:{1}".format(robot.model(), robot.manufacturer()))
    };
});

```

Without knowing too much about map() this looks like a fairly reasonable implementation. We know `robot.name()` has the name of the robot and `robot.model()` and `robot.manufacturer()` will give us the model and manufacturer values. The `RobotDetails` interface that is used to model the data in the grid requires observables for the  `name` and `modelAndMfg` properties, therefore the strings that are received from the `QueryCache` model are put into a pair of observables.

The reason that this implementation is somewhat buggy is the following.
 In the sample located at `<dir>\Client/V1/Data/Projection/Templates/UnderstandingMapAndMapInto.html`
<!-- TODO: Locate working sample; this html -->
 When the blade opens up click on the __Buggy Map__ button to load the grid with a data projection code shown above. You should see something like the following show up in the __log stream__ control at the bottom of the blade:

```
Creating buggy map() projection
Creating a projection (projection id=4, robot=Bolt)
Creating a projection (projection id=5, robot=Botly)
Creating a projection (projection id=6, robot=Spring)
Creating a projection (projection id=7, robot=MetalHead)
```

Let's talk about what's happening here. We've created the projection shown above and passed it to the grid. Since there are four items in the QueryCache the projection will run four times, once on each object. Everytime we run the mapping function on an item in the grid this sample creates a new ID for the resulting `RobotDetails` object. You can see the robot names and the ID we generated for the details object in the output above.

Activate the first time in the grid so the child blade opens then what we're going to do is simulate the QueryCache getting an updated property value (generally by polling the server) for that activated item. You can do this by clicking on the 'update status' command at the top of the blade. When you click you'll see that the status for the 'Bolt' robot was updated but the child blade closed. Why did it do that? It's still the same item in the QueryCache, we've just updated one of it's properties. And you can see the top row of the grid is still an item with a name of 'Bolt'. The answer can be found in the __log__ at the bottom of the blade:

```
Updating robot status to 'processor' (robot='Bolt')
Creating a projection (projection id=8, robot=Bolt)
```

You'll notice after the status observable updates the map's projection function runs and computes __a different projected item__. The object with projectionId === 4 is gone and has been replaced with a new item with projectionId === 8. This is the reason the child blade closed. The item that was in selectableSet's activatedItems observable array no longer exists in the grid's list of items. It has been replaced by an item with the same `name` and `modelAndMfg` but a new `status`.

To understand why the map does this you need to understand a little how map() works. When the mapping function you supply runs knockout is watching to see what observable values are read and it then takes a dependency on those values (just like ko.pureComputed or ko.reactor). If any of those values change knockout knows the generated item is now out of date because the source for that item has changed. How does the map function generate an update-to-date projection? The only way it can, by running the mapping function again. This can be especially bad if you do something expensive in your mapping function.

The same thing happens if you update the model property of the top item (by clicking the 'update model' command):

```
Updating model to 'into' (robot=Bolt)
Creating a projection (projection id=10, robot=Bolt)
```

Reason is the same. During our mapping function we wrote:

```
modelAndMfg: ko.observable("{0}:{1}".format(robot.model(), robot.manufacturer()))
```

Which means the map projection will run again anytime robot.model() is observably updated. This causes the old item to be removed from the grid and an entirely new item to be added.

This obviously isn't what we want so how do we write projections that don't do this? In the case of a property we want to pass through straight from the data model to the grid model (like the `status` property in this example) you simply pass the observable. Don't get the current string value out of the observable and shove it into a different observable. So this line from our mapping function:

```
status: ko.observable(robot.status()),
```

becomes this:

```
status: robot.status,
```

We can't take the same approach with the `modelAndMfg` property however since we need to combine multiple properties from the data model to produce one property on the grid model. For cases like this you should use a ko.pureComputed() like so:

```
modelAndMfg: ko.pureComputed(() => {
    return "{0}:{1}".format(robot.model(), robot.manufacturer());
})
```

This prevents the map() from taking a dependency on robot.model() and robot.manufacturer() because __the pureComputed() function takes the dependency on robot.model() and robot.manufacturer()__. Since the pureComputed() we created will update whenever model() or manufacturer() updates ko.map knows it will not need to rerun your mapping function to keep the projection object up-to-date when those observables change in the source model.

A correct implemenation of the map above then looks like (again ignore uuid and the logging functions):

```typescript

var projectedItems = this._view.items.map<RobotDetails>(this._currentProjectionLifetime, (itemLifetime, robot) => {
    var projectionId = this._uuid++;
    this._logMapFunctionRunning(projectionId, robot);
    return <RobotDetails>{
        name: robot.name,
        status: robot.status,
        modelAndMfg: ko.pureComputed(() => {
            this._logComputedRecalculating(projectionId, robot);
            return "{0}:{1}".format(robot.model(), robot.manufacturer());
        })
    };
});

```

You can click on the 'Proper map' button in the sample and perform the same actions to see the difference. Now updating a property on the opened grid item no longer results in a rerunning of your map function. Instead changes to `status` are pushed directly to the DOM and changes to `model` cause the pureComputed to recalculate but importantly __do not change the object in grid.items()__.

Now that you understand how `map()` works we can introduce `mapInto()`. Here's the code the same projection implemented with mapInto():

```typescript

var projectedItems = this._view.items.mapInto<RobotDetails>(this._currentProjectionLifetime, (itemLifetime, robot) => {
    var projectionId = this._uuid++;
    this._logMapFunctionRunning(projectionId, robot);
    return <RobotDetails>{
        name: robot.name,
        status: robot.status,
        modelAndMfg: ko.pureComputed(() => {
            this._logComputedRecalculating(projectionId, robot);
            return "{0}:{1}".format(robot.model(), robot.manufacturer());
        })
    };
});

```

You can see how it reacts by clicking on the 'Proper mapInto' button and then add/remove/update the items. The code and behavior are the exact same. So how are map() and mapInto() different? We can see with a buggy implementation of a projection using mapInto():

```typescript

var projectedItems = this._view.items.mapInto<RobotDetails>(this._currentProjectionLifetime, (itemLifetime, robot) => {
    var projectionId = this._uuid++;
    this._logMapFunctionRunning(projectionId, robot);
    return <RobotDetails>{
        name: ko.observable(robot.name()),
        status: ko.observable(robot.status()),
        modelAndMfg: ko.observable("{0}:{1}".format(robot.model(), robot.manufacturer()))
    };
});

```

This is the same as our buggy implementation of map() we wrote earlier. Click the 'Buggy mapInto' button and then play around with updating status() and model() of the top row while that row is activated. You'll notice, unlike map(), that the child blade doesn't close however you'll also notice that when the source data in the QueryCache changes __the observable changes are not present in the projected object__. The reason for this is mapInto() ignores any observables that use in the mapping function you supply. It is therefore guaranteed that a projected item will stay the same item as long as the source item is around but if you write your map incorrectly it isn't guaranteed the projected data is update to date.

So to summarize:

Function | Projection always guaranteed up to date | Projected object identity will not change
--- | --- | ---
map() | Yes | No
mapInto() | No | Yes

However if the projection is done correctly both functions should work identically.

<a name="working-with-data-loading-data-using-knockout-projections"></a>
### Using Knockout projections

In many cases extension authors will want to shape and filter data as it is loaded via QueryView and EntityView.

[Knockout projections](https://github.com/stevesanderson/knockout-projections) provide a simple way to efficiently perform `map` and `filter` functions over an observable array of model objects.  This allows you to add new computed properties to model objects, exclude unneeded properties on model objects, and generally change the structure of an object that is inside an array.  If used correctly, the Knockout projections library does this efficiently by only executing the developer-supplied mapping/filtering function when new data is added to the array and when data is modified. The Knockout projections library is included by default in the SDK.  You can learn more by [reading this blog post](http://blog.stevensanderson.com/2013/12/03/knockout-projections-a-plugin-for-efficient-observable-array-transformations/).

The samples extension includes an example of using a __projected array__ to bind to a grid:

`\Client\Data\Projection\ViewModels\ProjectionBladeViewModel.ts`

```typescript

this._view = dataContext.robotData.robotsQuery.createView(container);

// As items are added or removed from the underlying items array,
// individual changed items will be re-evaluated to create the computed
// value in the resulting observable array.
var projectedItems = this._view.items.mapInto<RobotDetails>(container, (itemLifetime, robot) => {
    return <RobotDetails>{
        name: robot.name,
        computedName: ko.pureComputed(() => {
            return "{0}:{1}".format(robot.model(), robot.manufacturer());
        })
    };
});

this.grid = new Grid.ViewModel<RobotDetails, string>(
    container,
    projectedItems,
    Grid.Extensions.SelectableRow);

```

<a name="working-with-data-loading-data-chaining-uses-of-map-and-filter"></a>
### Chaining uses of <code>map</code> and <code>filter</code>

Often, it is convenient to chain uses of `map` and `filter`:
<!-- the below code no longer lives in samples extension anywhere -->
```ts
// Wire up the contents of the grid to the data view.
this._view = dataContext.personData.peopleQuery.createView(container);
var projectedItems = this._view.items
    .filter((person: SamplesExtension.DataModels.Person) => {
        return person.smartPhone() === "Lumia 520";
    })
    .map((person: SamplesExtension.DataModels.Person) => {
        return <MappedPerson>{
            name: person.name,
            ssnId: person.ssnId
        };
    });

var personItems = ko.observableArray<MappedPerson>([]);
container.registerForDispose(projectedItems.subscribe(personItems));
```

This filters to only Lumia 520 owners and then maps to just the columns the grid uses.  Additional pipeline stages can be added with more map/filters/computeds to do more complex projections and filtering.

<a name="working-with-data-loading-data-anti-patterns-and-best-practices"></a>
### Anti-patterns and best practices

**Do not** unwrap observables directly in your mapping function - When returning a new object from the function supplied to `map`, you should **avoid unwrapping observables** directly in the mapping function, illustrated by `computedName` here:

```ts
var projectedItems = this._view.items.map<RobotDetails>({
    mapping: (robot: SamplesExtension.DataModels.Robot) => {
        return <RobotDetails>{
            name: robot.name,
            
            // DO NOT DO THIS!  USE A COMPUTED INSTEAD!
            computedName: "{0}:{1}".format(robot.model(), robot.manufacturer());
        };
    },
    ...
```

The `computedName` property above is the source of a common bug where **"my grid loses selection when my QueryCache refreshes"**.  The reason for this is subtle.  If you unwrap observables in your mapping function, you will find that - each time the observable changes - your mapping function will be invoked again, (inefficiently) *generating an entirely new object*.  Since the Azure Portal FX's selection machinery presently relies on JavaScript object identity, selection tracked relative to the *old object* will be lost when this object is replaced by the *new object* generated by your mapping function.  Ignoring bugs around selection, generating new objects can lead to UI flicker and performance problems, as more UI is re-rendered than is necessary to reflect data changes. 

**Do** follow these two patterns to avoid re-running of mapping functions and to avoid unnecessarily generating new output objects:
 
* **Reuse observables from the input object** - Above, the `name` property above simply reuses - in the projected output object - an observable *from the input object*
* **Use `ko.computed()` for new, computed properties** - The `computedName` property above uses a Knockout `computed` and unwraps observables *in the function defining the `computed`*.  With this, only the `computedName` property is recomputed when the input `robot` object changes.

**Do** use `map` and `filter` to reduce the size of the data you are binding to a control - See [Use map and filter to reduce size of rendered data](/portal-sdk/generated/index-portalfx-extension-monitor.md#use-map-and-filter-to-reduce-size-of-rendered-data).

**Do not** use `subscribe` to project\shape data - An extreme anti-pattern would be to not use `map` at all when projecting/shaping data for use in controls:

```ts
// DO NOT DO THIS!
this._view.items.subscribe((items) => {
    var mappedItems: MappedPerson[] = [];
    for (var i = 0; i < items.length; i++) {
        // create a new mapped person for every item
        mappedItems.push({
            name: items[i].name,
            model: robot.model()
        });
    }

    this.selectableGridViewModel.items(mappedItems);
});
```

There are two significant problems with `subscribe` used here:

* Whenever `this._view.items` changes, an *entirely new array containing entirely new objects* will be generated.  Your scenario will suffer from the cost of serializing/deserializing this new array to the grid control and from the cost of fully re-rendering your grid.
* Whenever the `robot.model` observable changes, this change *will not be reflected in the grid*, since no code has subscribed to this `robot.model` observable.


    
<a name="working-with-data-refreshing-cached-data"></a>
## Refreshing cached data

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

<a name="working-with-data-refreshing-cached-data-the-implicit-refresh"></a>
### The implicit refresh

<a name="working-with-data-refreshing-cached-data-polling"></a>
### Polling

In many scenarios, users expect to see their rendered data update implicitly when server data changes. The auto-refreshing of client-side data, also known as  'polling', can be accomplished by configuring the cache object to include 'polling', as in the example located at `<dir>\Client\V1\Hubs\RobotData.ts`. This code is also included in the following example.

```typescript

public robotsQuery = new MsPortalFx.Data.QueryCache<SamplesExtension.DataModels.Robot, any>({
    entityTypeName: SamplesExtension.DataModels.RobotType,
    sourceUri: () => Util.appendSessionId(RobotData._apiRoot),
    poll: true
});

```

Additionally, the extension can customize the polling interval by using the `pollingInterval` option. By default, the polling interval is 60 seconds. It can be customized to a minimum of 10 seconds. The minimum is enforced to avoid the server load that can result from inaccurate changes.  However, there have been instances when this 10-second minimum has caused negative customer impact because of the increased server load.

<a name="working-with-data-data-merging"></a>
## Data merging

For the Azure Portal UI to be responsive, it is important to avoid re-rendering entire blades and parts when data changes. Instead, it is better to make granular data changes so that FX controls and **Knockout** HTML templates can re-render small portions of the Blade/Part UI. In many cases when data is refreshed, the newly-loaded server data precisely matches previously-cached data, and therefore there is no need to re-render the UI.

When cache object data is refreshed - either implicitly as specified in [#the-implicit-refresh](#the-implicit-refresh),  or explicitly as specified in  [#the-explicit-refresh](#the-explicit-refresh) - the newly-loaded server data is added to previously-cached, client-side data through a process called "data merging". The data merging process is as follows.

1. The newly-loaded server data is compared to previously-cached data
1. Differences between newly-loaded and previously-cached data are detected. For instance, "property <X> on object <Y> changed value" and "the Nth item in array <Z> was removed".
1. The differences are applied to the previously-cached data, via changes to Knockout observables.

<a name="working-with-data-data-merging-data-merging-caveats"></a>
### Data merging caveats

For many scenarios, data merging requires no configuration because it is an implementation detail of implicit and explicit refreshed. However, in some scenarios, there are gotcha's to look out for.

<a name="working-with-data-data-merging-data-merging-caveats-supply-type-metadata-for-arrays"></a>
#### Supply type metadata for arrays

When detecting changes between items in an previously-loaded array and a newly-loaded array, the "data merging" algorithm requires some per-array configuration. Specifically, the data merging algorithm that is not configured does not know how to match items between the old and new arrays. Without configuration, the algorithm considers each previously-cached array item as 'removed' because it matches no item in the newly-loaded array. Consequently, every newly-loaded array item is considered to be added because  it matches no item in the previously-cached array. This effectively replaces the entire contenst of the cached array, even in those cases where the server data is unchanged. This is often the cause of performance problems in the extension, like your Blade/Part (poor responsiveness, hanging).
, even while users - sadly - see no pixel-level UI problems.  
<!-- Determine whether "" is an acceptable translation for "(poor responsiveness, hanging)". -->
To proactively warn you of these potential performance problems, the "data merge" algorithm will log warnings to the console that resemble:

```
Base.Diagnostics.js:351 [Microsoft_Azure_FooBar]  18:55:54 
MsPortalFx/Data/Data.DataSet Data.DataSet: Data of type [No type specified] is being merged without identity because the type has no metadata. Please supply metadata for this type.
```

Any array cached in your cache object is configured for "data merging" by using [type metadata](portalfx-data-typemetadata.md). Specifically, for each `Array<T>`, the extension has to supply type metadata for type `T` that describes the "id" properties for that type (see examples of this [here](portalfx-data-typemetadata.md)). With this "id" metadata, the "data merging" algorithm can match previously-cached and newly-loaded array items and can merge these *in-place* (with no per-item array remove/add). With this, when the server data doesn't change, each cached array item will match a newly-loaded server item, each will merge in-place with no detected chagnes, and the merge will be a no-op for the purposes of UI rerendering.

<a name="working-with-data-data-merging-data-merging-caveats-data-merge-failures"></a>
#### Data merge failures

As "data merging" proceeds, differences are applied to the previously-cached data via Knockout observable changes. When these observables are changed, Knockout subscriptions are notified and Knockout `reactors` and `computeds` are reevaluated. Any associated (often extension-authored) callback here **can throw an exception** and this will halt/preempt the current "data merge" cycle. When this happens, the "data merging" algorithm issues an error resembling:

```
Data merge failed for data set 'FooBarDataSet'. The error message was: ...
```

Importantly, this error is not due to bugs in the data-merging algorithm. Rather, some JavaScript code (frequently extension code) is causing an exception to be thrown. This error should be accompanied with a JavaScript stack trace that extension developers can use to isolate and fix such bugs.  

<a name="working-with-data-data-merging-data-merging-caveats-entityview-item-observable-doesn-t-change-on-refresh"></a>
#### EntityView <code>item</code> observable doesn&#39;t change on refresh?

Situation:  The EntityView `item` observable does not change, and therefore does not notify subscribers, when the cache object is refreshed. The refreshing is performed either [implicitly](#the-implicit-refresh) or [explicitly](#the-explicit-refresh).  When the observable does not change, code like the following does not work as expected.

```ts
entityView.item.subscribe(lifetime, () => {
    const item = entityView.item();
    if (item) {
        // Do something with 'newItem' after refresh.
        doSomething(item.customerName());
    }
});
```
Explanation:  The The EntityView `item` observable does not change because the "data merge" algorithm does not replace objects that are previously cached, unless such objects are  array items. Instead, objects are merged in-place, which optimizes for limited/no UI re-rendering when data changes, as specified in  [#data-merging](#data-merging).  

Solution: A better coding pattern is to use `ko.reactor` and `ko.computed` as follows.  

```ts
ko.reactor(lifetime, () => {
    const item = entityView.item();
    if (item) {
        // Do something with 'newItem' after refresh.
        doSomething(item.customerName());
    }
});
```

In this example, the supplied callback will be called both when the `item` observable changes, (when the data first loads) and when any properties on the entity change (like `customerName` above).

<a name="working-with-data-data-merging-the-explicit-refresh"></a>
### The explicit refresh

<a name="working-with-data-explicitly-proactively-reflecting-server-data-changes-on-the-client"></a>
## Explicitly/proactively reflecting server data changes on the client

As server data changes, there are scenarios where the extension should take explicit steps to keep their cache object data consistent with the server. In terms of UX, explicit refreshing of a cache object is necessary in scenarios like the following. 

* **User makes server changes** - User initiates some action and, as a consequence, the extension issues an AJAX call that changes server data. As a best-practice, this AJAX call is typically issued from an extension DataContext.

```typescript

public updateRobot(robot: SamplesExtension.DataModels.Robot): FxBase.PromiseV<any> {
    return FxBaseNet.ajax({
        uri: Util.appendSessionId(RobotData._apiRoot + robot.name()),
        type: "PUT",
        contentType: "application/json",
        data: ko.toJSON(robot)
    }).then(() => {
        // This will refresh the set of data that is available in the underlying data cache.
        this.robotsQuery.refreshAll();
    });
}

```

In this scenario, because the AJAX call will be issued from a DataContext, refreshing data in caches is performed  using methods from the dataCache classes directly. See ["Refreshing/updating a QueryCache/EntityCache"](#refresh-datacache) below.
  
<a name="refresh-dataview-sample"></a>
* **User clicks `Refresh` command** - (Less common) The user clicks on some 'Refresh'-like command on a blade or part, implemented in that blade or part's `ViewModel`.

```ts
class RefreshCommand implements MsPortalFx.ViewModels.Commands.Command<void> {
    private _websiteView: MsPortalFx.Data.EntityView<Website>;

    public canExecute: KnockoutObservableBase<boolean>;

    constructor(websiteView: MsPortalFx.Data.EntityView<Website>) {
        this.canExecute = ko.computed(() => {
            return !websiteView.loading();
        });

        this._websiteView = websiteView;
    }

    public execute(): MsPortalFx.Base.Promise {
        return this._websiteView.refresh();
    }
```
  
In this scenario, since the data being refreshed is that data rendered in a specific Blade/Part, refreshing data in the associated cache is best done by using   `DataCache` class methods for the QueryView/EntityView that is being used by the Blade/Part ViewModel. See ["Refreshing a QueryView/EntityView"](#refresh-dataview) below.

<a name="refresh-datacache"></a>
<a name="working-with-data-explicitly-proactively-reflecting-server-data-changes-on-the-client-refreshing-or-updating-a-data-cache"></a>
### Refreshing or updating a data cache

There are a number of methods available on cache objects in the `DataCache` class  that make it straightforward and efficient to keep client-side cached data consistent with server data. Which of these is appropriate varies by scenario, and these are discussed individually below.  
To understand the design behind this collection of methods and how to select the appropriate method to use, it's important to understand a bit about the DataCache/DataView design (in detail [here](portalfx-data-configuringdatacache.md)). Specifically, the cache objects are  a collection of cache entries. In some cases, where there are multiple active Blades and Parts, a specific cache object might contain many cache entries. So, below, you'll see `refreshAll` - which issues N AJAX calls to refresh all N entries of a cache object - as well as alternative, per-cache-entry methods that allow for more granular, often more efficient refreshing of cache object data.

<a name="working-with-data-explicitly-proactively-reflecting-server-data-changes-on-the-client-refreshing-or-updating-a-data-cache-refreshall"></a>
#### <code>refreshAll</code>
  
As mentioned above, this method will issue an AJAX call (either using the `supplyData` or `sourceUri`'option supplied to the cache object) for each entry currently held in the cache object.  Upon completion, each AJAX result is [merged](#data-merging) onto its corresponding cache entry, as in the following example.

```typescript

public updateRobot(robot: SamplesExtension.DataModels.Robot): FxBase.PromiseV<any> {
    return FxBaseNet.ajax({
        uri: Util.appendSessionId(RobotData._apiRoot + robot.name()),
        type: "PUT",
        contentType: "application/json",
        data: ko.toJSON(robot)
    }).then(() => {
        // This will refresh the set of data that is available in the underlying data cache.
        this.robotsQuery.refreshAll();
    });
}

```

If the (optional) `predicate` parameter is supplied to the `refreshAll` call, then only those entries for which the predicate returns 'true' will be refreshed.  This `predicate` feature is useful when the extension understands the nature of the server data changes and can - based on this knowledge - choose to not refresh cache object entries whose server data has not changed.


<a name="working-with-data-explicitly-proactively-reflecting-server-data-changes-on-the-client-refreshing-or-updating-a-data-cache-refresh-method"></a>
#### <code>refresh</code> method
  
The `refresh` method is useful when the server data changes are known to be specific to a single cache entry.  This is a single query in the case of `QueryCache`, and it is a single entity `id` in the case of `EntityCache`.

```typescript

const promises: FxBase.Promise[] = [];
this.sparkPlugsQuery.refresh({}, null);
MsPortalFx.makeArray(sparkPlugs).forEach((sparkPlug) => {
    promises.push(this.sparkPlugEntities.refresh(sparkPlug, null));
});
return Q.all(promises);

```

```typescript

public updateSparkPlug(sparkPlug: DataModels.SparkPlug): FxBase.Promise {
    let promise: FxBase.Promise;
    const uri = appendSessionId(SparkPlugData._apiRoot);
    if (useFrameworkPortal) {
        // Using framework portal (NOTE: this is not allowed against ARM).
        // NOTE: do NOT use invoke API since it doesn't handle CORS.
        promise = FxBaseNet.ajaxExtended<any>({
            headers: { accept: applicationJson },
            isBackgroundTask: false,
            setAuthorizationHeader: true,
            setTelemetryHeader: "Update" + entityType,
            type: "PATCH",
            uri: uri + "&api-version=" + entityVersion,
            data: ko.toJSON(convertToResource(sparkPlug)),
            contentType: applicationJson,
            useFxArmEndpoint: true,
        });
    } else {
        // Using local controller.
        promise = FxBaseNet.ajax({
            uri: uri,
            type: "PATCH",
            contentType: "application/json",
            data: ko.toJSON(sparkPlug),
        });
    }

    return promise.then(() => {
        // This will refresh the set of data that is available in the underlying data cache.
        SparkPlugData._debouncer.execute([this._getSparkPlugId(sparkPlug)]);
    });
}

```
  
Using `refresh`, only a single AJAX call will be issued to the server.

<a name="working-with-data-explicitly-proactively-reflecting-server-data-changes-on-the-client-refreshing-or-updating-a-data-cache-applychanges"></a>
#### &#39;<code>applyChanges</code>&#39;

In some scenarios, AJAX calls to the server to refresh cached data can be *avoided entirely*. For instance, the user may have fully described the server data changes by filling out a Form on a Form Blade. In this case, the necessary cache object changes are known by the extension directly without having to make an AJAX call to their server. This use of `applyChanges` can be a nice optimization to avoid some AJAX traffic to your servers.

**Example - Adding an item to a QueryCache entry**

```typescript

public createRobot(robot: SamplesExtension.DataModels.Robot): FxBase.PromiseV<any> {
    return FxBaseNet.ajax({
        uri: Util.appendSessionId(RobotData._apiRoot),
        type: "POST",
        contentType: "application/json",
        data: ko.toJSON(robot)
    }).then(() => {
        // This will refresh the set of data that is displayed to the client by applying the change we made to 
        // each data set in the cache. 
        // For this particular example, there is only one data set in the cache. 
        // This function is executed on each data set selected by the query params.
        // params: any The query params
        // dataSet: MsPortalFx.Data.DataSet The dataset to modify
        this.robotsQuery.applyChanges((params, dataSet) => {
            // Duplicates on the client the same modification to the datacache which has occured on the server.
            // In this case, we created a robot in the ca, so we will reflect this change on the client side.
            dataSet.addItems(0, [robot]);
        });
    });
}

```

**Example - Removing an item to a QueryCache entry**

```typescript

public deleteRobot(robot: SamplesExtension.DataModels.Robot): FxBase.PromiseV<any> {
    return FxBaseNet.ajax({
        uri: Util.appendSessionId(RobotData._apiRoot + robot.name()),
        type: "DELETE"
    }).then(() => {
        // This will notify the shell that the robot is being removed.
        MsPortalFx.UI.AssetManager.notifyAssetDeleted(ExtensionDefinition.AssetTypes.Robot.name, robot.name());

        // This will refresh the set of data that is displayed to the client by applying the change we made to 
        // each data set in the cache. 
        // For this particular example, there is only one data set in the cache.
        // This function is executed on each data set selected by the query params.
        // params: any The query params
        // dataSet: MsPortalFx.Data.DataSet The dataset to modify
        this.robotsQuery.applyChanges((params, dataSet) => {
            // Duplicates on the client the same modification to the datacache which has occured on the server.
            // In this case, we deleted a robot in the cache, so we will reflect this change on the client side.
            dataSet.removeItem(robot);
        });
    });
}

```

Similar to '`refreshAll`', the '`applyChanges`' method accepts a function that is called for each cache entry currently in the cache object, whgch allows the extension to update only those cache entries known to be impacted by the server changes made by the user.
  
<a name="working-with-data-explicitly-proactively-reflecting-server-data-changes-on-the-client-refreshing-or-updating-a-data-cache-forceremove"></a>
#### <code>forceRemove</code>
  
A subtlety of the cache objects in the DataCache class is that they can contain cache entries for some time after the last blade or part has been closed or unpinned. This supports the scenario where a user closes a Blade (for instance) and immediately reopens it.  

Now, when the server data for a given cache entry has been entirely deleted, then the extension will forcibly remove corresponding entries from their QueryCache (less common) and EntityCache (more common). The '`forceRemove`' method does just this, as in the following example. 

```typescript

public deleteComputer(computer: SamplesExtension.DataModels.Computer): FxBase.PromiseV<any> {
    return FxBaseNet.ajax({
        uri: Util.appendSessionId(ComputerData._apiRoot + computer.name()),
        type: "DELETE"
    }).then(() => {
        // This will notify the shell that the computer is being removed.
        MsPortalFx.UI.AssetManager.notifyAssetDeleted(ExtensionDefinition.AssetTypes.Computer.name, computer.name());

        // This will refresh the set of data that is displayed to the client by applying the change we made to 
        // each data set in the cache. 
        // For this particular example, there is only one data set in the cache.
        // This function is executed on each data set selected by the query params.
        // params: any The query params
        // dataSet: MsPortalFx.Data.DataSet The dataset to modify
        this.computersQuery.applyChanges((params, dataSet) => {
            // Duplicates on the client the same modification to the datacache which has occured on the server.
            // In this case, we deleted a computer in the cache, so we will reflect this change on the client side.
            dataSet.removeItem(computer);
        });

        // This will force the removal of the deleted computer from this EntityCache.  Subsequently, any Part or
        // Blades that use an EntityView to fetch this deleted computer will likely receive an expected 404
        // response.
        this.computerEntities.forceRemove(computer.name());
    });
}

```
  
Once called, the corresponding cache entry will be removed. If the user were to - somehow - open a Blade or drag/drop a Part that tried to load the deleted data, the cache objects would try to create an entirely new cache entry, and - presumably - it would fail to load the corresponding server data. In such a case, by design, the user would see a 'data not found' user experience in that Blade/Part.

When using '`forceRemove`', the extension will also - typically - want to take steps to ensure that any existing Blades/Parts are no longer making use of the removed cache entry (via QueryView/EntityView). When the extension notifies the FX of a deleted ARM resource via '`MsPortalFx.UI.AssetManager.notifyAssetDeleted()`' (see [here](portalfx-assets.md) for details), the FX will automatically show 'deleted' UX in any corresponding Blades/Parts. If the user clicked some 'Delete'-style command on a Blade to trigger the '`forceRemove`', often the extension will elect to *programmatically close the Blade* with the 'Delete' command (in addition to making associated AJAX and '`forceRemove`' calls from their DataContext).
  
<a name="refresh-dataview"></a>
<a name="working-with-data-explicitly-proactively-reflecting-server-data-changes-on-the-client-refreshing-a-queryview-entityview"></a>
### Refreshing a <strong>QueryView/EntityView</strong>

In some Blades/Parts, there can be a specific 'Refresh' command that is meant to refresh only that data visible in the given Blade/Part. In this scenario, it is the QueryView/EntityView that serves as a reference/pointer to that Blade/Part's data, and it's with that QueryView/EntityView that the extension should refresh the data.  (See a sample [here](#refresh-dataview-sample)).  

When `refresh` is called, a Promise is returned that reflects the progress/completion of the corresponding AJAX call. In addition, the '`isLoading`' observable property of QueryView/EntityView also changes to 'true' (useful for controlling UI indications that the refresh is in progress, like temporarily disabling the clicked 'Refresh' command).  

At the cache object level, in response to the QueryView/EntityView '`refresh`' call, an AJAX call will be issued for the corresponding cache entry, precisely in the same manner that would happen if the extension called the cache object's `refresh` method with the associated cache key (see [here](#refresh-datacache-refresh)).  

<a name="working-with-data-explicitly-proactively-reflecting-server-data-changes-on-the-client-refreshing-a-queryview-entityview-queryview-entityview-refresh-caveat"></a>
#### QueryView/EntityView &#39;<code>refresh</code>&#39; <strong>caveat</strong>

There is one subtety to the '`refresh`' method available on QueryView/EntityView that sometimes trips up extension developers. You will notice that '`refresh`' accepts no parameters. This is because '`refresh`' was designed to refresh *previously-loaded data*. An initial call to QueryView/EntityView's '`fetch`' method establishes a cache entry in the corresponding cache object that includes the URL information with which to issue an AJAX call when '`refresh`' is later called.  

Sometimes, extensions developers feel it is important - when a Blade opens or a Part is first displayed - to implicitly refresh the Blade's/Part's data (in cases where the data may have previously been loaded/cached for use in some previously viewed Blade/Part). To make this so, they'll sometimes call QueryView/EntityView's '`fetch`' and '`refresh`' methods in succession. This is a minor anti-pattern that should probably be avoided. This "refresh my data on Blade open" pattern trains the user to open Blades to fix stale data (even close and then immediately reopen the same Blade) and can often be a symptom of a missing 'Refresh' command or [auto-refreshing data](#the-implicit-refresh) that's configured with too long a polling interval.  


    
<a name="working-with-data-virtualized-data-for-the-grid"></a>
## Virtualized data for the grid
<a name="working-with-data-querying-for-virtualized-data"></a>
## Querying for virtualized data
In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.


If your back end is going to return significant amounts of data, you should consider using the `DataNavigator` class provided by the framework. There are two models for querying virtualized data from the server:

1. __"Load more" model__: With this model, a page of data is loaded, the user scrolls to the bottom, and then the next page of data is loaded.  There is no way to scroll to "page 5", and all data is represented in a timeline.  This works best with APIs that provide continuation tokens, or timeline based data.

2. __Paged model__: The classic paged model provides either a pager control, or a virtualized scrollbar which represents the paged data.  It works best with back end APIs that have a skip/take style data virtualization strategy.

Both of these use the existing `QueryCache` and the `MsPortalFx.Data.RemoteDataNavigator` entities to orchestrate virtualization.


<a name="working-with-data-querying-for-virtualized-data-load-more-continuation-token"></a>
#### Load more / continuation token

![Load more grid][loadmore-grid]

The 'load more' approach requires setting up a `QueryCache` with a navigation element.  The navigation element describes the continuation token model:

`\SamplesExtension\Extension\Client\Controls\ProductData.ts`

```ts
this.productsCache = new MsPortalFx.Data.QueryCache<SamplesExtension.DataModels.Product, ProductQueryParams>({
    entityTypeName: SamplesExtension.DataModels.ProductType,
    sourceUri: MsPortalFx.Data.uriFormatter(ProductData.QueryString),
    navigation: {
        loadByContinuationToken: (
            suppliedQueryView: MsPortalFx.Data.QueryView<SamplesExtension.DataModels.Product, ProductQueryParams>,
            query: ProductQueryParams,
            reset: boolean,
            filter: string): MsPortalFx.Base.Promise => {

            var token = reset ? "" :
                (suppliedQueryView.metadata() ?
                suppliedQueryView.metadata().continuationToken :
                "");

            return suppliedQueryView.fetch({ token: token, categoryId: query.categoryId });
        }
    },
    processServerResponse: (response: any) => {
        return <MsPortalFx.Data.DataCacheProcessedResponse>{
            data: response.products,
            navigationMetadata: {
                totalItemCount: response.totalCount,
                continuationToken: response.continuationToken
            }
        };
    }
});
```

In the view model, use the `Pageable` extension for the grid, with the `Sequential` type. Instead of the `createView` API on the QueryCache, use the `createNavigator` API which integrates with the virtualized data system:


`\SamplesExtension\Extension\Client\Controls\Grid\ViewModels\PageableGridViewModel.ts`

```ts
constructor(container: MsPortalFx.ViewModels.PartContainerContract,
            initialState: any,
            dataContext: ControlsArea.DataContext) {

    // create the data navigator from the data context (above)
    this._sequentialDataNavigator = dataContext.productDataByContinuationToken.productsCache.createNavigator(container);

    // Define the extensions you wish to enable.
    var extensions = MsPortalFx.ViewModels.Controls.Lists.Grid.Extensions.Pageable;

    // Define the options required to have the extensions behave properly.
    var pageableExtensionOptions = {
        pageable: {
            type: MsPortalFx.ViewModels.Controls.Lists.Grid.PageableType.Sequential,
            dataNavigator: this._sequentialDataNavigator
        }
    };

    // Initialize the grid view model.
    this.sequentialPageableGridViewModel = new MsPortalFx.ViewModels.Controls.Lists.Grid
        .ViewModel<SamplesExtension.DataModels.Product, ProductSelectionItem>(
            null, extensions, pageableExtensionOptions);

    // Set up which columns to show.  If you do not specify a formatter, we just call toString on
    // the item.
    var basicColumns: MsPortalFx.ViewModels.Controls.Lists.Grid.Column[] = [
        {
            itemKey: "id",
            name: ko.observable(ClientResources.gridProductIdHeader)
        },
        {
            itemKey: "description",
            name: ko.observable(ClientResources.gridProductDescriptionHeader)
        },
    ];
    this.sequentialPageableGridViewModel.showHeader = true;

    this.sequentialPageableGridViewModel.columns =
        ko.observableArray<MsPortalFx.ViewModels.Controls.Lists.Grid.Column>(basicColumns);

    this.sequentialPageableGridViewModel.summary =
        ko.observable(ClientResources.basicGridSummary);

    this.sequentialPageableGridViewModel.noRowsMessage =
        ko.observable(ClientResources.nobodyInDatabase);
}


public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
    return this._sequentialDataNavigator.setQuery({ categoryId: inputs.categoryId });
}
```

<a name="working-with-data-querying-for-virtualized-data-pageable-skip-take-grid"></a>
#### Pageable / skip-take grid

![Pageable grid][pageable-grid]

The pageable approach requires setting up a `QueryCache` with a navigation element.  The navigation element describes the skip-take behavior:

`\SamplesExtension\Extension\Client\Controls\ProductPageableData.ts`

```ts
var QueryString = MsPortalFx.Base.Resources
    .getAppRelativeUri("/api/Product/GetPageResult?skip={skip}&take={take}");

var productsCache = new MsPortalFx.Data.QueryCache<SamplesExtension.DataModels.Product, ProductPageableQueryParams>({

    entityTypeName: SamplesExtension.DataModels.ProductType,
    sourceUri: MsPortalFx.Data.uriFormatter(ProductPageableData.QueryString),
    navigation: {
        loadBySkipTake: (
            suppliedQueryView: MsPortalFx.Data.QueryView<SamplesExtension.DataModels.Product, ProductPageableQueryParams>,
            query: ProductPageableQueryParams,
            skip: number,
            take: number,
            filter: string): MsPortalFx.Base.Promise => {

                return suppliedQueryView.fetch({ skip: skip.toString(), take: take.toString(), categoryId: query.categoryId });
        }
    },
    processServerResponse: (response: any) => {
        return <MsPortalFx.Data.DataCacheProcessedResponse>{
            data: response.products,
            navigationMetadata: {
                totalItemCount: response.totalCount,
                continuationToken: response.continuationToken
            }
        };
    }
});
```

In the view model, use the `Pageable` extension for the grid, with the `Pageable` type. Instead of the `createView` API on the QueryCache, use the `createNavigator` API which integrates with the virtualized data system:


`\SamplesExtension\Extension\Client\Controls\Grid\ViewModels\PageableGridViewModel.ts`

```ts
constructor(container: MsPortalFx.ViewModels.PartContainerContract,
            initialState: any,
            dataContext: ControlsArea.DataContext) {

    this._pageableDataNavigator = dataContext.productDataBySkipTake.productsCache.createNavigator(container);

    // Define the extensions you wish to enable.
    var extensions = MsPortalFx.ViewModels.Controls.Lists.Grid.Extensions.Pageable;

    // Define the options required to have the extensions behave properly.
    var pageableExtensionOptions = {
        pageable: {
            type: MsPortalFx.ViewModels.Controls.Lists.Grid.PageableType.Pageable,
            dataNavigator: this._pageableDataNavigator,
            itemsPerPage: ko.observable(20)
        }
    };

    // Initialize the grid view model.
    this.pagingPageableGridViewModel = new MsPortalFx.ViewModels.Controls.Lists.Grid
        .ViewModel<SamplesExtension.DataModels.Product, ProductSelectionItem>(
            null, extensions, pageableExtensionOptions);

    // Set up which columns to show.  If you do not specify a formatter, we just call toString on
    // the item.
    var basicColumns: MsPortalFx.ViewModels.Controls.Lists.Grid.Column[] = [
        {
            itemKey: "id",
            name: ko.observable(ClientResources.gridProductIdHeader)
        },
        {
            itemKey: "description",
            name: ko.observable(ClientResources.gridProductDescriptionHeader)
        },
    ];

    this.pagingPageableGridViewModel.showHeader = true;

    this.pagingPageableGridViewModel.columns =
        ko.observableArray<MsPortalFx.ViewModels.Controls.Lists.Grid.Column>(basicColumns);

    this.pagingPageableGridViewModel.summary =
        ko.observable(ClientResources.basicGridSummary);

    this.pagingPageableGridViewModel.noRowsMessage =
        ko.observable(ClientResources.nobodyInDatabase);
}

public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
    return this._pageableDataNavigator.setQuery({ categoryId: inputs.categoryId });
}
```

[loadmore-grid]: ../media/portalfx-data/loadmore-grid.png
[pageable-grid]: ../media/portalfx-data/pageable-grid.png


    
<a name="working-with-data-type-metadata"></a>
## Type metadata
In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.


When performing merge operations, the DataSet library will need to know a little bit about the schema of your model objects. For example, in the case of a Website, we want to know the property which defines the primary key of that object. This information which describes the object, and all of its properties is referred to in the portal as *type metadata*. Type metadata can be manually coded using existing libraries. However, for developers using C#, we provide two features that make this easier:

- Generation of type metadata from C# to TypeScript at build time
- Generation of TypeScript model interfaces from C# model objects

Both of these features allow you to write your model objects once in C#, and then let the compiler generate interfaces and data for use at runtime.

To use type metadata generation, you need to keep your model objects (aka Data Transfer Objects / DTOs) in a separate .NET project from your extension. For an example, check out the `SamplesExtension.DataModels` project included in the SDK. The class library project used to generate models requires the following dependencies:

- System.ComponentModel.DataAnnotations
- System.ComponentModel.Composition
- Microsoft.Portal.TypeMetadata

`Microsoft.Portal.TypeMetadata` can be found at the following location:
`%programfiles(x86)%\Microsoft SDKs\PortalSDK\Libraries\Microsoft.Portal.TypeMetadata.dll`

At the top of any C# file using the `TypeMetadataModel` annotation, the following namespaces must be imported:

- `System.ComponentModel.DataAnnotations`
- `Microsoft.Portal.TypeMetadata`

For an example of a model class which generates TypeScript, open the following sample:

```cs
// \SamplesExtension.DataModels\Robot.cs

using System.ComponentModel.DataAnnotations;
using Microsoft.Portal.TypeMetadata;

namespace Microsoft.Portal.Extensions.SamplesExtension.DataModels
{
    /// <summary>
    /// Representation of a robot used by the browse sample.
    /// </summary>
    [TypeMetadataModel(typeof(Robot), "SamplesExtension.DataModels")]
    public class Robot
    {
        /// <summary>
        /// Gets or sets the name of the robot.
        /// </summary>
        [Key]
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets the status of the robot.
        /// </summary>
        public string Status { get; set; }

        /// <summary>
        /// Gets or sets the model of the robot.
        /// </summary>
        public string Model { get; set; }

        /// <summary>
        /// Gets or sets the manufacturer of the robot.
        /// </summary>
        public string Manufacturer { get; set; }

        /// <summary>
        /// Gets or sets the Operating System of the robot.
        /// </summary>
        public string Os { get; set; }
    }
}
```

In the sample above, the `[TypeMetadataModel]` data attribute designates this class as one which should be included in the type generation. The first parameter to the data attributes notes the type we're targeting (this is always the same as the class you are decorating). The second attribute provides the TypeScript namespace for the model generated object. If you do not specify a namespace, the .NET namespace of the model object will be used. The `[Key]` attribute on the name field designates the name property as the primary key field of the object. This is required when performing merge operations from data sets and edit scopes.

<a name="working-with-data-type-metadata-setting-options"></a>
### Setting options

By default, the generated files will be placed in the `\Client\_generated` directory. They will still need to be explicitly included in the csproj for your extension. The TypeScript interface generation and metadata generation are both controlled via properties in your extension's csproj file. The `SamplesExtension.DataModels` project is already configured to generate models. 

Dependent on the version of the SDK you use the following changes are required to your project:

 * From Release 4.15 forward all you need to do is reference your DataModels project and ensure your datamodels are marked with the appropriate TypeMetadataModel attribute  
 * Versions prior to 4.15 require the following change to add this capability to another .NET project, the following changes need to be made to the extension (not model) csproj file:

    `SamplesExtension.csproj`

```xml
<ItemGroup>
    <GenerateInterfacesDataModelAssembly
        Include="..\SamplesExtension.DataModels\bin\$(Configuration)\Microsoft.Portal.Extensions.SamplesExtension.DataModels.dll" />
</ItemGroup>
```

    The addition of `GenerateInterfaces` to the existing `CompileDependsOn` element will ensure the `GenerateInterfaces`         target is executed with the appropriate settings. The `AssemblyPaths` property notes the path on disk where the model        project assembly will be placed during a build.

<a name="working-with-data-type-metadata-using-the-generated-models"></a>
### Using the generated models

Make sure that the generated TypeScript files are included in your csproj. The easiest way to include new models in your extension project is to the select the "Show All Files" option in the Solution Explorer of Visual Studio. Right click on the `\Client\_generated` directory in the solution explorer and choose "Include in Project". Inside of the `\Client\_generated` folder you will find a file named by the fully qualified namespace of the interface. In many cases, you'll want to instantiate an instance of the given type. One way to accomplish this is to create a TypeScript class which implements the generated interface. However, this defeats the point of automatically generating the interface. The framework provides a method which allows generating an instance of a given interface:

```ts
MsPortalFx.Data.Metadata.createEmptyObject(SamplesExtension.DataModels.RobotType)
```

<a name="working-with-data-type-metadata-non-generated-type-metadata"></a>
### Non-generated type metadata

Optionally, you may choose to write your own metadata to describe model objects. This is only recommended if not using a .NET project to generate metadata at compile time. In place of using the generated metadata, you can set the `type` attribute of your `DataSet` to `blogPostMetadata`. The follow snippet manually describes a blog post model:

```ts
var blogPostMetadata: MsPortalFx.Data.Metadata.Metadata = {
    name: "Post"
    idProperties: ["id"],
    properties: {
        "id": null,
        "post": null,
        "comments": { itemType: "Comment", isArray: true },
    }
};

var commentMetadata: MsPortalFx.Data.Metadata.Metadata = {
    name: "Comment"
    properties: {
        "name": null,
        "post": null,
        "date": null,
    }
};

MsPortalFx.Data.Metadata.setTypeMetadata("Post", blogPostMetadata);
MsPortalFx.Data.Metadata.setTypeMetadata("Comment", commentMetadata);
```

- The `name` property refers to the type name of the model object.
- The `idProperties` property refers to one of the properties defined below that acts as the primary key for the object.
- The `properties` object contains a property for each property on the model object.
- The `itemType` property allows for nesting complex object types, and refers to a registered name of a metadata object. (see `setTypeMetadata`).
- The `isArray` property informs the shell that the `comments` property will be an array of comment objects.

The `setTypeMetadata()` method will register your metadata with the system, making it available in the data APIs.


<a name="advanced-data-topics"></a>
# Advanced data topics
    
    
<a name="advanced-data-topics-data-atomization"></a>
## Data atomization

Atomization fulfills two main goals: 

1. It enables several data views to be bound to one data entity, thus presenting a smooth and  consistent experience to the user.  In this instance, two views that represent the same asset are always in sync. 
1. It minimizes memory trace.

Atomization can be switched only for entities, which have globally unique IDs (per type) in  the  metadata system. In this case, a third attribute can be added to its `TypeMetadataModel` attribute in C#, as in the following example.

```cs

[TypeMetadataModel(typeof(Robot), "SamplesExtension.DataModels", true /* Safe to unify entity as Robot IDs are globally unique. */)]

```

The Atomization attribute is set to 'off' by default. The Atomization attribute is not inherited and has to be set to `true` for all types that should be atomized. 
In the simplest case, all entities within an extension will use the same atomization context, which defaults to one.
In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

It is possible to select a different atomization context for a given cache object, as in the following example.

```cs

var cache = new MsPortalFx.Data.QueryCache<ModelType, QueryType>({
    ...
    atomizationOptions: {
        atomizationContextId: "string-id"
    }
    ...
});

```


<!-- optional Best Practices document -->
<!-- gitdown": "include-file", "file": "../templates/portalfx-<major-area>-bp-<topic>.md"  -->
   ## Best Practices 

<a name="advanced-data-topics-data-atomization-use-querycache-and-entitycache"></a>
### Use QueryCache and EntityCache

When performing data access from your view models, it may be tempting to make data calls directly from the `onInputsSet` function. By using the `QueryCache` and `EntityCache` objects from the `DataCache` class, you can control access to data through a single component. A single ref-counted cache can hold data across your entire extension.  This has the following benefits.

* Reduced memory consumption
* Lazy loading of data
* Less calls out to the network
* Consistent UX for views over the same data.

**NOTE**: Developers should use the `DataCache` objects `QueryCache` and `EntityCache` for data access. These classes provide advanced caching and ref-counting. Internally, these make use of Data.Loader and Data.DataSet (which will be made FX-internal in the future).

To learn more, visit [portalfx-data-caching.md#configuring-the-data-cache](portalfx-data-caching.md#configuring-the-data-cache).



<a name="advanced-data-topics-data-atomization-avoid-unnecessary-data-reloading"></a>
### Avoid unnecessary data reloading

As users navigate through the Ibiza UX, they will frequently revisit often-used resources within a short period of time.
They might visit their favorite Website Blade, browse to see their Subscription details, and then return to configure/monitor their
favorite Website. In such scenarios, ideally, the user would not have to wait through loading indicators while Website data reloads.

To optimize for this scenario, use the `extendEntryLifetimes` option that is available on the `QueryCache` object and the `EntityCache` object.

```ts

public websitesQuery = new MsPortalFx.Data.QueryCache<SamplesExtension.DataModels.WebsiteModel, any>({
    entityTypeName: SamplesExtension.DataModels.WebsiteModelType,
    sourceUri: MsPortalFx.Data.uriFormatter(Shared.websitesControllerUri),
    supplyData: (method, uri, headers, data) => {
        // ...
    },
    extendEntryLifetimes: true
});

```

The cache objects contain numerous cache entries, each of which are ref-counted based on not-disposed instances of QueryView/EntityView. When a user closes a blade, typically a cache entry in the corresponding cache object will be removed, because all QueryView/EntityView instances will have been disposed. In the scenario where the user revisits the Website blade, the corresponding cache entry will have to be reloaded via an **AJAX** call, and the user will be subjected to loading indicators on
the blade and its parts.

With `extendEntryLifetimes`, unreferenced cache entries will be retained for some amount of time, so when a corresponding blade is reopened, data for the blade and its parts will already be loaded and cached.  Here, calls to `this._view.fetch()` from a blade or part `ViewModel` will return a resolved Promise, and the user will not see long-running loading indicators.

**NOTE**:  The time that unreferenced cache entries are retained in QueryCache/EntityCache is controlled centrally by the FX
 and the timeout will be tuned based on telemetry to maximize cache efficiency across extensions.)

For your scenario to make use of `extendEntryLifetimes`, it is **very important** that you take steps to keep your client-side
QueryCache/EntityCache data caches **consistent with server data**.
See [Reflecting server data changes on the client](portalfx-data-configuringdatacache.md) for details.


<!-- optional FAQ document -->
<!-- gitdown": "include-file", "file": "../templates/portalfx-<major-area>-faq-<topic>.md"  -->
   ## Frequently asked questions

<a name="advanced-data-topics-data-atomization-"></a>
### 

* * * 
   
<!-- required Glossary document. -->
<!-- gitdown": "include-file", "file": "../templates/portalfx-extensions-glossary-<major-area>.md"  -->
   ## Glossary

 This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                 | Meaning |
| ---                  | --- |
| area             |    |
| ARM | Azure Resource Manager | 
| COGS |   Cost of Goods Sold |
| CORS | | 
| CRUD |   Create, Replace, Update, Delete |
| JSON Web Token |  JSON-based token that asserts information between the server and the client.  For example, a JWT could assert that the client user has the claim "logged in as admin".  | 
| JWT token | JSON Web Token |
| lifetime | The amount of time an object exists in memory between instantiation and destruction.  It may be automatically destroyed by when a parent object is deallocated, or its existence may be managed by a lifetime manager object or a child lifetime manager object. |
| polling | The process that determines which client-side data should be automatically refreshed. |
| reactor | |