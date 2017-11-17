## Understanding scenarios for changing configs
### Onboarding a new or existing extension in the portal
All new extensions should always be added to the portal configuration in disabled mode. 
The following is an example of a pull request for registering a ``` Scheduler ``` extension in the Fairfax environment.
[https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/459608f61d5c36864affafe6eb9d230655f67a29?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/459608f61d5c36864affafe6eb9d230655f67a29?refName=refs%2Fheads%2Fdev).

### Enabling an extension in the portal

The extension can only be enabled in production after all exit criteria have been met. Once you have received sign-off from all the stakeholders that are included in the exit criteria for the extension, please attach the email to the workitem that you will use for sending the pull request. How to send the pull request is specified in  [portalfx-extensions-pullRequest.md](portalfx-extensions-pullRequest.md).

Enabling an extension requires two changes:
1.	To enable the extension, just remove the ```disables``` boolean attribute from the config.
1.	Update the enabled extension count in test.

    An example of a pull request for enabling ``` HDInsight ``` extension in the Mooncake environment is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/062ccb2ed5c5a8a086877e2d61dd6009242f17fc?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/062ccb2ed5c5a8a086877e2d61dd6009242f17fc?refName=refs%2Fheads%2Fdev).

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

### Manifest Caching
You can improve the performance of the extension by changing  the extension uses caches.

Work In Progress

<!--TODO:  locate the work that is in progress, and add it to the document.  Should this have been Best Practices? -->

For more information about extension caching, see [portalfx-extension-homepage-caching.md](portalfx-extension-homepage-caching.md).

### PCV1 and PCV2 Removal
Removing PCV1 and PCV2 code from an extension can improve performance.
<!--TODO:  locate the work that is in progress, and add it to the document -->

Work In Progress

### Updating the feedback email
<!--TODO:  locate the work that is in progress, and add it to the document -->

Work In Progress

To update the feedback email, send a pull request as specified in [portalfx-extensions-pullRequest.md](portalfx-extensions-pullRequest.md).


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

## Expediting the deployment of configuration changes

In order to expedite the deployment of changes, you will need to send the pull request for each branch in portal repository, i.e., Dogfood, MPAC and Production. How to send the pull request is specified in  [portalfx-extensions-pullRequest.md](portalfx-extensions-pullRequest.md).

All the pull requests should be sent for Dev branch. Once the pull request is marked as complete then you can cherry-pick the same commit from the dev branch and send the pull request for the Dogfood branch. Once the Dogfood pull request is marked complete, then you can cherry-pick the same commit from the dogfood branch and send the pull request for for MPAC branch. Once the MPAC pull request is marked complete then you can cherry-pick the same commit from the PAC branch and send the pull request for the production branch. 

If the pull request is not sent in the previously specified order, or the if commit message is changed, then it will lead to unit Test failure. In case of test failure, the  changes that are associated with the extension will be reverted without notice.

The SLA for deploying configuration changes to all regions in the Production Environment is in the following table.

| Environment	| SLA |
| --- | --- |
| PROD	 | 7 days |
| BLACKFOREST	 | 10 days |
| FAIRFAX	 | 10 days |
| MOONCAKE | 	10 days |

As per the safe deployment mandate, deployment to production environment will be done in stages. Each stage is a logical grouping of regions. There are five stages in production environment. And, there is a 24-hour wait period between promoting the build from one batch to another. This implies that the minimum time to deploy a change in all regions in Production branch is five days.

## Receiving notification when changes are deployed

Since you have associated your commit with a workitem, you will receive a notification when the config change that you have submitted is deployed to each region.

When other people in your team want to subscribe to these changes, please ask them to make a comment on the workitem. Once they have made a change they will start receiving the notifications.