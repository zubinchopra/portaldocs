<a name="portal-extensions-for-developers"></a>
# Portal Extensions for Developers

<a name="portal-extensions-for-developers-introduction"></a>
## Introduction

Welcome to the Azure portal! We're excited to have you to join the family. The Azure Portal UI team supports Ibiza and the Portal Framework, and can help you with onboarding a service into the Management UI in the Azure portal.

<a name="portal-extensions-for-developers-overview"></a>
## Overview

The user experience for services that are visible in the Azure Portal are named extensions and blades, or context panes.  Some examples of context panes are in the following image.

![alt-text](../media/portalfx-create/plus-new.png  "Extensions and Context Panes")

Onboarding a service, or developing a portal extension, has three phases: private preview, public preview, and Global Availability (GA). 

Most services that onboard to Azure can leverage the following components of the Azure ecosystem:
1. Management APIs that are exposed via Azure Resource Manager (ARM) or Microsoft Graph
1. Management UI in the Azure portal and/or other tools/websites, like Visual Studio
1. Marketing content on the Azure Web site or other websites

The Azure onboarding process is streamlined to optimize the delivery of high quality experiences based on hundreds of hours of usability testing that meet Microsoft Common Engineering Criteria (CEC) and compliance requirements. Do not start designing UI or management APIs until after the onboarding process begins, to ensure the latest patterns and practices are being followed. This will better optimize developer resources and reduce re-working due to anti-patterns and inconsistencies that block usability, performance, and other factors.

