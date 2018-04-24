
<a name="browse-experience"></a>
## Browse Experience
This section describes how to display an extension in the Azure Portal.

The Portal's common navigation menu is the `Browse` menu, and it displays a list of all the different services and resource types that the Portal offers.

The Portal can be navigated by using the  ``` Browse ``` menu to the left.  Click on the ```My services ``` arrow to display Azure services, and scroll to the  ``` My Resources ``` service and click on it, as in the following image.

   ![alt-text](../media/portalfx-overview/browse-my-resources.png "Portal Resources")

The Portal will display the extension's item in a list, as in the following image.

   ![alt-text](../media/portalfx-overview/browse-my-resources-list.png "Resource List")

If you have not yet created any items, the Portal will display a "No My Resources to display" message.
When you can create a gallery item as specified in  [portalfx-extensions-key-components-mgCreate.md](portalfx-extensions-key-components-mgCreate.md), it will be displayed in this list.

The code for the browse implementation is located in the ```Browse.pdl``` file in the  ```Client/Browse``` folder in Visual Studio (VS), as in the following image.

![alt-text](../media/portalfx-overview/browse-code.png "ResourceType")

When the  ```resourceType ``` name "Microsoft.PortalSdk/rootResources" is replaced with your production Resource Provider (RP) type,  your resources will be displayed in the list after the F5 button is clicked. 

For more information on the Browse experience, see the document located at [top-extensions-browse.md](top-extensions-browse.md).

For more information about Resource Providers (RP) and other ARM support, see the Microsoft internal ARM wiki, located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Wiki.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Wiki.aspx).

