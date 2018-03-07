
<a name="performance"></a>
# Performance


<a name="performance-overview"></a>
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

<a name="performance-extension-performance"></a>
## Extension performance

Extension performance is impacted by both Blade and Part performance, when the extension is loaded, when it is unloaded, and when it is required by another extension.

When a user visits a resource blade for the first time, the Portal  loads the extension and then requests the ViewModel.  This adds to the counts and times for the Blade and Part performance.

In addition, if the user were to browse away from the UI experience and browse back previous to the unloading of the extension, the load times for the second visit are faster because the UI does not have to re-load the entire extension.

<a name="performance-blade-performance"></a>
## Blade performance

Blade performance is measured  around specific areas that are encapsulated under the `BladeRevealed` action. They are as follows.


1. The constructor
1. The call to the `OnInputsSet` method
1. Displaying parts within the blade


<a name="performance-part-performance"></a>
## Part performance

Part performance is measured  around specific areas that are encapsulated under the `PartRevealed` action. They are as follows.

1. The constructor
1. The call to the `OnInputsSet` method

<a name="performance-wxp-score"></a>
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

<a name="performance-assessing-blade-performance"></a>
## Assessing blade performance

There are two methods that are used to assess the performance of an extension. The PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf) measures blade, part, and extension performance, or you may run local Kusto queries to determine the numbers that are associated with extension performance.

The PowerBi dashboard is maintained on a regular basis by the Fx team. If you choose to run local queries, make sure that you use the Fx provided Kusto functions to calculate the assessment.

<a name="performance-topics-that-improve-blade-performance"></a>
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

<a name="performance-portalcop"></a>
## PortalCop

The Portal Framework team has a tool named **PortalCop** that helps reduce code size and remove redundant RESX entries.

<a name="performance-portalcop-installing-portalcop"></a>
### Installing PortalCop

The tool should be installed when the developer installs Visual Studio, as specified in  [portalfx-extensions-nuget-overview.md](portalfx-extensions-nuget-overview.md).
If not, the tool can be installed by running the following command in the NuGet Package Manager Console.

```
Install-Package PortalFx.PortalCop -Source https://msazure.pkgs.visualstudio.com/DefaultCollection/_packaging/Official/nuget/v3/index.json -Version 1.0.0.339
```

The tool can also be installed by running the following command in  a Windows command prompt.

```
nuget install PortalFx.PortalCop -Source https://msazure.pkgs.visualstudio.com/DefaultCollection/_packaging/Official/nuget/v3/index.json -Version 1.0.0.339
```

<a name="performance-portalcop-running-portalcop"></a>
### Running PortalCop

<a name="performance-portalcop-running-portalcop-namespace-mode"></a>
#### Namespace mode

The **PortalCop** tool has a namespace mode that is used in code minification. 
 
```
   portalcop Namespace
```

**NOTE**: Do not run this mode in your codebase if If you do not use AMD.

If there are nested namespaces in the code, for example A.B.C.D, the minifier only reduces the top level name, and leaves all the remaining names uncompressed.

For example, if the code uses `MsPortalFx.Base.Utilities.SomeFunction();` it will be minified as `a.Base.Utilities.SomeFunction();`.

While implementing an extension with the Framework, namespaces that are imported can achieve better minification.  For example, the following namespace is imported into code
```
   import FxUtilities = MsPortalFx.Base.Utilities;
```

It yields a better minified version, as in the following example.
```
   FxUtilities.SomeFunction(); -> a.SomeFunction();
```

In the Namespace mode, the **PortalCop** tool normalizes imports to the Fx naming convention. It will not collide with any predefined names you defined. This tool can achieve as much as a 10% code reduction in most of the Shell codebase.

**NOTE**: Review the changes to minification after running the tool.  The tool does string mapping instead of syntax-based replacement, so you may want to be wary of string content changes.

<a name="performance-portalcop-running-portalcop-resx-mode"></a>
#### Resx mode

The **PortalCop** tool has a resx mode that is used to reduce code size and save on localization costs by finding unused/redundant `resx` strings. To list unused strings, use the following command.
```
   portalcop Resx
```
   
To list and clean *.resx files, use the following command.
```
    portalcop Resx AutoRemove
```

Constraints on using the resx mode are as follows.

* The tool may incorrectly flag resources as being unused if the extension uses strings in unexpected formats.  For example, if the extension tries to dynamically read from resx based on string values, as in the following code.

```
Utils.getResourceString(ClientResources.DeploymentSlots, slot)));
export function getResourceString(resources: any, value: string): string {
        var key = value && value.length ? value.substr(0, 1).toLowerCase() + value.substr(1) : value;
        return resources[key] || value;
}
```

* You should review the changes after running the tool and make sure that they are valid.
* If using the AutoRemove option, you need to use  **VisualStudio** to regenerate the `Designer.cs` files by opening the RESX files.
* If there are scenarios that the tool incorrectly identifies as unused, please report them to 
<a href="mailto:ibizafxpm@microsoft.com?subject=PortalCop incorrectly identifies Scenario as unused">ibizafxpm@microsoft.com</a>.



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

