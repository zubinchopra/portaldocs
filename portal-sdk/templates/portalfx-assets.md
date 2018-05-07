
## Assets

Assets are generic entities that are tracked within the Portal. As generic entities, assets can identify subscription resources like websites, higher-level entities like the AAD directory, lower-level entities like TFS work items, or things that are not associated with subscriptions. For example, subscriptions, resource groups, and deployments are all tracked as assets.

All asset types have the following requirements:

1. The asset type blade has a single `id` parameter that is the asset `id`
1. The asset type part is the same as the blade's pinned part
1. The asset type part and blade's pinned part open the asset type's blade
1. Calls `notifyAssetDeleted()` when the resource has been deleted or is not found

Asset types that represent Azure Resource Manager (ARM) resource types also have the following requirements.

1. The asset `id` is the string resource `id`
1. The ARM RP manifest should include a RP, resource type, and resource kind metadata

In addition, the part and blade have the same `id` input parameter, as in the following example.

```xml
<Part Name="MyAssetPart" ViewModel="MyAssetPartViewModel" AssetType="MyAsset" AssetIdProperty="id" ...>
  <Part.Properties>
    <!-- Required. Must be the only input parameter. -->
    <Property Name="id" Source="{DataInput Property=id}" />
  </Part.Properties>
  <BladeAction Blade="MyAssetBlade">
    <BladeInput Source="id" Parameter="id" />
  </BladeAction>
  ...
</Part>

<Blade Name="MyAssetBlade" ViewModel="MyAssetBladeViewModel" AssetType="MyAsset" AssetIdProperty="id">
  <Blade.Parameters>
    <!-- Required. Must be the only input parameter. -->
    <Parameter Name="id" Type="Key" />
  </Blade.Parameters>
  <Blade.Properties>
    <Property Name="id" Source="{BladeParameter Name=id}" />
  </Blade.Properties>
  ...
</Blade>
```

Assets are used for the following experiences.

