
<a name="blades-and-template-blades"></a>
# Blades and Template Blades

 
<a name="blades-and-template-blades-overview"></a>
## Overview

Blades are the main UI container in the Portal. They are equivalent to `windows` or `pages` in other UX frameworks.      A blade typically takes up the full screen, has a presence in the Portal breadcrumb, and has an 'X' button to close it. The `TemplateBlade` is the recommended development model, which typically contains an import statement, an HTML template for the UI, and  ViewModel that contains the logic that binds to the HTML template. However, some previous development models are still supported.

The following is a list of different types of blades.

| Type                          | Document                                                       | Description |
| ----------------------------- | ---- | ---- |
| TemplateBlade                 | [top-blades-procedure.md](top-blades-procedure.md)   | Creating any Portal blade. This is the main and recommended authoring model for UI in the Portal. | 
| The Blade ViewModel           | [top-blades-viewmodel.md](top-blades-viewmodel.md)   |  The `ViewModels` that associate data that is retrieved from the server with the blade and its controls. |
| Advanced TemplateBlade Topics | [top-blades-advanced.md](top-blades-advanced.md)     | Advanced topics in template blade development.                                                    | 
| MenuBlade                     | [portalfx-blades-menublade.md](portalfx-blades-menublade.md)   | Displays a vertical menu at the left of a blade.                                                  |  
| Blade Settings                | [top-blades-settings.md](top-blades-settings.md)   | Framework settings that allow extensions to opt in or out of interaction patterns.                  | 
| AppBlade                      | [top-blades-appblades.md](top-blades-appblades.md)   | Provides an IFrame to host the UI.                                                                | 
| Blade with tiles              | [top-blades-legacy.md](top-blades-legacy.md)         |  Legacy authoring model. Given its complexity, you may want to use TemplateBlades instead. | | 
| Sample Extensions with Blades | [portalfx-extensions-samples-blades.md](portalfx-extensions-samples-blades.md) |  SDK Samples that demonstrate how to develop extensions with different templates.  | | 


 
 
<a name="blades-and-template-blades-best-practices"></a>
## Best Practices

Typically, extensions follow these best practices, which often result in performance improvements. Portal development patterns or architectures that are recommended based on customer feedback and usability studies are categorized by the type of blade. 

* [Best Practices for All blades](#best-practices-for-all-blades)

* [Best Practices for Create blades](#best-practices-for-create-blades)

* [Best Practices for Menu blades](#best-practices-for-menu-blades)

* [Best Practices for Resource List blades](#best-practices-for-resource-list-blades)
	
<a name="blades-and-template-blades-best-practices-best-practices-for-all-blades"></a>
### Best Practices for All blades

These patterns are recommended for every extension, but they are not required.

* Never change the name of a Blade or a Part

* Limit blade `parameters` updates to the addition of parameters that are marked in **TypeScript** as optional

* Never remove parameters from their `Parameters` type

* Avoid observables when possible

  The values in non-observables are much more performant than the values in observables.  Specifying a string instead of a `KnockoutObservable<string>`, os specifying a boolean instead of a `KnockoutObservable<boolean>` will improve performance whenever possible. The performance difference for each operation is not large, but when a blade can make tens or hundreds of values, they will add up.

* Name `ViewModel` properties properly

  Make sure that the only data that the proxied observables layer copies to the shell is the data that is needed in the extension iframe. The shell displays a warning when specific types of objects are being sent to the shell, for example, `editScopes`, but it can not guard against everything. 

  Extension developers should occasionally review the data model to ensure that only the needed data is public.  The names of private members begin with an underscore, so that proxied observables are made aware by the naming convention that the members are private and therefore should not be sent to the shell.


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

<a name="blades-and-template-blades-best-practices-when-to-make-properties-observable"></a>
### When to make properties observable

*** Wwhy not make every property observable just in case you want to update it later?***

SOLUTION: The reason is performance. Using an observable string instead of a string increases the size of the `ViewModel`.  It also means that the proxied observable layer has to do extra work to connect listeners to the observable if it is ever updated. Both these factors will reduce the blade reveal performance, for literally no benefit if the observable is  never updated. Extensions should use non-observable values wherever possible. However, there are still many framework `Viewmodels` that accept only observable values, therefore the extension provides an observable even though it will never be updated.

* * *


 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                              | Meaning |
| ---                               | --- |
| Deep linking |  Updates the portal URL when a blade is opened, which gives the user a URL that directly navigates to the new blade. |
| DOM | Document Object Model |
| PDE | Portal Definition Export | 
| proxied observable layer | The `ViewModel` that contains the blade.  It will exist in the separate iframe that communicates with the Portal shell iframe `ViewModel`.  |
| RBAC | Role based access. Azure resources support simple role-based access through the Azure Active Directory. | 

