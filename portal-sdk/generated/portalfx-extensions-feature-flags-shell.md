
<a name="shell-feature-flags"></a>
## Shell feature flags

The Ibiza Fx team supports the following feature flags, or Shell feature flags. These flags are only available to the Shell, unless they are configured to be shared. Unless otherwise noted, a value of `true` enables the extension, and a value of `false` disables it.

There are two naming conventions for feature flags. Some feature flags have their own names, like **hubsextension_showserverevents**; however, the syntax for most feature flags assumes they are a property of the feature object, in which case they are invoked with the  syntax: ```feature.<featureName>=true```.

<!--TODO: can an extension name contain capital letters or special characters? -->
<!--TODO: can the canmodifystamps flag ever be required or included when it is false?  -->
<!--TODO: is the canmodifystamps always required when extensionName is used? -->

<a name="shell-feature-flags-feature-flags-from-the-feature-object"></a>
### Feature flags from the feature object

**abovethefold**:  A value of `true` means that the item is above the fold, or is initially displayed on the Web page without scrolling.  A value of `false` means that the item is not above the fold.

**autoenablemove**:  Shows or hides the **Change** (resource move) link in the **Essentials** menu for all resource types.  A value of `true` shows the links, and a value of `false` hides them.  The links are the edit buttons next to the resource group, and the subscription name in the **Essentials** menu.

**browsecategories**: Enables categories in the **Browse** menu.

