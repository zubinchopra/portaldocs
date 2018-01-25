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


