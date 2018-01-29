<a name="portal-extensions-configuration"></a>
# Portal Extensions Configuration

<!-- document headers are in the individual documents -->

<a name="portal-extensions-configuration-introduction"></a>
## Introduction

It is important to read this guide carefully, as we rely on you to manage the extension registration / configuration management process  in the Portal repository. External partners should also read this guide to understand the capabilities that Portal can provide for  extensions by using configuration. However, external partner requests should be submitted by sending an email to ```ibizafxpm@microsoft.com ``` instead of using the internal sites that are in this document. 

The subject of the email should contain the following.

``` <Onboarding Request ID> Add <extensionName> extension to the Portal  ```

where 

**Onboarding Request**: the unique identifier for the request, without the angle brackets

**extensionName**: the name of the extension

 The body of the email should contain the following information.

```json
Extension name: <Company>_<BrandOrSuite>_<ProductOrComponent>  
URLs:  (must adhere to pattern)
PROD:  main.<extensionName>.ext.contoso.com
Contact info:_________
Business Contacts:_________
Dev leads: _________
PROD on-call email: _________
```

The email may also contain the extension config file, as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).



## Overview

### Understanding the extension configuration in Portal

 The extension configuration file contains  information for all extensions registered in the Azure Portal. It is located in the Portal repository in the  `src/RDPackages/OneCloud/` directory that is located at [https://msazure.visualstudio.com/One/_git/AzureUX-PortalFx?version=GBdev](https://msazure.visualstudio.com/One/_git/AzureUX-PortalFx?version=GBdev). For more information about loading extension stamps, see [portalfx-extensions-testing-in-production-overview.md#registering-a-custom-extension](portalfx-extensions-testing-in-production-overview.md#registering-a-custom-extension).

For information on how developers can leverage secondary stamps, see [portalfx-extensions-configuration-overview.md#extension-stamps](./portalfx-extensions-configuration-overview.md#extension-stamps).
 
 The configuration file name is based on the environment name, as in the following code.  
 
 `Extensions.<EnvironmentName>.json`
 
 For example, ```Extensions.Prod.json``` contains the configuration for all extensions in the Production environment, and  `Extensions.dogfood.json` contains the configuration for all extensions in the Dogfood environment.

 The following file contains a typical configuration for an extension.

```json
{
     name: "Microsoft_Azure_Demo",
     uri: "//demo.hosting.portal.azure.net/demo",
     uriFormat: "//demo.hosting.portal.azure.net/demo/{0}",
     feedbackEmail: "azureux-demo@microsoft.com",
     cacheability: "manifest",
     disabled: true,
}
```

Its options are as follows.

* **name**:  Required. The name for the extension, as specified in the `Client\extension.pdl` file of the extension project.
    
    <!--TODO: for more information about the extension.pdl file, see ...  although the pdl file is related, it is really a separate subject -->

  Typically, the ```extension.pdl``` file looks like the following.
    ```json
      <?xml version="1.0" encoding="utf-8" ?>
      <Definition xmlns="http://schemas.microsoft.com/aux/2013/pdl">
      <Extension Name="Microsoft_Azure_Demo" Version="1.0" EntryPointModulePath="Program"/>
      </Definition>
    ```
  The only option that the file contains that is relevant to extensions is as follows.

  **Extension Name**:  the name of the extension in the following format:  ```<Company>_<BrandOrSuite>_<ProductOrComponent>```

    Examples:  ```Contoso_Azure_<extensionName>``` , ```Nod_Publishers_Azure_<extensionName> ```

  If the extension is in preview mode then the preview tag should also be added, as in the following example. 

    ```<Extension Name="Microsoft_Azure_Demo" Version="1.0" Preview="true" EntryPointModulePath="Program"/>```
 
* **uri**: Required. The uniform resource identifier for the extension. This consists of the uri of the provider, followed by a forward slash, followed by the directory or path that contains the extension. 
   
   * Hosting service uri
 
      The following example contains the ```uri``` for an extension  that is hosted by an extension hosting service.
    
      ```json
      uri: "//demo.hosting.portal.azure.net/demo",
      ```

      In the preceding example,  ```demo.hosting.portal.azure.net``` is the address of the provider and the second occurrence of ```demo``` is the directory or path that contains the extension.
   
   * DIY Hosting uri

      The following example contains the ```uri``` for an extension that is still using the DIY deployment.
    
      ```json
      uri: "//main.demo.ext.azure.com",
      ```

      In the preceding example, ```main.demo.ext.azure.com```  is the address of the provider of the extension.

      **NOTE**: For extensions that are not using a hosting service, we recommend that the `uri` follow the standard CNAME pattern, as specified in [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md). 

  When the user loads the extension in the Portal, it is loaded from the `uri` specified in the extension configuration. To update the ```uri```, send a pull request as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md). Additional extension stamps can be loaded by specifying the stamp name in the  `uri` and specifying the feature flag `feature.canmodifystamps=true`. For more information about feature flags, see [portalfx-extensions-feature-flags.md](portalfx-extensions-feature-flags.md).

* **uriFormat**: Required. The `uri` for the extension, followed by a forward slash, followed by a parameter marker that allows modification of the extension stamp.
    
  * Hosting service uriFormat

    The following code contains the `uriFormat` for an extension that is hosted by a hosting service.
    
    ```json
      uriFormat: "//demo.hosting.portal.azure.net/demo/{0}",
    ```

    In the preceding example,  ```demo.hosting.portal.azure.net``` is the address of the extension, ```demo``` is the name of the directory or path that contains the extension, and ``` {0} ``` is the parameter marker that will contain the value to substitute into the name string. The substitution specifies the environment from which to load the extension.

  * DIY Hosting uriFormat

    The following code describes the ```uriFormat``` parameter for extensions that have not yet onboarded a hosting service.

    ```json
      uri: "//main.demo.ext.azure.com",
      uriFormat: "//{0}.demo.ext.azure.com",
    ```

    In the preceding example, ```main.demo.ext.azure.com``` is the address of the provider,  ```demo.ext.azure.com``` is the address of the extension, and ``` {0} ``` is the parameter marker that will contain the value to substitute into the name string. The substitution specifies the environment from which to load the extension. For example, if the parameter contains a value of "perf", then the uriFormat would be     ```uriFormat: "//perf.demo.ext.azure.com",```.

      **NOTE**: We recommend that the `uriFormat` follow  the standard CNAME pattern, as specified in  [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md). 

  To update the `uriFormat`, send a pull request as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).
    
