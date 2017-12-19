## Configuration Scenarios

### Onboarding a new or existing extension

<!--TODO:  Determine whether existing extensions should be changed to disabled mode, and if so, under what circumstances -->

All new extensions should always be added to the portal configuration in disabled mode. To add an extension to the portal, send a pull request, as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md). The following is an example of a pull request for registering a `Scheduler` extension in the Fairfax environment.
[https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/459608f61d5c36864affafe6eb9d230655f67a29?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/459608f61d5c36864affafe6eb9d230655f67a29?refName=refs%2Fheads%2Fdev).

### Managing the configuration of the extension

All extensions are registered into the portal in the disabled state, therefore they are disabled by default.  This hides the extension from users, and it will not be displayed in the portal. The extension remains in hidden mode until it is ready for public preview or GA. Partners use this capability to test the extension, or to host it for private preview. For more information about previews and Global Availability, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

To temporarily enable a disabled extension in private preview for this test session only, change the configuration by adding an extension override in the portal URL, as in the following example.

`https://portal.azure.com?Microsoft_Azure_Demo=true`

where

`Microsoft_Azure_Demo`

is the name of the extension as registered with the portal.

Conversely, the extension can temporarily be disabled for a session by changing this configuration attribute to a value of `false`. The extension cannot be temporarily enabled or disabled in the production environment.

As part of permanently enabling the extension, the developer should update the extension test count in the `%ROOT%\src\StbPortal\Website.Server.Tests\DeploymentSettingsTests.cs` file. Otherwise, the **disabled** property in the `config` file(s) can remain set to `false`. 

### Enabling an extension

The extension can only be enabled in production after all exit criteria have been met. After all the stakeholders that are included in the exit criteria have signed off  on the extension, attach their emails to the workitem that is used for sending the pull request, as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

Enabling an extension requires two changes:
1. To enable the extension, remove the `disables` attribute from the config.
1. Update the enabled extension test count.

    An example of a pull request that enables the `HDInsight` extension in the Mooncake environment and increases the extension test is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/062ccb2ed5c5a8a086877e2d61dd6009242f17fc?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/062ccb2ed5c5a8a086877e2d61dd6009242f17fc?refName=refs%2Fheads%2Fdev).

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

### Manifest caching
The performance of an extension can be improved  by changing  how the extension uses caches.

**>> Work In Progress <<**

<!--TODO:  locate the work that is in progress, and add it to the document.  Should this have been Best Practices? -->

For more information about extension caching, see [portalfx-extension-homepage-caching.md](portalfx-extension-homepage-caching.md).

### PCV1 and PCV2 removal
Removing PCV1 and PCV2 code from an extension can improve performance.
<!--TODO:  locate the work that is in progress, and add it to the document -->

**>> Work In Progress <<**

### Updating the feedback email
<!--TODO:  locate the work that is in progress, and add it to the document -->

**>> Work In Progress <<**

To update the feedback email, send a pull request as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

## Service Level Agreements for deployment

As per the safe deployment mandate, all the configuration changes are treated as code changes. Consequently, they use similar deployment processes.

All changes that are checked in to the dev branch will be deployed in the following order: **Dogfood** -> **RC** -> **MPAC** -> **PROD** -> National Clouds (**BlackForest**, **FairFax**, and **Mooncake**).  The following table specifies the amount of time allowed to complete the deployment.

| Environment | Service Level Agreement     |
| ----------- | ------- |
| DOGFOOD     |	5 days  |
| RC	      | 10 days |
| MPAC	      | 15 days |
| PROD	      | 20 days |
| BLACKFOREST |	1 month |
| FAIRFAX	  | 1 month | 
| MOONCAKE    |	1 month | 

## Expediting deployment

To deploy expedited changes, developers can send a pull request for each branch in the portal repository, i.e., Dogfood, MPAC and Production. How to send the pull request is specified in  [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

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

## Receiving notification when changes are deployed

After the commit has been associated with a workitem, the developer will receive a notification when the config change is deployed to each region.

When the development team wants to subscribe to these changes, ask them to make a comment on the workitem. After they have made changes, they will start receiving the notifications.