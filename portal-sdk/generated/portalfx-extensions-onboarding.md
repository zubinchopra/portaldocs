<a name="portal-extensions"></a>
# Portal Extensions

<a name="portal-extensions-introduction"></a>
## Introduction
   
Welcome to Azure! We're excited to have you to join the family and become a partner. If you are developing a service and want your customers to access it by using the Azure Portal, then this is the right starting point. The Azure Portal team supports the Azure Portal, its SDK, and the Framework that service teams use to integrate their management UI into the Azure Portal. 

The Microsoft Azure Portal, located at [https://portal.azure.com](https://portal.azure.com), is a central place where Azure customers can provision and manage Azure resources. The Azure Portal is a [single page application](portalfx-extensions-onboarding-glossary.md) that may contain more than one Web application. The parts of the page in the Portal are dynamically loaded based on customer actions.

A UI extension is essentially the user experience (UX) for a service. Extensions are developed by teams that integrate user interfaces into the Azure Portal. Extensions are dynamically accessed and loaded based on customer actions in the Portal.

The portal has an extension model where each team that builds user interfaces (UI) can create and deploy extensions. This process requires a relationship to be established between your team and the Portal team. This document reviews the process of onboarding your team and starting that relationship. The process is specified in the following image.

![alt-text](../media/portalfx-extensions-onboarding/azure-onboarding.png "Azure Onboarding Process")

<a name="portal-extensions-onboarding-a-service"></a>
## Onboarding a service

Onboarding a service, or developing a Portal extension, has three phases: onboarding, development, and deployment.
 
<a name="portal-development-phase-1-onboarding"></a>
# Portal development phase 1: onboarding

<a name="portal-development-phase-1-onboarding-development-procedures"></a>
## Development Procedures
   
The items that are being developed extend functionality to an Azure Portal, and therefore are named extensions.  Some examples are in the following image.

 ![alt-text](../media/portalfx-ui-concepts/blade.png "Azure Portal Blades")

Perform the following tasks to become part of Azure Portal extension developer community.

* Prerequisites to Azure Portal onboarding

1. [Schedule Kickoff Meetings](#schedule-kickoff-meetings)

1. [Onboard with related teams](top-external-onboarding.md)

1. [Join DLs and request permissions](#join-dls-and-request-permissions) 

1. [Get the developers started](top-extensions-getting-started.md)
 
You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).

<a name="portal-development-phase-1-onboarding-development-procedures-schedule-kickoff-meetings"></a>
### Schedule Kickoff Meetings
 
Reach out to the <a href="mailto:ibiza-onboarding-kick@microsoft.com?subject=Kickoff Meeting Request&body=My team would like to meet with you to learn about the Azure onboarding process.">Portal team</a> and request a kickoff meeting. A team representative will deliver a 30-minute overview of the onboarding process. We can direct you to the latest patterns and practices, talk about the relationship between our teams,  and answer questions.  

<!--TODO: Are the business model review and the feasibility study previous to or a  part of the kickoff meetings?  they are in the step-by-step named Develop and deploy the extension, and they seem to occur after the team is onboard but before the extension is developed. -->

Make sure the extension that will be developed has passed the business model review and is feasible previous to the kickoff meetings. For more information about business model reviews and feasibility studies, see .

Schedule and attend the kickoff meeting(s) hosted by your PM or Dev Lead. These meetings will touch on the following points.

* Whether the service will target public Azure, on-premises, or both
* What is the name of the service
* Summary of the service and target scenarios

If you are planning to build a first party application, i.e., you are a part of Microsoft, the meeting agenda will also include:
* VP, PM, and engineering owners
* Timelines (preview, GA)

When these meetings have concluded, your team will be ready to build extensions.

<a name="portal-development-phase-1-onboarding-development-procedures-join-dls-and-request-permissions"></a>
### Join DLs and request permissions

Request the following permissions to stay current on product roadmaps, get news on latest features, and read workshop announcements.

* PMs and Developer Leads need to join the  `ibizapartners PM`  group by clicking on this link: [http://igroup/join/ibizapartners-pm](http://igroup/join/ibizapartners-pm). 

* Developers should join the  `ibizapartners DEV` group by clicking on this  link:  [http://igroup/join/ibizapartners-dev](http://igroup/join/ibizapartners-dev). 

* Developers should join the  ```Azure Portal Core Team - 15003(15003)``` group by using this link: [http://ramweb](http://ramweb).

* PMs, Developers, and Developer Leads should subscribe to the partner request process by joining the ```Uservoice ``` group at this link:  [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice). For more information about the partner request process, see [portalfx-extension-partner-request-process.md](portalfx-extension-partner-request-process.md).

* PMs, Developers, and Developer Leads should receive notifications on breaking changes by joining the ```ibizabreak ``` group at  this  link:  [http://igroup/join/ibizabreak](http://igroup/join/ibizabreak).

* PMs, Developers, and Developer Leads  should join Stackoverflow Forums that are located at [https://stackoverflow.microsoft.com](https://stackoverflow.microsoft.com)  to let us know if you have any questions. Remember to tag questions with ```ibiza``` or related tag.

* Developers who want to contribute to the Azure documentation or test framework should join groups from the site located at [http://aka.ms/azuregithub](http://aka.ms/azuregithub).


 
<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages"></a>
## Status Codes and Error Messages
Status codes or error messages that are encountered while developing an extension may be dependent on the type of extension that is being created, or the development phase in which the message is encountered.  Terms that are encountered in the error messages may be defined in the [Glossary](portalfx-extensions-glossary-status-codes.md).
<!-- TODO:  Find at least one status code for each of these conditions. -->

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-console-error-messages"></a>
### Console Error Messages

***Console error messages in F12 developer tools***

Some console and HTTP error messages are located at[https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx](https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx).

* * *

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-err_connection_reset"></a>
### ERR_CONNECTION_RESET

***Cannot load `localhost` Ibiza extension with ERR_CONNECTION_RESET***

ERROR: The Storage Area Network (SAN) is missing in the certificate.

SOLUTION: [https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595](https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595)

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-err_insecure_response"></a>
### ERR_INSECURE_RESPONSE

ERR_INSECURE_RESPONSE in the browser console

***My Extension fails to sideload and I get an ERR_INSECURE_RESPONSE in the browser console***.
   
![alt-text](../media/portalfx-testinprod/errinsecureresponse.png "ERR_INSECURE_RESPONSE Log")

ERROR: the browser is trying to load the extension but the SSL certificate from localhost is not trusted.

SOLUTION: Install and trust the certificate.

* * *

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-failed-to-initialize"></a>
### Failed To Initialize

ERROR: The extension failed to initialize. One or more calls to methods on the extension's entry point class failing.

SOLUTION: Scan all the relevant error messages during the timeframe of the failure. These errors should have information about what exactly failed while trying to initialize the extension, e.g. the initialize endpoint, the getDefinition endpoint, etc.

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-first-response-not-received"></a>
### First Response Not Received

ERROR: The shell loaded the extension URL obtained from the config into an IFrame; however there wasn't any response from the extension.

SOLUTION: 

1. Verify that the extension is correctly hosted and accessible from the browser.

1. The extension should have code injected in the  `layout.cshtml` which includes a postMessage call. Verify that this code gets executed.

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-invalid-definition"></a>
### Invalid Definition

ERROR: The definition that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension definition and fix them.

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-invalid-extension-name"></a>
### Invalid Extension Name

ERROR: The name of the extension as specified in the `extensions.json` configuration file doesn't match the name of the extension in the extension manifest.

SOLUTION: Verify what the correct name of the extension should be, and if the name in config is incorrect, update it.

If the name in the manifest is incorrect, contact the relevant extension team to update the  `<Extension>` tag in the PDL file with the right extension name and recompile.

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-invalid-indicate-loaded"></a>
### Invalid Indicate Loaded

ERROR: The manifest for an extension was received at an invalid time. e.g. if the manifest was already obtained or the extension was already loaded.

SOLUTION: Report this issue to the framework team for investigation.

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-invalid-manifest"></a>
### Invalid Manifest

ERROR: The manifest that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension manifest and fix them.

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-manifest-not-received"></a>
### Manifest Not Received

ERROR: The bootstrap logic was completed, however the extension did not return a manifest to the shell. The shell waits for a period of time (currently 40 seconds as of 2014/10/06) and then times out.

SOLUTION:
1. Verify that the extension is correctly hosted and accessible from the browser.

1. If the extension is using AMD modules, verify that the `manifest.js` file is accessible from the browser. Under default settings it should be present at `/Content/Scripts/_generated/manifest.js`.

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-portal-error-520"></a>
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

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-sandboxed-iframe-security"></a>
### Sandboxed iframe security

***Error: 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'.***
 
The Azure Portal should frame the extension URL, as specified in [portalfx-extensions-getting-started-procedure.md](portalfx-extensions-getting-started-procedure.md) and [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).  Also see [#console-error-messages](#console-error-messages).

* * *

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-timed-out"></a>
### Timed Out

ERROR: The extension failed to load after the predefined timeout, which is currently 40 seconds.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-too-many-bootgets"></a>
### Too Many BootGets

ERROR: The extension tried to send the bootGet message to request for Fx scripts multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION:  Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="portal-development-phase-1-onboarding-status-codes-and-error-messages-too-many-refreshes"></a>
### Too Many Refreshes

ERROR: The extension tried  to reload itself within the IFrame multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 






  
<a name="portal-development-phase-2-development"></a>
# Portal development phase 2: development

<a name="portal-development-phase-2-development-development-procedures"></a>
## Development Procedures
   
The items that are being developed extend functionality to an Azure Portal, and therefore are named extensions. Perform the following tasks to become part of Azure Portal extension developer community.

1. [Review Technical Guidance](#review-technical-guidance)

1. [Network with support teams](#network-with-support-teams)

1. [Develop the extension](#develop-the-extension)

You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).

<a name="portal-development-phase-2-development-development-procedures-review-technical-guidance"></a>
### Review Technical Guidance

You may want to review the following documents from the Azure Portal UI team site. These provide technical guidance for use while you are building an extension.

| Function                                      | Title and Link |
| --------------------------------------------- | -------------- |
| Guidance for Program Managers and Dev Leads   | Portal Extensions for Program Managers, located at [portalfx-extensions-forProgramManagers.md](portalfx-extensions-forProgramManagers.md) |
| Private Preview, Public Preview, and GA       | Portal Extension Development Phases, located at [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md) |
| How it Works	                                | Getting Started, located at [portalfx-howitworks.md#getting-started](portalfx-howitworks.md#getting-started)
| Build an empty extension                      | Creating An Extension, located at [portalfx-extensions-create-blank-procedure.md](portalfx-extensions-create-blank-procedure.md) |
| Portal environments and extension configurations | [portalfx-extensions-branches.md](portalfx-extensions-branches.md) | 
| Experiment with sample code	                  | Sample Extensions, located at [portalfx-extensions-samples.md](portalfx-extensions-samples.md) |

<a name="portal-development-phase-2-development-development-procedures-network-with-support-teams"></a>
### Network with support teams
 
1. To ensure that the business goals of the new extension or service are aligned with Azure's business strategy, please reach out to the Integrated Marketing Team or the L&R - Operations - GD&F team at [mailto:ibiza-bmr@microsoft.com?subject=Azure%20Business%20model%20review](mailto:ibiza-bmr@microsoft.com?subject=Azure%20Business%20model%20review). Brian Hillger’s team and Stacey Ellingson’s team will guide you through the business model review process. The extension or service is not ready to be onboarded to Azure until its business model has received approval from those teams. Do not proceed with the next step until the business model has received approval.

1. Schedule a UX feasibility review with the Ibiza team UX contact by emailing [mailto:ibiza-onboarding@microsoft.com?subject=Extension%20Feasibility%20Review](mailto:ibiza-onboarding@microsoft.com?subject=Extension%20Feasibility%20Review).  Many extensions have been made more successful by setting up early design reviews with the Azure Portal team. Taking the time to review the design gives extension owners an opportunity to understand how they can leverage Azure Portal design patterns, and ensure that the desired outcome is feasible. 

1. If the extension requires additional built-in support for standard Graph or ARM APIs, submit a partner request at the site located at [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice).  For information about other components that the new service needs, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).

1. Start the CSS onboarding process with the CSS team at least three months previous to public preview. This process may coincide with the following step. For more information about development phases, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

<a name="portal-development-phase-2-development-development-procedures-develop-the-extension"></a>
### Develop the extension

1. Build the extension and sideload it for local testing. Sideloading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about sideloading, see [portalfx-extensions-sideloading-overview.md](portalfx-extensions-sideloading-overview.md) and [portalfx-testinprod.md](portalfx-testinprod.md). 

1. Complete the development and unit testing of the extension. For more information on debugging, see [portalfx-debugging.md](portalfx-debugging.md) and [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).

1. Address the exit criteria to meet previous to moving the extension to the next development phase. The exit criteria are located at [top-exit-criteria.md](top-exit-criteria.md).

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).
 
<a name="portal-development-phase-2-development-status-codes-and-error-messages"></a>
## Status Codes and Error Messages
Status codes or error messages that are encountered while developing an extension may be dependent on the type of extension that is being created, or the development phase in which the message is encountered.  Terms that are encountered in the error messages may be defined in the [Glossary](portalfx-extensions-glossary-status-codes.md).
<!-- TODO:  Find at least one status code for each of these conditions. -->

<a name="portal-development-phase-2-development-status-codes-and-error-messages-console-error-messages"></a>
### Console Error Messages

***Console error messages in F12 developer tools***

Some console and HTTP error messages are located at[https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx](https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx).

* * *

<a name="portal-development-phase-2-development-status-codes-and-error-messages-err_connection_reset"></a>
### ERR_CONNECTION_RESET

***Cannot load `localhost` Ibiza extension with ERR_CONNECTION_RESET***

ERROR: The Storage Area Network (SAN) is missing in the certificate.

SOLUTION: [https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595](https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595)

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-err_insecure_response"></a>
### ERR_INSECURE_RESPONSE

ERR_INSECURE_RESPONSE in the browser console

***My Extension fails to sideload and I get an ERR_INSECURE_RESPONSE in the browser console***.
   
![alt-text](../media/portalfx-testinprod/errinsecureresponse.png "ERR_INSECURE_RESPONSE Log")

ERROR: the browser is trying to load the extension but the SSL certificate from localhost is not trusted.

SOLUTION: Install and trust the certificate.

* * *

<a name="portal-development-phase-2-development-status-codes-and-error-messages-failed-to-initialize"></a>
### Failed To Initialize

ERROR: The extension failed to initialize. One or more calls to methods on the extension's entry point class failing.

SOLUTION: Scan all the relevant error messages during the timeframe of the failure. These errors should have information about what exactly failed while trying to initialize the extension, e.g. the initialize endpoint, the getDefinition endpoint, etc.

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-first-response-not-received"></a>
### First Response Not Received

ERROR: The shell loaded the extension URL obtained from the config into an IFrame; however there wasn't any response from the extension.

SOLUTION: 

1. Verify that the extension is correctly hosted and accessible from the browser.

1. The extension should have code injected in the  `layout.cshtml` which includes a postMessage call. Verify that this code gets executed.

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-invalid-definition"></a>
### Invalid Definition

ERROR: The definition that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension definition and fix them.

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-invalid-extension-name"></a>
### Invalid Extension Name

ERROR: The name of the extension as specified in the `extensions.json` configuration file doesn't match the name of the extension in the extension manifest.

SOLUTION: Verify what the correct name of the extension should be, and if the name in config is incorrect, update it.

If the name in the manifest is incorrect, contact the relevant extension team to update the  `<Extension>` tag in the PDL file with the right extension name and recompile.

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-invalid-indicate-loaded"></a>
### Invalid Indicate Loaded

ERROR: The manifest for an extension was received at an invalid time. e.g. if the manifest was already obtained or the extension was already loaded.

SOLUTION: Report this issue to the framework team for investigation.

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-invalid-manifest"></a>
### Invalid Manifest

ERROR: The manifest that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension manifest and fix them.

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-manifest-not-received"></a>
### Manifest Not Received

ERROR: The bootstrap logic was completed, however the extension did not return a manifest to the shell. The shell waits for a period of time (currently 40 seconds as of 2014/10/06) and then times out.

SOLUTION:
1. Verify that the extension is correctly hosted and accessible from the browser.

1. If the extension is using AMD modules, verify that the `manifest.js` file is accessible from the browser. Under default settings it should be present at `/Content/Scripts/_generated/manifest.js`.

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-portal-error-520"></a>
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

<a name="portal-development-phase-2-development-status-codes-and-error-messages-sandboxed-iframe-security"></a>
### Sandboxed iframe security

***Error: 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'.***
 
The Azure Portal should frame the extension URL, as specified in [portalfx-extensions-getting-started-procedure.md](portalfx-extensions-getting-started-procedure.md) and [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).  Also see [#console-error-messages](#console-error-messages).

* * *

<a name="portal-development-phase-2-development-status-codes-and-error-messages-timed-out"></a>
### Timed Out

ERROR: The extension failed to load after the predefined timeout, which is currently 40 seconds.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-too-many-bootgets"></a>
### Too Many BootGets

ERROR: The extension tried to send the bootGet message to request for Fx scripts multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION:  Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="portal-development-phase-2-development-status-codes-and-error-messages-too-many-refreshes"></a>
### Too Many Refreshes

ERROR: The extension tried  to reload itself within the IFrame multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 



<a name="portal-development-phase-2-development-best-practices"></a>
## Best Practices
   
Portal development patterns or architectures that are recommended based on customer feedback and usability studies are located in the topic for the blade that is being developed. For more information, see [portalfx-blades-best-practices.md](portalfx-blades-best-practices.md).

<a name="portal-development-phase-2-development-best-practices-performance"></a>
### Performance

There are practices that can improve the performance of the extension.  For more information, see [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md).


<a name="portal-development-phase-2-development-best-practices-productivity-tip"></a>
### Productivity Tip

Install Chrome that is located at [http://google.com/dir](http://google.com/dir) to leverage the debugger tools while developing an extension.

<a name="portal-development-phase-2-development-frequently-asked-questions"></a>
## Frequently asked questions

<a name="portal-development-phase-2-development-frequently-asked-questions-onboarding-faq"></a>
### Onboarding FAQ

***Where are the onboarding FAQs for Sparta (ARM/CSM-RP)?***

The SharePoint Sparta Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx).

* * *

<a name="portal-development-phase-2-development-frequently-asked-questions-ssl-certs"></a>
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

<a name="portal-development-phase-2-development-frequently-asked-questions-other-onboarding-questions"></a>
### Other onboarding questions

***How can I ask questions about onboarding ?***

You can ask questions on Stackoverflow with the tag [onboarding](https://stackoverflow.microsoft.com/questions/tagged/onboarding).





  
<a name="portal-development-phase-3-deployment"></a>
# Portal development phase 3: deployment

<a name="portal-development-phase-3-deployment-deployment-procedures"></a>
## Deployment Procedures

1. [Deploy the extension](#deploy-the-extension)

1. [Register the extension](#register-the-extension)

You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).

<a name="portal-development-phase-3-deployment-deployment-procedures-deploy-the-extension"></a>
### Deploy the extension

1. When you are confident that the development of the extension is complete, you should execute the following process so the specific work required for the Azure Fundamental tenets appears in Service360, as specified in [Azure Fundamentals](https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d). 
    * Add the service to ServiceTree, which is located at [https://servicetree.msftcloudes.com](https://servicetree.msftcloudes.com)
    * Make the service be "Active" in ServiceTree
    * Complete metadata in ServiceTree to enable the automation for various Service360 Action Items
    * Complete the Action Items identified in Service360, which is located at [http://aka.ms/s360](http://aka.ms/s360)

1. 	Integrate the extension into the Marketplace. 

    In the following images, each icon in the Azure Portal Marketplace is referred to as a Gallery item. Gallery items take the form of a file with the .azpkg extension. This is a  zip file which contains all assets for the gallery item: icons, screenshots, descriptions.

    ![alt-text](../media/portalfx-extensions-onboarding/azurePortalMarketPlace.png "Azure Portal Marketplace")

    * **PROD:** The Marketplace team accepts fully finished .azkpg files from your team and uploads them to Production to onboard the gallery package. Send the following email to 1store@microsoft.com.  The subject line should contain “Marketplace Onboarding Request” and the *.azpkg file should be attached to the email, as in the following image.

      ![alt-text](../media/portalfx-extensions-onboarding/marketplaceOnboardingRequest.png "Marketplace Onboarding Request")

    * **DOGFOOD:** Use AzureGallery.exe to upload items to DOGFOOD using the following command:

      ```AzureGallery.exe upload -p ..\path\to\package.azpkg -h [optional hide key]```

    In order to use the gallery loader, there are some values to set in the AzureGallery.exe.config file. For more information, see the Gallery Item Specifications document that is located at      [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations).  

    For more dev/test scenarios, see [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production).


<a name="portal-development-phase-3-deployment-deployment-procedures-register-the-extension"></a>
### Register the extension

Once the name of the extension or service name is finalized, request to have the extension registered in all environments. Registering an extension in Portal requires deployment so it can take almost 10 days in the Production environment. Please plan accordingly.

* For internal partners, the request to register an extension is a pull request, as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).
 
* External teams can submit their requests by sending an email that resembles the following image.

  ![alt-text](../media/portalfx-extensions-onboarding/registrationRequest.png "Extension Registration Onboarding Request")
 
* After deploying the extension to the DOGFOOD (DF) environment, contact the Fx team to request that they enable the extension, if applicable. Every extension  meets required exit criteria / quality metrics before it will be enabled. The  extension will be enabled in production once all exit criteria have been met.

   Extension names must use standard extension name format, as in the example located at [portalfx-extensions-configuration-overview.md#name](portalfx-extensions-configuration-overview.md#name).

* Extension URLs must use a standard CNAME pattern. For more information about CNAMES, see [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md).

 
<a name="portal-development-phase-3-deployment-status-codes-and-error-messages"></a>
## Status Codes and Error Messages
Status codes or error messages that are encountered while developing an extension may be dependent on the type of extension that is being created, or the development phase in which the message is encountered.  Terms that are encountered in the error messages may be defined in the [Glossary](portalfx-extensions-glossary-status-codes.md).
<!-- TODO:  Find at least one status code for each of these conditions. -->

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-console-error-messages"></a>
### Console Error Messages

***Console error messages in F12 developer tools***

Some console and HTTP error messages are located at[https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx](https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx).

* * *

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-err_connection_reset"></a>
### ERR_CONNECTION_RESET

***Cannot load `localhost` Ibiza extension with ERR_CONNECTION_RESET***

ERROR: The Storage Area Network (SAN) is missing in the certificate.

SOLUTION: [https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595](https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595)

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-err_insecure_response"></a>
### ERR_INSECURE_RESPONSE

ERR_INSECURE_RESPONSE in the browser console

***My Extension fails to sideload and I get an ERR_INSECURE_RESPONSE in the browser console***.
   
![alt-text](../media/portalfx-testinprod/errinsecureresponse.png "ERR_INSECURE_RESPONSE Log")

ERROR: the browser is trying to load the extension but the SSL certificate from localhost is not trusted.

SOLUTION: Install and trust the certificate.

* * *

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-failed-to-initialize"></a>
### Failed To Initialize

ERROR: The extension failed to initialize. One or more calls to methods on the extension's entry point class failing.

SOLUTION: Scan all the relevant error messages during the timeframe of the failure. These errors should have information about what exactly failed while trying to initialize the extension, e.g. the initialize endpoint, the getDefinition endpoint, etc.

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-first-response-not-received"></a>
### First Response Not Received

ERROR: The shell loaded the extension URL obtained from the config into an IFrame; however there wasn't any response from the extension.

SOLUTION: 

1. Verify that the extension is correctly hosted and accessible from the browser.

1. The extension should have code injected in the  `layout.cshtml` which includes a postMessage call. Verify that this code gets executed.

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-invalid-definition"></a>
### Invalid Definition

ERROR: The definition that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension definition and fix them.

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-invalid-extension-name"></a>
### Invalid Extension Name

ERROR: The name of the extension as specified in the `extensions.json` configuration file doesn't match the name of the extension in the extension manifest.

SOLUTION: Verify what the correct name of the extension should be, and if the name in config is incorrect, update it.

If the name in the manifest is incorrect, contact the relevant extension team to update the  `<Extension>` tag in the PDL file with the right extension name and recompile.

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-invalid-indicate-loaded"></a>
### Invalid Indicate Loaded

ERROR: The manifest for an extension was received at an invalid time. e.g. if the manifest was already obtained or the extension was already loaded.

SOLUTION: Report this issue to the framework team for investigation.

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-invalid-manifest"></a>
### Invalid Manifest

ERROR: The manifest that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension manifest and fix them.

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-manifest-not-received"></a>
### Manifest Not Received

ERROR: The bootstrap logic was completed, however the extension did not return a manifest to the shell. The shell waits for a period of time (currently 40 seconds as of 2014/10/06) and then times out.

SOLUTION:
1. Verify that the extension is correctly hosted and accessible from the browser.

1. If the extension is using AMD modules, verify that the `manifest.js` file is accessible from the browser. Under default settings it should be present at `/Content/Scripts/_generated/manifest.js`.

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-portal-error-520"></a>
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

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-sandboxed-iframe-security"></a>
### Sandboxed iframe security

***Error: 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'.***
 
The Azure Portal should frame the extension URL, as specified in [portalfx-extensions-getting-started-procedure.md](portalfx-extensions-getting-started-procedure.md) and [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).  Also see [#console-error-messages](#console-error-messages).

* * *

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-timed-out"></a>
### Timed Out

ERROR: The extension failed to load after the predefined timeout, which is currently 40 seconds.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-too-many-bootgets"></a>
### Too Many BootGets

ERROR: The extension tried to send the bootGet message to request for Fx scripts multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION:  Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="portal-development-phase-3-deployment-status-codes-and-error-messages-too-many-refreshes"></a>
### Too Many Refreshes

ERROR: The extension tried  to reload itself within the IFrame multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 



<a name="portal-development-phase-3-deployment-best-practices"></a>
## Best Practices
   
Portal development patterns or architectures that are recommended based on customer feedback and usability studies are located in the topic for the blade that is being developed. For more information, see [portalfx-blades-best-practices.md](portalfx-blades-best-practices.md).

<a name="portal-development-phase-3-deployment-best-practices-performance"></a>
### Performance

There are practices that can improve the performance of the extension.  For more information, see [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md).


<a name="portal-development-phase-3-deployment-best-practices-productivity-tip"></a>
### Productivity Tip

Install Chrome that is located at [http://google.com/dir](http://google.com/dir) to leverage the debugger tools while developing an extension.

<a name="portal-development-phase-3-deployment-frequently-asked-questions"></a>
## Frequently asked questions

<a name="portal-development-phase-3-deployment-frequently-asked-questions-onboarding-faq"></a>
### Onboarding FAQ

***Where are the onboarding FAQs for Sparta (ARM/CSM-RP)?***

The SharePoint Sparta Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx).

* * *

<a name="portal-development-phase-3-deployment-frequently-asked-questions-ssl-certs"></a>
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

<a name="portal-development-phase-3-deployment-frequently-asked-questions-other-onboarding-questions"></a>
### Other onboarding questions

***How can I ask questions about onboarding ?***

You can ask questions on Stackoverflow with the tag [onboarding](https://stackoverflow.microsoft.com/questions/tagged/onboarding).




   
<a name="portal-development-phase-3-deployment-stackoverflow-forums"></a>
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


   
<a name="portal-development-phase-3-deployment-contacts"></a>
## Contacts
   
For assistance with the prerequisites for onboarding Management UI, contact the following people.  

If the following table is not current, please send a pull request to update the the contact list. For more information on how to send a pull request, see [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).

| Function                                      | Azure Stakeholder                          | Contact                                                                       |
| --------------------------------------------- | -----------------------------------------  | ----------------------------------------------------------------------------- |
| Accessibility	                                | Paymon Parsadmehr, Erica Mohler            |  <a href="mailto:ibiza-accessibility@microsoft.com?subject=Accessibility">ibiza-accessibility@microsoft.com</a> |
| Activity logs	                                | Marck Robinson                             | [ibiza-activity-logs@microsoft.com](mailto:ibiza-activity-logs@microsoft.com)  |
| The ARM Team                                  |                                            | [aux-arm-leads@microsoft.com](mailto:aux-arm-leads@microsoft.com)  |
| Azure.com	                                    | Elena Salaks; Guy Burstein                 | [ibiza-azure@microsoft.com](mailto:ibiza-azure@microsoft.com)  |
| Azure Compliance                              | Azure Compliance team                      | [azcompl@microsoft.com](mailto:azcompl@microsoft.com)  |
| Azure Resource Manager (ARM)                  | Vlad Joanovic                              | [ibiza-arm@microsoft.com](mailto:ibiza-arm@microsoft.com)  |
| Business model review                         | Integrated Marketing; Brian Hillger’s team | [ibiza-bmr@microsoft.com](mailto:ibiza-bmr@microsoft.com)  |
| Business model review                         | L&R - Operations - GD\&F; Stacey Ellingson | [ibiza-bmr@microsoft.com](mailto:ibiza-bmr@microsoft.com)  |
| Create success                                | Balbir Singh                               | [ibiza-create@microsoft.com](mailto:ibiza-create@microsoft.com)  |
| CSS Support                                   | Wes Penner; CEGRM                          | [ibiza-css@microsoft.com](mailto:ibiza-css@microsoft.com)  |
| External Partner Contact                      |                                            | [ibizafxpm@microsoft.com](mailto:ibizafxpm@microsoft.com)  |
| Fx Coverage 	                                | Adam Abdelhamed; Santhosh Somayajula       | [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com)  |
| Localization                                  | Bruno Lewin                                | [ibiza-interntnl@microsoft.com](mailto:ibiza-interntnl@microsoft.com)  |
| Onboarding kickoff                            | Leon Welicki; Adam Abdelhamed; Santhosh Somayajula | [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com) |
| Third Party Applications (External partners)  | Leon Welicki; Adam Abdelhamed; Santhosh Somayajula | [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com) |
| Performance                                   | Sean Watson                                | [ibiza-perf@microsoft.com](mailto:ibiza-perf@microsoft.com) |
| Pull requests                                 |                                            | [ibizafxpm@microsoft.com](mailto:ibizafxpm@microsoft.com) |
| Registration for internal extensions          |                                            | [ibizafxpm@microsoft.com](mailto:ibizafxpm@microsoft.com) |
| Quality Essentials                            |                                            | [Get1CS@microsoft.com​](mailto:Get1CS@microsoft.com) |
| Reliability                                   | Sean Watson                                | [ibiza-reliability@microsoft.com](mailto:ibiza-reliability@microsoft.com) |
| Resource Move                                 | Edison Park                                | [ibiza-resourceMove@microsoft.com](mailto:ibiza-resourceMove@microsoft.com) |
| Usability	                                    | Joe Hallock; Mariah Jackson                | [ibiza-usability@microsoft.com](mailto:ibiza-usability@microsoft.com) |
| UX feasibility review                         | Santhosh Somayajula                        | [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com) | 

<a name="portal-development-phase-3-deployment-for-more-information"></a>
## For More Information
   
For more information about development phases, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

For more information about the Microsoft Azure Trust Center, see [http://azure.microsoft.com/en-us/support/trust-center/](http://azure.microsoft.com/en-us/support/trust-center/).

For more information about exit criteria, see [top-exit-criteria.md](top-exit-criteria.md).

 For more information about quality metrics, see the One Compliance System Web site that is located at [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx).

For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). 

For more information about localization requirements, see [portalfx-localization.md](portalfx-localization.md). 

For more information about azure.com onboarding, see [http://acomdocs.azurewebsites.net](http://acomdocs.azurewebsites.net).
 
<a name="portal-development-phase-3-deployment-glossary"></a>
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


