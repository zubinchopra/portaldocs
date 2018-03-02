
<a name="blade-kinds"></a>
## Blade Kinds

Blade Kinds are a set of built-in blades that encapsulate common patterns. These implementations offer a consistent UI and are easily implemented, because they provide a simplified programming model with a closed UI.  The main advantage of blade kinds is simplicity. When the Blade Kinds for an extension are updated, developers can use the updates and the layout without changing extension implementations. For example, one type of blade kind, the Quick start, is depicted in the following image.

![alt-text](../media/portalfx-bladeKinds/BladeKindsIntro.png "part")

When developing an extension that uses blade kinds, the developer should provide the ViewModel for the blade and another ViewModel for the part, regardless of the blade kind that is being developed.

The blade kind that is specified in the PDL file is a simplified version of a typical blade, as in the following code.

```xml
<azurefx:QuickStartBlade ViewModel="" PartViewModel=""/>
```

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

To learn more about each of the Blade Kinds, start with the following topics:

- [QuickStart Blade](#quickstart-blade)
- [Properties Blade](#properties-blade)
- [Notice Blade](#notice-blade)
- [Setting List Blade](#setting-list-blade)

* * * 

<a name="blade-kinds-quickstart-blade"></a>
### QuickStart Blade

The QuickStart blade provides users a convenient way to learn how to use your service. 

<!-- TODO: Determine whether the following sentence is advertising, or an actuality for services. -->

Every service should have a QuickStart Blade.

![alt-text](../media/portalfx-bladeKinds/QuickStartBlade.PNG "QuickStart Blade")

Use the following steps to create a QuickStart Blade.

1. The PDL to define a QuickStart Blade is located at     `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`.

    ```xml
    <azurefx:QuickStartBlade Name="QuickStartBlade"
                            ViewModel="{ViewModel Name=QuickStartBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                            PartViewModel="{ViewModel Name=InfoListPartViewModel, Module=./BladeKind/ViewModels/InfoListPartViewModel}"
                            Parameter="info"/>
    ```

1. Define the TypeScript view model that contains the blade, as in the following example.

    `<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`

    ```ts
    /**
    * The quick start blade view model for blade kinds.
    */
    export class QuickStartBladeViewModel extends MsPortalFx.ViewModels.Blade {
        /**
        * Blade view model constructor.
        *
        * @param container Object representing the blade in the shell.
        * @param initialState Bag of properties saved to user settings via viewState.
        * @param dataContext Long lived data access object passed into all view models in the current area.
        */
        constructor(container MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
            super();
            this.title(ClientResources.quickStartBladeTitle);
            this.subtitle(ClientResources.bladesLensTitle);
            this.icon(MsPortalFx.Base.Images.Polychromatic.Info());
        }

        /**
        * Invoked when the Part's inputs change.
        */
        public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
            this.subtitle(inputs.info.text);
            return null; // No need to load anything
        }
    }
    ```

1. Define the TypeScript view model that defines the part.

    `<dir>\Client\V1\Blades\BladeKind\ViewModels\InfoListPartViewModel.ts`


    ```ts
    /**
    * This sample uses the base class implementation. You can also implement the
    * interface MsPortalFx.ViewModels.Parts.InfoList.ViewModel.
    */
    export class InfoListPartViewModel extends MsPortalFx.ViewModels.Parts.InfoList.ViewModel {
        private _text: KnockoutObservableBase<string>;
        private _bladeWithInputs: KnockoutObservableBase<MsPortalFx.ViewModels.DynamicBladeSelection>;

        /**
        * Initialize the part.
        */
        constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
            super(initialState);

            this._text = ko.observable<string>("");

            var thirdBladeDisplayValue = ko.pureComputed(() => {
                return "{0} {1}".format(ExtensionDefinition.BladeNames.thirdBlade + ClientResources.sendingValue, this._text());
            });

            var infoListDesc1 = ko.pureComputed(() => {
                return "{0} - {1}".format(this._text(), ClientResources.infoListDesc1);
            });

            this._bladeWithInputs = ko.observable<MsPortalFx.ViewModels.DynamicBladeSelection>({
                detailBlade: ExtensionDefinition.BladeNames.thirdBlade,
                detailBladeInputs: {}
            });

            // add a section to open an external webpage.
            this.addSection(
                this._text,
                infoListDesc1,
                ClientResources.htmlSiteMSDNAddress,
                MsPortalFx.Base.Images.HeartPulse());

            // add a section to open a blade.
            this.addSection(
                ExtensionDefinition.BladeNames.firstBlade,
                ClientResources.infoListDesc3, {
                    detailBlade: ExtensionDefinition.BladeNames.firstBlade,
                    detailBladeInputs: {}
                }, MsPortalFx.Base.Images.Polychromatic.Browser());

            // add a secion that can have a list of links.
            this.addSection(
                ClientResources.infoListTitle2,
                ClientResources.infoListDesc2,
                [
                    new Vm.Parts.InfoList.Link(
                        ClientResources.htmlSiteMicrosoftName,
                        ClientResources.htmlSiteMicrosoftAddress
                        ),
                    new Vm.Parts.InfoList.Link(
                        ClientResources.targetBlade2Title,
                        {
                            detailBlade: ExtensionDefinition.BladeNames.secondBlade,
                            detailBladeInputs: {}
                        }
                        ),
                    new Vm.Parts.InfoList.Link(
                        ClientResources.htmlSiteBingName,
                        ClientResources.htmlSiteBingAddress
                        ),
                    new Vm.Parts.InfoList.Link(
                        thirdBladeDisplayValue,
                        this._bladeWithInputs
                        )
                ]);
        }

        /**
        * All sections should be added in the constructor, and should be updated via observables.
        */
        public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
            var text = inputs.info.text;

            this._text(text);

            // update the blade binding with inputs value
            this._bladeWithInputs({
                detailBlade: ExtensionDefinition.BladeNames.thirdBlade,
                detailBladeInputs: {
                    id: text
                }
            });


            return null; // No need to load anything
        }
    }
    ```
<a name="blade-kinds-properties-blade"></a>
### Properties Blade

The Properties blade that provides users a convenient way access the properties of your service. 

![alt-text](../media/portalfx-bladeKinds/PropertiesBlade.PNG "Demo")

The PDL to define a Properties Blade is located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`.

```xml
  <azurefx:PropertiesBlade Name="PropertiesBlade"
                           ViewModel="{ViewModel Name=PropertiesBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                           PartViewModel="{ViewModel Name=PropertiesPartViewModel, Module=./BladeKind/ViewModels/PropertiesPartViewModel}"
                           Parameter="info"/>
```

The TypeScript view model to define the Blade view model:

`<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`

```ts
/**
 * The properties blade view model for blade kinds.
 */
export class PropertiesBladeViewModel extends MsPortalFx.ViewModels.Blade {
    /**
     * Blade view model constructor.
     *
     * @param container Object representing the blade in the shell.
     * @param initialState Bag of properties saved to user settings via viewState.
     * @param dataContext Long lived data access object passed into all view models in the current area.
     */
    constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
        super();
        this.title(ClientResources.propertiesBladeTitle);
        this.icon(MsPortalFx.Base.Images.Polychromatic.Info());
    }

    /**
     * Invoked when the Part's inputs change.
     */
    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        this.subtitle(inputs.info.text);
        return null; // No need to load anything
    }
}
```

The TypeScript view model to define the part view model:


`<dir>\Client\V1\Blades\BladeKind\ViewModels\PropertiesPartViewModel.ts`

```ts
/**
 * Properties part view model.
 */
export class PropertiesPartViewModel extends MsPortalFx.ViewModels.Parts.Properties.ViewModel {
    private _text: KnockoutObservableBase<string>;
    private _bladeWithInputs: KnockoutObservableBase<MsPortalFx.ViewModels.DynamicBladeSelection>;

    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
        super(initialState);

        var longTextProperty = new MsPortalFx.ViewModels.Parts.Properties.TextProperty(ClientResources.textPropertyLabel, ko.observable<string>(ClientResources.textPropertyValue));
        longTextProperty.wrappable(true);

        this._text = ko.observable<string>("");

        this.addProperty(longTextProperty);
        this.addProperty(new MsPortalFx.ViewModels.Parts.Properties.LinkProperty(ClientResources.linkPropertyLabel, ClientResources.microsoftUri, ClientResources.linkPropertyValue));

        this.addProperty(new MsPortalFx.ViewModels.Parts.Properties.OpenBladeProperty(
            ExtensionDefinition.BladeNames.firstBlade,
            ExtensionDefinition.BladeNames.firstBlade, {
                detailBlade: ExtensionDefinition.BladeNames.firstBlade,
                detailBladeInputs: {}
            }));

        this.addProperty(new MsPortalFx.ViewModels.Parts.Properties.CopyFieldProperty(ClientResources.copyFieldPropertyLabel, this._text));

        this.addProperty(new MsPortalFx.ViewModels.Parts.Properties.OpenBladeProperty(
            ExtensionDefinition.BladeNames.secondBlade,
            ExtensionDefinition.BladeNames.secondBlade, {
                detailBlade: ExtensionDefinition.BladeNames.secondBlade,
                detailBladeInputs: {}
            }));

        this.addProperty(new MsPortalFx.ViewModels.Parts.Properties.CallbackProperty(ClientResources.callbackPropertyLabel, ClientResources.callbackPropertyValue, () => {
            alert(this._text());
        }));

        this._bladeWithInputs = ko.observable<MsPortalFx.ViewModels.DynamicBladeSelection>({
            detailBlade: ExtensionDefinition.BladeNames.thirdBlade,
            detailBladeInputs: {}
        });

        var thirdBladeDisplayValue = ko.pureComputed(() => {
            return ExtensionDefinition.BladeNames.thirdBlade + ClientResources.sendingValue + this._text();
        });

        this.addProperty(new MsPortalFx.ViewModels.Parts.Properties.OpenBladeProperty(
            ExtensionDefinition.BladeNames.thirdBlade,
            thirdBladeDisplayValue,
            this._bladeWithInputs
        ));

        var multiLinks = ko.observableArray<MsPortalFx.ViewModels.Parts.Properties.Link>([
            {
                text: ClientResources.htmlSiteMicrosoftName,
                uri: ClientResources.htmlSiteMicrosoftAddress
            },
            {
                text: ClientResources.htmlSiteBingName,
                uri: ClientResources.htmlSiteBingAddress
            },
            {
                text: ClientResources.htmlSiteMSDNName,
                uri: ClientResources.htmlSiteMSDNAddress
            }
        ]);

        this.addProperty(new MsPortalFx.ViewModels.Parts.Properties.MultiLinksProperty(ClientResources.multiLinksPropertyLabel, multiLinks));
    }

    /**
     * All properties should be added in the constructor, and use observables to update properties.
     */
    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        var text = inputs.info.text;

        this._text(text);

        // update the blade binding with inputs value
        this._bladeWithInputs({
            detailBlade: ExtensionDefinition.BladeNames.thirdBlade,
            detailBladeInputs: {
                id: text
            }
        });

        return null;
    }
}

