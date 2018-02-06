<a name="portal-extensions"></a>
# Portal Extensions

<!-- TODO: This document contains all the pieces that were in the onboarding document that were removed.  They may need to be moved to other documents that are more detailed. -->


<a name="portal-extensions-communication"></a>
## Communication
   
Plan ahead for all the outbound communication, blogging, and marketing work that publicizes new services during the time that they are being deployed to customers.  This coordination is important, particularly when software release commitments are aligned with the Azure events and conferences. This coordination may be optional for preview releases, but the localized azure.com content and service updates plan are required for stakeholder signoff, if the extension will be deployed to GA.
 



<a name="portal-extensions-azure-fundamentals"></a>
## Azure Fundamentals

The Azure Fundamentals are a set of tenets to which each Azure service is expected to adhere. The Azure Fundamentals program is described in the document located at [https://aka.ms/azurefundamentals](https://aka.ms/azurefundamentals). The document also identifies the stakeholders and contacts for each of the tenets.

<a name="portal-extensions-quality-essentials"></a>
## Quality Essentials

Compliance criteria and practices are defined in Quality Essentials throughout the development cycle. These ensure that services meet the Trusted Cloud commitments outlined in the Microsoft Azure Trust Center for our customers. These are required procedures for preview and Global Availability, and are to be revisited for every release cycle.

The customer has a different set of expectations for the extension in each phase. To meet customer expectations, we have compiled exit criteria for each phase. The development of an extension  can proceed to the next step when it meets the exit criteria for the current step. To meet customer expectations and continue to increase customer satisfaction, several quality metrics are tracked for every extension by the Get1CS team. An overview of Quality Essentials is located at [https://aka.ms/qualityessentials](https://aka.ms/qualityessentials). There may be tools to install from the QE and 1CS sites that are part of the Quality Essentials process. The Azure team only tracks the exit criteria and localization requirements.

Nearly 70% of Azure users are from outside of the United States. Therefore, it is important to make Azure a globalized product. There are a few internationalization requirements that the extension or service is required to support. This is the same set of languages that are supported by Azure Portal for GA.
<a name="portal-extensions-for-more-information"></a>
## For More Information
   
For more information about the Microsoft Azure Trust Center, see [http://azure.microsoft.com/en-us/support/trust-center/](http://azure.microsoft.com/en-us/support/trust-center/).

 For more information about quality metrics, see the One Compliance System Web site that is located at [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx).

For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). 

For more information about azure.com onboarding, see [http://acomdocs.azurewebsites.net](http://acomdocs.azurewebsites.net).

<a name="portal-extensions-development-procedures"></a>
## Development Procedures
   
1. [Develop and deploy the extension](#develop-and-deploy-the-extension)

1. [Register the extension](#register-the-extension)

You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).

<a name="portal-extensions-development-procedures-develop-and-deploy-the-extension"></a>
### Develop and deploy the extension
 
1. If the extension requires additional built-in support for standard Graph or ARM APIs, submit a partner request at the site located at [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice).  For information about other components that the new service needs, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).

1.	Build the extension and sideload it for local testing. Sideloading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about sideloading, see [portalfx-extensions-sideloading-overview.md](portalfx-extensions-sideloading-overview.md) and [portalfx-testinprod.md](portalfx-testinprod.md). 

1. Complete the development and unit testing of the extension. For more information on debugging, see [portalfx-debugging.md](portalfx-debugging.md) and [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).


1.	Address the exit criteria to meet previous to moving the extension to the next development phase. The exit criteria are located at [top-exit-criteria.md](top-exit-criteria.md).

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

1. 	Integrate the extension into the Marketplace. 

    In the following images, each icon in the Azure Portal Marketplace is referred to as a Gallery item. Gallery items take the form of a file with the .azpkg extension. This is a  zip file which contains all assets for the gallery item: icons, screenshots, descriptions.

    ![alt-text](../media/portalfx-extensions-onboarding/azurePortalMarketPlace.png "Azure Portal Marketplace")

    * **PROD:** The Marketplace team accepts fully finished .azkpg files from your team and uploads them to Production to onboard the gallery package. Send the following email to 1store@microsoft.com.  The subject line should contain “Marketplace Onboarding Request” and the *.azpkg file should be attached to the email, as in the following image.

      ![alt-text](../media/portalfx-extensions-onboarding/marketplaceOnboardingRequest.png "Marketplace Onboarding Request")

    * **DOGFOOD:** Use AzureGallery.exe to upload items to DOGFOOD using the following command:

      ```AzureGallery.exe upload -p ..\path\to\package.azpkg -h [optional hide key]```

    In order to use the gallery loader, there are some values to set in the AzureGallery.exe.config file. For more information, see the Gallery Item Specifications document that is located at      [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations).  

    For more dev/test scenarios, see [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production).

<a name="portal-extensions-development-procedures-register-the-extension"></a>
### Register the extension

* After deploying the extension to the DOGFOOD (DF) environment, contact the Fx team to request that they enable the extension, if applicable. Every extension  meets required exit criteria / quality metrics before it will be enabled. The  extension will be enabled in production once all exit criteria have been met.



<a name="portal-extensions-requirements-for-azure-services"></a>
## Requirements for Azure Services
   
All services using Azure Billing must be exposed by using the Azure Resource Manager (ARM). Services that do not use Azure Billing can use either ARM or Microsoft Graph. Usually, services that integrate deeply with Office 365 use Graph, while all others are encouraged to use ARM. 
 
For more information about ARM API, see Azure Resource Manager (ARM) API Reference, located at [https://docs.microsoft.com/en-us/dynamics365/customer-engagement/customer-insights/ref/armapiref](https://docs.microsoft.com/en-us/dynamics365/customer-engagement/customer-insights/ref/armapiref), and also see Resource Manager REST APIs, located at [https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-rest-api](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-rest-api).

For more information about onboarding with Microsoft Graph, see [https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/resources/azure_ad_overview](https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/resources/azure_ad_overview).

The Azure Portal SDK doesn't require any specific back-end, but does provide extra support for ARM-based resources. 

All new services should be listed in the Azure Web site that is located at [https://azure.microsoft.com](https://azure.microsoft.com). This isn't a requirement for onboarding the Portal, but service categorization is the same between the azure.com Products menu, Portal Services menu, and the Azure Marketplace. The service should not be listed in the Portal unless it is also on azure.microsoft.com.
<a name="portal-extensions-requirements-for-azure-services-develop-the-extension"></a>
### Develop the extension

1. Build the extension and sideload it for local testing. Sideloading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about sideloading, see [portalfx-extensions-sideloading-overview.md](portalfx-extensions-sideloading-overview.md) and [portalfx-testinprod.md](portalfx-testinprod.md). 

1. Complete the development and unit testing of the extension. For more information on debugging, see [portalfx-debugging.md](portalfx-debugging.md) and [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).

1. Address the exit criteria to meet previous to moving the extension to the next development phase. The exit criteria are located at [top-exit-criteria.md](top-exit-criteria.md).

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).
<a name="portal-development-phase-2"></a>
# Portal development phase 2
  
<a name="portal-development-phase-2-development"></a>
## Development

Developing a Portal extension has three phases: private preview, public preview, and Global Availability (GA). Azure Portal onboarding is creating a UI for a service in Azure Portal, and is a subset of Azure onboarding.

Most services that onboard to Azure can leverage the following components of the Azure ecosystem:
1. Management APIs that are exposed via Azure Resource Manager (ARM) or Microsoft Graph
1. Management UI in the Azure Portal and/or other tools/websites, like Visual Studio
1. Marketing content on the Azure Web site or other websites

The Azure onboarding process is streamlined to optimize the delivery of high-quality experiences based on hundreds of hours of usability testing that meet Microsoft Common Engineering Criteria (CEC) and compliance requirements. This will better optimize developer resources and reduce re-working due to anti-patterns and inconsistencies that block usability, performance, and other factors. Therefore, we strongly recommend starting the onboarding process previous to designing UI or management APIs.

Perform the following tasks to develop an Azure extension.

1. [Learn about the hosting service](portalfx-extensions-hosting-service-overview.md)



You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).


<a name="portal-development-phase-2-development-deployment-procedure"></a>
### Deployment procedure

1. Review the development phases that are located at [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md) to understand how development is related to exit criteria.

1. Review the environments that are specified in [portalfx-extensions-branches.md](portalfx-extensions-branches.md) to understand the environments in which the developer can test an extension.

1. When you are confident that the development of the extension is complete, you should execute the following process so the specific work required for the Azure Fundamental tenets appears in Service360, as specified in [Azure Fundamentals](https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d). 
    * Add the service to ServiceTree, which is located at [https://servicetree.msftcloudes.com](https://servicetree.msftcloudes.com)
    * Make the service be "Active" in ServiceTree
    * Complete metadata in ServiceTree to enable the automation for various Service360 Action Items
    * Complete the Action Items identified in Service360, which is located at [http://aka.ms/s360](http://aka.ms/s360)

1. 	Integrate the extension into the Marketplace. 

    In the following images, each icon in the Azure Portal Marketplace is referred to as a Gallery item. Gallery items take the form of a file with the .azpkg extension. This is a  zip file which contains all assets for the gallery item: icons, screenshots, descriptions.

    ![alt-text](../media/portalfx-extensions-onboarding/azurePortalMarketPlace.png "Azure Portal Marketplace")

    * **PROD:** The Marketplace team accepts fully finished .azkpg files from your team and uploads them to the Production environment to onboard the gallery package. Reach out to  <a href="mailto:1store@microsoft.com?subject=Marketplace Onboarding Request&body=Hello, I would like to onboard the attached package to the production environment. The .azkpg package is named <packageName>. ">1store</a> with the zip file to have them install it.
    
      **NOTE**: The subject line of the email should contain “Marketplace Onboarding Request” and the *.azpkg file should be attached to the email.
    
    * **DOGFOOD:** Use AzureGallery.exe to upload items to DOGFOOD using the following command:

      ```AzureGallery.exe upload -p ..\path\to\package.azpkg -h [optional hide key]```

    In order to use the gallery loader, there are some values to set in the AzureGallery.exe.config file. For more information, see the Gallery Item Specifications document that is located at      [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations).  

    For more dev/test scenarios, see [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production).

<a name="portal-development-phase-2-glossary"></a>
## Glossary
    
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
| Definition file | A file that provides type information for JavaScript code that is inherently not statically typed. Definition files are a fundamental part of using existing JavaScript libraries in TypeScript, and the file suffix is always  *.d.ts. |
| DEV                       | Development | 
| DF                        | Dogfood | 
| DNS                       | Domain Name Server  | 
| DNS                       | Domain Name System  | 
| first-party extension     | An Azure Portal extension that is developed by Microsoft |
| FAQ                       | Frequently Asked Questions | 
| GA                        | Global Availability | 
| gallery                   | Also known as Marketplace or Azure Portal Marketplace. See Marketplace Gallery. | 
| GB Certificate            | Six Sigma Green Belt Certification.  | 
| GB Standard               | GB stands for Guobiao, or “National Standard” in Chinese. The GB standard is the basis for testing products that require certification. | 
| Marketplace               | See Marketplace Gallery. | 
| Marketplace Gallery       | Also known as the Gallery or Marketplace Gallery. | 
| MPAC                      | ms.portal.azure.com, the Azure Portal instance for internal Microsoft customers.  | 
| P0 scenarios              | The most important user scenarios for an extension. Less important scenarios that are used for usability testing are categorized as P1, P2, or P3. |
| PDE | | 
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
| single page application | A web application that dynamically rewrites displayed pages instead of providing entire new pages from a server. | 
| SLA                       | Service Level Agreement | 
| SSL                       | Secure Socket Layer  | 
| third-party extension     | An Azure Portal extension that is developed by partners outside of Microsoft |
| URL                       | Uniform Resource Locator | 
| VP                        | Vice President | 
| Weighted Experience Score | The percentage of blade usage that meets the performance bar. |
| WxP                       | See Weighted Experience Score.  | 



