
## Available Packages

Packages used by extension developers are separated into the following categories.

* [Development](#development)
* [Publishing in the marketplace](#publishing-in-the-marketplace)
* [Testing](#testing)
* [Shared Packages](#shared-packages)
* [Deprecated packages](#deprecated-packages)

The following sections describe the various packages by category. All packages are available both in the Portal SDK MSI and through the deep-linked package source. Some packages are shipped as NuGet packages, and others as Node modules.  All packages in the following tables are NuGet packages unless they are annotated to be a node module.

### Development

After installation, NuGet packages that are used for development can be viewed in the `packages.config` file or in the NuGet **Package Manager** tool in **Visual Studio**.  Node modules can be viewed  in `package.json`.

| Package | Purpose |
| ------- | ------- |
| Microsoft.Portal.Framework | 	Contains framework assemblies required for extension development. | 
| Microsoft.Portal.Security.AadCore	| Contains AAD module used for auth. | 
| Microsoft.Portal.Tools | 	Contains PDC, build target files (.target) , Definition files and TypeScript 2.3.3 compiler. | 
| Microsoft.Portal.Tools.ContentUnbundler | Contains the tool that packages an extension UI into a zip file which can be served by the hosting service. | 

### Publishing in the marketplace

| Package | Purpose |
| ------- | ------- |
| Microsoft.Azure.Gallery.AzureGalleryUtility	| Contains tools to package, upload and update gallery items in the Azure Portal marketplace.| 
| Microsoft.Azure.Gallery.Common | 	Common packages used by Microsoft.Azure.Gallery.AzureGalleryUtility| 

### Testing

| Package | Purpose |
| ------- | ------- |
| msportalfx-test (node module) | Provides APIs for authoring UI-based test cases with Selenium in TypeScript. | 
| msportalfx-ut (node module)	| Provides APIs for authoring Unit Tests against extension code in TypeScript. Includes runtime, APIs, test runner support, trx and junit output for CI and code coverage reporting. See [top-extensions-unit-test.md](top-extensions-unit-test.md) for more details. | 
| Microsoft.Portal.TestFramework | 	Provides APIs for writing UI-based test cases with Selenium authored in CSharp. For more information about using the test framework, see [top-extensions-csharp-test-framework.md](top-extensions-csharp-test-framework.md). | 
| Microsoft.Portal.TestFramework.UnitTest | The msportalfx-ut node module shipped in a NuGet package for those that cannot consume the internal package source, or are on CoreXT or similar IDE's that require offline/disconnected builds. 	For more information about unit testing, see [top-extensions-unit-test.md](top-extensions-unit-test.md). |

### Shared packages

Portal Definition Exports, or PDE's, are extensions that are maintained by teams other than the Ibiza team and your team. These extensions are available for your use. This list of packages are contributed to by extension developers who are exposing functionality from their extension by way of shipping their PDE. The absence of an extension package from the list does not imply that the package does not exist, or does not ship. To verify whether an extension ships a NuGet package, reach out to the respective teams at [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md) or [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice).

| Package | Purpose | Document |
| ------- | ------- | -------- |
| Microsoft.Portal.Extensions.KeyVault | Blades and parts shared by the KeyVault extension. | [portalfx-pde-keyvault.md](portalfx-pde-keyvault.md) | 
| Microsoft.Portal.Extensions.AAD | Blades and parts shared by the AAD extension. | [portalfx-pde-adrbac.md](portalfx-pde-adrbac.md) | 
| Microsoft.Portal.Extensions.Billing | Blades and parts shared by the Billing extension. | [portalfx-pde-billing.md](portalfx-pde-billing.md) | 
| Microsoft.Portal.Extensions.Hubs | Blades and parts shared by the Hubs extension. | [portalfx-hubsextension-pde.md](portalfx-hubsextension-pde.md) | 
| Microsoft.Portal.Extensions.Insights | Blades and parts shared by the Insights extension. | [portalfx-pde-azureinsights.md](portalfx-pde-azureinsights.md) | 
| Microsoft.Portal.Extensions.Monitoring | Blades and parts shared by the Monitoring extension. | [portalfx-pde-monitoring.md](portalfx-pde-monitoring.md) | 

### Deprecated packages

The following NuGet packages have been deprecated. Do not use these packages when building new extensions. 

| Package | Purpose |
| ------- | ------- |
| Microsoft.Portal.Azure.Website | Sideload your extension instead, as specified in [top-extensions-sideloading.md](top-extensions-sideloading.md). |
| Microsoft.Portal.Azure.WebsiteNoAuth | Sideload your extension instead, as specified in [top-extensions-sideloading.md](top-extensions-sideloading.md). |
| Microsoft.Portal.Framework.Scripts | Use Microsoft.Portal.TestFramework.UnitTest instead, as specified in [top-extensions-unit-test.md](top-extensions-unit-test.md). |
| Microsoft.Portal.Tools.Etw | The recommended practice is to use the Extension Hosting Service as specified in [top-extensions-hosting-service.md](top-extensions-hosting-service.md) instead of custom deployment, as specified in [top-extensions-custom-deployment.md](top-extensions-custom-deployment.md). If you are self-hosting your extension, then this package provides the `EtwRelatedFilesUtility.exe` tool and sample configurations.  | 
| Microsoft.Portal.TypeMetadata | Author typemetadata directly when required. |
