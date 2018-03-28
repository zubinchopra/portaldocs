
<a name="overview"></a>
## Overview

The resource menu provides a browse-manage experience for an Azure resource. It
does this by providing an app-like container that includes a navigation
menu to the left of the screen. This navigation menu allows the user to access all of the functionality
that the resource provides.  The functionality is categorized into relevant groups.

<a name="overview-what-is-required-to-enable-the-resource-menu"></a>
#### What is required to enable the resource menu?

The resource menu requires:

* Opting in via the PDL AssetType
* Providing an AssetViewModel on the AssetType
* A 'getMenuConfig' method on the AssetViewModel
* Add menu items to the menu
* Verify that UX is responsive when maximized and restored

<a name="overview-migration"></a>
### Migration

Developers that migrate to the Resource menu need to upgrade to SDK version 
5.0.302.374 or newer. The SDK is available at[../generated/downloads.md](../generated/downloads.md).

* For more informatation about migrating an extension from the settings blade to the resource menu, see
[portalfx-resourcemenu-migration.md](portalfx-resourcemenu-migration.md).

* For more information about the APIs that support the Resource menu, see [portalfx-resourcemenu-api.md](portalfx-resourcemenu-api.md).

* For answers to frequently asked questions, see [portalfx-extensions-faq-resourcemenu.md](portalfx-extensions-faq-resourcemenu.md).

<a name="overview-responding-to-user-feedback"></a>
### Responding to user feedback

As a product the main source of negative user feedback comes from horizontal
scrolling and UI movement. This is something we are trying to address across the
portal one way of doing that is removing blades from the user's journey. The
average journey depth is 3/4 blades and the average flow is Browse, Resource
blade, Settings and then some blade from settings. In most cases this will
result in the 4th blade being off screen and then scrolled into view.

<a name="overview-how-is-this-different-from-the-settings-blade"></a>
### How is this different from the settings blade?

Previously every extension had to create a settings blade for every resource
they owned, that was an extra overhead, now the resource menu is a blade which
is loaded from the HubsExtension and calls into the AssetViewModel associated to
the AssetType to determine what menu items to show and what blades those items
open. Every extension and resource can leverage this blade without worrying
about getting UX consistency and avoid having to implementing the same blade
multiple times. The biggest change to the API is how dynamic items are handled.
Instead of having an observable array, the API is now a function that returns a
promise for the list of items. The main motivator for this change was to counter
usability issues with the list becoming jumpy and moving underneath the user
unpredictably. Although it is still possible to handle all the dynamic cases
that exist today by disabling the item and observably updating if the item is
enabled/disabled once the blade/inputs have been determined or delay creating
the menu object until all the dynamic items have been determined.

<a name="overview-how-is-this-different-from-the-settings-blade-the-api-is-slightly-different-in-two-cases"></a>
#### The API is slightly different in two cases

 1. Grouping was defined by aligning every item within the same group to use the
 same group id where as now we have promoted the grouping concept, further
 details about that below.
 2. Defining what blade to open was a dynamic blade selection whereas now it is
 a function supplyBladeReference().

<a name="overview-how-is-this-different-from-the-settings-blade-opting-in-via-the-pdl-assettype"></a>
#### Opting in via the PDL AssetType

Just provide 'UseResourceMenu="true"' as a property on the AssetType PDL tag as
shown below. At some point in the future this will become the default experience
and will require an opt out if the behaviour is undesired.

```xml
<AssetType Name="MyResource"
           ...
           UseResourceMenu="true">
```

For this flag to take effect, your asset type should map to an ARM resource. You
can associate your ARM resource to your asset type by specifying the following
tags within your <AssetType> tag.

```xml
<Browse Type="ResourceType" />
<ResourceType
    ResourceTypeName="<<your-resource-type-name>>"
    ApiVersion="api-version-you-want-to-use" />
```

As an example, for Resource Groups, currently, the resource type tag is similar to below.

```xml
<ResourceType
    ResourceTypeName="Microsoft.Resources/subscriptions/resourceGroups"
    ApiVersion="2014-04-01-preview" />
```

<a name="overview-how-is-this-different-from-the-settings-blade-providing-an-assetviewmodel-on-the-assettype"></a>
#### Providing an AssetViewModel on the AssetType

First, if you don't have one already, create a new viewmodel for your
AssetViewModel below is a skeleton for the AssetViewModel. For more information
on assets [see the following](portalfx-assets.md)

```ts
/**
 * The MyResource view model.
 */
export class MyResourceViewModel
    implements ExtensionDefinition.ViewModels.MyResourceViewModel.Contract {

    /**
     * Initializes a new instance of the desktop view model class.
     *
     * @param container Object representing the container in the shell.
     * @param initialState Bag of properties saved to user settings via viewState.
     * @param dataContext Long lived data access object passed into all view models in the current area.
     */
    constructor(container: FxContainerContract, initialState: any, dataContext: DataContext) {
    }
}
 ```

