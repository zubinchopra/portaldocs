
<a name="blades-and-template-blades"></a>
# Blades and Template Blades


<a name="blades-and-template-blades-overview"></a>
## Overview

Blades are the main UI container in the Portal. They are equivalent to `windows` or `pages` in other UX frameworks.   A blade typically takes up the full screen, has a presence in the Portal breadcrumb, and has an 'X' button to close it. The TemplateBlade is the recommended development model, which typically contains an import statement, an HTML template for the UI, and  ViewModel that contains the logic that binds to the HTML template. However, previous development models are still supported.

The following is a list of different types of blades.

| Type                          | Document                                                       | Description |
| ----------------------------- | ---- | ---- |
| TemplateBlade                 | [portalfx-blades-procedure.md](portalfx-blades-procedure.md)   | Creating any Portal blade. This is the main and recommended authoring model for UI in the Portal. | 
| Advanced TemplateBlade Topics | [portalfx-blades-advanced.md](portalfx-blades-advanced.md)     | Advanced topics in template blade development.                                                    | 
| MenuBlade                     | [portalfx-blades-menublade.md](portalfx-blades-menublade.md)   | Displays a vertical menu at the left of a blade.                                                  |  
| Blade Kinds                   | [portalfx-blades-bladeKinds.md](portalfx-blades-bladeKinds.md) | A set of built-in blades that encapsulate common patterns.                                        | 
| Blade Settings                | [portalfx-blades-settings.md](portalfx-blades-settings.md)   | Framework settings that allow extensions to opt in or out of interaction patterns.                  | 
| AppBlade                      | [portalfx-blades-appblades.md](portalfx-blades-appblades.md)   | Provides an IFrame to host the UI.                                                                | 
| Blade with tiles              | [portalfx-blades-legacy.md](portalfx-blades-legacy.md)         |  Legacy authoring model. Given its complexity, you may want to use TemplateBlades instead. | | -------------------------------------------------------------- | ----------- | 


   
 
<a name="blades-and-template-blades-templateblades"></a>
## TemplateBlades

The TemplateBlade is the recommended way of authoring blades in Ibiza. It is the equivalent to windows or pages in other systems.
It uses an HTML template for the UI, and a ViewModel with the logic that binds to that HTML template. 
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

 
<a name="blades-and-template-blades-advanced-topics"></a>
## Advanced Topics

The following sections discuss advanced topics in template blade development.

