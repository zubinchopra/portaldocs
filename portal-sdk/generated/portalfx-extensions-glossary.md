
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
| MPAC             | ms.portal.azure.com, the Azure Portal instance for internal Microsoft customers. | 
| national cloud   | Network instances of Microsoft enterprise cloud services that are isolated physically and logically. They are confined within the geographic borders of specific countries and operated by local personnel. See sovereign cloud. |
| PROD             | Production |
| RC               | Release Candidate environment, used to deploy daily builds of the Azure Portal. There is no user traffic in this environment. |
| sovereign cloud  | Instances of Azure restricted to a particular group of users. This group may consist of one geopolitical boundary, like a country. It may also consist of one legal boundary, for example, the public sector. |
| TFS              | Team Foundation Server |
| URL              | Uniform Resource Locator |

<a name="azure-portal-glossary-debugging-extensions"></a>
## Debugging Extensions
<a name="azure-portal-glossary-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term                         | Meaning |
| ---                          | --- |
| data stack                   | Contains all the information that the browser associates with the current testing session. |
| deep link                    | A link that jumps directly into the extension within the Portal. Each deep link consists of the Portal URL, the target directory domain name or tenant id (e.g. microsoft.com), the type prefix (i.e. asset, resource, blade, browse, or marketplace), and the actual deep link target. |
| Document Object Model (DOM)  | A methodology that treats an  HTML, XHTML, or XML page as a tree structure that contains hierarchical objects. These nodes   represent every item  that is part of the document and can be manipulated programmatically. Visible changes to DOM nodes may be displayed in the browser. |
| iFrame                       | An inline frame that embeds a document within the current HTML document. | 
| Knockout                     | A standalone JavaScript implementation of the Model-View-ViewModel architecture. | 
| KO                         |  Knockout   | 
| minification                 | The process of removing all unnecessary characters from source code without changing its functionality. These characters may be whitespace, newlines, comments, and other non-executable items that increase code readability. Minification reduces the amount of data that is transferred across the Internet, and can be interpreted immediately without being uncompressed. | 
| PO | Proxy Observable |
| proxy observable (PO)        | A tool that synchronizes the ViewModel in an iframe with a copy of that ViewModel that is used by the Knockout debugger. | 
| Selenium                     | Software-testing framework for web applications that  provides a playback tool for authoring tests.  |
| startboard                   | |
| sticky                       | Provides quick statistics and fast access to specific types of testing functionality. |
| ViewModel                    | Holds all the data associated with the screen. Allows user data to be separated from context pane data and to persist through configuration changes. Also view model, View-Model. |



<a name="azure-portal-glossary-extension-configuration"></a>
## Extension Configuration
<a name="azure-portal-glossary-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

<!-- TODO:  Determine the difference between a branch, a region, and an environment. If they are not  completely interchangeable, then we can standardize usage. -->

| Term                     | Meaning |
| ---                      | --- |
| BF                       | Black Forest |
| branch | A collection of code in a content management system. |
| branch | The five Azure environments  in which extensions are run.  They are: Blackforest, Dogfood, FairFax, Mooncake, and the Production Release Candidate(s). |
| build verification test  | A subset of regression testing, this is a set of non-exhaustive tests that verify whether the most important application functions work. Its results are used to determine whether a build is stable enough to proceed with further testing. |
| BVT                      | Build Verification Test |
| cherry-pick              | Apply the changes introduced by an existing GitHub commit. |
| CDN                      | Content Delivery Network |
| CNAME                    | Canonical Name record. A type of resource record in the Domain Name System (DNS) that specifies that a domain name is an alias for another domain (the 'canonical' domain). | 
| DF                       | Dogfood |
| DIY                      | Do It Yourself |
| environment              | A configuration of computers in which extensions can be run. For example, environments are Blackforest, Dogfood, Mooncake, and Production.  | 
| feature flag             | A switch that allows a user to turn on or off specific functionalities of an extension. Flags are  passed from the Portal to extensions and their controllers, and are used as an alternative to maintaining multiple source-code branches in order to hide, enable or disable a feature during run time. Most, but not all, feature flags are made available by using the syntax `feature.<featureName> = true`.   |
| FF                       | Fairfax |
| flighting                | The process of directing Internet traffic to various editions of an extension, as specified by stamps that represent different stages or regions, or by friendly names. |
| GA                       | Global Availability |
| iframe                   | An inline frame, used to embed another document within the current HTML document. |
| MC                       | Mooncake |
| MPAC                     | ms.portal.azure.com, the Azure Portal instance for internal Microsoft customers.  | 
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
| stamp                    | An instance of a service in a region. Every extension can deploy one or more extension editions based on testing requirements. The main extension is used for production and is the only one that the Portal will load by default. Also known as configuration or configuration file.   | 
| URI                      | Universal Resource Identifier  | 
| URL                      | Uniform Resource Locator |


  

