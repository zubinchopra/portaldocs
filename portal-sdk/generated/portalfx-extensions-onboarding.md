<a name="portal-extensions"></a>
# Portal Extensions

<a name="portal-extensions-introduction"></a>
## Introduction
   
Welcome to Azure! We're excited to have you to join the family and become a partner. If you are developing a service and want your customers to access it by using the Azure Portal, then this is the right starting point. The Azure Portal team supports the Azure Portal, its SDK, and the Framework that service teams use to integrate their management UI into the Azure Portal. 

The Microsoft Azure Portal, located at [https://portal.azure.com](https://portal.azure.com), is a central place where Azure customers can provision and manage Azure resources. The Azure Portal is a [single page application](portalfx-extensions-onboarding-glossary.md) that may contain more than one Web application. The parts of the page in the Portal are dynamically loaded based on customer actions.

A UI extension is essentially the user experience (UX) for a service. Extensions are developed by teams that integrate user interfaces into the Azure Portal. Extensions are dynamically accessed and loaded based on customer actions in the Portal.

The portal has an extension model where each team that builds user interfaces (UI) can create and deploy extensions. This process requires a relationship to be established between your team and the Portal team. This document reviews the process of onboarding your team and starting that relationship. 

Onboarding a service, or developing a Portal extension, has three phases: onboarding, development, and deployment. The process is specified in the following image.

![alt-text](../media/portalfx-extensions-onboarding/azure-onboarding.png "Azure Onboarding Process")
 
<a name="portal-development-phase-1"></a>
# Portal development phase 1

<a name="portal-development-phase-1-onboarding"></a>
## Onboarding
   
The items that are being developed extend functionality to an Azure Portal, and therefore are named extensions.  Some examples are in the following image.

 ![alt-text](../media/portalfx-ui-concepts/blade.png "Azure Portal Blades")

Perform the following tasks to become part of Azure Portal extension developer community.

1. [Schedule Kickoff Meetings](portalfx-extensions-onboarding1-kickoffs.md)

1. [Onboard with related teams](top-external-onboarding.md)

1. [Join DLs and request permissions](portalfx-extensions-onboarding1-permissions.md) 

1. [Get the developers started](top-extensions-getting-started.md)
 
You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).






  
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

1. [Learn about the hosting service](portalfx-extensions-onboarding2-hosting.md)

1. [Develop the extension](portalfx-extensions-onboarding2-develop.md)

1. [Register the extension](portalfx-extensions-onboarding2-registration.md)

You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).



<a name="portal-development-phase-2-best-practices"></a>
## Best Practices
   
Portal development patterns or architectures that are recommended based on customer feedback and usability studies are located in the topic for the blade that is being developed. For more information, see [portalfx-blades-best-practices.md](portalfx-blades-best-practices.md).

<a name="portal-development-phase-2-best-practices-performance"></a>
### Performance

There are practices that can improve the performance of the extension.  For more information, see [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md).


<a name="portal-development-phase-2-best-practices-productivity-tip"></a>
### Productivity Tip

Install Chrome that is located at [http://google.com/dir](http://google.com/dir) to leverage the debugger tools while developing an extension.

<a name="portal-development-phase-2-frequently-asked-questions"></a>
## Frequently asked questions

<a name="portal-development-phase-2-frequently-asked-questions-onboarding-faq"></a>
### Onboarding FAQ

***Where are the onboarding FAQs for Sparta (ARM/CSM-RP)?***

The SharePoint Sparta Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx).

* * *

<a name="portal-development-phase-2-frequently-asked-questions-ssl-certs"></a>
### SSL Certs
   
   <!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->
   
