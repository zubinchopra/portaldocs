
## Installing a Resource Menu

Developers that migrate to the Resource menu need to upgrade to SDK version 
5.0.302.374 or newer. The SDK is available at[../generated/downloads.md](../generated/downloads.md).

Enabling the resource menu requires the following steps.

1. [Create the PDL file](#create-the-pdl-file)

1. [Create the AssetViewModel file](#create-the-assetviewmodel-file)

1. [Add the getMenuConfig method](#add-the-getMenuConfig-method)

1. [Add menu items to the menu](#add-menu-items-to-the-menu)

1. Verify that UX is responsive when maximized and restored

### Create the PDL file

The extension can opt in to using the Resource Menu by using an `AssetType` in the PDL file. One example is located at  `<dir>\Client\V1\Navigation\ResourceMenuBlade\ResourceMenuBlade.pdl` and  `<dir>Client\V1\Navigation\ResourceMenuBlade\ViewModels\LaunchingResourceMenuBladeViewModel.ts`. 

<!-- TODO:  Determine which example is actually used in this document. There does not seem to be a sample that is already customized to match the example. -->

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>` is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

1. Add an `UseResourceMenu="true"` as a property on the `AssetType` tag, as in the following PDL file.

    <!-- TODO: Determine whether opting in is now the default experience. If so, this should be updated to describe how to opt out if the behaviour is undesired.
    -->

    ```xml
    <AssetType Name="MyResource"
            ...
            UseResourceMenu="true">
    ```

1. For this flag to take effect, map the asset type to an ARM resource by specifying the following tags within the `<AssetType>` tag.

    ```xml
    <Browse Type="ResourceType" />
    <ResourceType
        ResourceTypeName="<<your-resource-type-name>>"
        ApiVersion="api-version-you-want-to-use" />
    ```

1.  Add a resource type tag for Resource Groups, as in the following example.

    ```xml
    <ResourceType
        ResourceTypeName="Microsoft.Resources/subscriptions/resourceGroups"
        ApiVersion="2014-04-01-preview" />
    ```

### Create the AssetViewModel file

The following code is a skeleton for the `AssetViewModel` file. It can be used to create a new `ViewModel` for the resource assets, as in the following procedure.

1. Provide an `AssetViewModel` file to define the Resource Menu `ViewModel`.

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

1. After the `AssetViewModels` file has been added to the project, add a `ViewModel` reference to it in the `AssetType` element in the  PDL file. This associates the information in the PDL file with the view that is located in the `AssetViewModels` file, as in the following example.

    ```xml
    <AssetType Name="MyResource"
            ...
            ViewModel="{ViewModel Name=MyResourceViewModel, Module=./AssetViewModels/MyResourceViewModel}">
    ```

### Add the getMenuConfig method

The `getMenuConfig` method should be added to the `AssetViewModel` file. It uses the  following signature.


```ts
public getMenuConfig(resourceInfo: MsPortalFx.Assets.ResourceInformation): MsPortalFx.Base.PromiseV<MsPortalFx.Assets.ResourceMenuConfig> {
    return Q({});
}
```


<!-- TODO:  Determine where this code should be located in the extension.  Is this a separate viewmodel, like the main blade?  Do we have an example? -->

The following interface should be added to the        
 .  After it is added to the project, the extension can populate it and send it to   .

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

If you would like to see more properties added to this example, reach out to <a href="mailto:ibiza-menu-blade@microsoft.com?subject=Resource Sample Needs More Properties ">Ibiza Menu Blade</a>.

For a full list of the APIs and interfaces, see [portalfx-resourcemenu-api.md](portalfx-resourcemenu-api.md).

### Add menu items to the menu

After the resource menu skeleton has been added to the extension,  the menu object must be created.  This is the item that will be returned in the  `getMenuConfig` method.

 promise

The menu object uses the following structure.

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

The properties for the interface are as follows.

**groups**: An array of groups, or menu items within each group that will open a blade.

**defaultItemId**: The ID of the menu item that was specified the **groups** property.  This is selected by default.

**options**: Flags to display or hide common menu items. The following table contains all of the available options.

| Option                        | Purpose | Production-ready metric | Enabled by default | 
|-------------------------------|-------------|--------------------|----------|
| enableAlerts                | Create, view, and update alert rules | No  | No | 
| enableAppInsights           | View Application Insights monitoring |No  | No | 
| enableDiagnostics           | View monitoring diagnostics | No  | No | 
| enableExportTemplate        | Export a template of the resource group to automate redeployments. RPs must provide template schemas for this, as specified in [http://aka.ms/armschema](http://aka.ms/armschema). Does not support classic resources. | Yes | Resources, resource groups | 
| enableLocks                 | Lock resources to avoid accidental deletion and/or editing. | Yes | Resources, resource groups, subscriptions | 
| enableLogAnalytics          |  View OMS workspace. |No  | No |
| enableLogSearch             | Search logs. |No  | No | 
| enableMetrics               | View monitoring metrics. | No  | No | 
| enableProperties            |  Generic properties blade for resources. Only includes standard ARM properties today, but may be integrated with the supplemental data, if needed. (Please file a [partner request](http://aka.ms/portalfx/request).) Does not support non-tracked resources. | No  | No |
| enableRbac                  | Manage user/role assignments for this resource. | Yes | All ARM resource types | 
| enableSupportEventLogs      | View all operations and events | Yes | Resources, resource groups, subscriptions | 
| enableSupportHelpRequest    | Create a support request for this resource, resource group, or subscription. | Yes | All ARM resource types | 
| enableSupportResourceHealth | Check resource for common health issues (e.g. connectivity) and recommend fixes. | Yes | No | 
| enableSupportTroubleshoot   |  **Deprecated. Do not use.** Legacy support only. Moved to a new design with improved usability scores. | No  | No |
| enableSupportTroubleshootV2 | Troubleshoot possible availability/reliability issues (e.g. connectivity). | Yes | No | 
| enableTags                  | Tag resource with key/value pairs to group/organize related resources. RP must support PATCH operations to update tags. Does not support classic resources. | Yes | Resources, resource groups, subscriptions | 
| showAppInsightsFirst        | View Application Insights monitoring. `enableAppInsights` must be set to `true`. | No  | No | 


| Option                        | Production-ready metric | Enabled by default | Purpose |
|-------------------------------|-------------|--------------------|----------|
| enableAlerts                | No  | No | Create, view, and update alert rules. |
| enableAppInsights           | No  | No | View Application Insights monitoring. |
| enableDiagnostics           | No  | No | View monitoring diagnostics. |
| enableExportTemplate        | Yes | Resources, resource groups | Export a template of the resource group to automate redeployments. RPs must provide [template schemas](http://aka.ms/armschema) for this. Does not support classic resources. |
| enableLocks                 | Yes | Resources, resource groups, subscriptions | Lock resources to avoid accidental deletion and/or editing. |
| enableLogAnalytics          | No  | No | View OMS workspace. |
| enableLogSearch             | No  | No | Search logs. |
| enableMetrics               | No  | No | View monitoring metrics. |
| enableProperties            | No  | No | Generic properties blade for resources. Only includes standard ARM properties today, but may be integrated with the supplemental data, if needed. (Please file a [partner request](http://aka.ms/portalfx/request).) Does not support non-tracked resources. |
| enableRbac                  | Yes | All ARM resource types | Manage user/role assignments for this resource. |
| enableSupportEventLogs      | Yes | Resources, resource groups, subscriptions | View all operations and events |
| enableSupportHelpRequest    | Yes | All ARM resource types | Create a support request for this resource, resource group, or subscription. |
| enableSupportResourceHealth | Yes | No | Check resource for common health issues (e.g. connectivity) and recommend fixes. |
| enableSupportTroubleshoot   | No  | No | **Deprecated. Do not use.** Legacy support only. Moved to a new design with improved usability scores. |
| enableSupportTroubleshootV2 | Yes | No | Troubleshoot possible availability/reliability issues (e.g. connectivity). |
| enableTags                  | Yes | Resources, resource groups, subscriptions | Tag resource with key/value pairs to group/organize related resources. RP must support PATCH operations to update tags. Does not support classic resources. |
| showAppInsightsFirst        | No  | No | View Application Insights monitoring. `enableAppInsights` must be set to `true`. |




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
For more information about assets, see [portalfx-assets.md](portalfx-assets.md).


#### Verify that UX is responsive when maximized and restored

Since the resource menu acts as a container for the blades opened by the menu items, the display state is preserved when you switch between menu items. So, you should verify that blades render acceptable UX when the resource menu is maximized and when the resource menu is restored to the specified widths.

Next Steps:

* There are samples of resources using this in the Samples Extension see the Client\ResourceTypes\Desktop\ folder, particularly the AssetViewModels\DesktopViewModel.ts

* See [Resource Menu APIs](portalfx-resourcemenu-api.md)

* See the [frequently asked questions](portalfx-extensions-faq-resourcemenu.md)

* If there are any issues please reach out to <a href="mailto:ibiza-menu-blade@microsoft.com?subject=Issues with Resource Samples">Ibiza Menu Blade</a>.

