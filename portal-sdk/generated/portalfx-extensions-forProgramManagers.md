<a name="portal-extensions-for-program-managers"></a>
# Portal Extensions for Program Managers

<a name="portal-extensions-for-program-managers-introduction"></a>
## Introduction

Welcome to Azure! We're excited to have you to join the family and become a partner. The Azure Portal team supports the Azure Portal, its SDK, and the Framework that service teams use to integrate their management UI into the Azure Portal.

<a name="portal-extensions-for-program-managers-overview"></a>
## Overview

Extensions are developed by teams that integrate user interfaces into the Azure Portal. Some examples are in the following image.

![alt-text](../media/portalfx-create/plus-new.png  "Extensions")

Onboarding a service, or developing a portal extension, has three phases: private preview, public preview, and Global Availability (GA). Azure portal onboarding is creating a UI for a service in Azure portal, and is a subset of Azure onboarding.

Most services that onboard to Azure can leverage the following components of the Azure ecosystem:
1. Management APIs that are exposed via Azure Resource Manager (ARM) or Microsoft Graph
1. Management UI in the Azure portal and/or other tools/websites, like Visual Studio
1. Marketing content on the Azure Web site or other websites

The Azure onboarding process is streamlined to optimize the delivery of high-quality experiences based on hundreds of hours of usability testing that meet Microsoft Common Engineering Criteria (CEC) and compliance requirements. This will better optimize developer resources and reduce re-working due to anti-patterns and inconsistencies that block usability, performance, and other factors. Therefore, we strongly recommend starting the onboarding process previous to designing UI or management APIs.

