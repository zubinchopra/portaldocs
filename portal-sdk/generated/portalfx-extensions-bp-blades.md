
<a name="best-practices"></a>
## Best Practices

Typically, extensions follow these best practices, which often result in performance improvements. Portal development patterns or architectures that are recommended based on customer feedback and usability studies are categorized by the type of blade. 
	
* Never change the name of a Blade or a Part

* Limit their `parameters` updates to the addition of parameters that are marked in **TypeScript** as optional

* Never remove parameters from their `Parameters` type

**NOTE**: These patterns are recommended for every extension, but they are not required.

<a name="best-practices-best-practices-for-create-blades"></a>
### Best Practices for Create blades

Best practices for create blades cover common scenarios that will save time and avoid deployment failures.

* All Create blades should be a single blade. Instead of wizards or picker blades, extensions should use form sections and dropdowns.

* The subscription, resource group, and location picker blades have been deprecated.  Subscription-based resources should use the built-in subscription, resource group, location, and pricing dropdowns instead.

* Every service should expose a way to get scripts to automate provisioning. Automation options should include CLI, PowerShell, .NET, Java, Node, Python, Ruby, PHP, and REST, in that order. ARM-based services that use template deployment are opted in by default.

<a name="best-practices-best-practices-for-menu-blades"></a>
### Best Practices for Menu blades

Services should use the Menu blade instead of the Settings blade. ARM resources should opt in to the resource menu for a simpler, streamlined menu.

<a name="best-practices-best-practices-for-resource-list-blades"></a>
### Best Practices for Resource List blades

  Resource List blades are also known as Browse blades.

  Browse blades should contain an "Add" command to help customers create new resources quickly. They should also contain Context menu commands in the "..." menu for each row.

  In addition, they should show all resource properties in the Column Chooser.

  For more information, see the Asset documentation located at [portalfx-assets.md](portalfx-assets.md).

