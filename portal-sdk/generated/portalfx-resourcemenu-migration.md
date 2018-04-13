
<a name="resource-menu-migration"></a>
# Resource menu migration

The Resource menu is the navigation menu for all your resource's functionality. Visually, the Resource menu  is not a separate blade; it ties the navigation menu and the content together, giving the user the impression that they are viewing a single 'app' like container. 

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included. 

There are several samples that use resource menus or resource types. Their locations are as follows.

* `<dir>\Client\V1\ResourceTypes`

* `<dir>\Client\V2\ResourceTypes`

Within those directories, there may be code that resembles the extension that you are maintaining.

Use the following steps to migrate from a settings blade to a resource menu blade.

1. [Use the resource menu](#use-the-resource-menu)

1. [Create an Asset ViewModel](#create-an-asset-viewmodel) 

1. [Flag previous behaviors](#flag-previous-behaviors)

* * *

<a name="resource-menu-migration-use-the-resource-menu"></a>
### Use the resource menu

To use a resource menu in an extension, add the `UseResourceMenu` property and specify a `ViewModel` on the `AssetType` tag in the PDL file.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

Some examples that contain AssetViewModels are in the following list.

`<dir>\Client\V1\ResourceTypes\Container`
`<dir>\Client\V1\ResourceTypes\Desktop`
`<dir>\Client\V1\ResourceTypes\Document`
`<dir>\Client\V1\ResourceTypes\ExtensionResources`
`<dir>\Client\V1\ResourceTypes\Host`
`<dir>\Client\V1\ResourceTypes\MobilePhone`
`<dir>\Client\V1\ResourceTypes\Snowmobile`
`<dir>\Client\V1\ResourceTypes\SnowmobileSki`
`<dir>\Client\V1\ResourceTypes\SparkPlug`
`<dir>\Client\V1\ResourceTypes\Storage\HardDrive`
`<dir>\Client\V1\ResourceTypes\Storage\SolidStateDrive`
`<dir>\Client\V1\ResourceTypes\Storage\StorageDrive`
`<dir>\Client\V1\ResourceTypes\TenantResource`
`<dir>\Client\V2\ResourceTypes\VirtualServer\AssetType`



``` xml
<AssetType Name="MyResource"
           ViewModel="{ViewModel Name=MyResourceViewModel, Module=./AssetViewModels/MyResourceViewModel}"
           ...
           UseResourceMenu="true">
```

<a name="resource-menu-migration-create-an-assetviewmodel"></a>
### Create an AssetViewModel

Create the `ViewModel` and then add a `getMenuConfig` method to the `AssetViewModel`. This method contains all the logic that determines which items to add to the menu, based on dynamic dependencies.

The following code ports the current settings of the extension into the new method.  It contains a menu that has three items and two groups. The items are an overview item, a custom group with an item, and adding an item to a framework group.

You can see that the API follows the settings item API very closely without the groups reference and the blade reference. Referencing blades within your own extension can be done by using the first two options. If the extension opens a blade outside of your extension, you can use the third method.

``` ts
import BladeReferences = require("../../_generated/BladeReferences");
import * as FxMenuBlade from "MsPortalFx/Composition/MenuBlade";
import * as ClientResources from "ClientResources";

import FxAssets = MsPortalFx.Assets;

const MenuGroupStrings = ClientResources.ResourceMenuGroup;
const MenuStrings = ClientResources.ResourceMenu;

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

    /**
     * Gets the resource menu configuration.
     *
     * @param resourceInfo The resource ID and resource|resource group for the menus.
     * @return A promise which will be resolved with the resource menu configuration.
     */
    public getMenuConfig(resourceInfo: MsPortalFx.Assets.ResourceInformation): MsPortalFx.Base.PromiseV<MsPortalFx.Assets.ResourceMenuConfig> {
        return Q(<MsPortalFx.Assets.ResourceMenuConfig>{
            overview: {
                id: "overview",
                displayText: MenuStrings.overview,
                keywords: ["keyword1","keyword2"],
                icon: MsPortalFx.Base.Images.Polychromatic.MyResourceImage(),
                supplyBladeReference: () => {
                    return new BladeReferences.MyResourceOverviewBladeReference({
                        id: resourceInfo.resourceId
                    });
                }
            },
            options: <MsPortalFx.Assets.ResourceMenuOptions>{
                enableRbac: true,
                enableTags: true,
                enableSupportEventLogs: true,
                enableSupportHelpRequest: true,
                enableSupportResourceHealth: true,
                enableSupportTroubleshoot: true
            },
            groups: <FxMenuBlade.MenuGroup[]>[
                {
                    id: "overview_group",
                    displayText: MenuGroupStrings.overview,
                    items: <FxMenuBlade.MenuItem[]>[
                        {
                            id: "properties",
                            displayText: "Properties",
                            keywords: ["keyword1","keyword2"],
                            icon: MsPortalFx.Base.Images.Polychromatic.MyPropertiesImage(),
                            supplyBladeReference: () => {
                                return new BladeReferences.MyResourcePropertiesBladeReference({
                                    resourceGroup: resourceInfo.resourceId
                                });
                            },
                            enabled: ko.observable(true)
                        }
                    ]
                },
                {
                    // There are a number of predefined framework groups items can be added to them using the following pattern
                    referenceId: FxAssets.SupportGroupId,
                    items: <FxMenuBlade.MenuItem[]>[
                        {
                            id: "alerts",
                            displayText: "Alerts",
                            keywords: ["keyword1","keyword2"],
                            icon: MsPortalFx.Base.Images.Polychromatic.Notification(),
                            supplyBladeReference: () => {
                                return new MsPortalFx.Composition.PdlBladeReference<any>(
                                    "AlertsListBlade",
                                    {
                                        targetResourceIds: [resourceInfo.resourceId],
                                        options: { enableEvents: false }
                                    },
                                    null,
                                    null,
                                    InsightsExtensionName
                                );
                            }
                        }
                    ]
                }
            ]
        });
    }
}
 ```

For more information about the Resource menu APIs, see [portalfx-resourcemenu-api.md](portalfx-resourcemenu-api.md).

### Flag previous behaviors

After the Resource menu has been added to the extension, there may be cases in which previous code is no longer suitable. However, backward-compatibility may be an issue, for developers and other users.  If so, the `resourcemenu` feature flag can be used to switch between the resource menu and previous settings selections, as in the following code.

``` ts
MsPortalFx.isFeatureEnabled("resourcemenu")
```

For example, if the Resource summary part on the resource blade is not enabled, then settings should be retrieved from a different blade by using the  `getSettingsSelection` option.

``` ts
getSettingsSelection: MsPortalFx.isFeatureEnabled("resourcemenu") ? null : SettingsSelection;
```