```

<a name="blade-kinds-notice-blade"></a>
### Notice Blade

The Notice blade that provides a convenient way to display announcements to your users, such as coming soon features. 

![alt-text](../media/portalfx-bladeKinds/NoticeBlade.PNG "Notice Blade")

The PDL to define a Properties Blade is located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`.

```xml
  <azurefx:NoticeBlade Name="NoticeBlade"
                       ViewModel="{ViewModel Name=NoticeBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                       PartViewModel="{ViewModel Name=NoticePartViewModel, Module=./BladeKind/ViewModels/NoticePartViewModel}"
                       Parameter="info"/>
```
The TypeScript view model to define the Blade view model:

`<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`

```ts
/**
 * The notice blade view model for blade kinds.
 */
export class NoticeBladeViewModel extends MsPortalFx.ViewModels.Blade {
    /**
     * Blade view model constructor.
     *
     * @param container Object representing the blade in the shell.
     * @param initialState Bag of properties saved to user settings via viewState.
     * @param dataContext Long lived data access object passed into all view models in the current area.
     */
    constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
        super();
        this.title(ClientResources.noticeBladeTitle);
    }

    /**
     * Invoked when the Part's inputs change.
     */
    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        this.subtitle(inputs.info.text);
        return null; // No need to load anything
    }
}
```

