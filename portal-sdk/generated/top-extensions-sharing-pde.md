
<a name="sharing-your-pde-with-other-teams"></a>
# Sharing your PDE with other teams

<a name="sharing-your-pde-with-other-teams-overview"></a>
## Overview

Extensions can be used by other extensions within the Portal. There are extensions that the Ibiza team makes  available to developers, and other teams and developers are also encouraged to share extensions as appropriate.

Extensions and blades are shared by means of packaging them as NuGet packages that are  made available in the Visual Studio IDE and the CoreXT IDE,  although it is possible to access a NuGet package from other IDE's. 

An extension can refer to another extension's NuGet packages in order to invoke its blades or parts at runtime.

 For more information about sharing pde's, see [portalfx-extensions-nuget-packages.md](portalfx-extensions-nuget-packages.md). 
Shared blades are typically dedicated to a specific function, like billing, monitoring, or  . Using a shared blade standardizes    across extensions, and 
 improves blade performance within the Portal.
 
<a name="sharing-your-pde-with-other-teams-basic-format-of-a-shared-blade"></a>
## Basic format of a shared blade

The PDL file contains the definition of the template blade. The following example contains a typical PDL file.

    ```xml
    <TemplateBlade
                Name="MyTemplateBlade"
                ViewModel="{ ViewModel Name=MyTemplateBladeViewModel, Module=./ViewModels/MyTemplateBladeViewModel }"
                InitialDisplayState="Maximized"
                Template="{ Html Source='Templates\\MyTemplateBlade.html' }">
    </TemplateBlade>
    ```
There are several options that are located in the PDL file. The following is a list of the most relevant parameters.

**Name**: Name of the blade. This name is used later to refer to this blade. 

**ViewModel**: Required field.  The ViewModel that is associated with this blade. 

**Template**: Required field.  The HTML template for the blade. 

**Size**: Optional field. The width of the blade. The default value is `Medium`. 

**InitialDisplayState**: Optional field.  Specifies whether the blade is opened maximized or not. The default value is `Normal`. 

**Style**: Optional field. Visual style for the blade. The default value is `Basic`. 

**Pinnable**: Optional field. Specifies whether the blade can be pinned or not. The default value is `false`.

**ParameterProvider**: Optional field. Specifies whether the blade provides parameters to other blades within the extension.   The default value is  `false`.

**Export**: Optional field.  Specifies whether this blade is exported from your extension and to be opened by other extensions. If this field is `true`, a strongly typed blade reference is created. 

For more information on the types of shared extensions, see the  following list of PDE topics. 

| Type                        | Document                                                       | Description                                                                 |
| --------------------------- | -------------------------------------------------------------- | --------------------------------------------------------------------------- |
| Extensibility               | [portalfx-extensibility-pde.md](portalfx-extensibility-pde.md) | Locating and Importing the PDE file into your extension.                    | 
| Sharing Extensions          | [portalfx-pde-publish.md](portalfx-pde-publish.md)             | How to share a PDE with other teams.                                        |
| Content Delivery Network    | [portalfx-pde-cdn.md](portalfx-pde-cdn.md)                     | Storing images, scripts, and other files on globally geodistributed servers |
| The KeyVault picker blade   | [portalfx-pde-keyvault.md](portalfx-pde-keyvault.md)           | Unifies KeyVault selection and/or key/secret selection scenarios across the Portal. |
| The Select Member Blade     | [portalfx-pde-adrbac.md](portalfx-pde-adrbac.md)               | Unifies "member selection" scenarios across the Portal.                     |
| The Billing Blade           | [portalfx-pde-billing.md](portalfx-pde-billing.md)             |                                                                             | 
| The Hubs Extensions         | [portalfx-hubsextension-pde.md](portalfx-hubsextension-pde.md) | Provides the PricingTier, the ResourceTags, and other parts                 | 
| Azure Insights              | [portalfx-pde-azureinsights.md](portalfx-pde-azureinsights.md) | Activity logs and other tools that provide metadata about extension performance and maintenance. | 
| Azure Monitoring            | [portalfx-pde-monitoring.md](portalfx-pde-monitoring.md)       | azure-monitoring-usage-doc                                                  |

For more information about sharing pde's, see [portalfx-extensions-nuget-packages.md](portalfx-extensions-nuget-packages.md).