
<a name="resource-menu"></a>
## Resource Menu

If you are building an extension for an Azure service, then you probably built a resource provider that displays a top-level resource, like a  Virtual Machine or a  Storage account.

If that's the case, then the ```Resource``` menu blade is a great starting point. When the user selects a specific resource from the ``` Browse ``` experience, the menu blade that is displayed contains a mixture of standard resource features and service-specific features. Some standard resource features are activity logs, role based access controls, and Support.  Service-specific features are items like tables in a storage account. The following image displays a ```Browse``` experience Menu blade that contains features.

![alt-text](../media/portalfx-overview/resource-menu.png "Menu blade")

Click on your resource from within the ```Browse``` list to open the resource menu. Many of the standard Azure experiences such as tags, locks, and access controls have been automatically injected into the menu.

The code for the resource menu blade is located in the ``` AssetTypeViewModel ``` file in the ``` Browse/ViewModels ``` folder in the associated Visual Studio project. The menu can be extended by modifying the ```getMenuConfig ``` function, as in the following image.

![alt-text](../media/portalfx-overview/resource-menu-code.png "VS getConfig Function")

<!-- TODO:  Locate a gallery doc that describes the common resource properties.  [Resource menu blade documentation](/gallery-sdk/generated/index-gallery.md#resource-management-resource-menu).-->

For more information on the Resource Menu,  see [top-blades-resourcemenu.md](top-blades-resourcemenu.md).