* **feedbackEmail**: Required. The email id to which to send all feedback about the extension. 

  To update the feedback email, send a pull request as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

* **cacheability**: Required. Enables caching of the extension on your extension server or on the client. The default value is "manifest".
      
  If legacy DIY deployment is being used, then you will need to do some work before the value of the `cacheability` attribute can be set to ```manifest```. Otherwise, the extension will reduce the performance of Azure Portal.

  **NOTE**: Setting the value of the `cacheability` attribute to `manifest` is a requirement for registering the extension into the Portal.  For assistance with caching, send a pull request as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).
    
  For more information about caching, see [portalfx-extension-homepage-caching.md](portalfx-extension-homepage-caching.md).

* **disabled**: Optional. Registers the extension configuration into the Portal in hidden mode.  A value of  `true` disables an extension, and a value of `false` enables the extension for display. The default value is `false`. For more information about enabling and disabling extensions, see [portalfx-extensions-configuration-scenarios.md#managing-the-configuration-of-the-extension](portalfx-extensions-configuration-scenarios.md#managing-the-configuration-of-the-extension).
 
* **flightUris**: Optional.  The uri concatenated to a friendly name in order to flight traffic to another stamp, as in the following example:  `//demo.hosting.portal.azure.net/demo/MPACFlight`.
 
 <!--TODO: Update portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md when it is determined that this flag should be here and/or in the feature flags document. -->
 
 * **scriptoptimze**: Leverage the performance optimizations in the base controller. A value of `true`  , whereas a value of `false` .

### Understanding which extension configuration to modify

The Azure Portal uses five different extension configuration files to manage the extension configuration. The description of mapping of the Portal environment to the extension configuration is located at [portalfx-extensions-branches.md](portalfx-extensions-branches.md).

### Extension Stamps

Because the hosting service provides a mechanism for deploying extensions using safe deployment practices, the Portal will load the version of the extension that is based on the region from where the customer is accessing the Portal. For more details, see the Hosting Service documentation located at [portalfx-extensions-hosting-service.md](portalfx-extensions-hosting-service.md).

If the Legacy DIY deployment registration format is used, then the Portal will always serve the stamp that is registered in the ```uri```. In the preceding  examples, the Portal will always serve main stamp of the extension.

Additional stamps can be accessed by using the ```uriFormat``` parameter that is specified in the extension config file.

To use a secondary test stamp, specify the `feature.canmodifystamps` flag, and add a parameter that matches the name of the  extension as registered in the Portal, as in the following example.

```json
name: "Microsoft_Azure_Demo",
uri: "//main.demo.ext.azure.com",
uriFormat: "//{0}.demo.ext.azure.com",
. . .
https://portal.azure.com?feature.canmodifystamps=true&Microsoft_Azure_Demo=perf 
```

 The Portal  will replace the ```{0}``` in the ```uriFormat``` string with ```perf```, and attempt to load the ```Microsoft_Azure_Demo``` extension from the ```https://perf.demo.ext.azure.com``` URL. The Portal always uses the  HTTPS protocol.

To override the stamp, specify the flag ```feature.canmodifystamps=true ```.  To specify an extension that is located in a specific stage, or that is associated with a specific build, use  `feature.canmodifystamps=true&<extensionName>=<StageName_Or_BuildNumber>`, where

**extensionName**: the name of the extension

 **StageName_Or_BuildNumber**:   The stage name or build number that is deployed to a specific stage, for example, stagename `stage1` or   `1d0d8d31` for  BuildNumber of 1.0.8.31. 
 **NOTE**: The dots in the build number are replaced with the letter "d".
 

<a name="portal-extensions-configuration-configuration-scenarios"></a>
## Configuration Scenarios

<a name="portal-extensions-configuration-configuration-scenarios-onboarding-a-new-or-existing-extension"></a>
### Onboarding a new or existing extension

<!--TODO:  Determine whether existing extensions should be changed to disabled mode, and if so, under what circumstances -->

All new extensions should always be added to the Portal configuration in disabled mode. To add an extension to the Portal, send a pull request, as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md). The following is an example of a pull request for registering a `Scheduler` extension in the Fairfax environment.
[https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/459608f61d5c36864affafe6eb9d230655f67a29?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/459608f61d5c36864affafe6eb9d230655f67a29?refName=refs%2Fheads%2Fdev).

