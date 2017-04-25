<a name="feature-flags"></a>
# Feature flags

Feature flags are specially-formatted querystring parameters extensions can use to enable or alter functionality. Feature flags can be used to enable/disable programmatic code (e.g. form elements, HTML template components, behavior). Feature flags cannot be used to hide blades, parts, or commands. If you need to hide parts, switch to [template blades](#portalfx-blades-templateBlade) and hide content accordingly. If you need to hide commands, use the [toolbar](#user-content-basic-concepts-blades-introduction-to-templateblade-adding-commands-to-a-templateblade).

Feature flags have the following rules:

* Shell flags must be formatted at `feature.{feature}` (e.g. `feature.fullwidth=true`)
* Shell flags are only available to the Shell (unless configured to be shared)
* Extension flags must be formatted as `{extension}_{feature}` (e.g. `?microsoft_azure_compute_someflag=somevalue`)
* Extension flags are only available to the extension named by the flag
* Can have any non-empty value (e.g. `?microsoft_azure_compute_someflag=1`)
* Should be lower case and not case-sensitive (feature names are lower-cased automatically by the below APIs)
* Cannot include an underscore (_) in the flag name (e.g. `microsoft_azure_compute_some_flag` will not work)

Use the `MsPortalFx.isFeatureEnabled()` and `MsPortalFx.getFeatureValue()` functions to access feature values:

```ts
// get boolean value indicating whether the flag is enabled -- portal.azure.com?microsoft_azure_compute_someflag=true
if (MsPortalFx.isFeatureEnabled("someflag"))
{
    // turn on new feature
}

// get specific value as a string to support multiple values -- portal.azure.com?microsoft_azure_compute_someotherflag=value1
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

<a name="feature-flags-enabling-for-all-users-in-an-environment"></a>
## Enabling for all users in an environment
Feature flags can be enabled for all users in one or more deployments through the configuration of an extension. This can be achieved as follows:

In your `ApplicationConfiguration` class, add the following property.

```cs
[ConfigurationSetting]
public CaseInsensitiveReadOnlyDictionary<IReadOnlyDictionary<string, string>> DefaultQueryString
{
    get;
    private set;
}
```

In your derived app context class (probably called `CustomApplicationContext`) override the `GetDefaultQueryString` method


```cs
public override IReadOnlyDictionary<string, string> GetDefaultQueryString(string host)
{
    return this.configuration.DefaultQueryString.GetValueOrDefault(host);
}
```

Finally, in your config files (web.config/cscfg), add the following entry

```xml
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

Using `*` implies that a request to the extension will enable those features no matter what the domain is.
Feature flags associated with the domain name of the environment (i.e. the domain name of the incoming requests, will take precedence over the feature flags in `*`).


When using `MsPortalFx.Base.Net.ajax()`, feature flags are also passed to your controller. Ensure your controllers extend `Microsoft.Portal.Framework.ApiControllerBase` and use the `RequestFlags` dictionary to check:

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

<a name="feature-flags-shell-feature-flags"></a>
## Shell feature flags
The Fx team supports the following feature flags:

| Feature | Notes |
|---------|-------|
| `feature.autoenablemove=true` | Shows the "change" (resource move) link in Essentials for all resource types |
| `feature.browsecuration={name}` | Switches the curation file used for the More Services menu, default favorites, and search results (available: default). [Submit an ibiza-browse partner request](http://aka.ms/new-ibiza-browse-request) for custom curation to support a specific scenario. |
| `feature.browsecurationflags={a,b}` | Comma-delimited list of additional flags used to render Browse curation (available: appservice, aws, vms) |
| `feature.canmodifyextensions=true` | See [http://aka.ms/portalfx/tip](http://aka.ms/portalfx/tip) |
| `feature.canmodifystamps=true` | See [http://aka.ms/portalfx/deployment#stampoverride](http://aka.ms/portalfx/deployment#stampoverride) |
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
| `{extension-name}=true|false` | Enables/disables an extension. See http://aka.ms/portalfx/deployment#disabled. |
| `{extension-name}=a-z0-9+` | Enables an extension and uses a different stamp; requires canmodifystamps=true. See http://aka.ms/portalfx/deployment#stampoverride. |
| `hubsextension_showserverevents=true` | Automatically show all error and warning events as notifications |
| `microsoft_azure_marketplace_curation=???` | Uses a named curation |
| `microsoft_azure_marketplace_itemhidekey=???` | Shows named items that are hidden in the Marketplace |

