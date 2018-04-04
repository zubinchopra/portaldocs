
## Best Practices

Typically, extensions follow these best practices, which often result in performance improvements. Portal development patterns or architectures that are recommended based on customer feedback and usability studies are categorized by the type of blade. 

* [Best Practices for All blades](#best-practices-for-all-blades)

* [Best Practices for Create blades](#best-practices-for-create-blades)

* [Best Practices for Menu blades](#best-practices-for-menu-blades)

* [Best Practices for Resource List blades](#best-practices-for-resource-list-blades)
	
### Best Practices for All blades

These patterns are recommended for every extension, but they are not required.

* Never change the name of a Blade or a Part

* Limit blade `parameters` updates to the addition of parameters that are marked in **TypeScript** as optional

* Never remove parameters from their `Parameters` type

* Use standard `<a href="#">` tags when adding `fxclick` to open child blades to make the links accessible.

* Do not use `<div>` tags when adding `fxClick` to open child blades. The <div>` tags require apply additional HTML attributes to make the links accessible.

* Do not use the **Knockout** `click` data-binding to open child Blades. The `fxClick` data-binding was developed specifically to handle asynchronous click communication between the Portal Shell IFrame and the  extension's IFrame.

* Do not call any of the `container.open*` methods from within an `fxclick handler`.  If the extension calls them, then the `ext-msportalfx-activated` class will be automatically added to the html element that was clicked. The class will be automatically removed when the child blade is closed.

* Avoid observables when possible

  The values in non-observables are much more performant than the values in observables.  Specifying a string instead of a `KnockoutObservable<string>`, os specifying a boolean instead of a `KnockoutObservable<boolean>` will improve performance whenever possible. The performance difference for each operation is not large, but when a blade can make tens or hundreds of values, they will add up.

* Name `ViewModel` properties properly

  Make sure that the only data that the proxied observables layer copies to the shell is the data that is needed in the extension iframe. The shell displays a warning when specific types of objects are being sent to the shell, for example, `editScopes`, but it can not guard against everything. 

  Extension developers should occasionally review the data model to ensure that only the needed data is public.  The names of private members begin with an underscore, so that proxied observables are made aware by the naming convention that the members are private and therefore should not be sent to the shell.


### Best Practices for Create blades

Best practices for create blades cover common scenarios that will save time and avoid deployment failures.

* All Create blades should be a single blade. Instead of wizards or picker blades, extensions should use form sections and dropdowns.

* The subscription, resource group, and location picker blades have been deprecated.  Subscription-based resources should use the built-in subscription, resource group, location, and pricing dropdowns instead.

* Every service should expose a way to get scripts to automate provisioning. Automation options should include **CLI**, **PowerShell**, **.NET**, **Java**, **NodeJs**, **Python**, **Ruby**, **PHP**, and **REST**, in that order. ARM-based services that use template deployment are opted in by default.

### Best Practices for Menu blades

Services should use the Menu blade instead of the Settings blade. ARM resources should opt in to the resource menu for a simpler, streamlined menu.

### Best Practices for Resource List blades

  Resource List blades are also known as Browse blades.

  Browse blades should contain an "Add" command to help customers create new resources quickly. They should also contain Context menu commands in the "..." menu for each row.

  In addition, they should show all resource properties in the Column Chooser.

  For more information, see the Asset documentation located at [portalfx-assets.md](portalfx-assets.md).