The TypeScript view model to define the part view model:

`<dir>\Client\V1\Blades\BladeKind\ViewModels\NoticePartViewModel.ts`

```ts
/**
 * Notice part view model.
 */
export class NoticePartViewModel extends MsPortalFx.ViewModels.Controls.Notice.ViewModel {
    /**
     * View model constructor.
     *
     * @param container Object representing the part in the shell.
     * @param initialState Bag of properties saved to user settings via viewState.
     * @param dataContext Long lived data access object passed into all view models in the current area.
     */
    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
        super();

        this.title(ClientResources.comingSoonTitle);
        this.description(ClientResources.comingSoonDescription);
        this.callToActionText(ClientResources.comingSoonAction);
        this.callToActionUri(ClientResources.microsoftUri);
        this.imageType(MsPortalFx.ViewModels.Controls.Notice.ImageType.ComingSoon);
    }

    /**
     * Update header based on service name.
     *
     * @param inputs Collection of inputs passed from the shell.
     * @returns A promise that needs to be resolved when data loading is complete.
     */
    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        var serviceName = inputs.info.serviceName,
            header = ClientResources.comingSoon.format(serviceName);

        this.header(header);

        return null;
    }
}
```

 
<a name="blade-kinds-setting-list-blade"></a>
### Setting List Blade

