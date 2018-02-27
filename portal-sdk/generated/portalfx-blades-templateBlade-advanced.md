
<a name="advanced-topics"></a>
### Advanced Topics


The following sections discuss more advanced topics in template blade development.

* [Deep linking](#deep-linking)

* [Displaying notifications](Displaying notifications)
<a name="pinning-the-blade"></a>
### Pinning the blade
<a name="storing-settings"></a>
### Storing settings

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

<a name="deep-linking"></a>
### Deep linking

**Deep linking** is the feature that gives the user a URL that directly navigates to the new blade when a blade is opened and the portal URL is updated. By design, only certain blades can be deep linked. Blades that cannot be deep linked are the ones that cannot be opened independent of some parent blade or part, like blades that return values to a calling module. An example of blades that cannot be deep-linked is a Web page in the middle of an website's check-out experience.

One of the easiest ways to make your blade deep linkable is to mark your TemplateBlade as pinnable. For more information about pinning blades, see [#pinning-the-blade](#pinning-the-blade).

<a name="displaying-notifications"></a>
### Displaying notifications

A status bar can be displayed at the top of a blade that contains both text and coloration that can be used to convey information and status to users. For example, when validation fails in a form, a red bar with a message can be displayed at the top of the blade. This area is clickable and can either open a new blade or an external url.

This capability is exposed through the **statusBar** member in the Blade base class by using `this.statusBar(myStatus)` in your blade view-model, as in the following code.

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

<a name="pinning-the-blade"></a>
### Pinning the blade

Blades can be marked as able to be pinned to the dashboard by setting `Pinnable="true"` in the TemplateBlade's PDL definition file. By default, blades are pinned as button parts to the dashboard. If a different represention should be used, it should be specified in the PDL. 

<a name="storing-settings"></a>
### Storing settings

Settings that are associated with a blade  can be stored. Those settings need to be declared both in the PDL definition file and in the ViewMmodel that is associated with the blade.

The following code demonstrates how to define the settings in the PDL file using the `TemplateBlade.Settings` element.

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

The settings are retrieved through the blade container.

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

The settings are also sent to the `onInputsSet` method.

```typescript

public onInputsSet(inputs: Def.TemplateBladeWithSettingsViewModel.InputsContract, settings: Def.TemplateBladeWithSettingsViewModel.SettingsContract): MsPortalFx.Base.Promise {
    // Any changes to the  Configuration values (see 'updateValues' above) will cause 'onInputsSet' to be called with the
    // new inputs/settings values.
    this._colorSetting(settings && settings.content && settings.content.colorSettingValue || BackgroundColor.Default);
    this._fontSetting(settings && settings.content && settings.content.fontSettingValue || FontStyle.Default);

    return null;
}

```

<a name="displaying-unauthorized-ui"></a>
### Displaying Unauthorized UI

You can set your blade to Unauthorized UI using the **unauthorized** member of the blade container.

The code below does this statically, but it can also be done dynamically (e.g. based on a condition after data is loaded).

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

<a name="dynamically-displaying-notice-ui"></a>
### Dynamically displaying Notice UI

You can set your blade to Notice UI using **enableNotice** member of the blade container.

This can be done statically (e.g. in the constructor) or dynamically. In the example below, the blade is set to Notice UI if the **id** input parameter has a given value.

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