***How do I use SSL certs?***
 
 SSL Certs are relevant only for teams that host their own extensions.  Azure Portal ONLY supports loading extensions from HTTPS URLs. Use a wildcard SSL cert for each environment to simplify maintenance, for example,   ``` *.<extensionName>.onecloud-ext.azure-test.net  ``` or  ``` *.<extensionName>.ext.azure.com) ``` .    To simplify overall management when your team is building separate, independent extensions, you can also use  ``` <extensionName>.<team>.ext.azure.com ``` and create a wildcard SSL cert for  ``` *.<team>.ext.azure.com ```. Internal teams can create SSL certs for the DogFood environment using the SSL Administration Web page that is located at [http://ssladmin](http://ssladmin). 
 
  Production certs must follow your organization’s PROD cert process. 

 **NOTE** Do not use the SSL Admin site for production certs.

 * * *

 ### Compile on Save

**What is Compile on Save ?**

Compile on Save is a **TypeScript** option that   . To use it, make sure that **TypeScript** 2.0.3 was installed on your machine. The version can be verified by executing the following  command:

```bash
$>tsc -version
```
Then, verify that when a **TypeScript** file is saved, that the following text is displayed in the bottom left corner of your the **Visual Studio** application.

![alt-text](../media/portalfx-ide-setup/ide-setup.png "CompileOnSaveVisualStudio")

 * * *

<a name="portal-development-phase-2-frequently-asked-questions-other-onboarding-questions"></a>
### Other onboarding questions

***How can I ask questions about onboarding ?***

You can ask questions on Stackoverflow with the tag [onboarding](https://stackoverflow.microsoft.com/questions/tagged/onboarding).





  
<a name="portal-development-phase-3"></a>
# Portal development phase 3

<a name="portal-development-phase-3-deployment"></a>
## Deployment

1. [Deploy the extension](portalfx-extensions-onboarding3-deployment.md)

1. [Register the extension](portalfx-extensions-onboarding3-registration.md)

You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).


<a name="portal-development-phase-3-best-practices"></a>
## Best Practices
   
Portal development patterns or architectures that are recommended based on customer feedback and usability studies are located in the topic for the blade that is being developed. For more information, see [portalfx-blades-best-practices.md](portalfx-blades-best-practices.md).

<a name="portal-development-phase-3-best-practices-performance"></a>
### Performance

There are practices that can improve the performance of the extension.  For more information, see [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md).


<a name="portal-development-phase-3-best-practices-productivity-tip"></a>
### Productivity Tip

Install Chrome that is located at [http://google.com/dir](http://google.com/dir) to leverage the debugger tools while developing an extension.

<a name="portal-development-phase-3-frequently-asked-questions"></a>
## Frequently asked questions

<a name="portal-development-phase-3-frequently-asked-questions-onboarding-faq"></a>
### Onboarding FAQ

***Where are the onboarding FAQs for Sparta (ARM/CSM-RP)?***

The SharePoint Sparta Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx).

* * *

<a name="portal-development-phase-3-frequently-asked-questions-ssl-certs"></a>
### SSL Certs
   
   <!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->
   
***How do I use SSL certs?***
 
 SSL Certs are relevant only for teams that host their own extensions.  Azure Portal ONLY supports loading extensions from HTTPS URLs. Use a wildcard SSL cert for each environment to simplify maintenance, for example,   ``` *.<extensionName>.onecloud-ext.azure-test.net  ``` or  ``` *.<extensionName>.ext.azure.com) ``` .    To simplify overall management when your team is building separate, independent extensions, you can also use  ``` <extensionName>.<team>.ext.azure.com ``` and create a wildcard SSL cert for  ``` *.<team>.ext.azure.com ```. Internal teams can create SSL certs for the DogFood environment using the SSL Administration Web page that is located at [http://ssladmin](http://ssladmin). 
 
  Production certs must follow your organization’s PROD cert process. 

 **NOTE** Do not use the SSL Admin site for production certs.

 * * *

 ### Compile on Save

**What is Compile on Save ?**

Compile on Save is a **TypeScript** option that   . To use it, make sure that **TypeScript** 2.0.3 was installed on your machine. The version can be verified by executing the following  command:

```bash
$>tsc -version
```
Then, verify that when a **TypeScript** file is saved, that the following text is displayed in the bottom left corner of your the **Visual Studio** application.

![alt-text](../media/portalfx-ide-setup/ide-setup.png "CompileOnSaveVisualStudio")

 * * *

<a name="portal-development-phase-3-frequently-asked-questions-other-onboarding-questions"></a>
### Other onboarding questions

***How can I ask questions about onboarding ?***

You can ask questions on Stackoverflow with the tag [onboarding](https://stackoverflow.microsoft.com/questions/tagged/onboarding).



 
<a name="portal-development-phase-3-status-codes-and-error-messages"></a>
## Status Codes and Error Messages
Status codes or error messages that are encountered while developing an extension may be dependent on the type of extension that is being created, or the development phase in which the message is encountered.  Terms that are encountered in the error messages may be defined in the [Glossary](portalfx-extensions-glossary-status-codes.md).
<!-- TODO:  Find at least one status code for each of these conditions. -->

<a name="portal-development-phase-3-status-codes-and-error-messages-console-error-messages"></a>
### Console Error Messages

***Console error messages in F12 developer tools***

Some console and HTTP error messages are located at[https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx](https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx).

* * *

<a name="portal-development-phase-3-status-codes-and-error-messages-err_connection_reset"></a>
### ERR_CONNECTION_RESET

***Cannot load `localhost` Ibiza extension with ERR_CONNECTION_RESET***

ERROR: The Storage Area Network (SAN) is missing in the certificate.

SOLUTION: [https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595](https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595)

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-err_insecure_response"></a>
### ERR_INSECURE_RESPONSE

ERR_INSECURE_RESPONSE in the browser console

***My Extension fails to sideload and I get an ERR_INSECURE_RESPONSE in the browser console***.
   
![alt-text](../media/portalfx-testinprod/errinsecureresponse.png "ERR_INSECURE_RESPONSE Log")

ERROR: the browser is trying to load the extension but the SSL certificate from localhost is not trusted.

SOLUTION: Install and trust the certificate.

* * *

<a name="portal-development-phase-3-status-codes-and-error-messages-failed-to-initialize"></a>
### Failed To Initialize

ERROR: The extension failed to initialize. One or more calls to methods on the extension's entry point class failing.

SOLUTION: Scan all the relevant error messages during the timeframe of the failure. These errors should have information about what exactly failed while trying to initialize the extension, e.g. the initialize endpoint, the getDefinition endpoint, etc.

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-first-response-not-received"></a>
### First Response Not Received

ERROR: The shell loaded the extension URL obtained from the config into an IFrame; however there wasn't any response from the extension.

SOLUTION: 

1. Verify that the extension is correctly hosted and accessible from the browser.

1. The extension should have code injected in the  `layout.cshtml` which includes a postMessage call. Verify that this code gets executed.

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-invalid-definition"></a>
### Invalid Definition

ERROR: The definition that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension definition and fix them.

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-invalid-extension-name"></a>
### Invalid Extension Name

ERROR: The name of the extension as specified in the `extensions.json` configuration file doesn't match the name of the extension in the extension manifest.

SOLUTION: Verify what the correct name of the extension should be, and if the name in config is incorrect, update it.

If the name in the manifest is incorrect, contact the relevant extension team to update the  `<Extension>` tag in the PDL file with the right extension name and recompile.

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-invalid-indicate-loaded"></a>
### Invalid Indicate Loaded

ERROR: The manifest for an extension was received at an invalid time. e.g. if the manifest was already obtained or the extension was already loaded.

SOLUTION: Report this issue to the framework team for investigation.

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-invalid-manifest"></a>
### Invalid Manifest

ERROR: The manifest that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension manifest and fix them.

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-manifest-not-received"></a>
### Manifest Not Received

ERROR: The bootstrap logic was completed, however the extension did not return a manifest to the shell. The shell waits for a period of time (currently 40 seconds as of 2014/10/06) and then times out.

SOLUTION:
1. Verify that the extension is correctly hosted and accessible from the browser.

1. If the extension is using AMD modules, verify that the `manifest.js` file is accessible from the browser. Under default settings it should be present at `/Content/Scripts/_generated/manifest.js`.

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-portal-error-520"></a>
### Portal Error 520

***The Portal encountered a part it cannot render***

ERROR: The Portal displays a 520 error, as in the following image.

![alt-text](../media/portalfx-debugging/failure.png "Portal Error Message")

The Web server is returning an unknown error. 

SOLUTION: Use the following troubleshooting steps.

* Check the browser console, and look for errors that describe the error condition in more detail. 
* Click on the failed part. With some types of errors, this will add a stack trace to the browser console.
* Double check the Knockout template for correct syntax.
* Ensure that all variables that are used in the template are public properties on the corresponding view model class.
* Reset the desktop state.
* Enable first chance exceptions in the JavaScript debugger.
* Set break points inside the viewModel constructor to ensure no errors are thrown.

* * *

<a name="portal-development-phase-3-status-codes-and-error-messages-sandboxed-iframe-security"></a>
### Sandboxed iframe security

***Error: 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'.***
 
The Azure Portal should frame the extension URL, as specified in [portalfx-extensions-getting-started-procedure.md](portalfx-extensions-getting-started-procedure.md) and [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).  Also see [#console-error-messages](#console-error-messages).

* * *

<a name="portal-development-phase-3-status-codes-and-error-messages-timed-out"></a>
### Timed Out

ERROR: The extension failed to load after the predefined timeout, which is currently 40 seconds.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-too-many-bootgets"></a>
### Too Many BootGets

ERROR: The extension tried to send the bootGet message to request for Fx scripts multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION:  Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="portal-development-phase-3-status-codes-and-error-messages-too-many-refreshes"></a>
### Too Many Refreshes

ERROR: The extension tried  to reload itself within the IFrame multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 


   
<a name="portal-development-phase-3-stackoverflow-forums"></a>
## Stackoverflow Forums

The Ibiza team strives to answer the questions that are tagged with Ibiza tags on the Microsoft [Stackoverflow](https://stackoverflow.microsoft.com) Web site within 24 hours. If you do not receive a response within 24 hours, please email the owner associated with the tag. Third-party developers that have Stackoverflow questions should work with their primary contact.  If you do not yet have a primary contact, please reach out to our onboarding team at [mailto:ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com).

To help the Azure UI team answer your questions, the submissions are categorized into various topics that are marked with tags. 
To read forum submissions, enter the following in the address bar of your browser:

```https://stackoverflow.microsoft.com/questions/tagged/<ibizaTag>```

To ask a question in a forum, enter the following in the address bar of your browser.

```https://stackoverflow.microsoft.com/questions/ask?tags=<ibizaTag>```

where
 
**ibizaTag**:  One of the tags from the following table, without the angle brackets.

You can also click on the links in the table to open the correct Stackoverflow forum.
<!--TODO: Determine whether the following UserVoice categories also have Stackoverflow support. 
ibiza-notifications
ibiza-quotas
ibiza-samples-docs
-->

| Tag                                                                                                            | Owner               | Contact |
| -------------------------------------------------------------------------------------------------------------- | ------------------- | ------- |
| [azure-gallery](https://stackoverflow.microsoft.com/questions/tagged/azure-gallery)                            |                     | |
| [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza)                                            | Adam Abdelhamed         | |
| [ibiza-accessibility](https://stackoverflow.microsoft.com/questions/tagged/ibiza-accessibility)                | Paymon Parsadmehr   | [mailto:ibiza-accessibility@microsoft.com](mailto:ibiza-accessibility@microsoft.com) | 
| [ibiza-bad-samples-doc](https://stackoverflow.microsoft.com/questions/tagged/ibiza-bad-samples-doc)            | Adam Abdelhamed          | |
| [ibiza-blades-parts](https://stackoverflow.microsoft.com/questions/tagged/ibiza-blades-parts)                  | Sean Watson         | |
| [ibiza-breaking-changes](https://stackoverflow.microsoft.com/questions/tagged/ibiza-breaking-changes)          | Adam Abdelhamed          | |
| [ibiza-browse](https://stackoverflow.microsoft.com/questions/tagged/ibiza-browse)                              | Sean Watson         | |
| [ibiza-controls](https://stackoverflow.microsoft.com/questions/tagged/ibiza-controls)                          | Shrey Shirwaikar    | |
| [ibiza-controls-grid](https://stackoverflow.microsoft.com/questions/tagged/ibiza-controls-grid)                | Shrey Shirwaikar    | |
| [ibiza-create](https://stackoverflow.microsoft.com/questions/tagged/ibiza-create)                              | Balbir Singh        | |
| [ibiza-data-caching](https://stackoverflow.microsoft.com/questions/tagged/ibiza-data-caching)                  | Adam Abdelhamed          | |
| [ibiza-deployment](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment)                      | Umair Aftab         | |
| [ibiza-forms](https://stackoverflow.microsoft.com/questions/tagged/ibiza-forms)                                | Shrey Shirwaikar    | |
| [ibiza-forms-create](https://stackoverflow.microsoft.com/questions/tagged/ibiza-forms-create)                  | Paymon Parsadmehr; Shrey Shirwaikar | |
| [ibiza-hosting-service](https://stackoverflow.microsoft.com/questions/tagged/ibiza-hosting-service)            | Umair Aftab         | |
| [ibiza-kusto](https://stackoverflow.microsoft.com/questions/tagged/ibiza-kusto)                                |                     | |
| [ibiza-localization-global](https://stackoverflow.microsoft.com/questions/tagged/ibiza-localization-global)    | Paymon Parsadmehr   | |
| [ibiza-missing-docs](https://stackoverflow.microsoft.com/questions/tagged/ibiza-missing-docs)                  |                     | |
| [ibiza-monitoringux](https://stackoverflow.microsoft.com/questions/tagged/ibiza-monitoringux)                  |                     | |
| [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding)                      | Santhosh Somayajula                 | |
| [ibiza-performance](https://stackoverflow.microsoft.com/questions/tagged/ibiza-performance)                    | Sean Watson         | |
| [ibiza-reliability](https://stackoverflow.microsoft.com/questions/tagged/ibiza-reliability)                    | Sean Watson         | |
| [ibiza-resources](https://stackoverflow.microsoft.com/questions/tagged/ibiza-resources)                        | Balbir Singh        | |
| [ibiza-sdkupdate](https://stackoverflow.microsoft.com/questions/tagged/ibiza-sdkupdate)                        | Umair Aftab         | |
| [ibiza-security-auth](https://stackoverflow.microsoft.com/questions/tagged/ibiza-security-auth)                | Santhosh Somayajula | |
| [ibiza-telemetry](https://stackoverflow.microsoft.com/questions/tagged/ibiza-telemetry)                        | Sean Watson         | |
| [ibiza-test](https://stackoverflow.microsoft.com/questions/tagged/ibiza-test)                                  | Adam Abdelhamed          | |
| [ibiza-uncategorized](https://stackoverflow.microsoft.com/questions/tagged/ibiza-uncategorized)                |                     | |


   
<a name="portal-development-phase-3-contacts"></a>
## Contacts
   
For assistance with the prerequisites for onboarding Management UI, contact the following people.  A :star: means they are a part of the Azure team instead of a support team contact.

If the following table is not current, please send a pull request to update the the contact list. For more information on how to send a pull request, see [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

| Function                                      | Azure Stakeholder                          | Contact                                                                       |
| --------------------------------------------- | -----------------------------------------  | ----------------------------------------------------------------------------- |
| Accessibility	                                | :star:Paymon Parsadmehr, Erica Mohler            |  <a href="mailto:ibiza-accessibility@microsoft.com?subject=Accessibility">ibiza-accessibility@microsoft.com</a> |
| Activity logs	                                | :star:Marck Robinson                             | [ibiza-activity-logs@microsoft.com](mailto:ibiza-activity-logs@microsoft.com)  |
| The ARM Team                                  |                                            | [aux-arm-leads@microsoft.com](mailto:aux-arm-leads@microsoft.com)  |
| Azure.com	                                    | Elena Salaks; Guy Burstein                 | [ibiza-azure@microsoft.com](mailto:ibiza-azure@microsoft.com)  |
| Azure Compliance                              | :star:Azure Compliance team                      | [azcompl@microsoft.com](mailto:azcompl@microsoft.com)  |
| Azure Resource Manager (ARM)                  | Vlad Joanovic                              | [ibiza-arm@microsoft.com](mailto:ibiza-arm@microsoft.com)  |
| Business model review                         | Integrated Marketing; Brian Hillger’s team | [ibiza-bmr@microsoft.com](mailto:ibiza-bmr@microsoft.com)  |
| Business model review                         | L&R - Operations - GD\&F; Stacey Ellingson | [ibiza-bmr@microsoft.com](mailto:ibiza-bmr@microsoft.com)  |
| Create success                                | :star:Balbir Singh                               | [ibiza-create@microsoft.com](mailto:ibiza-create@microsoft.com)  |
| CSS Support                                   | Wes Penner; CEGRM                          | [ibiza-css@microsoft.com](mailto:ibiza-css@microsoft.com)  |
| External Partner Contact                      |                                            | [ibizafxpm@microsoft.com](mailto:ibizafxpm@microsoft.com)  |
| Fx Coverage 	                                | :star:Adam Abdelhamed; :star: Santhosh Somayajula       | [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com)  |
| Localization                                  | Bruno Lewin                                | [ibiza-interntnl@microsoft.com](mailto:ibiza-interntnl@microsoft.com)  |
| Onboarding kickoff                            | :star:Leon Welicki; :star:Adam Abdelhamed; :star:Santhosh Somayajula | [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com) |
| Third Party Applications (External partners)  | :star:Leon Welicki; :star:Adam Abdelhamed; :star:Santhosh Somayajula | [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com) |
| Performance                                   | :star:Sean Watson                                | [ibiza-perf@microsoft.com](mailto:ibiza-perf@microsoft.com) |
| Pull requests                                 |                                            | [ibizafxpm@microsoft.com](mailto:ibizafxpm@microsoft.com) |
| Registration for internal extensions          |                                            | [ibizafxpm@microsoft.com](mailto:ibizafxpm@microsoft.com) |
| Quality Essentials                            |                                            | [Get1CS@microsoft.com​](mailto:Get1CS@microsoft.com) |
| Reliability                                   | :star:Sean Watson                                | [ibiza-reliability@microsoft.com](mailto:ibiza-reliability@microsoft.com) |
| Resource Move                                 | Edison Park                                | [ibiza-resourceMove@microsoft.com](mailto:ibiza-resourceMove@microsoft.com) |
| Usability	                                    | Joe Hallock; Mariah Jackson                | [ibiza-usability@microsoft.com](mailto:ibiza-usability@microsoft.com) |
| UX feasibility review                         | :star:Santhosh Somayajula                        | [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com) | 

<a name="portal-development-phase-3-for-more-information"></a>
## For More Information
   
For more information about development phases, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

For more information about the Microsoft Azure Trust Center, see [http://azure.microsoft.com/en-us/support/trust-center/](http://azure.microsoft.com/en-us/support/trust-center/).

For more information about exit criteria, see [top-exit-criteria.md](top-exit-criteria.md).

 For more information about quality metrics, see the One Compliance System Web site that is located at [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx).

For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). 

For more information about localization requirements, see [portalfx-localization.md](portalfx-localization.md). 

For more information about azure.com onboarding, see [http://acomdocs.azurewebsites.net](http://acomdocs.azurewebsites.net).
 
<a name="portal-development-phase-3-glossary"></a>
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