<a name="azure-portal-glossary-extensions-onboarding"></a>
## Extensions Onboarding
<!--TODO:  Determine which glossary terms are included in other bp documents previous to deleting this one -->
<a name="azure-portal-glossary-glossary"></a>
## Glossary
    
This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                      | Meaning |
| ---                       | --- |
| .Net                      | A software framework developed by Microsoft that runs primarily on Microsoft Windows. | 
| 1CS                       | One Compliance System  | 
| API                       | Application Programming Interface  |
| ARM                       | Azure Resource Manager |
| BladeFullReady            | The time it takes a blade to fully load. | 
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




<a name="azure-portal-glossary-feature-flags"></a>
## Feature Flags
<a name="azure-portal-glossary-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                | Meaning |
| ------------------- | --- |
| API contract | An agreement between two pieces of code as to how to pass parameters between them, and how those parameters are processed. |
| CDN                 | Content delivery network | 
| CI infrastructure   | | 
| curation            | The process of categorizing content around a specific topic or area of interest. Curated items often formed into various types of collections and are displayed together according to theme or purpose. | 
| diagnostic switch  | |
| DOM                | Document Object Model |
| feature flag       | A coding technique that allows the enabling or disabling of new code within a solution. It allows the testing and development-level viewing of new features, before they are complete and ready for private preview.  |
| IRIS               | | 
| manifest caching | | 
| marketplace | | 
| MVC                | Model-View-Controller, a methodology of software organization that separates the view from the data storage model in a way that allows the processor or a controller to multitask or switch between applications or orientations without losing data or damaging the view.|
| NPS popups         | Net Promoter Score | 
| ProxiedObservables | | 
| query string       | The part of a uniform resource locator (URL) that contains data. Query strings are generated by form submission, or by being entered into the address bar of the browser after the URL. The  query string is specified by the values following the question mark (?). The values are used in Web processing, along with the path component of the URL. Query strings should not be used to transfer large amounts of data.  | 
| stage | | 
| trace mode         | |
| web worker | A way to for extensions to run scripts in background threads. |

<a name="azure-portal-glossary-hello-world-extension"></a>
## Hello World Extension
<a name="azure-portal-glossary-glossary"></a>
## Glossary
 
This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term          | Meaning | 
| ---           | --- |
| area          | Group of blades and parts that are associated with a single user-defined context.  |
| blade         | An Azure SDK object, or an object from a framework API, that contains content by using an HTML template.  That template is bound to properties on the TypeScript class of the object.  The main unit of the Azure UX that can be built using the Azure SDK.   The vertical container that acts as the starting point for any journey.  Web pages that can be loaded in the Portal. |
| data binding  | The process that establishes a connection between the application UI and the business logic  behind the pane. |
| extension     | A Web application that was developed using the Azure Portal SDK and is made available to users through the Azure Portal. |
| framework     | A software environment that provides large software platform functionality in the process of building and deploying applications. The larger platform is selectively changed by adding developer code to make software applications. |
| part          | See blade. |
| SDK           | Software Development Kit. |
| UI            | User interface. |
| UX            | User experience. |

<a name="azure-portal-glossary-hosting-service"></a>
## Hosting Service
<a name="azure-portal-glossary-glossary"></a>
## Glossary

 This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                 | Meaning |
