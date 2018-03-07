
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

There are a few patterns that assist in improving browser and Portal performance.

<a name="performance-best-practices-use-amd"></a>
### Use AMD

Azure supports [Asynchronous Module Definition (AMD)](http://requirejs.org/docs/whyamd.html), which is an improvement over bundling scripts into a single file at
compilation time. Now, the Portal downloads only the files needed to display the current UI onto the screen. This makes it faster to unload and reload an extension, and provides for generally better performance in the browser.  

* Old code

The previous coding pattern was relevant for extensions that imported modules using `<reference>` elements. These statements bundlef all scripts into a single file at compilation time, leading to a relatively large file that was downloaded whenever the extension displayed a UI.  The deprecated code is in the following example.

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

* New code

By using AMD, the following files are loaded only as required, instead of one large bundle. This results in increased load time, and decreased memory consumption in the browser. The improved code is in the following example.

```ts

import SecurityArea = require("../SecurityArea");
import ClientResources = require("ClientResources");
import Svg = require("../../_generated/Svg");

export class BladeViewModel extends MsPortalFx.ViewModels.Blade {
    ...
}

```

For more information about the TypeScript module loading
system, see the official language specification located at [http://www.typescriptlang.org/docs/handbook/modules.html](http://www.typescriptlang.org/docs/handbook/modules.html).

<a name="performance-best-practices-use-paging-for-large-data-sets"></a>
### Use paging for large data sets

When working with large data sets, developers should use grids and their paging features.
Paging allows deferred loading of rows, so even with large datasets, responsiveness is maintained.

Paging implies that many rows might not need to be loaded at all. For more information about paging with grids, see [portalfx-control-grid.md](portalfx-controls-grid.md)  and the sample located at `<dir>\Client\V1\Controls\Grid\ViewModels\PageableGridViewModel.ts`.

<a name="performance-best-practices-use-paging-for-large-data-sets-use-map-and-filter-to-reduce-size-of-rendered-data"></a>
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

<a name="performance-best-practices-use-paging-for-large-data-sets-benefits-to-ui-rendering-performance"></a>
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

