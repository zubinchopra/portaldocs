<a name="consuming-data"></a>
## Consuming data
<a name="using-dataviews"></a>
## Using DataViews

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

The `QueryView` and `EntityView` cache objects both present data from the cache to the `ViewModel`, and provide reference counting. A `DataView` is created from the `createView` method of the cache object that was used, as in the following example.

 The sample  located at `<dir>Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`   demonstrates a `SaveItemCommand` class that uses the binding between a part and a command. This code is also included in the following example.

```ts
this._websitesQueryView = dataContext.masterDetailBrowseSample.websitesQuery.createView(container);
```

In the previous code, the `container` object acts as a lifetime object. Lifetime objects inform the cache when a given view is currently being displayed on the screen. This allows the shell to make several adjustments for performance, including the following.

* Adjust polling interval when the part is not on the screen
* Automatically dispose of data when the blade containing the part is closed

Creating a `DataView` does not result in a data load operation from the server. The server is only queried when the `fetch` operation of the view is invoked, as in the following example.

`<dir>Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`

```ts
public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
    return this._websitesQueryView.fetch({ runningStatus: inputs.filterRunningStatus.value });
}
```

The `runningStatus` is a filter which will be applied to the query. This allows several views to be created over a single cache, each presenting a potentially different data set.

<a name="observable-map-filter"></a>
## Observable map &amp; filter

In many cases, you may want to shape your data to fit the view you are binding to. There are many cases where this is useful:

* Shaping data to match the contract of a control (data points of a chart, for instance)
* Adding a computed property to a model object
* Filtering data on the client based on a property

The recommended approach to these cases is to use the `map` and `filter` methods found in the <a href="https://github.com/stevesanderson/knockout-projections" target="_blank">Knockout projections</a> library, included in the SDK.

See [Shaping and filtering your data](./portalfx-data-projections.md) for more details.

<!--
    Base.Net.Ajax
-->
