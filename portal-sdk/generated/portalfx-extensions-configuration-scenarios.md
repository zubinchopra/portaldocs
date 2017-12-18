<a name="understanding-scenarios-for-changing-configs"></a>
## Understanding scenarios for changing configs

<a name="understanding-scenarios-for-changing-configs-onboarding-a-new-or-existing-extension-in-the-portal"></a>
### Onboarding a new or existing extension in the portal
All new extensions should always be added to the portal configuration in disabled mode. 
The following is an example of a pull request for registering a ``` Scheduler ``` extension in the Fairfax environment.
[https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/459608f61d5c36864affafe6eb9d230655f67a29?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/459608f61d5c36864affafe6eb9d230655f67a29?refName=refs%2Fheads%2Fdev).

<a name="understanding-scenarios-for-changing-configs-managing-the-configuration-of-the-extension"></a>
### Managing the configuration of the extension

All extensions are registered into the portal in the disabled state, therefore they are disabled by default.  This hides the extension from users, and it will not be displayed in the portal. The extension will remain in hidden mode until it is ready for public preview or GA. This is useful if the extension is not yet ready for the public preview phase or the GA phase. Partners use this capability to test the extension, or to host it for private preview. For more information about previews and Global Availability, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

To temporarily enable a disabled extension in private preview for this test session only, change the configuration by adding an extension override in the portal URL, as in the following example.

``` https://portal.azure.com?Microsoft_Azure_Demo=true ```

where

``` Microsoft_Azure_Demo ```

is the name of the extension as registered with the portal.

Conversely, the  extension can temporarily be disabled for a session by changing this configuration attribute to a value of `false`. The extension cannot be temporarily enabled or disabled in the production environment.

As part of permanently enabling the extension, the developer should update the extension test count in the `%ROOT%\src\StbPortal\Website.Server.Tests\DeploymentSettingsTests.cs` file. Otherwise, the **disabled** property in the `config` file(s) can be left with a value of `false`. 

<a name="understanding-scenarios-for-changing-configs-enabling-an-extension-in-the-portal"></a>
### Enabling an extension in the portal

The extension can only be enabled in production after all exit criteria have been met. Once you have received sign-off from all the stakeholders that are included in the exit criteria for the extension, please attach the email to the workitem that is used for sending the pull request, as specified in  [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

Enabling an extension requires two changes:
1.	To enable the extension, just remove the ```disables``` boolean attribute from the config.
1.	Update the enabled extension count in test.

    An example of a pull request for enabling ``` HDInsight ``` extension in the Mooncake environment is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/062ccb2ed5c5a8a086877e2d61dd6009242f17fc?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/062ccb2ed5c5a8a086877e2d61dd6009242f17fc?refName=refs%2Fheads%2Fdev).

<a name="understanding-scenarios-for-changing-configs-moving-from-diy-deployment-to-an-extension-hosting-service"></a>
### Moving from DIY deployment to an Extension hosting service
If the extension is being migrated from DIY deployment to a hosting service, we recommend using the following steps  to minimize the probability of regression.

1. Change the ``` uri ``` format to use a hosting service in the PROD environment

   An example of a pull request for modifying the ``` uriFormat ``` parameter is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/c22b81463cab1d0c6b2c1abc803bc25fb2836aad?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/c22b81463cab1d0c6b2c1abc803bc25fb2836aad?refName=refs%2Fheads%2Fdev)

1. Flight changes in MPAC

    An example of a pull request for a flighting extension in MPAC is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev)

1. Enable 100% traffic in MPAC and PROD

    An example of a pull request that shows enabling 100% traffic without flighting for ```MicrosoftAzureClassicStorageExtension```, and 100% traffic with flighting for ```Microsoft_Azure_Storage``` is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/b81b415411f54ad83f93d43d37bcad097949a4e3?refName=refs%2Fheads%2Fdev&discussionId=-1&_a=summary&fullScreen=false](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/b81b415411f54ad83f93d43d37bcad097949a4e3?refName=refs%2Fheads%2Fdev&discussionId=-1&_a=summary&fullScreen=false).

