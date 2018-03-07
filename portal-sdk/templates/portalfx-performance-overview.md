
## Overview


The PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf) displays various performance statistics for several extensions.
You can select your extension, blade, and part(s) from the filters, as in the following image.

![alt-text](../media/portalfx-performance/extensionPerfQuery.png "PowerBi Query")

In the following example, the AppInsightsExtension has been selected for further examination. Its blades and parts are described, and its scores are below the list of parts.

![alt-text](../media/portalfx-performance/extensionPerfQuerySelection.png "PowerBi Extension Query")

Portal performance is defined as the sum of the performance of all the experiences in the product or extension.  For example, the blades and parts associated with the extension in the previous image are displayed in the following image.

![alt-text](../media/portalfx-performance/extensionPerfQueryBladesParts.png "PowerBi Extension Query")

All extensions need to meet the minimum performance required to be  at the 80th percentile, as  in the following table.

| Area      | Sub-Area                   |  Telemetry Action         | How is it measured? |
| --------- | -------------------------- | ------------------------ | ------------------- |
| Blade     | [Revealed](portalfx-extensions-glossary-performance.md)                   | BladeRevealed            | Time it takes for the  `OnInputsSet` method of the blade to resolve.  All the parts on the blade that are [above the fold](portalfx-extensions-glossary-performance.md) to display the data they have received. |
| Blade     | [FullRevealed](portalfx-extensions-glossary-performance.md)               | BladeFullRevealed        | Time it takes for the  `OnInputsSet` method of the blade to display all of the data they have requested.  |
| Part      | Revealed                   |  PartRevealed             | Time it takes for the part to be rendered and then call the `OnInputsSet` method  or the `earlyReveal` method to resolve the data with the viewmodel and therefore the view |
| WxP       | N/A                        |  N/A                      | The overall experience score, that uses the blade revealed time and weighted blade usages.|

<!--| Extension | Initial Extension Response | TODO                | InitialExtensionResponse | TODO |
| Extension | Manifest Load              | TODO                | ManifestLoad             | TODO |
| Extension | Initialization             | TODO                | InitializeExtensions     | TODO | -->

## Extension performance

Extension performance is impacted by both Blade and Part performance, when the extension is loaded, when it is unloaded, and when it is required.

When a user visits a resource blade for the first time, the Portal  loads the extension and then requests the ViewModel.  This makes the Blade/Part performance happen.

If the user were to browse away from the UI experience and browse back previous to the unloading of the  extension, the second visit is faster because the UI does not have to re-load all of the extension.

## Blade performance

Blade performance is centered around specific areas that are encapsulated under the `BladeRevealed` action. They are as follows.


1. The constructor
1. The call to the `OnInputsSet` method
1. Displaying parts within the blade


## Part performance

Part performance is centered around specific areas that are encapsulated under the `PartRevealed` action. They are as follows.

1. The constructor
1. The call to the `OnInputsSet` method

## WxP score

The WxP score is a per-extension Weight eXPerience score (WxP). It is expressed as a percentage and calculated as follows.

```txt

WxP = (BladeViewsMeetingTheBar * 80thPercentileBar) /
     ((BladeViewsMeetingTheBar * 80thPercentileBar) + 
     ∑(BladeViewsNotMeetingTheBar * ActualLoadTimePerBlade))

```

| Blade   | 80th Percentile Times | Usage Count | Meets 80th Percentile Bar? |
| ------- | --------------------- | ----------- | -------------------------- |
| Blade A | 1.2                   | 1000        | Yes                        |
| Blade B | 5                     | 500         | No                         |
| Blade C | 6                     | 400         | No                         |

```txt

WxP = (BladeViewsMeetingTheBar * 80thPercentileBar) /
     ((BladeViewsMeetingTheBar * 80thPercentileBar) +
     ∑(BladeViewsNotMeetingTheBar * ActualLoadTimePerBlade)) %   
      
   = (4 * 1000) / ((4 * 1000) + ((5 * 500) + (6 * 400))) %
    = 44.94%

```

The model gives a negative score to  the  views that do not meet the bar. 

## Assessing blade performance

There are two methods that are used to assess the performance of an extension. 

1. Visit the PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf).

1. Run local Kusto queries to determine the numbers that are associated with extension performance.

The PowerBi dashboard is maintained on a regular basis by the Fx team. If you choose to run local queries, make sure that you use the Fx provided Kusto functions to calculate the assessment.

## Topics that Improve Blade Performance

The following table contains documents that are related to improving the perfomance of an extension.

| Purpose | Name |  
| ------- | ---- | 
| Content Delivery Network | [portalfx-cdn.md](portalfx-cdn.md)  | 
| Caching  | [portalfx-extension-homepage-caching.md](portalfx-extension-homepage-caching.md)|
|  Persistent Caching of scripts across extension updates | [portalfx-extension-persistent-caching-of-scripts.md](portalfx-extension-persistent-caching-of-scripts.md)   |
|  Identify and resolve common performance issues | [portalfx-performance-portalcop.md](portalfx-performance-portalcop.md) |
| Optimize CORS preflight requests | [portalfx-data-loadingdata.md#loading-data-optimize-number-cors-preflight-requests-to-arm-using-invokeapi.md](portalfx-data-loadingdata.md#loading-data-optimize-number-cors-preflight-requests-to-arm-using-invokeapi.md)  |
| Improve part responsiveness with revealContent | [portalfx-parts-revealContent.md](portalfx-parts-revealContent.md) |