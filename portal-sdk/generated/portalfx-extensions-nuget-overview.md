<a name="nuget-packages"></a>
# NuGet Packages

The Azure Portal SDK ships framework assemblies, tools, test framework and extension [PDE](portalfx-extensions-glossary-onboarding.md) files as NuGet packages. It also provides the capability to ship extensions as NuGet packages. This allows extensions to invoke blades and parts from other extensions at runtime. For more information about sharing  extensions as NuGet packages, see [portalfx-pde-publish.md](portalfx-pde-publish.md).

<a name="nuget-packages-configure-nuget-package-sources-for-development"></a>
## Configure NuGet package sources for development

In order to download the NuGet packages as part of an extension, developers can choose between using CoreXT-compatible package sources, or consuming the local packages installed by the MSI. Choose a configuration that applies to your extension development context.

* Extensions built in CoreXT

    In the CoreXT configuration file located at `<repoRootPath\.config\corext.config`, ensure that `msazure.pkgs.visualstudio.com` is included as a package source. The code to include the package source is as follows.

        ```xml
        <repo name="Official" uri="https://msazure.pkgs.visualstudio.com/DefaultCollection/_apis/packaging/Official/nuget/index.json" fallback="http://wanuget/Official/nuget" />
        ```

* Non-CoreXT extensions

    External partners can download and install the NuGet packages when they install and use **Visual Studio 2015**. For more information, see [portalfx-extensions-getting-started-procedure.md](portalfx-extensions-getting-started-procedure.md). The packages that are installed are located in the C:\Program Files (x86)\Microsoft SDKs\PortalSDK\Packages directory.

**NOTE**:  `<repoRootPath>`, without the angle brackets, is the path to the extension repository on the development computer.
