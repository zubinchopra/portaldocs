
<a name="performance"></a>
# Performance


<a name="performance-overview"></a>
## Overview

Portal performance is defined as all experiences throughout the product. 
All extensions need to meet the performance bar at a minimum.

| Area      | Sub-Area                   | 80th Percentile Bar | Telemetry Action         | How is it measured? |
| --------- | -------------------------- | ------------------- | ------------------------ | ------------------- |
| Blade     | Revealed                   | See Power BI        | BladeRevealed            | Time it takes for the blade's OnInputsSet to resolve and all the parts on the blade and above the fold to reveal |
| Blade     | FullRevealed               | N/A                 | BladeFullRevealed        | Same as Revealed but all the parts on the blade to reveal |
| Part      | Revealed                   | See Power BI        | PartRevealed             | Time it takes for the part to be rendered and then the part's OnInputsSet to resolve or earlyReveal to be called |
| WxP       | N/A                        | See Power BI        | N/A                      | An overall experience score, calculated by weighting blade usage and the blade revealed time |

<!--| Extension | Initial Extension Response | TODO                | InitialExtensionResponse | TODO |
| Extension | Manifest Load              | TODO                | ManifestLoad             | TODO |
| Extension | Initialization             | TODO                | InitializeExtensions     | TODO | -->

<a name="performance-extension-performance"></a>
## Extension performance

Extension performance is impacted by both Blade and Part performance, when the extension is loaded, when it is unloaded, and when it is required.

When a user visits a resource blade for the first time, the Portal  loads the extension and then requests the ViewModel.  This makes the Blade/Part performance happen.

If the user were to browse away from the UI experience and browse back previous to the unloading of the  extension, the second visit is faster because the UI does not have to re-load all of the extension.

<a name="performance-blade-performance"></a>
## Blade performance

Blade performance is centered around specific areas that are encapsulated under the `BladeRevealed` action. They are as follows.


1. The constructor
1. The call to the `OnInputsSet` method
1. Displaying parts within the blade


<a name="performance-part-performance"></a>
## Part performance

Part performance is centered around specific areas that are encapsulated under the `PartRevealed` action. They are as follows.

1. The constructor
1. The call to the `OnInputsSet` method

<a name="performance-wxp-score"></a>
## WxP score

The WxP score is a per-extension Weight eXPerience score (WxP). It is calculated as follows:

```txt

WxP = (BladeViewsMeetingTheBar * 80thPercentileBar) / ((BladeViewsMeetingTheBar * 80thPercentileBar) + ∑(BladeViewsNotMeetingTheBar * ActualLoadTimePerBlade))

```

| Blade   | 80th Percentile Times | Usage Count | Meets 80th Percentile Bar? |
| ------- | --------------------- | ----------- | -------------------------- |
| Blade A | 1.2                   | 1000        | Yes                        |
| Blade B | 5                     | 500         | No                         |
| Blade C | 6                     | 400         | No                         |

```txt

WxP = (BladeViewsMeetingTheBar * 80thPercentileBar) / ((BladeViewsMeetingTheBar * 80thPercentileBar) + ∑(BladeViewsNotMeetingTheBar * ActualLoadTimePerBlade)) %    = (4 * 1000) / ((4 * 1000) + ((5 * 500) + (6 * 400))) %
    = 44.94%

```

The model gives a negative score to  the  views that do not meet the bar. 

<a name="performance-assessing-blade-performance"></a>
## Assessing blade performance

There are two methods that are used to assess the performance of an extension. 

1. Visit the PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf).

1. Run local Kusto queries to determine the numbers that are associated with extension performance.

The PowerBi dashboard is maintained on a regular basis by the Fx team. If you choose to run local queries, make sure that you use the Fx provided Kusto functions to calculate the assessment.

<a name="performance-topics-that-improve-blade-performance"></a>
## Topics that Improve Blade Performance

The following table contains documents that are related to improving the perfomance of an extension.

