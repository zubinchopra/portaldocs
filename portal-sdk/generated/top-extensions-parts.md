
<a name="parts"></a>
# Parts
   
 
<a name="parts-overview"></a>
## Overview

Parts, also known as tiles, are a framework feature that integrates the UI of an extension on dashboards.  Parts were more prevalent on blades, but this older pattern is being obsoleted by TemplateBlades that do not contain parts. For more information about template blades, see [portalfx-blades-overview.md](portalfx-blades-overview.md).

The following sections cover these topics.

1. [Traditional Blades versus Template Blades](#traditional-blades-versus-template-blades)
1. [Displaying data by using intrinsic parts](#displaying-data-by-using-intrinsic-parts)
1. [Custom parts](#custom-parts)
1. [Integrating parts into the part gallery](#integrating-parts-into-the-part-gallery)
1. [Defining the sizing behavior](#defining-the-sizing-behavior)
1. [Per-user part settings](#per-user-part-settings)
1. [The no-data message](#the-no-data-message)

* * * 

<a name="parts-overview-traditional-blades-versus-template-blades"></a>
### Traditional Blades versus Template Blades

Previously, Ibiza blades contained customizable parts, or tiles, that served as the main way for users to navigate the UI. However, the UI's were difficult to navigate, caused excessive navigation, caused excessive horizontal scrolling, and were not very performant.

Newer UI experiences combine traditional menu blades with TemplateBlades to display features and content.

There are still many cases where extensions may display rich monitoring experiences or at-a-glance data. To support those cases, Ibiza now supports multiple, shareable dashboards that were once known as the single start board.

It is highly recommended that developers who still need to build parts should build them for use on dashboards, instead of blades.

<a name="parts-overview-displaying-data-by-using-intrinsic-parts"></a>
### Displaying data by using intrinsic parts

Built-in parts, also known as intrinsic parts, let extension developers create parts that contain pre-defined views and interaction patterns, but lets them plug in their own data.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

The following example of a Button part contains an icon and a label that navigates to a blade when the user clicks it. The three files used for the button part example are the following.
*  `<dir>\Client\V1\Parts\Intrinsic\ButtonPart\ViewModels\ButtonPartIntrinsicInstructionsPartViewModel.ts`
* `<dir>\Client\V1\Parts\Intrinsic\ButtonPart\ButtonPartIntrinsicInstructions.pdl`
* `<dir>\Client\V1\Parts\Intrinsic\ViewModels\ButtonPartViewModel.ts`

A working copy of the sample is located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstructions).

The following procedure demonstrates how to use a button part.

1. Declare the part in the global `<Definition>` section of the PDL for the extension, as in the following example.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

  gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/Intrinsic/ButtonPart/ButtonPartIntrinsicInstructions.pdl", "section": "parts#BasicPartExampleForDocs"}

1. The ViewModel that is associated with the pdl will plug data into the part. The ViewModel is located at `<dir>\Client\V1\Parts\Intrinsic\ViewModels\ButtonPartViewModel.ts`  For this step, the data is just the label and icon, but for more data-oriented parts, the data can be gathered from a server, like a resource provider. The ViewModel is in the following code.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

  "gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/Intrinsic/ViewModels/ButtonPartViewModel.ts", "section": "parts#BasicPartExampleViewModel"}

For more information about built-in parts, see [portalfx-parts-intrinsic.md](portalfx-parts-intrinsic.md)

<a name="parts-overview-custom-parts"></a>
### Custom parts

Unlike intrinsic parts, custom parts use `html` templates that are bound to the view model. The developer defines the look and feel in addition to the data loading for the part. Templates also can use other controls that are provided by the framework, as specified in [top-extensions-controls.md](top-extensions-controls.md).

The following is an example of a custom part. The three files used for the custom part example are the following.
`<dir>\Client\V1\Parts\Custom\CustomParts.pdl`
`<dir>\Client\V1\Parts\Custom\Templates\ExampleCustomPart.html`
`<dir>\Client\V1\Parts\Custom\ViewModels\ExampleCustomPartViewModel.ts`

A working copy is located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/custompart](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/custompart).

The following procedure demonstrates how to use a custom part.

1. Declare the part in the global `<Definition>` section of the PDL for the extension, as in the following example.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

   gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/Custom/CustomParts.pdl", "section": "Parts#CustomPartsPDLDoc"}

1. The pdl points to the html template.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

   gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/Custom/Templates/ExampleCustomPart.html", "section": "Parts#CustomPartTemplateDoc"}

1. The HTML template is bound to the following ViewModel by using **Knockout**, which is also referred to in the pdl.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

   gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/Custom/ViewModels/ExampleCustomPartViewModel.ts", "section": "parts#CustomPartViewModelDoc"}

<a name="parts-overview-integrating-parts-into-the-part-gallery"></a>
### Integrating parts into the part gallery

Tiles are added to dashboards by using the part gallery, which is also known as the tile gallery.  The tile gallery is displayed  when the **Edit Dashboard** command is clicked, or when parts on the dashboard are rearranged or resized.

To register a part with the gallery, you need to add the `PartGalleryInfo` tag inside the `<Part>` or `<CustomPart>` tag, as in the file located at `<dir>\Client/V1/Parts/TileGallery/TileGallery.pdl` and in the following code.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->


 gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/TileGallery/TileGallery.pdl", "section": "parts#PartGalleryDocsPDL"}

The **Title**, **Category**, and **Thumbnail** parts are reasonably intuitive.

Some tile experiences require that parts are configured when they are dropped from the tile gallery. The **AutoConfigSelectablePath** property performs this task for parts that have this requirement.
 
  <!-- TODO: Determine whether the following sentence is more appropriate.
   The **AutoConfigSelectablePath** property set a requirement to configure parts when they are dropped from the tile gallery.
   for parts that have this requirement.
  -->
 
 The following is the path to a selectable that is located inside the ViewMmodel and is immediately set to `true` by the Framework when the part is dropped on a dashboard. The selectable can be configured to open a context blade for configuration. The  example located at `<dir>/Client/V1/Parts/TileGallery/ViewModels/GeneralGalleryPart.ts` demonstrates how this type of selectable is configured. The example code is in the following code. 


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

  gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/TileGallery/ViewModels/GeneralGalleryPart.ts", "section": "parts#PartGalleryConfigOnDropDoc"}

If the part that is being developed is associated with an Ibiza asset like an ARM resource, then it should be associated with an asset type and have a single input definition whose `IsAssetId` property is `true`.  If this is not the case then the part will appear in the **General** category of the part gallery.
 
<a name="parts-overview-defining-the-sizing-behavior"></a>
### Defining the sizing behavior

There is a significant amount of flexibility when sizing extension tiles. All size options are included in the `<CustomPart>` tag in the PDL located at `<dir>\Client/V1/Parts/PartSizes/PartSizes.pdl`.

A working copy is located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/partsizes](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/partsizes).

1. The following part supports only the large, standard size.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

   gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/PartSizes/PartSizes.pdl", "section": "parts#BasicPartThatSupportsSingleStandardSize"}

1. The following part supports multiple, standard sizes.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

   gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/PartSizes/PartSizes.pdl", "section": "parts#PartThatSupportsMultipleStandardSizes"}

1. The following part defaults to an arbitrary size, and can be resized by the user.  The Framework automatically adds a drag handle to this part because of the value `ResizeMode="User"`.

<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

   gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/PartSizes/PartSizes.pdl", "section": "parts#PartThatSupportsArbitrarySizeAndUserResize"}

1. The following part defaults to an arbitrary size, and can be resized programatically.  

<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

     gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/PartSizes/PartSizes.pdl", "section": "parts#PartThatSupportsArbitrarySizeAndProgrammaticResize"}

1. The following code demonstrates  how to programatically resize the part from within the associated ViewModel.  The parameters are specified in grid units instead of pixels. The code is located at `<dir>\Client\V1\Parts\PartSizes\ViewModels\PartSizesViewModels.ts`.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

     gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/PartSizes/ViewModels/PartSizesViewModels.ts", "section": "parts#ProgramatticResizeDoc"}

<a name="parts-overview-per-user-part-settings"></a>
### Per-user part settings

Extensions can read and write settings that are saved whenever the user saves a dashboard.  Private dashboards are located in the Ibiza user settings service.  Shared dashboards are stored in ARM as Azure resources inside the **MS.Portal** resource provider.

The dashboard is saved as a `JSON` document that contains the list of parts on the dashboard, in addition to their sizes, positions, and settings.  It also contains dashboard-level settings like the time range that is shared by many monitoring charts.

The following example located at `<dir>/Client/V1/Parts/TileGallery/TileGallery.pdl` demonstrates the use of the `<CustomPart.PartSettings>` tag to declare settings in the PDL file. It is also in the following code.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

  gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/TileGallery/TileGallery.pdl", "section": "parts#PartSettingsDocs"}

The following is the TypeScript code that reads and writes samples. It is also located at `<dir>Client/V1/Parts/TileGallery/ViewModels/GeneralGalleryPart.ts`.

<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->
  gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/TileGallery/ViewModels/GeneralGalleryPart.ts", "section": "parts#TileGalleryWithNewConfigurationPattern"}

<a name="parts-overview-the-no-data-message"></a>
### The no-data message

Sometimes parts are displayed for which no data is available. For example, an extension may display a teaser 'deployment history' that contains sample data, before a user has enabled deployments. To support this, part `container` objects use the `noDataMessage` property.

The following example populates the part with sample data and set `noDataMessage` to a nonempty string.

```ts
container.noDataMessage("Enable deployments to see your history");
```

In this example, the part is grayed-out and is non-interactive. The message is displayed over the part. To remove the message, set the `noDataMessage` value back to `null`. 

This feature is used to inform the user that the feature exists, although the part is not applicable because no data is available yet.
If the extension needs to disable a part while the  data is loading, it should return a promise from the  `onInputsSet` method or use the `container.operations` queue.
   
 
<a name="parts-overview-versioning"></a>
### Versioning

When users customize or pin a part, the following states are stored and used the next time the part is loaded from a customized context.

1. Basic part metadata, like part name or extension name
1. Part inputs, like resource id
1. Part settings, like time range for a chart

Because these states are stored, these parts need to be backwards-compatible.

Supporting new functionality may require the modification of the schema of a part's inputs and settings. 

The Azure Portal always calls the most recent edition of an extension, as specified in the extensions configuration file. However, older versions of inputs and settings that were stored by an earlier edition of the extension may still exist, and they may be incompatible with the most recent edition of the extension. Consequently, users may experience unexpected results when the extension or part is called with previous settings.

Likewise, other extensions may have taken dependencies on less-recent editions of the extension or part. For example, another extension may use a .pde file that contains a `<PartReference/>`.  Those other extensions may also experience unexpected results when they call the extension or part with old inputs.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

This example is based on the sample located at `<dir>\Client\V1\Hubs\Browse\Browse.pdl`. It builds on the ViewModel located at `<dir>\Client\V1\Hubs\Browse\ViewModels\RobotPartViewmodel.ts`.

 The **CanUseOldInputVersion** attribute can be set to `true` to specify that the part can process older versions of inputs. It should be used in conjunction with the  part property named `version`, as in the following example.

<!-- TODO:  Determine whether the following sample is causing GitHub to stop the build. -->
     gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Hubs/Browse/Browse.pdl"}

```xml
<Part Name="RobotPart"
      ViewModel="{ViewModel Name=RobotPartViewModel, Module=./Browse/ViewModels/RobotPartViewModel}"
      CanUseOldInputVersions="true"
      PartKind="Button"
      AssetType="Robot"
      AssetIdProperty="name">
    <Part.Properties>
        <Property Name="version"
                  Source="{Constant 2}" />
        <Property Name="name"
                  Source="{DataInput Property=id}" />
    </Part.Properties>
</Part>
```

**NOTE**: Inline parts can specify the current version as a constant.  Although this is the first explicit version, we recommend using  a value of `2` the first time it is used.

Globally-defined parts can not specify constant bindings, but the flow is mostly the same.

```xml
<CustomPart Name="RobotSummary2"
            Export="true"
            ViewModel="RobotSummaryViewModel"
            CanUseOldInputVersions="true"
            Template="{Html Source='Templates\\Robot.html'}"
            InitialSize="FullWidthFitHeight">
    <CustomPart.Properties>
        <Property Name="name"
                  Source="{DataInput Property=name}" />
        <Property Name="version"
                  Source="{DataInput Property=version}" /> <!-- currently 2 -->
    </CustomPart.Properties>
</CustomPart>
```

  The following code demonstrates how to process explicitly-versioned inputs, in addition to the version of the parts that existed previous to the addition of explicit versioning support.

```javascript
public onInputsSet(inputs: Def.InputsContract, settings: Def.SettingsContract): MsPortalFx.Base.Promise {
        var name: string;
        if (inputs.version === "2") {  // this block explicitly handles version 2, which is the latest
            name = inputs.name;
        } else if (inputs.version === "1") { // this block explicitly handles version 1, which is now old, but was an explicit version
            var oldInputs: any = inputs;
             name = oldInputs.oldName;
        } else if (MsPortalFx.Util.isNullOrUndefined(inputs.version)) { // this block handles any version of the inputs
            var oldestInputs: any = inputs;                             //  that existed before the version property was added
            name = oldestInputs.oldestName;
        } else {
            throw new Error("Unexpected version.  This should not happen, but there is one edge case where you temporarily deploy a new version, say version 3, and then roll back your code to version 2.  Any tiles pinned before you roll back will hit this block.");
        }
        return this._view.fetch(name);
    }
```

The same technique can be used for part settings.

```javascript
public onInputsSet(inputs: Def.InputsContract, settings: Def.SettingsContract): MsPortalFx.Base.Promise {
        var someSetting: string;
        if (settings.version === "2") {  // this block explicitly handles version 2, which is the latest
            someSetting = settings.someSetting;
        } else if (settings.version === "1") { // this block explicitly handles version 1, which is now old, but was an explicit version
            var oldSettings: any = settings;
            someSetting = oldSettings.oldSetting;
        } else if (MsPortalFx.Util.isNullOrUndefined(settings.version)) { // this block handles any version of the settings
            var oldestSettings: any = string;                             //  that existed before the version property was added
            someSetting = oldestSettings.oldestSetting;
        } else {
            throw new Error("Unexpected version.  This should not happen, but there is one edge case where you temporarily deploy a new version, say version 3, and then roll back your code to version 2.  Any tiles pinned before you roll back will hit this block.");
        }
        return this._view.fetch(name);
    }
```

 
 
<a name="intrinsic-parts"></a>
# Intrinsic Parts

Intrinsic parts are composed of existing controls in the portal, and provide patterns for solving common patterns in the portal.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

All of the currently available intrinsics can be located in the working copy located at  [https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade](https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade).

<a name="intrinsic-parts-asset"></a>
## Asset

![asset][asset]: ../media/portalfx-controls/asset.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/AssetPartIntrinsicInstructions">
Learn how to use the Asset part.
</a>

<a name="intrinsic-parts-button"></a>
## Button

![button][button]: ../media/portalfx-controls/button.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/ButtonPartIntrinsicInstructions">
Learn how to use the Button part.
</a>

<a name="intrinsic-parts-chart"></a>
## Chart

![chart][chart]: ../media/portalfx-controls/chart.png
[barChart]: ../media/portalfx-controls/barChart.png


<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/ChartPartIntrinsicInstructions">
Learn how to use the Chart part.
</a>

<a name="intrinsic-parts-collection"></a>
## Collection

![collection][grid]: ../media/portalfx-controls/grid.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/CollectionIndexPartBlade">
Learn how to use the Collection part.
</a>

<a name="intrinsic-parts-collection-summary"></a>
## Collection Summary

![collectionSummary][collectionsummary]: ../media/portalfx-controls/collectionsummary.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/CollectionSummaryPartIntrinsicInstructions">
Learn how to use the Collection Summary part.
</a>

<a name="intrinsic-parts-diff-editor"></a>
## Diff Editor

![diffEditorPartTitle][diff]: ../media/portalfx-controls/diff.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/DiffEditorPartIntrinsicInstructions">
Learn how to use the Diff Editor part.
</a>

<a name="intrinsic-parts-donut"></a>
## Donut

![donut][donut]
[donut]: ../media/portalfx-controls/Donut.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/DonutPartIntrinsicInstructions">
Learn how to use the Donut part.
</a>

<a name="intrinsic-parts-editor"></a>
## Editor

![editorPartTitle][editor]
[editor]: ../media/portalfx-controls/editor.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/EditorPartIntrinsicInstructions">
Learn how to use the Editor part
</a>

<a name="intrinsic-parts-info-list"></a>
## Info List

![infoList][infolist]
[infolist]: ../media/portalfx-controls/infolist.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/InfoListPartIntrinsicInstructions">
Learn how to use the Info list part.
</a>

<a name="intrinsic-parts-properties"></a>
## Properties

![properties][properties]

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/PropertiesPartIntrinsicInstructions">
Learn how to use the Properties part.

<a name="intrinsic-parts-quickstart"></a>
## Quickstart

![quickStart][quickstart]
[quickstart]: ../media/portalfx-controls/quickstart.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/QuickstartPartIntrinsicInstructions">
Learn how to use the Quick start part.
</a>

<a name="intrinsic-parts-quota-guage"></a>
## Quota Guage

![quotaGauge][gauge]

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/QuotaGaugeIntrinsicInstructions">
Learn how to use the Quota gauge part.
</a>

<a name="intrinsic-parts-setup"></a>
## Setup

![setupPartTitle][setup]

[setup]: ../media/portalfx-controls/setup.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/SetupPartBlade">
Learn how to use the Setup part.
</a>

<a name="intrinsic-parts-simple-chart"></a>
## Simple Chart

![chart][chart]
[chart]: ../media/portalfx-controls/chart.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/SimpleChartPartIntrinsicInstructions/selectedItem/SimpleChartPartIntrinsicInstructions">
Learn how to use the Simple Chart part.
</a>

<a name="intrinsic-parts-single-value-guage"></a>
## Single value guage

![singleValueGauge][gauge]
[gauge]: ../media/portalfx-controls/gauge.png

<a href="https://aka.ms/portalfx/samples/#blade/SamplesExtension/SingleValueGaugeIntrinsicInstructions">
Learn how to use the Single value gauge part.
</a>

Next steps: [Developing custom parts](portalfx-parts.md#parts-a-k-a-tiles-how-to-create-a-custom-part-where-you-define-the-look-and-feel-as-well-as-the-data-loading)


[settings]: ../media/portalfx-controls/settings.png


 
 
<a name="intrinsic-parts-single-value-guage-permanently-discontinue-a-part"></a>
### Permanently discontinue a part

Developers occasionally build and ship parts, and later  discontinue their functionality. However, there may be cases where these parts were pinned and  incorporated into the layout of a user's dashboard.

Azure customers have informed the Azure team that parts disappearing automatically from their startboards is an extremely dissatisfactory experience. To address this customer request, Azure has created a process that allows developers to permanently discontinue a part while providing a good user experience that uses customizations.

To discontinue a part, developers delete the majority of the code, but leave enough in place so that the tile still loads.  Then use the `container.noDataMessage()` api to inform the user that the part is no longer supported.

This ensures that customers are informed that this part is no longer supported, and that parts that fail will not be displayed on their dashboards.

  
   
<a name="intrinsic-parts-single-value-guage-removing-a-part-from-a-blade-default-layout"></a>
### Removing a part from a blade default layout

An unlocked blade's default layout should consist of tiles that provide the most out-of-the-box value to users and still meet extension performance goals.  That layout may change over time, and your team  may decide that a part that was included in a blade's default layout should be removed.

1. If the part was defined inline as a `<Part/>` or `<CustomPart>` element within a `<Blade/>` and `<Lens/>`, then the part should be moved out of the blade and into the global part catalog for the extension. Otherwise, if the  part is already defined in the global part catalog, or is defined in another extension then the pdl file may contain a  `<PartReference/>` tag for the blade, instead of  a `<Part/>` tag.

**NOTE**: It is best practice to use **Typescript** or no-pdl parts.

1. Remove the  `<Part/>` or `<PartReference/>` tag from the extension configuration or pdl file.

1. If the goal was to permanently discontinue a part, including removing support for pinned instances and the tile gallery, then follow the procedure specified in [portalfx-parts-discontinuing.md](portalfx-parts-discontinuing.md). Otherwise, to continue supporting instances of the part that have been pinned to user startboards, or to allow new users to  find the part in the tile gallery,  replace the part tag with a  global definition for  a  `<RedirectPart/>` tag, as in the following xml.  

```xml
<RedirectPart Name="SAME EXACT PART NAME THAT IS BEING REDIRECTED FROM" 
              Blade="EXACT BLADE NAME THAT THE PART WAS DEFINED IN"
              Lens="OPTIONAL - EXACT LENS NAME THE PART WAS DEFINED IN"
              Extension="OPTIONAL - ONLY APPLICABLE IF THE PART IS DEFINED IN A DIFFERENT EXTENSION">
    <NewPart Name="NAME OF THE NEW GLOBAL PART THAT DEFINES THE PART BEHAVIOR" />
</RedirectPart>
```

   
<a name="intrinsic-parts-improving-part-performance"></a>
## Improving Part Performance

When a Part loads, the user is presented with the default **blocking loading** indicator that is in the following image.

![alt-text](../media/portalfx-parts/portalfx-parts-opaquespinner.png "Part with blocking loading indicator") 

By default, the lifetime of this indicator is controlled by the promise that is returned from the `onInputsSet` method of the part, as in the following example.

```ts
public onInputsSet(inputs: Def.InputsContract): MsPortalFx.Base.Promise {
	// When this promise is resolved, the loading indicator is removed.
    return this._view.fetch(inputs.websiteId);
}
```

With large amounts of data, it is good practice to reveal content while the data continues to load.  When this occurs, the **blocking loading** indicator can be removed previous to the completion of the data loading process. This allows the user to interact with the part and the data that is currently accessible.

Essential content can be displayed while the non-essential content continues to load in the background, as signified by the  **status** marker on the bottom  left side of the tile.

A **non-blocking loading** indicator is displayed at the top of the part.  the user can activate or interact with the part while it is in this state. A part that contains the status marker and the **non-blocking loading** indicator is in the following image.

![alt-text](../media/portalfx-parts/portalfx-parts-translucentspinner.png "Part with non-blocking loading indicator") 

The `container.revealContent()` API that is located in the ViewModel can add this optimization to the part that is being developed. This method performs the following.

* Remove the **blocking loading** indicator
* Reveal content on the part
* Display the **non-blocking** loading indicator
* Allow the user to interact with the part

The `container.revealContent()` method can be called from either the ViewModel's `constructor` method or the ViewModel's `onInputsSet` function. These calls are located either in a `.then(() => ...)` callback, after the essential data has loaded, or they are located in the `onInputsSet` method, previous to the code that initiates data loading.

<a name="intrinsic-parts-improving-part-performance-calling-from-the-constructor"></a>
### Calling from the constructor

If the part contains interesting content to display previous to loading any data, the extension should call the `container.revealContent()` method from the ViewModel's `constructor` .  The following example demonstrates  a chart that immediately displays the X-axis and the Y-axis.

```ts
export class BarChartPartViewModel implements Def.BarChartPartViewModel.Contract {

    public barChartVM: MsPortalFx.ViewModels.Controls.Visualization.Chart.Contract<string, number>;

    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: ControlsArea.DataContext) {
        // Initialize the chart view model.
        this.barChartVM = new MsPortalFx.ViewModels.Controls.Visualization.Chart.ViewModel<string, number>(container);

        // Configure the chart view model (incomplete as shown).
        this.barChartVM.yAxis.showGridLines(true);
		
		container.revealContent();
	}
}
```

<a name="intrinsic-parts-improving-part-performance-calling-from-oninputsset"></a>
### Calling from onInputsSet

 Calling the `onInputsSet` method to return a promise behaves consistently, whether or not the part makes use of the  `container.revealContent()` method. Consequently, the  `container.revealContent()`method can optimize the behavior of the part that is being developed. There are two methodologies that are used to call the `container.revealContent()` method.
 
It is common to call the  `container.revealContent()` method after some essential, fast-loading data is loaded, as in the following example.

```ts
public onInputsSet(inputs: MyPartInputs): Promise {
    // This larger Promise still controls the lifetime of all loading indicators (the
    // non-blocking one in this case, since 'container.revealContent()' has been called).
    return Q.all([
        this._essentialDataView.fetch(inputs.resourceId).then(() => {
            // Show the Part content once essential, fast-loading data loads.
            this._container.revealContent();
        }),
        this._slowLoadingNonEssentialDataView.fetch(inputs.resourceId)
    ]);
}
```

It is less common to call the `container.revealContent()` method when the essential data to display can be computed synchronously from other inputs, as in the following example.

```ts
public onInputsSet(inputs: MyPartInputs): Promise {

    // In this case, the 'resourceGroupName' is sufficient to allow the user to interact with the Part/Blade.
    var resourceDescriptor = ResourceTypes.parseResourceManagerDescriptor(inputs.resourceId);
    this.resourceGroupName(resourceDescriptor.resourceGroup);
    this._container.revealContent();

    // This Promise controls the lifetime of all loading indicators (the
    // non-blocking one in this case, since 'container.revealContent()' has been called).
    return this._dataView.fetch(inputs.resourceId);
}
```

The promise returned from `onInputsSet` still determines the visibility of the loading indicators.  After the promise is resolved, all loading indicators are removed, as in the following image.

![alt-text](../media/portalfx-parts/portalfx-parts-nospinner.png "Fully loaded part with no loading indicator")

Also, if the promise that was returned from `onInputsSet` is rejected, the part displays the default error UX.  The promise that was returned from `onInputsSet` could be rejected if either the fast-loading data promise or the slow-loading data promise was rejected. The customizable error UX is in the following image.

![alt-text](../media/portalfx-parts/default-error-UX.png "Default error UX")



   
<a name="intrinsic-parts-improving-part-performance-handling-part-errors"></a>
### Handling part errors

Occasionally while loading parts, an extension may encounter some sort of unrecoverable error. In that case, the part may placed into a failure state, as in the following image.

![alt-text](../media/portalfx-debugging/failure.png "Failed part")

Parts should only be placed into a failed state if there was a system fault and no action can be taken by the user to correct the error. If the user can correct the error, then display guidance about how to do so. An example is located at `<dir>\Client\V1\Parts\Lifecycle\ViewModels\PartLifecycleViewModels.ts`, and in the following code.

```ts
constructor(container: MsPortalFx.ViewModels.PartContainer, initialState: any, dataContext: DataContext) {
    container.fail(SamplesExtension.Resources.Strings.failedToLoad);
}
```

If the error is  fixed, for example, if you are polling for data, and a subsequent poll returns valid results, then the extension can call `container.recover()` to return the part to its normal display state.


  
<a name="intrinsic-parts-improving-part-performance-handling-assets-that-no-longer-exist"></a>
### Handling assets that no longer exist

Many parts represent assets such as ARM resources that can be deleted from the UI, PowerShell, or calling REST APIs directly.  A stateless UI system would handle this by loading only assets that exist at the time the UI starts up.  Since Ibiza holds the state for all user customizations, this 'Not Found' case needs to be handled in a few specific places. 

* A part that has been pinned to the startboard represents an asset that no longer exists
  * Example: The VM part
* A part that has been pinned to the startboard depends on information provided by an asset that no longer exists
  * Example: The CPU chart for a VM part

<a name="intrinsic-parts-improving-part-performance-handling-assets-that-no-longer-exist-automatic-http-404-handling"></a>
#### Automatic HTTP 404 handling

In an attempt to cover the most common scenarios, the Portal's built-in data layer automatically detects HTTP 404 responses from **AJAX** calls.  When a part depends on data and a 404 has been detected, Ibiza automatically makes the part non-interactive and displays a message of 'Not Found'.

The effect is that in most "not found" scenarios, most extensions will display the more accurate 'Not found' message instead of the sad cloud UX that is reserved for  unexpected errors.

This distinction also allows the Portal telemetry system differentiate between a part that fails to render because of bugs and a part that fails to render because the user's asset has been deleted.

**NOTE**: Instances of 'Not Found' do not count against a part's reliability KPI.

<a name="intrinsic-parts-improving-part-performance-handling-assets-that-no-longer-exist-how-to-opt-out-of-automatic-http-404-handling"></a>
#### How to opt out of automatic HTTP 404 handling

We strongly encourage teams to develop extensions that allow the Portal to  handle 404 responses by default. However, there may be some valid exceptions where this standard behavior may not be the best action an extensinon can perform.  In those very rare cases you can opt out of automatic 404 handling by setting the `showNotFoundErrors` flag to `false` when creating the extension's `dataViews`, as in the following example.

```js
this._dataView = dataContext.createView(container, { interceptNotFound: false });
```

The preceding code makes 404s result in rejected promises, and individual extensions apply special handling of 404 responses.


  ## Samples Parts 

| API Topic                             | Document                                                                 | Sample                                                           | Experience |
| ----------------------------------------------  | ------------------------------------------------------------------------ | ---------------------------------------------------------------- | ---------- |
| Button Part | | `<dir>\Client\V1\Parts\Intrinsic\ButtonPart\ViewModels\ButtonPartIntrinsicInstructionsPartViewModel.ts`  | [http://aka.ms/portalfx/samples#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstructions)  | 
| Custom Part |  |  | http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/custompart  | 



 
<a name="intrinsic-parts-best-practices"></a>
## Best Practices

Portal development patterns or architectures that are recommended based on customer feedback and usability studies may be categorized by the type of part.

<a name="intrinsic-parts-best-practices-loading-indicators"></a>
#### Loading indicators

Loading indicators should be consistently applied across all blades and parts of the extension.  To achieve this:

* Call `container.revealContent()` to limit the time when the part displays  **blocking loading** indicators.

* Return a `Promise` from the `onInputsSet` method that reflects all data-loading for the part. Return the `Promise` from the blade if it is locked or is of type  `<TemplateBlade>`.

* Do not return a `Promise` from the `onInputsSet` method previous to the loading of all part data if it removes loading indicators.   The part will seem to be broken or unresponsive if no **loading** indicator is displayed while the data is loading, as in the following code.

```ts
public onInputsSet(inputs: MyPartInputs): Promise {
    this._view.fetch(inputs.resourceId);
    
    // DO NOT DO THIS!  Removes all loading indicators.
    // Your Part will look broken while the `fetch` above completes.
    return Q();
}
```

<a name="intrinsic-parts-best-practices-handling-part-errors"></a>
### Handling part errors

The sad cloud UX is displayed when there is no meaningful error to display to the user. Typically this occures when the error is unexpected and the only option the user has is to try again.

If an error occurs that the user can do something about, then the extension should launch the UX that allows them to correct the issue.    Extension  developers and domain owners are aware of  how to handle many types of errors.

For example, if the error is caused because the user's credentials are not known to the extension, then it is best practice to use one of the following options instead of failing the part.

1. The part can handle the error and change its content to show the credentials input form

1. The part can handle the error and show a message that says ‘click here to enter credentials’. Clicking the part would launch a blade with the credentials form.

 

 ## Frequently asked questions

<a name="intrinsic-parts-best-practices-"></a>
### 

* * * 

 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                | Meaning |
| ------------------- | --- |
|  | |
