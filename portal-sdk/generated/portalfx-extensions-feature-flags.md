


<a name="extension-flags"></a>
# Extension flags
    
There are five types of flags that are associated with extensions. The purpose of each type of flag is similar but not identical. For example, flags that modify the browser in which the extension is running are not  flags that modify the extension itself. Extension flags are invoked by appending them to the query string, as in the following example: `https://portal.azure.com/?<extensionName>_<extensionFlag>=<value>`, where ```extensionFlag```, without angle brackets, is the feature to enable for the extension named `extensionName`.

Using these flags allows the developer to make modifications to the server, to the browser, and to the extension code, or make use of Azure-supplied extensions, regardless of the stage in which the extension is being tested.  

**NOTE**: Features that are invoked through the extensiondefinition are outside of the scope of this document.

The following table specifies the flags that can be used with the Azure portal and its extensions, categorized by the type of flag.

| Flag | Purpose | Document | 
| -- | -- | -- |
| Trace mode | Instructions to the debugging environment. Temporarily set server characteristics, toggle a behavior, or enable event logging. | [portalfx-extensions-feature-flags-trace-mode.md](portalfx-extensions-feature-flags-trace-mode.md) |
| Developer features | Allow the extension to specify its own features. Developers can create and maintain their own flags. |  [portalfx-extensions-feature-flags-developer.md](portalfx-extensions-feature-flags-developer.md)  |
| Shell flags | Connect the developer's extension to Azure API features. The Shell features are maintained by the Azure Portal team. Shell features do not require changes to the code in the extension. |  [portalfx-extensions-feature-flags-shell.md](portalfx-extensions-feature-flags-shell.md) |


<!-- The following sentence is from portalfx-domain-based-configuration-pattern.md. -->
  Changing the default feature flags that are sent to the extension requires Shell configuration changes and redeployment.


<a name="extension-flags-trace-mode-flags"></a>
## Trace Mode Flags

