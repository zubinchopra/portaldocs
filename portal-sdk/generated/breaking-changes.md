# Breaking Changes from 9/13/2016 
* Additional Q&A about breaking changes can be found [here](./breaking-changes.md) 
* To ask a question about breaking changes [use this](https://aka.ms/ask/ibiza-breaking-change)  


## 5.0.302.573
<table><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7426345'>7426345</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7426345'>[Auth] Add onbaording AAD service principal for ibiza managed extension to client's tenant.</a><p>Added new package dependency
- Microsoft.Azure.ActiveDirectory.GraphClient version 2.1.1

Updates to these packages should be made as follows:
- Microsoft.Data.Edm from 5.6.2 to 5.6.3
- Microsoft.Data.OData from 5.6.2 to 5.6.3
- Microsoft.Data.Services.Client from 5.6.2 to 5.6.3
- System.Spatial from 5.6.2 to 5.6.3</p></td></tr></table>

## 5.0.302.568
<table><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7426345'>7426345</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7426345'>[Auth] Add onbaording AAD service principal for ibiza managed extension to client's tenant.</a><p>Added new package dependency
- Microsoft.Azure.ActiveDirectory.GraphClient version 2.1.1

Updates to these packages should be made as follows:
- Microsoft.Data.Edm from 5.6.2 to 5.6.3
- Microsoft.Data.OData from 5.6.2 to 5.6.3
- Microsoft.Data.Services.Client from 5.6.2 to 5.6.3
- System.Spatial from 5.6.2 to 5.6.3</p></td></tr></table>

## 5.0.302.566
<table><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7694345'>7694345</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7694345'>Deprecate the getService API</a><p> The MsPortalFx.Extension.getService() API has been a known performance bottleneck and will be removed. Beginning with this SDK, the API will cause compiler breaks but continue to work at runtime. The API will be completely removed in a future SDK.  Please remove all references to MsPortalFx.Extension.getService() from your code (including any JS files that you may be referencing. If you are using ExtensionCore.js in your extension you will be affected.)</p></td></tr><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7674510'>7674510</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7674510'>Data.Loader should strong type the return data type instead of JQueryPromiseVV<string, DataSet> in order to comply with the A+ promise standard</a><p>  Data.Loader and Data.DataCachedLoader have some API still on JQueryPromise interface.  This change force the API, if return a promise with JQueryPromiseVV(arg1, arg2) to Promise<FetchData> to comply with A+ promise standard.
 
    Introduce the FetchData type which consists of name: datasetName and value:DataSet
    Data.DataCacheLoader.refreshDataSet return type change from Promise<void> to Promise<FetchData>
 
      Data.CachedDataSet.foreRefresh() the return type become FxPromiseV<FetchData>
      Data.CachedDataSEt.debounceServerFetch, the return type change from JQueryPromise to FxPromiseV<FetchData>
 
      Data.Loader.getData() return type used to be any. Now return FxPromiseV<FetchData>
 
FxPromiseV<FetchData></p></td></tr><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7584873'>7584873</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7584873'>Externalize configuration for thread pool min/max worker and io threads</a><p>Add an appSetting to your web.config and/or cscfg named Microsoft.Portal.Framework.FrameworkConfiguration.ThreadPoolConfiguration. 

To retain the default configuration that your web server currently uses today supply an empty json blob. e.g

<add key="Microsoft.Portal.Framework.FrameworkConfiguration.ThreadPoolConfiguration" value="{}"/>

alternatively set the min IO and Worker threads to be a factor of the number of cores your selected compute SKU has.  To take effect the value of min must be greater than or equal to the number of cores of your current SKU.

    <add key="Microsoft.Portal.Framework.FrameworkConfiguration.ThreadPoolConfiguration" value="{
        ThreadPoolMinWorkerThreads: 24,
        ThreadPoolMinIoThreads: 24,
    }"/></p></td></tr><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7558332'>7558332</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7558332'>allow disabling nagle algorithm</a><p>*.config and *.cscfg setting Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointConnectionLimitPerProcessor has been removed and consolidated into a setting named Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointManager which is a json blob.  As a result ServicePointConnectionLimitPerProcessor is no long honored instead you should specify the value for this within the ServicePointManager setting.

Example configuration before and after.

*.cscfg Before:
     <Setting name="Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointConnectionLimitPerProcessor" value="500" />

*.config Before:
     <add key="Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointConnectionLimitPerProcessor" value="500" />

*.cscfg After:
     <Setting name="Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointManager" value="{
          ConnectionLimitPerProcessor: 500,
          UseNagleAlgorithm: false,
          Expect100Continue: false
         }" />

*.config After:
     <add key="Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointManager" value="{
         ConnectionLimitPerProcessor: 500,
         UseNagleAlgorithm: false,
         Expect100Continue: false
         }" />