Once the AssetViewModel has been added you will need to add a reference to it
from the AssetType in PDL.

```xml
<AssetType Name="MyResource"
           ...
           ViewModel="{ViewModel Name=MyResourceViewModel, Module=./AssetViewModels/MyResourceViewModel}">
```

#### Adding a 'getMenuConfig' method on the AssetViewModel

The method must be called 'getMenuConfig' and must follow the signature below, see [Resource Menu APIs][resourcemenuapis] for a full list of the APIs and interfaces. 

```ts
public getMenuConfig(resourceInfo: MsPortalFx.Assets.ResourceInformation): MsPortalFx.Base.PromiseV<MsPortalFx.Assets.ResourceMenuConfig> {
    return Q({});
}
```

The following object is populated and passed in, if you would like to see more properties added here feel free to reach out to <a href="mailto:ibiza-menu-blade@microsoft.com?subject=Resource Sample Needs More Properties ">Ibiza Menu Blade</a>.

```ts
/**
 * The resource information for the resource menu.
 */
interface ResourceInformation {
    /**
     * The resource ID.
     */
    resourceId: string;
    /**
     * The resource or resource group.
     */
    resource: FxAzure.Subscription | FxHubsAzure.ResourceGroup | FxHubsAzure.Resource;
}

```

#### Add menu items to the menu

Once you have the skeleton of the resource menu working, the next step is to create the menu object to return in your 'getMenuConfig' method.
The menu object follows the following structure, again see [Resource Menu APIs][resourcemenuapis] for the full list of APIs.

```ts
/**
 * The resource menu configuration.
 */
interface ResourceMenuConfig {
    /**
     * The menu item groups.
     */
    groups: FxMenuBlade.MenuGroup[];
    /**
     * The ID of the default menu item.
     */
    defaultItemId: string;
    /**
     * Optional set of resource menu options.
     */
    options?: ResourceMenuOptions;
}
```

| Property        | Description |
|-----------------|-------------|
| `groups`        | Array of groups and menu items within each group that will open a blade |
| `defaultItemId` | ID of the menu item (defined in `groups`) to be selected by default |
| `options`       | Flags to show/hide common menu items |

The following options are available:

