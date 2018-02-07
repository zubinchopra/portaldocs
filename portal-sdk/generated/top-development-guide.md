
<a name="development-guide"></a>
# Development Guide


<a name="development-guide-develop-the-extension"></a>
### Develop the extension

1. Build the extension and sideload it for local testing. Sideloading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about sideloading, see [portalfx-extensions-sideloading-overview.md](portalfx-extensions-sideloading-overview.md) and [portalfx-testinprod.md](portalfx-testinprod.md). 

1. Complete the development and unit testing of the extension. For more information on debugging, see [portalfx-debugging.md](portalfx-debugging.md) and [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).

1. Address the exit criteria to meet previous to moving the extension to the next development phase. The exit criteria are located at [top-exit-criteria.md](top-exit-criteria.md).

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

<a name="install-software-for-extension-development"></a>
# Install Software for Extension Development

<!-- document headers are in the individual documents -->

<a name="install-software-for-extension-development-minimum-installation"></a>
## Minimum Installation

Install the following software. Your team should be aware of the most current download locations so that you can complete your own installs.

1. Windows 8, Windows Server 2012 R2, or the most recent edition of the client or server platform. Some downloads are located at the following sites.
    * Windows 8
    
      [https://www.microsoft.com/en-us/software-download/windows8](https://www.microsoft.com/en-us/software-download/windows8)

    * Windows Server 2012 R2

      [https://www.microsoft.com/en-us/download/details.aspx?id=41703](https://www.microsoft.com/en-us/download/details.aspx?id=41703)

1. Visual Studio 2015 that is located at [https://www.visualstudio.com/downloads/](https://www.visualstudio.com/downloads/)

1. Typescript for Visual Studio 15 that is located at [https://www.microsoft.com/en-us/download/details.aspx?id=48593](https://www.microsoft.com/en-us/download/details.aspx?id=48593)

1. VS Code that is located at [https://code.visualstudio.com/docs/setup/setup-overview](https://code.visualstudio.com/docs/setup/setup-overview)

1. Knockout that is located at [http://knockoutjs.com/downloads/](http://knockoutjs.com/downloads/)

1. Azure Portal SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download)

1. Quality Essentials that is located at [http://qe](http://qe), or One Compliance System (1CS) that is located at  [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx)

1. Node tools that are located at [https://github.com/Microsoft/nodejstools/releases/tag/v1.3.1](https://github.com/Microsoft/nodejstools/releases/tag/v1.3.1)

1. Nuget package loading instructions are located at [top-portalfx-extensions-nuget.md](top-portalfx-extensions-nuget.md) and at [portalfx-extensions-getting-started-procedure.md](portalfx-extensions-getting-started-procedure.md).

1. Set up the source code management system on your computer. Teams use **GitHub**, **VSO**, and other content management systems. Which one is used by your team is team-dependent.

Test that your computer is ready for Azure development by creating a blank extension, as specified in [portalfx-extensions-create-blank-procedure.md](portalfx-extensions-create-blank-procedure.md).



<a name="install-software-for-extension-development-other-software-installation"></a>
## Other Software Installation

The MSI Installer

<a name="nuget-packages"></a>
# NuGet Packages

The Azure Portal SDK ships framework assemblies, tools, test framework and extension [PDE](Portalfx-extensions-onboarding-glossary.md) files as NuGet packages. It also provides the capability to ship extensions as NuGet packages. This allows extensions to invoke blades and parts from other extensions at runtime. For more information about sharing  extensions as NuGet packages, see [portalfx-pde-publish.md](portalfx-pde-publish.md).

<a name="nuget-packages-download-nuget-packages"></a>
## Download NuGet packages

In order to download the NuGet packages as part of an extension, developers can choose between the following package sources:

<details>
<summary>Wanuget packages</summary>

*  CoreXT extensions

   Ensure that [http://wanuget/Official](http://wanuget/Official) is included as a package source in the CoreXT configuration file that is located at `<repoPath>\.config\corext.config`, where `<repoPath>`, without the angle brackets, is the path to the extension repository on the development computer. The code to include the package source is as follows.

    ```xml
    <repo name="Official"
     uri="https://msazure.pkgs.visualstudio.com/DefaultCollection/_apis/packaging/Official/nuget/index.json"
     fallback="http://wanuget/Official/nuget" 
     />
    ```

   **NOTE**: This is the recommended approach for [first-party extensions](portalfx-extensions-onboarding-glossary.md). 

* Non-CoreXT extensions

    Ensure that [http://wanuget/Official](http://wanuget/Official) is added to the package source.
</details>
<details><summary>Local packages</summary>

External partners can download and install the NuGet packages when they install and use **Visual Studio 2015**. For more information, see [portalfx-extensions-getting-started-procedure.md](portalfx-extensions-getting-started-procedure.md). The packages that are installed are located in the `C:\Program Files (x86)\Microsoft SDKs\PortalSDK\Packages` directory.

**NOTE**: This is the recommended approach for [third-party extensions](portalfx-extensions-onboarding-glossary.md).
</details>

<a name="nuget-packages-package-categories"></a>
## Package categories

The following tables describe the various NuGet packages by category.
<details>
<summary>For development</summary>

After installation, NuGet packages that are used for development are listed in the `NuGet Package Manager` tool in the **Visual Studio** project for the extension that is being built.
   
| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.Framework | Contains framework assemblies Microsoft.Portal.Azure.dll, Microsoft.Portal.Core.dll,Microsoft.Portal.Framework.dll, Microsoft.WindowsAzure.ServiceRuntime.dll and WindowsAzureEventSource.dll.  |
| Microsoft.Portal.Security.AadCore | Contains AAD module used for auth Microsoft.Portal.AadCore.dll | 
| Microsoft.Portal.TypeMetadata  | Contains both runtime and compile time components that drive reflection-style features for the Azure Portal SDK.  This includes the compile time generation of C# model interfaces into TypeScript interfaces, and the injection of type information into the portal at runtime. | 
| Microsoft.Portal.Tools | Contains PDC, Target files (.target) , [Definition files](portalfx-extensions-onboarding-glossary.md) and TypeScript 2.0.3 compiler. | 
| Microsoft.Portal.Tools.ContentUnbundler | Contains the tool that packages an extension UI into a zip file which can be served by the hosting service. | 
</details>
<details>

<summary>For publishing in the marketplace</summary>

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Azure.Gallery.AzureGalleryUtility | Contains tools to package, upload and update gallery items in the Azure Portal marketplace. | 
</details>
<details>

<summary>For end-to-end testing</summary>

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.TestFramework | Allows use of UI-based test cases with **Selenium** and **Visual Studio**. For more information about using the test framework, see [portalfx-testing-ui-test-cases.md](portalfx-testing-ui-test-cases.md). | 
</details>
<details>

<summary>Deprecated packages</summary>

The following NuGet packages have been deprecated. Do not use these packages when building new extensions. If the packages were used in local development, please reach out to the <a href="mailto:IbizaFxPM@microsoft.com?subject=Migration to Sideloading">IbizaFxPM team</a> for assistance with migration to sideloading.

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.Azure.Website | Contains the Authenticated Developer Portal Website with Hubs and Billing Extensions. | 
| Microsoft.Portal.Azure.WebsiteNoAuth | Contains the Unauthenticated Developer Portal Website. | 
</details>

<a name="nuget-packages-invoking-other-extensions-at-runtime"></a>
## Invoking other extensions at runtime

An extension can refer to another extension's NuGet packages in order to invoke its blades or parts at runtime. For more information about available PDE's, see [portalfx-extension-sharing-pde.md](portalfx-extension-sharing-pde.md).

**NOTE**: The list of NuGet packages that contain extensions is contributed to by extension developers who ship the packages. Absence of an extension package from the list does not imply that the package does not exist, or does not ship. To verify whether an extension ships a NuGet package, reach out to the respective teams at  [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice)  or [portalfx-extensions-contacts](portalfx-extensions-contacts).
<!-- TODO:  Determine whether this should be the Uservoice link. -->
