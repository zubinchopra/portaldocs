
<a name="extension-flags"></a>
## Extension Flags

Extension flags are specially-formatted query string parameters that are sent through the Portal to extensions and their controller methods.  They are often used while testing to enable and disable features that are maintained in the source code. Flags can only be used on items like form elements or HTML template components; they cannot be used to hide blades, parts, or commands. 

Flags are only accessible by the extension in which they are defined, and therefore are not shared across extensions. Typically, the flag is boolean and has a descriptive name. Most flags are set to a value of `true` or `false`, which respectively enables or disables the feature. However, some  flags send non-boolean values to the extension when more than two options are appropriate to test a specific feature.

Extension features are enabled by appending a flag to the query string, as in the following example: `https://portal.azure.com/?<extensionName>_<flagName>=<value>`, where ```flagName```, without angle brackets, is the feature to enable for the extension. The extension name and the underscore are used by the Portal to determine the extension for which the flag applies.

The only limitation on developer-designed flag names is that they cannot contain underscores. Flags are named according to the following rules.
* Are all lower case
* Must be formatted as `<extensionName>_<flagName>` (e.g. `azurecompute_someflag`)
* Can contain any non-empty value (e.g. `azurecompute_someflag=true`)
* Cannot include an underscore in the flag portion of the name (i.e., `azure_compute_some_flag` does not work, but `azure_compute_someflag` works)
 
<a name="extension-flags-feature-flag-api-contract"></a>
### Feature flag API contract

Developers can create flags for extensions, and plan to manage them as a part of the software maintenance process.  Typically, the flag is boolean and has a descriptive name. A value of `true` turns on the feature, and a value of `false` turns it off. 

The following code examples demonstrate how to turn extension  flags on and off inside the code. 

<details>
<summary>Reading flags in **TypeScript** </summary>

* Detecting whether a flag is set

    Use the ```MsPortalFx.isFeatureEnabled``` and  ```MsPortalFx.getFeatureValue``` APIs to access feature values in **TypeScript**, as in the following code.

    Query string with parameters: `https://portal.azure.com?azure_compute_someflag=true`

   ```ts
    if (MsPortalFx.isFeatureEnabled("someflag"))
    {
        // turn on new feature
    }
   ```

*  Detecting the value of a flag

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
<summary>Programming default values for flags in C#</summary>

Flags can be enabled for all users in one or more deployments by using an extension configuration, as in the following code. 

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

* The asterisk specifies the default case. The flag will be set to the specified value for all requests to the extension, regardless of the domain.

* Flags that are associated with the domain name in an environment, i.e. the domain name of the incoming extension requests, will take precedence over the flags that are in the default case.

</details>
<details>
<summary>Reading flags in the context of an AJAX call in C#</summary> 

*  Using the RequestFlags dictionary

    When using `MsPortalFx.Base.Net.ajax()`, extension flags are also sent to the controller methods. The controller should extend the  `Microsoft.Portal.Framework.ApiControllerBase` method to receive the flag value. The extension can use the `RequestFlags` dictionary to check whether a flag is being sent to the controller, as in the following code.

   ```cs
    if (RequestFlags.TryGetValue("microsoft_azure_compute_someflag", out value) && value == "true")
    {
        // turn on feature here
    }
   ```

<!-- TODO:  determine whether browsecuration affects the Browse menu, the More Services menu, or both -->

</details>

<br>

For more information about extension flags, see [https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags](https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags).

You can ask questions on Stackoverflow with the tag [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza).
