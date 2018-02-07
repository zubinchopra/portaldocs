<a name="development-guide"></a>
# Development Guide

<a name="development-guide-getting-started"></a>
## Getting Started

The following procedure specifies how to set up a developer computer for Azure extension development.
   
1. Your computer should have the most recent editions of operating systems and other software installed, as specified in [top-extensions-install-software.md](top-extensions-install-software.md).

1. Build an empty extension, as specified in [portalfx-extensions-create-blank-procedure.md](portalfx-extensions-create-blank-procedure.md).

1. Build a Hello World extension, as specified in [portalfx-extensions-helloWorld.md](portalfx-extensions-helloWorld.md).

1. Samples are part of the downloaded SDK, and the  DOGFOOD (DF) environment displays working copies of the samples. Browse through the samples that are located at [portalfx-extensions-samples.md](portalfx-extensions-samples.md) to explore live examples of APIs.

For more information about key components of an extension, see [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).

For more information about building extensions with TypeScript decorators, watch the video that is located at [https://aka.ms/portalfx/typescriptdecorators](https://aka.ms/portalfx/typescriptdecorators).

<a name="development-guide-develop-the-extension"></a>
## Develop the extension

1. Build the extension and sideload it for local testing. Sideloading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about sideloading, see [portalfx-extensions-sideloading-overview.md](portalfx-extensions-sideloading-overview.md) and [portalfx-testinprod.md](portalfx-testinprod.md). 

1. Complete the development and unit testing of the extension. For more information on debugging, see [portalfx-debugging.md](portalfx-debugging.md) and [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).

1. Address the exit criteria to meet previous to moving the extension to the next development phase. The exit criteria are located at [top-exit-criteria.md](top-exit-criteria.md).

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

<a name="development-guide-develop-the-extension-deploy-the-extension"></a>
### Deploy the extension

<!--TODO:  Determine how much of this section was previously included in portalfx-extensions-publishing.md -->

1. Review the development phases that are located at [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md) to understand how development is related to exit criteria.

1. Review the environments that are specified in [portalfx-extensions-branches.md](portalfx-extensions-branches.md) to understand the environments in which the developer can test an extension.

1. If the extension requires additional built-in support for standard Graph or ARM APIs, submit a partner request at the site located at [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice).  For information about other components that the new service needs, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).

1. When you are confident that the development of the extension is complete, you should execute the following process so the specific work required for the Azure Fundamental tenets appears in Service360, as specified in [Azure Fundamentals](https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d). 
    * Add the service to ServiceTree, which is located at [https://servicetree.msftcloudes.com](https://servicetree.msftcloudes.com)
    * Make the service be "Active" in ServiceTree
    * Complete metadata in ServiceTree to enable the automation for various Service360 Action Items
    * Complete the Action Items identified in Service360, which is located at [http://aka.ms/s360](http://aka.ms/s360)

1.  Request to deploy the extension to the Production environment, as specified in [portalfx-extensions-publishing](portalfx-extensions-publishing).

1. Integrate the extension into the Marketplace. 

    In the following images, each icon in the Azure Portal Marketplace is referred to as a Gallery item. Gallery items take the form of a file with the .azpkg extension. This is a  zip file which contains all assets for the gallery item: icons, screenshots, descriptions.

    ![alt-text](../media/portalfx-extensions-onboarding/azurePortalMarketPlace.png "Azure Portal Marketplace")

    * **PROD:** The Marketplace team accepts fully finished .azkpg files from your team and uploads them to Production to onboard the gallery package. Reach out to <a href="mailto:1store@microsoft.com?subject=Marketplace Onboarding Request&body=Hello, I would like to onboard the attached package to the production environment. The .azkpg package is named <packageName>. ">1store</a> with the zip file to have them install it.
    
    * **DOGFOOD:** Use AzureGallery.exe to upload items to DOGFOOD using the following command:

      ```AzureGallery.exe upload -p ..\path\to\package.azpkg -h [optional hide key]```

    In order to use the gallery loader, there are some values to set in the AzureGallery.exe.config file. For more information, see the Gallery Item Specifications document that is located at      [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations).  

    For more dev/test scenarios, see [https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production](https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging-testing-in-production).