| Option                        | Production-ready metrics | Enabled by default | Scenario |
|-------------------------------|-------------|--------------------|----------|
| `enableAlerts`                | No  | No | Create, view, and update alert rules. |
| `enableAppInsights`           | No  | No | View Application Insights monitoring. |
| `enableDiagnostics`           | No  | No | View monitoring diagnostics. |
| `enableExportTemplate`        | Yes | Resources, resource groups | Export a template of the resource group to automate redeployments. RPs must provide [template schemas](http://aka.ms/armschema) for this. Does not support classic resources. |
| `enableLocks`                 | Yes | Resources, resource groups, subscriptions | Lock resources to avoid accidental deletion and/or editing. |
| `enableLogAnalytics`          | No  | No | View OMS workspace. |
| `enableLogSearch`             | No  | No | Search logs. |
| `enableMetrics`               | No  | No | View monitoring metrics. |
| `enableProperties`            | No  | No | Generic properties blade for resources. Only includes standard ARM properties today, but may be integrated with the supplemental data, if needed. (Please file a [partner request](http://aka.ms/portalfx/request).) Does not support non-tracked resources. |
| `enableRbac`                  | Yes | All ARM resource types | Manage user/role assignments for this resource. |
| `enableSupportEventLogs`      | Yes | Resources, resource groups, subscriptions | View all operations and events |
| `enableSupportHelpRequest`    | Yes | All ARM resource types | Create a support request for this resource, resource group, or subscription. |
| `enableSupportResourceHealth` | Yes | No | Check resource for common health issues (e.g. connectivity) and recommend fixes. |
| `enableSupportTroubleshoot`   | No  | No | **Deprecated. Do not use.** Legacy support only. Moved to a new design with improved usability scores. |
| `enableSupportTroubleshootV2` | Yes | No | Troubleshoot possible availability/reliability issues (e.g. connectivity). |
| `enableTags`                  | Yes | Resources, resource groups, subscriptions | Tag resource with key/value pairs to group/organize related resources. RP must support PATCH operations to update tags. Does not support classic resources. |
| `showAppInsightsFirst`        | No  | No | View Application Insights monitoring. `enableAppInsights` must be set to `true`. |

In this case let's assume your resource has an item with the ID 'overview' and has also onboarded support, getting
export template, locks, RBAC, Activity Log, new support request, and tags automatically:

```ts
public getMenuConfig(resourceInfo: MsPortalFx.Assets.ResourceInformation): MsPortalFx.Base.PromiseV<MsPortalFx.Assets.ResourceMenuConfig> {
    return Q(
        <MsPortalFx.Assets.ResourceMenuConfig>{
            defaultItemId: "overview",
            options: {
                enableSupportTroubleshoot: true,
                enableSupportResourceHealth: true
            },
            groups: <FxMenuBlade.MenuGroup[]>[
                ...
            ]
        }
    );
}
```

Now define a group with a single item, the menu's group and item API is as follows.

```ts
/**
 * Defines a group in the menu.
 */
interface MenuGroup extends MenuItemBase {
    /**
     * The menu items in the group.
     */
    items: MenuItem[];
}

/**
 * Defines an item in a group of the menu.
 */
interface MenuItem extends MenuItemBase, FxComposition.Selectable2Options<FxComposition.BladeReference<any>> {
    /**
     * The icon associated to the menu item.
     */
    icon: FxBase.Image;
    /**
     * A value indicating whether or not the item is enabled.
     */
    enabled?: KnockoutObservableBase<boolean>;
}

/**
 * Attributes common to all items and groups in the menu.
 */
interface MenuItemBase {
    /**
     * Gets the ID for the item.
     */
    id: string;
    /**
     * The display text for the item.
     */
    displayText: string;
    /**
     * A space-delimited list of keywords associated to the item.
     */
    keywords?: string | string[];
}
```

Now given that our 'getMenuConfig' will look something like the following.

```ts
import * as ClientResources from "ClientResources";
import * as FxMenuBlade from "MsPortalFx/Composition/MenuBlade";
import * as BladeReferences from "../../../_generated/BladeReferences";

public getMenuConfig(resourceInfo: MsPortalFx.Assets.ResourceInformation): MsPortalFx.Base.PromiseV<MsPortalFx.Assets.ResourceMenuConfig> {
    return Q(
        <MsPortalFx.Assets.ResourceMenuConfig>{
            defaultItemId: "overview",
            options: {
                enableSupportTroubleshoot: true,
                enableSupportResourceHealth: true
            },
            groups: <FxMenuBlade.MenuGroup[]>[
                {
                    id: "overview_group",
                    displayText: ClientResources.ResourceMenuGroup.overview,
                    items: [
                        {
                            id: "overview",
                            displayText: ClientResources.ResourceMenu.overview,
                            enabled: ko.observable(true),
                            keywords: "overview",
                            icon: Images.MyResourceIcon,
                            supplyBladeReference: () => {
                                return new BladeReferences.MyResourceOverviewBlade({ id: resourceInfo.resourceId });
                            }
                        }
                    ]
                }
            ]
        }
    );
}
```

Now you will have a Resource menu which has one group with one item in it which opens the blade 'MyResourceOverviewBlade'.

#### Adding to the resourcemenu title and subtitle

The resource menu by default (for the overview) will show the name of the
resource as the title of the blade, and the resource type as the subtitle. When
any menu item is selected, the title gets updated to

"`<<resource name>> - <<selected menu item>>`"

Extension authors can add to the title and subtitle through the blade opened in
the content area. They can do this by implementing the `HostedInMenuBlade`
interface as follows.

```ts
export class MyResourceBlade
    extends MsPortalFx.ViewModels.Blade
    implements MsPortalFx.ViewModels.HostedInMenuBlade {

    public menuContent = {
        title: ko.observable<string>(),
        subtitle: ko.observable<string>(),
    };

    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        return someAsyncCall().then(data => {
            this.menuContent.title(data.title);
            this.menuContent.subtitle(data.subtitle);
        });
    }
}
```

#### Verify that UX is responsive when maximized and restored

Since the resource menu acts as a container for the blades opened by the menu items, the display state is preserved when you switch between menu items. So, you should verify that blades render acceptable UX when the resource menu is maximized and when the resource menu is restored to the specified widths.

Next Steps:

* There are samples of resources using this in the Samples Extension see the Client\ResourceTypes\Desktop\ folder, particularly the AssetViewModels\DesktopViewModel.ts
* See [Resource Menu APIs][resourcemenuapis]

## Resource menu APIs

The following sections list the Resource Menu API's. They are also located at []().

* [MsPortalFx Assets](#msportalfx-assets)

* [Menu APIs](#menu-apis)

* [Selectable APIs](#selectable-apis)

* * *

### MsPortalFx Assets

The `MsPortalFx.Assets` is the interface for the resource menu API.

```ts
import * as FxMenuBlade from "Fx/Composition/MenuBlade";
 
declare module MsPortalFx.Assets {
    /**
     * The resource information for the resource menu.
     */
    interface ResourceInformation {
        /**
         * The resource ID.
         */
        resourceId: string;
        /**
         * The resource or resource group.
         */
        resource: FxSubscription | FxHubsAzure.ResourceGroup | FxHubsAzure.Resource;
        /**
         * The resource's subscription information (only valid for non-tenant resources).
         */
        subscription?: FxSubscription;
    }

    /**
     * The options of the resource menu config.
     */
    interface ResourceMenuOptions {
        /**
         * Enables the settings for roles and users.
         */
        enableRbac?: boolean;
        /**
         * Enables the settings for help request support.
         */
        enableSupportHelpRequest?: boolean;
        /**
         * Enables the settings for troubleshoot support.
         */
        enableSupportTroubleshoot?: boolean;
        /**
         * Enables the settings for troubleshootv2 support.
         */
        enableSupportTroubleshootV2?: boolean;
        /**
         * Enables the settings for resource health support.
         */
        enableSupportResourceHealth?: boolean;
        /**
         * Enables the settings for the event logs.
         */
        enableSupportEventLogs?: boolean;
        /**
         * Enables the setting for tags.
         */
        enableTags?: boolean;
    }

    /**
     * Defines a group extension in the menu.
     * This is used to extend the built-in groups with additional items.
     *
     * NOTE: The referenceId must be one of the constants for group IDs in this file.
     *       Using a different ID will result in a load rejection.
     */
    interface MenuGroupExtension {
        /**
         * Gets the ID for the built-in group.
         */
        referenceId: string;
        /**
         * The menu items in the group.
         */
        items: MenuItem[];
    }

    /**
     * The menu group instance type (either a menu group or a menu group extension).
     */
    type MenuGroupInstance = MenuGroup | MenuGroupExtension;

    /**
     * The resource menu configuration.
     */
    interface ResourceMenuConfig {
       /**
         * The resource menu item (overview item).
         */
        overview: MenuItem;
        /**
         * The menu item groups.
         */
        groups: MenuGroupInstance[];
        /**
         * The ID of the default menu item.
         * If this is not provided, the overview item will be the default item.
         */
        defaultItemId?: string;
        /**
         * Optional set of resource menu options.
         */
        options?: ResourceMenuOptions;
    }

    /**
     * The contract for the asset type's resource menu config.
     */
    interface ResourceMenuConfigContract {
        /**
         * Gets the resource menu configuration.
         *
         * @param resourceInfo The resource ID and resource|resource group for the menus.
         * @return A promise which will be resolved with the resource menu configuration.
         */
        getMenuConfig(resourceInfo: ResourceInformation): FxBase.PromiseV<ResourceMenuConfig>;
    }
}

```

### Menu APIs

This module contains the attributes that are common to all items and groups in the Resource menu.


```ts
declare module "Fx/Composition/MenuBlade" {
    /**
     * Attributes common to all items and groups in the menu.
     */
    interface MenuItemBase {
        /**
         * Gets the ID for the item.
         */
        id: string;
        /**
         * The display text for the item.
         */
        displayText: string;
        /**
         * A space-delimited list of keywords associated to the item.
         */
        keywords?: string | string[];
    }

    /**
     * Defines an item in a group of the menu.
     */
    interface MenuItem extends MenuItemBase, FxComposition.Selectable2Options<FxComposition.BladeReference<any>> {
        /**
         * The icon associated to the menu item.
         */
        icon: FxBase.Image;
        /**
         * A value indicating whether or not the item is enabled.
         */
        enabled?: KnockoutObservableBase<boolean>;
    }

    /**
     * Defines a group in the menu.
     */
    interface MenuGroup extends MenuItemBase {
        /**
         * The menu items in the group.
         */
        items: MenuItem[];
    }
}
```

### Selectable APIs

The selectable API's are the references to blades that are used when resource menu items are selected by the user.

```ts
declare module "Fx/Composition/Selectable" {
    /**
     * Configuration to pass to the selectable constructor
     */
    interface Selectable2Options<TBladeReference> {
        /**
         * This callback is invoked by the portal when a new blade is to be opened
         * in response to a user-invoked navigation.
         *
         * @return A blade reference that describes the blade to open.  This value cannot be null or undefined.
         */
        supplyBladeReference?: () => TBladeReference;
        /**
         * This callback is invoked by the portal when a new blade is to be opened
         * asychronously in response to a user-invoked navigation.
         *
         * @return A promise that returns a blade reference that describes the blade to open.  This value cannot be null or undefined.
         */
        supplyBladeReferenceAsync?: () => Q.Promise<TBladeReference>;
    }
}
```

* See the [frequently asked questions][resourcemenufaq]
<!--TODO:  This document has been deprecated.  It has been replaced by portalfx-extensions-faq-resourcemenu.md -->

The page you requested has moved to [portalfx-extensions-faq-resourcemenu.md](portalfx-extensions-faq-resourcemenu.md). 



* If there are any issues please reach out to <a href="mailto:ibiza-menu-blade@microsoft.com?subject=Issues with Resource Samples">Ibiza Menu Blade</a>.

