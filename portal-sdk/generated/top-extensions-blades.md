
<a name="blades-and-template-blades"></a>
# Blades and Template Blades


<a name="blades-and-template-blades-overview"></a>
## Overview

Blades are the main UI container in the Portal. They are equivalent to `windows` or `pages` in other UX frameworks.   A blade typically generally takes up the full screen, has a presence in the portal breadcrumb, and has an 'X' button to close it.
 The following is a list of different types of blades.

| Type | Document    | Description |
| ---- | ----------- | ----------- | 
| TemplateBlade | [portalfx-extensions-blades-procedure.md](portalfx-extensions-blades-procedure.md) | Creating any Portal blade. This is the main and recommended authoring model for UI in the Portal. It uses an HTML template for the UI, and a ViewModel with the logic that binds to that HTML template. | 
| MenuBlade | [portalfx-blades-menublade.md](portalfx-blades-menublade.md) | Left side vertical menu. Displays a menu at the left of a blade. This blade gets combined by the Shell with the blade that its opened at its right.|  
| Fx Blades |  [portalfx-blades-bladeKinds.md](portalfx-blades-bladeKinds.md) | A limited set of built-in blades that encapsulate common patterns, like properties, quick start, or create forms. | 
| AppBlade | [portalfx-blades-appblades.md](portalfx-blades-appblades.md) | Rehosts an existing experience, or creates a UI that is  not supported by the Fx. It provides an IFrame to host the UI in order to enable full flexibility and control. Does not use Ibiza Fx controls, and extension developers are fully responsible for accessibility, theming, and consistency. | 
| Blade with tiles |[portalfx-blades-legacy.md](portalfx-blades-legacy.md) |  Legacy authoring model that uses a combination of lenses and parts. Given the complexity associated with this model, we are encouraging authors to use TemplateBlades instead. | 

   
 
<a name="blades-and-template-blades-templateblades"></a>
## TemplateBlades

The TemplateBlade is the recommended way of authoring blades in Ibiza. It is the equivalent to windows or pages in other systems.

You can think of a TemplateBlade as an HTML page. Authoring template blades requires a blade definition in PDL, an HTML template, a ViewModel, and optionally a CSS file. The following sections discuss the details of the PDL definition and the blade capabilities in the ViewModel.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

