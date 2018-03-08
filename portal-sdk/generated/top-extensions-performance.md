
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
|  Persistent Caching of scripts across extension updates | [portalfx-performance-caching-scripts.md](portalfx-performance-caching-scripts.md)   |
|  Identify and resolve common performance issues | [portalfx-performance-portalcop.md](portalfx-performance-portalcop.md) |
| Optimize CORS preflight requests | [portalfx-data-loadingdata.md#loading-data-optimize-number-cors-preflight-requests-to-arm-using-invokeapi.md](portalfx-data-loadingdata.md#loading-data-optimize-number-cors-preflight-requests-to-arm-using-invokeapi.md)  |
| Improve part responsiveness with revealContent | [portalfx-parts-revealContent.md](portalfx-parts-revealContent.md) |


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

The storage account should be the same across all upgrades of the extension, which includes geo-distribution across regions when the extension is deployed. For more information about extension configuration and geo-distribution, see [portalfx-extension-hosting-service-advanced.md](portalfx-extension-hosting-service-advanced.md).

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

