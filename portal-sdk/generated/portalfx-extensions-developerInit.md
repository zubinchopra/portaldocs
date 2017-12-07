<a name="setting-up-for-azure-portal-development"></a>
# Setting up for Azure Portal Development

<a name="setting-up-for-azure-portal-development-overview"></a>
## Overview

<a name="setting-up-for-azure-portal-development-introduction"></a>
## Introduction

This document describes the creation of a blank Azure extension that validates that the developer's computer is ready for more portal development.

<a name="setting-up-for-azure-portal-development-overview"></a>
## Overview

Your development environment should have the most recent editions of operating systems and other software installed, as specified in [portalfx-extensions-forDevelopers-procedures.md#install-software](portalfx-extensions-forDevelopers-procedures.md#install-software).

Samples are part of the downloaded SDK, in addition to being available from the DOGFOOD (DF) environment. Browse through the samples to explore live examples of APIs.

[http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKBlade](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKBlade)

For more information about key components of an Extension, see [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).

For more information about building a Hello World context pane in an extension, see [portalfx-extensions-helloWorld.md](portalfx-extensions-helloWorld.md).


<a name="setting-up-for-azure-portal-development-creating-your-first-extension"></a>
## Creating Your First Extension

<a name="setting-up-for-azure-portal-development-create-a-blank-extension"></a>
## Create a blank extension

This process validates that your development environment is set up correctly to develop extensions and blades, and validates that the local extension can be loaded in the Azure portal. The empty extension that is created by this process can be modified later for actual development. For more information about developing and testing extensions, see [portalfx-extensions-debugging.md](portalfx-extensions-debugging.md).

1. Launch **Visual Studio 2015** and navigate to File -> New -> Project. In the new project dialog, select Installed -> Visual C# -> Azure Portal. Select the Azure Portal Extension project type, and give it a unique name.  The name of the project typically matches the solution name. The location can be the same as any other **Visual Studio** project directory.  Then, click the checkbox next to ```Create directory for solution```.  Then, click the ```OK``` button, as described in the following image.

    ![alt-text](../media/portalfx-overview/new-project-template.png "New Project Dialog")

1.  Use the F5 key to compile and run the new project extension in `IIS Express`.

1.  On first run, a request to install a certificate for localhost for `IIS Express` may be displayed. Accept the certificate to continue, as in the following image.

    ![alt-text](../media/portalfx-overview/enablehttps.png "Security Warning Dialog")

1. The platform may display a "debugging not enabled" warning. You may enable or disable debugging.

    ![alt-text](../media/portalfx-overview/first-run-debugging-dialog.png "Debugging Not Enabled Dialog")

1. The platform will sideload the application into the production portal. For more information about sideloading extensions, see [portalfx-extensions-sideloading.md](portalfx-extensions-sideloading.md).

If the  browser displays the message 'Server Error in '/' Application' instead, it is likely that the **NuGet** packages are not yet associated with **Visual Studio**. The **Visual Studio** Error List dialog may display the error message that is in the following image.

    ![alt-text](../media/portalfx-extensions-developerInit/nuGetPackagesMissing.png "Missing NuGet Packages")

    If this message is displayed, the missing packages can be installed by using the **Nuget Package Manager**. The **Package Manager** can be started by selecting `Tools`  -> `Nuget Package Manager` -> `Package Manager Console`, as in the following image.

     ![alt-text](../media/portalfx-extensions-developerInit/nugetPackageManagerConsole.png "Nuget Package Manager Console")

     When the **Package Manager** console is displayed, click on the `Restore` button that is associated with the error, as in the following image.
     
     ![alt-text](../media/portalfx-extensions-developerInit/nugetPackageManagerRestore.png "Nuget Package Manager Restore")

    You may want to validate that the **Content Unbundler** tool, which is a tool that ships with the VS Portal extension and that packages static files as zip file, was installed as one of the  **nuGet** packages.  Look for  `Microsoft.Portal.Tools.ContentUnbundler` in the `packages.config` file, as in the following image.
   
     ![alt-text](../media/portalfx-extensions-developerInit/packages.png "Packages Config with Content Unbundler")

    Click on the F5 button to rebuild the application. When the build is successful, **Visual Studio** will proceed to the next step and sideload the application into the production portal.

1. The portal will prompt you to allow the sideloaded extension. Click the ```Allow``` button, as in the following image.

    ![alt-text](../media/portalfx-overview/untrusted-extensions.png "Untrusted Extensions Dialog")
    
Congratulations! You have just created your first extension.



<a name="setting-up-for-azure-portal-development-glossary"></a>
## Glossary
<a name="setting-up-for-azure-portal-development-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term              | Meaning |
| ---               | --- |
| Azure Portal SDK  | Software Development Kit for developing Azure Portal extensions. |
| CDN               | Content Delivery Network |
| IIS Express       | Internet Information Services. A Web server for hosting anything on the Web. |
| localhost         | A hostname that means this computer or this host.  |
| sideload          | The process of transferring data between two local devices, or between the development platform and the local host. Also side load, side-load. |