The Azure Fundamentals are a set of Tenets each Azure service is expected to adhere to. The Azure Fundamentals program is described in this document [Azure Fundamentals](https://microsoft.sharepoint.com/:w:/r/teams/WAG/EngSys/_layouts/15/Doc.aspx?sourcedoc=%7BF5B821BC-31C4-4042-ADB5-5EBF4D8B408D%7D&file=Azure%20Fundamentals%20Proposal.docx&action=edit&mobileredirect=true). The document also identifies the stakeholders and contacts for each of the Tenets.

The Azure Fundamentals document is located at [https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d](https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d).

Compliance criteria and practices are defined in Quality Essentials throughout the development cycle. These ensure that services meet the Trusted Cloud commitments outlined in the Microsoft Azure Trust Center for our customers. These are required procedures for preview and Global Availability, and are to be revisited for every release cycle.

The customer has a different set of expectations for the extension in each phase. To meet customer expectations, we have compiled exit criteria for each phase. The development of an extension  can proceed to the next step when it meets the exit criteria for the current step. To meet customer expectations and continue to increase customer satisfaction, several quality metrics are tracked for every extension by the Get1CS team. An overview of Quality Essentials is located at [https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx](https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx). There may be tools to install from thr QE and 1CS sites that are part of the Quality Essentials process. The Azure team only tracks the exit criteria and localization requirements.

Nearly 70% of Azure users are from outside of the United States. Therefore, it is important to make Azure a globalized product. There are a few internationalization requirements that the extension or service is required to support. This is the same set of languages that are supported by Azure Portal for GA.

<a name="portal-extensions-for-developers-for-more-information"></a>
## For More Information

For more information about development phases, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

For more information about Azure Fundamentals, see [https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d](https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d).

For more information about the Microsoft Azure Trust Center, see [http://azure.microsoft.com/en-us/support/trust-center/](http://azure.microsoft.com/en-us/support/trust-center/).

For more information about exit criteria, see [portalfx-extensions-exitCriteria.md](portalfx-extensions-exitCriteria.md).

For more information about Quality Essentials, see [https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx](https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx).

 For more information about quality metrics, see the One Compliance System Web site that is located at [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx).

For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). 

For more information about localization requirements, see [portalfx-localization.md](portalfx-localization.md). 

For more information about azure.com onboarding, see [http://acomdocs.azurewebsites.net](http://acomdocs.azurewebsites.net).



<a name="portal-extensions-for-developers-requirements-for-azure-services"></a>
## Requirements for Azure Services

All services using Azure Billing must be exposed by using the Azure Resource Manager (ARM). Services that do not use Azure Billing can use either ARM or Microsoft Graph. Usually, services that integrate deeply with Office 365 use Graph, while all others are encouraged to use ARM. 

For more information about ARM API, see Azure Resource Manager (ARM) API Reference, located at [https://docs.microsoft.com/en-us/dynamics365/customer-engagement/customer-insights/ref/armapiref](https://docs.microsoft.com/en-us/dynamics365/customer-engagement/customer-insights/ref/armapiref), and also see Resource Manager REST APIs, located at [https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-rest-api](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-rest-api).

For more information about onboarding with Microsoft Graph, see [https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/resources/azure_ad_overview](https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/resources/azure_ad_overview).

The Azure portal SDK doesn't require any specific back-end, but does provide extra support for ARM-based resources. 

All new services should be listed in the Azure Web site that is located at [https://azure.microsoft.com](https://azure.microsoft.com). This isn't a requirement for onboarding the portal, but service categorization is the same between the azure.com Products menu, portal Services menu, and the Azure Marketplace. The service should not be listed in the portal unless it is also on azure.microsoft.com.


<a name="portal-extensions-for-developers-quality-essentials"></a>
## Quality Essentials

Quality Essentials  and 1CS provide access to manage the release policies and procedures for each compliance. QE tracks the following policies.
* Accessibility
* Global readiness
* Global trade compliance
* License terms
* Open source software
* Privacy
* Security Development Lifecycle (SDL)
* Software integrity

Some of the procedures such as Accessibility, GB Certificate, Privacy, and Security are also measured in the Service Health Review Scorecard that is located at [https://aka.ms/shr](https://aka.ms/shr), and in the exit criteria for management review and tracking. 

These requirements apply to both the portal fx and extensions. Since Fx provides the common infrastructure and UI controls that govern the data handling and UX, hence some of the compliance work for extensions would be identical across in Ibiza, and rationally be mitigated by the Framework. For example, Accessibility support on keyboard navigation and screen reader recognition, as well as the regional format and text support to meet globalization requirements, are implemented at the controls that Framework distributed.  The same is true for Security threat modeling, extension authentication to ARM, postMessage/RPC layer and UserSettings, etc. are handled by Framework. To minimize the duplicate efforts on those items, Fx provides some level of "blueprint" documentation that can be used as a reference for compliance procedures. You are still responsible to review the tools and submit the results for approval previous to shipping the extension. 

| Policy            | Location  | Fx coverage |
| ---               | ---       | --- |
| Accessibility     | [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-development.md](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-development.md) | Generic control supports on keyboard, focus handling, touch, screen reader, high contrast, and theming |
| Global Readiness  |           | Localizability, regional format, text support, China GB standard |
| Privacy           |           | User settings data handling, encryption, and authentication |
| SDL               |           | Threat modeling |

For more information and any questions about Fx coverage, reach out to the Fx Coverage contact that is located in [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).


<a name="portal-extensions-for-developers-development-phases"></a>
## Development Phases

<a name="portal-extensions-for-developers-development-phases-private-preview"></a>
### Private Preview

The extension is in private preview stage when it has been added to the Azure portal configuration. It is still in hidden/ disabled state, and the preview tag in the the `extension.pdl` file is set to `Preview="true"`. This means that the developer and their team have acquired a small team of reviewers with which to collaborate on the development and testing of the extension.  The developer can then modify the extension until it meets specific criteria for usability, reliability, performance, and other factors. The criteria are located at [Exit Criteria and Quality Metrics](portalfx-extensions-exitCriteria.md). 

When the criteria are met, the developer starts the processes that will move the extension from the private preview state to the public preview state. They should also start the CSS onboarding process at least three months previous to public preview. The CSS onboarding process requires information like the disclosure level, and the key contacts for the release. It allows the appropriate teams enough time to ensure that customers of the extension have access to Azure support and other permissions necessary to access the site.  To start the process, send an email to ibiza-css@microsoft.com. For more information about CSS contacts, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md). For more information about the CSS onboarding process, see [http://spot/intake](http://spot/intake).

When all requirements are met, CSS will release the extension from private preview to public preview. The extension will be enabled, but the preview tag in the the `extension.pdl` file is still set to `Preview="true"`.

This process is separate from onboarding to Azure.

<!-- TODO:  If all extensions eventually leave the private preview state, this paragraph can be removed.  The iterative process does not need to be described. -->

**NOTE**: Not all extensions will be moved to public preview, because factors exist that require that the extension remain in the private preview state.

<a name="portal-extensions-for-developers-development-phases-public-preview"></a>
### Public Preview

In the public preview state, the extension undergoes more development and review, this time with a larger audience.  The exit criteria for the public preview state are the same as the exit criteria for the private preview state. An extension that meets the exit criteria with this new audience can be moved from public preview to Global Availability.

The icon to the right of the extension indicates whether the extension is in the private preview state or the public preview state, as in the following image.

 ![alt-text](../media/portalfx-extensions/previewMode.png "Private Preview State")

<a name="portal-extensions-for-developers-development-phases-global-availability"></a>
### Global Availability

When an extension passes all exit criteria for the public preview state, it can be promoted to the Global Availability state. In order to move the extension to GA, the preview tag in the `extension.pdl` file is removed.
  
<a name="portal-extensions-for-developers-development-procedures"></a>
## Development Procedures

The items that are being developed add functionality to an Azure Portal, and therefore are named extensions, or context panes.  Some examples of context panes are in the following image.

 ![alt-text](../media/portalfx-ui-concepts/blade.png "Azure Portal Context Panes")

Perform the following tasks to become part of Azure portal extension developer community.

1. Join DLs and request permissions by using the document located at [portalfx-extensions-permissions.md](portalfx-extensions-permissions.md).

1. [Install Software](#install-software)

1. [Schedule Kickoff Meetings](#schedule-kickoff-meetings)

1. [Review Technical Guidance](#review-technical-guidance)

1. [Develop and deploy the extension](#develop-and-deploy-the-extension)

1. [Register the extension](#register-the-extension)

<a name="portal-extensions-for-developers-development-procedures-install-software"></a>
### Install Software
   
Install the following software. Your team should be aware of the most current download locations so that you can complete your own installs.

* Windows 8, Windows Server 2012 R2, or the most recent edition of the client or server platform. Some downloads are located at the following sites.
  * Windows 8
    
    [https://www.microsoft.com/en-us/software-download/windows8](https://www.microsoft.com/en-us/software-download/windows8)

  * Windows Server 2012 R2

    [https://www.microsoft.com/en-us/download/details.aspx?id=41703](https://www.microsoft.com/en-us/download/details.aspx?id=41703)

* Visual Studio 2015 that is located at [https://www.visualstudio.com/downloads/](https://www.visualstudio.com/downloads/)

* Typescript for Visual Studio 15 that is located at [https://www.microsoft.com/en-us/download/details.aspx?id=48593](https://www.microsoft.com/en-us/download/details.aspx?id=48593)

* Knockout that is located at [http://knockoutjs.com/downloads/](http://knockoutjs.com/downloads/)

* Azure Portal SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download)

* Quality Essentials that is located at [http://qe](http://qe), or One Compliance System (1CS) that is located at  [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx)

* Set up the source code management system on your computer. Teams use **GitHub**, **VSO**, and other content management systems. Which one is used by your team is team-dependent.

Test that your computer is ready for Azure development by creating a blank extension, as specified in [portalfx-extensions-developerInit-procedure.md](portalfx-extensions-developerInit-procedure.md).

<a name="portal-extensions-for-developers-development-procedures-schedule-kickoff-meetings"></a>
### Schedule Kickoff Meetings

Schedule and attend the kickoff meeting(s) hosted by your PM or Dev Lead. These meetings will touch on the following points.
* Whether the service will target public Azure, on-premises, or both
* What is the name of the service
* Summary of the service and target scenarios

If you are planning to build a first party application, i.e., you are a part of Microsoft, the meeting agenda will also include:
* VP, PM, and engineering owners
* Timelines (preview, GA)

<a name="portal-extensions-for-developers-development-procedures-review-technical-guidance"></a>
### Review Technical Guidance

Read the following documents from the Azure Portal UI team site.  Our doc site provides technical guidance for use while you are building an extension.

| Function                                      | Title and Link |
| ---                                           | --- |
| Guidance for Program Managers and Dev Leads   | Portal Extensions for Program Managers, located at [portalfx-extensions-forProgramManagers.md](portalfx-extensions-forProgramManagers.md) |
| Private Preview, Public Preview, and GA       | Portal Extension Development Phases, located at [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md) |
| How it Works	                                | Getting Started, located at [portalfx-howitworks.md#getting-started](portalfx-howitworks.md#getting-started)
| Build an empty extension                      | Creating An Extension, located at [portalfx-extensions-developerInit.md](portalfx-extensions-developerInit.md) |
| Experiment with sample code	                | Sample Extensions, located at [portalfx-sample-extensions.md#samples-extension](portalfx-sample-extensions.md#samples-extension) |

<a name="portal-extensions-for-developers-development-procedures-develop-and-deploy-the-extension"></a>
### Develop and deploy the extension

1. Many extensions have been made more successful by setting up early design reviews with the Azure portal team. Taking the time to review the design gives extension owners an opportunity to understand how they can leverage Azure portal design patterns, and ensure that the desired outcome is feasible. When you are ready to build the extension, schedule a UX feasibility review with the Ibiza team UX contact by emailing ibiza-onboarding@microsoft.com and including “Extension Feasibility Review” in the subject line of the e-mail.

    <!-- TODO: find the original source for the guidance about standard Graphs and partner requests.  
      1.	If the extension requires additional built-in support for standard Graph or ARM APIs, submit a partner request at the site located at [https://feedback.azure.com/forums/594979-ibiza-partners](https://feedback.azure.com/forums/594979-ibiza-partners). For more information about the site, see [portalfx-extension-partner-request-process.md](portalfx-extension-partner-request-process.md).
     -->

1.	When you build the extension, remember to sideload it for local testing. Sideloading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about sideloading, see [portalfx-testinprod.md](portalfx-testinprod.md).

1. Complete the development and unit testing of the extension. For more information on debugging, see [portalfx-debugging.md](portalfx-debugging.md) and [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).

1.	When you are confident that the development of the extension is complete, you should execute the following process so the specific work required for the Azure Fundamental tenets appears in Service360, as specified in [Azure Fundamentals](https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d). 
    * Add the service to ServiceTree, which is located at [https://servicetree.msftcloudes.com](https://servicetree.msftcloudes.com)
    * Make the service be "Active" in ServiceTree
    * Complete metadata in ServiceTree to enable the automation for various Service360 Action Items
    * Complete the Action Items identified in Service360, which is located at [http://aka.ms/s360](http://aka.ms/s360)
1.	Address the exit criteria to meet previous to moving the extension to the next development phase. The exit criteria are located at [portalfx-extensions-exitCriteria.md](portalfx-extensions-exitCriteria.md).

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

1. 	Integrate the extension into the Marketplace. 

    In the following images, each icon in the Azure Portal Marketplace is referred to as a Gallery item. Gallery items take the form of a file with the .azpkg extension. This is a  zip file which contains all assets for the gallery item: icons, screenshots, descriptions.

      ![alt-text](../media/portalfx-extensions-forDevelopers
      /azurePortalMarketPlace.png "Azure Portal Marketplace")

    * **PROD:** The Marketplace team accepts fully finished .azkpg files from your team and uploads them to Production to onboard the gallery package. Send the following email to 1store@microsoft.com.  The subject line should contain “Marketplace Onboarding Request” and the *.azpkg file should be attached to the email, as in the following image.

      ![alt-text](../media/portalfx-extensions-forDevelopers/marketplaceOnboardingRequest.png "Marketplace Onboarding Request")

    * **DOGFOOD:** Use AzureGallery.exe to upload items to DOGFOOD using the following command:

      ```AzureGallery.exe upload -p ..\path\to\package.azpkg -h [optional hide key]```

    In order to use the gallery loader, there are some values to set in the AzureGallery.exe.config file. For more information, see the Gallery Item Specifications document that is located at      [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations).  

    For more dev/test scenarios, see [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production).

<a name="portal-extensions-for-developers-development-procedures-register-the-extension"></a>
### Register the extension

Once the name of the extension or service name is finalized, request to have the extension registered in all environments. Registering an extension in Portal requires deployment so it can take almost 10 days in the Production environment. Please plan accordingly.

* For internal partners, the request to register an extension is a pull request, as specified in [portalfx-extensions-pullRequest.md](portalfx-extensions-pullRequest.md).
 
* External teams can submit their requests by sending an email that resembles the following image.

  ![alt-text](../media/portalfx-extensions-forDevelopers/registrationRequest.png "Extension Registration Onboarding Request")
 
* After deploying the extension to the DOGFOOD (DF) environment, contact the Fx team to request that they enable the extension, if applicable. Every extension  meets required exit criteria / quality metrics before it will be enabled. The  extension will be enabled in production once all exit criteria have been met.

   Extension names must use standard extension name format, as in the example located at [portalfx-extensions-configuration-overview.md#name](portalfx-extensions-configuration-overview.md#name).

* Extension URLs must use a standard CNAME pattern. For more information about CNAMES, see [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md).


<a name="portal-extensions-for-developers-exit-criteria-and-quality-metrics"></a>
## Exit Criteria and Quality Metrics

In order to meet customer expectations and continue to increase customer satisfaction, there are quality metrics that are tracked for every extension, context pane, and part.  These metrics help developers build extensions that compile, that contain the items that are requested by the partners of the developer, and that pass acceptance tests that are created by the partners that are associated with a specific phase. When the extension meets the criteria, it becomes a candidate for being moved from the private preview stage to the public preview stage, or from the public preview stage to Global Availability (GA).

Every new extension provides an opportunity for the Ibiza team to improve the customer experience. By using set criteria to meet customer expectations, we can improve the customer experience for the extension and overall portal. Extension developers can drastically improve the customer experience by following these criteria. 

The criteria that are tracked for each extension are sent out as part of an executive summary every Friday. Extensions that fail to meet the criteria are usually prime candidates for having brought down the customer experience in the Azure portal. Such extensions are highlighted in the weekly status report.

Basic information on the quality metrics that are tracked is located at  .

<!-- TODO:  Each of the following sections should have a "for more information" link, like maybe an external link -->

<a name="portal-extensions-for-developers-exit-criteria-and-quality-metrics-performance"></a>
### Performance

The Weighted Experience Score (WxP) determines the percentage of context pane usage that meets the performance bar. The metrics for all context panes within an extension are combined into the WxP, which requires a passing score of greater than 80. Meeting the performance bar is a requirement for public preview or Global Availability (GA).

MPAC and PROD performance are included in weekly status emails and each team is expected to investigate regressions.

For more information about the Weighted Experience Score, see  [portalfx-performance.md#wxp-score](portalfx-performance.md#wxp-score).

Blade reveal time is the time it takes for all the parts above the fold to call ```revealContent()``` to load first level data, or to resolve ```onInputSet()``` promises, whichever is earlier.

All context panes meet the required blade reveal time of less than 4 seconds for the 80th percentile before being enabled in PROD. Extensions should be enabled in MPAC to start tracking performance. Resource and Create context panes are tracked explicitly. 

We require at least 100 loads of the UX (extension/blade/tiles) to get a signal. If you cannot generate that traffic authentically in the expected timeframe, please hold a bug bash to increase the traffic.

For more information about performance and reliability, see the following resources:

* Dashboard 

  [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf)

  * Telemetry Access for access 
        
    [http://aka.ms/portalfx/docs/telemetryaccess](http://aka.ms/portalfx/docs/telemetryaccess)

  * Query - including test/dev traffic

    [https://aka.ms/portalfx/perfsignoff](https://aka.ms/portalfx/perfsignoff)

* Checklist

    [portalfx-performance.md](portalfx-performance.md)
        
   [http://aka.ms/portalfx/performance/checklist](http://aka.ms/portalfx/performance/checklist)

* Portal COP (Telemetry)

    [portalfx-performance-portalcop.md](portalfx-performance-portalcop.md)

<a name="portal-extensions-for-developers-exit-criteria-and-quality-metrics-reliability"></a>
### Reliability

Every extension meets the reliability Service Level Agreement (SLA). There are some reliability metrics should be met previous to enabling the extension in the production environment; however, extensions must be enabled in MPAC in order to start tracking reliability. Meeting the reliability bar is a requirement for public preview or GA.

MPAC and PROD reliability are included in weekly status emails and each team is expected to investigate regressions.

<!-- TODO:  Is there a link to information about the weekly status email for MPAC and PROD reliability?? -->

We require at least 100 loads of the UX (extension/blade/tiles) to get a signal, if you cannot generate that traffic authentically in the expected timeframe, please hold a bug bash to increase traffic.

Use the following query to calculate the performance and reliability of your extension.
    
```json 
    // First parameter startDate
    // Second parameter timeSpan
    // Third parameter includeTestTraffic - set this to `false` if you are already in public preview
    GetExtensionPerfReliability(now(),7d,true) 
    | where extension == "<extensionName>"
```

If any of the reliability numbers of the extension are below the bar, please investigate and resolve the related issues.

<a name="portal-extensions-for-developers-exit-criteria-and-quality-metrics-usability"></a>
### Usability

Each service or extension defines the critical P0 scenarios for their business. The extension is tested using these usability scenarios, with at least ten participants. A  success rate of 80% and an experience score of 80% are required for a passing usability score.

For more information on how to define scenarios, see [portalfx-extensions-stub.md](portalfx-extensions-stub.md).

<a name="portal-extensions-for-developers-exit-criteria-and-quality-metrics-accessibility"></a>
### Accessibility

The accessibility bar is similar to the usability bar, and every service must meet the accessibility standards that are tested in their critical P0 scenarios. C+E teams should work with their own Accessibility teams. 
    
**NOTE**: Accessibility is a blocking requirement.

For more information about accessibility, see [portalfx-accessibility.md](portalfx-accessibility.md).
    
<a name="portal-extensions-for-developers-exit-criteria-and-quality-metrics-create-success-rate"></a>
### Create Success Rate
    
The success of an extension is combined of several factors, the most important of which is customer satisfaction. In order to ensure that every customer has a great customer experience, the extension should be within the create success rate.   The create success rate is defined as the number of times the UX completes the generation process when the create button is clicked. When the extension meets or exceeds those factors, it is eligible for public preview or Global Availability.
     
Extensions and Resource Providers (RPs) are responsible for validating all inputs to ensure the Create is not submitted unless that Create will be successful. This applies to all services.

Services that use ARM template deployment and other ARM-based services should also validate resource provider registration, permissions, and deployment to avoid common issues and improve extension success rates. Validating against some factors is required for the preview and GA phases.

Check the Power BI Dashboard for Service Level Agreements (SLA) that are associated with Creating context panes. The Ibiza Extension Perf/Reliability/Usage Dashboard is located at [aka.ms/ibizaperformance](aka.ms/ibizaperformance).

It is important to meet the success rate previous to moving the extension to the next phase, because various phases are associated with service level agreements and other items that are affected if an extension does not work.  For example, context panes with a success rate below 99% will result in sev 2 incidents. Also, if the success rate drops by 5% during a rolling 24-hour period that contains at least 50 Creates, a sev 2 incident will be filed. This applies to every error that causes Creates to fail when the `Create` button is clicked.

Success rates are a non-blocking requirement.  Some exceptions can be granted to move an extension from the private preview stage to the public preview stage, but in general, the overall customer experience is reduced.
   
For more information about creating success, see [portalfx-create.md#validation](portalfx-create.md#validation).

<!-- TODO:  portalfx-create.md has a section named Validation, but it does not have a link.     -->

<a name="portal-extensions-for-developers-resource-move"></a>
## Resource move

ARM-based services allow customers to move resources between subscriptions and resource groups.

For more information on resource moves, see the following resources.
    
* Documentation 

    [portalfx-resourcemove.md](portalfx-resourcemove.md)
	
* Dashboard
        
    [http://aka.ms/portalfx/resourcemove/dashboard](http://aka.ms/portalfx/resourcemove/dashboard)


<a name="portal-extensions-for-developers-status-codes-and-error-messages"></a>
## Status Codes and Error Messages
Status codes or error messages that are encountered while developing an extension may be dependent on the type of extension that is being created, or the development phase in which the message is encountered.

[Glossary](portalfx-extensions-status-codes-glossary.md)

<a name="portal-extensions-for-developers-status-codes-and-error-messages-err_insecure_response"></a>
### ERR_INSECURE_RESPONSE

ERR_INSECURE_RESPONSE in the browser console

My Extension fails to side load and I get an ERR_INSECURE_RESPONSE in the browser console.

![alt-text](../media/portalfx-testinprod/errinsecureresponse.png "ERR_INSECURE_RESPONSE Log")

ERROR: the browser is trying to load the extension but the SSL certificate from localhost is not trusted.

SOLUTION: Install and trust the certificate.

* * *

<a name="portal-extensions-for-developers-status-codes-and-error-messages-err_connection_reset"></a>
### ERR_CONNECTION_RESET

***Cannot load `localhost` Ibiza extension with ERR_CONNECTION_RESET***

ERROR: The Storage Area Network (SAN) is missing in the certificate.

SOLUTION: [https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595](https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595)

* * *

<a name="portal-extensions-for-developers-status-codes-and-error-messages-portal-error-520"></a>
### Portal Error 520

***The portal encountered a part it cannot render***

ERROR: The Portal displays a 520 error, as in the following image.

![alt-text](../media/portalfx-debugging/failure.png "Portal Error Message")

This can happen for a variety of reasons.

SOLUTION: Use the following steps.

* Check the browser console, and look for errors.
* Click on the failed part. With some types of errors, this will add a stack trace to the browser console.
* Double check the Knockout template for correct syntax.
* Ensure all variables referenced on the template are available as public properties on the corresponding view model class.
* Reset the desktop state.
* Enable first chance exceptions in the JavaScript debugger.
* Set break points inside of the view model constructor, and ensure no errors are thrown.

* * *


<a name="portal-extensions-for-developers-best-practices"></a>
## Best Practices

Portal development patterns or architectures that are recommended based on customer feedback and usability studies are located in the topic for the blade that is being developed. For more information, see [portalfx-blades-best-practices.md](portalfx-blades-best-practices.md).

<a name="portal-extensions-for-developers-best-practices-performance"></a>
### Performance

There are practices that can improve the performance of the extension.  For more information, see [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md).




<a name="portal-extensions-for-developers-stackoverflow-forums"></a>
## Stackoverflow Forums

Stackoverflow is a Web site that allows users to network and answer questions for each other.

To help the Azure UI team answer your questions, the submissions are categorized into various topics that are marked with tags. 
To use the tags to read forum submissions, enter the following in the address bar of your browser:

```https://stackoverflow.microsoft.com/questions/tagged/<ibizaTag>```

where

 ``` ibizaTag``` 
 (without the angle brackets) is one of the tags from the following  list.

To ask a question in a forum, enter the following in the address bar of your browser.

```https://stackoverflow.microsoft.com/questions/ask?tags=<ibizaTag>```


 The current list of  tags is as follows:
| Tag  |  Owner  |
| --- |  --- |
| azure-gallery  |  | 
| ibiza |  | 
| ibiza-accessibility |  | 
| ibiza-bad-samples-doc | amitmod | 
| ibiza-blades-parts | sewatson  | 
| ibiza-breaking-changes   |  amitmod | 
| ibiza-browse  | edpark  | 
| ibiza-controls  | Shresh | 
| ibiza-create | Paparsad  | 
| ibiza-data-caching | amitmod | 
| ibiza-deployment | amitmod | 
| ibiza-forms-create  | amitmod<br>Paparsad<br>Shresh | 
| ibiza-kusto  |  | 
| ibiza-localization-global  | Paparsad  | 
| ibiza-missing-docs  |  | 
| ibiza-monitoringux  |  rajram | 
| ibiza-onboarding | |
| ibiza-performance | sewatson  | 
| ibiza-reliability | sewatson  | 
| ibiza-resources  | Paparsad  | 
| ibiza-sdkupdate  | amitmod  | 
| ibiza-security-auth | edpark   | 
| ibiza-telemetry  | sewatson  | 
| ibiza-test | amitmod | 
| ibiza-uncategorized |  | 



<a name="portal-extensions-for-developers-frequently-asked-questions"></a>
## Frequently asked questions

<a name="portal-extensions-for-developers-frequently-asked-questions-onboarding-faq"></a>
### Onboarding FAQ

***Where are the onboarding FAQs for Sparta (ARM/CSM-RP)?***

The Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx).

* * *
<a name="portal-extensions-for-developers-frequently-asked-questions-ssl-certs"></a>
### SSL Certs

***How do I use SSL certs?***

 Azure portal ONLY supports loading extensions from HTTPS URLs. Use a wildcard SSL cert for each environment to simplify maintenance, for example,   ``` *.<extensionName>.onecloud-ext.azure-test.net  ``` or  ``` *.<extensionName>.ext.azure.com) ``` .    To simplify overall management when your team is building separate, independent extensions, you can also use  ``` <extensionName>.<team>.ext.azure.com ``` and create a wildcard SSL cert for  ``` *.<team>.ext.azure.com ```. Internal teams can create SSL certs for the DogFood environment using the SSL Administration Web page that is located at [http://ssladmin](http://ssladmin). 
 
 SSL Certs are relevant only for teams that host their own extensions.  Production certs must follow your organization’s PROD cert process. 

 **NOTE** Do not use the SSL Admin site for production certs.
 * * *
   
<a name="portal-extensions-for-developers-contacts"></a>
## Contacts

For assistance with the prerequisites for onboarding Management UI, contact the following people.  

If the information is not current, please send a pull request to update the documentation. For more information on how to send a pull request, see [portalfx-extensions-pullRequest.md](portalfx-extensions-pullRequest.md).

<!-- TODO: validate person names against links in portalfx-onboarding.md -->

| Function                                      | Azure Stakeholder                         | Contact |
| ---                                           | ---                                       |  --- |
| Accessibility	                                | Paymon Parsadmehr                         | ibiza-accessibility@microsoft.com |
| Activity logs	                                | Marck Robinson                            | ibiza-activity-logs@microsoft.com |
| The ARM Team                                  |                                           | aux-arm-leads@microsoft.com |
| Azure.com	                                    | Elena Salaks; Guy Burstein                | ibiza-azure@microsoft.com |
| Azure Compliance                              | Azure Compliance team                     | azcompl@microsoft.com |
| Azure Resource Manager (ARM)                  | Ryan Jones                                | ibiza-arm@microsoft.com |
| Business model review                         | Brian Hillger’s team;  Stacey Ellingson   | ibiza-bmr@microsoft.com |
| Create success                                | Balbir Singh                              | ibiza-create@microsoft.com |
| CSS Support                                   | Wes Penner; CEGRM                         | ibiza-css@microsoft.com |
| External Partner Contact                      |                                           | ibizaFXPM@microsoft.com |
| Fx Coverage 	                                | Amit Modi                                 | ibiza-onboarding@microsoft.com |
| Localization                                  | Bruno Lewin                               | ibiza-interntnl@microsoft.com |
| Onboarding kickoff                            | Leon Welicki; Adam Abdelhamed; Amit Modi  | ibiza-onboarding-kick@microsoft.com |
| Third Party Applications (External partners)  | Leon Welicki; Adam Abdelhamed             | ibiza-onboarding-kick@microsoft.com |
| Performance                                   | Sean Watson                               | ibiza-perf@microsoft.com |
| Pull requests                                 |                                           | ibizafxpm@microsoft.com |
| Registration for internal extensions          |                                           | ibizafxpm@microsoft.com |
| Quality Essentials                            |                                           | Get1CS@microsoft.com​ |
| Reliability                                   | Sean Watson                               | ibiza-reliability@microsoft.com |
| Resource Move                                 | Edison Park                               | ibiza-resourceMove@microsoft.com |
| Usability	                                    | Angela Moulden                            | ibiza-usability@microsoft.com |
| UX feasibility review                         |                                           | ibiza-onboarding@microsoft.com | 

<!-- TODO: Validate whether the ibizafxpm@microsoft.com  link is the correct one for sending pull requests to, when sending pull requests to the dev branch for new extensions. -->

<a name="portal-extensions-for-developers-glossary"></a>
## Glossary
<!--
This document should remain identical to the glossary in portal-extensions-forProgramManagers-glossary, because they were originally the same document.
-->
  ## Glossary
<!--
This document should remain identical to the glossary in portal-extensions-forDevelopers-glossary, because they were originally the same document.
-->

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                      | Meaning |
| ---                       | --- |
| .Net                      | A software framework developed by Microsoft that runs primarily on Microsoft Windows. | 
| 1CS                       | One Compliance System  | 
| API                       | Application Programming Interface  |
| ARM                       | Azure Resource Manager |
| blade reveal time         | The time it takes for all the parts above the fold to call ```revealContent()```, to load first-level data, or to resolve ```onInputSet()``` promises, whichever is earlier. |
| C+E                       | Cloud + Enterprise | 
| CEC                       | Common Engineering Criteria  | 
| CEGRM                     | CSS Release management team | 
| CLI                       | Command Line Interface  | 
| CNAME                     | Canonical Name record. A type of resource record in the Domain Name System (DNS) that specifies that a domain name is an alias for another domain (the 'canonical' domain). | 
| CSS                       | CSS Release management  | 
| DEV                       | Development | 
| DF                        | Dogfood | 
| DNS                       | Domain Name Server  | 
| DNS                       | Domain Name System  | 
| FAQ                       | Frequently Asked Questions | 
| GA                        | Global Availability | 
| gallery                   | Also known as Marketplace or Azure Portal Marketplace. See Marketplace Gallery. | 
| GB Certificate            | Six Sigma Green Belt Certification.  | 
| GB Standard               | GB stands for Guobiao, or “National Standard” in Chinese. The GB standard is the basis for testing products that require certification. | 
| Marketplace               | See Marketplace Gallery. | 
| Marketplace Gallery       | Also known as the Gallery or Marketplace Gallery. | 
| MPAC                      | ms.portal.azure.com, the Azure portal instance for internal Microsoft customers.  | 
| P0 scenarios              | The most important user scenarios for an extension. Less important scenarios that are used for usability testing are categorized as P1, P2, or P3. |
| PHP                       | Recursive acronym for PHP: Hypertext Preprocessor. | 
| PM                        | Program Manager | 
| PM                        | Project Manager | 
| PROD                      | Production  | 
| QE                        | Quality Essential | 
| RDFE                      | Red Dog Front End | 
| REST                      | Representational state transfer   | 
| RP                        | Resource Provider  | 
| RP schema                 | Resource Provider schema | 
| RPC                       | Remote Procedure Call | 
| SDK                       | Software Development Kit | 
| SDL                       | Security Development Lifecycle |
| Service 360               | An extension of Service Portfolio Management. It enhances a Service Portfolio by providing a single view of business service performance across an organization, for business processes such as Operation, Risk, Investment, and Finance. | 
| SLA                       | Service Level Agreement | 
| SSL                       | Secure Socket Layer  | 
| URL                       | Uniform Resource Locator | 
| VP                        | Vice President | 
| Weighted Experience Score | The percentage of context pane usage that meets the performance bar. |
| WxP                       | See Weighted Experience Score.  | 



