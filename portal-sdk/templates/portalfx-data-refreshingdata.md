
## Refreshing cached data

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

### The implicit refresh 

### Polling

In many scenarios, users expect to see their rendered data update implicitly when server data changes. The auto-refreshing of client-side data, also known as  'polling', can be accomplished by configuring the cache object to include 'polling', as in the example located at `<dir>\Client\V1\Hubs\RobotData.ts`. This code is also included in the following example.

{"gitdown": "include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts","section":"dataRefresh#poll"}

Additionally, the extension can customize the polling interval by using the `pollingInterval` option. By default, the polling interval is 60 seconds. It can be customized to a minimum of 10 seconds. The minimum is enforced to avoid the server load that can result from inaccurate changes.  However, there have been instances when this 10-second minimum has caused negative customer impact because of the increased server load.

## Data merging

For the Azure Portal UI to be responsive, it is important to avoid re-rendering entire blades and parts when data changes. Instead, it is better to make granular data changes so that FX controls and **Knockout** HTML templates can re-render small portions of the Blade/Part UI. In many cases when data is refreshed, the newly-loaded server data precisely matches previously-cached data, and therefore there is no need to re-render the UI.

When cache object data is refreshed - either implicitly as specified in [#the-implicit-refresh](#the-implicit-refresh),  or explicitly as specified in  [#the-explicit-refresh](#the-explicit-refresh) - the newly-loaded server data is added to previously-cached, client-side data through a process called "data merging". The data merging process is as follows.

1. The newly-loaded server data is compared to previously-cached data
1. Differences between newly-loaded and previously-cached data are detected. For instance, "property <X> on object <Y> changed value" and "the Nth item in array <Z> was removed".
1. The differences are applied to the previously-cached data, via changes to Knockout observables.

### Data merging caveats 

For many scenarios, data merging requires no configuration because it is an implementation detail of implicit and explicit refreshed. However, in some scenarios, there are gotcha's to look out for.

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

#### Data merge failures

As "data merging" proceeds, differences are applied to the previously-cached data via Knockout observable changes. When these observables are changed, Knockout subscriptions are notified and Knockout `reactors` and `computeds` are reevaluated. Any associated (often extension-authored) callback here **can throw an exception** and this will halt/preempt the current "data merge" cycle. When this happens, the "data merging" algorithm issues an error resembling:

```
Data merge failed for data set 'FooBarDataSet'. The error message was: ...
```

Importantly, this error is not due to bugs in the data-merging algorithm. Rather, some JavaScript code (frequently extension code) is causing an exception to be thrown. This error should be accompanied with a JavaScript stack trace that extension developers can use to isolate and fix such bugs.  

#### EntityView `item` observable doesn't change on refresh?  

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

### The explicit refresh

## Explicitly/proactively reflecting server data changes on the client

As server data changes, there are scenarios where the extension should take explicit steps to keep their cache object data consistent with the server. In terms of UX, explicit refreshing of a cache object is necessary in scenarios like the following. 

* **User makes server changes** - User initiates some action and, as a consequence, the extension issues an AJAX call that changes server data. As a best-practice, this AJAX call is typically issued from an extension DataContext.

<!--
gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts","section":"dataRefresh#refreshFromDataContext"}
-->

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
### Refreshing or updating a data cache

There are a number of methods available on cache objects in the `DataCache` class  that make it straightforward and efficient to keep client-side cached data consistent with server data. Which of these is appropriate varies by scenario, and these are discussed individually below.  
To understand the design behind this collection of methods and how to select the appropriate method to use, it's important to understand a bit about the DataCache/DataView design (in detail [here](portalfx-data-configuringdatacache.md)). Specifically, the cache objects are  a collection of cache entries. In some cases, where there are multiple active Blades and Parts, a specific cache object might contain many cache entries. So, below, you'll see `refreshAll` - which issues N AJAX calls to refresh all N entries of a cache object - as well as alternative, per-cache-entry methods that allow for more granular, often more efficient refreshing of cache object data.

#### `refreshAll`
  
As mentioned above, this method will issue an AJAX call (either using the `supplyData` or `sourceUri`'option supplied to the cache object) for each entry currently held in the cache object.  Upon completion, each AJAX result is [merged](#data-merging) onto its corresponding cache entry, as in the following example.

<!-->
gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts","section":"dataRefresh#refreshFromDataContext"}
-->

If the (optional) `predicate` parameter is supplied to the `refreshAll` call, then only those entries for which the predicate returns 'true' will be refreshed.  This `predicate` feature is useful when the extension understands the nature of the server data changes and can - based on this knowledge - choose to not refresh cache object entries whose server data has not changed.


#### `refresh` method
  
The `refresh` method is useful when the server data changes are known to be specific to a single cache entry.  This is a single query in the case of `QueryCache`, and it is a single entity `id` in the case of `EntityCache`.

<!--
gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/ResourceTypes/SparkPlug/SparkPlugData.ts","section":"dataRefresh#dataCacheRefresh"}

gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/ResourceTypes/SparkPlug/SparkPlugData.ts","section":"dataRefresh#dataCacheRefreshCalled"}
-->

Using `refresh`, only a single AJAX call will be issued to the server.

#### '`applyChanges`'

In some scenarios, AJAX calls to the server to refresh cached data can be *avoided entirely*. For instance, the user may have fully described the server data changes by filling out a Form on a Form Blade. In this case, the necessary cache object changes are known by the extension directly without having to make an AJAX call to their server. This use of `applyChanges` can be a nice optimization to avoid some AJAX traffic to your servers.

**Example - Adding an item to a QueryCache entry**

<!--
gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts","section":"dataRefresh#applyChanges1"}

-->

**Example - Removing an item to a QueryCache entry**

<!--
gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/RobotData.ts","section":"dataRefresh#applyChanges2"}
-->

Similar to '`refreshAll`', the '`applyChanges`' method accepts a function that is called for each cache entry currently in the cache object, whgch allows the extension to update only those cache entries known to be impacted by the server changes made by the user.
  
#### `forceRemove`
  
A subtlety of the cache objects in the DataCache class is that they can contain cache entries for some time after the last blade or part has been closed or unpinned. This supports the scenario where a user closes a Blade (for instance) and immediately reopens it.  

Now, when the server data for a given cache entry has been entirely deleted, then the extension will forcibly remove corresponding entries from their QueryCache (less common) and EntityCache (more common). The '`forceRemove`' method does just this, as in the following example. 

<!-->
gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs/ComputerData.ts","section":"dataRefresh#forceRemove"}
-->

Once called, the corresponding cache entry will be removed. If the user were to - somehow - open a Blade or drag/drop a Part that tried to load the deleted data, the cache objects would try to create an entirely new cache entry, and - presumably - it would fail to load the corresponding server data. In such a case, by design, the user would see a 'data not found' user experience in that Blade/Part.

When using '`forceRemove`', the extension will also - typically - want to take steps to ensure that any existing Blades/Parts are no longer making use of the removed cache entry (via QueryView/EntityView). When the extension notifies the FX of a deleted ARM resource via '`MsPortalFx.UI.AssetManager.notifyAssetDeleted()`' (see [here](portalfx-assets.md) for details), the FX will automatically show 'deleted' UX in any corresponding Blades/Parts. If the user clicked some 'Delete'-style command on a Blade to trigger the '`forceRemove`', often the extension will elect to *programmatically close the Blade* with the 'Delete' command (in addition to making associated AJAX and '`forceRemove`' calls from their DataContext).
  
<a name="refresh-dataview"></a>
### Refreshing a **QueryView/EntityView**  

In some Blades/Parts, there can be a specific 'Refresh' command that is meant to refresh only that data visible in the given Blade/Part. In this scenario, it is the QueryView/EntityView that serves as a reference/pointer to that Blade/Part's data, and it's with that QueryView/EntityView that the extension should refresh the data.  (See a sample [here](#refresh-dataview-sample)).  

When `refresh` is called, a Promise is returned that reflects the progress/completion of the corresponding AJAX call. In addition, the '`isLoading`' observable property of QueryView/EntityView also changes to 'true' (useful for controlling UI indications that the refresh is in progress, like temporarily disabling the clicked 'Refresh' command).  

At the cache object level, in response to the QueryView/EntityView '`refresh`' call, an AJAX call will be issued for the corresponding cache entry, precisely in the same manner that would happen if the extension called the cache object's `refresh` method with the associated cache key (see [here](#refresh-datacache-refresh)).  

#### QueryView/EntityView '`refresh`' **caveat**  

There is one subtety to the '`refresh`' method available on QueryView/EntityView that sometimes trips up extension developers. You will notice that '`refresh`' accepts no parameters. This is because '`refresh`' was designed to refresh *previously-loaded data*. An initial call to QueryView/EntityView's '`fetch`' method establishes a cache entry in the corresponding cache object that includes the URL information with which to issue an AJAX call when '`refresh`' is later called.  

Sometimes, extensions developers feel it is important - when a Blade opens or a Part is first displayed - to implicitly refresh the Blade's/Part's data (in cases where the data may have previously been loaded/cached for use in some previously viewed Blade/Part). To make this so, they'll sometimes call QueryView/EntityView's '`fetch`' and '`refresh`' methods in succession. This is a minor anti-pattern that should probably be avoided. This "refresh my data on Blade open" pattern trains the user to open Blades to fix stale data (even close and then immediately reopen the same Blade) and can often be a symptom of a missing 'Refresh' command or [auto-refreshing data](#the-implicit-refresh) that's configured with too long a polling interval.  