| Name | Purpose | 
| ---- | ----- | 
| [portalfx-cdn.md](portalfx-cdn.md) | Content Delivery Network   | 
| [portalfx-extension-homepage-caching.md](portalfx-extension-homepage-caching.md) | Caching  |
| [portalfx-extension-persistent-caching-of-scripts.md](portalfx-extension-persistent-caching-of-scripts.md)  |  Persistent Caching of scripts across extension updates |
| [portalfx-performance-portalcop.md](portalfx-performance-portalcop.md) |  Identify and resolve common performance issues |
| [portalfx-data-loadingdata.md#loading-data-optimize-number-cors-preflight-requests-to-arm-using-invokeapi.md](portalfx-data-loadingdata.md#loading-data-optimize-number-cors-preflight-requests-to-arm-using-invokeapi.md)  | Optimize CORS preflight requests |
| [portalfx-parts-revealContent.md](portalfx-parts-revealContent.md) | Improve part responsiveness with revealContent |
   
 
<a name="performance-best-practices"></a>
## Best Practices

<a name="performance-best-practices-writing-fast-extensions"></a>
### Writing fast extensions

When writing extensions, there are a few patterns you can follow to make sure you're getting the most performance out
the browser and the portal.

<a name="performance-best-practices-writing-fast-extensions-use-amd"></a>
#### Use AMD

In the early days of the Azure Portal SDK, it was common to write extensions that bundled all scripts into a single file at
compilation time. This generally happens if you use reference statements in your classes:

<a name="performance-best-practices-writing-fast-extensions-use-amd-deprecated-synatx"></a>
##### [DEPRECATED SYNATX]

```ts

/// <reference path="../TypeReferences.d.ts" />
/// <reference path="WebsiteSelection.ts" />
/// <reference path="../Models/Website.ts" />
/// <reference path="../DataContexts/DataContexts.ts" />

module RemoteExtension {
    export class WebsitesBladeViewModel extends MsPortalFx.ViewModels.Blade {
    ...
    }
}

```

In the example above, modules are imported using `<reference>` elements.
This includes those scripts into a single script file at compile time, leading to a relatively large file which needs to be downloaded
every time your extension projects UI.

Since that time, we've introduced support for using [Asynchronous Module Definition (AMD)](http://requirejs.org/docs/whyamd.html).
Instead of bundling all scripts into a single monolithic file, the portal is now capable of downloading only the files needed to
project the current UI onto the screen. This makes it faster to unload and reload an extension, and provides for generally better
performance in the browser.  In this case, by using AMD, the following files will only be loaded at runtime as they're required
(instead of one large bundle):

<a name="performance-best-practices-writing-fast-extensions-use-amd-correct-synatx"></a>
##### [CORRECT SYNATX]

```ts

import SecurityArea = require("../SecurityArea");
import ClientResources = require("ClientResources");
import Svg = require("../../_generated/Svg");

export class BladeViewModel extends MsPortalFx.ViewModels.Blade {
    ...
}

```

This leads to faster load time, and less memory consumption in the browser. You can learn more about the TypeScript module loading
system in the [official language specification](http://www.typescriptlang.org/docs/handbook/modules.html).

<!--TODO: Deprecate the following section. It has been replaced by portalfx-extensions-bp-data.md -->
<!-- TODO:  If this section is not to be deprecated, add a link to it-->

<a name="performance-best-practices-writing-fast-extensions-use-querycache-and-entitycache"></a>
#### Use QueryCache and EntityCache

When performing data access from your view models, it may be tempting to make data calls directly from the `onInputsSet` function. By using the `QueryCache` and `EntityCache` objects from the `DataCache` class, you can control access to data through a single component. A single ref-counted cache can hold data across your entire extension.  This has the following benefits.

* Reduced memory consumption
* Lazy loading of data
* Less calls out to the network
* Consistent UX for views over the same data.

**NOTE**: Developers should use the `DataCache` objects `QueryCache` and `EntityCache` for data access. These classes provide advanced caching and ref-counting. Internally, these make use of Data.Loader and Data.DataSet (which will be made FX-internal in the future).

To learn more, visit [portalfx-data-caching.md#configuring-the-data-cache](portalfx-data-caching.md#configuring-the-data-cache).

<a name="performance-best-practices-writing-fast-extensions-avoid-unnecessary-data-reloading"></a>
#### Avoid unnecessary data reloading

As users navigate through the Ibiza UX, they will frequently revisit often-used resources within a short period of time.
They might visit their favorite Website Blade, browse to see their Subscription details, and then return to configure/monitor their
favorite Website. In such scenarios, ideally, the user would not have to wait through loading indicators while Website data reloads.
<>
To optimize for this scenario, use the `extendEntryLifetimes` option common to QueryCache and EntityCache.

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

Cache objects contain numerous cache entries, each of which are ref-counted based on not-disposed instances of QueryView/EntityView. When a user closes a Blade, typically a cache entry in the corresponding cache object  will be removed,
since all QueryView/EntityView instances will have been disposed. In the scenario where the user *revisits* their Website Blade,
the corresponding cache entry will have to be reloaded via an ajax call, and the user will be subjected to loading indicators on
the Blade and its Parts.

With `extendEntryLifetimes`, unreferenced cache entries will be *retained for some amount of time*, so when a corresponding Blade
is reopened, data for the Blade and its Parts will already be loaded and cached.  Here, calls to `this._view.fetch()` from a Blade
or Part view model will return a resolved Promise, and the user will not see long-running loading indicators.

(Note - The time that unreferenced cache entries are retained in QueryCache/EntityCache is controlled centrally by the FX
 and the timeout will be tuned based on telemetry to maximize cache efficiency across extensions.)

For your scenario to make use of `extendEntryLifetimes`, it is **very important** that you take steps to keep the client-side cache objects data caches **consistent with server data**.
See [Reflecting server data changes on the client](portalfx-data-configuringdatacache.md) for details.
<!--TODO: Deprecate the previous section. It has been replaced by portalfx-extensions-bp-data.md -->


<a name="performance-best-practices-writing-fast-extensions-use-paging-for-large-data-sets"></a>
#### Use paging for large data sets

When working with a large data set, extension authors should use the paging features of the grid.
Paging allows deferred loading of rows, so even with a large dataset responsiveness can be maintained.
Additionally it means many rows might not need to be loaded at all. To learn more about paging with grids,
you can check out the samples:

`\Client\Controls\Grid\ViewModels\PageableGridViewModel.ts`

<a name="performance-best-practices-writing-fast-extensions-use-map-and-filter-to-reduce-size-of-rendered-data"></a>
#### Use &quot;map&quot; and &quot;filter&quot; to reduce size of rendered data

Often, it is useful to use the [Knockout projections](https://github.com/stevesanderson/knockout-projections) to shape and filter model data loaded using QueryView and EntityView (see [Shaping and filtering data](portalfx-data-projections.md)).

Significant performance improvements can achieved by reducing the number and size of the model objects bound to controls like grids, lists, charts:

    `\Client\Controls\Grid\ViewModels\SelectableGridViewModel.ts`

```ts

// Wire up the contents of the grid to the data view.
this._view = dataContext.personData.peopleQuery.createView(container);
var projectedItems = this._view.items
    .filter((person: SamplesExtension.DataModels.Person) => { return person.smartPhone() === "Lumia 520"; })
    .map((person: SamplesExtension.DataModels.Person) => {
        return <MappedPerson>{
            name: person.name,
            ssnId: person.ssnId
        };
    });

var personItems = ko.observableArray<MappedPerson>([]);
container.registerForDispose(projectedItems.subscribe(personItems));


```

In this example, `map` is used to project new model objects containing only those properties required to fill the columns of the grid.  Additionally, `filter` is used to reduce the size of the array to just those items that will be rendered as grid rows.

<a name="performance-best-practices-writing-fast-extensions-benefits-to-ui-rendering-performance"></a>
#### Benefits to UI-rendering performance

Using the selectable grid SDK sample we can see the benefits to using `map` to project objects with only those properties required by a grid row:

![Using knockout projections to map an array][mapping]
[mapping]: ../media/portalfx-performance/mapping.png

There is almost a 50% reduction in time with these optimizations, but also note that at 300 items it is still over 1.5s. Mapping to just the 2 columns in that selectable grid sample reduces the message size by 2/3 by using the technique described above. This reduces the time needed to transfer the view model as well as reducing memory usage.



 ## Frequently asked questions

<a name="performance-best-practices-"></a>
### 

* * * 
<!--### My Extension 'InitialExtensionResponse' is above the bar, what should I do

TODO

<a name="performance-best-practices-my-extension-manifestload-is-above-the-bar-what-should-i-do"></a>
### My Extension &#39;ManifestLoad&#39; is above the bar, what should I do

TODO

<a name="performance-best-practices-my-extension-initializeextensions-is-above-the-bar-what-should-i-do"></a>
### My Extension &#39;InitializeExtensions&#39; is above the bar, what should I do

TODO -->


<a name="performance-my-blade-revealed-is-above-the-bar-what-should-i-do"></a>
## My Blade &#39;Revealed&#39; is above the bar, what should I do

1. Assess what is happening in your Blades's constructor and OnInputsSet.
1. Can that be optimized?
1. If there are any AJAX calls, wrap them with custom telemetry and ensure they you aren't spending a large amount of time waiting on the result.
1. Check the Part's on the Blade revealed times using [Extension performance/reliability report][Ext-Perf/Rel-Report], select your Extension and Blade on the filters.
1. How many parts are on the blade?
    - If there's only a single part, if you're not using a `<TemplateBlade>` migrate your current blade over.
    - If there's a high number of parts (> 3), consider removing some of the parts

<a name="performance-my-part-revealed-is-above-the-bar-what-should-i-do"></a>
## My Part &#39;Revealed&#39; is above the bar, what should I do

1. Assess what is happening in your Part's constructor and OnInputsSet.
1. Can that be optimized?
1. If there are any AJAX calls, wrap them with custom telemetry and ensure they you aren't spending a large amount of time waiting on the result.
1. Do you have partial data before the OnInputsSet is fully resolved? If yes, then you can reveal early, display the partial data and handle loading UI for the individual components 

<a name="performance-my-wxp-score-is-below-the-bar-what-should-i-do"></a>
## My WxP score is below the bar, what should I do

Using the [Extension performance/reliability report][Ext-Perf/Rel-Report] you can see the WxP impact for each individual blade. Although given the Wxp calculation,
if you are drastically under the bar its likely a high usage blade is not meeting the performance bar, if you are just under the bar then it's likely it's a low usage
blade which is not meeting the bar.


 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                | Meaning |
| ------------------- | ------- |
| performance bar     |         |
| WxP score           | Weighted eXPerience score (WxP) |

