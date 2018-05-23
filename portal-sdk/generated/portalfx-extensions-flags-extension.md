
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
 
<a name="extension-flags-the-support-extension"></a>
### The support extension

<!--TODO:  Determine whether there are other extensions that can be used by developer extensions that require code changes in addition to the query string feature flag. -->

Azure provides a support extension so that every resource that subscribes can assess its health, check the audit logs, get troubleshooting information, or open a support ticket.  Every extension should reach out to the <a href="mailto:AzSFAdoption@microsoft.com?subject=Onboarding with the Support team&body=Hello, I have a new extension that needs to opt in to to the features that Troubleshooting and Support provides.">Azure Self-Help Adoption Core Team at AzSFAdoption@microsoft.com</a> to opt in to the support system and UX integration.

The developer needs to add code to the extension for each setting that will be used.  The following flags are used in coordination with the support extension, as specified in [top-blades-settings.md#support-settings](top-blades-settings.md#support-settings).

After the extension has been modified for the support extension, these flags can be used to obtain various types of support.  They are invoked as follows. 

```js
   &<extensionName>=troubleshootsettingsenabled=true
   &<extensionName>=healthsettingsenabled=true
   &<extensionName>=requestsettingsenabled=true
```

<!-- TODO:  Determine the actions that are performed by the other two flags. -->

* **troubleshootsettingsenabled**:  A value of `true`   , and a value of `false`    .

* **healthsettingsenabled**: A value of `true`   , and a value of `false`    .

* **requestsettingsenabled**:  A value of `true` enables troubleShooting from the support extension, and a value of `false` disables it.  This implies that coordination between your team and the Support team has been completed so that the support extension can respond to this flag setting.


<a name="extension-flags-the-azure-content-delivery-network"></a>
### The Azure Content Delivery Network

The Azure Content Delivery Network, as specified in [portalfx-pde-cdn.md](portalfx-pde-cdn.md), requires code changes and allows the use of an extension flag to provide the capability to send audio, video, images, and other files to customers.


<a name="extension-flags-feature-flag-api-contract"></a>
### Feature flag API contract

Developers can create flags for extensions, and plan to manage them as a part of the software maintenance process.  Typically, the flag is boolean and has a descriptive name. A value of `true` turns on the feature, and a value of `false` turns it off. 

The following sections demonstrate how to turn extension  flags on and off inside the code. 

* [Reading flags in TypeScript](#reading-flags-in-typescript)

* [Programming default values for flags in C#](#programming-default-values-for-flags-in-c#)

* [Reading flags in the context of an AJAX call in C#](#reading-flags-in-the-context-of-an-AJAX-call-in-c#)

<a name="extension-flags-feature-flag-api-contract-reading-flags-in-typescript"></a>
#### Reading flags in TypeScript

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

<a name="extension-flags-feature-flag-api-contract-programming-default-values-for-flags-in-c"></a>
#### Programming default values for flags in C#

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
    'dogfood.websitesextension.com': {healthsettingsenabled
            'websitesextension_':'true'
    }
    }" />
    ```

    * The asterisk specifies the default case. The flag will be set to the specified value for all requests to the extension, regardless of the domain.

    * Flags that are associated with the domain name in an environment, i.e. the domain name of the incoming extension requests, will take precedence over the flags that are in the default case.

<a name="extension-flags-feature-flag-api-contract-reading-flags-in-the-context-of-an-ajax-call-in-c"></a>
#### Reading flags in the context of an AJAX call in C#

*  Using the RequestFlags dictionary

    When using `MsPortalFx.Base.Net.ajax()`, extension flags are also sent to the controller methods. The controller should extend the  `Microsoft.Portal.Framework.ApiControllerBase` method to receive the flag value. The extension can use the `RequestFlags` dictionary to check whether a flag is being sent to the controller, as in the following code.

   ```cs
    if (RequestFlags.TryGetValue("microsoft_azure_compute_someflag", out value) && value == "true")
    {
        // turn on feature here
    }
   ```

<!-- TODO:  determine whether browsecuration affects the Browse menu, the More Services menu, or both -->

<a name="extension-flags-other-feature-flag-services"></a>
### Other feature flag services

<!--TODO: Determine whether 
 ?feature.disablebladecustomization still qualifies as being a feature flag. -->

For more information about extension flags, see [https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags](https://docs.microsoft.com/en-us/vsts/articles/phase-features-with-feature-flags).

You can ask questions on Stackoverflow with the tag [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza).