<a name="performance-best-practices-use-pageablegrids-for-large-data-sets"></a>
### Use pageableGrids for large data sets

When working with large data sets, developers should use grids and their paging features.
Paging allows deferred loading of rows, so even with large datasets, responsiveness is maintained.

Paging implies that many rows might not need to be loaded at all. For more information about paging with grids, see [portalfx-control-grid.md](portalfx-controls-grid.md)  and the sample located at `<dir>\Client\V1\Controls\Grid\ViewModels\PageableGridViewModel.ts`.

<a name="performance-best-practices-filtering-data-for-the-selectablegrid"></a>
### Filtering data for the selectableGrid

Significant performance improvements can be achieved by reducing the number of data models that are bound to controls like grids, lists, or charts.

Use the Knockout projections that are located at [https://github.com/stevesanderson/knockout-projections](https://github.com/stevesanderson/knockout-projections) to shape and filter model data.  They work in context with  with the  `QueryView` and `EntityView` objects that are discussed in [portalfx-data-projections.md#using-knockout-projections](portalfx-data-projections.md#using-knockout-projections).

The code located at   `<dir>\Client\V1\Controls\Grid\ViewModels\SelectableGridViewModel.ts` improves extension performance by connecting the reduced model data to a ViewModel that uses grids.  It is also in the following example.

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

In the preceding example, the `map` function uses a data model that contains only the properties necessary to fill the columns of the grid in the ViewModel. The `filter` function reduces the size of the array by returning only the  items that will be rendered as grid rows.

<a name="performance-best-practices-benefits-to-ui-rendering-performance"></a>
### Benefits to UI-rendering performance

The following image uses the selectableGrid `map` function to display only the data that is associated the properties that are required by the grid row.

![alt-text](../media/portalfx-performance/mapping.png "Using knockout projections to map an array")

* The data contains 300 items, and the time to load is over 1.5s. 
* The optimization of mapping to just the two columns in the selectable grid reduces the message size by 2/3. 
* The size reduction decreases the time needed to transfer the view model by about 50% for this sample data.
* The decrease in size and transfer time also reduces  memory usage.


<a name="performance-frequently-asked-questions"></a>
## Frequently asked questions

<a name="performance-frequently-asked-questions-extension-scores-are-above-the-bar"></a>
### Extension scores are above the bar

***How can I refactor my code to improve performance?***


DESCRIPTION:

The PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf) displays various performance statistics for several extensions.
You can select your Extension and Blade on the filters.
The scores for the individual pieces of an extension are related, so it is possible that improving the scores for a part will also bring the scores for the blade or the extension into alignment with performance expectations.

SOLUTION: 

1. Decrease Part 'Revealed' scores

    * Optimize the Blades's `constructor` and `OnInputsSet` methods of the part.
    * Wrap any **AJAX** calls with custom telemetry to ensure that they are not waiting on the result of the call.
    * If the part receives partial data previous to the completion of the `OnInputsSet` method, then the part can reveal the information early and display the partial data.  The part should also  load the UI for the individual components.

1. Decrease Blade 'Revealed' scores.

    * Optimize the quantity and quality of parts on the blade.
        * If there is only one part, or if the part is not a `<TemplateBlade>`, then migrate the part to use the new template as specified in  [portalfx-blades-procedure.md](portalfx-blades-procedure.md).
        * If there are more than three parts, consider refactoring or removing some of them so that fewer parts need to be displayed.
    * Optimize the Blades's `constructor` and `OnInputsSet` methods of the blade.
   * Wrap any **AJAX** calls with custom telemetry to ensure that they are not waiting on the result of the call.
    * Reduce the revealed times for parts on the blade.

* * *

<a name="performance-frequently-asked-questions-my-wxp-score-is-below-the-bar"></a>
### My WxP score is below the bar
***How do I identify which pieces of the extension are not performant?***

DESCRIPTION: 

The PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf) displays the WxP impact for each individual blade. It may not display information at the level of granularity that immediately points to the problem.

SOLUTION:

If the extension is drastically under the bar, it is  likely that a high-usage blade is not meeting the performance bar.  If the extension is nearly meeting the  bar, then it is likely that a low-usage blade is the one that is not meeting the bar.

* * * 

<!--###  Extension 'InitialExtensionResponse' is above the bar

 'ManifestLoad' is above the bar, what should I do

 'InitializeExtensions' is above the bar, what should I do
 -->



<a name="performance-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                | Meaning |
| ------------------- | ------- |
| above the fold | Initially displayed on the Web page without scrolling. |
| CDN | Content Delivery Network |
| FullRevealed  | The ViewModel within the blade or part has received all of the information that is will display. |
| MEF | |
| Percentile | A figure that reports the relative standing of a particular value within a statistical data set.  It is a ranking in relation to the rest of the data, instead of the mean, standard deviation, or actual data value. For example, a score at the 80th percentile means that 80% of the scores are lower, and  20% of the scores were higher. | 
| performance bar     |         |
| Revealed | The ViewModel within the blade or part has received enough information to begin to display it. |
| WxP score           | Weighted eXPerience score (WxP) |