<!--TODO: Validate what the default value is. -->
**browsecuration={fileName}**:  Switches the curation file used for the **More Services** menu, default favorites, and search results.  The default is ***available***.  To submit a partner request for custom curation to support a specific scenario, see [http://aka.ms/new-ibiza-browse-request](http://aka.ms/new-ibiza-browse-request).

**browsecurationflags={a,b}**:  Comma-delimited list, in brackets, of additional flags used while rendering browse curation.  The list is in the following table.


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

**canmodifyextensions**:  Required to support loading untrusted extensions for security purposes. For more information, see [portalfx-testinprod.md](portalfx-testinprod.md).

**canmodifystamps**:  Use a secondary test stamp, as specified in [portalfx-extensions-configuration-overview.md#extension-stamps](portalfx-extensions-configuration-overview.md#extension-stamps). If the developer is using a secondary test stamp, as specified with  **canmodifystamps**=true, enter the following into the query string immediately after the **canmodifystamps** flag.

   `&<extensionName>=<stageName_or_buildNumber>` 

  where

   * **extensionName**: The name of the extension
   * **stageName_or_buildNumber**:  The stage as specified in [portalfx-extensions-hosting-service-scenarios.md#sideloading](portalfx-extensions-hosting-service-scenarios.md#sideloading). Use the stage name or build number that is deployed to a specific stage, for example, stage1. If using a BuildNumber, replace the dots with the letter 'd', so that build number 1.0.8.31 is represented by 1d0d8d31.

<!--TODO: Determine whether the following flag is associated with msportalfx-test.md#msportalfx-test-running-ci-->
**ci**:  Sets up  the portal up to work better with tests by disabling NPS popups and other items.

**consoletelemetry**:  Logs most telemetry events to the browser console.

**customportal**:  Overrides the `ms.portal` redirect when signing in to portal.azure.com. A value of `false` overrides the redirect, and a value of `true`   .

**disableextensions**:  Disables all extensions. A value of `true` disables the extension, and a value of `false` enables it. 
For example, the following command disables all extensions, enables hubs, and enables the specific extension to be tested.

`?feature.DisableExtensions=true&HubsExtension=true&MyOtherExtension=true `

* **NOTE**: Extensions must be enabled explicitly with this flag, including Hubs. 

**eagerlyrevealassetpart**:  Asset part will infer resource names from ARM resource IDs, and will auto-reveal its content as soon as it has an icon and name.

**extloadtimeout**:  Extension loading timeout (in seconds???).  Can contain any characters in the ranges [0-9]. The maximum value is .

**fakepreviewassets**: Reserved for team use. <!-- `=true  | Forces Clocks and Hosts (from samples - see Client\V1\Blades\DynamicBlade\ViewModels) to be in preview (for testing only). A value of `true` forces the preview mode,  and a value of `false`       it. -->
  
**fastmanifest**:  Enables relex-based manifest caching.   A value of `true` enables  the caching, and a value of `false`  disables it.

**feedback**:  Disables the feedback pane. A value of `true` enables the feedback pane, and a value of `false`  disables it.

**forceiris**:  Forces the portal to query IRIS even if the time limit  has not expired.  The  time limit is 24 hours.

**fullwidth**:  Forces all resource menu blades to be opened maximized.

**hideavatartenant**: Reserved for internal Azure Portal use. <!-- Hides the directory name under the user's name in the avatar menu. -->

**inmemorysettings**:  Uses in-memory user settings.

**internalonly**:  Shows or hides the **Preview** banner in the top-left.  A value of `true` shows the banner,  and a value of `false` hides it.  

**irissurfacename**:  Defines the surface name to use when querying IRIS.

**multicloud**: Enables multicloud mode. Reserved for team use.  

**nodirectory**:  Opens the avatar menu after the user signs in.

**pinnedextensions**:  Comma-delimited list, in brackets, of extensions that are never unloaded.  Pins the specified extensions so that they exist during the lifetime of the portal.

**pov2**:  Use ProxiedObservables version 2 (POv2) .

**pov2compatibilitymode**:  Disable compatibility mode for POv2, when enabled.  A value of `true` enables compatibility mode,   and a value of `false`  disables it, so that the extension can run faster.  

**prefetch**: Enables or disables a script prefetch feature in the portal for diagnostics purposes. Reserved for team use. 

<!--TODO:  verify whether these relex settings have ceased to exist or are just not used -->
**relex**:  Comma-delimited list of extensions to load in Relex. **NOTE**: An asterisk ("*") will load all extensions in Relex.

**relexsinglecomm=true**:  When run in conjunction with the `feature.relex` flag, runs the corresponding extensions in relex with a single web socket connection to relex for all extensions.

**seetemplate**: "See template" link in Create blades. A value of `true`         ,  and a value of `false`      . 

**settingsprofile**: Loads a portal with the specified, isolated set of settings. It is used by the CI infrastructure to enable the loading of multiple portals in parallel without overwriting each other’s settings. Reserved for team use.

**ShowAffinityGroups**:  Set to allow users to add and select affinity groups in the portal.  A value of `true`         ,  and a value of `false`      .   

**showauditlogsaseventlogs**:  Changes audit log strings.

**showbugreportlink**:  Shows or hides the **Report bug** link in the top bar. A value of `true` shows the link,  and a value of `false` hides it.

**showpreviewtags**: Hides the preview ribbon on the startboard and shows labels in blade headers when extensions are marked as in preview   **NOTE**: Does not hide the preview ribbon.

<!--TODO:  verify whether these relex settings have ceased to exist or are just not used -->
**showrelexdialog**:  Hides the relex dialog that is displayed if performance is slow.

**testhubsurl**:  Reserved for team use.

**testremoteurl**: Reserved for team use.

**testsamplesurl**: Reserved for team use.

**tilemgmt**: Reserved for future use.

**UserType**: A value of "test" excludes test traffic from Azure reports.

**waitforpendingchanges**: Reserved for future use.

<!--TODO:  Validate that the parameters are used correctly.  -->
**webworker**: Used in conjunction with `<extensionName>=true`. A value of `true` enables webworkers in the portal who have explicitly been set as supporting webworkers in the `extensions.json` file for all extensions. For example,

  ```webworker=true, Microsoft_Azure_Demo=true, extName=``` 

will allow the webworker whose id specified in `extName` to use the specified extension.

<!--TODO: Validate that "before flipping the switch" means enabling an extension in production. -->

**webworker**: Used in conjunction with **microsoft_azure_compute**. Enables the webworkers <>     for all extensions that have explicitly set supporting webworkers, and forces **microsoft_azure_compute** into a web worker. Useful for testing extensions manually or through CI previous to enabling them in production.  

<!-- TODO:  Find a name for the feature flags that are not invoked with the "feature.<name> syntax. -->

<a name="shell-feature-flags-features-other-than-the-feature-object"></a>
### Features other than the <code>feature</code> object

**extensionName**:  The name of the extension, which is used as a feature flag. Can contain any character in the ranges between [a-z] or [0-9]. Requires the `canmodifystamps` flag to contain a value of `true` in order to be in effect. Used to enable or disable an extension, or use a different configuration stamp.  A value of `true` will temporarily enable a disabled extension, and a value of `false` will temporarily disable it, as in the following example: `https://portal.azure.com?Microsoft_Azure_DevTestLab=true`.  For more information, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

**canmodifystamps**: Specifies the extension stamp that is located in a specific stage, or that is associated with a specific build. For more information about enabling and disabling extensions, see [portalfx-deployment.md#enable-or-disable-extensions-onboarding-ibiza](portalfx-deployment.md#enable-or-disable-extensions-onboarding-ibiza). For more information about extension stamps, see [portalfx-extensions-configuration-overview.md#extension-stamps](portalfx-extensions-configuration-overview.md#extension-stamps). 

**hubsextension_showserverevents**:  Automatically shows all error and warning events as notifications.

**microsoft_azure_marketplace_Curation**:  Associated with Marketplace extensions. Uses a named curation  . For more information about curations, see   .

**microsoft_azure_marketplace_curation**: Associated with Marketplace extensions. Uses a named curation . For more information about curations, see   .

**microsoft_azure_marketplace_itemhidekey**: Associated with Marketplace extensions. Shows specified Marketplace items that are otherwise hidden. A value of `true` shows the item,  and a value of `false` hides it. Used in conjunction with **extensionName** when the extension is enabled. For more information about hidekeys, see   .

**microsoft_azure_marketplace_quotaIdOverride**:  Associated with Marketplace extensions and the Create Launcher. A value of `true` ,  and a value of `false`. 

**testExtensions**: Contains the name of the extension, and the environment in which the environment is located. It specifies the intent to load the extension `<extensionName>` from the `localhost:<portNumber>` into the current session of the portal. The **name** and **uri**  parameters are as specified in [portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal](portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal).