<a name="portal-extensions-configuration-configuration-scenarios-managing-the-configuration-of-the-extension"></a>
### Managing the configuration of the extension

All extensions are registered into the Portal in the disabled state, therefore they are disabled by default.  This hides the extension from users, and it will not be displayed in the Portal. The extension remains in hidden mode until it is ready for public preview or GA. Partners use this capability to test the extension, or to host it for private preview. For more information about previews and Global Availability, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

To temporarily enable a disabled extension in private preview for this test session only, change the configuration by adding an extension override in the Portal URL, as in the following example.

`https://portal.azure.com?Microsoft_Azure_Demo=true`

where

`Microsoft_Azure_Demo`

is the name of the extension as registered with the Portal.

Conversely, the extension can temporarily be disabled for a session by changing this configuration attribute to a value of `false`. The extension cannot be temporarily enabled or disabled in the production environment.

As part of permanently enabling the extension, the developer should update the extension test count in the `%ROOT%\src\StbPortal\Website.Server.Tests\DeploymentSettingsTests.cs` file. Otherwise, the **disabled** property in the `config` file(s) can remain set to `false`. 

<a name="portal-extensions-configuration-configuration-scenarios-enabling-an-extension"></a>
### Enabling an extension

The extension can only be enabled in production after all exit criteria have been met. After all the stakeholders that are included in the exit criteria have signed off  on the extension, attach their emails to the workitem that is used for sending the pull request, as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

Enabling an extension requires two changes:
1. To enable the extension, remove the `disables` attribute from the config.
1. Update the enabled extension test count.

    An example of a pull request that enables the `HDInsight` extension in the Mooncake environment and increases the extension test is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/062ccb2ed5c5a8a086877e2d61dd6009242f17fc?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/062ccb2ed5c5a8a086877e2d61dd6009242f17fc?refName=refs%2Fheads%2Fdev).

<a name="portal-extensions-configuration-configuration-scenarios-converting-from-diy-deployment-to-a-hosting-service"></a>
### Converting from DIY deployment to a hosting service

<!-- TODO: Determine whether they meant "rollback" instead of "regression", which is a term that is typically used while testing. -->

To minimize the probability of regression, use the following procedure to migrate an extension from DIY deployment to a hosting service.

