
<a name="master-details-browse"></a>
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


<a name="master-details-browse-the-masterdetail-area-and-datacontext"></a>
### The MasterDetail Area and DataContext

The Portal uses an `Area` to hold the cache and other data objects that are shared across multiple blades. The code for the area is located in its own folder, as specified in [portalfx-data-overview.md#areas](portalfx-data-overview.md#areas). In this example, the area folder is named `MasterDetail` and it is located in the `Client` folder of the extension. 

 Inside the folder, there is a TypeSscript file whose name is a combination of the name of the area and the word 'Area'. The file is named  `MasterDetailArea.ts` and is located at `<dir>Client/V1/MasterDetail/MasterDetailArea.ts`. This code is also included in the following example.

<!-- 
gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/MasterDetail/MasterDetailArea.ts", "section": "data#websitesQueryCache"}
-->

This file contains the `DataContext` class, which is the class that will be sent to all the `ViewModels` associated with the area.  The `DataContext` also contains an `EditScopeCache` which is used in the master detail edit scenario that is located at [portalfx-forms-construction.md](portalfx-forms-construction.md). This code is also included in the following example.

 <!--TODO:  Locate the gitHub copies of the samples. -->

<!-- determine whether an "as specified in portalfx-forms-editscope*" is relevant here.  -->

If this is a new area for the extension, edit the  `Program.ts` file to create the `DataContext` when the extension is loaded. The SDK edition of the `Program.ts` file is located at `<dir>\Client\Program.ts`. For the extension that is being built, find the `initializeDataContexts` method and then use the `setDataContextFactory` method to set the `DataContext`.

<a name="master-details-browse-implementing-the-master-view"></a>
### Implementing the master view

The master view is used to display the data in the caches. The advantage of using views is that they allow the `QueryCache` to handle the caching, refreshing, and evicting of data.

1. Make sure that the PDL that defines the blades specifies the  `Area` so that the `ViewModels` receive the `DataContext`. In the `<Definition>` tag at the top of the PDL file, include an `Area` attribute whose value corresponds to the name of the area that is being built, as in the example located at `<dir>Client/V1/MasterDetail/MasterDetailBrowse/MasterDetailBrowse.pdl`. This code is also included in the following example.

    <!--```xml

<Definition xmlns="http://schemas.microsoft.com/aux/2013/pdl"
Area="V1/MasterDetail">

``` -->

    The `ViewModel` for the list of websites is located in `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`. 

1. Create a view on the `QueryCache`, as in the following example.

    <!-- ```typescript

this._websitesQueryView = dataContext.websitesQuery.createView(container);

``` -->

   The view is the `fetch()` method that is called to populate the `QueryCache`, and allows the items that are returned by the fetch call to be viewed. 

   **NOTE**:  There may be multiple views over the same `QueryCache`. This  occurs when multiple blades are displayed on the screen at the same time, all of which are using data from the same cache. 

   There are two controls on this blade, both of which use the view that was just created: a grid and the `OptionGroup` control.  

   * The grid displays the data in the `QueryCache`, as specified in [portalfx-data-dataviews.md](portalfx-data-dataviews.md) and in [#fetching-data-for-the-grid](#fetching-data-for-the-grid).

   * The `OptionGroup` control allows the user to select whether to display websites that are in a running state, websites in a stopped state or display both types of sites. The display created by the `OptionGroup` control is specified in [#the-optiongroup-control](#the-optiongroup-control).

<a name="master-details-browse-implementing-the-master-view-fetching-data-for-the-grid"></a>
#### Fetching data for the grid

The observable `items` array of the view is sent to the grid constructor as the `items` parameter, as in the following example.

<!--
```typescript

this.grid = new Grid.ViewModel<WebsiteModel, number>(this._lifetime, this._websitesQueryView.items, extensions, extensionsOptions);

```
-->

The `fetch()` command has not yet been issued on the QueryCache. When the command is issued, the view's `items` array will be observably updated, which populates the grid with the results. This occurs by calling the  `fetch()` method on the blade's `onInputsSet()`, which returns the promise shown in the following example.

<!--
```typescript

/**
 * Invoked when the blade's inputs change
 */   
public onInputsSet(inputs: Def.BrowseMasterListViewModel.InputsContract): MsPortalFx.Base.Promise {
    return this._websitesQueryView.fetch({ runningStatus: this.runningStatus.value() });
}

```
-->

This will populate the `QueryCache` with items from the server and display them in the grid.

<a name="master-details-browse-implementing-the-master-view-the-optiongroup-control"></a>
#### The OptionGroup control

The  control is initialized, and the extension then subscribes to its value property, as in the following example.

<!-- ```typescript

this.runningStatus.value.subscribe(this._lifetime, (newValue) => {
    this.grid.loading(true);
    this._websitesQueryView.fetch({ runningStatus: newValue })
        .finally(() => {
            this.grid.loading(false);
        });
});

``` -->

In the subscription, the extension performs the following actions.

1. Put the grid in a loading mode. It will remain in this mode until all of the data is retrieved.
1. Request the new data by calling the `fetch()` method on the data view with new parameters.
1. When the `fetch()` method completes, take the grid out of loading mode.

There is no need to get the results of the fetch and replace the items in the grid because the grid's `items` array has been pointed to the `items` array of the view. The view will update its `items` array as soon as the fetch is complete.

The rest of the code demonstrates that the grid has been configured to activate any of the websites when they are clicked. The `id` of the website that is activated is sent to the details child blade as an input.  For more information about the details child blade, see [#implementing-the-detail-view](#implementing-the-detail-view).

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