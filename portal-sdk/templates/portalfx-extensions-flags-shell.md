
## Shell feature flags

The Ibiza Fx team supports the following Shell feature flags. These flags are only available to the Shell, unless they are configured to be shared. Unless otherwise noted, a value of `true` enables the feature, and a value of `false` disables it. 

<!--TODO: can the canmodifystamps flag ever be required or included when it is false?  -->
<!--TODO: is the canmodifystamps always required when extensionName is used? -->

Shell feature flags are invoked with the syntax: `https://portal.azure.com/?feature.<featureName>=true`.

The keyboard shortcut CTRL+ALT+D toggles the visibility of the debug tool, as specified in [top-extensions-debugging-overview.md](top-extensions-debugging-overview.md). The yellow sticky that is located at the bottom on the right side of the window can be used to toggle trace mode flags and shell feature flags.

### The extensionName flag

The name of the extension can be used as a feature flag. The extension name can contain any character in the ranges between [a-z] or [0-9]. The portal query string can handle multiple extensions simultaneously.
<!--TODO: Determine whether all uses of the extensionName flag require the 'canmodifystamps` flag. -->
 This flag is used to enable or disable an extension, use a different configuration file for an extension, and provide other run-time functionality.  A value of `true` will temporarily enable a disabled extension, and allows the use of other flags. A value of `false` will temporarily disable the extension and leave it in hidden mode. The syntax for the extensionName flag is `https://portal.azure.com?Microsoft_Azure_DevTestLab=true`. It requires the `canmodifystamps` flag to contain a value of `true` in order to be in effect.  For more information, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

The name of the extension can be used in the query string to access various Shell flags. These are flags that are independent of the **canmodifystamps** flag.
`   &<extensionName>=true,[<otherShellFlags>]`.  How to use the flags that are within the extension is specified in [portalfx-extensions-feature-flags-developer.md](portalfx-extensions-feature-flags-developer.md);  The Shell flags that require `&<extensionName>=true` are in the following table.
    
  <!--TODO:  Validate that the parameters are used correctly.  -->

  | Directive | Use | 
  | --------- | --- |
  | nocdn | A value of `true` will bypass the CDN when loading resources for the Portal only. A value of `force` will bypass the CDN when loading resources for the Portal and all extensions.|
| testExtensions | Contains the name of the extension, and the environment in which the extension is located. For example, `?testExtensions={"HelloWorld":"https://localhost:44300/"}` specifies the intent to load the `HelloWorld` extension from the localhost port 44300 into the current session of the Portal. The **name** and **uri**  parameters are as specified in [portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal](portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal).|

    
### The canmodifystamps flag

The **canmodifystamps** flag is used in conjunction with the **extensionName** parameter to pass developer-specified values to the extension, to specify which stage or build number to use, and other purposes. When the **canmodifystamps** flag is set to true, the following run options can be enabled.

* Create custom deployment environments, as specified in [portalfx-deployment.md](portalfx-deployment.md).

