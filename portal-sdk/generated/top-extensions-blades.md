
<a name="blades-and-template-blades"></a>
# Blades and Template Blades

 
<a name="blades-and-template-blades-overview"></a>
## Overview

Blades are the main UI container in the Portal. They are equivalent to `windows` or `pages` in other UX frameworks.      A blade typically takes up the full screen, has a presence in the Portal breadcrumb, and has an 'X' button to close it. The `TemplateBlade` is the recommended development model, which typically contains an import statement, an HTML template for the UI, and  ViewModel that contains the logic that binds to the HTML template. However, some previous development models are still supported.

The following is a list of different types of blades.

| Type                          | Document                                                       | Description |
| ----------------------------- | ---- | ---- |
| TemplateBlade                 | [portalfx-blades-procedure.md](portalfx-blades-procedure.md)   | Creating any Portal blade. This is the main and recommended authoring model for UI in the Portal. | 
| Advanced TemplateBlade Topics | [portalfx-blades-advanced.md](portalfx-blades-advanced.md)     | Advanced topics in template blade development.                                                    | 
| MenuBlade                     | [portalfx-blades-menublade.md](portalfx-blades-menublade.md)   | Displays a vertical menu at the left of a blade.                                                  |  
| Blade Kinds                   | [portalfx-blades-bladeKinds.md](portalfx-blades-bladeKinds.md) | A set of built-in blades that encapsulate common patterns.                                        | 
| Blade Settings                | [portalfx-blades-settings.md](portalfx-blades-settings.md)   | Framework settings that allow extensions to opt in or out of interaction patterns.                  | 
| AppBlade                      | [portalfx-blades-appblades.md](portalfx-blades-appblades.md)   | Provides an IFrame to host the UI.                                                                | 
| Blade with tiles              | [portalfx-blades-legacy.md](portalfx-blades-legacy.md)         |  Legacy authoring model. Given its complexity, you may want to use TemplateBlades instead. | | 
| Sample Extensions with Blades | [portalfx-extensions-samples-blades.md](portalfx-extensions-samples-blades.md) |  SDK Samples that demonstrate how to develop extensions with different templates.  | | 


 
 ## Samples Blades

| API Topic                             | Document                                                                 | Sample                                                           | Experience |
| ----------------------------------------------  | ------------------------------------------------------------------------ | ---------------------------------------------------------------- | ---------- |
| View Model                 | [portalfx-blade-viewmodel.md](portalfx-blade-viewmodel.md)                           | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels`       |  |
| Template Blades                | [portalfx-blades-overview.md](portalfx-blades-overview.md) | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels.ts` <br>     `<dir>\Client\V1\Data\ClientSideSortFilter\ViewModels\ViewModels.ts` <br>     `<dir>\Client\V1\Blades\Template\ViewModels\TemplateBladeViewModels.ts`  | |
| TemplateBlade Advanced Options | [portalfx-blades-advanced.md](portalfx-blades-advanced.md)   | `<dir>/Client/V1/Blades/Template/ViewModels/TemplateBladeViewModels.ts` <br> `<dir>/Client/V1/Blades/ContentState/ViewModels/ContentStateViewModels.ts` <br>      `<dir>/Client/V1/Blades/DynamicNotice/ViewModels/DynamicNoticeViewModels.ts` <br> `<dir>Client/V1/Blades/Unauthorized/ViewModels/UnauthorizedBladeViewModel.ts`  | 
| Blade Properties               | [portalfx-blades-properties.md](portalfx-blades-properties.md)                           | `<dir>\Client\V1\Blades\Properties\ ViewModels\BladePropertyViewModels.ts`  <br> `<dir>\Client\V1\Hubs\Browse\ViewModels\RobotBladeViewModel.ts`     | | 
| AppBlades                  | [portalfx-blades-appblades.md](portalfx-blades-appblades.md)                         | `<dir>\Client\V1\Blades\AppBlade\ ViewModels\AppBladeViewModel.ts`   |  |
| Menu Blade                     | [portalfx-blades-menublade.md](portalfx-blades-menublade.md)                             | `<dir>\Client\V1\Blades\MenuBlade\ ViewModels\SampleMenuBlade.ts`| [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions) <br> [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SampleMenuBlade/bladeWithSummary](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SampleMenuBlade/bladeWithSummary) | 
| Pricing Tier Blade             | [portalfx-extension-pricing-tier.md](portalfx-extension-pricing-tier.md)                 | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | |
| Testing Parts and Blades    | [portalfx-testing-parts-and-blades.md](portalfx-testing-parts-and-blades.md)   |   `<dir>\Client\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts` <br>  `<dir>\Client\Blades\BladeKind\ViewModels\InfoListPartViewModel.ts`  <br> `<dir>\Client\Blades\BladeKind\ViewModels\PropertiesPartViewModel.ts`  <br> `<dir>\Client\Blades\BladeKind\ViewModels\NoticePartViewModel.ts`  <br> `<dir>\Client\Blades\BladeKind\ViewModels\SettingListPartViewModel.ts`     |

<a name="blades-and-template-blades-samples-index-blades"></a>
## Samples Index Blades

The following table contains blades  that display lists of controls.  These objects are not inherently controls.

| Gallery | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| ControlIndexBlade |  | `<dir>\Client\V1\Controls\ControlIndexBlade\ViewModels\ControlIndexViewModel.ts` |  |
| UnsupportedIndexBlade |  | `<dir>\Client\V1\Controls\UnsupportedIndexBlade\ViewModels\UnsupportedIndexViewModel.ts` |   |

 
<a name="blades-and-template-blades-best-practices"></a>
## Best Practices

Portal development patterns or architectures that are recommended based on customer feedback and usability studies are categorized by the type of blade.

**NOTE**: These patterns are recommended for every extension, but they are not required.

Typically, extensions follow these best practices.
	
* Never change the name of a Blade or a Part

* Limit their `parameters` updates to the addition of parameters that are marked in TypeScript as optional

* Never remove parameters from their `Parameters` type

<a name="blades-and-template-blades-best-practices-resource-list-blades"></a>
### Resource List blades

  Resource List blades are also known as browse blades.

  All Browse blades should contain an "Add" command to help customers create new resources quickly, and Context menu commands in the "..." menu for each row.

  In addition, they should show all resource properties in the column chooser.

  For more information, see the Asset documentation located at [portalfx-assets.md](portalfx-assets.md).

<a name="blades-and-template-blades-best-practices-menu-blades"></a>
### Menu blades

All services should use the menu blade instead of the Settings blade. ARM resources should opt in to the resource menu for a simpler, streamlined menu.

<a name="blades-and-template-blades-best-practices-create-blades"></a>
### Create blades

Best practices for create blades cover common scenarios that will save time and avoid deployment failures.

* All Create blades should be a single blade. Instead of wizards or picker blades, extensions should use form sections and dropdowns.

* The subscription, resource group, and location picker blades have been deprecated.  Subscription-based resources should use the built-in subscription, resource group, location, and pricing dropdowns instead.

* Every service should expose a way to get scripts to automate provisioning. Automation options should include CLI, PowerShell, .NET, Java, Node, Python, Ruby, PHP, and REST, in that order. ARM-based services that use template deployment are opted in by default.


 ## Frequently asked questions

<a name="blades-and-template-blades-best-practices-"></a>
### 

* * * 

 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                              | Meaning |
| ---                               | --- |
| Deep linking |  Updates the portal URL when a blade is opened, which gives the user a URL that directly navigates to the new blade. |
| PDE | Portal Definition Export | 
| RBAC | Role based access. Azure resources support simple role-based access through the Azure Active Directory. | 

