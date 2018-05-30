
# Deep links

Use deep links to jump directly into your extension within the Portal. The syntax for all deep links is as follows.

 `<portalURL>/#@<directory>/<linkType>/<target>`

 where

**portalURL**: The portal URL. For example, `https://portal.azure.com`.

**directory**: The target directory domain name or tenant id. For example, `microsoft.com`.

   **NOTE**:  Remember to include the pound-sign ('#') and the asterisk ('*') previous to the link type.

<!-- TODO:  Determine whether this list of deep link types is complete. -->

**linkType**: The type of deep link, used as a prefix. The types are `asset`,  `blade`, `browse`, `create`,  `marketplace`, or `resource`.

**target**: The actual deep link target. Formatting for the deep link target is dependent on the type of link. The syntax for deep link targets are as follows.

* Assets

    `<portalURL>/#@<directory>/asset/<extensionName>/<assetType>/<assetId>`

* Blades

    `<portalURL>/#@<directory>/blade/<extensionName>/<bladeName>`
    
    `<portalURL>/#@<directory>/blade/<extensionName>.<bladeName>`

* Browse

<!--
    `<portalURL>/<directory>#browse/{resourceType}`

    `<portalURL>/<directory>#browse/{resourceGroups}`

    `<portalURL>/<directory>#browse/all`

    `<portalURL>/<directory>#browse/subscriptions`

    `<portalURL>/<directory>#browse/tags`
-->

* Create

    `<portalURL>/#@<directory>/create/<packageId>`

* Marketplace

    `<portalURL>/#@<directory>/create/{packageId}/preview`

* Resource

    `<portalURL>/#@<directory>/resource{resourceId}`

Parameters for deep link targets are as follows:

**Extension Name**:  The name of the extension in the following format:  `<Company>_<BrandOrSuite>_<ProductOrComponent>`

Examples:  ```Contoso_Azure_<extensionName>``` , ```HubsExtension```, ```Nod_Publishers_Azure_<extensionName> ```

**assetType**: Asset types include the following.

    BillingSubscriptionBrowseService

    Subscription 

**assetId**: A GUID that is associated with the specific asset.

**bladeName**: The name of the blade.

**packageId**: The GUID that is associated with the package that contains the create blade or the Marketplace gallery item.

**resourceId**:  The GUID that is associated with the resource that is in the Browse menu or .

**resourceGroups**: The type of resource group that is in the Browse menu or the menu. This includes the following literals.

* all

* Subscription

* Tags

**resourceType**: The type of resource that is in the Browse menu or .  

   **NOTE**: Only subscription resource groups are supported. Tenant resource groups and nested resource groups are not supported.

<!--TODO:  Determine whether we have a list of resource types. -->



## Examples 

<!-- TODO: Determine whether any of these links should be live. If not, they will be included as code, as in the first example. -->

The following is an example of a link to an asset. 

`https://portal.azure.com/#@microsoft.com/asset/Microsoft_Azure_Billing/BillingSubscriptionBrowseService/00000000-0000-0000-0000-000000000000`

The following is an example of a link to a blade. When the blade does not exist, the Portal displays the "sad cloud" blade.
   [https://portal.azure.com/#@microsoft.com/blade/HubsExtension/HelpAndSupportBlade](https://portal.azure.com/#@microsoft.com/blade/HubsExtension/HelpAndSupportBlade)

Blade inputs are serialized in consecutive name/value pairs, as in the following example.

<!--TODO: Determine whether the names are HubsExtension and type in the following example. -->
[https://portal.azure.com/#@microsoft.com/blade/HubsExtension/BrowseAllBladeWithType/type/HubsExtension_Tag](https://portal.azure.com/#@microsoft.com/blade/HubsExtension/BrowseAllBladeWithType/type/HubsExtension_Tag)

The following is an example of a link to a browse resource. 
[https://portal.azure.com/#@microsoft.com/browse/microsoft.search/searchServices](https://portal.azure.com/#@microsoft.com/browse/microsoft.search/searchServices)

<!-- TODO:  Doublecheck that Browse still works this way. -->

Additionally, you can link to the following Browse blades. An incorrect URL will display the "All resources" menu.

[https://portal.azure.com/#@microsoft.com/browse/](https://portal.azure.com/microsoft.com#browse/)

[https://portal.azure.com/#@microsoft.com/browse/all](https://portal.azure.com/microsoft.com#browse/all)

[https://portal.azure.com/#@microsoft.com/browse/resourcegroups](https://portal.azure.com/#@microsoft.com/browse/resourcegroups)

[https://portal.azure.com/#@microsoft.com/browse/subscriptions](https://portal.azure.com/#@microsoft.com/browse/subscriptions)

[https://portal.azure.com/#@microsoft.com/browse/tags](https://portal.azure.com/microsoft.com#browse/tags)

[https://portal.azure.com/#@microsoft.com/browse/all](https://portal.azure.com/microsoft.com#browse/all)


The following is a link to a create blade.
 [https://portal.azure.com/#@microsoft.com/create/NewRelic.NewRelicAccount](https://portal.azure.com/#@microsoft.com/create/NewRelic.NewRelicAccount)

The following is a link to a create blade that is being previewed in the Marketplace.  The link for a Marketplace blade for your package appends the literal "/preview" to the end of the Create blade link, as in the following example.
[https://portal.azure.com/#@microsoft.com/create/NewRelic.NewRelicAccount/preview](https://portal.azure.com/#@microsoft.com/create/NewRelic.NewRelicAccount/preview)

The following is a link to a resource group within a subscription resource. If the resource does not exist, a message to that effect is displayed.
[https://portal.azure.com/#@microsoft.com/resource/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/foo/providers/microsoft.web/sites/bar](https://portal.azure.com/#@microsoft.com/resource/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/foo/providers/microsoft.web/sites/bar)