## Development Procedures
To become an Azure Portal developer, perform the following tasks.

1. Acquire permissions [portalfx-extensions-forDevelopers-procedures.md#acquire-permission](portalfx-extensions-forDevelopers-procedures.md#acquire-permissions)
1. Install Software [portalfx-extensions-forDevelopers-procedures.md#install-software](portalfx-extensions-forDevelopers-procedures.md#install-software)
1. Attend Kickoff Meetings [portalfx-extensions-forDevelopers-procedures.md#attend-kickoff-meetings](portalfx-extensions-forDevelopers-procedures.md#attend-kickoff-meetings)
1. Review Technical Guidance [portalfx-extensions-forDevelopers-procedures.md#review-technical-guidance](portalfx-extensions-forDevelopers-procedures.md#review-technical-guidance)
1. Develop and deploy the extension [portalfx-extensions-forDevelopers-procedures.md#develop-and-deploy-the-extension](portalfx-extensions-forDevelopers-procedures.md#develop-and-deploy-the-extension)
1. Register the extension [portalfx-extensions-forDevelopers-procedures.md#register-the-extension](portalfx-extensions-forDevelopers-procedures.md#register-the-extension)

### Acquire permissions
Acquire the following permissions to stay current on product roadmaps, get news on latest features, and read workshop announcements.

* PMs and Developer Leads need to join the  ```ibizapartners PM```  group by clicking on this link: [http://igroup/join/ibizapartners-pm](http://igroup/join/ibizapartners-pm). 

* Developers should join the  ```ibizapartners DEV ``` group by clicking on this  link:  [http://igroup/join/ibizapartners-dev](http://igroup/join/ibizapartners-dev). 

* Developers should join the  ```Azure Portal Partner Contributors``` group by using this link: [http://ramweb](http://ramweb).

* PMs, Developers, and Developer Leads should receive notifications on breaking changes by joining the ```ibizabreak ``` group at  this  link:  [http://igroup/join/ibizabreak](http://igroup/join/ibizabreak).

* PMs, Developers, and Developer Leads  should join Stackoverflow Forums that are located at [https://stackoverflow.microsoft.com](https://stackoverflow.microsoft.com)  to let us know if you have any questions. Remember to tag questions with ```ibiza``` or related tag.

* Developers should join github groups from the site located at [http://github.com](http://github.com).
 
### Install Software
   
Install the following software. Your team should be aware of the most current download locations so that you can complete your own installs.

* Windows 8, Windows Server 2012 R2, or the most recent edition of the client or server platform. Some downloads are located at the following sites.
  * Windows 8
    
    [https://www.microsoft.com/en-us/software-download/windows8](https://www.microsoft.com/en-us/software-download/windows8)

  * Windows Server 2012 R2

    [https://www.microsoft.com/en-us/download/details.aspx?id=41703](https://www.microsoft.com/en-us/download/details.aspx?id=41703)

* Visual Studio that is located at [https://www.visualstudio.com/downloads/](https://www.visualstudio.com/downloads/)

* Typescript for Visual Studio 17 that is located at [https://www.microsoft.com/en-us/download/details.aspx?id=55258](https://www.microsoft.com/en-us/download/details.aspx?id=55258)

* Typescript for Visual Studio 15 that is located at [https://www.microsoft.com/en-us/download/details.aspx?id=48593](https://www.microsoft.com/en-us/download/details.aspx?id=48593)

* Knockout that is located at [http://knockoutjs.com/downloads/](http://knockoutjs.com/downloads/)

* Azure Portal SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download)

* Quality Essentials that is located at [http://qe](http://qe), or 1CS that is located at  [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx)


### Attend Kickoff Meetings

Attend the kickoff meeting(s) hosted by your PM or Dev Lead. These meetings will touch on the following points.
* Whether the service will target public Azure, on-premises, or both
* What is the name of the service
* Summary of the service and target scenarios

If you are planning to build a first party application, i.e., you are a part of Microsoft, the meeting agenda will also include:
* VP, PM, and engineering owners
* Timelines (preview, GA)

### Review Technical Guidance

Read the following documents from the Azure Portal UI team site.  Our doc site provides technical guidance for use while you are building an extension.

| Function | Title and Link	|
| --- | --- |
| Guidance for Program Managers and Dev Leads | Portal Extensions for Program Managers, located at [portalfx-extensions-forProgramManagers.md](portalfx-extensions-forProgramManagers.md) |
| Private Preview, Public Preview, and GA  |	Portal Extension Development Phases, located at   [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md) |
| How it Works	 | Getting Started, located at [portalfx-howitworks.md#getting-started](portalfx-howitworks.md#getting-started)
|  Build an empty extension  |	Creating An Extension, located at [portalfx-extensions-developerInit.md](portalfx-extensions-developerInit.md) |
| Experiment with sample code	| Sample Extensions, located at [portalfx-sample-extensions.md#samples-extension](portalfx-sample-extensions.md#samples-extension) |

### Develop and deploy the extension

1.	When you are ready to build the actual extension, you should schedule a UX feasibility review. Many extensions have been made more successful by setting up early design reviews with the Azure portal team. The time to review the design gives extension owners an opportunity to understand how they can leverage Azure portal design patterns, and ensure that the desired outcome is feasible. You can schedule this review by reaching out to the Ibiza team UX Feasibility Review contact that is located in [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md). Remember to include “Extension Feasibility Review” in the subject line of the e-mail.

1.	If the extension requires additional built-in support for standard Graph or ARM APIs, submit a partner request at the site located at [https://feedback.azure.com/forums/594979-ibiza-partners](https://feedback.azure.com/forums/594979-ibiza-partners).
1. Complete the development and unit testing of the extension.
1.	When you build the extension, you should also side-load it for local testing. Side-loading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about side-loading, see [portalfx-testinprod.md](portalfx-testinprod.md).
1.	When you are confident that the development of the extension is complete, you should execute the following process so the specific work required for the tenets appears in Service360.
    * Add the service to ServiceTree, which is located at [https://servicetree.msftcloudes.com](https://servicetree.msftcloudes.com)
    * Make the service be "Active" in ServiceTree
    * Complete metadata in ServiceTree to enable the automation for various Service360 Action Items
    * Complete the Action Items identified in Service360, which is located at [http://aka.ms/s360](http://aka.ms/s360)
1.	Address the exit criteria to meet previous to moving the extension to the next development phase. The exit criteria are located at [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).

    <!-- TODO:  Validate that all of the contents of     [portalfx-onboarding-exitcriteria.md](portalfx-onboarding-exitcriteria.md) have been moved to the current exit criteria documents  portalfx-extensions-forProgramManagers-exitCriteria.md and portalfx-extensions-forDevelopers-exitCriteria.md -->

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration.md](portalfx-extensions-configuration.md).

1. 	Integrate the extension into the Marketplace. 

    In the following images, each icon in the Azure Portal Marketplace is referred to as a Gallery item. Gallery items take the form of a file with the .azpkg extension. This is a  zip file which contains all assets for the gallery item: icons, screenshots, descriptions.

      ![alt-text](../media/portalfx-extensions-forDevelopers
      /azurePortalMarketPlace.png "Azure Portal Marketplace")

    * **PROD:** The Marketplace team accepts fully finished .azkpg files from your team and uploads them to Production to onboard the gallery package. Send the following email to 1store@microsoft.com.  The subject line should contain “Marketplace Onboarding Request” and the *.azpkg file should be attached to the email, as in the following image.

      ![alt-text](../media/portalfx-extensions-forDevelopers/marketplaceOnboardingRequest.png "Marketplace Onboarding Request")

    * **DOGFOOD:** Use AzureGallery.exe to upload items to DOGFOOD using the following command:

      ```AzureGallery.exe upload -p ..\path\to\package.azpkg -h [optional hide key]```

     <!-- TODO:  is there a way to replace this with a shorter link? -->
    

    In order to use the gallery loader, there are some values to set in the AzureGallery.exe.config file. For more information, see the Gallery Item Specifications document that is located at      [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations).  


    For more dev/test scenarios, see [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production).

### Register the extension

Once the name of the extension or service name is finalized, request to have the extension registered in all environments. Registering an extension in Portal requires deployment so it can take almost 10 days. Please plan accordingly.

<!-- TODO: Determine where the request to register extension is located. The specified  address results in a 404  -->

* The request to register an extension, for internal applications, is located at       [https://aka.ms/portalfx/newextension](https://aka.ms/portalfx/newextension). The request should be completed and emailed to ibizafxpm@microsoft.com, with the phrase ‘Register extension’ in the subject line. You will automatically be notified when the configuration change is pushed to PROD. External teams can submit their requests by sending an  email that resembles the following image.

  ![alt-text](../media/portalfx-extensions-forDevelopers/registrationRequest.png "Extension Registration Onboarding Request")
 

* Once deployed to DOGFOOD (DF), contact the Fx team to request that they enable the extension, if applicable. Every extension  meets required exit criteria / quality metrics before it will be enabled. The  extension will be enabled in production once all exit criteria have been met.

   Extension names must use standard extension name format, as in the example located at [portalfx-extensions-configuration-overview.md#name](portalfx-extensions-configuration-overview.md#name).

* Extension URLs must use a standard CNAME pattern. For more information about CNAMES, see [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md).

* Use a wildcard SSL cert for each environment to simplify maintenance, for example,   ``` *.<extension>.onecloud-ext.azure-test.net  ``` or  ``` *.<extension>.ext.azure.com) ``` . 
   To simplify overall management when your team is building separate, independent extensions, you can also use  ``` <extension>.{team}.ext.azure.com ``` and create a wildcard SSL cert for  ``` *.{team}.ext.azure.com ```. Internal teams can create SSL certs for DogFood using the SSL Administration Web page that is located at [http://ssladmin](http://ssladmin). 
    
        Production certs must follow your organization’s PROD cert process. 

        **NOTE** Do not use the SSL Admin site for production certs.