The Setting List Blade provides a convenient way to give users access to a list of your service's settings.

![alt-text](../media/portalfx-bladeKinds/SettingListBlade.PNG "Setting List")


The PDL to define a Settings Blade is located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`.

```xml
  <azurefx:SettingListV2Blade Name="SettingListBlade"
                            ViewModel="{ViewModel Name=SettingListBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                            PartViewModel="{ViewModel Name=SettingListPartViewModel, Module=./BladeKind/ViewModels/SettingListPartViewModel}"
                            Parameter="id"/>
```

The TypeScript view model to define the Blade view model:

`<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`

```ts
/**
 * The setting list blade view model for blade kinds.
 */
export class SettingListBladeViewModel extends MsPortalFx.ViewModels.Blade {
    /**
     * Blade view model constructor.
     *
     * @param container Object representing the blade in the shell.
     * @param initialState Bag of properties saved to user settings via viewState.
     * @param dataContext Long lived data access object passed into all view models in the current area.
     */
    constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
        super();
        this.title(ClientResources.settingListBlade);
    }

    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        this.subtitle(inputs.id);
        return null; // No need to load anything
    }
}
```

The TypeScript view model to define the part view model:

`<dir>\Client\V1\Blades\BladeKind\ViewModels\SettingListPartViewModel.ts`

```ts
/**
 * The view model of the setting list part.
 */
export class SettingListPartViewModel extends MsPortalFx.ViewModels.Parts.SettingList.ViewModelV2 {
    private _propertySettingBladeInputs: KnockoutObservableBase<any>;
    private _keySettingBladeInputs: KnockoutObservableBase<any>;

    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
        this._propertySettingBladeInputs = ko.observable({});
        this._keySettingBladeInputs = ko.observable({});

