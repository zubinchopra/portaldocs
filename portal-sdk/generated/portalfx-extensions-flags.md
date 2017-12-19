
<a name="extension-flags"></a>
# Extension flags

There are three types of flags that are associated with extensions. Using these flags allows the developer to make modifications to the server, to the browser, and to the extension code, regardless of the environment in which the extension is running.  Consequently, the purpose of each type of flag is similar but not identical. For example, flags that modify the environment in which the extension is running, instead of the extension itself, are either trace mode flags or diagnostic switches. 

* [Trace mode flags](#trace-modes)

  These instructions to the debugging environment will temporarily set specific server characteristics, toggle a specific behavior, or enable the logging of specific types of events. 

* [Diagnostic switches](#diagnostic-switches)

  These are directives to JavaScript within the browser. For example, the `clientOptimizations` flag is a directive  to JavaScript instead of the portal extension that is running in the browser. Other switches that go beyond selecting content for the browser console.log are outside of the scope of this document.
  
* [Feature flags](#feature-flags)

  These flags connect the extension to testing features that are within the Azure API. The Shell features are maintained by the Azure Portal team, but you can also create your own flags.

<a name="extension-flags-trace-modes"></a>
## Trace Modes

Trace mode flags are objects that exist inside the extension, and can be configured externally through the `.config` file. The trace mode that is included in the portal allows you to enable, disable, and filter tracking output. The information it displays is associated with debugging, moreso than with regular operation of the extension. The information that is other than standard console errors may be used to monitor application execution and performance in a deployed environment.  The errors that are presented in the console can be of great assistance in fixing extension issues. For more information about trace modes, see https://docs.microsoft.com/en-us/dotnet/framework/debug-trace-profile/how-to-create-initialize-and-configure-trace-switches.

 
<!--TODO:  Verify whether this section contains all trace modes for the Azure Portal. -->

Trace modes are enabled by appending a flag to the end of the query string. Trace mode syntax is as follows:  ```trace=<settingName>```, 
 where ```settingName```, without angle brackets, is the type of trace to run on the extension.


 The Azure trace mode flags are in the following list.

**desktop**: Log all shell desktop operations. Useful for reporting errors to the alias.

**diagnostics**: Display the debug hub, and add verbose tracing.

**inputsset.debug.viewModelOrPdlName**: Break into debugger when `onInputsSet` is about to be called on extension side. This trace can use the `viewmodel` name or the part/blade name to filter trace.

**inputsset.log.CommandViewModel**:  Further refine which view model to trace.

**inputsset.log.viewModelOrPdlName**: Log in console when `onInputsSet` is about to be called on extension side. This trace can use the `viewmodel` name or the part/blade name to filter trace.

**inputsset.log.WebsiteBlade**: Further refine which view model to trace.

**inputsset.verbose.viewModelOrPdlName**: Log in the console every time the shell evaluates whether `onInputsSet` should be called. This trace can use the viewmodel name or the part or blade name to filter trace. 

**partsettings.viewModelOrPartName**: Shows writes and reads of part settings for the specified part. This trace can use the `viewmodel` name or the part name to filter trace. 

**usersettings**:  Show all writes and reads to the user settings service. Great for debugging issues that require a 'reset desktop'. 

<a name="extension-flags-diagnostic-switches"></a>
## Diagnostic switches

 <!--TODO:  Validate that this statement is accurate for Azure Portal -->
 A variety of diagnostic switches can be used when debugging an extension. Diagnostic switches are slightly different from trace switches in that diagnostics may be controlled by the system, whereas traces are more dependent upon the logic of the code that is being debugged.

 The diagnostic switches are in the following list.

**clientOptimizations**: Turns off bundling and minification of JavaScript to make debugging easier.    A value of `true` turns on bundling and minification,  and a value of `false` turns them off.

  <!-- TODO: Spellcheck on the terms in the following paragraph:
  `web.config` 
  -->

  **NOTE**:  This applies to both the portal and extensions source. If testing extensions that are already deployed to production, use the `clientOptimizations` flag instead of the `*IsDevelopmentMode` appSetting. If working in a development environment instead, use the `*IsDevelopmentMode` appSetting instead of the `clientOptimizations` flag to  turn off bundling and minification for this extension only. This will speed up portal load during development and testing.  To change the `*IsDevelopmentMode` appSetting, locate the appropriate `web.config` file and change the value of the `*IsDevelopmentMode` appSetting to true.

<a name="extension-flags-feature-flags"></a>
## Feature Flags

Extension flags and feature flags are specially-formatted query string parameters that are sent through the portal to extensions and their controller methods.  They are often used while Testing in Production (TIP) to enable and disable features that are maintained in the extension code. Feature flags can only be used on program code, like form elements or HTML template components; they cannot be used to hide blades, parts, or commands. There is no pre-registration of feature flags because the process of using feature flags is dynamic.

Flags are only accessible by the extension in which they are defined, and therefore are not shared across extensions.  Most feature flags are set to a value of `true` or `false`, which respectively enables or disables the feature. However, some feature flags send non-Boolean values to the extension when more than two options are appropriate to test a specific feature.

There are no limitations on developer-designed feature flag names, except that they cannot contain underscores. The format of feature flags in the query string uses the following rules.

<!-- TODO:  determine whether the flag names are required to be lower case -->

* Must be formatted as `<extensionName><flagName>` (e.g. `azurecomputesomeflag`)
* Can have any non-empty value (e.g. `azurecomputesomeflag=true`)
* Should be lower case
* Cannot include an underscore in the flag portion of  name (i.e., `azure_compute_some_flag` does not work, but `azure_compute_someflag` works)

 In the following example, the  `pricingtier` feature flag is used in two different extensions. 

   ```https://portal.azure.com/?hubsextension_pricingtier=whatever1&microsoft_azure_billing_pricingtier=whatever2```

* From Hubs Extension

    `fx.environment.extensionFlags = { “hubsextension_pricingtier”: “value1” }`
 
* From Billing Extension

    `fx.environment.extensionFlags = { “microsoft_azure_billing_pricingtier”: “value2” }`

<a name="extension-flags-feature-flags-modifying-code-for-feature-flags"></a>
### Modifying code for feature flags

You can create feature flags for your extension, if you plan to manage them as a part of the software maintenance process.  Typically, the feature has a descriptive name; a value of `true` turns on the feature, and a value of `false` turns it off. The following code examples demonstrate how to turn feature flags on and off in your code. 

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

Feature flags can be enabled for all users in one or more deployments by using an extension configuration. This can be achieved as follows.

1. In your `ApplicationConfiguration` class, add the following property.

     ```cs
    [ConfigurationSetting]
    public CaseInsensitiveReadOnlyDictionary<IReadOnlyDictionary<string, string>> DefaultQueryString
    {
        get;
        private set;
    }
    ```

1. In your derived app context class (probably named `CustomApplicationContext`),  override the `GetDefaultQueryString` method.

     ```cs
    public override IReadOnlyDictionary<string, string> GetDefaultQueryString(string host)
    {
        return this.configuration.DefaultQueryString.GetValueOrDefault(host);
    }
    ```

1. Finally, in your config files (`web.config` or `cscfg`), add the following entry
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

The asterisk specifies the default case, and requests to the extension will enable those features, regardless of the domain.

Feature flags that are associated with the domain name in an environment, i.e. the domain name of the incoming extension requests, will take precedence over the feature flags that are in the default case.

</details>
<details>
<summary>Ajax</summary> 

*  Using the RequestFlags dictionary

    When using `MsPortalFx.Base.Net.ajax()`, extension flags are also sent to the controller methods. Ensure that the controllers extend the  `Microsoft.Portal.Framework.ApiControllerBase` method and use the `RequestFlags` dictionary to check, as in the following figure.

   ```cs
    if (RequestFlags.TryGetValue("microsoft_azure_compute_someflag", out value) && value == "true")
    {
        // turn on feature here
    }
   ```

*  Using the RequestFlags dictionary

    If you want to enable this for all users, you can configure  the `ApplicationContext`  to specify a list of default query string parameters by overriding the `GetDefaultQueryString` method, as in the following figure.

   ```cs
    public override IReadOnlyDictionary<string, string> GetDefaultQueryString(string host)
    {
        // read the default query string parameters from config and return.
    }
   ```

This option will make these feature flags available in client-code for all users.

<!-- TODO: Determine whether Ibiza contacts for feature flags should be added to the document -->
<!-- TODO:  determine whether browsecuration affects the Browse menu, the More Services menu, or both -->
<!-- TODO:  determine [Submit an ibiza-browse partner request](http://aka.ms/new-ibiza-browse-request) is the right link for custom curation  -->
</details>

For more information about feature flags, see [https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags](https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags).

<a name="extension-flags-feature-flags-shell-feature-flags"></a>
### Shell feature flags

The Ibiza Fx team supports the following feature flags, or shell feature flags. These flags are only available to the Shell unless they are configured to be shared. Unless otherwise noted, a value of true enables the extension, and a value of false disables it.

<!-- TODO:  Find a name for the feature flags that are not invoked with the "feature.<name> syntax. -->
There are two naming conventions for feature flags. Some feature flags have their own names, like **contactsExtension_dataprovider**; however, most flags can be considered to be a  property of the feature object, in which case they are invoked with the following syntax: ```feature.<featureName>=true```.

<!--TODO: can an extension name contain capital letters or special characters? -->
<!--TODO: can the canmodifystamps flag ever be required or included when it is false?  -->
<!--TODO: is the canmodifystamps always required when extensionName is used? -->

<a name="extension-flags-feature-flags-shell-feature-flags-features-invoked-without-feature-featurename-syntax"></a>
#### Features invoked without  <code>feature.&lt;featureName&gt;</code> syntax

**extensionName**:  The name of the extension. Can contain any character in the ranges between a-z or 0-9. Used to enable or disable an extension, or use a different configuration stamp.   When used with the `canmodifystamps` flag, this flag specifies the extension stamp that is located in a specific stage, or that is associated with a specific build. For more information about enabling and disabling extensions, see [portalfx-deployment.md#enable-or-disable-extensions-onboarding-ibiza](portalfx-deployment.md#enable-or-disable-extensions-onboarding-ibiza). For more information about extension stamps, see [portalfx-extensions-configuration-overview.md#extension-stamps](portalfx-extensions-configuration-overview.md#extension-stamps). 

**contactsExtension_dataprovider**:  .

**testExtensions**: Contains the name of the extension, and the environment in which the environment is located. It specifies the intent to load the extension `<extensionName>` from the `localhost:<Port_Number>` into the current session of the portal.

<a name="extension-flags-feature-flags-shell-feature-flags-feature-flags-prefaced-with-feature"></a>
#### Feature flags prefaced with &quot;feature&quot;

**abovethefold**:  A value of `true` means that the item is above the fold, or is initially displayed on the Web page without scrolling.  A value of `false` means that the item is not above the fold.

**autoenablemove**:  Shows or hides the **Change** (resource move) link in the **Essentials** menu for all resource types.  A value of `true` shows the links, and a value of `false` hides them.  The links are the edit buttons next to the resource group, and the subscription name in the **Essentials** menu.

**browsecategories**: Enables categories in the **Browse** menu.

<!--TODO: Validate what the default value is. -->
**browsecuration={fileName}**:  Switches the curation file used for the **More Services** menu, default favorites, and search results.  The default is ***available***.  To submit a partner request for custom curation to support a specific scenario, see [http://aka.ms/new-ibiza-browse-request](http://aka.ms/new-ibiza-browse-request).

**browsecurationflags={a,b}**:  Comma-delimited list of additional flags used while rendering browse curation.  The list is in the following table.
| Flag | Purpose |
| --- | --- | 
| (available: appservice, vms)  | |
| analytics | Merge **Intelligence** and **Analytics** categories |
| aws | Model **Compute** category after AWS  |
| cdn | Remove the **Media/CDN** category |
| databases | Rename the **Data** category to **Databases** |
| integration | Add all integration services to the **Enterprise Integration** category |
| management | Rename **Management + Security** to **Monitoring + Management** |
| oms | Group all OMS services together in the **Management** category |
| security | Rename **Identity + Access Management** to **Security + Identity** |
| sql | Add SQL Datawarehouses and SQL Server Stretch DBs kinds |
| storage | Add all storage services to the **Storage** category  
| vm | Rename **Compute** to **VMs**, and rename **Web + Mobile** to **App Services** |

**browsegrid2**: 

**canmodifyextensions**:  Required to support loading untrusted extensions for security purposes. For more information, see [portalfx-testinprod.md](portalfx-testinprod.md).

**canmodifystamps**:  Use a secondary test stamp.  See [portalfx-extensions-configuration-overview.md#extension-stamps](portalfx-extensions-configuration-overview.md#extension-stamps). If the developer is using a secondary test stamp, the following must be entered into the query string immediately after **canmodifystamps**: `=true`:  `&<extensionName>=<StageName_Or_BuildNumber>` ,where `extensionName` is the name of the extension, and `StageName_Or_BuildNumber` is the stage as specified in [portalfx-extensions-hosting-service-scenarios.md#sideloading](portalfx-extensions-hosting-service-scenarios.md#sideloading).  Use the stage name or build number which is deployed to a certain stage for StageName_Or_BuildNumber  <br>  StageName example: stage1  <br>  BuildNumber example: for a builld number of 1.0.8.31 replace the . with d, so it would be 1d0d8d31  .

**ci**:  Sets up  the portal up to  work better with tests by disabling NPS popups, , and other items.

**collapseessentials**:  .

**consoletelemetry**:  Logs most telemetry events to the browser console.

**customportal**:  Overrides the `ms.portal` redirect when signing in to portal.azure.com.

**deferredcss**:    .

**disableextensions**:  Disables all extensions. A value of `true` disables the extension,   and a value of `false` enables it. <br> **NOTE**: Extensions must be enabled explicitly with this flag, including Hubs. <br> Example: ?feature.DisableExtensions`=true&HubsExtension`=true&MyOtherExtension`=true  <br> This will make every extension disabled by default.  <br>  This will enable hubs (which almost everyone needs).  <br>  This will enable the particular extension you want to test.   <br>  You can add multiple like the green and blue one if you want to test other stuff.

**eagerlyrevealassetpart**:  Asset part will infer resource names from ARM resource IDs, and will auto-reveal its content as soon as it has an icon and name.

**earlyoninputsset**: .

**extloadtimeout**: `=0-9+  | Extension loading timeout (in seconds???).

**fakepreviewassets**: Reserved for internal Azure Portal use. <!-- `=true  | Forces Clocks and Hosts (from samples - see Client\V1\Blades\DynamicBlade\ViewModels) to be in preview (for testing only). A value of `true` forces the preview mode,  and a value of `false`       it. -->
  
**fastmanifest**:  Enables relex-based manifest caching.   A value of `true` enables  the caching,   and a value of `false`  disables it.

**feedback=false**:  Disables the feedback pane.

**forceiris**:  Forces the portal to query IRIS even if the time limit  has not expired.  Currently, the time limit is 24 hours.

**fullwidth**:  Forces all resource menu blades to be opened maximized.

<!-- TODO: Determine whether the  document should include what a feature is for, even if the feature is internal? -->

**hideavatartenant**: Reserved for internal Azure Portal use. <!-- Hides the directory name under the user's name in the avatar menu. -->

**inmemorysettings**:  Uses in-memory user settings.

**internalonly**:  Shows or hides the **Preview** banner in the top-left.  A value of `true` shows the banner,  and a value of `false` hides it.  

**irissurfacename**:  Defines the surface name to use when querying IRIS.

**multicloud**: .

**nodirectory**: `=true  | Opens the avatar menu after the user signs in.

**partgallerypivots**:   |   .

**pinnedextensions**: ={a,b,c}`  | Pins the specified extensions so that they are never unloaded during the lifetime of the portal.

**pov2**:  Use ProxiedObservables version 2 (POv2) .

**pov2compatibilitymode**:  Disable compatibility mode for POv2, when enabled.  A value of `true` enables compatibility mode,   and a value of `false`  disables it, so that the extension can run faster.  

**prefetch**:   |   .

<!--TODO:  verify whether these relex settings have ceased to exist or are just not used -->
****:relex={x}**:  Comma-delimited list of extensions to load in Relex <br> **NOTE**: `*` will load all extensions in Relex.

**relexsinglecomm=true**:  When run in conjunction with the `feature.relex` flag, runs the corresponding extensions in relex with a single web socket connection to relex for all extensions.

**seetemplate**: "See template" link in Create blades. A value of `true`         ,  and a value of `false`      .

**settingsportalinstance**: .  

**settingsprofile**:   .

**ShowAffinityGroups**:  Set to allow users to add and select affinity groups in the portal.  A value of `true`         ,  and a value of `false`      .   

**showauditlogsaseventlogs**: `=true  | Changes audit log strings.

**showbugreportlink**: =true|false  Shows or hides the **Report bug** link in the top bar. A value of `true` shows the link,  and a value of `false` hides it.

**showpreviewtags**: `=true  | Hides the preview ribbon on the startboard and shows labels in blade headers when extensions are marked as in preview  <br>  **NOTE**: Does not currently hide the preview ribbon.  

<!--TODO:  verify whether these relex settings have ceased to exist or are just not used -->
**showrelexdialog=false**:  Hides the relex dialog that is shown if performance is slow.

**spinnerbehavior**:  |   |

**testhubsurl**:=???  | ???  |

**testremoteurl**:  |   |

**testsamplesurl**:  |   |

**tilemgmt**:  |   |

**UserType**: A value of "test" excludes test traffic from Azure reports.

**waitforpendingchanges**: |   |

**webworker**: `=true,extensionName,extName`   A value of `true` enables webworkers in the portal who have explicitly been set as supporting webworkers in the `extensions.json` file for all extensions.

**webworker**: `=true,microsoft_azure_compute enables webworkers for all extensions who've explicitly been set as supporting webworkers, and forces microsoft_azure_compute into a web worker. Useful for testing extensions manually/through CI before flipping the switch.

**hubsextension_showserverevents=true**:  Automatically show all error and warning events as notifications. A value of `true` shows them as notifications,  and a value of `false` shows them as                                  . |
**microsoft_azure_marketplace_Curation**: `=???  | Uses a named curation  .

**microsoft_azure_marketplace_curation=???**:  Uses a named curation .

**microsoft_azure_marketplace_itemhidekey=???**:  Shows named items that are hidden in the Marketplace. A value of `true` shows the item,  and a value of `false` hides it. 

**microsoft_azure_marketplace_quotaIdOverride**: `=true  | ??? (something in the Create Launcher) . A value of `true` ,  and a value of `false` . 

**websitesExtension_PortalHost**: `=???  .



  <!-- TODO:  The following oneNote pages have been included in this document.

  Affinity Groups Feature Flag
  Extension feature flags  Feature flags

  there are some remaining questions about the inclusion of 
  Testing features behind feature flags

  -->