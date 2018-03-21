
<a name="blade-kinds"></a>
## Blade Kinds

Blade Kinds are a set of built-in blades that encapsulate common patterns. These implementations offer a consistent UI and are easily implemented, because they provide a simplified programming model with a closed UI.  When the Blade Kinds for an extension are updated, developers can use the updates and the layout without changing the rest of the extension implementations. For example, one type of blade kind, the Quick start, is depicted in the following image.

![alt-text](../media/portalfx-bladeKinds/BladeKindsIntro.png "Quick start Blade Kind")

When developing an extension that uses blade kinds, the developer should provide one `ViewModel` for the blade and another `ViewModel` for the part, regardless of the blade kind that is being developed.

The blade kind that is specified in the PDL file is a simplified version of a typical blade, as in the following code.

```xml
<azurefx:QuickStartBlade ViewModel="" PartViewModel=""/>
```

The Blade kind uses **Typescript** logic for the blade, and a separate `viewModel` for each part that it contains.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

The following sections discuss the different types of Blade kinds.

- [Notice Blade](#notice-blade)
- [Properties Blade](#properties-blade)
- [QuickStart Blade](#quickstart-blade)
- [Setting List Blade](#setting-list-blade)

* * * 

<a name="blade-kinds-notice-blade"></a>
### Notice Blade

The Notice blade provides a convenient way to display announcements.  For example, the "coming soon" Notice blade is depicted in the following image.

![alt-text](../media/portalfx-bladeKinds/NoticeBlade.PNG "Notice Blade")

1. The HTML template is referenced in the PDL file located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`.

1. The PDL to define a Notice blade is also located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`, and is in the following code.

    ```xml
    <azurefx:NoticeBlade Name="NoticeBlade"
                        ViewModel="{ViewModel Name=NoticeBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                        PartViewModel="{ViewModel Name=NoticePartViewModel, Module=./BladeKind/ViewModels/NoticePartViewModel}"
                        Parameter="info"/>
    ```

1. The TypeScript that defines the Notice Blade `ViewModel` is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`. It is also in the following code.

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

1. The TypeScript that defines the Notice part `ViewModel` is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\NoticePartViewModel.ts`. It is also in the following code.

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

<a name="blade-kinds-properties-blade"></a>
### Properties Blade

The Properties blade provides users a convenient way access the properties of the service.  For example, a `Properties` blade is depicted in the following image. 

![alt-text](../media/portalfx-bladeKinds/PropertiesBlade.PNG "Demo")

1. The PDL to define a Properties Blade is located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`. It is also in the following example.

    ```xml
    <azurefx:PropertiesBlade Name="PropertiesBlade"
                            ViewModel="{ViewModel Name=PropertiesBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                            PartViewModel="{ViewModel Name=PropertiesPartViewModel, Module=./BladeKind/ViewModels/PropertiesPartViewModel}"
                            Parameter="info"/>
    ```

1. The TypeScript that defines the Properties Blade `ViewModel` is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`. It is also in the following example.

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

1. The TypeScript that defines the part view model is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\PropertiesPartViewModel.ts`. It is also in the following code.

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

<a name="blade-kinds-quickstart-blade"></a>
### QuickStart Blade

The QuickStart blade provides users a convenient way to learn how to use the service. 

<!-- TODO: Determine whether the following sentence is advertising, or an actuality for services. -->

Every service should have a QuickStart Blade.

![alt-text](../media/portalfx-bladeKinds/QuickStartBlade.PNG "QuickStart Blade")

Use the following steps to create a QuickStart Blade.

1. The PDL to define a QuickStart Blade is located at     `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`. It is also in the following code.

    ```xml
    <azurefx:QuickStartBlade Name="QuickStartBlade"
                            ViewModel="{ViewModel Name=QuickStartBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                            PartViewModel="{ViewModel Name=InfoListPartViewModel, Module=./BladeKind/ViewModels/InfoListPartViewModel}"
                            Parameter="info"/>
    ```

1. The TypeScript that defines the QuickStart Blade `ViewModel` is located at   `<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`. It is also in the following example.

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

1. The TypeScript that defines the part view model is located at   `<dir>\Client\V1\Blades\BladeKind\ViewModels\InfoListPartViewModel.ts`.  It is also in the following example.

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
 
<a name="blade-kinds-setting-list-blade"></a>
### Setting List Blade

The Setting List Blade provides a convenient way to display a list of settings for a service, as in the following image.

![alt-text](../media/portalfx-bladeKinds/SettingListBlade.PNG "Setting List")

1. The PDL to define a Settings Blade is located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`. It is also in the following code.

    ```xml
    <azurefx:SettingListV2Blade Name="SettingListBlade"
                                ViewModel="{ViewModel Name=SettingListBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                                PartViewModel="{ViewModel Name=SettingListPartViewModel, Module=./BladeKind/ViewModels/SettingListPartViewModel}"
                                Parameter="id"/>
    ```

1. The TypeScript that defines the Settings Blade `ViewModel` is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`. It is also in the following code.

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

1. The TypeScript that defines the part view model is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\SettingListPartViewModel.ts`. It is also in the following code.

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
