
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

### Traditional Blades versus Template Blades

Previously, Ibiza blades contained customizable parts, or tiles, that served as the main way for users to navigate the UI. However, the UI's were difficult to navigate, caused excessive navigation, caused excessive horizontal scrolling, and were not very performant.

Newer UI experiences combine traditional menu blades with TemplateBlades to display features and content.

There are still many cases where extensions may display rich monitoring experiences or at-a-glance data. To support those cases, Ibiza now supports multiple, shareable dashboards that were once known as the single start board.

It is highly recommended that developers who still need to build parts should build them for use on dashboards, instead of blades.

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

### Per-user part settings

Extensions can read and write settings that are saved whenever the user saves a dashboard.  Private dashboards are located in the Ibiza user settings service.  Shared dashboards are stored in ARM as Azure resources inside the **MS.Portal** resource provider.

The dashboard is saved as a `JSON` document that contains the list of parts on the dashboard, in addition to their sizes, positions, and settings.  It also contains dashboard-level settings like the time range that is shared by many monitoring charts.

The following example located at `<dir>/Client/V1/Parts/TileGallery/TileGallery.pdl` demonstrates the use of the `<CustomPart.PartSettings>` tag to declare settings in the PDL file. It is also in the following code.


<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->

  gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/TileGallery/TileGallery.pdl", "section": "parts#PartSettingsDocs"}

The following is the TypeScript code that reads and writes samples. It is also located at `<dir>Client/V1/Parts/TileGallery/ViewModels/GeneralGalleryPart.ts`.

<!-- TODO:  Determine whether the following sample is causing gitHub to blow up. -->
  gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Parts/TileGallery/ViewModels/GeneralGalleryPart.ts", "section": "parts#TileGalleryWithNewConfigurationPattern"}

### The no-data message

Sometimes parts are displayed for which no data is available. For example, an extension may display a teaser 'deployment history' that contains sample data, before a user has enabled deployments. To support this, part `container` objects use the `noDataMessage` property.

The following example populates the part with sample data and set `noDataMessage` to a nonempty string.

```ts
container.noDataMessage("Enable deployments to see your history");
```

In this example, the part is grayed-out and is non-interactive. The message is displayed over the part. To remove the message, set the `noDataMessage` value back to `null`. 

This feature is used to inform the user that the feature exists, although the part is not applicable because no data is available yet.
If the extension needs to disable a part while the  data is loading, it should return a promise from the  `onInputsSet` method or use the `container.operations` queue.