<details>

  <summary>1. Change the uri format to use a hosting service in the PROD environment</summary>

   An example of a pull request for modifying the `uriFormat` parameter is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/c22b81463cab1d0c6b2c1abc803bc25fb2836aad?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/c22b81463cab1d0c6b2c1abc803bc25fb2836aad?refName=refs%2Fheads%2Fdev).
</details>

<details>
  <summary>2. Flight changes in MPAC</summary>

  An example of a pull request for a flighting extension in MPAC is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev).

</details>

<details>
  
  <summary>3. Enable 100% traffic in MPAC and PROD</summary>
  
  An example of a pull request that enables 100% traffic without flighting for `MicrosoftAzureClassicStorageExtension`, and 100% traffic with flighting for `Microsoft_Azure_Storage` is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/b81b415411f54ad83f93d43d37bcad097949a4e3?refName=refs%2Fheads%2Fdev&discussionId=-1&_a=summary&fullScreen=false](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/b81b415411f54ad83f93d43d37bcad097949a4e3?refName=refs%2Fheads%2Fdev&discussionId=-1&_a=summary&fullScreen=false). 
</details>

<details>

  <summary>4. Enable flighting in MPAC</summary>

  The Azure Portal provides the ability to flight the MPAC customers to multiple stamps. Traffic will be equally distributed between all registered stamps.  An example of a pull request is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev).
    
  * Hosting service `extension.pdl` file

    To flight traffic to multiple stamps, register other stamps in `flightUri`. For example, the friendly name `MPACFlight` is used to flight traffic to another stamp, as in the following example.

    ``` 
    { 
      name: "Microsoft_Azure_Demo", 
      uri: "//demo.hosting.portal.azure.net/demo", 
      uriFormat: "//demo.hosting.portal.azure.net/demo/{0}", 
      feedbackEmail: "azureux-demo@microsoft.com", 
      flightUris: [
        "//demo.hosting.portal.azure.net/demo/MPACFlight",
      ],
    }
    ```
  * Legacy deployment `extension.pdl` file

    DIY deployment can also flight traffic to multiple stamps, as in the following example.

    ``` 
    {
        name: "Microsoft_Azure_Demo",
        uri: "//main.demo.ext.azure.com",
        uriFormat: "//{0}.demo.ext.azure.com",
        feedbackEmail: "azureux-demo@microsoft.com",
        flightUris: [
            "//flight.demo.ext.azure.com",
        ],
      }
    ``` 
</details>

<a name="portal-extensions-configuration-configuration-scenarios-manifest-caching"></a>
### Manifest caching
The performance of an extension can be improved  by changing  how the extension uses caches.

**>> Work In Progress <<**

<!--TODO:  locate the work that is in progress, and add it to the document.  Should this have been Best Practices? -->

For more information about extension caching, see [portalfx-extension-homepage-caching.md](portalfx-extension-homepage-caching.md).

<a name="portal-extensions-configuration-configuration-scenarios-pcv1-and-pcv2-removal"></a>
### PCV1 and PCV2 removal
Removing PCV1 and PCV2 code from an extension can improve performance.
<!--TODO:  locate the work that is in progress, and add it to the document -->

**>> Work In Progress <<**

<a name="portal-extensions-configuration-configuration-scenarios-updating-the-feedback-email"></a>
### Updating the feedback email
<!--TODO:  locate the work that is in progress, and add it to the document -->

**>> Work In Progress <<**

To update the feedback email, send a pull request as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

<a name="portal-extensions-configuration-service-level-agreements-for-deployment"></a>
## Service Level Agreements for deployment

As per the safe deployment mandate, all the configuration changes are treated as code changes. Consequently, they use similar deployment processes.

All changes that are checked in to the dev branch will be deployed in the following order: **Dogfood** -> **RC** -> **MPAC** -> **PROD** -> National Clouds (**BlackForest**, **FairFax**, and **Mooncake**).  The following table in [portalfx-extensions-svc-lvl-agreements.md](portalfx-extensions-svc-lvl-agreements.md) specifies the amount of time allowed to complete the deployment.

<a name="portal-extensions-configuration-expediting-deployment"></a>
## Expediting deployment