The Azure Fundamentals are a set of tenets to which each Azure service is expected to adhere. The Azure Fundamentals program is described in this document [Azure Fundamentals](https://microsoft.sharepoint.com/:w:/r/teams/WAG/EngSys/_layouts/15/Doc.aspx?sourcedoc=%7BF5B821BC-31C4-4042-ADB5-5EBF4D8B408D%7D&file=Azure%20Fundamentals%20Proposal.docx&action=edit&mobileredirect=true). The document also identifies the stakeholders and contacts for each of the Tenets.

The Azure Fundamentals document is located at [https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d](https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d).

Compliance criteria and practices are defined in Quality Essentials throughout the development cycle. These ensure that services meet the Trusted Cloud commitments outlined in the Microsoft Azure Trust Center for our customers. These are required procedures for preview and Global Availability, and are to be revisited for every release cycle.

The customer has a different set of expectations for the extension in each phase. To meet customer expectations, we have compiled exit criteria for each phase. The development of an extension  can proceed to the next step when it meets the exit criteria for the current step. To meet customer expectations and continue to increase customer satisfaction, several quality metrics are tracked for every extension by the Get1CS team. An overview of Quality Essentials is located at [https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx](https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx). There may be tools to install from thr QE and 1CS sites that are part of the Quality Essentials process. The Azure team only tracks the exit criteria and localization requirements.

Nearly 70% of Azure users are from outside of the United States. Therefore, it is important to make Azure a globalized product. There are a few internationalization requirements that the extension or service is required to support. This is the same set of languages that are supported by Azure Portal for GA.





<a name="portal-extensions-for-program-managers-requirements-for-azure-services"></a>
## Requirements for Azure Services

All services using Azure Billing must be exposed by using the Azure Resource Manager (ARM). Services that do not use Azure Billing can use either ARM or Microsoft Graph. Usually, services that integrate deeply with Office 365 use Graph, while all others are encouraged to use ARM. 
 
For more information about ARM API, see Azure Resource Manager (ARM) API Reference, located at [https://docs.microsoft.com/en-us/dynamics365/customer-engagement/customer-insights/ref/armapiref](https://docs.microsoft.com/en-us/dynamics365/customer-engagement/customer-insights/ref/armapiref), and also see Resource Manager REST APIs, located at [https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-rest-api](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-rest-api).

For more information about onboarding with Microsoft Graph, see [https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/resources/azure_ad_overview](https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/resources/azure_ad_overview).

The Azure portal SDK doesn't require any specific back-end, but does provide extra support for ARM-based resources. 

All new services should be listed in the Azure Web site that is located at [https://azure.microsoft.com](https://azure.microsoft.com). This isn't a requirement for onboarding the portal, but service categorization is the same between the azure.com Products menu, portal Services menu, and the Azure Marketplace. The service should not be listed in the portal unless it is also on azure.microsoft.com.

<a name="portal-extensions-for-program-managers-communication"></a>
## Communication

Plan ahead for all the outbound communication, blogging, and marketing work that publicizes new services during the time that they are being deployed to customers.  This coordination is important, particularly when software release commitments are aligned with the Azure events and conferences. This coordination may be optional for preview releases, but the localized azure.com content and service updates plan are required for stakeholder signoff, if the extension will be deployed to GA.
 


  

<a name="portal-extensions-for-program-managers-development-phases"></a>
## Development Phases

<a name="portal-extensions-for-program-managers-development-phases-private-preview"></a>
### Private Preview

The extension is in private preview stage when it has been added to the Azure portal configuration. It is still in hidden/ disabled state, and the preview tag in the the `extension.pdl` file is set to `Preview="true"`.  In this state the extension is not visible to all the customers of Azure portal; instead, the developer and their team have acquired a small team of reviewers with which to collaborate on the development and testing of the extension. Some teams also leverage this phase for testing the business model by providing a specific URL to their customers that allows them to access this extension. The developer can then modify the extension until it meets specific criteria for usability, reliability, performance, and other factors. The criteria are located at [Exit Criteria and Quality Metrics](portalfx-extensions-exitCriteria.md). 

When the criteria are met, the developer starts the processes that will move the extension from the private preview state to the public preview state. They should also start the CSS onboarding process with the CSS team at least three months previous to public preview. The CSS onboarding process requires information like the disclosure level, and the key contacts for the release. It allows the appropriate teams enough time to ensure that customers of the extension have access to Azure support and other permissions necessary to access the site.  To start the process, send an email to ibiza-css@microsoft.com. For more information about CSS contacts, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md). For more information about the CSS onboarding process, see [http://spot/intake](http://spot/intake).

When all requirements are met, CSS will release the extension from private preview to public preview. The extension will be enabled, but the preview tag in the the `extension.pdl` file is still set to `Preview="true"`.

This process is separate from onboarding to Azure.

<a name="portal-extensions-for-program-managers-development-phases-public-preview"></a>
### Public Preview

In the public preview state, the extension undergoes more development and review, and it can be used by all customers in Azure portal.  The exit criteria for the public preview state are the same as the exit criteria for the private preview state, except for Usability.  Public Preview requires extensions to have a score of 7/10, whereas GA requires extensions to have a score of 8/10.  An extension that meets the exit criteria with this public audience can be moved from public preview to Global Availability. The criteria that are used to validate promoting the extension out of the public preview state are located at [Exit Criteria and Quality Metrics](portalfx-extensions-exitCriteria.md).

The icon to the right of the extension indicates whether the extension is in the private preview state or the public preview state, as in the following image.

 ![alt-text](../media/portalfx-extensions/previewMode.png "Private Preview State")

<a name="portal-extensions-for-program-managers-development-phases-global-availability"></a>
### Global Availability

When an extension passes all exit criteria for the public preview state, it can be promoted to the Global Availability state. In order to move the extension to GA, the preview tag in the `extension.pdl` file is removed. This will remove the preview tag from the display. 
  
<a name="portal-extensions-for-program-managers-managing-development"></a>
## Managing Development

{"gitdown": "include-file", "file": "../templates/portalfx-extensions-permissions.md"
 
If you are planning to build a first-party application, i.e., you are a part of Microsoft, you should meet with the Onboarding team specified in [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md). In the meeting, you need to touch on the following points.
* Whether the service will target public Azure, on-premises, or both
* 	What is the name of the service
* 	VP, PM, and engineering owners
* 	Timelines (preview, GA)
* 	Summary of the service and target scenarios

If you are planning to build a third-party application, i.e., you are an external partner, you should meet with the Third Party Application team listed in  in [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md). The meeting will touch on the following points.
* 	Whether the service will target public Azure, on-premises, or both
* 	What is the name of the service
* 	Summary of the service and target scenarios

When these meetings have concluded, your team will be ready to build extensions.

  
<a name="portal-extensions-for-program-managers-exit-criteria-and-quality-metrics"></a>
## Exit Criteria and Quality Metrics

In order to meet customer expectations and continue to increase customer satisfaction, there are quality metrics that are tracked for every extension, and part.  These metrics help developers build extensions that compile, that contain the items that are requested by the partners of the developer, and that pass acceptance tests that are created by the partners that are associated with a specific phase. When the extension meets the criteria, it becomes a candidate for being moved from the private preview stage to the public preview stage, or from the public preview stage to Global Availability (GA).

Every new extension provides an opportunity for the Ibiza team to improve the customer experience. By using set criteria to meet customer expectations, we can improve the customer experience for the extension and overall portal. Extension developers can drastically improve the customer experience by following these criteria. 

The criteria that are tracked for each extension are sent out as part of an executive summary every Friday. Extensions that fail to meet the criteria are usually prime candidates for having brought down the customer experience in the Azure portal. Such extensions are highlighted in the weekly status report.

Basic information on the quality metrics that are tracked is located at  .

<!-- TODO:  Each of the following sections should have a "for more information" link, like maybe an external link -->

<a name="portal-extensions-for-program-managers-exit-criteria-and-quality-metrics-performance"></a>
### Performance

The Weighted Experience Score (WxP) determines the percentage of blade usage that meets the performance bar. The metrics for all blades within an extension are combined into the WxP, which requires a passing score of greater than 80. Meeting the performance bar is a requirement for public preview or Global Availability (GA).

MPAC and PROD performance are included in weekly status emails and each team is expected to investigate regressions.

For more information about the Weighted Experience Score, see  [portalfx-performance.md#wxp-score](portalfx-performance.md#wxp-score).

Blade reveal time is the time it takes for all the parts above the fold to call ```revealContent()``` to load first level data, or to resolve ```onInputSet()``` promises, whichever is earlier.

All blades meet the required blade reveal time of less than 4 seconds for the 80th percentile before being enabled in PROD. Extensions should be enabled in MPAC to start tracking performance. Resource and Create blades are tracked explicitly. 

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

<a name="portal-extensions-for-program-managers-exit-criteria-and-quality-metrics-reliability"></a>
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

<a name="portal-extensions-for-program-managers-exit-criteria-and-quality-metrics-usability"></a>
### Usability

Each service or extension defines the critical P0 scenarios for their business. The extension is tested using these usability scenarios, with at least ten participants. A  success rate of 80% and an experience score of 80% are required for a passing usability score.

For more information on how to define scenarios, see       .

<a name="portal-extensions-for-program-managers-exit-criteria-and-quality-metrics-accessibility"></a>
### Accessibility

The accessibility bar is similar to the usability bar, and every service must meet the accessibility standards that are tested in their critical P0 scenarios. C+E teams should work with their own Accessibility teams. 
    
**NOTE**: Accessibility is a blocking requirement.

For more information about accessibility, see [portalfx-accessibility.md](portalfx-accessibility.md).
    
<a name="portal-extensions-for-program-managers-exit-criteria-and-quality-metrics-create-success-rate"></a>
### Create Success Rate
    
The success of an extension is combined of several factors, the most important of which is customer satisfaction. In order to ensure that every customer has a great customer experience, the extension should be within the create success rate.   The create success rate is defined as the number of times the UX completes the generation process when the create button is clicked. When the extension meets or exceeds those factors, it is eligible for public preview or Global Availability.
     
Extensions and Resource Providers (RPs) are responsible for validating all inputs to ensure the Create is not submitted unless that Create will be successful. This applies to all services.

Services that use ARM template deployment and other ARM-based services should also validate resource provider registration, permissions, and deployment to avoid common issues and improve extension success rates. Validating against some factors is required for the preview and GA phases.

Check the Power BI Dashboard for Service Level Agreements (SLA) that are associated with Creating extensions. The Ibiza Extension Perf/Reliability/Usage Dashboard is located at [aka.ms/ibizaperformance](aka.ms/ibizaperformance).

It is important to meet the success rate previous to moving the extension to the next phase, because various phases are associated with service level agreements and other items that are affected if an extension does not work.  For example, extensions with a success rate below 99% will result in sev 2 incidents. Also, if the success rate drops by 5% during a rolling 24-hour period that contains at least 50 Creates, a sev 2 incident will be filed. This applies to every error that causes Creates to fail when the `Create` button is clicked.

Success rates are a non-blocking requirement.  Some exceptions can be granted to move an extension from the private preview stage to the public preview stage, but in general, the overall customer experience is reduced.
   
For more information about creating success, see [portalfx-create.md#validation](portalfx-create.md#validation).

<!-- TODO:  portalfx-create.md has a section named Validation, but it does not have a link.     -->

<a name="portal-extensions-for-program-managers-resource-move"></a>
## Resource move

ARM-based services allow customers to move resources between subscriptions and resource groups.

For more information on resource moves, see the following resources.
    
* Documentation 

    [portalfx-resourcemove.md](portalfx-resourcemove.md)
	
* Dashboard
        
    [http://aka.ms/portalfx/resourcemove/dashboard](http://aka.ms/portalfx/resourcemove/dashboard)


<!-- 
<a name="portal-extensions-for-program-managers-best-practices"></a>
## Best Practices
"gitdown": "include-file", "file": "../templates/portalfx-extensions-bp-forProgramManagers.md"
-->
 

<a name="portal-extensions-for-program-managers-stackoverflow-forums"></a>
## Stackoverflow Forums

Stackoverflow is a Web site that allows users to network and answer questions for each other.

To help the Azure UI team answer your questions, the submissions are categorized into various topics that are marked with tags. 
To use the tags to read forum submissions, enter the following in the address bar of your browser:

```https://stackoverflow.microsoft.com/questions/tagged/<ibizaTag>```

To ask a question in a forum, enter the following in the address bar of your browser.

```https://stackoverflow.microsoft.com/questions/ask?tags=<ibizaTag>```

where
 
**ibizaTag**:  One of the tags from the following table, without the angle brackets.

| Tag                       | Email of Owner  |
| ---                       | --- |
| azure-gallery             | | 
| ibiza                     | | 
| ibiza-accessibility       | | 
| ibiza-bad-samples-doc     | amitmod | 
| ibiza-blades-parts        | sewatson  | 
| ibiza-breaking-changes    | amitmod | 
| ibiza-browse              | edpark  | 
| ibiza-controls            | shresh | 
| ibiza-create              | paparsad   | 
| ibiza-data-caching        | amitmod | 
| ibiza-deployment          | amitmod | 
| ibiza-forms-create        | amitmod<br>paparsad<br>shresh | 
| ibiza-kusto               | | 
| ibiza-localization-global | paparsad  | 
| ibiza-missing-docs        | | 
| ibiza-monitoringux        | rajram | 
| ibiza-onboarding          | |
| ibiza-performance         | sewatson  | 
| ibiza-reliability         | sewatson  | 
| ibiza-resources           | paparsad  | 
| ibiza-sdkupdate           | amitmod  | 
| ibiza-security-auth       | edpark   | 
| ibiza-telemetry           | sewatson  | 
| ibiza-test                | amitmod | 
| ibiza-uncategorized       | | 



<a name="portal-extensions-for-program-managers-frequently-asked-questions"></a>
## Frequently asked questions

<a name="portal-extensions-for-program-managers-frequently-asked-questions-onboarding-faq"></a>
### Onboarding FAQ
 
***Where are the onboarding FAQs for Sparta (ARM/CSM-RP)?***

The Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx).

* * *
  
<a name="portal-extensions-for-program-managers-contacts"></a>
## Contacts

For assistance with the prerequisites for onboarding Management UI, contact the following people.  

If the following table is not current, please send a pull request to update the the contact list. For more information on how to send a pull request, see [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

<!-- TODO: validate person names against links in portalfx-onboarding.md -->

| Function                                      | Azure Stakeholder                         | Contact |
| --------------------------------------------- | ----------------------------------------- |  --- |
| Accessibility	                                | Paymon Parsadmehr                         | ibiza-accessibility@microsoft.com |
| Activity logs	                                | Marck Robinson                            | ibiza-activity-logs@microsoft.com |
| The ARM Team                                  |                                           | aux-arm-leads@microsoft.com |
| Azure.com	                                    | Elena Salaks; Guy Burstein                | ibiza-azure@microsoft.com |
| Azure Compliance                              | Azure Compliance team                     | azcompl@microsoft.com |
| Azure Resource Manager (ARM)                  | Ryan Jones                                | ibiza-arm@microsoft.com |
| Business model review                         | Integrated Marketing; Brian Hillger’s team | ibiza-bmr@microsoft.com|
| Business model review                         | L&R - Operations - GD\&F; Stacey Ellingson | ibiza-bmr@microsoft.com |
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
| Usability	                                    | Joe Hallock; Mariah Jackson               | ibiza-usability@microsoft.com |
| UX feasibility review                         |                                           | ibiza-onboarding@microsoft.com | 

<!-- TODO: Validate whether the ibizafxpm@microsoft.com  link is the correct one for sending pull requests to, when sending pull requests to the dev branch for new extensions. -->

<a name="portal-extensions-for-program-managers-for-more-information"></a>
## For More Information

For more information about development phases, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

For more information about the Microsoft Azure Trust Center, see [http://azure.microsoft.com/en-us/support/trust-center/](http://azure.microsoft.com/en-us/support/trust-center/).

For more information about exit criteria, see [portalfx-extensions-exitCriteria.md](portalfx-extensions-exitCriteria.md).

 For more information about quality metrics, see the One Compliance System Web site that is located at [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx).

For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). 

For more information about localization requirements, see [portalfx-localization.md](portalfx-localization.md). 

For more information about azure.com onboarding, see [http://acomdocs.azurewebsites.net](http://acomdocs.azurewebsites.net).

<a name="portal-extensions-for-program-managers-glossary"></a>
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
| Weighted Experience Score | The percentage of blade usage that meets the performance bar. |
| WxP                       | See Weighted Experience Score.  | 


