
<a name="working-with-data"></a>
# Working with data

  ## Overview

The following list of data subtopics follows the Model-View-View-Model methodology.

| Type                             | Document                                                                     | Description |
| -------------------------------- | ---------------------------------------------------------------------------- | ---- |
| Data Modeling and Organization   | [top-extensions-data-modeling.md](top-extensions-data-modeling.md)                       | The data model for the extension project source. | 
| The Data Cache Object            | [top-extensions-data-caching.md](top-extensions-data-caching.md)                         | Caching data from the server |
| The Data View Object             | [top-extensions-data-views.md](top-extensions-data-views.md)                             | Presenting data to the ViewModel | 
| The Browse Sample | [portalfx-data-masterdetailsbrowse.md](portalfx-data-masterdetailsbrowse.md) | Extension that allows a user to select a Website from a list of websites, using the QueryCache-EntityCache data models | 
|  Loading Data | [portalfx-data-loading.md](portalfx-data-loading.md) | `QueryCache` and `EntityCache` methods that request data from servers and other sources  | 
| Child Lifetime Managers  | [portalfx-data-lifetime.md](portalfx-data-lifetime.md) | Fine-grained memory management that allows resources to be destroyed previous to the closing of the blade. | 
|   | [portalfx-data-projections.md](portalfx-data-projections.md) |  | 
|   | [portalfx-data-refreshingdata.md](portalfx-data-refreshingdata.md) |  | 
|   | [portalfx-data-virtualizedgriddata.md](portalfx-data-virtualizedgriddata.md) |  | 
|   | [portalfx-data-typemetadata.md](portalfx-data-typemetadata.md) |  | 
|   | [top-extensions-data-atomization.md](top-extensions-data-atomization.md) |  | 

* * * 

    
<a name="working-with-data-overview"></a>
## Overview

The Azure Portal UX provides unique data access challenges. Many blades and parts may be displayed at the same time, each of which instantiates a new `ViewModel` instance. Each `ViewModel` often needs access to the same or related data. To optimize for these object-oriented patterns, extensions follow specific data access patterns.

The following sections discuss these patterns and how to apply them to an extension.

