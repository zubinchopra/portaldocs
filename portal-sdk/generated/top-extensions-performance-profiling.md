
<a name="performance"></a>
# Performance


<a name="performance-overview"></a>
## Overview

Performance statistics for several extensions are displayed on the PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf). You can select your extension, blade, and part(s) from the filters, as in the following image.

![alt-text](../media/portalfx-performance/extensionPerfQuery.png "PowerBi Query")

In the following example, the AppInsightsExtension has been selected for further examination. Its blades and parts are described, and its scores are below the list of parts.

![alt-text](../media/portalfx-performance/extensionPerfQuerySelection.png "PowerBi Extension Query")

Portal performance is the sum of the performance of all the experiences in the product or extension.  Portal performance from a customer's perspective is seen as all experiences throughout the product. For example, the blades and parts associated with the extension in the previous image are displayed in the following image. As a developer, you have a responsibility to  uphold your extension to the 95th percentile performance bar.

![alt-text](../media/portalfx-performance/extensionPerfQueryBladesParts.png "PowerBi Extension Query")

All extensions need to meet the minimum performance required to be  at the 95th percentile, as  in the following table.

| Area      |  Telemetry Action         | How is it measured? |
| --------- | ------------------------- | ------------------- |
| Extension   | ExtensionLoad          | The time it takes for your extension's home page to be loaded and the initial scripts, specifically, the initialize call, to complete within the  Extension definition file. |
| Blade     | BladeFullReady      | The time it takes for the blade's `onInitialize` or `onInputsSet` to resolve and all the parts on the blade to become ready. This means that it can display all of the data it has requested.  |
| Part      | PartReady              | Time it takes for the part to be rendered and then the part's `OnInputsSet` to resolve.   |
| WxP       |  N/A                      | The overall experience score, calculated by weighting blade usage and the blade full ready time. |

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

Blade performance is measured  around specific areas that are encapsulated under the `BladeFullReady` action. They are as follows.

1. The constructor
1. The call to the `OnInputsSet` method or the `onInitialize` method
1. Displaying parts within the blade


<a name="performance-blade-performance-the-bladeperformanceincludingnetwork-method"></a>
### The BladePerformanceIncludingNetwork method

<!-- TODO:  Some, but not all of this, has been changed from 95% to 80%.  -->

The `BladePerformanceIncludingNetwork` function samples 1% of traffic in order to measure the number of network requests that are made throughout a session. Within the function, we correlate the count of any network requests that are made when the user is loading a specific blade. The function does not impact the markers that measure performance; however, a larger number of network requests typically results in slower performance. 

There is a known calculation issue with the current approach because the 95th percentile is reported as the summation of the 95th percentiles for `BladeFullReady` and the `getMenuConfig` call.

The subtle difference with the standard `BladeFullReady` marker is that if the blade is opened within a `ResourceMenu` blade, we include the time it takes to resolve the `getMenuConfig` promise when the `ResourceMenu` blade is loaded to the 95th percentile of the `BladeFullReady` duration. 

 In most cases the difference is insignificant because the `getMenuConfig` 95th percentile is less than < 10 milliseconds because it is static.  If your extension is drastically affected by the time it takes to load the `ResourceMenu` blade, its performance can be improved by making the menu statically defined.

<a name="performance-part-performance"></a>
## Part performance

Part performance is measured  around specific areas that are encapsulated under the `PartReady` action. They are as follows.

1. The constructor
1. The call to the `onInitialize` method or the  `OnInputsSet` method

<a name="performance-wxp-score"></a>
## WxP score

The WxP score is a per-extension Weight eXPerience score (WxP). It is expressed as a percentage and calculated as follows.

```txt

WxP = (BladeViewsMeetingTheBar * 95thPercentileBar) /
     ((BladeViewsMeetingTheBar * 95thPercentileBar) + 
     ∑(BladeViewsNotMeetingTheBar * ActualLoadTimePerBlade))

```

| Blade   | 95th Percentile Times | Usage Count | Meets 95th Percentile Bar? |
| ------- | --------------------- | ----------- | -------------------------- |
| Blade A | 1.2                   | 1000        | Yes                        |
| Blade B | 5                     | 500         | No                         |
| Blade C | 6                     | 400         | No                         |

```txt

WxP = (BladeViewsMeetingTheBar * 95thPercentileBar) /
     ((BladeViewsMeetingTheBar * 95hPercentileBar) +
     ∑(BladeViewsNotMeetingTheBar * ActualLoadTimePerBlade)) %   
      
   = (4 * 1000) / ((4 * 1000) + ((5 * 500) + (6 * 400))) %
    = 44.94%

```

The model counts the views that do not meet the bar and gives them a negative score.

