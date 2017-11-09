
# Extension flags

Extension flags are specially-formatted querystring parameters passed from the portal to extensions and their controllers. Extension flags are not shared across extensions - they are only accessible by the extension they are defined for. Extension flags cannot be used to hide blades, parts, or commands. They can only be used to enable/disable programmatic code (e.g. form elements, HTML template components).

Extension flags have the following rules:

* Must be formatted as `{extension}_{flag}` (e.g. `microsoft_azure_compute_someflag`)
* Can have any non-empty value (e.g. `?microsoft_azure_compute_someflag=true`)
* Should be lower case
* Cannot include an underscore (_) in the flag name (e.g. `microsoft_azure_compute_some_flag` will not work)

Use the `MsPortalFx.isFeatureEnabled` and  `MsPortalFx.getFeatureValue` APIs to access feature values in TypeScript:

E.g. 1

https://portal.azure.com?microsoft_azure_compute_someflag=true

```ts
if (MsPortalFx.isFeatureEnabled("someflag"))
{
    // turn on new feature
}
```

E.g. 2

https://portal.azure.com?microsoft_azure_compute_someotherflag=value1

```ts
switch (MsPortalFx.getFeatureValue("someotherflag"))
{
    case "value1":
        // behavior 1
        break;
    case "value2":
        // behavior 1
        break;
    default:
        // default behavior
        break;
}
```

## Enabling for all users in an environment
Feature flags can be enabled for all users in one or more deployments through the configuration of an extension. This can be achieved as follows: -

In your `ApplicationConfiguration` class, add the following property.

```cs
[ConfigurationSetting]
public CaseInsensitiveReadOnlyDictionary<IReadOnlyDictionary<string, string>> DefaultQueryString
{
    get;
    private set;
}
```

In your derived app context class (probably called CustomApplicationContext) override the GetDefaultQueryString method


```cs
public override IReadOnlyDictionary<string, string> GetDefaultQueryString(string host)
{
    return this.configuration.DefaultQueryString.GetValueOrDefault(host);
}
```

Finally, in your config files (web.config/cscfg), add the following entry
```
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

Using * implies that a request to the extension will enable those features no matter what the domain is.
Feature flags associated with the domain name of the environment i.e. the domain name of the incoming requests, will take precedence over the feature flags in '*'.


When using `MsPortalFx.Base.Net.ajax()`, extension flags are also passed to your controller. Ensure your controllers extend `Microsoft.Portal.Framework.ApiControllerBase` and use the `RequestFlags` dictionary to check:

```cs
if (RequestFlags.TryGetValue("microsoft_azure_compute_someflag", out value) && value == "true")
{
    // turn on feature here
}
```

Also, if you want to enable this for all users, you can enable this by configuring the `ApplicationContext` to specify a list of default query string parameters by overriding the `GetDefaultQueryString` method.

```cs
public override IReadOnlyDictionary<string, string> GetDefaultQueryString(string host)
{
    // read the default query string parameters from config and return.
}
```

This will make these feature flags available in client-code for all users.

## Shell feature flags
The Fx team supports the following feature flags:
| Feature | Notes |
|---------|-------|
| `clientOptimizations={true,false}` | Turns off bundling and minification of JavaScript to make debugging easier.  NOTE: This applies to both the portal and extensions source. |
| `feature.autoenablemove=true` | Shows the "change" (resource move) link in Essentials for all resource types |
| `feature.browsecuration={name}` | Switches the curation file used for the More Services menu, default favorites, and search results (available: default). [Submit an ibiza-browse partner request](http://aka.ms/new-ibiza-browse-request) for custom curation to support a specific scenario. |
| `feature.browsecurationflags={a,b}` | Comma-delimited list of additional flags used to render Browse curation (available: appservice, aws, vms) |
| `feature.canmodifyextensions=true` | See [Testing In Production](portalfx-testinprod.md) |
| `feature.canmodifystamps=true` | See [Extension Stamps](portalfx-deployment.md#before-deploying-extension-2-extension-stamps) |
| `feature.consoletelemetry=true` | Logs most telemetry events to the browser console |
| `feature.customportal=false` | Overrides the ms.portal redirect when signing in to portal.azure.com |
| `feature.disableextensions=true` | Disables all extensions (NOTE: Extensions must be enabled explicitly with this flag, including Hubs) |
| `feature.feedback=false` | Disables the feedback pane |
| `feature.fullwidth=true` | Forces all menu blades to be opened maximized |
| `feature.internalonly=true|false` | Shows/hides the "Preview" banner in the top-left |
| `feature.inmemorysettings=true` | Uses in-memory user settings |
| `feature.pinnedextensions={a,b}` | Comma-delimited liste of extensions to keep loaded (and never unload) |
| `feature.pov2=true` | Use POv2 (ProxiedObservables version 2) |
| `feature.pov2compatibilitymode=false` | Disable compatibility mode for POv2 (when enabled) to run faster. |
| `feature.relex={x}` | Comma-delimited list of extensions to load in Relex (NOTE: `*` will load all extensions in Relex) |
| `feature.relexsinglecomm=true` | When run in conjunction with the feature.relex flag, runs the corresponding extensions in relex with a single web socket connection to relex for all extensions |
| `feature.showbugreportlink=true|false` | Shows/hides the "Report bug" link in the top bar |
| `feature.showrelexdialog=false` | Hides the relex dialog that is shown if performance is slow	|
| `{extension-name}=true|false` | Enables/disables an extension. See [Enable/disable extensions](portalfx-deployment.md#before-deploying-extension-1-for-extensions-onboarding-ibiza-enable-disable-extensions). |
| `{extension-name}=a-z0-9+` | Enables an extension and uses a different stamp; requires canmodifystamps=true. See [Extension Stamps](portalfx-deployment.md#before-deploying-extension-2-extension-stamps). |
| `hubsextension_showserverevents=true` | Automatically show all error and warning events as notifications |
| `microsoft_azure_marketplace_curation=???` | Uses a named curation |
| `microsoft_azure_marketplace_itemhidekey=???` | Shows named items that are hidden in the Marketplace |