* **Code organization**

    * Organizing the extension source code into [areas](#areas)
    
* **Data management**

    * Shared data access using [data contexts](#data-contexts)

    * Using [data caches](#data-caches) to load and cache data

    * Memory management with [data views](#data-views)

* **Combining code organization and data management**

 * [Developing a DataContext for an area](#developing-a-datacontext-for-an-area)

All of these data concepts are used to achieve the goals of loading and updating extension data, in addition to efficient memory management. For more information about how the pieces fit together and how the resulting construct relates to the conventional MVVM pattern, see the [Data Architecture](https://auxdocs.blob.core.windows.net/media/DataArchitecture.pptx) video that discusses extension blades and parts.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

<a name="working-with-data-overview-areas"></a>
### Areas

From the perspective of code organization, an area can be defined as a project-level folder. It is of great assistance when data operations are segmented within the extension. `Areas` are a scheme for organizing and partitioning the source code of the extension. This makes it easier for teams to develop an extension in parallel. Areas help categorize related blades and parts, and each area also maintains the data that is required by its blades and parts.

Every area within an extension gets a distinct `DataContext` singleton, and it loads/caches/updates the data that is associated with the models that support the area's blades and parts.

An area is defined in the extension by using the following steps.

  1. Create a folder in the `Client\` directory of the project that contains the extension. The name of that folder is the name of the area, in addition to being the name of the `DataContext`.

  1. In the root of that folder, create a file for the `DataContext` and name it `<AreaName>Area.ts`, where `<AreaName>` is the name of the folder that was just created, as specified in [#developing-a-datacontext-for-an-area](#developing-a-datacontext-for-an-area). For example, the `DataContext` for the `Security` area in the sample is located at `\Client\Security\SecurityArea.ts`.  

A typical extension resembles the following image.

![alt-text](../media/portalfx-data-context/area.png "Extensions can host multiple areas")

<a name="working-with-data-overview-data-contexts"></a>
### Data contexts

For each area in an extension, there is a singleton `DataContext` instance that supports access to shared data for the blades and parts implemented in that area. Access to shared data means data loading, caching, refreshing and updating. Whenever multiple blades and parts make use of common server data, the `DataContext` is an ideal place to locate data logic for an extension [area](portalfx-extensions-glossary-data.md).

When a blade or part `ViewModel` is instantiated, its constructor is sent a reference to the `DataContext` singleton instance for the associated extension area.   The `ViewModel` accesses the data required by that blade or part in its constructor, as in the code located at `<dir>/Client/V1/MasterDetail/MasterDetailEdit/ViewModels/MasterViewModels.ts`.  The code is also in the following example.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

 ```typescript

constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: MasterDetailArea.DataContext) {
    super();

    this.title(ClientResources.masterDetailEditMasterBladeTitle);
    this.subtitle(ClientResources.masterDetailEditMasterBladeSubtitle);

    this._view = dataContext.websitesQuery.createView(container);
    
```

The benefits of centralizing data access in a singleton `DataContext` include the following.

1. Caching and Sharing

   The `DataContext` singleton instance will exist for the entire amount of time that the extension is loaded in the browser. Consequently, when a blade is opened, and therefore a new blade `ViewModel` is instantiated, data required by the new blade may have previously been loaded and cached in the `DataContext`, because it was required by some previously opened blade or rendered part.
  
   This cached data is available immediately, which optimizes rendering performance and improves [perceived responsiveness](portalfx-extensions-glossary-data.md). Also, no new **AJAX** calls are necessary to load the data for the newly-opened blade, which reduces server load and Cost of Goods Sold (COGS).

1. Consistency
  
   It is very common for multiple blades and parts to render the same data in levels of different detail, or with different presentation. Also, there are situations where such blades or parts are displayed on the screen simultaneously, or separated in time only by a single user navigation. 

   In these cases, the user expects to see all the blades and parts that describe the exact same state of the data. Using a shared `DataContext`  effectively achieves this consistency by allowing all the blades to use the single copy of the data that it contains.
  
1. Fresh data

   Users expect to see information that always reflects the current state of their data in the cloud. Another benefit of loading and caching data in a single location is that the cached data is regularly updated to accurately reflect the state of server data.

   For more information on refreshing data, see [portalfx-data-refreshingdata.md](portalfx-data-refreshingdata.md).

### Data caches
 
  The `DataCache` classes are a full-featured and convenient way to load and cache data required by blade and part `ViewModels`. The `DataCache` class objects in the API are `QueryCache`, `EntityCache` and the `EditScopeCache`. 

* QueryCache

  Loads data of type `Array<T>` according to an extension-specified `TQuery` type. `QueryCache` is useful for  list-like views like Grid, List, Tree, or Chart. For more information about the `QueryCache`, see [portalfx-data-caching.md#querycache](portalfx-data-caching.md#querycache). 
    
* EntityCache

  The `EntityCache` caches a single item, typically from the `QueryCache` object, as specified in [portalfx-data-caching.md#entitycache](portalfx-data-caching.md#entitycache).

* EditScopeCache

  The `EditScopeCache` class is less commonly used. It loads and manages instances of `EditScope`, which is a change-tracked, editable model for use in Forms.
  
 * `DataCache` class methods

  The `DataCache` objects use the CRUD methods: Create, Replace, Update, and Delete. Commands for blades and parts often use these methods to modify server data. These commands are implemented in methods on the `DataContext` class, where each method can issue **AJAX** calls to the server and reflect data changes in associated DataCaches. For more information about sharing  data across the parent and child blades, see  [portalfx-data-masterdetailsbrowse.md](portalfx-data-masterdetailsbrowse.md).

### Data views

`DataCaches` in the `DataContext` of an `area` will exist in memory for as long as an extension is loaded, and consequently may support blades and parts that come and go as the user navigates in the Azure Portal.  Memory management becomes important, because memory overuse by many extensions or blades simultaneously can impact responsiveness. Consequently, each `DataCache` instance manages a set of [cache entries](portalfx-extensions-glossary-data.md), and the `DataCache` class includes  mechanisms to automatically manage the number of cache entries present at any given time. 

The data in the `DataCache`, and therefore the `DataContext`, is impacted by the needs of the `DataView` for the `ViewModel`. When a `ViewModel` calls the `fetch()` method for its `DataView`, the method implicitly forms a ref-count to a `DataCache` entry. This ref-count keeps the entry in the `DataCache` as long as the blade or part `ViewModel` has not been disposed by the extension.

The `DataCache` manages its size automatically, without explicit code in the extension source, by using the `DataView` to track the ref-counts to cache entries. When every blade or part `ViewModel` that holds a ref-count to a specific cache entry is disposed indirectly by using `DataView`, the `DataCache` can elect to discard the cache entry. 

### Developing a DataContext for an area

The `DataContext` class does not specify the use of any single FX base class or interface. In practice, the members of a `DataContext` class typically include [data caches](#data-caches) and [data views](#data-views).

Typically, the `DataContext` associated with a particular area is instantiated from the `initialize()` method of `<dir>\Client\Program.ts`, which is the entry point of the extension, as in the following example.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

```typescript

this.viewModelFactories.V1$MasterDetail().setDataContextFactory<typeof MasterDetailV1>(
    "./V1/MasterDetail/MasterDetailArea",
    (contextModule) => new contextModule.DataContext());

```

There is a single `DataContext` class per area. That class is named `<AreaName>Area.ts`, as in the code located at  `<dir>\Client\V1\MasterDetail\MasterDetailArea.ts` and in the following example.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

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



   

   
## Using DataViews

Data in a cache is presented to the `ViewModel` by using a `DataView`. 
The `DataCache` objects contain a `createView` method that is used to create the `DataView`. The data in the cache is processed by the `DataView` that it associates with a specific `ViewModel`. There can be many `DataViews` for a cache but there is a one-to-one correspondence between the `DataView` and the `ViewModel`. Creating a `DataView` does not result in a data load operation from the server.  When a `ViewModel` calls the `fetch()` method for its `DataView`, the method implicitly counts each time a reference is made to each `DataCache` entry. This ref-count keeps the entry in the `DataCache` as long as the blade or part `ViewModel` has not been disposed by the extension.


**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

<!--TODO: Remove the following placeholder sentence when it is explained in more detail. -->

**NOTE**: Because this discussion includes **AJAX**, **TypeScript**, and template classes, it does not strictly specify an object-property-method model.

The example located at `<dir>Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts` demonstrates a `SaveItemCommand` class that uses the binding between a part and a command. This code is also included in the following `WebsiteQuery` example.

```ts
this._websitesQueryView = dataContext.masterDetailBrowseSample.websitesQuery.createView(container);
```

In the previous code, the `container` object acts as a lifetime object that  informs the cache when a given view is currently being displayed on the screen. This allows the Shell to make several adjustments for performance, including the following.

* Adjust polling interval when the part is not on the screen

* Automatically dispose of data when the blade that contains the part is closed

The server is only queried when the `fetch` operation of the view is invoked, as in the code located at 
`<dir>Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts` and  in the following example.

```ts
public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
    return this._websitesQueryView.fetch({ runningStatus: inputs.filterRunningStatus.value });
}
```

### Observable map & filter

In many cases, the developer may want to shape the extension data to fit the view to which it will be bound. Some cases where this is useful are as follows.

* Matching the contract of a control, like data points of a chart

* Adding a computed property to a model object

* Filtering data that is presented on the client

The recommended approach is to use the `map` and `filter` methods from the library that is located at [https://github.com/stevesanderson/knockout-projections](https://github.com/stevesanderson/knockout-projections).

The `runningStatus` is a filter that is applied to the query to allow several views to be created over a single cache. Each view can present a different subset of data from the cache, as in the code located at 
`<dir>Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts` and in the following example.

```ts
public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
    return this._websitesQueryView.fetch({ runningStatus: inputs.filterRunningStatus.value });
}
```

For more information about shaping and filtering your data, see [portalfx-data-projections.md](portalfx-data-projections.md).

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

   
## Master details browse 

Blades can be arranged in a one-to-many relationship, or a summary-detail relationship.  This arrangement can use grids to display information from `QueryCache`-`EntityCache` cache objects as parent-child blades.  The extension retrieves data from the server and displays it across multiple blades, and the data is shared across the parent blade and the child blades.

In this example, the information to display in the parent blade is a list of websites. The master view uses the `QueryCache` to load all of the data at once, as  specified in [#the-master-view](#the-master-view). The `QueryCache` caches a list of items as specified in [portalfx-data-caching.md#the-querycache](portalfx-data-caching.md#the-querycache). 

When the user activates a website on the master view, a child blade is opened, and displays detailed information about the activated website as specified in [#the-detail-view](#the-detail-view). The child blade is dependent on the parent blade for specific resources. The activated website that is displayed is associated with the `EntityCache` that contains a single item, as specified in [portalfx-data-caching.md#the-entitycache](portalfx-data-caching.md#the-entitycache).

The server data is cached using one of the two cache objects, and then the extension uses that cache to display the websites across the two blades. The data for both blades is located in the same cache, therefore the server is not queried again when it is time to open the second blade. When the data in the cache is updated, the  updated data is displayed across all blades at the same time. Consequently, the Portal always presents a consistent view of the data.

Linking the dataContext to the `ViewModel` is the process that connects the data to the UI. It does this in two ways.

* [The master view](#the-master-view)

    The master view uses the `QueryCache` to load all of the data from the data store into the UI. 

* [The detail view](#the-detail-view)

    The detail view uses the `EntityCache` to display detailed information about one item from the `QueryCache`.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK. 
     
The code for this example is located at:
`<dir>\Client\V1\MasterDetail\MasterDetailArea.ts`
`<dir>\Client\V1\MasterDetail\MasterDetailBrowse\MasterDetailBrowse.pdl`
`<dir>\Client\V1\Data\MasterDetailBrowse\MasterDetailBrowseData.ts`
`<dir>\Client\V1\asterDetail\MasterDetailBrowse\ViewModels\DetailViewModels.ts`
`<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`

The Portal uses an `Area` to contain the cache and other data objects that are shared across multiple blades. The code for the area is located in its own folder, as specified in [portalfx-data-modeling.md#areas](portalfx-data-modeling.md#areas). In this example, the area folder is named `MasterDetail` and it is located in the `Client` folder of the extension.

Inside the folder, there is a **TypeScript** file that contains the `DataContext` class. Its name is a combination of the name of the area and the word 'Area'. The `DataContext` class is the class that will be sent to all the `ViewModels` associated with the area.

For the example, the file is named `MasterDetailArea.ts` and is located at `<dir>Client/V1/MasterDetail/MasterDetailArea.ts`. This code is also included in the following example.
<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

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

If this is a new area for the extension, the developer should edit the `Program.ts` file to create the `DataContext` when the extension is loaded. The SDK edition of the `Program.ts` file is located at `<dir>\Client\Program.ts`. For the extension that is being built, find the `initializeDataContexts` method and then use the `setDataContextFactory` method to set the `DataContext`, as in the following example.
 
```typescript

this.viewModelFactories.V1$MasterDetail().setDataContextFactory<typeof MasterDetailV1>(
    "./V1/MasterDetail/MasterDetailArea",
    (contextModule) => new contextModule.DataContext());

```

### The master view

The master view is used to display the data in the caches. The advantage of using views is that they allow the `QueryCache` to handle the caching, refreshing, and evicting of data.

For this scenario, the `ViewModel` for the master view's list of websites is located in `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`. When it is instantiated, its constructor is sent a reference to the `DataContext` singleton instance.  The `ViewModel` accesses the data it requires in its constructor.

1. Make sure that the PDL that defines the blades specifies the `Area` so that the `ViewModels` receive the `DataContext`. In the `<Definition>` tag at the top of the PDL file, include an `Area` attribute whose value corresponds to the name of the area that is being built, as in the example located at `<dir>Client/V1/MasterDetail/MasterDetailBrowse/MasterDetailBrowse.pdl`. This code is also included in the following example.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

 ```xml

<Definition xmlns="http://schemas.microsoft.com/aux/2013/pdl"
Area="V1/MasterDetail">

``` 

2. Use the `fetch()` method from the `DataView` to populate the `QueryCache` and  select data from it to be viewed. This process is known as creating a view on the `QueryCache`, and it allows the items that are returned by the fetch call to be viewed or edited. It also implicitly forms a ref-count to the `DataCache` entries that it selects. The code that performs this is in the following example.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

 ```typescript

this._websitesQueryView = dataContext.websitesQuery.createView(container);

``` 

 3. When  the view is populated, the user needs to interact with it by using the controls. There are two controls on this blade, both of which use the view that was just created: a `grid` control and the `OptionGroup` control. 

    1. The `grid` control displays the data from the `QueryCache`, as specified in  [#fetching-data-for-the-grid](#fetching-data-for-the-grid).

    1. The `OptionGroup` control allows the user to select whether to display websites that are in a running state, websites in a stopped state or display both types of sites. The display created by the `OptionGroup` control is specified in [#the-optiongroup-control](#the-optiongroup-control).

For more information about dataviews, see [portalfx-data-views.md](portalfx-data-views.md).

#### Fetching data for the grid

The observable `items` array of the view is sent to the grid constructor as the `items` parameter, as in the following example.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

 ```typescript

this.grid = new Grid.ViewModel<WebsiteModel, number>(this._lifetime, this._websitesQueryView.items, extensions, extensionsOptions);

```

The `fetch()` command has not yet been issued on the `QueryCache`. When the command is issued, the view's `items` array will be observably updated, which populates the grid with the results. This occurs by calling the  `fetch()` method on the blade's `onInputsSet()`, which returns the promise shown in the following example.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

 ```typescript

/**
 * Invoked when the blade's inputs change
 */   
public onInputsSet(inputs: Def.BrowseMasterListViewModel.InputsContract): MsPortalFx.Base.Promise {
    return this._websitesQueryView.fetch({ runningStatus: this.runningStatus.value() });
}

```

This will populate the `QueryCache` with items from the server and display them in the grid.

#### The optionGroup control 

The `OptionGroup` control allows the user to select whether to display websites that are in a running state, websites in a stopped state or display both types of sites. This implies that the control may cause the extension to display different subsets of the data that is currently located in the `QueryCache`. The control may also change the data that is displayed in the grid. 

<!-- TODO:  Determine whether the grid leaves data on the master view in a grayed-out state. -->

The `OptionGroup` control is initialized, and the extension then subscribes to its value property, as in the following example.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

 ```typescript

this.runningStatus.value.subscribe(this._lifetime, (newValue) => {
    this.grid.loading(true);
    this._websitesQueryView.fetch({ runningStatus: newValue })
        .finally(() => {
            this.grid.loading(false);
        });
});

```

In the [subscription](portalfx-extensions-glossary-data.md), the extension performs the following actions.

1. Put the grid in a loading mode. It will remain in this mode until all of the data is retrieved.

1. Request the new data by calling the `fetch()` method on the `DataView` with new parameters.

1. When the `fetch()` method completes, take the grid out of loading mode.

There is no need to get the results of the fetch and replace the items in the grid because the grid's `items` array has a reference to the `items` array of the view. The view will update its `items` array as soon as the fetch is complete.

The rest of the code demonstrates that the grid has been configured to activate any of the websites when they are clicked. The `id` of the selected website is sent to the details child blade as an input. 

<a name="working-with-data-overview-the-detail-view"></a>
### The detail view

The detail view uses the `EntityCache` that was associated with the  `QueryCache` from the `DataContext` to display the details of a website. 

1. The child blade creates a view on the `EntityCache`, as in the following code.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

 ```typescript

this._websiteEntityView = dataContext.websiteEntities.createView(container);

```

2.  In the `onInputsSet()` method, the `fetch()` method is called with a parameter that contains the `id` of the website to display, as in the following example. 

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

 ```typescript

/**
* Invoked when the blade's inputs change.
*/
public onInputsSet(inputs: Def.BrowseDetailViewModel.InputsContract): MsPortalFx.Base.Promise {
    return this._websiteEntityView.fetch(inputs.currentItemId);
}

```

3. When the fetch is completed, the data is available in the view's `item` property. This blade uses the `text` data-binding in its `HTML` template to show the name, id and running status of the website. 


<!-- TODO:  Create a screen shot of the sample that displays these 3 items. Also, see whether there is an html file that can be included here.-->

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

   

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

   ## Lifetime Manager

The `lifetime manager` ensures that any resources that are specifically associated with a blade are disposed of when the blade is closed. Each blade has its own lifetime manager. Controls, **Knockout** projections and APIs that use a `lifetime manager` will be disposed when the `lifetime manager` is disposed. That means, for the most part, extensions in the Portal implicitly perform efficient memory management.

There are some scenarios that call for more fine-grained memory management wWhen dealing with large amounts of data, especially virtualized data. The most common case is the `map()` or `mapInto()` function, especially when it is used with a `reactor` or a control in the callback that generates individual items. These items can be destroyed previous to the closing of the blade by being removed from the source array. Otherwise, memory leaks can quickly add up and result in poor extension performance.

**NOTE**: The  `pureComputed()` method does not use a lifetime manager because it already uses memory as efficiently as possible.  This is by design, therefore it is good practice to use it. Generally, any `computed` the extension creates in a `map()` should be a `pureComputed()` method, instead of a `ko.reactor` method.

For more information on pureComputeds, see [portalfx-blades-viewmodel.md#the-ko.pureComputed method](portalfx-blades-viewmodel.md#the-ko.pureComputed-method).

<a name="working-with-data-overview-child-lifetime-managers"></a>
### Child lifetime managers

The maximum amount of time that a child lifetime manager can exist is the lifetime of its parent.  However, they can be disposed before the parent is disposed. 

When the developer is aware that extension child resources will have lifetimes that are shorter than that of the blade, a child lifetime manager can be created with the  `container.createChildLifetimeManager()` command, and sent to `ViewModel` constructors or whereever a lifetime manager object is needed. When the extension completes using those resources, the `dispose()` method can be explicitly called on the child lifetime manager. If the `dispose()` method is not called, the child lifetime manager will be disposed when its parent is disposed.

<!-- TODO:  Determine whether the disposing of the  child lifetime manager  when its parent is disposed is implicit. -->

In the following example, a data cache already contains data. Each item is displayed as a row in a grid. A button is displayed in a section below the grid. The `mapInto()` function maps specific data cache items to the view grid items, and creates the button to add to the section.  The `itemLifetime` child lifetime manager is automatically created by the `mapInto()` function.

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

In this example, when the value of an observable is read in the mapping function, it is wrapped in a `ko.pureComputed`. The `itemLifetime` child lifetime manager was sent to the mapping function as a parameter, instead of sending the `container` into the button constructor. It will be disposed when the associated object is removed from the source array. This means the button `ViewModel` will be disposed at the correct time, but it will still be in the section because the button has not been removed from the section's `children()` array. 

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

 For more information about selecting specific data cache items, see [portalfx-data-projections.md#data-shaping](portalfx-data-projections.md#data-shaping).

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

   
<a name="working-with-data-data-shaping"></a>
## Data shaping

<a name="working-with-data-data-shaping-shaping-and-filtering-data"></a>
### Shaping and filtering data

Extensions that use data from  a `QueryCache` will select and filter the items in the cache, or reshape them into formats that are more suited to a specific UI. The **Knockout** observable versions of the `map()` and `mapInto()` methods can be used to accomplish this.

The following data model accepts a `QueryCache` of `Robot` objects as a parameter. 

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

The  robots from the `QueryCache` are displayed on  a grid that is three columns wide. The `name` column and the `status` column are the same data as that of the model, but the third column is a combination of the model and manufacturer properties from the model object in the `QueryCache`. The working copy is located at [https://aka.ms/portalfx/projection](https://aka.ms/portalfx/projection). 

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

The interface for the shaped data to display in the grid is located at `<dir>\Client\V1\Data\Projection\ViewModels\MapAndMapIntoViewModels.ts`. This code is also included in the following example.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

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

The initial implementation of [data projection](portalfx-extensions-glossary.md) would resemble the following code.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

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

The `robot.name()` contains the name of the robot, and `robot.model()` and `robot.manufacturer()` respectively contain the model and manufacturer values. The `RobotDetails` interface that models the data in the grid requires observables for the  `name` and `modelAndMfg` properties, therefore they use the strings that are received from the `QueryCache` model. The `projectionId` and `_logMapFunctionRunning` methods are discussed in [](). 

The reason that this implementation is not extremely performant is demonstrated in the sample located at `<dir>\Client/V1/Data/Projection/Templates/UnderstandingMapAndMapInto.html` and in the working copy located at [https://aka.ms/portalfx/projection](https://aka.ms/portalfx/projection).  The grid is configured with the buttons in the middle of the screen.  When the grid is configured  with different types of projections, the commands at the top of the screen are used to add/remove/modify items in the data source.  The output window displays the results of the functions.

1. When the blade opens, click on the **Buggy Map** button to load the grid with the data projection that was previously discussed. Something like the following is displayed in the **log stream** control at the bottom of the blade.

    ```
    Creating buggy map() projection
    Creating a projection (projection id=4, robot=Spring) 
    Creating a projection (projection id=5, robot=MetalHead)
    Creating a projection (projection id=6, robot=Botly)
    Creating a projection (projection id=7, robot=Bolt)
    ```

    The projection was created and sent to the grid. Because there are four items in the `QueryCache`, the projection will run four times, once on each object. Every time the mapping function runs on an item in the grid, this sample creates a new ID for the resulting `RobotDetails` object.

1. Activate the first line in the grid by clicking on it so that the child blade opens. You may need to scroll to the right to view the grid and the child blade.

1. Clicking on the **update status** command at the top of the blade simulates the `QueryCache` receiving a property value for the activated item. Typically, new property values are retrieved by polling the server. Whe the status is updated, the child blade closes and the new status for the robot is displayed.  The activated item is the same item in the `QueryCache`, because the name has not changed, but one of its properties has been updated.  

The reason why this implementation is considered to be somewhat buggy is contained  in the **log** at the bottom of the blade.

    ```
    Updating robot status to 'processor' (robot='Bolt')
    Creating a projection (projection id=8, robot=Bolt)
    ```

When the `status` observable updates the map's projection, the function runs and computes a different projected item. The object with "projectionId === 4" is gone and is replaced with a new item with "projectionId === 8" or some other value. Consequently, the child blade closed because its contents were based on the value of the  `status` observable. The object that was in the grid's item had a different status value, and it has  been replaced by an item with the same `name` and `modelAndMfg` but a new `status`. The previous  that was in the `selectableSet's` `activatedItems` observable array no longer exists in the grid's item list.

<a name="working-with-data-data-shaping-shaping-and-filtering-data-how-map-works"></a>
#### How map() works

When the mapping function runs **Knockout**, it watches to see what observable values are read. Then it takes a dependency on those values, in a manner similar to  **ko.pureComputed** or **ko.reactor**. If any of those values change, **Knockout** is aware that the generated item is out-of-date because the source for that item has changed.

The `map()` function generates an update-to-date projection by running the mapping function again. This might not be performant  if the extension does something expensive in the mapping function. The same thing happens if the extension updates the model property of the top item by clicking the **update model** command.

```
Updating model to 'into' (robot=Bolt)
Creating a projection (projection id=10, robot=Bolt)
```

Reason is the same. The following line of code is in the mapping function. 

```
modelAndMfg: ko.observable("{0}:{1}".format(robot.model(), robot.manufacturer()))
```

This means that the map projection will run again anytime `robot.model()` is observably updated. This causes the old item to be removed from the grid and an entirely new item to be added.

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

This prevents the map() from taking a dependency on `robot.model()` and `robot.manufacturer()` because the `pureComputed()` function takes the dependency on `robot.model()` and `robot.manufacturer()`. Since the `pureComputed()` we created will update whenever `model()` or `manufacturer()` updates `ko.map` knows it will not need to rerun your mapping function to keep the projection object up-to-date when those observables change in the source model.

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

### Chaining uses of `map` and `filter`

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

**Do** use `map` and `filter` to reduce the size of the data you are binding to a control - See "Use map and filter to reduce size of rendered data".

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


<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->
  
   
## Data merging 

For the Azure Portal UI to be responsive, it is important to avoid re-rendering entire blades and parts when data changes. Instead, it is better to make granular data changes so that FX controls and **Knockout** HTML templates can re-render small portions of the blade or part UI. In many cases when an extension refreshes cached data, the newly-loaded server data precisely matches previously-cached data, and therefore there is no need to re-render the UI.

When cache object data is refreshed - either implicitly as specified in [#the-implicit-refresh](#the-implicit-refresh),  or explicitly as specified in  [#the-explicit-refresh](#the-explicit-refresh) - the newly-loaded server data is added to previously-cached, client-side data through a process named data-merging. The  process is as follows.

1. The newly-loaded server data is compared to previously-cached data
1. Differences between newly-loaded and previously-cached data are detected. For instance, "property <X> on object <Y> changed value" and "the Nth item in array <Z> was removed".
1. The differences are applied to the previously-cached data, via changes to **Knockout** observables.

For many scenarios, data merging requires no configuration because it is an implementation detail of implicit and explicit refreshed. However, there are caveats in some scenarios.

#### Supply type metadata for arrays

When detecting changes between items in an previously-loaded array and a newly-loaded array, the data-merging algorithm requires some per-array configuration. Specifically, the data-merging algorithm that is not configured does not know how to match items between the old and new arrays. Without configuration, the algorithm considers each previously-cached array item as removed because it does not match any item in the newly-loaded array. Consequently, every newly-loaded array item is considered to be added because it does not match any item in the previously-cached array. This effectively replaces the entire contents of the cached array, even in those cases where the server data is unchanged. This is often the cause of performance problems in the extension, like poor responsiveness or hanging.  The UI does not display any indication that an error has occurred. To proactively warn users of  potential performance problems, the data-merge algorithm logs warnings to the console that resemble the following.

```
Base.Diagnostics.js:351 [Microsoft_Azure_FooBar]  18:55:54 
MsPortalFx/Data/Data.DataSet Data.DataSet: Data of type [No type specified] is being merged without identity because the type has no metadata. Please supply metadata for this type.
```

Any array cached in the cache object is configured for data merging by using type metadata, as specified in [portalfx-data-typemetadata.md](portalfx-data-typemetadata.md). Specifically, for each `Array<T>`, the extension has to supply type metadata for type `T` that describes the `id` properties for that type. With this `id` metadata, the data-merging algorithm can match previously-cached and newly-loaded array items and can merge them in-place, with fewer remove operations or add operations per item in the array.  In addition, when the server data does not change, each cached array item will match a newly-loaded server item and the arrays merge in-place with no detected changes, therefore from the perspective of UI rerendering, the merge will be a no-op.

#### Data merge failures

As data-merging proceeds, differences are applied to the previously-cached data by using **Knockout** observable changes. When these observables are changed, **Knockout** subscriptions are notified and **Knockout** `reactors` and `computeds` are reevaluated. Any  extension-authored callback can throw an exception, which will halt or preempt the current data-merge cycle. When this happens, the data-merging algorithm issues an error resembling the following log entry.

```
Data merge failed for data set 'FooBarDataSet'. The error message was: ...
```

In this case, some **JavaScript** code or extension code is causing an exception to be thrown, and it is bubbled through the running data-merging algorithm to be logged. This error should be accompanied with a **JavaScript** stack trace that can be used to isolate and fix such bugs.  

#### EntityView item observable does not change on refresh

SITUATION:  The EntityView `item` observable does not change, and therefore does not notify subscribers, when the cache object is refreshed. The refreshing is performed either [implicitly](#the-implicit-refresh) or [explicitly](#the-explicit-refresh).  When the observable does not change, code like the following does not work as expected.

```ts
entityView.item.subscribe(lifetime, () => {
    const item = entityView.item();
    if (item) {
        // Do something with 'newItem' after refresh.
        doSomething(item.customerName());
    }
});
```

EXPLANATION:  The EntityView `item` observable does not change because the data-merge algorithm does not replace objects that are previously cached, unless such objects are array items. Instead, objects are merged in-place, which optimizes for limited or no UI re-rendering when data changes, as specified in  [#supply-type-metadata-for-arrays](#Supply-type-metadata-for-arrays).  

SOLUTION: A better coding pattern is to use `ko.reactor` and `ko.computed` as follows.  

```ts
ko.reactor(lifetime, () => {
    const item = entityView.item();
    if (item) {
        // Do something with 'newItem' after refresh.
        doSomething(item.customerName());
    }
});
```

In this example, the supplied callback will be called both when the `item` observable changes when the data first loads, and when any properties on the entity change, like `customerName`.

### The implicit refresh

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

In many scenarios, users expect to see their rendered data updated implicitly when server data changes. The auto-refreshing of client-side data, also known as polling, can be accomplished by configuring the cache object to include it, as in the example located at `<dir>\Client\V1\Hubs\RobotData.ts`. This code is also included in the following example.

```typescript

public robotsQuery = new MsPortalFx.Data.QueryCache<SamplesExtension.DataModels.Robot, any>({
    entityTypeName: SamplesExtension.DataModels.RobotType,
    sourceUri: () => Util.appendSessionId(RobotData._apiRoot),
    poll: true
});

```

Additionally, the extension can customize the polling interval by using the `pollingInterval` option. By default, the polling interval is 60 seconds. It can be customized to a minimum of 10 seconds. The minimum is enforced to avoid the server load that can result from inaccurate changes.  However, there have been instances when this 10-second minimum has caused negative customer impact because of the increased server load.

### The explicit refresh

When server data changes, the extension should take steps to keep the cache object data consistent with the server. In these instances, explicit refreshing of a cache object is necessary, for example, when the extension issues an AJAX call that changes server data. There are methods that explicitly and proactively reflect server data changes on the client.

**NOTE**: Issuing this **AJAX** call from an extension `DataContext` is best practice.

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

In this scenario, because the **AJAX** call will be issued from a `DataContext`, refreshing data in caches is performed  using methods in  the `dataCache` classes. See ["Refreshing or updating a data cache"](#refreshing-or-updating-a-data-cache).
#####
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

In this scenario, the data that is being refreshed was rendered in a specific blade or part. The `DataCache` class methods for the cache object(s) are used to refresh the data in the cache that is being used by the Blade/Part `ViewModel` for the blade or part. See ["Refreshing a QueryView/EntityView"](#refresh-dataview).

### Refreshing or updating a data cache

The cache objects are a collection of cache entries. In extensions that use multiple active blades and parts, a specific cache object might contain many cache entries.  This means that multiple parts or services can rely on the same set of data. There are a number of methods available on objects in the `DataCache` class that keep client-side cached data consistent with server data.

Which of these is appropriate to an extension varies by scenario.

For more information about the `DataCache`/`DataView` objects, see  [portalfx-data-caching.md](portalfx-data-caching.md).

#### The refresh method
  
The `refresh` method is useful when the server data changes are known to be specific to a single cache entry.  This is a single query in the case of `QueryCache`, and it is a single entity `id` in the case of `EntityCache`.  This per-cache-entry method allows for more granular, often more efficient refreshing of cache object data. Only one AJAX call will be issued to the server, as in the following code.

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

#### The refreshAll method
  
The `refreshAll` method issues N AJAX calls, one for each entry that is currently in the cache object.  The AJAX call is issued using either the `supplyData` or `uri` option supplied to the cache object. Upon completion, each AJAX result is merged onto its corresponding cache entry, as in the following example.

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

If the optional `predicate` parameter is supplied to the `refreshAll` call, then only those entries for which the predicate returns `true` will be refreshed.  This feature is useful when the extension is aware of server data changes and therefore does not refresh cache object entries whose server data has not changed.

#### The applyChanges method

The `applyChanges` method is used in instances where the data may have already been cached. For instance, the user may have fully described the server data changes by filling out a Form on a Form Blade. In this case, the necessary cache object changes are known by the extension directly, as in the following examples.

* Adding an item to a QueryCache entry

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

* Removing an item to a QueryCache entry

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

The `applyChanges` method accepts a function that is called for each cache entry currently in the cache object. This allows the extension to update only those cache entries that were impacted by the  changes made by the user.  This use of `applyChanges` can be a nice optimization to avoid some AJAX traffic to your servers.  When it is appropriate to write the data changes to the server, an extension would use the `refreshAll` method after the code that uses the  `applyChanges` method.
  
#### The forceRemove method
  
Cache objects in the `DataCache` class can contain cache entries for some time after the last blade or part has been closed or unpinned. This separates the cached data from the data view, and supports the scenario where a user closes a blade and immediately reopens it.

Now, when the server data for a given cache entry is entirely deleted, then the extension will forcibly remove corresponding entries from their `QueryCache` (less common) and `EntityCache` (more common). The `forceRemove` method does just this, as in the following example. 

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

Once called, the corresponding cache entry will be removed. If the user were to open a Blade or drag/drop a Part that tried to load the deleted data, the cache objects would try to create an entirely new cache entry, and the extension would fail to load the corresponding server data. In such a case, by design, the user would see a 'data not found' notification in that blade or part.

Typically, when using the `forceRemove` method, the extension will take steps to ensure that existing Blades/Parts are no longer accessing the removed cache entry in the `QueryView` or `EntityView` methods. When the extension notifies the Portal of a deleted ARM resource by using the `MsPortalFx.UI.AssetManager.notifyAssetDeleted()` method, as specified in [portalfx-assets.md](portalfx-assets.md), the Portal will automatically display 'deleted' in the UX in any corresponding blades or parts. If the user clicked on a 'Delete'-style command on a Blade to trigger the `forceRemove`, often the extension will programmatically close the Blade in addition to making associated AJAX and `forceRemove` calls from its `DataContext`.
  
## Refreshing a QueryView or EntityView

In some blades or parts, there can be a specific `Refresh` command that refreshes only the data that is visible in the specified blade or part. In this scenario, it is the `QueryView/EntityView` that serves as a reference pointer to that Blade/Part's data, and it's with that QueryView/EntityView that the extension should refresh the data.  (See a sample [here](#refresh-dataview-sample)).  

When `refresh` is called, a Promise is returned that reflects the progress/completion of the corresponding AJAX call. In addition, the `isLoading` observable property of QueryView/EntityView also changes to 'true' (useful for controlling UI indications that the refresh is in progress, like temporarily disabling the clicked 'Refresh' command).  

At the cache object level, in response to the QueryView/EntityView `refresh` call, an AJAX call will be issued for the corresponding cache entry, precisely in the same manner that would happen if the extension called the cache object's `refresh` method with the associated cache key (see [#the-refresh-method](#the-refresh-method)).  

#### QueryView/EntityView `refresh` **caveat**  

There is one subtety to the '`refresh`' method available on QueryView/EntityView that sometimes trips up extension developers. You will notice that '`refresh`' accepts no parameters. This is because '`refresh`' was designed to refresh *previously-loaded data*. An initial call to QueryView/EntityView's '`fetch`' method establishes a cache entry in the corresponding cache object that includes the URL information with which to issue an AJAX call when '`refresh`' is later called.  

Sometimes, extensions developers feel it is important - when a Blade opens or a Part is first displayed - to implicitly refresh the Blade's/Part's data (in cases where the data may have previously been loaded/cached for use in some previously viewed Blade/Part). To make this so, they'll sometimes call QueryView/EntityView's '`fetch`' and '`refresh`' methods in succession. This is a minor anti-pattern that should probably be avoided. This "refresh my data on Blade open" pattern trains the user to open Blades to fix stale data (even close and then immediately reopen the same Blade) and can often be a symptom of a missing 'Refresh' command or [auto-refreshing data](#the-implicit-refresh) that's configured with too long a polling interval.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

   
## Virtualized data for the grid

### Querying for virtualized data

If the server that your extension uses is going to return significant amounts of data, you should consider using the `DataNavigator` class provided by the Framework. The following two models are used to query virtualized data from the server.

* "Load more" model

    This sequential model loads a page of data.  When the user scrolls to the bottom of the page, the model loads the next page of data.  There is no way to skip forward or backward in the data, and all data is represented in a timeline.  This works best with APIs that provide continuation tokens, or timeline based data.

* Paged model

    The classic paged model provides either a pager control or a virtualized scrollbar which represents the paged data.  It works best with APIs that use random access or "skip/take"  data virtualization strategies.

Both of these models use the existing `QueryCache` and the `MsPortalFx.Data.RemoteDataNavigator` entities to orchestrate virtualization.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

### "Load more" model

The following image depicts a load-more grid with a continuation token.

![alt-text](../media/portalfx-data/loadmore-grid.png "Loadmore Grid with continuation token")

The 'load more' approach requires setting up a `QueryCache` object that uses a navigation element. The navigation element describes the continuation token data model in the sample located at `<dir>\Client\V1\Controls\ProductData.ts` The example is also in the following code.

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

In the `viewModel` for a load-more grid, the code uses the `Pageable` extension for the grid, with the `Sequential` type. Instead of using the `createView` API on the QueryCache, use the `createNavigator` API which integrates with the virtualized data system, as in the sample located at `<dir>\Client\V1\Controls\Grid\ViewModels\PageableGridViewModel.ts`.

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

### Pageable random access grid

![alt-text](../media/portalfx-data/pageable-grid.png "Pageable grid")

The pageable approach requires setting up a `QueryCache` with a navigation element.  The navigation element can access data in an order that is not sequential. This is known as random access, or skip-take behavior, as in the example located at `<dir>\Client\V1\Controls\ProductPageableData.ts`. It is also in the following code.

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

In the ViewMmodel for a random access grid, use the `Pageable` extension for the grid, with the `Pageable` type. Instead of the `createView` API on the QueryCache, use the `createNavigator` API which integrates with the virtualized data system, as in the example located at `<dir>\Client\V1\Controls\Grid\ViewModels\PageableGridViewModel.ts`. It is also in the following code.

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



<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

   
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

### Using the generated models

Make sure that the generated TypeScript files are included in your csproj. The easiest way to include new models in your extension project is to the select the "Show All Files" option in the Solution Explorer of Visual Studio. Right click on the `\Client\_generated` directory in the solution explorer and choose "Include in Project". Inside of the `\Client\_generated` folder you will find a file named by the fully qualified namespace of the interface. In many cases, you'll want to instantiate an instance of the given type. One way to accomplish this is to create a TypeScript class which implements the generated interface. However, this defeats the point of automatically generating the interface. The framework provides a method which allows generating an instance of a given interface:

```ts
MsPortalFx.Data.Metadata.createEmptyObject(SamplesExtension.DataModels.RobotType)
```

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


   ## Best Practices 

### Use QueryCache and EntityCache

When performing data access from your view models, it may be tempting to make data calls directly from the `onInputsSet` function. By using the `QueryCache` and `EntityCache` objects from the `DataCache` class, you can control access to data through a single component. A single ref-counted cache can hold data across your entire extension.  This has the following benefits.

* Reduced memory consumption
* Lazy loading of data
* Less calls out to the network
* Consistent UX for views over the same data.

**NOTE**: Developers should use the `DataCache` objects `QueryCache` and `EntityCache` for data access. These classes provide advanced caching and ref-counting. Internally, these make use of Data.Loader and Data.DataSet (which will be made FX-internal in the future).

To learn more, visit [portalfx-data-caching.md#configuring-the-data-cache](portalfx-data-caching.md#configuring-the-data-cache).



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

The cache objects contain numerous cache entries, each of which are ref-counted based on not-disposed instances of QueryView/EntityView. When a user closes a blade, typically a cache entry in the corresponding cache object will be removed, because all QueryView/EntityView instances will have been disposed. In the scenario where the user revisits the Website blade, the corresponding cache entry will have to be reloaded via an **AJAX** call, and the user will be subjected to loading indicators on the blade and its parts.

With `extendEntryLifetimes`, unreferenced cache entries will be retained for some amount of time, so when a corresponding blade is reopened, data for the blade and its parts will already be loaded and cached.  Here, calls to `this._view.fetch()` from a blade or part `ViewModel` will return a resolved Promise, and the user will not see long-running loading indicators.

**NOTE**:  The time that unreferenced cache entries are retained in QueryCache/EntityCache is controlled centrally by the FX and the timeout will be tuned based on telemetry to maximize cache efficiency across extensions.)

For your scenario to make use of `extendEntryLifetimes`, it is **very important** that you take steps to keep your client-side QueryCache/EntityCache data caches **consistent with server data**.
See [Reflecting server data changes on the client](portalfx-data-configuringdatacache.md) for details.

   ## Frequently asked questions

<a name="working-with-data-data-shaping-"></a>
### 

* * * 
   
   ## Glossary

 This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                 | Meaning |
| ---                  | --- |
| area                 | A project-level folder that is used to organize and partition the source code by categorizing related blades and parts by their data requirements.  |
| ARM | Azure Resource Manager | 
| cache entries | | 
| COGS |   Cost of Goods Sold |
| CORS | Cross-origin resource sharing. A mechanism that defines a way in which a browser and server can interact to determine whether or not it is safe to allow the cross-origin requests to be served.  For example, restricted resources, like  fonts,  may be requested from domains outside the domain from other resources are served. It may use additional HTTP headers to allow users to gain permission to access selected resources from a server on a different origin. | 
| CRUD | Create, Replace, Update, Delete |
| data projection | Combining columns of data in a way that is meaningful to the current topic.  For example, the `county` column may be combined with the `state or province` column to provide a meaningful sort by county. |
| JSON Web Token |  JSON-based token that asserts information between the server and the client.  For example, a JWT could assert that the client user has the claim "logged in as admin".  | 
| JWT token | JSON Web Token |
| lifetime | The amount of time an object exists in memory between instantiation and destruction.  It may be automatically destroyed by when a parent object is deallocated, or its existence may be managed by a lifetime manager object or a child lifetime manager object. |
| lifetime object | An object that informs the `DataCache` when a specific `DataView` is currently being displayed on the screen. This allows the Shell to make performance adjustments. | 
| polling | The process that determines which client-side data should be automatically refreshed. The auto-refreshing of client-side data. |
| perceived responsiveness | Responsiveness that is immediately apparent to an average user. |
| reactor | |
| shaping data | Selecting or combining properties in a `QueryCache` or `EntityCache` to form variables that are a closer match for the intended `ViewModel`.  This differs from filtering in that filtering selects rows in a `QueryCache` instead of columnar values. | 
| subscription | | 