Apart from updating your *.config and *.cscfg ensure you update your *.csdef to replace the Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointConnectionLimitPerProcessor with Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointManager
</p></td></tr><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7492578'>7492578</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7492578'>Add renamed ContentUnbundler NuGet package and add to VSIX</a><p>Microsoft.Portal.TestFramework.ContentUnbundler was renamed to more appropriate Microsoft.Portal.Tools.ContentUnbundler.

If using ContentUnbundler in Export mode for the Hosting Service you need to:
1. Update your package.config to reference the new NuGet Package.
2. in your *.csproj where you reference the package update the path to reflect the new name. (if in CoreXT don't forget to update to $(PkgMicrosoft_Portal_Tools_ContentUnbundler)

If using ContentUnbundler in Classic mode to generated aggregate scripts for UT purposes. 
- You can drop the need to run ContentUnbundler yourself and update Microsoft.Portal.Framework.Scripts NuGet package instead. This package contains the aggregated script output of content unbundler for each  corresponding SDK drop in a content file called MsPortalFx.js
- If you wish to continue to use ContentUnbundler in classic mode update your *.dll, *.exe references from /lib/net45/*.dll to /build/*.dll</p></td></tr><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7488094'>7488094</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7488094'>[ErrorTracker] content.valid writing to a read only observable</a><p>Previously the valid observable was not typed correctly so you would not get a compiler error when trying to write to it (instead it would show up at runtime as an MDS error). Now we're typing valid as read only so the compiler will flag issues in extension code. This does not change behavior at all since previously any writes to the valid() observable on controls were discarded and did nothing.</p></td></tr><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7446849'>7446849</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7446849'>fxcontrol-* classes shortened to fxc-*</a><p>To help load times the portal control css class name prefix was shortened from "fxcontrol-" to "fxc-".  The corresponding test framework classes were also updated.  Custom tests dependent on these css classes will need to be updated to the new prefix.  This test breaking change was made a year ago.  To provide time to adopt the fxc- prefix both the fxcontrol- and fxc- classes have been supported in the transition period.   This change finally removes all the fxcontrol- classes.  </p></td></tr><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7418439'>7418439</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7418439'>Widget errors: Compile time break if a single lens contains both fixed and variable sized tiles</a><p>The PDL compiler adds a new rule. This rule prevents the unsupported usage of parts with Fixed Size and Variable Size in the same lens. Such usage result in unpredictable runtime UI. If you have such compile error, ensure that your lens contains only Fixed Size parts or Variable Size parts, not a mix.   To fix: 
Option 1: Change the size of your parts. 
Option 2: Move parts to a new lens.</p></td></tr><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=6174198'>6174198</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=6174198'>Merge classic/v2 lists</a><p>This includes the removal of grid v1 browse blades and subsequently the grid v1 blade names.  This is a compile-time break only, runtime will continue to work.  The following constants have been removed and can be replaced by "Resources": MsPortalFx.Base.Constants.BladeNames.Hubs.[BrowseResourceBlade|BrowseAllResourcesBlade|BrowseResourceGroupBlade]</p></td></tr></table>

## 5.0.302.539
<table><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7558332'>7558332</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7558332'>allow disabling nagle algorithm</a><p>*.config and *.cscfg setting Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointConnectionLimitPerProcessor has been removed and consolidated into a setting named Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointManager which is a json blob.  As a result ServicePointConnectionLimitPerProcessor is no long honored instead you should specify the value for this within the ServicePointManager setting.  Example configuration before and after.  *.cscfg Before:      <Setting name="Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointConnectionLimitPerProcessor" value="500" />  *.config Before:      <add key="Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointConnectionLimitPerProcessor" value="500" />  *.cscfg After:      <Setting name="Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointManager" value="{           ConnectionLimitPerProcessor: 500,           UseNagleAlgorithm: false,           Expect100Continue: false          }" />  *.config After:      <add key="Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointManager" value="{          ConnectionLimitPerProcessor: 500,          UseNagleAlgorithm: false,          Expect100Continue: false          }" />  Apart from updating your *.config and *.cscfg ensure you update your *.csdef to replace the Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointConnectionLimitPerProcessor with Microsoft.Portal.Framework.FrameworkConfiguration.ServicePointManager</p></td></tr></table>

## 5.0.302.523
<table><tr><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7488094'>7488094</a></td><td><a href='http://vstfrd:8080/Azure/RD/_workitems#_a=edit&id=7488094'>[ErrorTracker] content.valid writing to a read only observable</a><p>Previously the valid observable was not typed correctly so you would not get a compiler error when trying to write to it (instead it would show up at runtime as an MDS error). Now we're typing valid as read only so the compiler will flag issues in extension code. This does not change behavior at all since previously any writes to the valid() observable on controls were discarded and did nothing.</p></td></tr></table>