Trace mode flags are associated with code that exists inside the portal, and can be configured externally through the `.config` file. Trace mode is also enabled by appending flags to the end of the querystring.  For example, [https://portal.azure.com/?trace=diagnostics](https://portal.azure.com/?trace=diagnostics) will enable verbose debugging information in the console. The trace mode allows the developer to enable, disable, and filter tracking output.

The information that trace mode displays is associated with debugging, moreso than with regular operation of the extension. This information is an addition to standard console errors, and it can be used to monitor application execution and performance in a deployed environment.  The errors that are presented in the console assist in fixing extension issues. For more information about trace modes, see [https://docs.microsoft.com/en-us/dotnet/framework/debug-trace-profile/how-to-create-initialize-and-configure-trace-switches](https://docs.microsoft.com/en-us/dotnet/framework/debug-trace-profile/how-to-create-initialize-and-configure-trace-switches).

Often the errors that are displayed in the console can lead you down the path of fixing your issues. In addition to viewing the standard errors displayed in the console, it's often useful to load the portal in trace mode. 
 <!--TODO:  Verify whether this section contains all trace modes for the Azure Portal. -->

Trace modes are enabled by appending them to the query string, as in the following example: `https://portal.azure.com/?trace=<settingName>`, where ```settingName```, without angle brackets, is the type of trace to run on the extension. The Azure trace mode flags are in the following list.

**desktop**: Log all shell desktop operations. Useful for reporting errors to the alias.

**diagnostics**: Display the debug hub, and add verbose tracing. Also used for capturing callstacks across iframes.

**inputsset.debug.viewModelOrPdlName**: Break into debugger when `onInputsSet` is about to be called on extension side. This trace can use the `viewmodel` name or the blade or part name to filter trace.

**inputsset.log.CommandViewModel**:  Add refinement to the selection of which view model to trace.

<!--TODO:  Validate how this works if onInputSet is being replaced. -->
**inputsset.log.viewModelOrPdlName**: Log in console when `onInputsSet` is about to be called on extension side. This trace can use the `viewmodel` name or the blade or part name to filter trace.

**inputsset.log.WebsiteBlade**: Further refine which view model to trace.

**inputsset.verbose.viewModelOrPdlName**: Log in the console every time the shell evaluates whether `onInputsSet` should be called. This trace can use the viewmodel name or the part or blade name to filter trace. 

**partsettings.viewModelOrPartName**: Shows writes and reads of settings for the specified part. This trace can use the `viewmodel` name or the part name to filter the trace. 

**usersettings**:  Show all writes and reads to the user settings service. Great for debugging issues that require a 'reset desktop'. 



<a name="extension-flags-feature-flags"></a>
## Feature Flags

Extension flags and feature flags are specially-formatted query string parameters that are sent through the portal to extensions and their controller methods.  They are often used while testing to enable and disable features that are maintained in the source code. Feature flags can only be used on items like form elements or HTML template components; they cannot be used to hide blades, parts, or commands. There is no pre-registration of feature flags because the process of using feature flags is dynamic.

Flags are only accessible by the extension in which they are defined, and therefore are not shared across extensions. Typically, the flag is boolean and has a descriptive name. Most feature flags are set to a value of `true` or `false`, which respectively enables or disables the feature. However, some feature flags send non-boolean values to the extension when more than two options are appropriate to test a specific feature.

Features are enabled by appending a flag to the query string, as in the following example: `https://portal.azure.com/?<extensionName>_<flagName>=<value>`, where ```flagName```, without angle brackets, is the feature to enable for the extension. The extension name and the underscore are used by the portal to determine the extension for which the feature flag applies.

The only limitation on developer-designed feature flag names is that they cannot contain underscores. Feature flags are named according to the following rules.
<!--TODO:  Determine whether the underscore between the extensionName and the flagName is a requirement. -->
* Must be formatted as `<extensionName>_<flagName>` (e.g. `azurecomputesomeflag`)
* Can contain any non-empty value (e.g. `azurecomputesomeflag=true`)
* Are all lower case
* Cannot include an underscore in the flag portion of the name (i.e., `azure_compute_some_flag` does not work, but `azure_compute_someflag` works)

 In the following example, the  `pricingtier` feature flag is used in two different extensions. 

   ```https://portal.azure.com/?hubsextension_pricingtier=whatever1&microsoft_azure_billing_pricingtier=whatever2```

* From Hubs Extension

    `MsPortalFx.getFeatureValue("pricingtier") = “value1”`
 
* From Billing Extension

    `MsPortalFx.getFeatureValue("pricingtier") = “value2”`
    
<a name="extension-flags-feature-flags-modifying-code-for-feature-flags"></a>
### Modifying code for feature flags

Developers can create feature flags for extensions, and plan to manage them as a part of the software maintenance process.  Typically, the feature is boolean and has a descriptive name. A value of `true` turns on the feature, and a value of `false` turns it off. 

The following code examples demonstrate how to turn feature flags on and off inside the code. 

<details>
<summary>TypeScript </summary>

* Enabling a feature

    Use the ```MsPortalFx.isFeatureEnabled``` and  ```MsPortalFx.getFeatureValue``` APIs to access feature values in TypeScript, as in the following code.

    Query string with parameters: `https://portal.azure.com?azure_compute_someflag=true`

   ```ts
    if (MsPortalFx.isFeatureEnabled("someflag"))
    {
        // turn on new feature
    }
   ```

*  Setting behavior based on feature flag value

    Query string with parameters: `https://portal.azure.com?azure_compute_someotherflag=value1`

   ```ts
    switch (MsPortalFx.getFeatureValue("someotherflag"))
    {
        case "value1":
            // behavior 1
            break;
        case "value2":
            // behavior 2
            break;
        default:
            // default behavior
            break;
    }
   ```

</details>
<details>
<summary> C# </summary>

Feature flags can be enabled for all users in one or more deployments by using an extension configuration, as in the following code. 

1. In the `ApplicationConfiguration` class, add the following property.

     ```cs
    [ConfigurationSetting]
    public CaseInsensitiveReadOnlyDictionary<IReadOnlyDictionary<string, string>> DefaultQueryString
    {
        get;
        private set;
    }
    ```

1. In the derived app context class (probably named `CustomApplicationContext`),  override the `GetDefaultQueryString` method.

     ```cs
    public override IReadOnlyDictionary<string, string> GetDefaultQueryString(string host)
    {
        return this.configuration.DefaultQueryString.GetValueOrDefault(host);
    }
    ```

1. Finally, in the config files (`web.config` or `cscfg`), add the following entry
  ```json
<Setting name="Microsoft.StbPortal.Website.Configuration.ApplicationConfiguration.DefaultQueryString" value="{
  '*': {
      'websitesextension_supportsettingsenabled':'true',
      'websitesextension_troubleshootsettingsenabled':'true'
  },
  'prod.websitesextension.com': {
      'websitesextension_requestsettingsenabled':'true'
  },
  'dogfood.websitesextension.com': {
        'websitesextension_healthsettingsenabled':'true'
  }
}" />
 ```

* The asterisk specifies the default case. Requests to the extension will enable those features, regardless of the domain.

* Feature flags that are associated with the domain name in an environment, i.e. the domain name of the incoming extension requests, will take precedence over the feature flags that are in the default case.

</details>
<details>
<summary>Ajax</summary> 

*  Using the RequestFlags dictionary

    When using `MsPortalFx.Base.Net.ajax()`, extension flags are also sent to the controller methods. The controller should extend the  `Microsoft.Portal.Framework.ApiControllerBase` method to receive the flag value. The extension can use the `RequestFlags` dictionary to check whether a flag is being sent to the controller, as in the following code.

   ```cs
    if (RequestFlags.TryGetValue("microsoft_azure_compute_someflag", out value) && value == "true")
    {
        // turn on feature here
    }
   ```

*  Overriding Defaults 

    To enable this for all users, `ApplicationContext` can be configured to specify a list of default query string parameters.  The extension should override the `GetDefaultQueryString` method, as in the following figure.

   ```cs
    public override IReadOnlyDictionary<string, string> GetDefaultQueryString(string host)
    {
        // read the default query string parameters from config and return.
    }
   ```

This option will make these feature flags available in client-side code for all users.

<!-- TODO: Determine whether Ibiza contacts for feature flags should be added to the document -->
<!-- TODO:  determine whether browsecuration affects the Browse menu, the More Services menu, or both -->


</details>

<br>

For more information about feature flags, see [https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags](https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags).

You can ask questions on Stackoverflow with the tag [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza).



<a name="extension-flags-shell-feature-flags"></a>
## Shell feature flags

The Ibiza Fx team supports the following feature flags, or Shell feature flags. These flags are only available to the Shell, unless they are configured to be shared. Unless otherwise noted, a value of `true` enables the feature, and a value of `false` disables it. 

There are three naming conventions for feature flags. Some feature flags have their own names, like **hubsextension_showserverevents** or `https://portal.azure.com/?<featureName>=<value>`; however, the syntax for most feature flags assumes they are a property of the feature object, in which case they are invoked with the  syntax: ```feature.<featureName>=true```. Otherwise, they are directives to the extension, in which case the syntax is `<extensionName>_<flagName>=<value>`. For more information about developer-specified feature flags in extensions, see [portalfx-extensions-feature-flags-developer.md](portalfx-extensions-feature-flags-developer.md).
<!-- TODO:  Determine whether hubsextension_showserverevents is the showserverevents feature flag for the hubsextension extension.  -->
<!--TODO: can an extension name contain capital letters or special characters? -->
<!--TODO: can the canmodifystamps flag ever be required or included when it is false?  -->
<!--TODO: is the canmodifystamps always required when extensionName is used? -->

The keyboard shortcut CTRL+ALT+D toggles the visibility of the debug tool, as specified in [portalfx-extensions-debugging-overview.md](portalfx-extensions-debugging-overview.md). The yellow sticky that is located at the bottom on the right side of the window can be used to toggle client optimizations and other shell feature flags.

<a name="extension-flags-shell-feature-flags-the-extensionname-flag"></a>
### The extensionName flag

The name of the extension can be used as a feature flag. The extension name can contain any character in the ranges between [a-z] or [0-9]. 
<!--TODO: Determine whether all uses of the extensionName flag require the 'canmodifystamps` flag. -->
Requires the `canmodifystamps` flag to contain a value of `true` in order to be in effect. Used to enable or disable an extension, use different configuration stamps, and provide other run-time functionality.  A value of `true` will temporarily enable a disabled extension, and allows the use of other flags. A value of `false` will temporarily disable the extension and leave it in hidden mode, as in the following example: `https://portal.azure.com?Microsoft_Azure_DevTestLab=true`.  For more information, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

The name of the extension can be used in the query string to access various Shell flags. These are flags that are independent of the **canmodifystamps** flag.

```js
   &<extensionName>=true,[<otherShellFlags>]
```
 How to use the flags that are within the extension is specified in [portalfx-extensions-feature-flags-developer.md](portalfx-extensions-feature-flags-developer.md);  The Shell flags are in the following table.
    
  <!--TODO:  Validate that the parameters are used correctly.  -->

  | Directive | Use | 
  | --------- | --- |
  | webworker | A value of `true` enables webworkers in the portal for all extensions who have explicitly been set as supporting webworkers in the `extensions.json` file. For example, `webworker=true,Microsoft_Azure_Demo=true,extName=<id>` will allow the webworker whose id is specified in `extName` to use the extension named Microsoft_Azure_Demo. 




<a name="extension-flags-shell-feature-flags-the-canmodifystamps-flag"></a>
### The canmodifystamps flag

The **canmodifystamps** flag is used in conjunction with the **extensionName** parameter to pass developer-specified values to the extension, to specify which stage or build number to use, and other purposes. When the **canmodifystamps** flag is set to true, the following run options can be enabled.

* Use a secondary test stamp, as specified in [portalfx-extensions-configuration-overview.md#extension-stamps](portalfx-extensions-configuration-overview.md#extension-stamps). If the developer is using a secondary test stamp, enter one of the following into the query string immediately after the **canmodifystamps** flag.
 ```js
   &<extensionName>=<stageName>
   &<extensionName>=<buildNumber>
   &<extensionName>=<uriFormatPrefix> 
 ```
  * **extensionName**: The name of the extension.

    * **stageName**:  The stage that represents a datacenter, as specified in [portalfx-extensions-hosting-service-scenarios.md#sideloading](portalfx-extensions-hosting-service-scenarios.md#sideloading). Use the name that is deployed to a specific stage, for example, stage1.
    * **buildNumber**:  The build number as specified in [portalfx-extensions-hosting-service-scenarios.md#sideloading](portalfx-extensions-hosting-service-scenarios.md#sideloading). Replace the dots in the build number with the letter 'd', so that build number 1.0.8.31 is represented by 1d0d8d31.
    * **uriFormatPrefix**: The value to use when building the **uriFormat** string. For example, when **uriFormat** is `//{0}.devtest.ext.azure.com`, the query string `https://portal.azure.com?feature.canmodifystamps=true&Microsoft_Azure_DevTestLab=perf` would cause  the `{0}` in the **uriFormat** string to be replaced with `perf` and attempt to load the extension from `https://perf.devtest.ext.azure.com`.
    
 * Create custom deployment environments, as specified in [portalfx-deployment.md](portalfx-deployment.md).

<a name="extension-flags-shell-feature-flags-feature-flags-from-the-feature-object"></a>
### Feature flags from the feature object

<!-- Content included from oneNote document named Extension feature flags -->

The following are the feature flags that are invoked with the syntax: `feature.<featureName>=true` unless otherwise noted.

**abovethefold**:  A value of `true` means that the item is above the fold, or is initially displayed on the Web page without scrolling.  A value of `false` means that the item is not above the fold.

**autoenablemove**:  Shows or hides the **Change** (resource move) link in the **Essentials** menu for all resource types.  A value of `true` shows the links, and a value of `false` hides them.  The links are the edit buttons next to the resource group, and the subscription name in the **Essentials** menu.

**browsecategories**: Enables categories in the **Browse** menu.

<!--TODO: Validate what the default value is. -->
**browsecuration={fileName}**:  Switches the curation file used for the **More Services** menu, default favorites, and search results.  The default is `available`.  To submit a partner request for custom curation to support a specific scenario, see [https:\\aka.ms\portalfx\uservoice](https:\\aka.ms\portalfx\uservoice).

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

**canmodifyextensions**:  Required to support loading untrusted extensions for security purposes. For more information, see [portalfx-extensions-testing-in-production-overview.md#registering-a-customized-extension](portalfx-extensions-testing-in-production-overview.md#registering-a-customized-extension).

<!--TODO: Determine whether the following flag is associated with msportalfx-test.md#msportalfx-test-running-ci-->
**ci**:  Sets up  the portal up to work better with tests by disabling NPS popups and other items.

**consoletelemetry**:  Logs most telemetry events to the browser console.

**customportal**:  Overrides the `ms.portal` redirect when signing in to portal.azure.com. A value of `false` turns off automatic redirection for users in the microsoft.com tenant, and a value of `true`   .

**disableextensions**:  Disables all extensions. A value of `true` disables the extension, and a value of `false` enables it. **NOTE**: Extensions must be enabled explicitly with this flag, including Hubs. For example, the following command disables all extensions, enables hubs, and enables the specific extension to be tested. `?feature.DisableExtensions=true&HubsExtension=true&MyOtherExtension=true `

**eagerlyrevealassetpart**:  Asset part will infer resource names from ARM resource IDs, and will auto-reveal its content as soon as it has an icon and name.

**extloadtimeout**:  Extension loading timeout (in seconds???).  Can contain any characters in the ranges [0-9]. The maximum value is .

**fakepreviewassets**: Reserved for team use. <!-- `=true  | Forces Clocks and Hosts (from samples - see Client\V1\Blades\DynamicBlade\ViewModels) to be in preview (for testing only). A value of `true` forces the preview mode,  and a value of `false`       it. -->

<!--TODO: Does the following feature go away with relex? -->
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

**pov2**:  Use ProxiedObservables version 2 (POv2), as specified in .

**pov2compatibilitymode**:  Disable compatibility mode for POv2, when enabled.  A value of `true` enables compatibility mode, and a value of `false`  disables it, so that the extension can run faster. 

**prefetch**: Enables or disables a script prefetch feature in the portal for diagnostics purposes. Reserved for team use. 

**rapidtoasts**: Enables or disables toast notifications, and sets the default time that a toast is displayed, in milliseconds.  A value of zero disables toasts. 

<!--TODO:  verify whether these relex settings have ceased to exist or are just not used -->
**relex**:  Not used.  Comma-delimited list of extensions to load in Relex. **NOTE**: An asterisk ("*") will load all extensions in Relex.

**relexsinglecomm=true**:  Not used. When run in conjunction with the `feature.relex` flag, runs the corresponding extensions in relex with a single web socket connection to relex for all extensions.

<!--TODO: Determine whether ?feature.resourcemenu=true belongs here.-->

**seetemplate**: "See template" link in Create blades. A value of `true`         ,  and a value of `false`      . 

**settingsprofile**: Loads a portal with the specified, isolated set of settings. It is used by the CI infrastructure to enable the loading of multiple portals in parallel without overwriting each other’s settings. Reserved for team use.

**ShowAffinityGroups**:  Set to allow users to add and select affinity groups in the portal.  A value of `true`         ,  and a value of `false`      .   

**showauditlogsaseventlogs**:  Changes audit log strings.

**showbugreportlink**:  Shows or hides the **Report bug** link in the top bar. A value of `true` shows the link,  and a value of `false` hides it.

**showpreviewtags**: Hides the preview ribbon on the startboard and shows labels in blade headers when extensions are marked as in preview.   **NOTE**: Does not hide the preview ribbon.

<!--TODO:  verify whether these relex settings have ceased to exist or are just not used -->
**showrelexdialog**:  Not used. Hides the relex dialog that is displayed if performance is slow.

**testhubsurl**:  Reserved for team use.

**testremoteurl**: Reserved for team use.

**testsamplesurl**: Reserved for team use.

**tilemgmt**: Reserved for future use.

**UserType**: A value of "test" excludes test traffic from Azure reports.

**verbosediagnostics**: Valid values are in the following table.
| Value | Meaning |
| ----- | ------- |
| all   | Includes default diagnostics and all filtered diagnostics in the Ctrl+Alt+A popup window | 
| permissions |  Includes default diagnostics and the permissions entry in the Ctrl+Alt+A popup window | 
| assets | Includes default diagnostics and the assets/assetManagement entries in the Ctrl+Alt+A popup window | 
| desktop | Includes default diagnostics and the desktop entry in the Ctrl+Alt+A popup window | 

**waitforpendingchanges**: Reserved for future use.


<!--TODO: Validate that "before flipping the switch" means enabling an extension in production. -->
<!--TODO: Validate that this information from the OneNote document is current. -->
**webworker**: Used in conjunction with **microsoft_azure_compute**. Enables the webworkers for all extensions that have explicitly set supporting webworkers, and forces **microsoft_azure_compute** into a web worker. For example, `feature.webworker=true,microsoft_azure_compute` can be added to the query string. Useful for testing extensions manually or through CI previous to enabling them in production.  

<!-- before flipping the switch.-->

<!-- TODO:  Find a name for the feature flags that are not invoked with the "feature.<name> syntax. -->

<a name="extension-flags-shell-feature-flags-features-other-than-the-feature-object"></a>
### Features other than the <code>feature</code> object

**hubsextension_showserverevents**:  Automatically shows all error and warning events as notifications.

**clientOptimizations**: Turns off bundling and minification of JavaScript to make debugging easier.    A value of `true` turns on bundling and minification,  and a value of `false` turns them both off. A value of `bundle` turns off JavaScript minification but retains bundling so the Portal still loads fairly quickly.  The value `bundle` is the suggested value for Portal extension debugging. 

<!-- Determine whether the following note is what was meant by "The 'bundle' value turns off JavaScript minification but retains bundling so the Portal still loads fairly quickly (which it doesn't for 'false' when bundling is turned off and many loose JavaScript files are loaded).". -->

**NOTE**:  A value of  `false` turns off bundling, but does not unload JavaScript files that were loaded.  
**Recommendation**:  When debugging an extension, the developer should supply `false` for this flag to disable script minification and to turn on additional diagnostics.

  **NOTE**:  This applies to both the portal and extensions source. If testing extensions that are already deployed to production, use the **clientOptimizations** flag instead of the ***IsDevelopmentMode** appSetting. If working in a development environment instead, use the ***IsDevelopmentMode** appSetting instead of the **clientOptimizations** flag to turn off bundling and minification for this extension only. This will speed up portal load during development and testing.  To change the ***IsDevelopmentMode** appSetting, locate the appropriate `web.config` file and change the value of the ***IsDevelopmentMode** appSetting to `true`.

<!--TODO:  Determine whether microsoft_azure_marketplace is an extension name or an example extension name.  If such is the case, then the following 4 flags should be documented as only the suffix name. -->

**microsoft_azure_marketplace_Curation**:  Associated with Marketplace extensions. Uses a named curation  . For more information about curations, see   .

**microsoft_azure_marketplace_curation**: Associated with Marketplace extensions. Uses a named curation . For more information about curations, see   .

<!--TODO:  Determine whether microsoft_azure_marketplace_ItemHideKey is different from microsoft_azure_marketplace_itemhidekey. -->

**microsoft_azure_marketplace_itemhidekey**: Associated with Marketplace extensions. Shows specified Marketplace items that are otherwise hidden, or shows unpublished items in the gallery. A value of `true` shows the item,  and a value of `false` hides it. Used in conjunction with **extensionName** when the extension is enabled. For example, if the hidekey is `DevTestLabHidden`,the following will display the extension in the "Create New" experience while it is enabled.
`https://portal.azure.com?<extensionName>=true&microsoft_azure_marketplace_ItemHideKey=DevTestLabHidden`.

**microsoft_azure_marketplace_quotaIdOverride**:  Associated with Marketplace extensions and the Create Launcher. A value of `true` ,  and a value of `false`. 

  **nocdn**: A value of `true` will bypass the CDN when loading resources for the portal only. A value of `force` will bypass the CDN when loading resources for the portal and all extensions.

**testExtensions**: Contains the name of the extension, and the environment in which the extension is located. For example, `?testExtensions={"HelloWorld":"https://localhost:44300/"}` specifies the intent to load the `HelloWorld` extension from the localhost port 44300 into the current session of the portal. The **name** and **uri**  parameters are as specified in [portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal](portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal).

<a name="extension-flags-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                | Meaning |
| ------------------- | --- |
| CDN                 | Content delivery network | 
| CI infrastructure   | | 
| configuration stamp | | 
| curation            | The process of categorizing content around a specific topic or area of interest. Curated items often formed into various types of collections and are displayed together according to theme or purpose. | 
| diagnostic switch  | |
| feature flag       | A coding technique that allows the enabling or disabling of new code within a solution. It allows the testing and development-level viewing of new features, before they are complete and ready for private preview.  |
| IRIS               | | 
| manifest caching | | 
| marketplace | | 
| MVC                | Model-View-Controller, a methodology of software organization that separates the view from the data storage model in a way that allows the processor or a controller to multitask or switch between applications or orientations without losing data or damaging the view.|
| NPS popups         | | 
| ProxiedObservables | | 
| query string       | | 
| stage | | 
| trace mode         | |
| web worker | |