
## Master details browse 

Blades can be arranged in a one-to-many relationship, or a summary-detail relationship.  This arrangement can use grids to display information from `QueryCache`-`EntityCache` cache objects as parent-child blades.  The extension retrieves data from the server and displays it across multiple blades, and the data is shared across the parent blade and the child blades.

In this example, the information to display in the parent blade is a list of websites. When the user activates a website, a child blade is opened, and displays detailed information about the activated website. The child blade is also dependent on the parent blade for specific resources.

The `QueryCache` caches a list of items as specified in [portalfx-data-caching.md#the-querycache](portalfx-data-caching.md#the-querycache). The `EntityCache` caches a single item, as specified in [portalfx-data-caching.md#the-entitycache](portalfx-data-caching.md#the-entitycache).

The server data is cached using one of the two cache objects, and then the extension uses that cache to display the websites across the two blades. The data for both blades is located in the same cache, therefore the server is not queried again when it is time to open the second blade. When the data in the cache is updated, the  updated data is displayed across all blades at the same time. Consequently, the Portal always presents a consistent view of the data.

* [Linking the DataContext to the ViewModel](#linking-the-datacontext-to-the-viewmodel)

* [Implementing the master view](#implementing-the-master-view)

* [Implementing the detail view](#implementing-the-detail-view)

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK. 

The code for this example is located at:
`<dir>\Client\V1\MasterDetail\MasterDetailArea.ts`
`<dir>\Client\V1\MasterDetail\MasterDetailBrowse\MasterDetailBrowse.pdl`
`<dir>\Client\V1\Data\MasterDetailBrowse\MasterDetailBrowseData.ts`
`<dir>\Client\V1\asterDetail\MasterDetailBrowse\ViewModels\DetailViewModels.ts`
`<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`

* * * 

### Linking the DataContext to the ViewModel

The Portal uses an `Area` to contain the cache and other data objects that are shared across multiple blades. The code for the area is located in its own folder, as specified in [portalfx-data-overview.md#areas](portalfx-data-overview.md#areas). In this example, the area folder is named `MasterDetail` and it is located in the `Client` folder of the extension.

Inside the folder, there is a **TypeScript** file that contains the `DataContext` class. Its name is a combination of the name of the area and the word 'Area'. The `DataContext` class is the class that will be sent to all the `ViewModels` associated with the area.

For the example, the file is named  `MasterDetailArea.ts` and is located at `<dir>Client/V1/MasterDetail/MasterDetailArea.ts`. This code is also included in the following example.

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailArea.ts", "section": "data#websitesQueryCache"}

If this is a new area for the extension, the developer should edit the `Program.ts` file to create the `DataContext` when the extension is loaded. The SDK edition of the `Program.ts` file is located at `<dir>\Client\Program.ts`. For the extension that is being built, find the `initializeDataContexts` method and then use the `setDataContextFactory` method to set the `DataContext`, as in the following example.

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailArea.ts", "section": "data#createDataContext"}

### Implementing the master view

The master view is used to display the data in the caches. The advantage of using views is that they allow the `QueryCache` to handle the caching, refreshing, and evicting of data.

1. Make sure that the PDL that defines the blades specifies the  `Area` so that the `ViewModels` receive the `DataContext`. In the `<Definition>` tag at the top of the PDL file, include an `Area` attribute whose value corresponds to the name of the area that is being built, as in the example located at `<dir>Client/V1/MasterDetail/MasterDetailBrowse/MasterDetailBrowse.pdl`. This code is also included in the following example.

   {"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailBrowse/MasterDetailBrowse.pdl", "section": "data#pdlArea"} 

    The `ViewModel` for the list of websites is located in `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`. 

1. Create a view on the `QueryCache`, as in the following example.

     {"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailBrowse/ViewModels/MasterViewModels.ts", "section": "data#createView"} 

   The view is the `fetch()` method that is called to populate the `QueryCache`, and allows the items that are returned by the fetch call to be viewed. 

   There are two controls on this blade, both of which use the view that was just created: a grid and the `OptionGroup` control.  

    1. The grid displays the data in the `QueryCache`, as specified in [portalfx-data-dataviews.md](portalfx-data-dataviews.md) and in [#fetching-data-for-the-grid](#fetching-data-for-the-grid).

    1. The `OptionGroup` control allows the user to select whether to display websites that are in a running state, websites in a stopped state or display both types of sites. The display created by the `OptionGroup` control is specified in [#the-optiongroup-control](#the-optiongroup-control).

#### Fetching data for the grid

The observable `items` array of the view is sent to the grid constructor as the `items` parameter, as in the following example.

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailBrowse/ViewModels/MasterViewModels.ts", "section": "data#gridConstructor"}

The `fetch()` command has not yet been issued on the QueryCache. When the command is issued, the view's `items` array will be observably updated, which populates the grid with the results. This occurs by calling the  `fetch()` method on the blade's `onInputsSet()`, which returns the promise shown in the following example.

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailBrowse/ViewModels/MasterViewModels.ts", "section": "data#onInputsSet"}

This will populate the `QueryCache` with items from the server and display them in the grid.

#### The OptionGroup control 

The  control is initialized, and the extension then subscribes to its value property, as in the following example.

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailBrowse/ViewModels/MasterViewModels.ts", "section": "data#optionGroupValueSubscription"}

In the subscription, the extension performs the following actions.

1. Put the grid in a loading mode. It will remain in this mode until all of the data is retrieved.
1. Request the new data by calling the `fetch()` method on the data view with new parameters.
1. When the `fetch()` method completes, take the grid out of loading mode.

There is no need to get the results of the fetch and replace the items in the grid because the grid's `items` array has been pointed to the `items` array of the view. The view will update its `items` array as soon as the fetch is complete.

The rest of the code demonstrates that the grid has been configured to activate any of the websites when they are clicked. The `id` of the website that is activated is sent to the details child blade as an input.  For more information about the details child blade, see [#implementing-the-detail-view](#implementing-the-detail-view).

### Implementing the detail view

The detail view uses the `EntityCache` that was associated with the  `QueryCache` from the `DataContext` to display the details of a website. 

1. The child blade creates a view on the `EntityCache`, as in the following code.

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailBrowse/ViewModels/DetailViewModels.ts", "section": "data#entityCacheView"}

1.  In the `onInputsSet` method, the `fetch` method is called, with the ID of the website to display as a parameter, as in the following example. 

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailBrowse/ViewModels/DetailViewModels.ts", "section": "data#onInputsSet"}

1. When the fetch is completed, the data is available in the view's `item` property. This blade uses the `text` data-binding in its HTML template to show the name, id and running status of the website. 