To deploy expedited changes, developers can send a pull request for each branch in the Portal repository, i.e., Dogfood, MPAC and Production. How to send the pull request is specified in  [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

Typically, all pull requests are for the Dev branch. When a pull request for an environment is marked as complete, the specified commit can be cherry-picked from that environment and included in a pull request for the next branch. The dev branch is followed by the **Dogfood** branch, which in turn is followed by the **MPAC** branch and finally the production branch.

If the pull request is not sent in the specified order, or if the commit message is changed, then unit test failure may occur. In this case, the changes that are associated with the extension will be reverted without notice.

The SLA for deploying configuration changes to all regions in the Production Environment is in the following table.

| Environment | Service Level Agreement |
| ----------- | ------- |
| PROD	      | 7 days  |
| BLACKFOREST | 10 days |
| FAIRFAX	  | 10 days |
| MOONCAKE    |	10 days |

As per the safe deployment mandate, deployment to production environment is performed in stages, where each stage is a logical grouping of regions. There are five stages in the production environment. There is a 24-hour wait period between promoting the build from one batch to another. This implies that the minimum time to deploy a change in all regions in Production branch is five days. For more information about staging, see    .

<a name="portal-extensions-configuration-receiving-notification-when-changes-are-deployed"></a>
## Receiving notification when changes are deployed

After the commit has been associated with a workitem, the developer will receive a notification when the config change is deployed to each region.

When the development team wants to subscribe to these changes, ask them to make a comment on the workitem. After they have made changes, they will start receiving the notifications.

<a name="portal-extensions-configuration-frequently-asked-questions"></a>
## Frequently asked questions

<a name="portal-extensions-configuration-frequently-asked-questions-ssl-certs"></a>
### SSL certs

***How do I use SSL certs?***

[portalfx-extensions-faq-onboarding2.md#sslCerts](portalfx-extensions-faq-onboarding2.md#sslCerts)

* * *

<a name="portal-extensions-configuration-frequently-asked-questions-loading-different-versions-of-an-extension"></a>
### Loading different versions of an extension

***How do I load different versions of an extension?***

Understanding which extension configuration to modify is located at [portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify](portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify).




<a name="portal-extensions-configuration-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

<!-- TODO:  Determine the difference between a branch, a region, and an environment. They are not  completely interchangeable, then we can standardize usage. -->

| Term                     | Meaning |
| ---                      | --- |
| BF                       | Black Forest |
| branch | |
| build verification test  | A subset of regression testing, this is a set of non-exhaustive tests that verify whether the most important application functions work. Its results are used to determine whether a build is stable enough to proceed with further testing. |
| BVT                      | Build Verification Test |
| cherry-pick              | Apply the changes introduced by an existing GitHub commit. |
| CDN                      | Content Delivery Network |
| CNAME                    | Canonical Name record. A type of resource record in the Domain Name System (DNS) that specifies that a domain name is an alias for another domain (the 'canonical' domain). | 
| DF                       | Dogfood |
| DIY                      | Do It Yourself |
| environment              | A configuration of computers in which extensions can be run. For example, environments are Blackforest, Dogfood, Mooncake, and Production.  | 
| feature flag             | A switch that allows a user to turn on or off specific functionalities of an extension. Flags are  passed from the Portal to extensions and their controllers, and are used as an alternative to maintaining multiple source-code branches in order to hide, enable or disable a feature during run time. Most, but not all, feature flags are made available by using the syntax `feature.<featureName> = true`.   |
| FF                       | Fairfax |
| flighting                | |
| flighting extension      | |
| GA                       | Global Availability |
| iframe                   | An inline frame, used to embed another document within the current HTML document. |
| MC                       | Mooncake |
| MPAC                     | ms.portal.azure.com, the Azure Portal instance for internal Microsoft customers.  | 
| PCV1                     | Parameter Collector V1 |
| PCV2                     | Parameter Collector V2 |
| PDL                      | Program Design Language |
| preview                  | The development phase that is used by the developer and a small audience to validate the functionality of an extension. |
| PROD                     | Production |
| region                   | The area in the world that that is served by a specific localization site. | 
| RC                       | Release Candidate environment, used to deploy daily builds of the Azure Portal. There is no user traffic in this environment. |
| RP                       | Resource Provider |
| SLA                      | Service Level Agreement |
| smoke test               | see build verification test  |
| SSL                      | Secure Socket Layer |
| stakeholder              | A person, group or organization that has interest or concern in an organization. Stakeholders can affect or be affected by the organization's actions, objectives and policies. |
| stamp                    | An instance of a service in a region. Every extension can deploy one or more stamps based on testing requirements. The main stamp is used for production and is the only one that the Portal will load by default.    | 
| URI                      | Universal Resource Identifier  | 
| URL                      | Uniform Resource Locator |


  