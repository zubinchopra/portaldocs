# NuGet Packages

The Azure portal SDK ships portal framework assemblies, tools, test framework and extension [PDE](portalfx-extensions-onboarding-glossary.md) files as NuGet packages. It also provides the capability to package and ship extensions as NuGet packages. This allows other extensions to invoke blades and parts from other extensions at runtime. 

## Setting up NuGet packages

In order to download the NuGet packages, developers can choose between the following package sources:

<details>
<summary>Wanuget packages</summary>

*  CoreXt extensions

   Ensure that [http://wanuget/Official](http://wanuget/Official) is listed as a package source in the CoreXT config located at `<repoPath>\.config\corext.config`, where **repoPath**, without the angle brackets, is the path to the extension repository on the development computer. The code to list  the package source is as follows.

    ```xml
    <repo name="Official" uri="https://msazure.pkgs.visualstudio.com/DefaultCollection/_apis/packaging/Official/nuget/index.json" fallback="http://wanuget/Official/nuget" />
    ```

   **NOTE**: This is the recommended approach for first-party extensions. 

* Non-CoreXT extensions

    Ensure that [http://wanuget/Official](http://wanuget/Official) is added to the package source.
</details>
<details><summary>Local packages</summary>

External partners can download and install the NuGet packages when they install and use **Visual Studio 2015**. For more information, see [portalfx-extensions-developerInit-procedure.md](portalfx-extensions-developerInit-procedure.md). The packages that are installed are located in the `C:\Program Files (x86)\Microsoft SDKs\PortalSDK\Packages` directory.

**NOTE**: This is the recommended approach for third-party extensions that are developed by external partners.
</details>

## NuGet package categories

The following tables describe the various NuGet packages by category.
<details>
<summary>For development</summary>

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.Framework | Contains framework assemblies Microsoft.Portal.Azure.dll, Microsoft.Portal.Core.dll,Microsoft.Portal.Framework.dll, Microsoft.WindowsAzure.ServiceRuntime.dll and WindowsAzureEventSource.dll. |
| Microsoft.Portal.Security.AadCore | Contains AAD module used for auth Microsoft.Portal.AadCore.dll | 
| Microsoft.Portal.TypeMetadata  | Contains both runtime and compile time components that drive reflection-style features for the Azure Portal SDK.  This includes the compile time generation of C# model interfaces into TypeScript interfaces, and the injection of type information into the portal at runtime. | 
| Microsoft.Portal.Tools | Contains PDC, Target files (.target) , Definition files (*.d.ts) and TypeScript 2.0.3 compiler. | 
| Microsoft.Portal.Tools.ContentUnbundler | Contains the tool that packages an extension UI into a zip file which can be served by the hosting service. | 
</details>
<details>

<summary>For publishing in the  marketplace</summary>

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Azure.Gallery.AzureGalleryUtility | Contains tools to package, upload and update gallery items in Azure portal marketplace. | 
</details>
<details>

<summary>For end to end testing</summary>

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.TestFramework | Allows use of UI-based test cases with **Selenium** and **Visual Studio**. For more information about using the test framework, see [portalfx-testing-ui-test-cases.md](portalfx-testing-ui-test-cases.md). | 
</details>
<details>

<summary>Deprecated packages</summary>

The following NuGet packages have been deprecated. Do not use these packages when building new extensions. If the packages were used in local development, please reach out to [IbizaFxPM@microsoft.com](mailto:IbizaFxPM@microsoft.com) for assistance with migration to sideloading for testing.

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.Azure.Website | Contains the Authenticated Developer Portal Website with Hubs and Billing Extensions that was used. | 
| Microsoft.Portal.Azure.WebsiteNoAuth | Contains the Unauthenticated Developer Portal Website | 
</details>

## Invoking other extensions at runtime

You can refer to other extension's NuGet packages in order to invoke their blades or parts at runtime. For more information about available PDE's, see [portalfx-extension-sharing-pde.md](portalfx-extension-sharing-pde.md).

**NOTE**: The list of NuGet packages that contain extensions is contributed to by extension developers who ship the packages. Absence of an extension package from the list that does not imply that the package does not exist or does not ship. To verify whether an extension ships a NuGet package, reach out to the respective teams at  [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice)  or [portalfx-extensions-contacts](portalfx-extensions-contacts).
<!-- TODO:  Determine whether this should be the Uservoice link. -->