1. Enable flighting in MPAC

    The Azure Portal provides the ability to flight the MPAC customers to multiple stamps. Portal will distribute the traffic equally between all the registered stamps.    An example of a pull request is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev).
    
    * Hosting service extension.pdl file

      To flight traffic to multiple stamps, register other stamps in ```flightUri```. For example, ``` MPACFlight ```
       (friendly name) is used to flight traffic to another stamp.

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
    * Legacy deployment extension.pdl file

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

    An example of a pull request is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev).

<a name="understanding-scenarios-for-changing-configs-manifest-caching"></a>
### Manifest Caching
The performance of an extension can be improved  by changing  how the extension uses caches.

Work In Progress

<!--TODO:  locate the work that is in progress, and add it to the document.  Should this have been Best Practices? -->

For more information about extension caching, see [portalfx-extension-homepage-caching.md](portalfx-extension-homepage-caching.md).

<a name="understanding-scenarios-for-changing-configs-pcv1-and-pcv2-removal"></a>
### PCV1 and PCV2 Removal
Removing PCV1 and PCV2 code from an extension can improve performance.
<!--TODO:  locate the work that is in progress, and add it to the document -->

Work In Progress

<a name="understanding-scenarios-for-changing-configs-updating-the-feedback-email"></a>
### Updating the feedback email
<!--TODO:  locate the work that is in progress, and add it to the document -->

Work In Progress

To update the feedback email, send a pull request as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).


<a name="sla-for-deploying-the-configuration-changes"></a>
## SLA for deploying the configuration changes

As per the safe deployment mandate, all the configuration changes are treated as code change. This implies that all configuration changes will go through the same deployment process as code change.

All changes checked-in to dev branch will be deployed in following order:

Dogfood -> RC -> MPAC -> PROD -> National Clouds (BF, FF and MC).
| Environment	| SLA |
| --- | --- |
| DOGFOOD | 	5 days |
| RC	| 10 days |
| MPAC	| 15 days |
| PROD	| 20 days |
| BLACKFOREST | 	1 month |
| FAIRFAX	| 1 month | 
| MOONCAKE | 	1 month | 

<a name="expediting-the-deployment-of-configuration-changes"></a>
## Expediting the deployment of configuration changes

In order to expedite the deployment of changes, you can send a pull request for each branch in the portal repository, i.e., Dogfood, MPAC and Production. How to send the pull request is specified in  [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

Typically, all pull requests are for the Dev branch. When a pull request for an environment is marked as complete, the specified commit can be cherry-picked from that environment and included in a pull request for the next branch. The dev branch is followed by the Dogfood branch, which in turn is followed by the MPAC branch and finally the production branch. 

If the pull request is not sent in the specified order, or if the commit message is changed, then it will lead to unit Test failure. In case of test failure, the  changes that are associated with the extension will be reverted without notice.

The SLA for deploying configuration changes to all regions in the Production Environment is in the following table.

| Environment	| SLA |
| --- | --- |
| PROD	 | 7 days |
| BLACKFOREST	 | 10 days |
| FAIRFAX	 | 10 days |
| MOONCAKE | 	10 days |

As per the safe deployment mandate, deployment to production environment will be done in stages. Each stage is a logical grouping of regions. There are five stages in production environment. And, there is a 24-hour wait period between promoting the build from one batch to another. This implies that the minimum time to deploy a change in all regions in Production branch is five days.

<a name="receiving-notification-when-changes-are-deployed"></a>
## Receiving notification when changes are deployed

After the commit has been associated with a workitem, you will receive a notification when the config change is deployed to each region.

When other people in your team want to subscribe to these changes, please ask them to make a comment on the workitem. Once they have made a change they will start receiving the notifications.