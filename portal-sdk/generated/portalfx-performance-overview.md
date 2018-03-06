
<a name="overview"></a>
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

<a name="extension-performance"></a>
## Extension performance

Extension performance is impacted by both Blade and Part performance, when the extension is loaded, when it is unloaded, and when it is required.

When a user visits a resource blade for the first time, the Portal  loads the extension and then requests the ViewModel.  This makes the Blade/Part performance happen.

If the user were to browse away from the UI experience and browse back previous to the unloading of the  extension, the second visit is faster because the UI does not have to re-load all of the extension.

<a name="blade-performance"></a>
## Blade performance

Blade performance is centered around specific areas that are encapsulated under the `BladeRevealed` action. They are as follows.


1. The constructor
1. The call to the `OnInputsSet` method
1. Displaying parts within the blade


<a name="part-performance"></a>
## Part performance

Part performance is centered around specific areas that are encapsulated under the `PartRevealed` action. They are as follows.

1. The constructor
1. The call to the `OnInputsSet` method

<a name="wxp-score"></a>
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

<a name="assessing-blade-performance"></a>
## Assessing blade performance

There are two methods that are used to assess the performance of an extension. 

1. Visit the PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf).

1. Run local Kusto queries to determine the numbers that are associated with extension performance.

The PowerBi dashboard is maintained on a regular basis by the Fx team. If you choose to run local queries, make sure that you use the Fx provided Kusto functions to calculate the assessment.

<a name="topics-that-improve-blade-performance"></a>
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