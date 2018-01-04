
<a name="azure-portal-glossary"></a>
# Azure Portal Glossary

 This section contains all glossaries from all Azure Portal Extension documents. There may be some duplication because documents may contain terms that are used in other documents.

<a name="azure-portal-glossary-cnames-and-cname-records"></a>
## CNAMEs and CNAME Records
<a name="azure-portal-glossary-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term             | Meaning |
| ---              | --- |
| BF               | Black Forest |
| CNAME            | Canonical Name record. A type of resource record in the Domain Name System (DNS) that specifies that a domain name is an alias for another domain (the 'canonical' domain). | 
| DNS              | Domain name server |
| FF               | Fairfax |  
| MPAC             | ms.portal.azure.com, the Azure portal instance for internal Microsoft customers. | 
| national cloud   | Network instances of Microsoft enterprise cloud services that are isolated physically and logically. They are confined within the geographic borders of specific countries and operated by local personnel. See sovereign cloud. |
| PROD             | Production |
| RC               | Release Candidate environment, used to deploy daily builds of the Azure Portal. There is no user traffic in this environment. |
| sovereign cloud  | Instances of Azure restricted to a particular group of users. This group may consist of one geopolitical boundary, like a country. It may also consist of one legal boundary, for example, the public sector. |
| TFS              | Team Foundation Server |
| URL              | Uniform Resource Locator |

<a name="azure-portal-glossary-extension-configuration"></a>
## Extension Configuration
<a name="azure-portal-glossary-glossary"></a>
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
| feature flag             | A switch that allows a user to turn on or off specific functionalities of an extension. Flags are  passed from the portal to extensions and their controllers, and are used as an alternative to maintaining multiple source-code branches in order to hide, enable or disable a feature during run time. Most, but not all, feature flags are made available by using the syntax `feature.<featureName> = true`.   |
| FF                       | Fairfax |
| flighting                | |
| flighting extension      | |
| GA                       | Global Availability |
| iframe                   | An inline frame, used to embed another document within the current HTML document. |
| MC                       | Mooncake |
| MPAC                     | ms.portal.azure.com, the Azure portal instance for internal Microsoft customers.  | 
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
| stamp                    | An instance of a service in a region. Every extension can deploy one or more stamps based on testing requirements. The main stamp is used for production and is the only one that the portal will load by default.    | 
| URI                      | Universal Resource Identifier  | 
| URL                      | Uniform Resource Locator |


  

<a name="azure-portal-glossary-extensions-onboarding"></a>
## Extensions Onboarding
<a name="azure-portal-glossary-glossary"></a>
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
| first-party extension     | An Azure portal extension that is developed by Microsoft |
| FAQ                       | Frequently Asked Questions | 
| GA                        | Global Availability | 
| gallery                   | Also known as Marketplace or Azure Portal Marketplace. See Marketplace Gallery. | 
| GB Certificate            | Six Sigma Green Belt Certification.  | 
| GB Standard               | GB stands for Guobiao, or “National Standard” in Chinese. The GB standard is the basis for testing products that require certification. | 
| Marketplace               | See Marketplace Gallery. | 
| Marketplace Gallery       | Also known as the Gallery or Marketplace Gallery. | 
| MPAC                      | ms.portal.azure.com, the Azure portal instance for internal Microsoft customers.  | 
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
| third-party extension     | An Azure portal extension that is developed by partners outside of Microsoft |
| URL                       | Uniform Resource Locator | 
| VP                        | Vice President | 
| Weighted Experience Score | The percentage of blade usage that meets the performance bar. |
| WxP                       | See Weighted Experience Score.  | 




<a name="azure-portal-glossary-hello-world-extension"></a>
## Hello World Extension
<a name="azure-portal-glossary-glossary"></a>
## Glossary
 
This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term          | Meaning | 
| ---           | --- |
| area          | Group of blades and parts that are associated with a single user-defined context.  |
| blade         | An Azure SDK object, or an object from a framework API, that contains content by using an HTML template.  That template is bound to properties on the TypeScript class of the object.  The main unit of the Azure UX that can be built using the Azure SDK.   The vertical container that acts as the starting point for any journey.  Web pages that can be loaded in the portal. |
| data binding  | The process that establishes a connection between the application UI and the business logic  behind the pane. |
| extension     | A Web application that was developed using the Azure Portal SDK and is made available to users through the Azure Portal. |
| framework     | A software environment that provides large software platform functionality in the process of building and deploying applications. The larger platform is selectively changed by adding developer code to make software applications. |
| part          | See blade. |
| SDK           | Software Development Kit. |
| UI            | User interface. |
| UX            | User experience. |

<a name="azure-portal-glossary-initializing-the-developer-platform"></a>
## Initializing the Developer Platform
 
<a name="azure-portal-glossary-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term              | Meaning |
| ---               | --- |
| Azure Portal SDK  | Software Development Kit for developing Azure Portal extensions. |
| CDN               | Content Delivery Network |
| IIS Express       | Internet Information Services. A Web server for hosting anything on the Web. |
| localhost         | A hostname that means this computer or this host.  |
| sideload          | The process of transferring data between two local devices, or between the development platform and the local host. Also side load, side-load. |  

<a name="azure-portal-glossary-testing-in-production"></a>
## Testing in Production
<a name="azure-portal-glossary-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term                 | Meaning |
| ---                  | --- |
| endpoint            | A device that is connected to a LAN and accepts or transmits communications across a network. In terms of directories or Web pages, there may be several endpoints that are defined on the same device.  | 
| obsolete script      | A script that makes certain parts of the portal act as legacy code, in order to limit the performance costs of the old functionality to only extensions that are using them. | 
| sandboxed iframe     | Enables an extra set of restrictions for the content in the iframe.  It can treat the content as being from a unique origin, block form submission or script execution, prevent links from targeting other browsing context, and other items that restrict the behavior of the iframe during testing. | 
| SAN                  | Storage Area Network  | 
| synthetic traffic    | Traffic that has been created with a traffic generators and that behaves like real traffic. It can be used to capture the behavior the network or device under test. | 


<a name="azure-portal-glossary-status-codes-and-error-messages"></a>
## Status Codes and Error Messages
<a name="azure-portal-glossary-glossary"></a>
## Glossary
   
This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term                      | Meaning |
| ---                       | --- |
| desktop state             | A snapshot of |
| first chance exception    | An exception's first pass through the debugger. Exceptions are thrown to the debugger first and then to the actual program.  If the exception is not handled by the program, it gets thrown to the debugger a second time. |
| SSL                       | Secure Socket Layer |



<!--
<a name="azure-portal-glossary-hosting-service"></a>
## Hosting Service
"gitdown": "include-file", "file": "./portalfx-extensions-hosting-service-glossary.md"
-->
<!--
<a name="azure-portal-glossary-key-components"></a>
## Key Components
"gitdown": "include-file", "file": "./portalfx-extensions-key-components-glossary.md"

<a name="azure-portal-glossary-extension-architecture"></a>
## Extension Architecture
"gitdown": "include-file", "file": "./portalfx-extensions-architecture-glossary.md"
-->
<!--
<a name="azure-portal-glossary-debugging-an-extension"></a>
## Debugging an Extension
"gitdown": "include-file", "file": "./portalfx-extensions-debugging-glossary.md"
-->