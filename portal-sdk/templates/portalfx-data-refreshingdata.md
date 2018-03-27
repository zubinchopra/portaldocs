
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

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts", "section": "dataRefresh#poll"}

Additionally, the extension can customize the polling interval by using the `pollingInterval` option. By default, the polling interval is 60 seconds. It can be customized to a minimum of 10 seconds. The minimum is enforced to avoid the server load that can result from inaccurate changes.  However, there have been instances when this 10-second minimum has caused negative customer impact because of the increased server load.

### The explicit refresh

When server data changes, the extension should take steps to keep the cache object data consistent with the server. In these instances, explicit refreshing of a cache object is necessary, for example, when the extension issues an AJAX call that changes server data. There are methods that explicitly and proactively reflect server data changes on the client.

**NOTE**: Issuing this **AJAX** call from an extension `DataContext` is best practice.

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts","section":"dataRefresh#refreshFromDataContext"}

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

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/ResourceTypes/SparkPlug/SparkPlugData.ts","section":"dataRefresh#dataCacheRefresh"}

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/ResourceTypes/SparkPlug/SparkPlugData.ts","section":"dataRefresh#dataCacheRefreshCalled"}

#### The refreshAll method
  
The `refreshAll` method issues N AJAX calls, one for each entry that is currently in the cache object.  The AJAX call is issued using either the `supplyData` or `uri` option supplied to the cache object. Upon completion, each AJAX result is merged onto its corresponding cache entry, as in the following example.

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts","section":"dataRefresh#refreshFromDataContext"}

If the optional `predicate` parameter is supplied to the `refreshAll` call, then only those entries for which the predicate returns `true` will be refreshed.  This feature is useful when the extension is aware of server data changes and therefore does not refresh cache object entries whose server data has not changed.

#### The applyChanges method

The `applyChanges` method is used in instances where the data may have already been cached. For instance, the user may have fully described the server data changes by filling out a Form on a Form Blade. In this case, the necessary cache object changes are known by the extension directly, as in the following examples.

* Adding an item to a QueryCache entry

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts","section":"dataRefresh#applyChanges1"}

* Removing an item to a QueryCache entry

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts","section":"dataRefresh#applyChanges2"}

The `applyChanges` method accepts a function that is called for each cache entry currently in the cache object. This allows the extension to update only those cache entries that were impacted by the  changes made by the user.  This use of `applyChanges` can be a nice optimization to avoid some AJAX traffic to your servers.  When it is appropriate to write the data changes to the server, an extension would use the `refreshAll` method after the code that uses the  `applyChanges` method.
  
#### The forceRemove method
  
Cache objects in the `DataCache` class can contain cache entries for some time after the last blade or part has been closed or unpinned. This separates the cached data from the data view, and supports the scenario where a user closes a blade and immediately reopens it.

Now, when the server data for a given cache entry is entirely deleted, then the extension will forcibly remove corresponding entries from their `QueryCache` (less common) and `EntityCache` (more common). The `forceRemove` method does just this, as in the following example. 

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/ComputerData.ts","section":"dataRefresh#forceRemove"}

Once called, the corresponding cache entry will be removed. If the user were to open a Blade or drag/drop a Part that tried to load the deleted data, the cache objects would try to create an entirely new cache entry, and the extension would fail to load the corresponding server data. In such a case, by design, the user would see a 'data not found' notification in that blade or part.

Typically, when using the `forceRemove` method, the extension will take steps to ensure that existing Blades/Parts are no longer accessing the removed cache entry in the `QueryView` or `EntityView` methods. When the extension notifies the Portal of a deleted ARM resource by using the `MsPortalFx.UI.AssetManager.notifyAssetDeleted()` method, as specified in [portalfx-assets.md](portalfx-assets.md), the Portal will automatically display 'deleted' in the UX in any corresponding blades or parts. If the user clicked on a 'Delete'-style command on a Blade to trigger the `forceRemove`, often the extension will programmatically close the Blade in addition to making associated AJAX and `forceRemove` calls from its `DataContext`.
  
## Refreshing a QueryView or EntityView

In some blades or parts, there can be a specific `Refresh` command that refreshes only the data that is visible in the specified blade or part. In this scenario, it is the `QueryView/EntityView` that serves as a reference pointer to that Blade/Part's data, and it's with that QueryView/EntityView that the extension should refresh the data.  (See a sample [here](#refresh-dataview-sample)).  

When `refresh` is called, a Promise is returned that reflects the progress/completion of the corresponding AJAX call. In addition, the `isLoading` observable property of QueryView/EntityView also changes to 'true' (useful for controlling UI indications that the refresh is in progress, like temporarily disabling the clicked 'Refresh' command).  

At the cache object level, in response to the QueryView/EntityView `refresh` call, an AJAX call will be issued for the corresponding cache entry, precisely in the same manner that would happen if the extension called the cache object's `refresh` method with the associated cache key (see [#the-refresh-method](#the-refresh-method)).  

#### QueryView/EntityView `refresh` **caveat**  

There is one subtety to the '`refresh`' method available on QueryView/EntityView that sometimes trips up extension developers. You will notice that '`refresh`' accepts no parameters. This is because '`refresh`' was designed to refresh *previously-loaded data*. An initial call to QueryView/EntityView's '`fetch`' method establishes a cache entry in the corresponding cache object that includes the URL information with which to issue an AJAX call when '`refresh`' is later called.  

Sometimes, extensions developers feel it is important - when a Blade opens or a Part is first displayed - to implicitly refresh the Blade's/Part's data (in cases where the data may have previously been loaded/cached for use in some previously viewed Blade/Part). To make this so, they'll sometimes call QueryView/EntityView's '`fetch`' and '`refresh`' methods in succession. This is a minor anti-pattern that should probably be avoided. This "refresh my data on Blade open" pattern trains the user to open Blades to fix stale data (even close and then immediately reopen the same Blade) and can often be a symptom of a missing 'Refresh' command or [auto-refreshing data](#the-implicit-refresh) that's configured with too long a polling interval.