         super(container, initialState, this._getSettings(container),
            {
             enableRbac: true,
             enableTags: true,
             groupable: true
            });
    }

    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        var id = inputs.id;
        this.resourceId(id);

        this._propertySettingBladeInputs({ id: id });
        this._keySettingBladeInputs({ id: id });

        return null; // No need to load anything
    }

    private _getSettings(): MsPortalFx.ViewModels.Parts.SettingList.Setting[] {
        var propertySetting = new MsPortalFx.ViewModels.Parts.SettingList.Setting("property", ExtensionDefinition.BladeNames.propertySettingBlade, this._propertySettingBladeInputs),
            keySetting = new MsPortalFx.ViewModels.Parts.SettingList.Setting("key", ExtensionDefinition.BladeNames.keySettingBlade, this._keySettingBladeInputs);

        propertySetting.displayText(ClientResources.propertySetting);
        propertySetting.icon(MsPortalFx.Base.Images.Polychromatic.Controls());
        propertySetting.keywords([ClientResources.user]);

        keySetting.displayText(ClientResources.keySetting);
        keySetting.icon(MsPortalFx.Base.Images.Polychromatic.Key());

        return [propertySetting, keySetting];
    }
}
```

<a name="blade-kinds-framework-settings"></a>
### Framework settings

One goal of the Azure Portal is to standardize key interaction patterns across resources, so that customers can learn them once and apply them everywhere. There a few setting items which are consistent across most resources. To make that process easier, the Framework will automatically add specific settings, but also allow extensions to opt in for any settings that the Framework does not automatically add. All the settings that are added by the Framework can always be opted out, by setting  the appropriate enabling option to `false`. 

Only two settings are added automatically: RBAC and Audit logs, or events. They are only added if a valid resource id was specified within the `resourceId()` property on the settingsList viewmodel. The best way to set this property is to use the `onInputsSet` call, as in the following code.

```ts
export class SettingListPartViewModel extends MsPortalFx.ViewModels.Parts.SettingList.ViewModelV2 {
    ...

     public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        var id = inputs.id;
        this.resourceId(id);

        return null
    }
}
```

<a name="blade-kinds-framework-settings-tags-and-rbac"></a>
#### Tags and RBAC

Tags and role-based access (RBAC) for users are the most common settings 
Although the Portal does not automatically add Tags, it is extremely easy to opt in if your resource supports tagging. To opt in set the following in the options parameter of the super call to the SettingsList viewmodel.

For more information about tags, see [./portalfx-tags](./portalfx-tags) and [https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags).

```ts
export class SettingListPartViewModel extends MsPortalFx.ViewModels.Parts.SettingList.ViewModelV2 {
    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
         super(container, initialState, this._getSettings(container),
            {
             enableRbac: true,
             enableTags: true,
             groupable: true
            });
    }
}
```

<a name="blade-kinds-framework-settings-support-settings"></a>
#### Support settings

Troubleshooting and support are one of these key experiences. We'd like to provide customers with a consistent gesture so for every resource they can assess its health, check the audit logs, get troubleshooting information, or open a support ticket. Every resource should on-board with Support and opt in to the support settings, see the [on-boarding process] [supportOnboarding]. For any questions regarding the process please reach out to the support adoption alias <AzSFAdoption@microsoft.com>

Enabling the support settings takes slightly more effort due to coordination and validation required with the support extension. For each of the settings you first need to opt in following the same pattern as before through the options parameter within the super call to the SettingsList ViewModel.

```ts
export class SettingListPartViewModel extends MsPortalFx.ViewModels.Parts.SettingList.ViewModelV2 {
    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
         super(container, initialState, this._getSettings(container),
            {
             enableSupportHelpRequest: true,
             enableSupportTroubleshoot: true,
             enableSupportResourceHealth: true,
             enableSupportEventLogs: true,
             groupable: true
            });
    }
}
```

Then to test it use the following extension side feature flags, depending on which settings you are testing, **please ensure your extension name is in lower case.**

* ?<extensionName>_troubleshootsettingsenabled=true
* ?<extensionName>_healthsettingsenabled=true
* ?<extensionName>_requestsettingsenabled=true

*Example: ?microsoft_azure_classic_compute_requestsettingsenabled=true*

Next steps:

* [Onboard to support](https://microsoft.sharepoint.com/teams/WAG/EngSys/Supportability/_layouts/15/WopiFrame.aspx?sourcedoc={7210704b-64db-489b-9143-093e020e75b4}&action=edit&wd=target%28%2F%2FCustomerEnablement.one%7Cf42af409-12ab-4ae0-ba49-af361116063b%2FAt%20How-to%20for%20PGs%7C92cd2c56-c400-4a6d-a455-63ef92290ae9%2F%29)