| Name                 | Location | Purpose | 
| -------------------- | -------- | ------- |
| Notifications        | [portalfx-notifications.md](portalfx-notifications.md) | Should be linked to an asset |
| The Browse menu      | [top-extensions-browse.md](top-extensions-browse.md)   | Lists browseable asset types |
| Browse > Recent      | | Shows only the assets that are based on the asset type specified on a blade |
| All Resources view   | | Shows only resources that have asset types that implement Browse v2 |
| Resource group list  | | Shows only resources that have asset types that have the specified  `ResourceType` |
| Defining permissions | [portalfx-permissions.md](portalfx-permissions.md) | Defining permissions in PDL requires asset types
| The `notifyAssetDeleted()` method | | Manages references to deleted assets that can be cleaned up |
| Resource kinds       | [Special-casing ARM resource kinds](#special-casing-arm-resource-kinds) | Overriding behavior for [resource kinds](#special-casing-arm-resource-kinds) |

### Defining the asset type

To define the asset type, add the following snippet to the PDL for the extension.

```xml
<AssetType
    Name="MyAsset"
    ServiceDisplayName="{Resource MyAsset.service, Module=ClientResources}"
    SingularDisplayName="{Resource MyAsset.singular, Module=ClientResources}"
    PluralDisplayName="{Resource MyAsset.plural, Module=ClientResources}"
    LowerSingularDisplayName="{Resource MyAsset.lowerSingular, Module=ClientResources}"
    LowerPluralDisplayName="{Resource MyAsset.lowerPlural, Module=ClientResources}"
    Keywords="{Resource MyAsset.keywords, Module=ClientResources}"
    Icon="{Resource Content.MyExtension.Images.myAsset, Module=./../_generated/Svg}"
    BladeName="MyAssetBlade"
    PartName="MyAssetPart"
    IsPreview="true">
  ...
</AssetType>
```

**Name**: Identifies the asset types for telemetry. It is scoped to your extension, and therefore, should be succinct, yet clear and meaningful.

**ServiceDisplayName**, **PluralDisplayName**, **LowerSingularDisplayName**, **LowerPluralDisplayName**: Display names for the asset type, based on display context. The Portal uses the most appropriate display name for a specific context to provide a modern voice and tone. If the product name or acronym is always capitalized, use the same values for upper and lower display name properties.  For example, `PluralDisplayName` and `LowerPluralDisplayName` may both use a string like `SQL databases`. Do not share strings between singular and plural display name properties.

* The Browse menu shows the `ServiceDisplayName` in the list of browseable asset types.  If `ServiceDisplayName` is not available, `PluralDisplayName` will be shown instead.

* The `All Resources` blade uses the `SingularDisplayName` in the Type column, when visible.

* Browse v2 uses the `LowerPluralDisplayName` as the text filter placeholder and when there are no resources, for example, "No web apps to display".

**Keywords**: Comma-separated set of words or phrases that allows users to search for the asset by identifiers other than than the display names. Filtering functionality within the `Browse` menu searches over `Keywords`. 

**IsPreview**: If the asset type is in preview, set it to `true`. If the asset type is GA, simply remove the property. The default is `false`.

### Blades, parts, and commands

The id for a blade, part, or command is dependent upon whether the id represents a single instance of an asset, or multiple instances of an asset. If the id represents or acts on a single instance, it should specify an `AssetType` and `AssetIdProperty`. If the id represents or acts on multiple assets, use the primary asset type/id based on the context. 

For a single instance, the `AssetIdProperty` is the name of the input property that contains the asset id, and the `AssetType` is the `Name` specified on the `<AssetType />` node.  Remember, if the asset is an ARM resource, then the `AssetIdProperty` should be the string resource id.

If a blade, part, or command represents or acts on multiple assets, the id is the primary asset type/id based on the context. For example, an extension should use the child's asset type/id when displaying information about a child asset that also obtains information about the parent.

### Displaying assets

* Displaying in the Browse menu

    Asset types that are displayed in the Browse menu specify the `<Browse Type="" />` node. The `Type` informs the Browse menu how to interact with the asset type. For more information about Browse integration, see [top-extensions-browse.md](top-extensions-browse.md).

    Services that use [resource kinds](#resource-kinds) can be added to the Browse menu if they are configured by the Ibiza team. To do this, create a partner request at [http://aka.ms/portalfx/request](http://aka.ms/portalfx/request) with the asset type name and resource kind value.

*  Displaying in the Browse Recent menu

    The `Recent` list in the Browse menu shows asset instances that have been interacted with by the user. The Portal tracks this with the `AssetType` and `AssetIdProperty` on each blade that is launched, as specified in [#blades,-parts,-and-commands](#blades,-parts,-and-commands).

* Displaying in All Resources and Resource Group Resources

    The `All Resources` and `Resource Group` blades display all resources except alert rules, autoscale settings, and dashboards. Resources that do not use an asset type use a basic resource menu blade that exposes properties, RBAC, tags, locks, and an activity log.

## Building browse experiences

Use the following procedure to implement the basic asset type.

1. Add the asset type definition, including display names, icon, blade, and part.

1. Add `<Browse Type="ResourceType" />` for [top-extensions-browse.md#building-browse-experience](top-extensions-browse.md#building-browse-experiences).

1. Then, include a `<ResourceType ResourceTypeName="" ApiVersion="" />` declaration.

### Handling permissions for RBAC

To ensure your blades, parts, and commands react in alignment with user permissions, you can add an `AssetType`, `AssetIdProperty`, and required `Permissions` to your blades, parts, and commands. For more information about permissions, see [portalfx-permissions.md](portalfx-permissions.md).


### Special-casing ARM resource kinds

The Portal supports overriding the following default behaviors, based on the resource kind value for special-casing ARM resource kinds.

* Hiding resources in Browse and resource groups
* Displaying separate icons throughout the Portal
* Launching different blades when an asset is opened

Specify the behaviors you want to override from your asset type. If different kinds need to opt in to a static resource menu overview item, add the `<StaticOverview />` node, as in the following example.

```xml
<Kind ...>
  <StaticOverview />
</Kind>
```

The `kind` value should make sense for your scenarios. Just add supported kinds to the `AssetType` PDL, as in the following example.

```xml
<AssetType ...>
  ...
  <ResourceType ...>
    <Kind Name="kind1" />
    <Kind Name="kind2" />
    <Kind Name="kind3" />
  </ResourceType>
</AssetType>
```

The properties that can be added to the PDL are as follows.

 **Name**: Required. Kind value assigned to resource types. 

**IsDefault**: Optional. Ignores the `Name` value and applies overrides to the default kind value.  The default value is "empty". **NOTE**:  It is recommended that teams avoid overriding the default value.

**BladeName**: Optional. Specifies the blade to launch when this kind is opened from a Fx resource list. 

**CompositeDisplayName**: Optional.  Overrides the type name shown in resource lists. The `ComposityDisplayName` is a convention-based reference to multiple RESX strings. For instance, `CompositeDisplayName="MyAsset"` would map to the following 4 RESX strings: `MyAsset_pluralDisplayName`, `MyAsset_singularDisplayName`, `MyAsset_lowerPluralDisplayName`, and `MyAsset_lowerSingularDisplayName`. 

 **Icon**: Optional.  Overrides the asset type's icon. 

**IsPreview**: Optional.  Indicates a preview label should be shown in the "Browse (More services)" menu. 

 **Keywords**: Optional.  Specifies the keywords to use when filtering in the "Browse (More services)" menu. 

 **MarketplaceItemId**: Optional. Specifies the Marketplace item id, or gallery package id, to launch from the "Add" command on the resource type Browse blade. 

 **MarketplaceMenuItemId**: Optional. Specifies the Marketplace menu item to launch from the "Add" command on the resource type Browse blad. 

 **ServiceDisplayName**: Optional. Overrides the text to use in the "Browse (More services)" menu. 

 **UseResourceMenu**: Optional. Overrides the asset type's `UseResourceMenu` flag. 

 **Visibility**: Optional. Specifies whether the `kind` is hidden from resource lists. Values: `Hidden`. 

### Deleting resources

The Portal includes many references to assets, like pinned parts on the dashboard, recent items, and more. All references are persisted to user settings, and they are available when the user signs in again. When an asset is deleted, the Portal needs to be notified that these references need to be deleted. To do that, simply call `MsPortalFx.UI.AssetManager.notifyAssetDeleted()`.

Assets can also be deleted outside the Portal. When an asset is deleted outside of the Portal, and `notifyAssetDeleted()` is not called, these references will not be cleaned up. When the user signs in again, they will still see pinned parts, for instance. These parts may fail to load due to a 404 from the service, because the assets no longer exist. An extension should always call `notifyAssetDeleted()` to ensure the Portal has a chance to delete references to asset ids when the extension receives a 404 for an asset id.

### Linking notifications to assets

<!--TODO: The code snippet has no reference to the `AssetTriplet` interface, as in portalfx-notifications-upgrade.md    -->

To link a notification to an asset, include an asset reference (`AssetTriplet`) in the notification, as in the following example.

```ts
MsPortalFx.Hubs.Notifications.ClientNotification.publish({
    title: resx.myEvent.title,
    description: resx.myEvent.description,
    status: MsPortalFx.Hubs.Notifications.NotificationStatus.Information,
    asset: {
        extensionName: ExtensionDefinition.definitionName,
        assetType: ExtensionDefinition.AssetTypes.MyAsset.name,
        assetId: assetId
    }
});
```

For more information about notifications, see [portalfx-notifications.md](portalfx-notifications.md) and [portalfx-notifications-upgrade.md](portalfx-notifications-upgrade.md).

### ARM RP and resource type metadata

Every ARM resource provider (RP) has a default RP icon, in addition to a resource type icon that is specified in the RP manifest. When a resource type icon is not provided, the RP icon is used. The icon supports the following scenarios.

* The AAD custom role management UI uses the resource type icon for resource type actions

* **Visual Studio** uses the resource type icon in its list of resources

* The Portal uses the RP icon when a blade is not associated with an asset type and does not have an icon

### Specifying icons

 Icons can be either SVG XML or a standard HTTPS URL. SVG XML is preferred for scalability and rendering performance; however, HTTPS URLs can be used when the extension's RP manifest is too large.

To retrieve RP manifests for a subscription, call `GET /subscriptions/###/providers?$expand=metadata`.

When an icon is not specified, each experience will use the `MsPortalFx.Base.Images.Polychromatic.ResourceDefault()` icon in the following image.

<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="50px" height="50px" viewBox="0 0 50 50" enable-background="new 0 0 50 50" xml:space="preserve">
    <path fill="#3999C6" d="M25.561,23.167c-0.103,0-0.197-0.03-0.288-0.083L6.011,12.045c-0.183-0.103-0.292-0.297-0.292-0.506 c0-0.203,0.108-0.395,0.292-0.496L25.149,0.075c0.182-0.1,0.405-0.1,0.579,0L44.994,11.12c0.174,0.102,0.29,0.291,0.29,0.496 c0,0.212-0.116,0.4-0.29,0.504L25.853,23.084C25.762,23.137,25.665,23.167,25.561,23.167"/>
    <path fill="#59B4D9" d="M22.792,50c-0.104,0-0.207-0.024-0.295-0.077L3.295,38.917C3.11,38.814,3,38.626,3,38.416V16.331 c0-0.207,0.11-0.397,0.295-0.506c0.176-0.1,0.401-0.1,0.586,0L23.08,26.831c0.178,0.107,0.286,0.297,0.286,0.504v22.086 c0,0.212-0.108,0.397-0.286,0.502C22.985,49.976,22.888,50,22.792,50"/>
    <path fill="#59B4D9" d="M28.225,50c-0.098,0-0.199-0.024-0.295-0.077c-0.178-0.105-0.288-0.289-0.288-0.502V27.478 c0-0.207,0.11-0.397,0.288-0.504l19.196-11.002c0.185-0.102,0.403-0.102,0.587,0c0.176,0.103,0.287,0.295,0.287,0.5v21.943 c0,0.211-0.111,0.398-0.287,0.502L28.511,49.923C28.429,49.976,28.325,50,28.225,50"/>
    <path opacity="0.5" fill="#FFFFFF" d="M28.225,50c-0.098,0-0.199-0.024-0.295-0.077c-0.178-0.105-0.288-0.289-0.288-0.502V27.478 c0-0.207,0.11-0.397,0.288-0.504l19.196-11.002c0.185-0.102,0.403-0.102,0.587,0c0.176,0.103,0.287,0.295,0.287,0.5v21.943 c0,0.211-0.111,0.398-0.287,0.502L28.511,49.923C28.429,49.976,28.325,50,28.225,50"/>
</svg>

To specify an RP icon, add the following Portal metadata snippet.

```ts
{
    "namespace": "rp.namespace",
    "metadata": {
        "portal": {
            "icon": "<svg>...</svg>"
        }
    },
    ...
}
```

To specify a resource type icon, add the same snippet to each resource type definition, as in the following example.

```ts
{
    "namespace": "rp.namespace",
    "metadata": {
        "portal": {
            "icon": "<svg>...</svg>"
        }
    },
    ...
    "resourceTypes": [
        {
            "resourceType": "instances",
            "metadata": {
                "portal": {
                    "icon": "https://..."
                }
            },
            ...
        },
        ...
    ],
    ...
}
```

