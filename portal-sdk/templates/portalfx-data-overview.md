## Overview

The Azure Portal UX provides unique data access challenges. Many blades and parts may be displayed at the same time, each of which instantiates a new `ViewModel` instance. Each `ViewModel` often needs access to the same or related data. To optimize for these interesting data-access patterns, extensions follow specific patterns that consist of  code organization and data management.

The following sections discuss these patterns and how to apply them to an extension.

* **Code organization**

    * Organizing the extension source code into [areas](#areas)
    
* **Data management**

    * Shared data access using [data contexts](#data-contexts)

    * Using [data caches](#data-caches) to load and cache data

    * Memory management with [data views](#data-views)

All of these data concepts are used to achieve the goals of loading and updating extension data, in addition to efficient  memory  management. For more information about how the pieces fit together and how the resulting construct relates to the conventional MVVM pattern, see the [Data Architecture](https://auxdocs.blob.core.windows.net/media/DataArchitecture.pptx) video that discusses extension blades and parts.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

### Areas

From the perspective of code organization, an area can be defined as a project-level folder. It is of great assistance when data operations are segmented within the extension.

`Areas` are a scheme for organizing and partitioning the source code of the extension. This makes it easier for teams to develop an extension in parallel. Areas help categorize related blades and parts, and each area also maintains the data that is required by its blades and parts.

Every area within an extension gets a distinct `DataContext` singleton, and it loads/caches/updates the data of the model types necessary to support the area's blades and parts.

An area is defined in the extension by using the following steps.

  1. Create a folder in the `Client\` directory of the project that contains the extension. The name of that folder is the name of the area.

  1. In the root of that folder, create a `DataContext` named `<AreaName>Area.ts`, where `<AreaName>` is the name of the folder that was just created, as specified in [#developing-a-datacontext-for-an-area](#developing-a-datacontext-for-an-area). For example, the `DataContext` for the `Security` area in the sample is located at `\Client\Security\SecurityArea.ts`.  

A typical extension resembles the following image.

![alt-text](../media/portalfx-data-context/area.png "Extensions can host multiple areas")

### Data contexts

For each area in an extension, there is a singleton `DataContext` instance that supports access to shared data for the blades and parts implemented in that area. Access to shared data means data loading, caching, refreshing and updating. Whenever multiple blades and parts make use of common server data, the `DataContext` is an ideal place to locate data loading/updating logic for an extension [area](portalfx-extensions-glossary-data.md).

When a blade or part `ViewModel` is instantiated, its constructor is sent a reference to the `DataContext` singleton instance for the associated extension area.  In the blade or part `ViewModel` constructor, the `ViewModel` accesses the data required by that blade or part, as in the code located at `<dir>/Client/V1/MasterDetail/MasterDetailEdit/ViewModels/MasterViewModels.ts`.

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailEdit/ViewModels/MasterViewModels.ts","section":"data-overview#data-context-ctor-use"}

The benefits of centralizing data access in a singleton `DataContext` include the following.

* Caching and Sharing

  The `DataContext` singleton instance will exist for the entire amount of time that the extension is loaded in the browser. Consequently, when a blade is opened, and therefore a new blade `ViewModel` is instantiated, data required by the new blade will often already be loaded and cached in the `DataContext`, as required by some previously opened blade or rendered part.
  
  Not only will this cached data be available immediately,  which optimizes rendering performance and improves perceived responsiveness, but also no new **AJAX** calls are necessary to load the data for the newly-opened blade, which reduces server load and Cost of Goods Sold (COGS).

* Consistency
  
  It is very common for multiple blades and parts to render the same data in levels of different detail, or with different presentation. Moreover, there are situations where such blades or parts are displayed on the screen at the same time, or separated in time only by a single user navigation. 

  In such cases, the user expects to see all the blades and parts depicting the exact same state of the user's data. An effective way to achieve this consistency is to load only a single copy of the data, which is what `DataContext` is designed to do.

* Fresh data

  Users expect to see data that always reflects the current state of their data in the cloud, which is neither stale nor out-of-date. Another benefit of loading and caching data in a single location is that the cached data can be regularly updated to accurately reflect the state of server data. 

  For more information on refreshing data, see [portalfx-data-refreshingdata.md](portalfx-data-refreshingdata.md).

### Data caches
 
  The `DataCache` classes are a full-featured and convenient way to load and cache data required by blade and part `ViewModels`. The   `DataCache` class objects in the API are `QueryCache`, `EntityCache` and the `EditScopeCache`. For more information about  `DataCache` classes, see [portalfx-data-caching.md](portalfx-data-caching.md). 

* **CRUD methods**

  The CRUD methods are Create, Replace, Update, and Delete. Commands for  blades and parts often use these methods to modify server data. These commands should be implemented in methods on the `DataContext` class, where each method can issue **AJAX** calls and reflect server changes in associated DataCaches.

* **QueryCache**

  Loads data of type `Array<T>` according to an extension-specified `TQuery` type. `QueryCache` is useful for loading data for list-like views like Grid, List, Tree, or Chart.

The `DataCache` classes all share the same API. The usage pattern is as follows.

1.  In a `DataContext`, the extension creates and configures `DataCache` instances, as specified in [portalfx-data-caching.md](portalfx-data-caching.md). Configuration includes the following.  

    * How to load data when it is missing from the cache
    * How to implicitly refresh cached data, to keep it consistent with server state

     {"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Data/MasterDetailBrowse/MasterDetailBrowseData.ts", "section": "data-overview#create-data-cache"} 

1. In its constructor, each blade and part `ViewModel` creates a `DataView` with which to load and refresh data for the blade or part.

    {"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailBrowse/ViewModels/DetailViewModels.ts", "section": "data#entityCacheView"}

1. When the blade or part ViewModel receives its parameters in the `onInputsSet` method, the ViewModel calls the  `dataView.fetch()` method to load data.

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailBrowse/ViewModels/MasterViewModels.ts", "section": "data#onInputsSet"}
  
For more information about employing these concepts, see [portalfx-data-masterdetailsbrowse.md](portalfx-data-masterdetailsbrowse.md).

### Data views

Memory management is very important in the Azure Portal, because overuse of memory by many different extensions may impact responsiveness.

Each `DataCache` instance manages a set of [cache entries](portalfx-extensions-glossary-data.md), and the `DataCache` includes automatic mechanisms to manage the number of cache entries present at any given time. This is important because `DataCaches` in the `DataContext` of an `area` will exist in memory for as long as an extension is loaded, and consequently may support blades and parts that come and go as the user navigates in the Azure Portal.  

When a `ViewModel` calls the `fetch()` method for its `DataView`, this `fetch()` call implicitly forms a ref-count to a `DataCache` cache entry, thereby pinning the entry in the DataCache as long as the blade/part `ViewModel` has not been  disposed by the extension. When all blade or part `ViewModels` that hold ref-counts to the same cache entry are disposed indirectly by using via DataView,  the DataCache can elect to evict or discard the cache entry. In this way, the `DataCache` can manage its size automatically, without explicit extension code.





### Developing a DataContext for an area

Typically, the `DataContext` associated with a particular area is instantiated from the `initialize()` method of `<dir>\Client\Program.ts`, which is the entry point of the extension.

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/Program.ts", "section": "data#createDataContext"}

There is a single `DataContext` class per area. That class is named `[AreaName]Area.ts`, as in the code located at  `<dir>\Client\V1\MasterDetail\MasterDetailArea.ts`.

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailArea.ts", "section": "data#dataContextMembers"}

The `DataContext` class does not specify the use of any single FX base class or interface. In practice, the members of a DataContext class typically include [data caches](#data-caches) and [data views](#data-views).