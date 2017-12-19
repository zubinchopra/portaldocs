


<a name="extension-flags"></a>
# Extension flags
    
There are three types of flags that are associated with extensions. Using these flags allows the developer to make modifications to the server, to the browser, and to the extension code, regardless of the environment in which the extension is being tested.  Consequently, the purpose of each type of flag is similar but not identical. For example, flags that modify the environment in which the extension is running, instead of the extension itself, are either trace mode flags or diagnostic switches. 

* [portalfx-extensions-feature-flags-trace-mode.md](portalfx-extensions-feature-flags-trace-mode.md)

  These instructions to the debugging environment will temporarily set specific server characteristics, toggle a specific behavior, or enable the logging of specific types of events. 

* [portalfx-extensions-feature-flags-diagnostics.md](portalfx-extensions-feature-flags-diagnostics.md)

  These are directives to JavaScript. For example, the `clientOptimizations` flag is a directive to the browser instead of the portal extension that is running in the browser. Switches that have functionality other than selecting content for the browser `console.log` are outside of the scope of this document.
  
* [portalfx-extensions-feature-flags-developer.md](portalfx-extensions-feature-flags-developer.md)

  These flags connect the extension to testing features that are within the Azure API. Developers can create and maintain their own flags.

*  [portalfx-extensions-feature-flags-shell.md](portalfx-extensions-feature-flags-shell.md)

  These flags connect the extension to testing features that are within the Azure API. The Shell features are maintained by the Azure Portal team.


<a name="extension-flags-trace-mode-flags"></a>
## Trace Mode Flags

