
<a name="frequently-asked-questions"></a>
## Frequently asked questions

<!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->

<a name="frequently-asked-questions-the-resource-menu"></a>
### The Resource menu

***What is the resource menu?***

SOLUTION:  The resource menu is a single location for all the resource's functionality. It reduces horizontal movement by promoting the navigation menu from the settings list, to a menu blade.

* * *

<a name="frequently-asked-questions-what-sdk-version-is-required"></a>
### What SDK version is required?

***What version of the SDK is needed for an extension to contain resource menus?***

SOLUTION: The Resource menu requires at least version 5.0.302.374. The SDK is available at[../generated/downloads.md](../generated/downloads.md).

* * * 

<a name="frequently-asked-questions-resource-menu-samples"></a>
### Resource menu samples

***Are there any samples I can refer to?***

SOLUTION: There are Numerous samples that demonstrate how to use the resource menu.  They are located at `..<dir>\Client\ResourceTypes\Desktop\AssetViewModels\DesktopViewModel.ts`, where `<dir>` is the `SamplesExtension\Extension\` directory, based on where the samples were installed when the developer set up the SDK. 

* * *

<a name="frequently-asked-questions-the-support-resource-management-group"></a>
### The Support Resource Management Group

***How do I add items to the Support/Resource Management Group?***

SOLUTION:  You can add items by using a `MenuGroupExtension`. `MenuGroupExtension` is a special kind of menu group that is  specified in the menu config object.  For more information, see  [portalfx-resourcemenu-adoption.md#creating-an-assetviewmodel](portalfx-resourcemenu-adoption.md#creating-an-assetviewmodel).

* * * 

<a name="frequently-asked-questions-resource-menu-availability"></a>
### Resource menu availability

***Do other resources use the Resource menu?***

Yes. IaaS, AppServices, Resource Groups, AppInsights and many others are already using the Resource menu. 
You can see this in the RC environment.

* * *

<a name="frequently-asked-questions-adopting-the-resource-menu"></a>
### Adopting the Resource menu

***How much work is it to adopt the Resource Menu?***

We have tried to keep the amount of churn to a minimum, so that you do not have to create a new blade.  There is a  framework blade that adapts, given a resource id.

All that is required is opting in and setting the menu items for your extensino. The Menu API is very similar to the settings list API.

SOLUTION:  We found that porting the Resource group over to 
took less than a day's worth of work, because the resource group only has 12 items in the menu.  However, the amount of time varies, depending on the number of items that should be ported to the new menu.

* * *

<a name="frequently-asked-questions-resource-menu-not-displaying"></a>
### Resource menu not displaying

***My extension has adopted the Resource menu, but it's not showing up.  What happened?***

The resource menu is currently hidden behind a global feature flag that works in all environments.

<!-- TODO: Determine whether this is already turned on.  
, this will be turned on publically once we have majority adoption.
-->

SOLUTION: Use the following feature flag in your URL for testing purposes.

```
?feature.resourcemenu=true
```

* * *

<a name="frequently-asked-questions-reporting-on-extension-performance"></a>
### Reporting on Extension performance

***Will this be tracked in the weekly status email?***

Yes, this is going to be tracked in the weekly status email.

* * *

<a name="frequently-asked-questions-reporting-resource-menu-bugs"></a>
### Reporting resource menu bugs

***I've noticed a bug. How can I report it?***

SOLUTION:  You can file a bug directly on the Resource Menu using the following link. 
[http://aka.ms/portalfx/resourcemenubug](http://aka.ms/portalfx/resourcemenubug)

The bug will be triaged as soon as possible. If you do not have access to the bug reporting tool, reach out to <a href="mailto:ibiza-menu-blade@microsoft.com?subject=Resource menu bug">Ibiza Menu Blade</a>.

* * *