* [Deep linking](#deep-linking)

* [Displaying notifications](#displaying-notifications)

* [Pinning the blade](#pinning-the-blade)

* [Storing settings](#storing-settings)

* [Displaying Unauthorized UI](#displaying-unauthorized-ui)

* [Dynamically displaying Notice UI](#dynamically-displaying-notice-ui)

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

* * *

<a name="blades-and-template-blades-advanced-topics-deep-linking"></a>
### Deep linking

Deep linking is the feature that gives the user a URL that directly navigates to the new blade when a blade is opened and the portal URL is updated. By design, only certain blades can be deep linked. Blades that cannot be deep linked are the ones that cannot be opened independent of some parent blade or part, like blades that return values to a calling module. An example of blades that cannot be deep-linked is a Web page in the middle of an website's check-out experience.

One of the easiest ways to make your blade deep linkable is to mark your TemplateBlade as pinnable. For more information about pinning blades, see [#pinning-the-blade](#pinning-the-blade).

<a name="blades-and-template-blades-advanced-topics-displaying-notifications"></a>
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

<a name="blades-and-template-blades-advanced-topics-pinning-the-blade"></a>
### Pinning the blade

Blades can be marked as able to be pinned to the dashboard by setting `Pinnable="true"` in the TemplateBlade's PDL definition file. By default, blades are pinned as button parts to the dashboard. If a different represention should be used, it should be specified in the PDL file. 

<a name="blades-and-template-blades-advanced-topics-storing-settings"></a>
### Storing settings

Settings that are associated with a blade can be stored. Those settings need to be declared both in the PDL definition file and in the ViewMmodel that is associated with the blade.  The code that demonstrates how to store settings is located at  `<dir>Client/V1/Blades/Template/Template.pdl` and  `<dir>Client/V1/Blades/Template/ViewModels/TemplateBladeViewModels.ts`.

The process is as follows.

Specify the settings in the PDL file using the `TemplateBlade.Settings` element.

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

After the settings are declared, they should also be specified in the ViewModel, as in the following example.

```typescript

// These are required by the portal presently.  Re: Part Settings, the Part below works exclusively in terms of
// 'configuration.updateValues' to update settings values and 'onInputsSet(..., settings)' to receive settings values.
public colorSettingValue = ko.observable<BackgroundColor>();
public fontSettingValue = ko.observable<FontStyle>();

```

Retrieve the settings by using the blade container.

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

Also send the settings to the `onInputsSet` method.

```typescript

public onInputsSet(inputs: Def.TemplateBladeWithSettingsViewModel.InputsContract, settings: Def.TemplateBladeWithSettingsViewModel.SettingsContract): MsPortalFx.Base.Promise {
    // Any changes to the  Configuration values (see 'updateValues' above) will cause 'onInputsSet' to be called with the
    // new inputs/settings values.
    this._colorSetting(settings && settings.content && settings.content.colorSettingValue || BackgroundColor.Default);
    this._fontSetting(settings && settings.content && settings.content.fontSettingValue || FontStyle.Default);

    return null;
}

```

<a name="blades-and-template-blades-advanced-topics-displaying-unauthorized-ui"></a>
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

<a name="blades-and-template-blades-advanced-topics-dynamically-displaying-notice-ui"></a>
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

Menu blades are rendered as a menu on the left side of the screen. This blade gets combined by the Shell with the blade that its opened at its right. Each item that is referenced from the left menu is rendered using the same header as the blade menu, resulting in the two blades being displayed as one blade.  This is similar to the way that the resource menu blade operates.

The process is as follows.

1. Menu blade is displayed as a menu (list of items), where each item opens a blade when clicked
1. The menu blade is rendered to the left of the screen
1. The blades that are opened from the menu share the chrome with the menu blade 

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

Menu blades are defined in the PDL file in the following code. The code is also located at `<dir>\Client/V1/Blades/MenuBlade/MenuBlade.pdl`.

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

* Menus can have different groups. In this code there are two groups.
* Each menu item opens a blade, and all necessary parameters are provided.
* Menu items can integrate with `EditScope` and `ParameterProvider`, as displayed in the `createengine` item.
* At the end of the constructor, options for the menu are set. The option set defines the `id` of the default item.

You can view a working copy of the MenuBlade  in the Dogfood environment sample located at [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/PdlSampleMenuBlade/browserelated](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/PdlSampleMenuBlade/browserelated).
 
 
<a name="blades-and-template-blades-blade-kinds"></a>
## Blade Kinds

Blade Kinds are a set of built-in blades that encapsulate common patterns. These implementations offer a consistent UI and are easily implemented, because they provide a simplified programming model with a closed UI.  The main advantage of blade kinds is simplicity. When the Blade Kinds for an extension are updated, developers can use the updates and the layout without changing extension implementations. For example, one type of blade kind, the Quick start, is depicted in the following image.

![alt-text](../media/portalfx-bladeKinds/BladeKindsIntro.png "part")

When developing an extension that uses blade kinds, the developer should provide the ViewModel for the blade and another ViewModel for the part, regardless of the blade kind that is being developed.

The blade kind that is specified in the PDL file is a simplified version of a typical blade, as in the following code.

```xml
<azurefx:QuickStartBlade ViewModel="" PartViewModel=""/>
```

The Blade kind uses Typescript logic for the blade, and a separate view model for each part that it contains.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

To learn more about each of the Blade Kinds, start with the following topics:

- [Notice Blade](#notice-blade)
- [Properties Blade](#properties-blade)
- [QuickStart Blade](#quickstart-blade)
- [Setting List Blade](#setting-list-blade)

* * * 

<a name="blades-and-template-blades-blade-kinds-notice-blade"></a>
### Notice Blade

The Notice blade provides a convenient way to display announcements to extension users.  For example, the "coming soon" notice blade is depicted in the following image. 

![alt-text](../media/portalfx-bladeKinds/NoticeBlade.PNG "Notice Blade")

The PDL to define a Notice Blade is located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`. It is also in the following code.

```xml
  <azurefx:NoticeBlade Name="NoticeBlade"
                       ViewModel="{ViewModel Name=NoticeBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                       PartViewModel="{ViewModel Name=NoticePartViewModel, Module=./BladeKind/ViewModels/NoticePartViewModel}"
                       Parameter="info"/>
```

The TypeScript view model to define the Blade view model is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`. It is also in the following code.

<!--TODO:  Determine whether this code matches the SDK sample line-for-line.  If it does, replace the inline code with a gitHub link. -->

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

The TypeScript view model to define the part view model is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\NoticePartViewModel.ts`. It is also in the following code.

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
 
<a name="blades-and-template-blades-blade-kinds-properties-blade"></a>
### Properties Blade

The Properties blade provides users a convenient way access the properties of your service.  For example, a properties blade is depicted in the following image. 


![alt-text](../media/portalfx-bladeKinds/PropertiesBlade.PNG "Demo")

The PDL to define a Properties Blade is located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`. It is also in the following example.

```xml
  <azurefx:PropertiesBlade Name="PropertiesBlade"
                           ViewModel="{ViewModel Name=PropertiesBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                           PartViewModel="{ViewModel Name=PropertiesPartViewModel, Module=./BladeKind/ViewModels/PropertiesPartViewModel}"
                           Parameter="info"/>
```

The TypeScript view model to define the Blade view model is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`. It is also in the following example.

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

The TypeScript view model to define the part view model is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\PropertiesPartViewModel.ts`. It is also in the following code.

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

<a name="blades-and-template-blades-blade-kinds-quickstart-blade"></a>
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

1. Define the TypeScript view model that contains the blade, as in the code located at     `<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`. It is also in the following example.

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

1. Define the TypeScript view model that defines the part, as in the code located at    `<dir>\Client\V1\Blades\BladeKind\ViewModels\InfoListPartViewModel.ts`.  It is also in the following example.

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
 
<a name="blades-and-template-blades-blade-kinds-setting-list-blade"></a>
### Setting List Blade

The Setting List Blade provides a convenient way to give users access to a list of your service's settings, as in the following image.

![alt-text](../media/portalfx-bladeKinds/SettingListBlade.PNG "Setting List")

The PDL to define a Settings Blade is located at `<dir>\Client\V1\Blades\BladeKind\BladeKinds.pdl`. It is also in the following code.

```xml
  <azurefx:SettingListV2Blade Name="SettingListBlade"
                            ViewModel="{ViewModel Name=SettingListBladeViewModel, Module=./BladeKind/ViewModels/BladeKindsViewModels}"
                            PartViewModel="{ViewModel Name=SettingListPartViewModel, Module=./BladeKind/ViewModels/SettingListPartViewModel}"
                            Parameter="id"/>
```

The TypeScript view model to define the Blade view model is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts`. It is also in the following code.

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

The TypeScript view model to define the part view model is located at `<dir>\Client\V1\Blades\BladeKind\ViewModels\SettingListPartViewModel.ts`. It is also in the following code.

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


 
<a name="blades-and-template-blades-blade-kinds-blade-settings"></a>
### Blade Settings

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

<a name="blades-and-template-blades-blade-kinds-blade-settings-tags-and-rbac"></a>
#### Tags and RBAC

Tags and role-based access (RBAC) for users are the most common settings. Although the Portal does not automatically add Tags, it is extremely easy to opt in if your resource supports tagging. To opt in for tags, set the following in the **options** parameter of the **super** method of the **SettingsList** ViewModel, as in the following example.

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

For more information about tags, see [./portalfx-tags](./portalfx-tags) and [https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags).

<a name="blades-and-template-blades-blade-kinds-blade-settings-support-settings"></a>
#### Support settings

<!-- TODO:  Determine whether this mailto address is accurate. -->

One key experience is Troubleshooting and Support. Azure provides customers with a consistent UI so that they can assess the health of every resource, check its audit logs, get troubleshooting information, or open a support ticket. Every extension should reach out to the <a href="mailto:AzSFAdoption@microsoft.com?subject=Onboarding with the Support team&body=Hello, I have a new extension that needs to opt in to to the features that Troubleshooting and Support provides.">Support Team at AzSFAdoption@microsoft.com</a> to opt in to the support system and UX integration.

Enabling the coordination between your extension and the support extension takes a little more effort. For each setting, the extension should opt in by using the **options** parameter of the **super** method of the **SettingsList** ViewModel, as in the following example.

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

To test the coordination, use the following feature flags, depending on which settings you are testing.  **NOTE**: Your extension name is in lower case.

* ?<extensionName>_troubleshootsettingsenabled=true
* ?<extensionName>_healthsettingsenabled=true
* ?<extensionName>_requestsettingsenabled=true

For example, the following query string would enable TroubleShooting and Support for an extension named `microsoft_azure_classic_compute`.

`?microsoft_azure_classic_compute_requestsettingsenabled=true`

For more information about onboarding to support for Product Teams, see [http://aka.ms/portalfx/productteamsupport](http://aka.ms/portalfx/productteamsupport).

 ## AppBlades

AppBlades provide an IFrame where an extension can render content.  The extension IFrame is associated with an IFrame that hosts the UI, in order to enable the flexibility and control of the Model-View-View-Model methodology.

AppBlades can rehost an existing experience, and allow developers to create a UI that is not supported by the Fx. Because it does not use Ibiza Fx controls, extension developers are fully responsible for accessibility, theming, and consistency.

This programming model results in maximum flexibility and reduces additional developer responsibilities. We recommend using AppBlades under the following conditions.

* An existing extension that should be migrated to Ibiza without needing to be re-implemented 
* Developers want to implement user interactions and experiences that are not supported by Ibiza Framework components
* An existing extension needs to be re-hosted in several environments

When using AppBlade, developers are responsible for the following.

* Accessibility

    Making the blade accessible, as specified in [portalfx-accessibility.md](portalfx-accessibility.md)

* Theming

    The extension should respond to theming behavior

* Consistent Look & feel

    Designing a visual experience that is consistent with the rest of Ibiza

* Controls

    Building your own controls, or using available alternatives to Ibiza Fx controls

<a name="blades-and-template-blades-creating-an-appblade"></a>
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

<a name="blades-and-template-blades-the-ibiza-command-bar"></a>
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

<a name="blades-and-template-blades-sending-messages-between-the-iframe-and-ibiza-fx"></a>
## Sending messages between the IFrame and Ibiza Fx

The AppBlade ViewModel is hosted in the hidden IFrame in which the extension is loaded. However, the contents of the AppBlade are hosted in different IFrame that is visible on the screen. The Ibiza extension IFrame and the UI IFrame communicate by sending and receiving messages. The following sections demonstrate how to exchange messages between the two IFrames and to the Portal.

<a name="blades-and-template-blades-ibiza-extension-iframe-messaging"></a>
## Ibiza extension IFrame messaging

<a name="blades-and-template-blades-ibiza-extension-iframe-messaging-listen-to-a-message"></a>
### Listen to a message

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

<a name="blades-and-template-blades-ibiza-extension-iframe-messaging-post-a-message"></a>
### Post a message

The Ibiza extension ViewModel can post messages to the UI IFrame by using the **postMessage** method in the AppBlade ViewModel, as in the following example.

```typescript

// This is another example of how to post a message back to your iframe.
this.postMessage(new FxAppBlade.Message("favoriteAnimal", "porcupine"));

```

<a name="blades-and-template-blades-ui-iframe-messaging"></a>
## UI IFrame messaging

<a name="blades-and-template-blades-ui-iframe-messaging-listen-to-a-message"></a>
### Listen to a message

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

<a name="blades-and-template-blades-ui-iframe-messaging-post-a-message"></a>
### Post a message

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

<a name="blades-and-template-blades-changing-ui-themes"></a>
## Changing UI themes

When using a template blade, extension developers can implement themes. Typically, the user selects a theme, which in turn is sent to the UI IFrame. The following code snippet demonstrates how to pass the selected theme to the UI IFrame using the **postMessage** method,  as specified in the section named [Sending messages between the IFrame and Ibiza Fx](#sending-messages-between-the-iframe-and-ibiza-fx).

```typescript

// Get theme class and pass it to App Blade
MsPortalFx.Services.getSettings().then(settings => {
    let theme = settings["fxs-theme"];
    theme.subscribe(container, theme =>
        this.postMessage(new FxAppBlade.Message("theme", theme.name))
    ).callback(theme());
});

```

 
<a name="blades-and-template-blades-legacy-blades"></a>
## Legacy Blades

A blade is the vertical container that acts as the starting point for any journey. You can define multiple blades, each containing their own collection of statically defined lenses and parts.

**NOTE**: Given the complexity associated with this model, extension authors are encouraged to use TemplateBlades instead, as specified in [portalfx-blades-overview.md](portalfx-blades-overview.md).

The following image depicts a legacy blade.

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

Blades use ViewModels to drive dynamic content, including titles, icons, and status.  The following is a list of legacy blade subtopics.

| Type                 | Document                                                       | Description |
| -------------------- | -------------------------------------------------------------- | ----------- |
| Controlling blade UI | [portalfx-blades-ui.md](portalfx-blades-ui.md)                 | Customizing blade behavior and experience | 
| Opening blades       | [portalfx-blades-opening.md](portalfx-blades-opening.md)       | How to open blades using the new container APIs or the legacy declarative APIs. | 
| Blade parameters     | [portalfx-blades-parameters.md](portalfx-blades-parameters.md) | Explicit declaration for parameters that blades are required to receive.    |  
| Blade properties     | [portalfx-blades-properties.md](portalfx-blades-properties.md) | Information sent to the blade as a `BladeParameter` is also sent to the blade ViewModel by using  a `<Property>` element. | 
| Blade outputs        | [portalfx-blades-outputs.md](portalfx-blades-outputs.md)       | A list of output properties that return data from a child blade back to the calling blade. | 
| Pinning blades       | [portalfx-blades-pinning.md](portalfx-blades-pinning.md)       | Pinning a blade creates a part on the currently active dashboard.    | 
| Closing blades       | [portalfx-blades-closing.md](portalfx-blades-closing.md)       | How to close the current blade that was called from a blade or a part container.  |


 ## Samples Blades

| API Topic                             | Document                                                                 | Sample                                                           | Experience |
| ----------------------------------------------  | ------------------------------------------------------------------------ | ---------------------------------------------------------------- | ---------- |
| View Model                 | [portalfx-blade-viewmodel.md](portalfx-blade-viewmodel.md)                           | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels`       |  |
| Template Blades                | [portalfx-extensions-blades-overview.md](portalfx-extensions-blades-overview.md) | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels.ts` <br>     `<dir>\Client\V1\Data\ClientSideSortFilter\ViewModels\ViewModels.ts` <br>     `<dir>\Client\V1\Blades\Template\ViewModels\TemplateBladeViewModels.ts`  | |
| TemplateBlade Advanced Options | [portalfx-extensions-blades-advanced.md](portalfx-extensions-blades-advanced.md)   | `<dir>/Client/V1/Blades/Template/ViewModels/TemplateBladeViewModels.ts` <br> `<dir>/Client/V1/Blades/ContentState/ViewModels/ContentStateViewModels.ts` <br>      `<dir>/Client/V1/Blades/DynamicNotice/ViewModels/DynamicNoticeViewModels.ts` <br> `<dir>Client/V1/Blades/Unauthorized/ViewModels/UnauthorizedBladeViewModel.ts`  | 
| Blade Properties               | [portalfx-blades-properties.md](portalfx-blades-properties.md)                           | `<dir>\Client\V1\Blades\Properties\ ViewModels\BladePropertyViewModels.ts`  <br> `<dir>\Client\V1\Hubs\Browse\ViewModels\RobotBladeViewModel.ts`     | | 
| AppBlades                  | [portalfx-blades-appblades.md](portalfx-blades-appblades.md)                         | `<dir>\Client\V1\Blades\AppBlade\ ViewModels\AppBladeViewModel.ts`   |  |
| Menu Blade                     | [portalfx-blades-menublade.md](portalfx-blades-menublade.md)                             | `<dir>\Client\V1\Blades\MenuBlade\ ViewModels\SampleMenuBlade.ts`| [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions) <br> [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SampleMenuBlade/bladeWithSummary](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SampleMenuBlade/bladeWithSummary) | 
| Pricing Tier Blade             | [portalfx-extension-pricing-tier.md](portalfx-extension-pricing-tier.md)                 | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | |
| Testing Parts and Blades    | [portalfx-testing-parts-and-blades.md](portalfx-testing-parts-and-blades.md)   |   `<dir>\Client\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts` <br>  `<dir>\Client\Blades\BladeKind\ViewModels\InfoListPartViewModel.ts`  <br> `<dir>\Client\Blades\BladeKind\ViewModels\PropertiesPartViewModel.ts`  <br> `<dir>\Client\Blades\BladeKind\ViewModels\NoticePartViewModel.ts`  <br> `<dir>\Client\Blades\BladeKind\ViewModels\SettingListPartViewModel.ts`     |

<a name="blades-and-template-blades-samples-index-blades"></a>
## Samples Index Blades

The following table contains blades  that display lists of controls.  These objects are not inherently controls.

| Gallery | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| ControlIndexBlade |  | `<dir>\Client\V1\Controls\ControlIndexBlade\ViewModels\ControlIndexViewModel.ts` |  |
| UnsupportedIndexBlade |  | `<dir>\Client\V1\Controls\UnsupportedIndexBlade\ViewModels\UnsupportedIndexViewModel.ts` |   |

 
<a name="blades-and-template-blades-best-practices"></a>
## Best Practices

Portal development patterns or architectures that are recommended based on customer feedback and usability studies are categorized by the type of blade.

**NOTE**: These patterns are recommended for every extension, but they are not required.

Typically, extensions follow these best practices.
	
* Never change the name of a Blade or a Part

* Limit their `parameters` updates to the addition of parameters that are marked in TypeScript as optional

* Never remove parameters from their `Parameters` type

<a name="blades-and-template-blades-best-practices-resource-list-blades"></a>
### Resource List blades

  Resource List blades are also known as browse blades.

  All Browse blades should contain an "Add" command to help customers create new resources quickly, and Context menu commands in the "..." menu for each row.

  In addition, they should show all resource properties in the column chooser.

  For more information, see the Asset documentation located at [portalfx-assets.md](portalfx-assets.md).

<a name="blades-and-template-blades-best-practices-menu-blades"></a>
### Menu blades

All services should use the menu blade instead of the Settings blade. ARM resources should opt in to the resource menu for a simpler, streamlined menu.

<a name="blades-and-template-blades-best-practices-create-blades"></a>
### Create blades

Best practices for create blades cover common scenarios that will save time and avoid deployment failures.

* All Create blades should be a single blade. Instead of wizards or picker blades, extensions should use form sections and dropdowns.

* The subscription, resource group, and location picker blades have been deprecated.  Subscription-based resources should use the built-in subscription, resource group, location, and pricing dropdowns instead.

* Every service should expose a way to get scripts to automate provisioning. Automation options should include CLI, PowerShell, .NET, Java, Node, Python, Ruby, PHP, and REST, in that order. ARM-based services that use template deployment are opted in by default.


 ## Frequently asked questions

<a name="blades-and-template-blades-best-practices-"></a>
### 

* * * 

 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                              | Meaning |
| ---                               | --- |
| Deep linking |  Updates the portal URL when a blade is opened, which gives the user a URL that directly navigates to the new blade. |
| PDE | Portal Definition Export | 
| RBAC | Role based access. Azure resources support simple role-based access through the Azure Active Directory. | 