* Use a secondary test configuration, as specified in [portalfx-extensions-configuration-overview.md#instructions-for-use](portalfx-extensions-configuration-overview.md#instructions-for-use). If the developer is using a secondary test configuration, enter one of the following into the query string immediately after the **canmodifystamps** flag.
 ```js
   &<extensionName>=<stageName>
   &<extensionName>=<buildNumber>
   &<extensionName>=<uriFormatPrefix> 
 ```
  * **extensionName**: The name of the extension.

    * **stageName**:  The stage that represents a datacenter, as specified in [portalfx-extensions-hosting-service-scenarios.md#sideloading](portalfx-extensions-hosting-service-scenarios.md#sideloading). Use the name that is deployed to a specific stage, for example, stage1.
    * **buildNumber**:  The build number as specified in [portalfx-extensions-hosting-service-scenarios.md#sideloading](portalfx-extensions-hosting-service-scenarios.md#sideloading). Replace the dots in the build number with the letter 'd', so that build number 1.0.8.31 is represented by 1d0d8d31.
    * **uriFormatPrefix**: The value to use when building the **uriFormat** string. For example, when **uriFormat** is `//{0}.devtest.ext.azure.com`, the query string `https://portal.azure.com?feature.canmodifystamps=true&Microsoft_Azure_DevTestLab=perf` would cause  the `{0}` in the **uriFormat** string to be replaced with `perf` and attempt to load the extension from `https://perf.devtest.ext.azure.com`.
    
### Shell flags

The following are the feature flags that are invoked with the syntax: `feature.<featureName>=true` unless otherwise noted.

**feature.abovethefold**:  A value of `true` means that the item is above the fold, or is initially displayed on the Web page without scrolling.  A value of `false` means that the item is not above the fold.

**feature.autoenablemove**:  Shows or hides the **Change** (resource move) link in the **Essentials** menu for all resource types.  A value of `true` shows the links, and a value of `false` hides them.  The links are the edit buttons next to the resource group, and the subscription name in the **Essentials** menu.

**feature.browsecategories**: Enables categories in the **Browse** menu.

<!--TODO: Validate what the default value is. -->
**feature.browsecuration={fileName}**:  Switches the curation file used for the **More Services** menu, default favorites, and search results.  The default is `available`.  To submit a partner request for custom curation to support a specific scenario, see [https:\\aka.ms\portalfx\uservoice](https:\\aka.ms\portalfx\uservoice).

**feature.browsecurationflags={a,b}**:  Comma-delimited list, in brackets, of additional flags used while rendering browse curation.  The list is in the following table.

| Flag        | Purpose |
| ----------- | --- | 
| (available: appservice, vms)  | |
| analytics   | Merge **Intelligence** and **Analytics** categories |
| aws         | Model **Compute** category after AWS  |
| cdn         | Remove the **Media/CDN** category |
| databases   | Rename the **Data** category to **Databases** |
| integration | Add all integration services to the **Enterprise Integration** category |
| management  | Rename **Management + Security** to **Monitoring + Management** |
| oms         | Group all OMS services together in the **Management** category |
| security    | Rename **Identity + Access Management** to **Security + Identity** |
| sql         | Add SQL Data Warehouses and SQL Server Stretch DBs kinds |
| storage     | Add all storage services to the **Storage** category  
| vm          | Rename **Compute** to **VMs**, and rename **Web + Mobile** to **App Services** |

**feature.canmodifyextensions**:  Required to support loading untrusted extensions for security purposes. For more information, see [portalfx-extensions-production-testing-overview.md#loading-customized-extensions](portalfx-extensions-production-testing-overview.md#loading-customized-extensions).

<!--TODO: Determine whether the following flag is associated with msportalfx-test.md#msportalfx-test-running-ci-->

**feature.ci**:  Sets up  the Portal up to work better with tests by disabling NPS popups and other items.

**feature.consoletelemetry**:  Logs most telemetry events to the browser console.

**feature.customportal**:  Overrides the `ms.portal` redirect when signing in to portal.azure.com. A value of `false` turns off automatic redirection for users in the microsoft.com tenant, and a value of `true`   .

**feature.disableextensions**:  Disables all extensions. A value of `true` disables the extension, and a value of `false` enables it. **NOTE**: Extensions must be enabled explicitly with this flag, including Hubs. For example, the following command disables all extensions, enables hubs, and enables the specific extension to be tested. `?feature.DisableExtensions=true&HubsExtension=true&MyOtherExtension=true `

**feature.eagerlyrevealassetpart**:  Asset part will infer resource names from ARM resource IDs, and will auto-reveal its content as soon as it has an icon and name.

**feature.extloadtimeout**:  Extension loading timeout (in seconds???).  Can contain any characters in the ranges [0-9]. The maximum value is .

**feature.fakepreviewassets**: Reserved for team use. <!-- `=true  | Forces Clocks and Hosts (from samples - see Client\V1\Blades\DynamicBlade\ViewModels) to be in preview (for testing only). A value of `true` forces the preview mode,  and a value of `false`       it. -->

<!--TODO: Does the following feature go away with relex? -->
**feature.fastmanifest**:  Enables relex-based manifest caching.   A value of `true` enables  the caching, and a value of `false`  disables it.

**feature.feedback**:  Disables the feedback pane. A value of `true` enables the feedback pane, and a value of `false`  disables it.

**feature.forceiris**:  Forces the Portal to query IRIS even if the time limit  has not expired.  The  time limit is 24 hours.

**feature.fullwidth**:  Forces all resource menu blades to be opened maximized.

**feature.hideavatartenant**: Reserved for internal Azure Portal use. <!-- Hides the directory name under the user's name in the avatar menu. -->

**feature.inmemorysettings**:  Uses in-memory user settings.

**feature.internalonly**:  Shows or hides the **Preview** banner in the top-left.  A value of `true` shows the banner,  and a value of `false` hides it.  

**feature.irissurfacename**:  Defines the surface name to use when querying IRIS.

**feature.multicloud**: Enables multicloud mode. Reserved for team use.  

**feature.nativeperf**:  Exposes native performance markers within the profile traces, which allows you to accurately match portal telemetry markers to the profile. The main use case is when profiling your extension/blade performance locally. Native performance markers will show up in the browser's performance profiling tool. 

**feature.nodirectory**:  Opens the avatar menu after the user signs in.

**feature.pinnedextensions**:  Comma-delimited list, in brackets, of extensions that are never unloaded.  Pins the specified extensions so that they exist during the lifetime of the Portal.

**feature.pov2**:  Use ProxiedObservables version 2 (POv2), as specified in .

**feature.pov2compatibilitymode**:  Disable compatibility mode for POv2, when enabled.  A value of `true` enables compatibility mode, and a value of `false`  disables it, so that the extension can run faster. 

**feature.prefetch**: Enables or disables a script prefetch feature in the Portal for diagnostics purposes. Reserved for team use. 

**feature.rapidtoasts**: Enables or disables toast notifications, and sets the default time that a toast is displayed, in milliseconds.  A value of zero disables toasts. 

<!--TODO:  verify whether these relex settings have ceased to exist or are just not used -->
**feature.relex**:  Not used.  Comma-delimited list of extensions to load in Relex. **NOTE**: An asterisk ("*") will load all extensions in Relex.

**feature.relexsinglecomm=true**:  Not used. When run in conjunction with the `feature.relex` flag, runs the corresponding extensions in relex with a single web socket connection to relex for all extensions.

<!--TODO: Determine whether ?feature.resourcemenu=true belongs here.-->

**feature.seetemplate**: "See template" link in Create blades. A value of `true`         ,  and a value of `false`      . 

**feature.settingsprofile**: Loads a Portal with the specified, isolated set of settings. It is used by the CI infrastructure to enable the loading of multiple Portals in parallel without overwriting each other’s settings. Reserved for team use.

**feature.ShowAffinityGroups**:  Set to allow users to add and select affinity groups in the Portal.  A value of `true`         ,  and a value of `false`      .   

**feature.showauditlogsaseventlogs**:  Changes audit log strings.

**feature.showbugreportlink**:  Shows or hides the **Report bug** link in the top bar. A value of `true` shows the link,  and a value of `false` hides it.

**feature.showpreviewtags**: Hides the preview ribbon on the startboard and shows labels in blade headers when extensions are marked as in preview.   **NOTE**: Does not hide the preview ribbon.

<!--TODO:  verify whether these relex settings have ceased to exist or are just not used -->
**feature.showrelexdialog**:  Not used. Hides the relex dialog that is displayed if performance is slow.

**feature.testhubsurl**:  Reserved for team use.

**feature.testremoteurl**: Reserved for team use.

**feature.testsamplesurl**: Reserved for team use.

**feature.tilemgmt**: Reserved for future use.

**feature.UserType**: A value of "test" excludes test traffic from Azure reports.

**feature.verbosediagnostics**: Valid values are in the following table.

| Value | Meaning |
| ----- | ------- |
| all   | Includes default diagnostics and all filtered diagnostics in the Ctrl+Alt+A popup window | 
| permissions |  Includes default diagnostics and the permissions entry in the Ctrl+Alt+A popup window | 
| assets | Includes default diagnostics and the assets/assetManagement entries in the Ctrl+Alt+A popup window | 
| desktop | Includes default diagnostics and the desktop entry in the Ctrl+Alt+A popup window | 

**feature.waitforpendingchanges**: Reserved for future use.

**feature.webworker**: Loads the extension in a separate webworker thread, which makes the extension more performant.  The flag is useful for testing extensions previous to enabling them in production. In a webworker thread, objects such as [DOM](portalfx-extensions-flags-glossary.md), cookies, and other items are not available. The query string parameter works in conjunction with the **supportsWebWorkers** parameter in the `extensions.json` file. The  `extensions.json` file must contain the value  `supportsWebWorkers: "true"`, in order for the feature flag to invoke behavior.  When the `supportsWebWorkers` parameter is absent or set to false, the feature flag cannot invoke any behavior. The query string is as follows: `https://portal.azure.com?extName=<webWorkerId>,<extensionName1>=true,<extensionName2>=true, <extensionName3>=true,feature.webworker=<value>`, where

  * **webWorkerId**: Identifies the webworker thread.

  * **extensionName\<number>**: Required field. Matches the name of the extension, without the angle brackets, as specified in the `<Extension>` element in the  `extension.pdl` file.  There is no default that will turn on all extensions in an environment on the basis of the `supportsWebWorkers: "true"` parameter in the json file.
  
  * **feature.webworker**: A value of `true` will allow the extensions to run in the specified webworker. A value of `false` will not run the extensions in a webworker.  In the previous query string, the **feature.webworker** flag allows the webworker whose id is specified in `webWorkerId` to use the extensions named `<extensionName1>`, `<extensionName2>,` and `<extensionName3>`.

    For more information about webworkers, see [https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers).

### Marketplace feature flags

<!--TODO:  Determine whether microsoft_azure_marketplace is an extension name or an example extension name.  If such is the case, then the following 4 flags should be documented as only the suffix name. -->

**microsoft_azure_marketplace_Curation**:  Associated with Marketplace extensions. Uses a named curation  . For more information about curations, see   .

**microsoft_azure_marketplace_curation**: Associated with Marketplace extensions. Uses a named curation . For more information about curations, see   .

<!--TODO:  Determine whether microsoft_azure_marketplace_ItemHideKey is different from microsoft_azure_marketplace_itemhidekey. -->

**microsoft_azure_marketplace_itemhidekey**: Associated with Marketplace extensions. Shows specified Marketplace items that are otherwise hidden, or shows unpublished items in the gallery. A value of `true` shows the item,  and a value of `false` hides it. Used in conjunction with **extensionName** when the extension is enabled. For example, if the hidekey is `DevTestLabHidden`,the following will display the extension in the "Create New" experience while it is enabled.
`https://portal.azure.com?<extensionName>=true&microsoft_azure_marketplace_ItemHideKey=DevTestLabHidden`.

**microsoft_azure_marketplace_quotaIdOverride**:  Associated with Marketplace extensions and the Create Launcher. A value of `true` ,  and a value of `false`. 
