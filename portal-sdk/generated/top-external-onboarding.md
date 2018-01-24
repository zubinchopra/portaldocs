<a name="onboarding-outside-of-ibiza"></a>
# Onboarding outside of Ibiza
<a name="onboarding-outside-of-ibiza-compliance-marketplace-integration-and-others"></a>
## Compliance, Marketplace Integration, and others


<a name="onboarding-outside-of-ibiza-requirements-for-azure-services"></a>
## Requirements for Azure Services
   
All services using Azure Billing must be exposed by using the Azure Resource Manager (ARM). Services that do not use Azure Billing can use either ARM or Microsoft Graph. Usually, services that integrate deeply with Office 365 use Graph, while all others are encouraged to use ARM. 
 
For more information about ARM API, see Azure Resource Manager (ARM) API Reference, located at [https://docs.microsoft.com/en-us/dynamics365/customer-engagement/customer-insights/ref/armapiref](https://docs.microsoft.com/en-us/dynamics365/customer-engagement/customer-insights/ref/armapiref), and also see Resource Manager REST APIs, located at [https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-rest-api](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-rest-api).

For more information about onboarding with Microsoft Graph, see [https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/resources/azure_ad_overview](https://developer.microsoft.com/en-us/graph/docs/api-reference/v1.0/resources/azure_ad_overview).

The Azure Portal SDK doesn't require any specific back-end, but does provide extra support for ARM-based resources. 

All new services should be listed in the Azure Web site that is located at [https://azure.microsoft.com](https://azure.microsoft.com). This isn't a requirement for onboarding the Portal, but service categorization is the same between the azure.com Products menu, Portal Services menu, and the Azure Marketplace. The service should not be listed in the Portal unless it is also on azure.microsoft.com.


<a name="onboarding-outside-of-ibiza-quality-essentials"></a>
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

These requirements apply to both the Portal fx and extensions. Since Fx provides the common infrastructure and UI controls that govern the data handling and UX, hence some of the compliance work for extensions would be identical across in Ibiza, and rationally be mitigated by the Framework. For example, Accessibility support on keyboard navigation and screen reader recognition, as well as the regional format and text support to meet globalization requirements, are implemented at the controls that Framework distributed.  The same is true for Security threat modeling, extension authentication to ARM, postMessage/RPC layer and UserSettings, etc. are handled by Framework. To minimize the duplicate efforts on those items, Fx provides some level of "blueprint" documentation that can be used as a reference for compliance procedures. You are still responsible to review the tools and submit the results for approval previous to shipping the extension. 

| Policy            | Location  | Fx coverage |
| ---               | ---       | --- |
| Accessibility     | [portalfx-accessibility.md](portalfx-accessibility.md) | Generic control supports on keyboard, focus handling, touch, screen reader, high contrast, and theming |
| Global Readiness  | [portalfx-globalization.md](portalfx-globalization.md) and [portalfx-localization.md](portalfx-localization.md) | Localizability, regional format, text support, China GB standard |
| Privacy           |  [portalfx-authentication.md](portalfx-authentication.md) | User settings data handling, encryption, and authentication |
| SDL               |  [https://microsoft.sharepoint.com/ teams/QualityEssentials/SitePages/ SDL_SecurityDevelopmentLifecycleOverview.aspx](https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/SDL_SecurityDevelopmentLifecycleOverview.aspx)         | Security Development Lifecycle Threat modeling |

For more information and any questions about Fx coverage, reach out to the Fx Coverage contact that is located in [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).


<a name="onboarding-outside-of-ibiza-azure-fundamentals"></a>
## Azure Fundamentals

The Azure Fundamentals are a set of tenets to which each Azure service is expected to adhere. The Azure Fundamentals program is described in the document located at [https://aka.ms/azurefundamentals](https://aka.ms/azurefundamentals). The document also identifies the stakeholders and contacts for each of the tenets.

The Azure Fundamentals document is 

<a name="onboarding-outside-of-ibiza-quality-essentials"></a>
## Quality Essentials

Compliance criteria and practices are defined in Quality Essentials throughout the development cycle. These ensure that services meet the Trusted Cloud commitments outlined in the Microsoft Azure Trust Center for our customers. These are required procedures for preview and Global Availability, and are to be revisited for every release cycle.

The customer has a different set of expectations for the extension in each phase. To meet customer expectations, we have compiled exit criteria for each phase. The development of an extension  can proceed to the next step when it meets the exit criteria for the current step. To meet customer expectations and continue to increase customer satisfaction, several quality metrics are tracked for every extension by the Get1CS team. An overview of Quality Essentials is located at [https://aka.ms/qualityessentials](https://aka.ms/qualityessentials). There may be tools to install from the QE and 1CS sites that are part of the Quality Essentials process. The Azure team only tracks the exit criteria and localization requirements.

Nearly 70% of Azure users are from outside of the United States. Therefore, it is important to make Azure a globalized product. There are a few internationalization requirements that the extension or service is required to support. This is the same set of languages that are supported by Azure Portal for GA.




<a name="onboarding-outside-of-ibiza-communication"></a>
## Communication
   
Plan ahead for all the outbound communication, blogging, and marketing work that publicizes new services during the time that they are being deployed to customers.  This coordination is important, particularly when software release commitments are aligned with the Azure events and conferences. This coordination may be optional for preview releases, but the localized azure.com content and service updates plan are required for stakeholder signoff, if the extension will be deployed to GA.
 



