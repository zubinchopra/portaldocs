<a name="nuget-packages-for-developing-extensions"></a>
# NuGet packages for developing extensions

Azure portal SDK (Ibiza SDK) ships portal framework assemblies, tools, test framework and extension PDE files as NuGet packages.

<a name="nuget-packages-for-developing-extensions-set-up-nuget-package-source"></a>
## Set-up NuGet package source

In order to download the NuGet pacakges developers can choose among the following package sources:

<a name="nuget-packages-for-developing-extensions-set-up-nuget-package-source-wanuget-packages"></a>
### <strong>Wanuget Packages</strong>

**Recommeneded approach for first-party extensions** i.e. extensions developed by Microsoft employees.

1. For extensions using CoreXT

Please ensure that [http://wanuget/Official](http://wanuget/Official) is listed as a package source in the CoreXT config located at:

```cmd
{PATH_TO_YOUR_REPO}\.config\corext.config
```

where {PATH_TO_YOUR_REPO} is path to your extension's repository on your machine.

```xml
 <repo name="Official" uri="https://msazure.pkgs.visualstudio.com/DefaultCollection/_apis/packaging/Official/nuget/index.json" fallback="http://wanuget/Official/nuget" />
```

1. For extensions using non-CoreXT

Please ensure that [http://wanuget/Official](http://wanuget/Official) is added to the package source.

<a name="nuget-packages-for-developing-extensions-set-up-nuget-package-source-local-package-source"></a>
### <strong>Local Package Source</strong>

**Recommeneded approach for third-party extensions** i.e. extensions developed by external partners .

External partners can download the NuGet packages by installing the [msi][portalfx-msi.md]. Installing the msi on a machine downloads the NuGet packages at following location on :

```bash
$>cd C:\Program Files (x86)\Microsoft SDKs\PortalSDK\Packages
```

<a name="nuget-packages-for-developing-extensions-nuget-packages"></a>
## NuGet Packages

<a name="nuget-packages-for-developing-extensions-nuget-packages-for-extension-development"></a>
### <strong>For extension development</strong>

* **Microsoft.Portal.Framework**

This nuget provides framework assemblies Microsoft.Portal.Azure.dll, Microsoft.Portal.Core.dll,Microsoft.Portal.Framework.dll, Microsoft.WindowsAzure.ServiceRuntime.dll and WindowsAzureEventSource.dll

* **Microsoft.Portal.Security.AadCore**

This nuget provides AAD module used for auth Microsoft.Portal.AadCore.dll

* **Microsoft.Portal.TypeMetadata**

This nuget provides both runtime and compile time components that drive reflection-style features for the Azure Portal SDK.  This includes the compile time generation of C# model interfaces into TypeScript interfaces, and the injection of type information into the portal at runtime.

* **Microsoft.Portal.Tools**

This NuGet package provides PDC, Target files (.target) , Definition files (*.d.ts) and TypeScript 2.0.3 compiler.

* **Microsoft.Portal.Tools.ContentUnbundler**

This NuGet package provides the content unbundler tool that helps extension developers package the extension UI in a zip file which can be served by hosting service.

<a name="nuget-packages-for-developing-extensions-nuget-packages-for-publishing-your-extension-in-marketplace"></a>
### <strong>For publishing your extension in marketplace</strong>

* **Microsoft.Azure.Gallery.AzureGalleryUtility**

This NuGet package provides tools to package, upload and update gallery items in Azure portal marketplace.

<a name="nuget-packages-for-developing-extensions-nuget-packages-for-end-to-end-testing"></a>
### For end to end testing

* **Microsoft.Portal.TestFramework**

Delivers the Portal TestFramework allowing you to UI based test cases with Selenium and Visual Studio - [to learn more about consuming the test framework see](https://auxdocs.azurewebsites.net/en-us/documentation/articles/portalfx-testing-ui-test-cases)

<a name="nuget-packages-for-developing-extensions-nuget-packages-deprecated-nuget-packages"></a>
### Deprecated NuGet packages

Following Deprecated NuGet packages have been deprecated for over 2 years now. If you are building a new extension then we recommend you do not take a dependence on these NuGet packages. If you are using these packages for local developement, please reach out to [IbizaFxPM@microsoft.com](mailto:IbizaFxPM@microsoft.com) so that we can help you migrate to side-loading based approach.

* Microsoft.Portal.Azure.Website

Provides the Authenticated Developer Portal Website with Hubs and Billing Extensions that was used.

* Microsoft.Portal.Azure.WebsiteNoAuth

Provides the Unauthenticated Developer Portal Website

<a name="nuget-packages-for-developing-extensions-nuget-packages-shipping-your-extension-as-nuget-package"></a>
### Shipping your extension as NuGet package

Azure portal SDK also provides the capability to package and ship your extension as a NuGet package. This allows other extensions to invoke your extension's blades / parts at runtime. You can learn more about packaging and shairing your extension as NuGet(portalfx-pde-publish.md)

<a name="nuget-packages-for-developing-extensions-invoking-other-extension-s-at-runtime"></a>
## Invoking other extension&#39;s at runtime

You can refer to other extension's NuGet packages in order to invoke their blades/ part's at runtime.
Here is a list of all available PDE's shipped as NuGet packages [here](portalfx.md#pde)

> NOTE: The list of NuGet packages published by extension's is contributed by extension developer's who ship these NuGet packages. If you do not see an extension's package listed here that does not mean they do not ship a NuGet package. In order to verify if an extension ships a NuGet package you can reach out to the respective teams at aka.ms/portalfx/partners.