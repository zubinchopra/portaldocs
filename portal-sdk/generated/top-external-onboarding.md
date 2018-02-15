<a name="onboarding-outside-of-ibiza"></a>
# Onboarding outside of Ibiza
<a name="onboarding-outside-of-ibiza-compliance-marketplace-integration-and-others"></a>
## Compliance, Marketplace Integration, and others

<a name="onboarding-outside-of-ibiza-introduction"></a>
## Introduction

It is important to read this guide carefully, as we rely on you to manage the extension registration / configuration management process  in the Portal repository. External partners should also read this guide to understand the capabilities that Portal can provide for  extensions by using configuration. However, external partner requests should be submitted by sending an email to <a href="mailto:ibizafxpm@microsoft.com?subject=<Onboarding Request ID> Add <extensionName> extension to the Portal&body=Extension name: <Company>_<BrandOrSuite>_<ProductOrComponent> <br><br> URLs: <br><br> PROD:  main.<extensionName>.ext.contoso.com <br><br> Contact info: <br><br> Business Contacts:<br><br> Dev leads: <br><br> PROD on-call email: <br><br>">ibizafxpm@microsoft.com</a> instead of using the internal sites that are in this document. 

The subject of the email should contain the following.

**\<Onboarding Request ID> Add <extensionName> extension to the Portal**

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
 
Some of the procedures such as Accessibility, GB Certificate, Privacy, and Security are also measured in the Service Health Review Scorecard that is located at [https://aka.ms/shr](https://aka.ms/shr), and in the production-ready metrics for management review and tracking. 

These requirements apply to both the Portal fx and extensions. Since Fx provides the common infrastructure and UI controls that govern the data handling and UX, hence some of the compliance work for extensions would be identical across in Ibiza, and rationally be mitigated by the Framework. For example, Accessibility support on keyboard navigation and screen reader recognition, as well as the regional format and text support to meet globalization requirements, are implemented at the controls that Framework distributed.  The same is true for Security threat modeling, extension authentication to ARM, postMessage/RPC layer and UserSettings, etc. are handled by Framework. To minimize the duplicate efforts on those items, Fx provides some level of "blueprint" documentation that can be used as a reference for compliance procedures. You are still responsible to review the tools and submit the results for approval previous to shipping the extension. 

| Policy            | Location  | Fx coverage |
| ---               | ---       | --- |
| Accessibility     | [portalfx-accessibility.md](portalfx-accessibility.md) | Generic control supports on keyboard, focus handling, touch, screen reader, high contrast, and theming |
| Global Readiness  | [portalfx-globalization.md](portalfx-globalization.md) and [portalfx-localization.md](portalfx-localization.md) | Localizability, regional format, text support, China GB standard |
| Privacy           |  [portalfx-authentication.md](portalfx-authentication.md) | User settings data handling, encryption, and authentication |
| SDL               |  [https://microsoft.sharepoint.com/ teams/QualityEssentials/SitePages/ SDL_SecurityDevelopmentLifecycleOverview.aspx](https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/SDL_SecurityDevelopmentLifecycleOverview.aspx)         | Security Development Lifecycle Threat modeling |

For more information and any questions about Fx coverage, reach out to the Fx Coverage contact that is located in [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).


<a name="onboarding-outside-of-ibiza-quality-essentials"></a>
## Quality Essentials

Compliance criteria and practices are defined in Quality Essentials throughout the development cycle. These ensure that services meet the Trusted Cloud commitments outlined in the Microsoft Azure Trust Center for our customers. These are required procedures for preview and Global Availability, and are to be revisited for every release cycle.

The customer has a different set of expectations for the extension in each phase. To meet customer expectations, we have compiled production-ready metrics for each phase. The development of an extension  can proceed to the next step when it meets the production-ready metrics for the current step. To meet customer expectations and continue to increase customer satisfaction, several quality metrics are tracked for every extension by the Get1CS team. An overview of Quality Essentials is located at [https://aka.ms/qualityessentials](https://aka.ms/qualityessentials). There may be tools to install from the QE and 1CS sites that are part of the Quality Essentials process. The Azure team only tracks the production-ready metrics and localization requirements.

Nearly 70% of Azure users are from outside of the United States. Therefore, it is important to make Azure a globalized product. There are a few internationalization requirements that the extension or service is required to support. This is the same set of languages that are supported by Azure Portal for GA.

<a name="onboarding-outside-of-ibiza-communication"></a>
## Communication
   
Plan ahead for all the outbound communication, blogging, and marketing work that publicizes new services during the time that they are being deployed to customers.  This coordination is important, particularly when software release commitments are aligned with the Azure events and conferences. This coordination may be optional for preview releases, but the localized azure.com content and service updates plan are required for stakeholder signoff, if the extension will be deployed to GA.
 



<a name="onboarding-outside-of-ibiza-for-more-information"></a>
## For More Information
   
For more information about the Microsoft Azure Trust Center, see [http://azure.microsoft.com/en-us/support/trust-center/](http://azure.microsoft.com/en-us/support/trust-center/).

 For more information about quality metrics, see the One Compliance System Web site that is located at [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx).

For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). 

For more information about azure.com onboarding, see [http://acomdocs.azurewebsites.net](http://acomdocs.azurewebsites.net).

<a name="onboarding-outside-of-ibiza-glossary"></a>
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