* [Creating the TemplateBlade](#creating-the-templateblade)

* [Adding Controls](#adding-controls)

* [Sending parameters](#sending-parameters)

* [Adding commands](#adding-commands)

* [Adding buttons](#adding-buttons)

* [Displaying a full-screen blade](#displaying-a-full-screen-blade)

* [Displaying a loading indicator UX](#displaying-a-loading-indicator-ux)

<a name="blades-and-template-blades-templateblades-creating-the-templateblade"></a>
### Creating the TemplateBlade

Use the following steps to create a template blade.

1. Add the **blade definition** to your PDL file

    ```xml
    <TemplateBlade
                Name="MyTemplateBlade"
                ViewModel="{ ViewModel Name=MyTemplateBladeViewModel, Module=./ViewModels/MyTemplateBladeViewModel }"
                InitialDisplayState="Maximized"
                Template="{ Html Source='Templates\\MyTemplateBlade.html' }">
    </TemplateBlade>
    ```
    The PDL file can contain several options. The following is a list of the most relevant parameters.

    **Name**: Name of the blade. This name is used later to refer to this blade. 

    **ViewModel**: Required field.  The ViewModel that is associated with this blade. 

    **Template**: Required field.  The HTML template for the blade. 

    **Size**: Optional field. The width of the blade. The default value is `Medium`. 

    **InitialDisplayState**: Optional field.  Specifies whether the blade is opened maximized or not. The default value is `Normal`. 

    **Style**: Optional field. Visual style for the blade. The default value is `Basic`. 
    **Pinnable**: Optional field. Flag that specifies whether the blade can be pinned or not. The default value is `false`.

    **ParameterProvider**: Optional field. Flag that specifies whether the blade is a parameter-provider. The default value is  `false`.

    **Export**: Optional field.  Flag that specifies whether this blade is exported in your extension and therefore can be opened by other extensions. As a result, a strongly typed blade reference is created. 

1. Create a **ViewModel** TypeScript class. The following code snippet shows the Viewmodel that is associated with the blade that was defined in the PDL file. This model exposes two observable properties, but more complex behavior can be added for your extension as appropriate.

    ```js
    export class MyTemplateBladeViewModel extends MsPortalFx.ViewModels.Blade {

        public text: KnockoutObservable<string>;
        public url: KnockoutObservable<string>;

        constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: any) {
            super();
            this.title("InfoBox");
            this.subtitle("InfoBox Playground");

            this.text = ko.observable<string>("Go to the Azure Portal");
            this.url = ko.observable<string>("http://portal.azure.com");
        }

        public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
            return null;
        }
    }

    ```

1. Create a template for the blade using regular HTML and **Knockout**. The **Knockout** bindings are bound to the public properties in the ViewModel in the previous step. 

    ```html
    <div>This is an example template blade that shows a link.</div>

    <a data-bind="text: text, attr: { href: url }" target="_blank"></a>
    ```

For more information about Knockout, see [knockout.js](http://knockoutjs.com/).

<a name="blades-and-template-blades-templateblades-adding-controls"></a>
### Adding controls

The example in the previous section uses ordinary HTML in its template. Ibiza provides an extensive controls library that you can use in the HTML template. The following example uses the `InfoBox` control instead of a regular HTML link.

<!-- TODO:  Determine whether the code in this file is in a sample that ships with the SDK. -->

1. Change the link element in the HTML template to a control container.

    ```html
    <div>This is an example template blade that shows a link.</div>

    <div data-bind="pcControl:infoBox"></div>
    ```

1. Update the blade ViewModel to expose and instantiate the control ViewModel, as in the following code.

    ```javascript
    export class MyTemplateBladeViewModel extends MsPortalFx.ViewModels.Blade {

        // view-model for the infoBox control
        public infoBox: MsPortalFx.ViewModels.Controls.InfoBox.BaseViewModel;

        constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: any) {
            super();
            this.title("InfoBox");
            this.subtitle("InfoBox Playground");

            // initialization of the InfoBox view-model
            this.infoBox = new MsPortalFx.ViewModels.Controls.InfoBox.LinkViewModel(container, {
                text: ko.observable<string>('Go to the Azure Portal'),
                image: ko.observable(MsPortalFx.Base.Images.Info()),
                clickableLink: ko.observable(MsPortalFx.ViewModels.Part.createClickableLinkViewModel(ko.observable<string>('http://portal.azure.com'))
            });
        }

        public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
            return null;
        }
    }
    ```

<a name="blades-and-template-blades-templateblades-sending-parameters"></a>
### Sending parameters

Blades can receive input parameters that are defined as part of the signature for the blade. The following code adds an "id" input parameter to the template blade.

1. Include the parameters in the signature of the blade in the PDL definition.

    ```xml
    <TemplateBlade
                Name="MyTemplateBlade"
                ViewModel="{ ViewModel Name=MyTemplateBladeViewModel, Module=./ViewModels/MyTemplateBladeViewModel }"
                Template="{ Html Source='Templates\\MyTemplateBlade.html' }">
        <TemplateBlade.Parameters>
            <Parameter Name="id" />
        </TemplateBlade.Parameters>
    </TemplateBlade>
    ```

1. Define the signature in the ViewModel.

    ```javascript
    import Def = ExtensionDefinition.ViewModels.Resource.MyTemplateBladeViewModel;

    export class MyTemplateBladeViewModel extends MsPortalFx.ViewModels.Blade {

        // this property is part of the blade signature and is passed into onInputSet
        public id: KnockoutObservable<string>;

        public infoBox: MsPortalFx.ViewModels.Controls.InfoBox.BaseViewModel;

        constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: any) {
            super();
            this.title("InfoBox");
            this.subtitle("InfoBox Playground");

            this.infoBox = new MsPortalFx.ViewModels.Controls.InfoBox.LinkViewModel(container, {
                text: ko.observable<string>('Go to the Azure Portal'),
                image: ko.observable(MsPortalFx.Base.Images.Info()),
                clickableLink: ko.observable(MsPortalFx.ViewModels.Part.createClickableLinkViewModel(ko.observable<string>('http://portal.azure.com'))
            });
        }

        public onInputsSet(inputs: Def.InputsContract): MsPortalFx.Base.Promise {
            // write the input property to the console
            console.log(inputs.id);
            return null;
        }
    }
    ```

<a name="blades-and-template-blades-templateblades-adding-commands"></a>
### Adding commands

Template blades can display commands at the top. To add the commands,  add a toolbar to the TemplateBlade, and then define its contents in the TemplateBlade's `ViewModel`.
The working copy of the sample in the Dogfood environment is located at  [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/bladewithtoolbar](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/bladewithtoolbar).


1. Add a **CommmandBar** element to your PDL template
    ```xml
    <TemplateBlade
                Name="MyTemplateBlade"
                ViewModel="{ ViewModel Name=MyTemplateBladeViewModel, Module=./ViewModels/MyTemplateBladeViewModel }"
                Template="{ Html Source='Templates\\MyTemplateBlade.html' }">
        <TemplateBlade.Parameters>
            <Parameter Name="id" />
        </TemplateBlade.Parameters>
        <CommandBar />
    </TemplateBlade>
    ```

1. Instantiate the `CommandBar` in the ViewModel, as in the following code.

```javascript
import Def = ExtensionDefinition.ViewModels.Resource.MyTemplateBladeViewModel;

export class MyTemplateBladeViewModel extends MsPortalFx.ViewModels.Blade {

    public id: KnockoutObservable<string>;
    public infoBox: MsPortalFx.ViewModels.Controls.InfoBox.BaseViewModel;

    // toolbar view-model
    public commandBar: MsPortalFx.ViewModels.ToolbarContract;

    constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: any) {
        super();
        this.title("InfoBox");
        this.subtitle("InfoBox Playground");

        this.infoBox = new MsPortalFx.ViewModels.Controls.InfoBox.LinkViewModel(container, {
            text: ko.observable<string>('Go to the Azure Portal'),
            image: ko.observable(MsPortalFx.Base.Images.Info()),
            clickableLink: ko.observable(MsPortalFx.ViewModels.Part.createClickableLinkViewModel(ko.observable<string>('http://portal.azure.com'))
        });

        // initialize the toolbar
        var button = new Toolbars.OpenLinkButton("http://azure.com");
        button.label("azure.com");
        button.icon(MsPortalFx.Base.Images.Hyperlink());
        this.commandBar = new Toolbars.Toolbar(container);
        this.commandBar.setItems( [ button ] );
    }

    public onInputsSet(inputs: Def.InputsContract): MsPortalFx.Base.Promise {
        return null;
    }
}
```

<a name="blades-and-template-blades-templateblades-adding-buttons"></a>
### Adding buttons

Blades can display buttons that are docked at to the base of the blade.  The following code demonstrates how to add buttons to the blade.

1. Add an `ActionBar` element in your PDL template. The ActionBar  is docked to the bottom of the blade and contains buttons, as in the following example.

    ```xml
    <TemplateBlade
                Name="MyTemplateBlade"
                ViewModel="{ ViewModel Name=MyTemplateBladeViewModel, Module=./ViewModels/MyTemplateBladeViewModel }"
                Template="{ Html Source='Templates\\MyTemplateBlade.html' }">
        <TemplateBlade.Parameters>
            <Parameter Name="id" />
        </TemplateBlade.Parameters>
        <ActionBar ActionBarKind="Generic" />
    </TemplateBlade>
    ```

1. Instantiate the `ActionBar` in the ViewModel.

    ```javascript
        export class MyTemplateBladeViewModel extends MsPortalFx.ViewModels.Blade {

            public id: KnockoutObservable<string>;
            public infoBox: MsPortalFx.ViewModels.Controls.InfoBox.BaseViewModel;

            // define the actionBar view-demol
            public actionBar: MsPortalFx.ViewModels.ActionBars.GenericActionBar.ViewModel;

            constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: any) {
                super();
                this.title("InfoBox");
                this.subtitle("InfoBox Playground");

                this.infoBox = new MsPortalFx.ViewModels.Controls.InfoBox.LinkViewModel(container, {
                    text: this.text,
                    image: ko.observable(MsPortalFx.Base.Images.Info()),
                    clickableLink: ko.observable(MsPortalFx.ViewModels.Part.createClickableLinkViewModel(this.url))
                });

          // initialize the ActionBar

                this.actionBar = new MsPortalFx.ViewModels.ActionBars.GenericActionBar.ViewModel(container);   
                this.actionBar.actionButtonClick = () => {
                    console.log("Clicked!!!");
                };
            }

            public onInputsSet(inputs: Def.InputsContract): MsPortalFx.Base.Promise {
                return null;
            }
        }
    ```

<a name="blades-and-template-blades-templateblades-displaying-a-full-screen-blade"></a>
### Displaying a full-screen blade

If you want the blade to open using the full screen, just add `InitialState="Maximized"` to the PDL definition of the blade, as in the following code.

```xml
<TemplateBlade
            Name="MyTemplateBlade"
            ViewModel="{ ViewModel Name=MyTemplateBladeViewModel, Module=./ViewModels/MyTemplateBladeViewModel }"
            InitialDisplayState="Maximized"
            Template="{ Html Source='Templates\\MyTemplateBlade.html' }">
</TemplateBlade>
```

<a name="blades-and-template-blades-templateblades-displaying-a-loading-indicator-ux"></a>
### Displaying a loading indicator UX

Sometimes interaction with a blade should be prevented while it is initializing. In those cases, a shield that contains a loading indicator UX is displayed in the blade to block the display. The shield can be fully transparent or opaque. The following code demonstrates how to set an opaque filter in the blade.

```javascript
constructor(container: FxCompositionBlade.Container, initialState: any, dataContext: BladesArea.DataContext) {
    super();

    var operation = Q.defer<any>();

    // show the shield while the operation promise is not resolved
    container.operations.add(operation.promise, { blockUi: true, shieldType: MsPortalFx.ViewModels.ShieldType.Opaque });

    // wait for 3 seconds and resolved the promise (which will remove the shield)
    window.setTimeout(() => { operation.resolve(); }, 3000);
}
```

The following code snippet demonstrates how to apply a filter on a timer.  The filter slowly changes from opaque to transparent. The sample is also located at `<dir>\Client\V1\Blades/Template/ViewModels/TemplateBladeViewModels.ts`.

```typescript

export class TemplateBladeWithShieldViewModel
extends Blade
implements Def.TemplateBladeWithShieldViewModel.Contract
{
/**
 * The blade's title.
 */
public title: KnockoutObservable<string>;

/**
 * TextBox form field.
 */
public myTextBox: TextBox.ViewModel;

private _timerHandle: number;

constructor(container: FxCompositionBlade.Container, initialState: any, dataContext: BladesArea.DataContext) {
    super();

    this.title(ClientResources.templateBladeWithShield);

    const translucent = MsPortalFx.ViewModels.ShieldType.Translucent;
    const opaque = MsPortalFx.ViewModels.ShieldType.Opaque;
    var isTranslucent = true;

    var op = () => {
        var operation = Q.defer<any>();
        var shieldType = isTranslucent ? translucent : opaque;
        container.operations.add(operation.promise, { blockUi: true, shieldType: shieldType });

        isTranslucent = !isTranslucent;
        window.setTimeout(() => { operation.resolve(); }, 3000);
    };

    op();

    window.setInterval(op, 5000);

    // TextBox
    var textBoxOptions = <TextBox.Options>{
        label: ko.observable(ClientResources.formsSampleBasicTextBox)
    };
    this.myTextBox = new TextBox.ViewModel(container, textBoxOptions);
}

/**
 * Clean up any resources.
 */
public dispose(): void {
    window.clearInterval(this._timerHandle);
}
}

```

<a name="advanced-template-blade-topics"></a>
# Advanced template blade topics

 
<a name="advanced-template-blade-topics-advanced-topics"></a>
### Advanced Topics

The following sections discuss advanced topics in template blade development.

* [Deep linking](#deep-linking)

* [Displaying notifications](#displaying-notifications)

* [Pinning the blade](#pinning-the-blade)

* [Storing settings](#storing-settings)

* [Displaying Unauthorized UI](#displaying-unauthorized-ui)

* [Dynamically displaying Notice UI](#dynamically-displaying-notice-ui)

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

* * *

<a name="advanced-template-blade-topics-deep-linking"></a>
### Deep linking

Deep linking is the feature that gives the user a URL that directly navigates to the new blade when a blade is opened and the portal URL is updated. By design, only certain blades can be deep linked. Blades that cannot be deep linked are the ones that cannot be opened independent of some parent blade or part, like blades that return values to a calling module. An example of blades that cannot be deep-linked is a Web page in the middle of an website's check-out experience.

One of the easiest ways to make your blade deep linkable is to mark your TemplateBlade as pinnable. For more information about pinning blades, see [#pinning-the-blade](#pinning-the-blade).

<a name="advanced-template-blade-topics-displaying-notifications"></a>
### Displaying notifications

A status bar can be displayed at the top of a blade that contains both text and coloration that can be used to convey information and status to users. For example, when validation fails in a form, a red bar with a message can be displayed at the top of the blade. This area is clickable and can either open a new blade or an external url.

This capability is exposed through the **statusBar** member in the Blade base class by using `this.statusBar(myStatus)` in your blade view-model, as in the code located at `<dir>Client/V1/Blades/ContentState/ViewModels/ContentStateViewModels.ts`.
It is also included in the following code.

```typescript

if (newContentState !== MsPortalFx.ViewModels.ContentState.None) {
    statusBar = {
        text: newDisplayText,
        state: newContentState,
        selection: stateDetailsBladeSelection,
        onActivated: onActivated
    }
}

this.statusBar(statusBar);

```

<a name="advanced-template-blade-topics-pinning-the-blade"></a>
### Pinning the blade

Blades can be marked as able to be pinned to the dashboard by setting `Pinnable="true"` in the TemplateBlade's PDL definition file. By default, blades are pinned as button parts to the dashboard. If a different represention should be used, it should be specified in the PDL. 

<a name="advanced-template-blade-topics-storing-settings"></a>
### Storing settings

Settings that are associated with a blade can be stored. Those settings need to be declared both in the PDL definition file and in the ViewMmodel that is associated with the blade.  The code that describes how to store settings is located at  `<dir>Client/V1/Blades/Template/Template.pdl` and  `<dir>Client/V1/Blades/Template/ViewModels/TemplateBladeViewModels.ts`.

The process is as follows.

1. Specify the settings in the PDL file using the `TemplateBlade.Settings` element.

    ```xml

<TemplateBlade Name="PdlTemplateBladeWithSettings"
               ViewModel="{ViewModel Name=TemplateBladeWithSettingsViewModel, Module=./Template/ViewModels/TemplateBladeViewModels}"
               Template="{Html Source='Templates\\TemplateBladeWithSettings.html'}">
  <TemplateBlade.Settings>
    <Setting Property="colorSettingValue" />
    <Setting Property="fontSettingValue" />
  </TemplateBlade.Settings>
</TemplateBlade>

```

1. After the settings are declared, they should also be specified in the ViewModel, as in the following example.

    ```typescript

// These are required by the portal presently.  Re: Part Settings, the Part below works exclusively in terms of
// 'configuration.updateValues' to update settings values and 'onInputsSet(..., settings)' to receive settings values.
public colorSettingValue = ko.observable<BackgroundColor>();
public fontSettingValue = ko.observable<FontStyle>();

```

1. Retrieve the settings by using the blade container.

    ```typescript

const configuration = container.activateConfiguration<Settings>();
this.configureHotSpot = new HotSpotViewModel(container, {
    supplyBladeReference: () => {
        const bladeRef = new PdlTemplateBladeWithSettingsConfigurationReference<BladeConfiguration, BladeConfiguration>({
            // The Configuration values are sent to the Provider Blade to be edited by the user.
            supplyInitialData: () => {
                return configuration.getValues();
            },

            // The edited Configuration values are returned from the Provider Blade and updated in this Part.
            // Any edits will cause 'onInputsSet' to be called again, since this is the method where the Part receives a new, consistent
            // set of inputs/settings.
            receiveResult: (result) => {
                configuration.updateValues(result);
            }
        });

        bladeRef.metadata = {
            isContextBlade: true
        };

        return bladeRef;
    }
});

```

1.  Also send the settings to the `onInputsSet` method.

    ```typescript

public onInputsSet(inputs: Def.TemplateBladeWithSettingsViewModel.InputsContract, settings: Def.TemplateBladeWithSettingsViewModel.SettingsContract): MsPortalFx.Base.Promise {
    // Any changes to the  Configuration values (see 'updateValues' above) will cause 'onInputsSet' to be called with the
    // new inputs/settings values.
    this._colorSetting(settings && settings.content && settings.content.colorSettingValue || BackgroundColor.Default);
    this._fontSetting(settings && settings.content && settings.content.fontSettingValue || FontStyle.Default);

    return null;
}

```

<a name="advanced-template-blade-topics-displaying-unauthorized-ui"></a>
### Displaying Unauthorized UI

You can set the blade to Unauthorized UI using the `unauthorized` member of the blade container. The code that describes how to set the blade is located at  `<dir>/Client/V1/Blades/Unauthorized/ViewModels/UnauthorizedBladeViewModel.ts`.

The following code does this statically, but it can also be done dynamically, based  on a condition after data is loaded.

```typescript

constructor(container: MsPortalFx.ViewModels.ContainerContract,
            initialState: any,
            dataContext: BladesArea.DataContext) {
    super();
    this.title(ClientResources.bladeUnauthorized);
    this.subtitle(ClientResources.bladesLensTitle);

    //This call marks the Blade as unauthorized, which should display a specialized UI.
    // container.unauthorized();

    // Or display a specialized UI with a customized message
    container.unauthorized(ClientResources.bladeUnauthorizedCustomizedMessage);
}

```

<a name="advanced-template-blade-topics-dynamically-displaying-notice-ui"></a>
### Dynamically displaying Notice UI

You can set the blade to the Notice UI using `enableNotice` member of the blade container. The code that describes how to set the blade is located at  `<dir>Client/V1/Blades/DynamicNotice/ViewModels/DynamicNoticeViewModels.ts`.

Enabling the blade can be done statically with the constructor, or it can be done dynamically. In the following example, the blade is set to Notice UI if the **id** input parameter has a specific value.

```typescript

public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
    this.title(inputs.id);

    if (inputs.id === "42" || inputs.id === "43") {
        // to simulate the response from service and enable notice accordingly.
        return Q.delay(1000).then(() => {
            this._container.enableNotice({
                noticeTitle: ClientResources.comingSoonTitle,
                noticeHeader: ClientResources.comingSoon.format(inputs.id),
                noticeDescription: ClientResources.comingSoonDescription,
                noticeCallToActionText: ClientResources.comingSoonAction,
                noticeCallToActionUri: ClientResources.microsoftUri,
                noticeImageType: MsPortalFx.ViewModels.Controls.Notice.ImageType.ComingSoon
            });
        });
    } else {
        return null;
    }
}

```

 ## Menu Blade

Menu blades are rendered as a menu on the left side of the screen. Each item that is referenced from the menu is rendered using the same header as the menu, resulting in the two blades being displayed as one blade.  This is similar to what the resource menu blade does.

The process is as follows.

1. Menu blade is displayed as a menu (list of items), where each items opens a blade when clicked
1. The menu blade is rendered to the left of the screen
1. The blades opened from the menu share the chrome with the menu blade 

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

Menu blades are defined in the PDL file in the following code.  The code is also located at `<dir>\Client/V1/Blades/MenuBlade/MenuBlade.pdl`.

```xml

<MenuBlade
  Name="PdlSampleMenuBlade"
  ViewModel="SampleMenuBlade" />

```

The following code demonstrates how to define a menu blade ViewModel to open four different items.

```typescript

export class SampleMenuBlade extends FxMenuBlade.ViewModel {
    constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: DataContext) {
        super(container);
        this.title(ClientResources.SampleMenuBlade.title);
        this.icon(FxImages.Gear());

        const resourceName = "roturn600";
        this.menu.groups([
            {
                id: "enginesgroup",
                displayText: ClientResources.AssetTypeNames.Engine.singular,
                items: [
                    // Menu item that demonstrates opening of a blade from a different extension
                    {
                        id: "browserelated",
                        displayText: ClientResources.SampleMenuBlade.relatedResources,
                        icon: null,
                        supplyBladeReference: () => {
                            return new HubsBladeReferences.MapResourceGroupBladeReference({
                                id: "/subscriptions/sub123/resourcegroups/snowtraxpxz",
                            });
                        },
                    },
                    // Menu item that demonstrates opening of a parameter collector blade for a create scenario
                    {
                        id: "createengine",
                        displayText: ClientResources.createEngine,
                        icon: null,
                        supplyBladeReference: () => {
                            return new BladeReferences.CreateEngineV3BladeReference({
                                supplyInitialData: () => {
                                    return {
                                        model: "Azure Engine 3.0",
                                    };
                                },
                                supplyProviderConfig: () => {
                                    return {
                                        provisioningConfig: {
                                            provisioningEnabled: true,
                                            galleryCreateOptions: CreateEngine.galleryCreateOptions,
                                            startboardProvisioningInfo: CreateEngine.startboardProvisioningInfo,
                                        },
                                        createEngineOptions: CreateEngine.createEngineOptions,
                                    };
                                },
                                receiveResult: result => {
                                    // Intentionally blank. The launched blade is responsible for the create operation.
                                }
                            });
                        },
                    },
                    // Menu item that demonstrates opting out of full width.
                    {
                        id: "fullwidthoptout",
                        displayText: ClientResources.SampleMenuBlade.optOut,
                        icon: null,
                        supplyBladeReference: () => {
                            return new BladeReferences.BladeWidthSmallBladeReference({bladeTitle: ClientResources.SampleMenuBlade.optOut});
                        },
                    },
                    // Menu item that demonstrates a blade that can have activated width.
                    {
                    id: "activationSample",
                        displayText: ClientResources.ActivationStyleBlade.title,
                        icon: null,
                        supplyBladeReference: () => {
                            return new BladeReferences.BladeWithActivationStyleReference();
                        },
                    }
                ],
            },
            {
                id: "group2",
                displayText: "Group #2",
                items: [
                    {
                        id: "unauthorizedblade",
                        displayText: ClientResources.bladeUnauthorized,
                        icon: null,
                        supplyBladeReference: () => new BladeReferences.UnauthorizedBladeReference(),
                    },
                    {
                        id: "bladeWithSummary",
                        displayText: resourceName,
                        icon: null,
                        supplyBladeReference: () => new BladeReferences.EngineBladeReference({
                            id: `/subscriptions/sub123/resourcegroups/snowtraxpxz/providers/Providers.Test/statefulIbizaEngines/${resourceName}`,
                        }),
                    },
                ],
            },
        ]);
        this.menu.setOptions({
            defaultId: "browserelated",
            // You can also specify an overview item over here. That would show up right at
            // the top of the menu right below the search box. See the SDKMenuBladeViewModel.ts
            // as an example. This sample intentionally doesn't specify the overview item to
            // test the case where no overview is specified.
        });
    }
}

```

There are a few things to notice in the preceding code.

* Menus can have different groups. In this code there are two groups
* Each menu item opens a blade, and all necessary parameters are provided
* Menu items can integrate with `EditScope` and `ParameterProvider`, as displayed in the `createengine` item
* At the end of the constructor, options for the menu are set. The option set defines the `id` of the default item.

You can view a working copy of the MenuBlade  in the Dogfood environment sample located at [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/PdlSampleMenuBlade/browserelated](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/PdlSampleMenuBlade/browserelated).
 
 
<a name="advanced-template-blade-topics-introduction"></a>
## Introduction

Blade Kinds are implementations of blades that offer a consistent UI and are easily implemented. Blade Kinds provide a simplified programming model with a closed UI.  The main advantage of blade kinds is simplicity. When the Blade Kinds for an extension are updated, developers can use the updates and the layout without having to change extension implementations. One type of blade kind, the Quick start blade kind, is depicted in the following image.

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

<a name="advanced-template-blade-topics-introduction-quickstart-blade"></a>
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

 
<a name="advanced-template-blade-topics-introduction-properties-blade"></a>
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

<a name="advanced-template-blade-topics-introduction-notice-blade"></a>
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

 
<a name="advanced-template-blade-topics-introduction-setting-list-blade"></a>
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

<a name="advanced-template-blade-topics-introduction-framework-settings"></a>
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

<a name="advanced-template-blade-topics-introduction-framework-settings-tags-and-rbac"></a>
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

<a name="advanced-template-blade-topics-introduction-framework-settings-support-settings"></a>
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


 
<a name="advanced-template-blade-topics-appblades"></a>
## AppBlades

AppBlade provides an IFrame where an extension can render content, which results in maximum flexibility and reduces additional developer responsibilities. We recommend using AppBlades under the following conditions.

* An existing extension that should be migrated to Ibiza without needing to be re-implemented 
* Developers want to implement user interactions and experiences that are not supported by Ibiza Framework components
*  An existing extension needs to be re-hosted in several environments

When using AppBlade, developers are responsible for the following.

* Accessibility

    Making the blade accessible, as specified in [portalfx-accessibility.md](portalfx-accessibility.md)

* Theming

    The extension should respond to theming behavior

* Consistent Look & feel

    Designing a visual experience that is consistent with the rest of Ibiza

* Controls

    Building your own controls, or using available alternatives to Ibiza Fx controls

<a name="advanced-template-blade-topics-creating-an-appblade"></a>
## Creating an AppBlade

1. Add the blade definition to your PDL file, as in the following example.

    ```xml
    <AppBlade Name="MicrosoftDocs"
            ViewModel="{ViewModel Name=MicrosoftDocsBladeViewModel, Module=./Summary/ViewModels/MicrosoftDocsBladeViewModel}"
            InitialDisplayState="Maximized">
    </AppBlade>
    ```

1. Create a ViewModel TypeScript class. The following code snippet displays the ViewModel for the template blade defined in the previous step. In this case, it is showing the docs.microsoft.azure.com by using  an AppBlade in the Portal.

    ```javascript
    export class MicrosoftDocsBladeViewModel extends MsPortalFx.ViewModels.AppBlade.ViewModel {
        constructor(container: FxViewModels.ContainerContract, initialState: any, dataContext: any) {

            super(container, {
                source: 'https://docs.microsoft.com/'
            });

            this.title("docs.microsoft.com");
        }
    }
    ```

**NOTE**: The source location for the contents of the IFrame is sent to the container by using the `source` property.

<a name="advanced-template-blade-topics-the-ibiza-command-bar"></a>
## The Ibiza command bar

The Ibiza command bar can optionally be used in an AppBlade to leverage Framework support and make Azure navigation a more consistent experience. To use a command bar, add it to the PDL file for the extension PDL and configure it in the AppBlade ViewModel, as in the following example.

```typescript

// You can add command bars to app blades.
this.commandBar = new Toolbar(container);
this.commandBar.setItems([this._openLinkButton()]);

```

There should also be a command button on the command bar, as in the following example.

```typescript

private _openLinkButton(): Toolbars.OpenLinkButton {
    var button = new Toolbars.OpenLinkButton("http://microsoft.com");

    button.label(ClientResources.ToolbarButton.openLink);
    button.icon(MsPortalFx.Base.Images.Hyperlink());

    return button;
}

```

<a name="advanced-template-blade-topics-sending-messages-between-the-iframe-and-ibiza-fx"></a>
## Sending messages between the IFrame and Ibiza Fx

The AppBlade ViewModel is hosted in the hidden IFrame in which the extension is loaded. However, the contents of the AppBlade are hosted in different IFrame that is visible on the screen. The Ibiza extension IFrame and the UI IFrame communicate by sending and receiving messages. The following sections demonstrate how to exchange messages between the two IFrames and to the Portal.

<a name="advanced-template-blade-topics-ibiza-extension-iframe-messaging"></a>
## Ibiza extension IFrame messaging

* Listen to a message

    The extension can listen to messages that are sent from the UI IFrame to the Ibiza extension ViewModel by using the **on** method in the **AppBlade** ViewModel, as in the following example.

```typescript

// This is an example of how to listen for messages from your iframe.
this.on("getAuthToken", () => {
    // This is an example of how to post a message back to your iframe.
    MsPortalFx.Base.Security.getAuthorizationToken().then((token) => {
        let header = token.header;
        let message = new FxAppBlade.Message("getAuthTokenResponse", header);

        this.postMessage(message);
    });
});

```

*  Post a message

    The Ibiza extension ViewModel can post messages to the UI IFrame by using the **postMessage** method in the AppBlade ViewModel, as in the following example.

```typescript

// This is another example of how to post a message back to your iframe.
this.postMessage(new FxAppBlade.Message("favoriteAnimal", "porcupine"));

```

<a name="advanced-template-blade-topics-ui-iframe-messaging"></a>
## UI IFrame messaging

* Listen to a message

    The extension can listen for messages that are sent from the Ibiza extension ViewModel to the UI Frame by adding an event listener to the application window, as shown in the following code.

```xml

window.addEventListener("message", receiveMessage, false);

```

    The extension should also provide a handler for the incoming message. In the following example, the **receiveMessage** method handles three different incoming message types, and reacts to theming changes in the Portal.

```xml

// The message format is { signature: "pcIframe", data: "your data here" }
function receiveMessage(event) {
    // It is critical that we only allow trusted messages through. Any domain can send a message event and manipulate the html.
    // It is recommended that you enable the commented out check below to get the portal URL that is loading the extension.
    // if (event.origin.toLowerCase() !== trustedParentOrigin) {
    //     return;
    // }

    if (event.data["signature"] !== "FxAppBlade") {
        return;
    }
    var data = event.data["data"];
    var kind = event.data["kind"];

    if (!data) {
        return;
    }

    var postMessageContainer = document.getElementById("post-message-container");
    var divElement = document.createElement("div");
    divElement.className = "post-message";

    var message;

    switch (kind) {
        case "getAuthTokenResponse":
            message = data;
            divElement.style.background = "yellow";
            break;
        case "favoriteAnimal":
            message = "My favorite animal is: " + data;
            divElement.style.background = "pink";
            break;
        case "theme":
            message = "The current theme is: " + data;
            divElement.style.background = "lightblue";
            break;
    }

    var textNode = document.createTextNode(message);

    divElement.appendChild(textNode);
    postMessageContainer.appendChild(divElement);
}

```

*  Post a message

    The  UI IFrame can post messages back to the Portal using the **postMessage** method. There is a required message that the  IFrame sends to the Portal to indicate that it is ready to receive messages.

    The following code snippet demonstrates how to post the  required message, in addition to posting other messages.

    ```xml

if (window.parent !== window) {
    // This is a required message. It tells the shell that your iframe is ready to receive messages.
    window.parent.postMessage({
        signature: "FxAppBlade",
        kind: "ready"
    }, shellSrc);

    // This is an example of a post message.
    window.parent.postMessage({
        signature: "FxAppBlade",
        kind: "getAuthToken"
    }, shellSrc);
}

```

## Changing UI themes

When using a template blade, extension developers can implement themes. Typically, the user selects a theme, which in turn is sent to the UI IFrame. The following code snippet demonstrates how to pass the selected theme to the UI IFrame using the **postMessage** method,  as specified in the section named [Exchanging messages between the IFrame and Ibiza Fx](#exchanging-messages-between-the-iframe-and-ibiza-fx).

```typescript

// Get theme class and pass it to App Blade
MsPortalFx.Services.getSettings().then(settings => {
    let theme = settings["fxs-theme"];
    theme.subscribe(container, theme =>
        this.postMessage(new FxAppBlade.Message("theme", theme.name))
    ).callback(theme());
});

```

 
### Introduction to Blades

A blade is the vertical container that acts as the starting point for any journey. You can define multiple blades, each containing their own collection of statically defined lenses and parts.

**NOTE**: Given the complexity associated with this model, we are encouraging authors to use TemplateBlades instead, as specified in [portalfx-extensions-blades-overview.md](portalfx-extensions-blades-overview.md).

![alt-text](../media/portalfx-extensions-helloWorld/helloWorldExtensionAlohaBlade.png "Blade")

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

Blades can be created in any PDL file, and they will be aggregated at compile time into the extension definition, as in the code located at `<dir>\Client\V1\Blades\Locked\Locked.pdl`. The code is also in the following example.

```xml
<Blade Name="LockedBlade"
       ViewModel="LockedBladeViewModel">
    <Lens>
        ...
    </Lens>
</Blade>
```

Blades use ViewModels to drive dynamic content, including titles, icons, and status.  To learn more about blades, start with the following topics:

* [Controlling blade UI](portalfx-blades-ui.md)
* [Opening blades](portalfx-blades-opening.md)
* [Blade parameters](portalfx-blades-parameters.md)
* [Blade properties](portalfx-blades-properties.md)
* [Blade outputs](portalfx-blades-outputs.md)
* [Pinning blades](portalfx-blades-pinning.md)
* [Blade Kinds](portalfx-blades-bladeKinds.md)
* [Closing blades](portalfx-blades-closing.md)

* * * 

* Controlling blade UI
 
## Blade UI

### Controlling blade UI

Blades support a variety of APIs which make it easy to customize their behavior and experience.

#### Title & Icon

The title, subtitle, and icon of a blade can be customized with a View Model. This allows making real time changes to the title and icon based on the status of the asset. The View Model for a blade is a simple interface:

`Client\Blades\Template\ViewModels\TemplateBladeViewModels.ts`

```ts
export class TemplateBladesBladeViewModel extends MsPortalFx.ViewModels.Blade {

    constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
        super();
        this.title(ClientResources.templateBladesBladeTitle);
        this.subtitle(ClientResources.samples);
        this.icon(MsPortalFx.Base.Images.Polychromatic.Info());
    }
}

```

In this case, the information in the view model will be hard coded. Finally, you're ready to reference the view model from PDL:

```xml
<Blade Name="TemplateBladesBlade"
       ViewModel="TemplateBladesBladeViewModel">
  <Lens>
    ...
  </Lens>
</Blade>
```

<!--
  Blade Content State
-->

#### Blade Content State

Blades have the ability to display a status at the top of the UI:

![Blade Status][blade-status]

The follow states are currently available:

* None
* Success
* Warning
* Error

The content state and its label are both set in the blade view model. They can be set initially, and changed at runtime to reflect the current state of the blade. For an example of using blade content states, view the following file in the samples:

`\Client\Blades\ContentState\ViewModels\ContentStateViewModels.ts`

```ts
this.contentState(MsPortalFx.Parts.ContentState.Success);
this.contentStateDisplayText("Success!");
```

<!--
  Locking
-->

#### Locking

Locking a blade will prevent users from pinning its parts to the start board, moving parts around, or resizing parts. It's particularly useful when building a list control, an input form, or a create experience.  If you need a locked blade you should use `<TemplateBlade />` as opposed to the classic `<Blade Locked="True" />`.  TemplateBlade has been designed to significantly simplify the locked blade programming model, specifically allows you to use: 

- a single TypeScript ViewModel for the entire blade and its content
- a single <TemplateBlade> PDL element that uses a html template
- significant reduction in the amount of PDL
- significant reduction in property binding complexity

For example to define a TemplateBlade with CommandBar in PDL use the following:

```xml
  <TemplateBlade Name="TemplateBladeWithCommandBar"
                 ViewModel="TemplateBladeWithCommandBarViewModel"
                 Template="{Html Source='..\Templates\SomeTemplate.html'}">
    <CommandBar />
  </TemplateBlade>
```

Contrast TemplateBlade with the classic `<Blade Locked="true"` approach:

```xml
<Blade Name="Samples" 
       Locked="True"
       ViewModel="SomeBladeVideModel">
  <Blade.Commands>
    <Command Text="{Resource saveText, Module=ClientResources}"
             ViewModel="SaveCommandViewModel">
    </Command>
  </Blade.Commands>
  <Lens Name="SomeLens">
    <CustomPart Name="SomeCustomPart"
                  Template="{Html Source='Templates\\SomeTemplate.html'}"
                  ViewModel="SomePartViewModel">
    </CustomPart>
  </Lens>
</Blade>
```

For complete examples of TemplateBlades see SamplesExtension `Client\Blades\Template\Template.pdl`

<!--
  Width
-->

#### Width

When creating blades, you can choose from multiple widths. The default is 'Medium':

* Small
* Medium
* Large
* XLarge
* Expandable

This is defined statically on the blade, and cannot be changed by the user. Small blades are useful for displaying lists of information. The Large and XLarge sizes are useful for blades with dense information which doesn't fit on a normal width blade (such as documentation).

`\Client\Blades\BladeWidth\BladeWidth.pdl`

```xml
<Blade Name="Samples"
       Width="Small">

    <Lens>
     ...
    </Lens>

</Blade>
```

<!--
  Initial Display State
-->

#### Initial Display State

When the user opens a blade, you can choose to have it open in the normal state, or in a maximized state:

* Maximized
* Normal

Users may always choose to restore the blade to its normal supported width. This is useful for blades which contain large amounts of information.

```xml
<Blade Name="Samples"
       InitialDisplayState="Maximized">
    <Lens>
     ...
    </Lens>
</Blade>
```

[blade]: ../media/portalfx-blades/blade.png
[blade-status]: ../media/portalfx-blades/blade-status.png

* Opening blades
 
#Blade opening and closing

This section describes how to open blades using the new (and recommended) container APIs as well as the older (not recommended) declarative APIs.

There is also a [live sample](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi) available.

## Strongly typed blade reference classes

When you compile your extension, a strongly typed blade reference class will be auto-generated for each blade in your system.  For example, if you have a blade called 'MyBlade', then a TypeScript class called 'MyBladeReference' will be generated in the _generated folder.  These blade reference classes can be used to open blades programmatically.
 
The BladeReference constructor accepts parameters such as Ids, as well as callback functions that allow the child blade to communicate backwards to the parent blade (shown later in the document).  Here is an example of how you would instantiate a blade reference that represents a website blade.

```javascript 
import { WebsiteBladeReference } from "../_generated/BladeReferences"; 
…
var bladeRef = new WebsiteBladeReference({
    parameters: { id: "_ARM_ID_HERE" }
});
```

Blade references are also generated for external extensions. The compiler creates a blade references module for every PDE file (Portal Definition Exports) you include.

If you want to open a blade in the a different extension you need to -
1. Ensure your project referencies the external extension's PDE file 
1. import the blade reference you desire from "../../_generated/<ExtesnionName>/BladeReference"

```javascript
import { LocationPickerV3BladeReference } from "../../_generated/HubsExtension/BladeReferences"
```

Blade references for parameter providers have a different signature that is nearly identical to the options that you provide to the ParameterCollector class.

## Opening blades (Recommended pattern)

These methods are now available on your template blade container.

```javascript
    // opens a blade right now
    openBlade(bladeToOpen: BladeReference): Promise<boolean>; 
     
    // displays the blade placeholder right now, but shows a spinner until the given promise resolves
    openBladeAsync(promiseToDetermineBladeToOpen: Promise<BladeReference>): Promise<boolean>; 
     
    // opens a context blade right now
    openContextBlade(bladeToOpen: BladeReference): Promise<boolean>; 
     
    // displays the context blade placeholder right now, but shows a spinner until the given promise resolves
    openContextBladeAsync(promiseToDetermineBladeToOpen: Promise<BladeReference>): Promise<boolean>; 
```

### Opening blades within the menu

When your template blade is in context of a menu blade (i.e. the child of a menu blade), these methods are available on the `menu` object within the `container` (PDL) or the `context` (no-PDL) object. 

> When using these APIs be aware your blade might be opened outside of the context of a menu blade and the 
> menu object will be null and you should account for that case by falling back to the standard blade opening 
> APIs.

```typescript
    /**
    * This method causes the menu blade to navigate to a different item
    *
    * @param id Identifier of the item to navigate too
    */
    switchItem(id: string): void;

    /**
    * Opens a child Blade in place.
    *
    * @param bladeToOpen A BladeReference describing the Blade to be opened.
    */
    openBlade(bladeToOpen: BladeReference): Promise<boolean>;

    /**
    * Opens a child Blade asynchronously in place.  While the Blade to be shown is being determined (via 'bladeReferencePromise') a loading
    * indicator will be displayed on the new child Blade.
    *
    * @param promiseToDetermineBladeToOpen A Promise that will be resolved with a BladeReference describing the Blade to be opened.
    */
    openBladeAsync(promiseToDetermineBladeToOpen: Promise<BladeReference>): Promise<boolean>;
```

Each of these methods returns a promise that generally returns true.  If there is a blade on the screen that has unsaved edits to a form, the framework will prompt the user, giving them the option to keep the unsaved blade open.  If the user chooses to continue working on their unsaved edits then the blade opening promise will return false.

For the Async methods, your code provides a promise.  If that promise fails (is rejected) then the promise returned from this API returns false.

## Click callbacks

In many cases, blade opening will be the result of a user interaction such as a click.  To support those scenarios many of our controls now support click callbacks.  You can use the blade opening APIs described above within these callbacks.  If the control you’re using supports highlighting the item that was clicked, such as the grid, then the highlight will be added to the click target automatically.  The highlight will be automatically cleared when the child blade closes.  Here are some examples:
 
### Button

Opens a blade when a button is clicked

```javascript
var button = new SimpleButton.ViewModel({
    // … skipping over other button options
    onClick: () => {
        container.openBlade(new SomeBladeReference(…));
    }
});
```

### Grid

Opens a blade when a row on a grid is clicked
``` javascript 
var grid= new Grid.ViewModel<Website, WebsiteId>({
    // … skipping over other grid options
    onRowClicked: (item: Website) => {
        container.openBlade(new SomeBladeReference(/* website id likely passed as an input here */));
    }
});
```

### Custom HTML

To open a blade when the user clicks on an HTML element, use the `fxclick` Knockout data-binding, like so:

```javascript
// Your html template
<a href="#" data-bind="fxClick: myOnClick">Click me!</a>
 
// Your template blade or part view model
public myOnClick(): void {
    container.openBlade(new SomeBladeReference(…));
}
```

In doing so, here are some best practices to follow:

##### DO

- Use standard `<a href="#">` tags when adding `fxclick` to open child blades. With this, your links will be accessible.

##### DO NOT

- Use `<div>` tags when adding `fxClick` to open child Blades. If you do this, you'll have to (unnecessarily) learn and apply additional HTML attributes to make your links accessible.

- Use the Knockout `click` data-binding to open child Blades. The `fxClick` data-binding was developed specifically to handle the async nature of the click communication between the Portal Shell IFrame and your extension's IFrame.

If you call any of the container.open* methods from within an fxclick handler then the `ext-msportalfx-activated` class will be automatically added to the html element that was clicked.
The class will be automatically removed when the child blade is closed.

### Declarative ways to open blades (Not recommended for new scenarios)

![Blade][blade]

#### Simple Blade Action (Not recommended for new scenarios)

The `<BladeAction>` tag provides the API required for opening a blade.  In the simplest of cases, the only required information is the name of the blade to launch:

`\SamplesExtension\Extension\Client\extension.pdl`

```xml
<Part Name="SamplesExtensionPart"
      PartKind="Button"
      ViewModel="{ViewModel Name=SamplesExtensionPartViewModel, Module=./ViewModels/SamplesViewModels}">
  <BladeAction Blade="SamplesExtensionBlade" />
</Part>
```

In the code snippet above, clicking on the part will launch the **SamplesExtensionBlade**.  The same pattern can be followed for commands:

`\SamplesExtension\Extension\Client\Commands\OpenBladeCommand\OpenBladeCommand.pdl`

```xml
<Command Kind="Blade"
       Name="OpenBladeCommand"
       Text="{Resource openBladeCommandNone, Module=ClientResources}"
       ViewModel="{ViewModel Name=OpenBladeCommand, Module=./OpenBladeCommand/ViewModels/OpenBladeCommandViewModels}">
  <BladeAction Blade="NoParameterChildBlade" />
</Command>
```

#### Passing parameters with BladeInput (Not recommended for new scenarios)

The cases above are trivial, in that no information is passed from the part or the command to the opened blade.  This will actually be an uncommon occurrence.  Usually, at the very least an {id} will be passed from the part to the blade. To pass information while launching a blade, a `<BladeInput>` is used:

`\SamplesExtension\Extension\Client\Bindings\InputBindingsDifferentBlades\InputBindingsDifferentBlades.pdl`

```xml
<CustomPart Name="ParentPart"
            ViewModel="{ViewModel Name=InputBindingsDifferentBladesParentPartViewModel, Module=./InputBindingsDifferentBlades/ViewModels/InputBindingsDifferentBladesViewModels}"
            Template="{Html Source='Templates\\Parent.html'}">

  <BladeAction Blade="InputBindingsDifferentBladesChildBlade">
    <BladeInput Parameter="currentNumber"
                Source="selectedItem" />
  </BladeAction>
</CustomPart>
```

The sample above instructs the Portal to open the `InputBindingsDifferentBladesChildBlade` blade, while passing a parameter named `currentNumber` to the blade.  The `selectedItem` property of the `InputBindingsDifferentBladesParentPartViewModel` view model will be used as the source of the argument passed to the blade.  To piece this all together:

* Blade - name of the blade to open
* Parameter - name of the blade parameter (argument) the `InputBindingsDifferentBladesChildBlade` is expecting to receive.
* Source - public observable property on the `InputBindingsDifferentBladesParentPartViewModel` view model which contains the information to pass to the new blade.
* content.* - this notes that the `selectedItem` property exists on the view model.  You may potentially also use container.*, which allows binding to properties available on the container object passed into the view model constructor.

The ViewModel for the part which launches the blade defines the `selectedItem` property which is used for the source:

`\SamplesExtension\Extension\Client\Bindings\InputBindingsDifferentBlades\ViewModels\InputBindingsDifferentBladesViewModels.ts`

```ts
/// <reference path="../../../TypeReferences.d.ts" />
import BindingsArea = require("../../BindingsArea");
import ClientResources = require("ClientResources");

export class InputBindingsDifferentBladesParentPartViewModel {

    /**
     * List of options provided in the template.
     */
    public availableOptions: any = [1, 2, 3, 4, 5];

    /**
     * The item selected from the other blade.
     */
    public selectedItem: KnockoutObservable<number> = ko.observable(1);

    /**
     * Part view model constructor.
     */
    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BindingsArea.DataContext) {
        container.partTitle(ClientResources.parentPart);

        this.selectedItem.subscribe((newValue) => {
            console.info(ClientResources.selectedItemChanged);
        });
    }
}
```

#### Blade Parameters (Not recommended for new scenarios)

Blades must explicitly declare which parameters they are required to receive.  Think of this as a function signature. There are [multiple types of parameters](portalfx-blades-parameters.md), each of which can serve a special purpose. In the examples above, a `<BladeInput>` defined a `Parameter` property - that parameter must match the name of a parameter available on the launched blade.  To learn more about blade parameters, check out the [full documentation](portalfx-blades-parameters.md).

`\SamplesExtension\Extension\Client\Bindings\InputBindingsDifferentBlades\InputBindingsDifferentBlades.pdl`

```xml
<Blade>
  ...
  <Blade.Parameters>

    <!--
      Typically a blade will have a key property (or set of key properties)
      that indicate uniqueness of the data within the blade.
     -->
    <Parameter Name="currentNumber" Type="Supplemental" />

  </Blade.Parameters>
</Blade>
```

The parameters passed to a blade can then be bound to parts, commands, or even the blade view model.  To learn more, visit [blade propertiess](portalfx-blades-properties.md).

#### Receiving data with BladeOutput (Not recommended for new scenarios)

In some cases, you may want to pass information from the current blade back to the parent blade. Blades can define a list of output properties that flow back to the calling blade. A common use for this binding is to return data from a child blade back to a part on its parent blade.

![Typical use of blade outputs][part-settings]

In this example, the parent blade defines a `BladeAction` which passes a `currentNumber` property to the child blade. This will allow changes in the View Model on the child blade to flow back to the view model on the parent blade.

`\SamplesExtension\Extension\Client\Bindings\OutputBindings\OutputBindings.pdl`

```xml
<CustomPart Name="ParentPart"
            ViewModel="{ViewModel Name=OutputBindingsParentPartViewModel,
                                  Module=./OutputBindings/ViewModels/OutputBindingsViewModels}"
            Template="{Html Source='Templates\\Parent.html'}">

  <BladeAction Blade="OutputBindingsChildBlade">
    <BladeOutput Parameter="currentNumber"
                 Target="currentNumber" />
  </BladeAction>
</CustomPart>
```

In the code above, the `onInputsSet` method of the `OutputBindingsParentPartViewModel` will be invoked when the `currentNumber` blade parameter changes in the child blade.

* Parameter - the name of the blade parameter passed to `OutputBindingsChildBlade`

* Target - the name on the `inputs` argument passed to the `onInputsSet` method of the `OutputBindingsParentPartViewModel` view model.

> [WACOM.NOTE] When the value of a blade output changes, the `onInputsSet` method of the part view model will be invoked.  The `inputs` object will contain the value of the output binding, which may not have been available when the first time `onInputsSet` is invoked.  This is one of the cases where `onInputsSet` is called multiple times for a given view model.

Learn more about [blade outputs](portalfx-blades-outputs.md).

#### Grids, CollectionParts, and ListViews 

Controls which are bound to a collection of elements (like the grid) can make the selection model a little more nuanced.  In most cases, the control will pass blade inputs which are defined by a property on the model object bound to the control:

`\SamplesExtension\Extension\Client\Data\MasterDetailBrowse\MasterDetailBrowse.pdl`

```xml
<Part Name="MasterBrowseListPart"
      ViewModel="{ViewModel Name=BrowseMasterListViewModel, Module=./MasterDetailBrowse/ViewModels/MasterViewModels}"
      PartKind="Grid">
  <BladeAction Blade="BrowseDetailBlade">
    <BladeInput Parameter="currentItemId"
                Source="{SelectedItem Property=id}" />
  </BladeAction>
</Part>
```

The new twist in the syntax is `Source="{SelectedItem Property=id}`.  This will identify the `id` property on the model object bound to the grid.  In this example, the `id` property is available on the `Website` model object, which is bound to the grid.  The grid only needs to declare itself as selectable:

```ts
private _websitesQueryView: MsPortalFx.Data.QueryView<SamplesExtension.DataModels.WebsiteModel, MasterDetailBrowseData.WebsiteQuery>;

...

var extensions = MsPortalFx.ViewModels.Controls.Lists.Grid.Extensions.SelectableRow,
    extensionsOptions = {
        selectableRow: {
            selectionMode: MsPortalFx.ViewModels.Controls.Lists.Grid.RowSelectionMode.Single,
            activateOnSelected: ko.observable<boolean>(true),
        }
    };

    super(this._websitesQueryView.items, extensions, <any>extensionsOptions);
```

#### Supporting nested selectables (Not recommended for new scenarios)

In rare cases, your part may be select both by clicking the part, and by clicking on an item within the part.  The classic example of this interaction is the `CollectionPart`:

`\SamplesExtension\Extension\Client\Parts\Intrinsic\CollectionPart\CollectionPartIntrinsicInstructions.pdl`

```xml
<Part Name="SelectableCollectionPartLarge"
      PartKind="Collection"
      ViewModel="{ViewModel Name=SelectableCollectionPartViewModel, Module=./Intrinsic/ViewModels/CollectionPartViewModel}">
  <BladeAction Blade="CollectionDetailsBlade">
    <BladeInput
        Parameter="title"
        Source="rollupCount" />
  </BladeAction>
  <BladeAction
      Blade="ItemDetailsBlade"
      SelectableSource="selectableData">
    <BladeInput
        Parameter="title"
        Source="{SelectedItem Property=ssnId}" />
  </BladeAction>
</Part>
```

There are two separate `<BladeAction>` elements defined for this part.  The `CollectionDetailsBlade` is launched when the part is clicked, passing only a simple parameter which is available from the view model.  The `ItemDetailsBlade` is launched when clicking on a row in the collection part.  The `SelectableSource` defines the direct path to the selectable object on the Collection Part view model.

#### Launching blades from another extension (Not recommended for new scenarios)

When using `<BladeAction>`, you're generally going to be launching blades from your own extension.  In some cases, you may [import a part from another extension](portalfx-extension-sharing-pde.md).  Using this technique, the source of the shared part will control launching of the blade.  However - in some cases you may want to launch a blade from another extension using a part from the current extension.  This is where `BladeReference` is useful.

## The PDE File

You may not have noticed, but every time you build your project you're generating a .PDE file inside of the `\Client\_generated` directory. The PDE file contains a list of the parts which are exposed in the global scope, along with a few other pieces of metadata:

```json
{
  "extension": "HubsExtension",
  "version": "1.0",
  "sdkVersion": "1.0.8889.122 (rd_auxweb_n_f1(tomcox).130919-1440)",
  "schemaVersion": "0.9.1.0",
  "assetTypes": [
    {
      "name": "TagsCollection",
      "permissions": []
    }
    ...
  ],
  "parts": [
    {
      "name": "ChangeLogPart",
      "inputs": []
    },
    ...
  ],
  "blades": [
    {
      "name": "TagCollectionBlade",
      "keyParameters": [],
      "inputs": [],
      "outputs": []
    },
    ...
  ]
}
```

To share parts, blades, or asset types with another extension, **both extensions must be running in the same portal**. The sharing of parts occurs at runtime, which requires that both extensions be present within the shell for this technique to work.

## Importing the PDE file

After you've generated the PDE file, it needs to be added to the project of the extension that wishes to consume your parts. First, add the file to your project. Next, you need to make a manual change to your .csproj file. Instead of using the `<Content>` compile action, you need to change it to `<ExtensionReference>`. Right click on your project file, and choose 'Unload Project'. Next, right click the project file again, and choose 'Edit'. Find the PDE file reference, and change the compile action:

```xml
<ExtensionReference Include="Client\References\HubsExtension.pde" />
```

Save the file, right click on your project file, and choose 'Reload Project'.


##### Consuming the blade (Not recommended for new scenarios)

To launch the blade referenced by the PDE file, use a `<BladeAction>` as usual, but specifying the extension:

'\Client\ResourceTypes\ResourceTypes.pdl'

```xml
<BladeAction Blade="{BladeReference ResourceMapBlade, extensionName=HubsExtension}">
  <BladeInput
      Source="assetOwner"
      Parameter="assetOwner" />
  <BladeInput
      Source="assetType"
      Parameter="assetType" />
  <BladeInput
      Source="assetId"
      Parameter="assetId" />
</BladeAction>
```

#### Dynamic Blade Action (Not recommended for new scenarios)

In the examples above, the target blade to be launched is known at design time.  In some cases, the blade to launch may not be known until runtime.  To define the blade at runtime, use `<DynamicBladeAction>`:

`\SamplesExtension\Extension\Client\Blades\DynamicBlade\DynamicBlade.pdl`

```xml
<CustomPart Name="DynamicBladePart"
            ViewModel="{ViewModel Name=DynamicBladePartViewModel, Module=./DynamicBlade/ViewModels/DynamicBladePartViewModel}"
            Template="{Html Source='..\\..\\Common\\Templates\\PartWithTitle.html'}"
            InitialSize="Small">
  <DynamicBladeAction SelectableSource="container.selectable.value" />
</CustomPart>
```

Notice the `DynamicBladeAction` does not designate a target blade.  However - it does ask for the path to a `selectable` object.  Selectables are an advanced aspect of the API, which is generally abstracted for the extension developer.  In this case, we are targeting the selectable that belongs to the **entire part**.  You can also target selectables that belong to specific control view models.

The view model in this case will define the blade to launch at runtime.  When the state of the part changes, the `selectedValue` property of the selectable can be modified to accept a `DynamicBladeSelection` object:

`\SamplesExtension\Extension\Client\Navigation\DynamicBlades\ViewModels\DynamicBladesViewModels.ts`

```ts
import ExtensionDefinition = require("../../../_generated/ExtensionDefinition");

...

this._container.selectable.selectedValue(<MsPortalFx.ViewModels.DynamicBladeSelection>{
    detailBlade: ExtensionDefinition.BladeNames.bladeName,
    detailBladeInputs: {
        // If your blade expects inputs (these do not), you could pass the inputs here.
    }
});
```

The code above can be executed anytime the target blade will change.  This will not trigger the launching of the blade, simply change that blade to launch when the user clicks on the part (or command, or hotspot, etc).  The `ExtensionDefinition.BladeNames` object above contains a strongly typed list of available blades in the extension.

> [WACOM.NOTE] Dynamic blade selection should be avoided, unless there is a strict requirement for determining the blade at runtime.  Static definitions allow for better compile time checking of names and inputs.  Also, blade outputs are not supported when using dynamic blade selection.

This method can also be used to launch a blade from another extension, using the 'extension' property of `DynamicBladeSelection`.

#### Hotspots (Not recommended for new scenarios)

When building [custom parts](portalfx-parts.md#parts-a-k-a-tiles-how-to-create-a-custom-part-where-you-define-the-look-and-feel-as-well-as-the-data-loading), you may want to launch a blade from a div, button, or `<a>` tag. To launch a blade, start with a `pcHotSpot` binding in your HTML template:

`\SamplesExtension\Extension\Client\ParameterCollection\CollectorAsHotSpot\Templates\CompositePart.html`

```html
<div data-bind="pcHotSpot: hotSpotSelectable">
  Click me [<span data-bind='text: hotSpotValue'></span>]GB
</div>
```

The `hotSpotSelectable` property needs to be a public property on your part view model of type `MsPortalFx.ViewModels.Selectable<boolean>`:

`\SamplesExtension\Extension\Client\ParameterCollection\CollectorAsHotSpot\ViewModels\CompositePartHotSpotViewModel.ts`

```ts
/**
 * Selectable for the hot spot.
 */
public hotSpotSelectable: MsPortalFx.ViewModels.Selectable<boolean>;

constructor(container: MsPortalFx.ViewModels.PartContainerContract,
            initialState: any,
            dataContext: ParameterCollectionArea.DataContext) {

    // Initialize the alphaSelectable
    this.hotSpotSelectable = new MsPortalFx.ViewModels.Selectable<boolean>({
        isSelected: !!(initialState && initialState.alphaSelectable && initialState.alphaSelectable.isSelected),
        selectedValue: !!(initialState && initialState.alphaSelectable && initialState.alphaSelectable.isSelected)
    });
}
```

The selectable object must be referenced from your PDL, hooking up the blade action to the selectable:

`\SamplesExtension\Extension\Client\ParameterCollection\ParameterCollection.pdl`

```xml
<BladeAction Blade="ParameterProviderFormBlade" SelectableSource="hotSpotSelectable" />
```

#### Advanced selection (Not recommended for new scenarios)

In some cases, you may have scenarios where the list of selectable items are not known up front.  Generally, you can point at a single selectble control or selectable set control.  Some cases are a little problematic:

* A grid that contains other grids
* A grid with hotspots inside of it
* A List view with tree views

In these rare cases, you may need to inform the shell of other controls which are not known at design time.  These controls (hotspots, grids, buttons) are generated dynamically.  For example, in this case there are many hotspot objects which will support selection:

`\SamplesExtension\Extension\Client\Bindings\DynamicSelectableRegistration\Templates\DynamicHotSpots.html`

```html
<div data-bind="foreach: hotspots">
    <div data-bind="pcHotSpot: selectable">
        <span data-bind="text: label"></span>
    </div>
</div>
```

For each hotspot generated above, the shell needs to know which blade to launch.  This is accomplished by using the `container.regsiterSelectable` API:

`\SamplesExtension\Extension\Client\Bindings\DynamicSelectableRegistration\ViewModels\DynamicHotspots.ts`

```ts
var lifetime = this._container.createChildLifetime(),
    selectable = MsPortalFx.ViewModels.Part.createSelectableViewModel(),
    id = SelectableIdPrefix + this.hotspots().length,
    label = "Hotspot #" + (this.hotspots().length + 1);

// a registered selectable requires unique id.
// the id is used to save and restore the selectable state when the journey is restored
this._container.registerSelectable(lifetime, id, selectable);

// set the blade selector which describes which blade we want to open when this hotspot is clicked
selectable.selectedValue(<MsPortalFx.ViewModels.DynamicBladeSelection>{
    detailBlade: ExtensionDefinition.BladeNames.hotspotChildBlade,
    detailBladeInputs: {
        HotspotId: label
    }
});

// finally add it to our list of hotspots that is displayed
this.hotspots.push({
    label: label,
    selectable: selectable,
    lifetime: lifetime
});
```

The same API can be applied to grids, list views, buttons, or any control that exposes a selectable or selectableSet object.



* Blade parameters
 
### Blade Parameters

Blades must explicitly declare which parameters they are required to receive.  Think of this as a function signature. There are multiple types of parameters, each of which can serve a special purpose.

#### Key Parameters

Key parameters define properties which act as the primary key for the blade. A common example may be "Website Id: 42" for a given blade. Often, a blade will have a single input which defines this identifier. Key properties are used as a key in the shell to save user settings like the layout of the blade, part sizes, part state, etc.

```xml
<Blade>
  ...
  <Blade.Parameters>

    <!--
      Typically a blade will have a key property (or set of key properties)
      that indicate uniqueness of the data within the blade.
     -->
    <Parameter Name="WebsiteId" Type="Key" />

  </Blade.Parameters>
</Blade>
```

#### NewEditScope Parameters

For parts which provide form editing capabilities, they often need to request an editScopeId. Previously, developers were required to provide a name for this input, and go through some trials to access the Id. It is now provided as a simple input which can be accessed view the `editScopeId` BladeParameter.

```xml
<Blade>
  ...
  <Blade.Parameters>
    <!--
      EditScopes are a special kind of input. They are generated from the shell,
      and are not passed via a blade binding.
    -->
    <Parameter Type="NewEditScope" />
  </Blade.Parameters>
</Blade>
```

#### Output Parameters

Output parameters provide the ability to receive an input from a child blade. Functionally little has changed with output bindings, but now they are a special defined type of input:

```xml
<Blade>
  ...
  <Blade.Parameters>
    <!--
      Output parameters are not set at invocation time, and cannot be keys or edit scopes.
    -->
    <Parameter Name="queryMetricId" Type="Output" />
  </Blade.Parameters>
</Blade>
```

#### Supplemental Parameters

Supplemental parameters provide no special function, and are not a key, but are used as additional data required by the part.

```xml
<Blade>
  ...
  <Blade.Parameters>

    <!--
      Supplemental inputs provide non-key parameters from launching blade. These may
      come from a different part on the launching blade.
    -->
    <Parameter Name="checkBoxValue" Type="Supplemental" />

  </Blade.Parameters>
</Blade>
```


* Blade properties
 
### Blade Properties

Blades use blade view models to manage the display information. This includes information like the title, subtitle, icon, and status. To acquire this data, often the extension will load an object by Id. Information passed into the blade as a `BladeParameter` can be passed to the blade view model via a `<Property>` element. For an example, refer to this file in the samples:

```
\Client\Hubs\Browse\Browse.pdl
```

```xml
<Blade Name="RobotBlade" ViewModel="RobotBladeViewModel">
  <Blade.Parameters>
    <Parameter Name="id" Type="Key"/>
  </Blade.Parameters>

  <Blade.Properties>
    <Property Name="name" Source="{BladeParameter Name=id}"/>
  </Blade.Properties>
  ...
</Blade>
```

In this example an `id` property is passed into the blade as a parameter, and then the `name` property is passed into the blade view model. The blade view model may subscribe to changes in this value, and update the blade information as required. For an example, refer to this file in the samples:

`\Client\Hubs\Browse\ViewModels\RobotBladeViewModel.ts`

```ts
module SamplesExtension.Hubs {
    /**
     * Represents the view model used by the robot blade.
     */
    export class RobotBladeViewModel extends MsPortalFx.ViewModels.Blade {

        /**
         * The name property is provided by an input binding to the blade.
         */
        public name = ko.observable("");

        /**
         * When the name is passed, bind it to the blade title. You could also choose
         * to grab the whole robot and use other pieces of its data (see RobotPartViewModel)
         */
        constructor(initialValue: any, dataContext: DataContext) {
            super();
            this.subtitle(SamplesExtension.Resources.Strings.hubsLensTitle);
            this.icon(MsPortalFx.Base.Images.Polychromatic.Gears());

            this.title = ko.computed((): string => {
                var title = SamplesExtension.Resources.Strings.loadingText;

                if (this.name() !== "") {
                    title = SamplesExtension.Resources.Strings.robotTitle + ": " + this.name();
                }

                return title;
            });
        }
    }
}
```

When changes are made to the `name` property on the view model, the `title` is updated on the blade.

### Blade Property Bindings

In most cases, parts will bind to `{BladeParameter}` values passed into the blade. In some cases, you may want to bind directly to a value on a blade view model. The most common use of this binding is to transform a value from a `{BladeParameter}` into some other form.
  Consider the following blade view model:

`\Client\Blades\Properties\ViewModels\BladePropertyViewModels.ts`

```ts
/**
 * The blade view model for blade Properties.
 */
export class BladePropertiesBladeViewModel extends MsPortalFx.ViewModels.Blade {

    /**
     * The temperature in celcius is calculated as a public property, used by a part.
     */
    public tempInCelcius: KnockoutComputed<number>;

    private _tempInFahrenheit = ko.observable(0);

    /**
     * View model constructor.
     */
    constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: DataContext) {
        super();
        this.title(SamplesExtension.Resources.Strings.bladePropertiesBladeTitle);
        this.icon(MsPortalFx.Base.Images.Polychromatic.Gears());

        this.tempInCelcius = ko.computed<number>(() => {
            return Math.round((this._tempInFahrenheit() - 32) * (5/9));
        });
    }

    /**
     * When the temperature in F is passed in, trigger the computed to calculate it in C
     */
    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        this._tempInFahrenheit(inputs.tempInFahrenheit);
        this.title(SamplesExtension.Resources.Strings.bladePropertiesBladeTitle + " - " + inputs.tempInFahrenheit + " deg F");
        return null;
    }
}
```

The view model accepts an input of temperature in fahrenheit, and projects a new property of temperature in celcius. A part on this blade can bind to the public `tempInCelcius` property:

`\Client\Blades\Properties\BladeProperties.pdl`

```xml
<CustomPart Name="PropertyButtonPart"
            ViewModel="PropertyButtonPart"
            Template="{Html Source='Templates\\Temperature.html'}">
  <CustomPart.Properties>
    <!--
      This part accepts an input via a public property on the blade view model.
      These bindings are called BladeProperty bindings.
    -->
    <Property Name="tempInCelcius"
              Source="{BladeProperty content.tempInCelcius}" />
  </CustomPart.Properties>
</CustomPart>
```


* Blade outputs
 
### Blade Outputs

In some cases, you may want to pass information from the current blade back to the parent blade. Blades can define a list of output properties that flow back to the calling blade. A common use for this binding is to return data from a child blade back to a part.

![Typical use of blade outputs][part-settings]

In this example, the parent blade defines a `BladeAction` which passes an `id` property to the child blade. This will allow changes in the View Model on the child blade to flow back to the view model on the parent blade.

`\SamplesExtension\Extension\Client\Bindings\OutputBindings\OutputBindings.pdl`

```xml
<CustomPart Name="ParentPart"
            ViewModel="{ViewModel Name=OutputBindingsParentPartViewModel,
                                  Module=./OutputBindings/ViewModels/OutputBindingsViewModels}"
            Template="{Html Source='Templates\\Parent.html'}">

  <BladeAction Blade="OutputBindingsChildBlade">
    <BladeOutput Parameter="currentNumber"
                 Target="currentNumber" />
  </BladeAction>
</CustomPart>
```

In the snippet above, `OutputBindingsChildBlade` will be opened with a `currentNumber` parameter.  The child blade will be responsible for setting the value on the output binding.  After that value is set, `onInputsSet` of the part will be invoked, this time with a value named `currentNumber`.





* Pinning blades 

### Pinning blades

By default, all blades and parts are 'pinnable'.  Pinning a blade creates a part on the currently active dashboard.

Every blade in the portal has a default representation. The default part for a blade uses a [button part](portalfx-parts-intrinsic.md).  The title, subtitle, and icon provided in the blade view model provide the data needed to create the default view.

#### Creating a custom pinned part

While the default pinned part is often sufficient, there are a few places where you may want to show a custom part representation.  

To use a custom pinned part, it's as easy as

`\SamplesExtension\Extension\Client\extension.pdl`

```xml
<!--
	Create a part in the <definition> element, making it available
	in the catalog.
-->
<Part Name="SDKPartType"
      ViewModel="SDKPartViewModel"
      PartKind="Button">
  <BladeAction Blade="SDKBlade"/>
</Part>

<Blade Name="SDKBlade"
  	   ViewModel="SDKBladeViewModel">
  <!--
  	The pinned part tag simply refers to a part already in the catalog.
  -->
  <PinnedPart PartType="SDKPartType" />
  ...
</Blade>
```

In the simple example above, the part in the catalog does not require inputs.  In the event that the part does require an input, the inputs must match the properties passed into the blade view model.  To learn more, check out [building pinnable parts](portalfx-parts-pinning.md).

#### Preventing pinning

There are some cases where a blade should not be pinned.  Those generally include:

* Create flows
* Editable forms
* Steps in a wizard

> [WACOM.NOTE] Users generally expect blades to be pinnable.  Only use Pinnable="False" in places where the pinned blade truly adds no value.

To prevent a blade from being pinned, set `Pinnable="False"` in the blade definition.

`\SamplesExtension\Extension\Client\Security\Security.pdl`

```xml
<Blade Name="SecuritySampleBlade"
       Pinnable="False">
  ...
```

* Closing blades

## Closing blades programatically

This snippet shows how to close the current blade.  This can be called from either a blade or part container.  You can optionally return untyped data to the parent blade when you close your own blade.

Check out the [blade opening sample](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi) and you'll notice that the 'Close' button on the child blades that open is implemented using the new blade closing APIs.
 
The following metnods are now available on the  template blade container.

```typescript

import { Container as BladeContainer } from "Fx/Composition/Blade";
   
// closes the current blade now, optionally passing data back to the parent
closeCurrentBlade(data?: any): Promise<boolean>; 
// closes the current child blade now, if one is present
closeChildBlade(): Promise<boolean>; 
// closes the current child context blade now, if one is present
closeContextBlade(): Promise<boolean>; 
```

The following methods are now available on the  part container contract.

```typescript
// closes the current child blade now, if one is present
closeChildBlade(): Promise<boolean>; 
// closes the current child context blade now, if one is present
closeContextBlade(): Promise<boolean>; 
```

Each of these methods returns a promise that generally returns true.  If there is a blade on the screen that has unsaved edits to a form, the framework will prompt the user, giving them the option to keep the unsaved blade open.  If the user chooses to continue working on their unsaved edits then the blade closing promise will return false.

## Writing code that reacts to a blade being closed

When opening a child blade, you can register the optional onClosed callback to be notified when the blade you've opened closes.  The child blade can send untyped data that can be used in the  callback.  Here is an example:
 
```typescript
import { BladeClosedReason } from "Fx/Composition";
...
container.openBlade(new SomeBladeReference({ … }, (reason: BladeClosedReason, data?: any) => {
        // Code that runs when the blade closes - Data will only be there if the child blade returned it
        // reason lets you differentiate between things like the user closing the blade via the close button vs. a parent blade programatically closing it
});
```







 
<a name="advanced-template-blade-topics-best-practices"></a>
## Best Practices

Portal development patterns or architectures that are recommended based on customer feedback and usability studies are categorized by the type of blade.

**NOTE**: These patterns are recommended for every extension, but they are not required.

<a name="advanced-template-blade-topics-best-practices-resource-list-blades"></a>
### Resource List blades

  Resource List blades are also known as browse blades.

  All Browse blades should contain an "Add" command to help customers create new resources quickly, and Context menu commands in the "..." menu for each row.

  In addition, they should show all resource properties in the column chooser.

  For more information, see the Asset documentation located at [portalfx-assets.md](portalfx-assets.md).

<a name="advanced-template-blade-topics-best-practices-menu-blades"></a>
### Menu blades

All services should use the menu blade instead of the Settings blade. ARM resources should opt in to the resource menu for a simpler, streamlined menu.

<a name="advanced-template-blade-topics-best-practices-create-blades"></a>
### Create blades

Best practices for create blades cover common scenarios that will save time and avoid deployment failures.

* All Create blades should be a single blade. Instead of wizards or picker blades, extensions should use form sections and dropdowns.

* The subscription, resource group, and location picker blades have been deprecated.  Subscription-based resources should use the built-in subscription, resource group, location, and pricing dropdowns instead.

* Every service should expose a way to get scripts to automate provisioning. Automation options should include CLI, PowerShell, .NET, Java, Node, Python, Ruby, PHP, and REST, in that order. ARM-based services that use template deployment are opted in by default.


 

 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                              | Meaning |
| ---                               | --- |
| Deep linking |  Updates the portal URL when a blade is opened, which gives the user a URL that directly navigates to the new blade. |
| RBAC | Role based access. Azure resources support simple role-based access through the Azure Active Directory. | 

