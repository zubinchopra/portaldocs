# NuGet Packages

The Azure Portal SDK ships framework assemblies, tools, test framework and extension [PDE](Portalfx-extensions-onboarding-glossary.md) files as NuGet packages. It also provides the capability to ship extensions as NuGet packages. This allows extensions to invoke blades and parts from other extensions at runtime. For more information about sharing  extensions as NuGet packages, see [portalfx-pde-publish.md](portalfx-pde-publish.md).

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

The following NuGet packages have been deprecated. Do not use these packages when building new extensions. If the packages were used in local development, please reach out to [IbizaFxPM@microsoft.com](mailto:IbizaFxPM@microsoft.com) for assistance with migration to sideloading.

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.Azure.Website | Contains the Authenticated Developer Portal Website with Hubs and Billing Extensions. | 
| Microsoft.Portal.Azure.WebsiteNoAuth | Contains the Unauthenticated Developer Portal Website. | 
</details>

## Invoking other extensions at runtime

An extension can refer to another extension's NuGet packages in order to invoke its blades or parts at runtime. For more information about available PDE's, see [portalfx-extension-sharing-pde.md](portalfx-extension-sharing-pde.md).

**NOTE**: The list of NuGet packages that contain extensions is contributed to by extension developers who ship the packages. Absence of an extension package from the list does not imply that the package does not exist, or does not ship. To verify whether an extension ships a NuGet package, reach out to the respective teams at  [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice)  or [portalfx-extensions-contacts](portalfx-extensions-contacts).
<!-- TODO:  Determine whether this should be the Uservoice link. -->