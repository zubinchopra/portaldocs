## Available NuGet Packages

NuGet packages are separated into the following categories.

* [Development](#development)
* [Publishing in the marketplace](#publishing-in-the-marketplace)
* [Testing](#testing)
* [Deprecated packages](#deprecated-packages)

The following sections describe the various NuGet packages by category.

### Development

After installation, NuGet packages that are used for development are listed in the `NuGet Package Manager` tool in the **Visual Studio** project for the extension that is being built.
   
| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.Framework | Contains framework assemblies Microsoft.Portal.Azure.dll, Microsoft.Portal.Core.dll,Microsoft.Portal.Framework.dll, Microsoft.WindowsAzure.ServiceRuntime.dll and WindowsAzureEventSource.dll.  |
| Microsoft.Portal.Security.AadCore | Contains AAD module used for auth Microsoft.Portal.AadCore.dll | 
| Microsoft.Portal.TypeMetadata  | Contains both runtime and compile time components that drive reflection-style features for the Azure Portal SDK.  This includes the compile time generation of C# model interfaces into TypeScript interfaces, and the injection of type information into the portal at runtime. | 
| Microsoft.Portal.Tools | Contains PDC, Target files (.target) , [Definition files](portalfx-extensions-glossary-onboarding.md) and TypeScript 2.0.3 compiler. | 
| Microsoft.Portal.Tools.ContentUnbundler | Contains the tool that packages an extension UI into a zip file which can be served by the hosting service. | 

### Publishing in the marketplace

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Azure.Gallery.AzureGalleryUtility | Contains tools to package, upload and update gallery items in the Azure Portal marketplace. | 

### Testing

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.TestFramework | Allows use of UI-based test cases with **Selenium** and **Visual Studio**. For more information about using the test framework, see [portalfx-testing-ui-test-cases.md](portalfx-testing-ui-test-cases.md). | 
| Microsoft.Portal.TestFramework.UnitTest | Unit Test framework. For more information about unit testing,  see [portalfx-unit-test.md](portalfx-unit-test.md). | 

### Deprecated packages

The following NuGet packages have been deprecated. Do not use these packages when building new extensions. If the packages were used in local development, please reach out to the <a href="mailto:IbizaFxPM@microsoft.com?subject=Migration to Sideloading">IbizaFxPM team</a> for assistance with migration to sideloading.

| Package | Purpose | 
| ------- | ------- |
| Microsoft.Portal.Azure.Website | Contains the Authenticated Developer Portal Website with Hubs and Billing Extensions. | 
| Microsoft.Portal.Azure.WebsiteNoAuth | Contains the Unauthenticated Developer Portal Website. | 
| Microsoft.Portal.Framework.Scripts | Deprecated, use Microsoft.Portal.TestFramework.UnitTest instead, as specified in  [portalfx-unit-test.md](portalfx-unit-test.md).  | 
| Microsoft.Portal.Tools.Etw | Provides the **EtwRelatedFilesUtility.exe** tool and sample configurations for developers who are self-hosting extensions. The recommended practice is to use the extension hosting service as specified in [top-extensions-hosting-service.md](top-extensions-hosting-service.md) instead of custom deployment, as specified in [portalfx-extensions-custom-deployment.md](portalfx-extensions-custom-deployment.md).  | 

## Invoking other extensions at runtime

An extension can refer to another extension's NuGet packages in order to invoke its blades or parts at runtime. For more information about available PDE's, see [portalfx-extension-sharing-pde.md](portalfx-extension-sharing-pde.md).

**NOTE**: The list of NuGet packages that contain extensions is contributed to by extension developers who ship the packages. Absence of an extension package from the list does not imply that the package does not exist, or does not ship. To verify whether an extension ships a NuGet package, reach out to the respective teams at  [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice)  or [portalfx-extensions-contacts](portalfx-extensions-contacts).