Trace mode flags are associated with code that exists inside the portal, and can be configured externally through the `.config` file. The trace mode allows the developer to enable, disable, and filter tracking output. The information it displays is associated with debugging, moreso than with regular operation of the extension. This information is an addition to standard console errors, and it can be used to monitor application execution and performance in a deployed environment.  The errors that are presented in the console assist in fixing extension issues. For more information about trace modes, see [https://docs.microsoft.com/en-us/dotnet/framework/debug-trace-profile/how-to-create-initialize-and-configure-trace-switches](https://docs.microsoft.com/en-us/dotnet/framework/debug-trace-profile/how-to-create-initialize-and-configure-trace-switches).

 <!--TODO:  Verify whether this section contains all trace modes for the Azure Portal. -->

Trace modes are enabled by appending a flag to the end of the query string. Trace mode syntax is as follows:  ```trace=<settingName>```, 
 where ```settingName```, without angle brackets, is the type of trace to run on the extension.

 The Azure trace mode flags are in the following list.

**desktop**: Log all shell desktop operations. Useful for reporting errors to the alias.

**diagnostics**: Display the debug hub, and add verbose tracing.

**inputsset.debug.viewModelOrPdlName**: Break into debugger when `onInputsSet` is about to be called on extension side. This trace can use the `viewmodel` name or the blade or part name to filter trace.

**inputsset.log.CommandViewModel**:  Add refinement to the selection of which view model to trace.

<!--TODO:  Validate how this works if onInputSet is being replaced. -->
**inputsset.log.viewModelOrPdlName**: Log in console when `onInputsSet` is about to be called on extension side. This trace can use the `viewmodel` name or the blade or part name to filter trace.

**inputsset.log.WebsiteBlade**: Further refine which view model to trace.

**inputsset.verbose.viewModelOrPdlName**: Log in the console every time the shell evaluates whether `onInputsSet` should be called. This trace can use the viewmodel name or the part or blade name to filter trace. 

**partsettings.viewModelOrPartName**: Shows writes and reads of settings for the specified part. This trace can use the `viewmodel` name or the part name to filter the trace. 

**usersettings**:  Show all writes and reads to the user settings service. Great for debugging issues that require a 'reset desktop'. 



<a name="extension-flags-diagnostic-switches"></a>
## Diagnostic switches

 <!--TODO:  Validate that this statement is accurate for Azure Portal -->
 A variety of diagnostic switches can be used when debugging an extension. Diagnostic switches are slightly different from trace switches in that diagnostics may be controlled by the system, whereas traces are more dependent upon the logic of the code that is being debugged.

 The diagnostic switches are in the following list.

**clientOptimizations**: Turns off bundling and minification of JavaScript to make debugging easier.    A value of `true` turns on bundling and minification,  and a value of `false` turns them off.

  **NOTE**:  This applies to both the portal and extensions source. If testing extensions that are already deployed to production, use the **clientOptimizations** flag instead of the ***IsDevelopmentMode** appSetting. If working in a development environment instead, use the ***IsDevelopmentMode** appSetting instead of the **clientOptimizations** flag to turn off bundling and minification for this extension only. This will speed up portal load during development and testing.  To change the ***IsDevelopmentMode** appSetting, locate the appropriate `web.config` file and change the value of the ***IsDevelopmentMode** appSetting to `true`.



<a name="extension-flags-feature-flags"></a>
## Feature Flags

Extension flags and feature flags are specially-formatted query string parameters that are sent through the portal to extensions and their controller methods.  They are often used while Testing in Production (TIP) to enable and disable features that are maintained in the extension code. Feature flags can only be used on items like form elements or HTML template components; they cannot be used to hide blades, parts, or commands. There is no pre-registration of feature flags because the process of using feature flags is dynamic.

Flags are only accessible by the extension in which they are defined, and therefore are not shared across extensions. Typically, the flag is boolean and has a descriptive name. Most feature flags are set to a value of `true` or `false`, which respectively enables or disables the feature. However, some feature flags send non-boolean values to the extension when more than two options are appropriate to test a specific feature.

The only limitation on developer-designed feature flag names is that they cannot contain underscores. Feature flags are named according to the following rules.

* Must be formatted as `<extensionName><flagName>` (e.g. `azurecomputesomeflag`)
* Can contain any non-empty value (e.g. `azurecomputesomeflag=true`)
* Are all lower case
* Cannot include an underscore in the flag portion of the name (i.e., `azure_compute_some_flag` does not work, but `azure_compute_someflag` works)

<!--TODO:  Determine whether any upper case letters are optional.  -->

 In the following example, the  `pricingtier` feature flag is used in two different extensions. 

   ```https://portal.azure.com/?hubsextension_pricingtier=whatever1&microsoft_azure_billing_pricingtier=whatever2```

* From Hubs Extension

    `fx.environment.extensionFlags = { “hubsextension_pricingtier”: “value1” }`
 
* From Billing Extension

    `fx.environment.extensionFlags = { “microsoft_azure_billing_pricingtier”: “value2” }`

<a name="extension-flags-feature-flags-modifying-code-for-feature-flags"></a>
### Modifying code for feature flags

Developers can create feature flags for extensions, and plan to manage them as a part of the software maintenance process.  Typically, the feature is boolean and has a descriptive name. A value of `true` turns on the feature, and a value of `false` turns it off. The following code examples demonstrate how to turn feature flags on and off inside the code. 

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
<!-- TODO:  determine [Submit an ibiza-browse partner request](http://aka.ms/new-ibiza-browse-request) is the right link for custom curation  -->

</details>

<br>

For more information about feature flags, see [https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags](https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags).



<a name="extension-flags-shell-feature-flags"></a>
## Shell feature flags

The Ibiza Fx team supports the following feature flags, or Shell feature flags. These flags are only available to the Shell, unless they are configured to be shared. Unless otherwise noted, a value of `true` enables the extension, and a value of `false` disables it.

There are two naming conventions for feature flags. Some feature flags have their own names, like **hubsextension_showserverevents**; however, the syntax for most feature flags assumes they are a property of the feature object, in which case they are invoked with the  syntax: ```feature.<featureName>=true```.

<!--TODO: can an extension name contain capital letters or special characters? -->
<!--TODO: can the canmodifystamps flag ever be required or included when it is false?  -->
<!--TODO: is the canmodifystamps always required when extensionName is used? -->

<a name="extension-flags-shell-feature-flags-feature-flags-from-the-feature-object"></a>
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

<a name="extension-flags-shell-feature-flags-features-other-than-the-feature-object"></a>
### Features other than the <code>feature</code> object

**extensionName**:  The name of the extension, which is used as a feature flag. Can contain any character in the ranges between [a-z] or [0-9]. Requires the `canmodifystamps` flag to contain a value of `true` in order to be in effect. Used to enable or disable an extension, or use a different configuration stamp.  A value of `true` will temporarily enable a disabled extension, and a value of `false` will temporarily disable it, as in the following example: `https://portal.azure.com?Microsoft_Azure_DevTestLab=true`.  For more information, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

**canmodifystamps**: Specifies the extension stamp that is located in a specific stage, or that is associated with a specific build. For more information about enabling and disabling extensions, see [portalfx-deployment.md#enable-or-disable-extensions-onboarding-ibiza](portalfx-deployment.md#enable-or-disable-extensions-onboarding-ibiza). For more information about extension stamps, see [portalfx-extensions-configuration-overview.md#extension-stamps](portalfx-extensions-configuration-overview.md#extension-stamps). 

**hubsextension_showserverevents**:  Automatically shows all error and warning events as notifications.

**microsoft_azure_marketplace_Curation**:  Associated with Marketplace extensions. Uses a named curation  . For more information about curations, see   .

**microsoft_azure_marketplace_curation**: Associated with Marketplace extensions. Uses a named curation . For more information about curations, see   .

**microsoft_azure_marketplace_itemhidekey**: Associated with Marketplace extensions. Shows specified Marketplace items that are otherwise hidden. A value of `true` shows the item,  and a value of `false` hides it. Used in conjunction with **extensionName** when the extension is enabled. For more information about hidekeys, see   .

**microsoft_azure_marketplace_quotaIdOverride**:  Associated with Marketplace extensions and the Create Launcher. A value of `true` ,  and a value of `false`. 

**testExtensions**: Contains the name of the extension, and the environment in which the environment is located. It specifies the intent to load the extension `<extensionName>` from the `localhost:<portNumber>` into the current session of the portal. The **name** and **uri**  parameters are as specified in [portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal](portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal).



<a name="extension-flags-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                | Meaning |
| ------------------- | --- |
| CI infrastructure   | | 
| configuration stamp | | 
| curation            | The process of categorizing content around a specific topic or area of interest. Curated items often formed into various types of collections and are displayed together according to theme or purpose. | 
| diagnostic switch  | |
| feature flag       | A coding technique that allows the enabling or disabling of new code within a solution. It allows the testing and development-level viewing of new features, before they are complete and ready for private preview.  |
| IRIS               | | 
| MVC                | Model-View-Controller, a methodology of software organization that separates the view from the data storage model in a way that allows the processor or a controller to multitask or switch between applications or orientations without losing data or damaging the view.|
| NPS popups         | | 
| ProxiedObservables | | 
| TIP                | Testing in Production  |
| trace mode         | |