| ---                  | --- |
| bake time |  The time to wait between each stage of an extension deployment |
| caching              | Hosting service extensions use persistent caching, index page caching, and manifest caching, among others. |
| CDN                  | Content Delivery Network | 
| COGS                 | Cost of Goods Sold | 
| controller           | The main code that links the application to the operating system, or to the server, for   multitasking, or access to other services. Contains intelligence that becomes a part of the data model when using MVVM modeling instead of MVC modeling. |
| DIY                  | Do It Yourself |
| EV2                  | Express Version 2 |
| Express Version 2    | Safe, secure and compliant way to roll out services to multiple regions across public and private clouds.  | 
| endpoint             | A device that is connected to a LAN and accepts or transmits communications across a network. In terms of directories or Web pages, there may be several endpoints that are defined on the same device. |
| Enhanced monitoring  |  |
| geodistribute        | Distribute the extension to all data centers in various geographical locations. |
| geodistribution      | The process of deploying software in multiple geographic regions as a single logical database. |
| jit                  | Just In Time | 
| MDS                  |  Multilayer Director Switch | 
| MVC                  | Model-View-Controller, a methodology of software organization that separates the view from the data storage model in a way that allows the processor or a controller to multitask or switch between applications or orientations without losing data or damaging the view. |
| MVVM                 | Model-View-View-Model methodology.  A  method of software organization that separates the view from the data storage model, but depends on intelligence in the view or in the data objects so that there is no controller module that needs to process or transfer information.  The controller's function is handled instead by the device operating system or by the server that is communicating with the application. This methodology allows the application to multitask, call other functions that are located on the device, or switch between orientations without losing data or damaging the view. |
| public endpoint      | |
| RP                   | Resource Provider |
| SAW                  | Secure Admin Workstation | 
| server-side code     | Scripts that are located on a server that produce customized responses for each client request to the website, as opposed to the web server serving static web pages. |
| WARM                 | Windows Azure Release Management |
| zip file             | The extracted deployment artifacts that are generated during the build.  They and the  `config.json` file will be deployed to a public endpoint.  |

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



<a name="azure-portal-glossary-testing-in-production"></a>
## Testing in Production
<a name="azure-portal-glossary-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term                 | Meaning |
| ---                  | --- |
| Developer Tools Console | | 
| diagnostic switch | | 
| endpoint             | A device that is connected to a LAN and accepts or transmits communications across a network. In terms of directories or Web pages, there may be several endpoints that are defined on the same device.  |
| extension stamp | An instance of a service in a region. Every extension can deploy one or more extension editions based on testing requirements. The main extension is used for production and is the only one that the Portal will load by default. Also known as configuration or configuration file.   | 
| hotfix | |
| localhost            | A hostname that means this computer or this host.  |
| obsolete script      | A script that makes certain parts of the Portal act as legacy code, in order to limit the performance costs of the old functionality to only extensions that are using them. | 
| phishing | | 
| pull request | |
| private preview | |
| query string       | The part of a uniform resource locator (URL) that contains data. Query strings are generated by form submission, or by being entered into the address bar of the browser after the URL. The  query string is specified by the values following the question mark (?). The values are used in Web processing, along with the path component of the URL. Query strings should not be used to transfer large amounts of data.  | 
| sandboxed iframe     | Enables an extra set of restrictions for the content in the iframe.  It can treat the content as being from a unique origin, block form submission or script execution, prevent links from targeting other browsing context, and other items that restrict the behavior of the iframe during testing. | 
| SAN                  | Storage Area Network  | 
| sideloading          | Loading an extension for a specific user session from any source other than the uri that is registered in the Portal.  The process of transferring data between two local devices, or between the development platform and the local host. Also side load, side-load. |   
| synthetic traffic    | Traffic that has been created with a traffic generators and that behaves like real traffic. It can be used to capture the behavior the network or device under test. | 
| untrusted extension | An extension that is not accompanied by an SSL certificate. |
| usability testing | |

<!--
<a name="azure-portal-glossary-key-components"></a>
## Key Components
"gitdown": "include-file", "file": "./portalfx-extensions-key-components.md"

<a name="azure-portal-glossary-extension-architecture"></a>
## Extension Architecture
"gitdown": "include-file", "file": "./portalfx-extensions-glossary-architecture.md"
-->
