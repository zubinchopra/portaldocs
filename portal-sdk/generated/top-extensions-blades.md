
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


 
 
<a name="blades-and-template-blades-best-practices"></a>
## Best Practices

Typically, extensions follow these best practices, which often result in performance improvements. Portal development patterns or architectures that are recommended based on customer feedback and usability studies are categorized by the type of blade. 
	
* Never change the name of a Blade or a Part

* Limit their `parameters` updates to the addition of parameters that are marked in **TypeScript** as optional

* Never remove parameters from their `Parameters` type

**NOTE**: These patterns are recommended for every extension, but they are not required.

<a name="blades-and-template-blades-best-practices-best-practices-for-create-blades"></a>
### Best Practices for Create blades

Best practices for create blades cover common scenarios that will save time and avoid deployment failures.

* All Create blades should be a single blade. Instead of wizards or picker blades, extensions should use form sections and dropdowns.

* The subscription, resource group, and location picker blades have been deprecated.  Subscription-based resources should use the built-in subscription, resource group, location, and pricing dropdowns instead.

* Every service should expose a way to get scripts to automate provisioning. Automation options should include **CLI**, **PowerShell**, **.NET**, **Java**, **NodeJs**, **Python**, **Ruby**, **PHP**, and **REST**, in that order. ARM-based services that use template deployment are opted in by default.

<a name="blades-and-template-blades-best-practices-best-practices-for-menu-blades"></a>
### Best Practices for Menu blades

Services should use the Menu blade instead of the Settings blade. ARM resources should opt in to the resource menu for a simpler, streamlined menu.

<a name="blades-and-template-blades-best-practices-best-practices-for-resource-list-blades"></a>
### Best Practices for Resource List blades

  Resource List blades are also known as Browse blades.

  Browse blades should contain an "Add" command to help customers create new resources quickly. They should also contain Context menu commands in the "..." menu for each row.

  In addition, they should show all resource properties in the Column Chooser.

  For more information, see the Asset documentation located at [portalfx-assets.md](portalfx-assets.md).



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

