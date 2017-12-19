
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