<a name="performance-assessing-blade-performance"></a>
## Assessing blade performance

There are two methods that are used to assess the performance of an extension. The PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf) measures blade, part, and extension performance, or you may run local Kusto queries to determine the numbers that are associated with extension performance.

For more information about telemetry, see [portalfx-telemetry-getting-started.md](portalfx-telemetry-getting-started.md).

**NOTE**: It is good practice to run queries locally by using the Azure-provided Kusto functions to calculate your assessment.

<a name="performance-performance-profiling"></a>
## Performance profiling

<a name="performance-performance-profiling-how-to-profile-your-scenario"></a>
### How to profile your scenario

1.	Open a browser and load the Portal using `https://portal.azure.com/?clientoptimizations=bundle&feature.nativeperf=true`.

    * The `clientOptimizations=bundle` flag allows you to assess which bundles are being downloaded in a user-friendly manner. For more information, see [portalfx-extensions-flags-trace#the- clientoptimizations-flag](portalfx-extensions-flags-trace#the- clientoptimizations-flag).

    * The `feature.nativeperf=true` feature  exposes native performance markers within the profile traces, which allows you to accurately match portal telemetry markers to the profile.

1. Go to a blank dashboard.

1. Clear cache by using a hard reset and reload the Portal.

1. Use the browser's profiling timeline to throttle both the network and the CPU, which  best reflects the 95th percentile scenario, and then start the Profiler.

1. Walk through your scenario.

    *	Switch to the dashboard that is associated with the scenario.

    *	Deep link to your blade. Make sure to keep the feature flags in the deep link. Deep-linking will isolate as much noise as possible from the profile.

1. Stop the Profiler.


<a name="performance-identify-common-slowdowns"></a>
## Identify common slowdowns

Some of the main factors in extension performance are associated with network performance, extra bundled code, and overallocation of CPU resources to rendering and observables. The following guidelines may help you isolate areas in which extension performance can be improved.

1.	Blocking network calls

    You can identify Unnecessary network calls by using the scenarios located in [The BladePerformanceIncludingNetwork method](#the-bladeperformanceincludingnetwork-method).

1.	Waterfalling bundling

    If any waterfalls exist within the extension, ensure you have the proper bundling hinting in place, as specified in the optimize bundling document located at []().

    The waterfall can be avoided or reduced by using the following code.

      ```
      /// <amd-bunding root="true" priority="0" />

      import ClientResources = require("ClientResources");
    ```

1.	Heavy rendering and CPU from overuse of UI-bound observables

    Guidelines on how to use observables are located in [portalfx-blades-viewmodel.md](portalfx-blades-viewmodel.md).

<a name="performance-verifying-a-change"></a>
## Verifying a change

To correctly verify a change, you will need to ensure the 'before' and 'after' are instrumented correctly with telemetry. Without telemetry, you cannot truly verify that the change was helpful. What may seem to be huge improvement in performance may transition into a smaller win after the extension moves to production. Occasionally, they actually transision into decreases in performance.  The main goal is to trust the telemetry and instead of profiling, because the telemetry reports on the extension's performance in production.

<a name="performance-topics-that-improve-blade-performance"></a>
## Topics that Improve Blade Performance

The following table contains documents that are related to improving extension perfomance.

| Purpose | Name |  
| ------- | ---- | 
| Content Delivery Network | [portalfx-cdn.md](portalfx-cdn.md)  | 
| Identify and resolve common performance issues | [portalfx-performance-portalcop.md](portalfx-performance-portalcop.md) |
| Improve part performance | [portalfx-parts-revealContent.md](portalfx-parts-revealContent.md) | Optimize CORS preflight requests | [portalfx-data-loadingdata.md#optimize-cors-preflight-requests](portalfx-data-loadingdata.md#optimize-cors-preflight-requests)  |
| Performance caching  | [portalfx-performance-caching-homepage.md](portalfx-performance-caching-homepage.md)|
| Persistent caching of scripts | [portalfx-performance-caching-scripts.md](portalfx-performance-caching-scripts.md)   |


<a name="performance-portalcop"></a>
## PortalCop

The Portal Framework team has a tool named **PortalCop** that helps reduce code size and remove redundant RESX entries.

<a name="performance-portalcop-installing-portalcop"></a>
### Installing PortalCop

The tool should be installed when the developer installs Visual Studio, as specified in  [top-extensions-nuget.md](top-extensions-nuget.md).
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



<a name="performance-revealing-part-content"></a>
## Revealing part content

When a part loads, the user is presented with the default **blocking loading** indicator similar to the one in the following image.

![alt-text](../media/portalfx-parts/portalfx-parts-opaquespinner.png "Part with blocking loading indicator") 

By default, the lifetime of this indicator is controlled by the `promise` that is returned from the `onInputsSet` method of the part, as in the following example.

```ts
public onInputsSet(inputs: Def.InputsContract): MsPortalFx.Base.Promise {
	// When this promise is resolved, the loading indicator is removed.
    return this._view.fetch(inputs.websiteId);
}
```

With large amounts of data, it is good practice to reveal content while the data continues to load.  When this occurs, the **blocking loading** indicator can be removed previous to the completion of the data loading process. This allows the user to interact with the part and the data that is currently accessible.

Essential content can be displayed while the non-essential content continues to load in the background, as signified by the  **status** marker on the bottom left side of the tile.

A **non-blocking loading** indicator is displayed at the top of the part.  The user can activate or interact with the part while it is in this state. A part that contains the status marker and the **non-blocking loading** indicator is in the following image.

![alt-text](../media/portalfx-parts/portalfx-parts-translucentspinner.png "Part with non-blocking loading indicator") 

The `container.revealContent()` API that is located in the `ViewModel` can add this optimization to the part. This method performs the following.

1. Remove the **blocking loading** indicator

1. Reveal content on the part

1. Display the **non-blocking** loading indicator

1. Allow the user to interact with the part

The `container.revealContent()` method can be called from either the ViewModel's `constructor` method or the ViewModel's `onInputsSet` function. These calls are located either in a `.then(() => ...)` callback, after the essential data has loaded, or they are located in the `onInputsSet` method, previous to the code that initiates data loading.

<a name="performance-revealing-part-content-calling-from-the-constructor"></a>
### Calling from the constructor

If the part needs to display content previous to loading any data, the extension should call the `container.revealContent()` method from the ViewModel's `constructor` .  The following example demonstrates  a chart that immediately displays the X-axis and the Y-axis.

```ts
export class BarChartPartViewModel implements Def.BarChartPartViewModel.Contract {

    public barChartVM: MsPortalFx.ViewModels.Controls.Visualization.Chart.Contract<string, number>;

    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: ControlsArea.DataContext) {
        // Initialize the chart view model.
        this.barChartVM = new MsPortalFx.ViewModels.Controls.Visualization.Chart.ViewModel<string, number>(container);

        // Configure the chart view model (incomplete as shown).
        this.barChartVM.yAxis.showGridLines(true);
		
		container.revealContent();
	}
}
```

<a name="performance-revealing-part-content-calling-from-oninputsset"></a>
### Calling from onInputsSet

The `onInputsSet` method behaves consistently when returning a promise , whether or not the part uses the `container.revealContent()` method. Consequently, the `container.revealContent()` method can optimize the behavior of the part that is being developed. There are two methodologies that are used to call the `container.revealContent()` method.
 
Typically, the `container.revealContent()` method is called after  essential, fast-loading data is loaded, as in the following example.

```ts
public onInputsSet(inputs: MyPartInputs): Promise {
    // This larger Promise still controls the lifetime of all loading indicators (the
    // non-blocking one in this case, since 'container.revealContent()' has been called).
    return Q.all([
        this._essentialDataView.fetch(inputs.resourceId).then(() => {
            // Show the Part content once essential, fast-loading data loads.
            this._container.revealContent();
        }),
        this._slowLoadingNonEssentialDataView.fetch(inputs.resourceId)
    ]);
}
```

It is less common to call the `container.revealContent()` method when the essential data to display can be computed synchronously from other inputs, as in the following example.

```ts
public onInputsSet(inputs: MyPartInputs): Promise {

    // In this case, the 'resourceGroupName' is sufficient to allow the user to interact with the Part/Blade.
    var resourceDescriptor = ResourceTypes.parseResourceManagerDescriptor(inputs.resourceId);
    this.resourceGroupName(resourceDescriptor.resourceGroup);
    this._container.revealContent();

    // This Promise controls the lifetime of all loading indicators (the
    // non-blocking one in this case, since 'container.revealContent()' has been called).
    return this._dataView.fetch(inputs.resourceId);
}
```

The promise returned from `onInputsSet` still determines the visibility of the loading indicators.  After the promise is resolved, all loading indicators are removed, as in the following image.

![alt-text](../media/portalfx-parts/portalfx-parts-nospinner.png "Fully loaded part with no loading indicator")

Also, if the promise that was returned from `onInputsSet` is rejected, the part displays the default error UX.  The promise that was returned from `onInputsSet` could be rejected if either the fast-loading data promise or the slow-loading data promise was rejected. The customizable error UX is in the following image.

![alt-text](../media/portalfx-parts/default-error-UX.png "Default error UX")


<a name="performance-performance-caching"></a>
## Performance caching

<a name="performance-performance-caching-server-side-caching-of-extension-home-pages"></a>
### Server side caching of extension home pages

As of SDK version 5.0.302.85, extension home pages can be cached to different levels on the server.  This results in improved load time, especially from browsers that have high latency. The following is an example of a Portal URL in the production environment.

```
https://yourextension.contoso.com/
    ?extensionName=Your_Extension
    &shellVersion=5.0.302.85%20(production%23444e261.150819-1426)
    &traceStr=
    &sessionId=ece19d8501fb4d2cbe10db84b844c55b
    &l=en.en-us
    &trustedAuthority=portal.azure.com%3A
    #ece19d8501fb4d2cbe10db84b844c55b
```

The sessionId is sent in the query string for the extension URL. This makes the extension essentially un-cacheable, because a unique URL is generated on each access. This essentially breaks any caching, whether it occurs on the client browser or on the extension server.

If server-side caching of extension home pages is enabled, the URL becomes the following.

```
https://yourextension.contoso.com/
    ?extensionName=Your_Extension
    &shellVersion=5.0.302.85%20(production%23444e261.150819-1426)
    &traceStr=
    &l=en.en-us
    &trustedAuthority=portal.azure.com%3A
    #ece19d8501fb4d2cbe10db84b844c55b
```

Notice that the sessionId is no longer present in the query string. This allows the extension server to serve the same version of the page to a returning browser (HTTP 304).

Also, examine the implementation of the `Microsoft.Portal.Framework.ExtensionDefinition` class.  In the class, there is a property named `Cacheability`. By default its value is `ExtensionIFrameCacheability.None`.  To enable homepage caching on the extension server, the implementation should set it to `ExtensionIFrameCacheability.Server`.

Making this change assumes that home page rendering does not change, because there would be different outputs for different requests. It also assumes that when the output changes, it also increments the value of `Microsoft.Portal.Framework.ApplicationContext.Version`.

**NOTE**: In this mode, if live updates are made to the extension without incrementing the version, some   customers may not see the changes for some time because of data that was previously cached.

<a name="performance-performance-caching-client-side-caching-of-extension-home-pages"></a>
### Client-side caching of extension home pages

Additional benefits are derived from caching if an extension can cache on the client, and omit another network call.

Consequently, the Azure team has added support for caching extension home pages in the browser itself. The performance of an extension can be improved  by changing  how the extension uses caches. This allows the extension to load with as few as zero network calls from the browser for a returning user.

It also serves as a basis for further performance and reliability improvements, because fewer network calls also results in fewer network related errors.

Perform the following steps to enable this.

1.  Install a version of the SDK more recent than 5.0.302.121.

1.  Implement persistent caching of your scripts as specified in [portalfx-performance-caching-scripts.md](portalfx-performance-caching-scripts.md). Without it, there may be a higher impact on reliability as a result of home page caching.

1.  Ensure that the implementation of `Microsoft.Portal.Framework.ApplicationContext.GetPageVersion()` returns a stable value for each build of the extension.  This is implemented by default by using the version of the assembly. Home page caching will not be very effective if this value changes for different servers that are using the same deployment.  Also, if this value stays the same for several updates to an extension, then existing users will continue to load the previous version of an extension even if an update is deployed.

1. Update the following property in the implementation of `Microsoft.Portal.Framework.ExtensionDefinition`.

    ```cs
    public override ExtensionIFrameCacheability Cacheability
    {
        get
        {
            return ExtensionIFrameCacheability.Manifest;
        }
    }
    ```

1. To ensure backward compatibility, contact the <a href="mailto:ibizafxpm@microsoft.com?subject=[Manifest Caching] on &lt;extensionName&gt; &body=Hi, we have enabled manifest caching on &lt;extensionName&gt; please make the appropriate Portal change."> Portal team</a>  or submit a Work Item Request at the site located at  [https://aka.ms/cachemanifest](https://aka.ms/cachemanifest) so we can update our copy of the value.  

<!-- TODO: Determine whether the following sentence is still required.
    When all extensions have moved to newer SDKs, we can eliminate it.
-->

<a name="performance-performance-caching-implications-of-client-side-caching"></a>
### Implications of client side caching

The benefits of caching and fast load time generally outweigh the following implications.

1. One implication of client-side caching is that it might take a few hours for an extension update to reach all your customers. However, this occurs even with the existing deployment process. If a user has already loaded an  extension in their browser session, they will not receive the new version until they refresh the browser by hitting the F5 key. Therefore, extension caching adds a small amount of latency to this process.

1. If the extension uses client side caching, versioning cannot be used to roll out breaking changes to the deployed extension. Instead, server side changes should be developed in a non-breaking way, and earlier versions of server-side code should be kept running for a few days.

<a name="performance-performance-caching-how-client-side-caching-works"></a>
### How client side caching works

<a name="performance-performance-caching-how-client-side-caching-works-manifest-caching"></a>
#### Manifest caching

Azure  periodically loads extensions (from our servers) to obtain their manifests. This is also known as the "manifest cache" that is updated every few minutes. This allows Azure  to start the Portal without loading every extension to find its  basic information.

<!-- TODO: Determine whether we still need the list of basic information. 
 Like its name and its browse entry/entries, etc.
 -->

When the extension is requested by a user, the latest version of its code is loaded. Therefore, the details of the extension are always at least as correct as the cached values. Consequently, client side caching serves as a reasonable optimization.

<a name="performance-performance-caching-how-client-side-caching-works-pageversion"></a>
#### PageVersion

Newer versions of the SDK include the value of `GetPageVersion()` in the extension manifest.
The Portal uses this value when loading the extension into the Portal, as in the following query string.

```
https://YourExtension.contoso.com/
    ?extensionName=Your_Extension
    &shellVersion=5.0.302.85%20(production%23444e261.150819-1426)
    &traceStr=
    &pageVersion=5.0.202.18637347.150928-1117
    &l=en.en-us
    &trustedAuthority=portal.azure.com%3A
    #ece19d8501fb4d2cbe10db84b844c55b
```

On the server side, the value of `pageVersion` is matched with the current value of `ApplicationContext.GetPageVersion()`. If those values match, Azure sets the page to be browser cacheable for one month. If the values do not match, no caching is set on the response. A mismatch could occur during an upgrade, or if there was an unstable value of `ApplicationContext.GetPageVersion())`.

This use of the `pageVersion` values provides a reliable experience even when updating an extension.
When the caching values are set, the browser will not make a server request when loading the extension for the second time.

<!-- TODO: Determine whether there is a difference between "bust" and "break".
-->
**NOTE**: The `shellVersion` is included in the query string of the URL to provide a mechanism to bust extension caches as appropriate.

<a name="performance-performance-caching-how-to-test-changes"></a>
### How to test changes

The behavior of different caching modes in an extension can be verified  by launching the Portal with the following query string.

```
https://portal.azure.com/
    ?<extensionName>=cacheability-manifest
    &feature.canmodifyextensions=true
```

This will cause the extension named "extensionName", without the angle brackets, to load with manifest-level caching instead of its default server setting.
The value "feature.canmodifyextensions=true" is added to the query string to make the Portal run in test mode.  

To verify that the browser serves the  extension entirely from the cache on subsequent requests, perform the following steps.

* Open F12 developer tools, switch to the network tab, and filter the requests to only show "documents".
* Navigate to the extension by opening one of its blades. You  should see it load once from the server.
* The home page of the  extension will be displayed  in the list of responses, along with its  load time and size.
*  Click F5 to refresh the Portal and navigate back to the extension. This time when the extension is served, you should see the response served with no network activity. The response will display from  the cache.  If you see this, manifest caching is working as expected.

<a name="performance-performance-caching-coordinating-extension-updates-with-the-portal-team"></a>
### Coordinating extension updates with the Portal team

If you make some of these changes, you need to coordinate with the 
 <a href="mailto:ibizafxpm@microsoft.com?subject=[Caching Updates] on &lt;extensionName&gt; &body=Hi, we have enabled client-side caching on &lt;extensionName&gt; please make the appropriate Portal change."> Portal team</a> to make sure that we make corresponding changes for backward compatibility and safe deployment. When we receive this email, we  will stop sending your extension the sessionId part of the query string in the URL.



<a name="performance-persistent-caching-for-scripts"></a>
## Persistent caching for scripts

One problem that affects extension reliability is that scripts may fail to load, especially after extensions have been updated.

For example, version 1 of an extension uses a script file named `/Content/Script_A_SHA1.js`. A user visits the Portal and interacts with the extension. The script named `Script_A_SHA1.js` is not loaded because the user has not visited the blade that uses it.

**NOTE**: The `SHA` suffix was added to ensure maximum cacheability of the script.

Then, the extension is updated on the server, and the version 2 changes Script_A so that its URL becomes `/Content/Script_A_SHA2.js`.

Now, when the user visits the blade that uses the script, Script_A_SHA1.js is no longer on the server. Requests for it will probably  result in a 404 "Not found" error.

The use of a Content Delivery Network(CDN) might reduce the probability of encountering a 404.  However, user actions can occur over several hours, and the CDN does not guarantee keeping data available for any duration, therefore this problem might still occur.

This issue can be avoided or reduced by implementing a persistent content cache. To facilitate extension upgrades, Azure Portal provides a cache that can be used to store the contents of the `.../Content/` folder. All of the JavaScript, CSS, scripts, and image files for the extension are stored in this cache to make upgrades smoother. The extension requires a connection string that specifies the storage account that contains this cache.  This allows caching to be performed in the following layers.

1. Layer 1 is Content Delivery Network.
1. Layer 2 is the memory in the extension server.
1. Layer 3 is the storage account.

The Layer 3 cache should get hit somewhat rarely and after it is read, the retrieved content will temporarily be located in the higher layers.

<!-- TODO: Based on hosting and extension configuration, determine whether the following sentence is accurate. 
So we don't think you need to geo-distribute this layer.
-->

If Azure determines that Layer 3 is getting hit too often, the Ibiza team may change the geo-distribution strategy.

The storage account should be the same across all upgrades of the extension, which includes geo-distribution across regions when the extension is deployed. For more information about extension configuration and geo-distribution, see [portalfx-extensions-hosting-service-advanced.md](portalfx-extensions-hosting-service-advanced.md).

An extension can make sure that scripts are available across extension updates by using a class that derives from `Microsoft.Portal.Framework.IPersistentContentCache` on the extension server. To do this, derive a class from `Microsoft.Portal.Framework.BlobStorageBackedPersistentContentCache` and [MEF](portalfx-extensions-glossary-performance.md)-export your implementation. If one account per region is used to handle the geo-distribution strategy, they can be synchronized by using a custom implementation of the `Microsoft.Portal.Framework.IPersistentContentCache` interface, similar to the one in the following code.

```cs 
[Export(typeof(Microsoft.Portal.Framework.IPersistentContentCache))]
```

The class itself resembles the following implementation as developed in **HubsExtension**.

```cs 

using System;
using System.ComponentModel.Composition;
using Microsoft.Portal.Framework;

namespace <your.extension.namespace>
{
    /// <summary>
    /// The configuration for hubs content caching.
    /// </summary>
    [Export(typeof(HubsBlobStorageBackedContentCacheSettings))]
    internal class HubsBlobStorageBackedContentCacheSettings : ConfigurationSettings
    {
        /// <summary>
        /// Gets the hubs content cache storage connection string.
        /// </summary>
        [ConfigurationSetting(DefaultValue = "")]
        public SecureConfigurationConnectionString StorageConnectionString
        {
            get;
            private set;
        }
    }

    /// <summary>
    /// Stores content in blob storage as block blobs.
    /// Used to ensure that cached content is available to clients
    /// even when the extension server code is newer/older than the content requested.
    /// </summary>
    [Export(typeof(IPersistentContentCache))]
    internal class HubsBlobStorageBackedContentCache : BlobStorageBackedPersistentContentCache
    {
        /// <summary>
        /// /// Creates an instance of the cache.
        /// </summary>
        /// <param name="applicationContext"> Application context which has environment settings.</param>
        /// <param name="settings"> The content cache settings to use.</param>
        /// <param name="tracer"> The tracer to use for any logging.</param>
        [ImportingConstructor]
        public HubsBlobStorageBackedContentCache(
            ApplicationContext applicationContext,
            HubsBlobStorageBackedContentCacheSettings settings,
            ICommonTracer tracer)
            :base(settings.StorageConnectionString.ToString(), "HubsExtensionContentCache", applicationContext, tracer)
        {
        }
    }
}

```

The `web.config` file includes the following information.

```xml

    <add key="<your.extension.namespace>.HubsBlobStorageBackedContentCacheSettings.StorageConnectionString" value="" />

```

<a name="performance-persistent-caching-for-scripts-velidating-that-persistent-caching-is-working"></a>
### Velidating that persistent caching is working

To validate that  persistent caching is working, perform the following steps.

1. Deploy a version of your extension. Make a list of the scripts that it loads, whose names are of the form `<prefix><sha hash><suffix>.js`.
1. Use any blob explorer or editor to validate that the scripts have been written to blob storage.
1. Make changes to the TS files in the solution, then build and deploy a new version of the extension.
1. Look for scripts that have the same prefix and suffix but a different hash.
1. For each of those scripts, try to request the original URL from step 1 to validate whether it loads from the extension server instead of the CDN.
1. The script should still get served, but this time should load from the persistent cache.


<a name="performance-best-practices"></a>
## Best Practices

There are a few patterns that assist in improving browser and Portal performance.

<a name="performance-best-practices-general-best-practices"></a>
### General Best Practices

1. Test your scenarios at scale 

    * Determine how your scenario deals with hundreds of subscriptions or thousands of resources.

    * Do not fan out to gather all subscriptions. Instead, limit the default experience to first N subscriptions and have the user determine their own scope.

1. Develop in diagnostics mode 

    * Use [https://portal.azure.com?trace=diagnostics](https://portal.azure.com?trace=diagnostics) to detect console performance warnings, like using too many defers or using too many `ko.computed` dependencies.

1. Be wary of observable usage 

    * Try not to use them unless necessary

    * Do not aggressively update UI-bound observables. Instead, accumulate the changes and then update the observable. Also, manually throttle or use `.extend({ rateLimit: 250 });` when initializing the observable.

1. Run portalcop to identify and resolve common performance issues, as specified in [portalfx-performance-portalcop.md](portalfx-performance-portalcop.md).

<a name="performance-best-practices-coding-best-practices"></a>
### Coding best practices

1. Reduce network calls.

    * Ideally there should be only one network call per blade.

    * Utilize batch to make network requests, as in the following example.

        ```
        import { batch } from "Fx/Ajax";

        return batch<WatchResource>({
            headers: { accept: applicationJson },
            isBackgroundTask: false, // Use true for polling operations​
            setAuthorizationHeader: true,
            setTelemetryHeader: "Get" + entityType,
            type: "GET",
            uri: uri,
        }, WatchData._apiRoot).then((response) => {
            const content = response && response.content;
            if (content) {
                return convertFromResource(content);
            }
        });
        ```

1. Remove automatic polling.

    If you need to poll, only poll on the second request and ensure `isBackgroundTask: true` is in the batch call.

1. Optimize bundling. The waterfall can be avoided or reduced by using the following code.

    ```
    /// <amd-bunding root="true" priority="0" />

    import ClientResources = require("ClientResources");
    ```

1. Remove all dependencies on obsoleted code.

    * Loading any required obsoleted bundles is a blocking request during your extension load times

    * For more information, see [https://aka.ms/portalfx/obsoletebundles](https://aka.ms/portalfx/obsoletebundles).

1. Use the Portal's ARM token, as specified in []().

1. Do not use old PDL blades that are composed of parts. Instead, use TypeScript decorators, as specified in  [portalfx-no-pdl-programming.md#building-a-hello-world-template-blade-using-decorators](portalfx-no-pdl-programming.md#building-a-hello-world-template-blade-using-decorators).

    Each part on the blade has its own `viewmodel` and template overhead. Switching to a no-pdl template blade will mitigate that overhead.

1. Use the latest controls available. The controls are located at [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground), and they  use the Asynchronous Module Loader (AMD), thereby reducing what is required to load your blade. This also  minimizes your observable usage.

1. Remove bad CSS selectors

    * Build with warnings as errors and fix them.

    * List HTML elements first in a CSS selector list.
        
        Bad CSS selectors are defined as selectors that end in HTML elements. For example, `.class1 .class2 .class3 div { background: red; } ` ends with the HTML element `div`. 
    Because CSS is evaluated from right-to-left, the browser will find all `div` elements first, which is more expensive than placing the `div`earlier in the list.

1. Fix your telemetry

    * Ensure you are returning the relevant blocking promises as part of your initialization path (`onInitialize` or `onInputsSet`).

    * Ensure your telemetry is capturing the correct timings.

<a name="performance-best-practices-operational-best-practices"></a>
### Operational best practices

1. Enable performance alerts

    To ensure your experience never regresses unintentionally, you can opt into configurable alerting on your extension, blade and part load times. For more information, see [portalfx-telemetry-alerting-overview.md](portalfx-telemetry-alerting-overview.md).

1. Move the extension to the Azure hosting service, as specified in [top-extensions-hosting-service.md](top-extensions-hosting-service.md). If it is not on the hosting service, check the following factors.

    * Homepage caching should be enabled
    * Persistent content caching should be enabled
    * Compression is enabled
    * Your service is efficiently geo-distributed 

    **NOTE**: An actual presence in a region instead of a CDN contributes to extension performance.

1. Use Brotli Compression 

    Move to V2 targets to get this type of compression by default. 


1. Remove controllers. Do not proxy ARM through your controllers.


<a name="performance-best-practices-use-amd"></a>
### Use AMD

Azure supports [Asynchronous Module Definition (AMD)](http://requirejs.org/docs/whyamd.html), which is an improvement over bundling scripts into a single file at
compilation time. Now, the Portal downloads only the files needed to display the current U
 onto the screen. This makes it faster to unload and reload an extension, and provides for generally better performance in the browser.  

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

The code located at `<dir>\Client\V1\Controls\Grid\ViewModels\SelectableGridViewModel.ts` improves extension performance by connecting the reduced model data to a ViewModel that uses grids.  It is also in the following example.

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

    * Optimize the part's `constructor` and `OnInputsSet` methods
    * Remove obsolete bundles, as specified in  [https://aka.ms/portalfx/obsoletebundles](https://aka.ms/portalfx/obsoletebundles).
    * Wrap any **AJAX** calls with custom telemetry to ensure that they are not waiting on the result of the call.     Also, ensure that **AJAX** is called using the batch api.
    * If the part receives partial data previous to the completion of the `OnInputsSet` method, then the part can reveal the information early and display the partial data.  The part should also  load the UI for the individual components.

1. Decrease Blade 'Revealed' scores.

    * Optimize the quantity and quality of parts on the blade.
        * If there is only one part, or if the part is not a `<TemplateBlade>`, then migrate the part to use the  no-pdl template as specified in  [top-blades-procedure.md](top-blades-procedure.md).
        * If there are more than three parts, consider refactoring or removing some of them so that fewer parts need to be displayed.
    * Optimize the Blades's `constructor` and `OnInputsSet` methods.
    * Remove obsolete bundles, as specified in  [https://aka.ms/portalfx/obsoletebundles](https://aka.ms/portalfx/obsoletebundles).
    * Use  the Portal's ARM token, if possible. Verify whether the extension can use the Portal's ARM token and if so, follow the instructions located at []() to install it.
    * Change the extension to use the hosting service, as specified in [top-extensions-hosting-service.md](top-extensions-hosting-service.md).
       * Wrap any **AJAX** calls with custom telemetry to ensure that they are not waiting on the result of the call.   Also, ensure that **AJAX** is called using the batch api.
    * Reduce the revealed times for parts on the blade.
    * Check for waterfalling or serialized bundle requests, as described in [portalfx-extensions-bp-performance.md#coding-best-practices](portalfx-extensions-bp-performance.md#coding-best-practices).  If any waterfalls exist within the extension, ensure you have the proper bundling hinting in place, as specified in the optimize bundling document located at []().

* * *

<a name="performance-frequently-asked-questions-my-wxp-score-is-below-the-bar"></a>
### My WxP score is below the bar

***How do I identify which pieces of the extension are not performant?***

DESCRIPTION: 

The PowerBi dashboard that is located at [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf) displays the WxP impact for each individual blade. It may not display information at the level of granularity that immediately points to the problem.

SOLUTION:

If the extension is drastically under the bar, it is  likely that a high-usage blade is not meeting the performance bar.  If the extension is nearly meeting the  bar, then it is likely that a low-usage blade is the one that is not meeting the bar.

* * * 

<a name="performance-frequently-asked-questions-azure-performance-office-hours"></a>
### Azure performance office hours

***Is there any way I can get further help?***

Sure! Book in some time in the Azure performance office hours.

**When?** Wednesdays from 1:00 to 3:30

**Where?** Building 42, Conference Room 42/46

**Contacts**: Sean Watson (sewatson)

**Goals**:

* Help extensions to meet the performance bar
* Help extensions to measure performance
* Help extensions to understand their current performance status

**How to book time** 

Send a meeting request with the following information.

```
TO: sewatson
Subject: YOUR_EXTENSION_NAME: Azure performance office hours
Location: Conf Room 42/46 (It is already reserved)
```

You can also reach out to <a href="mailto:sewatson@microsoft.com?subject=<extensionName>: Azure performance office hours&body=Hello, I need some help with my extension.  Can I meet with you in Building 42, Conference Room 42/46 on Wednesday the <date> from 1:00 to 3:30?">Azure Extension Performance Team at sewatson@microsoft.com</a>.

<!--###  Extension 'InitialExtensionResponse' is above the bar

 'ManifestLoad' is above the bar, what should I do

 'InitializeExtensions' is above the bar, what should I do
 -->



<a name="performance-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                | Meaning |
| ------------------- | ------- |
| AMD                 | Asynchronous Module Definition |
| above the fold | Initially displayed on the Web page without scrolling. |
| Brotli Compression | A data format that is specifically for data streams that use general-purpose the LZ77 lossless compression algorithm and other algorithms in their compression schemes.  This type of compression decreases the size of transmissions of web fonts, and  can now be used to encode any data sent by a web server to a web browser if both client and server support the format.  | 
| CDN | Content Delivery Network |
| FullRevealed  | The ViewModel within the blade or part has received all of the information that is will display. |
| MEF | |
| Percentile | A figure that reports the relative standing of a particular value within a statistical data set.  It is a ranking in relation to the rest of the data, instead of the mean, standard deviation, or actual data value. For example, a score at the 80th percentile means that 80% of the scores are lower, and  20% of the scores were higher. | 
| performance bar     |         |
| Revealed | The ViewModel within the blade or part has received enough information to begin to display it. |
| WxP score           | Weighted eXPerience score (WxP) |

