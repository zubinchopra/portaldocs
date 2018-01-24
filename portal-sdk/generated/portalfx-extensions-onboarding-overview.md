<a name="introduction"></a>
## Introduction
   
Welcome to Azure! We're excited to have you to join the family and become a partner. The Azure Portal team supports the Azure Portal, its SDK, and the Framework that service teams use to integrate their management UI into the Azure Portal.

The Microsoft Azure Portal, located at [https://portal.azure.com](https://portal.azure.com), is a central place where Azure customers can provision and manage Azure resources. The Azure Portal is a [single page application](portalfx-extensions-onboarding-glossary.md) that may contain more than one Web application. The parts of the page in the Portal are dynamically loaded based on customer actions.

A UI extension is essentially the user experience (UX) for a service. Extensions are developed by teams that integrate user interfaces into the Azure Portal. Extensions are dynamically accessed and loaded based on customer actions in the Portal. For example, when a customer clicks on the `Virtual Machines` icon in the Azure Portal, then the Portal loads the Virtual Machines extension. This extension provides the UI that allows the user to provision and manage virtual machines, as in the following image. 

<!--TODO:  Determine whether the following image is acceptable, because it is not fictitious. -->

![alt-text](../media/portalfx-extensions-onboarding/vmMachines.png "Virtual Machine Extension")

Extension developers can quickly grow a business by networking with a large pool of Azure Portal customers when they develop extensions for Azure Portal.

<a name="onboarding-a-service"></a>
## Onboarding a service

Onboarding a service, or developing a Portal extension, has three phases: private preview, public preview, and Global Availability (GA). Azure Portal onboarding is creating a UI for a service in Azure Portal, and is a subset of Azure onboarding.

Most services that onboard to Azure can leverage the following components of the Azure ecosystem:
1. Management APIs that are exposed via Azure Resource Manager (ARM) or Microsoft Graph
1. Management UI in the Azure Portal and/or other tools/websites, like Visual Studio
1. Marketing content on the Azure Web site or other websites

The Azure onboarding process is streamlined to optimize the delivery of high-quality experiences based on hundreds of hours of usability testing that meet Microsoft Common Engineering Criteria (CEC) and compliance requirements. This will better optimize developer resources and reduce re-working due to anti-patterns and inconsistencies that block usability, performance, and other factors. Therefore, we strongly recommend starting the onboarding process previous to designing UI or management APIs.
