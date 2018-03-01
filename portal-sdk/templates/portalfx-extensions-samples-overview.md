## Overview

One of the most productive ways to learn how to develop code is by reviewing program source.  The Azure Portal team ships samples that extension developers can leverage.

All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples).

## Samples extension

The samples extension provides an individual sample for each feature available in the framework, as described in the following image.

 ![alt-text](../media/top-extensions-samples/samples.png  "Samples Extension Solution")

After installing the Portal Framework SDK, the local instance of the Portal will open with the samples extension pre-registered.  You can open the `SamplesExtension` solution file to experiment with samples in the IDE.

```bash
[My Documents]\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\SamplesExtension.sln
```

The samples and the Portal can be located with **IntelliMirror** in the following location.

```bash
%LOCALAPPDATA%\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\SamplesExtension.sln
```

Each sample demonstrates a single usage of the API. It is great for detailed information on any one API. You can edit the samples and then refresh the Portal to see the changes. 

For help other than documentation and samples, review the StackOverflow forum located at [https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza). For a list of topics and stackoverflow tags, see [portalfx-stackoverflow.md](portalfx-stackoverflow.md).

<!-- TODO: Determine whether there should be a list of samples and whether they are V1 or V2.   
The alternative is to let the list default to the contents of the SamplesExtension.sln project, and the reverse cross-reference that is created by documents like portalfx-blades-appblades.md. -->

## V1 versus V2

The samples are structured into two directories, **V1** and **V2**, as in the following example. 

 ![alt-text](../media/top-extensions-samples/v1-and-v2.png  "V1 and V2 Directories")

<!--TODO: Can "meant" be changed to "will"  or "intended" ? -->

### V2

The samples in the **V2** directories use the most recent patterns. It contains the post-GA collection of new APIs that are meant to be the only set of APIs needed to develop an Ibiza extension.

The **V2** samples address the following API areas.

* New variations TemplateBlade, FrameBlade, MenuBlade 

* Blade-opening and closing `container.openBlade`, among others

* no-PDL TypeScript decorators that define all recommended Blade/Part variations

* Forms that do not use **V1** EditScope. For more information about EditScope, see [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md).

### V1

Our **V1** APIs use APIs that support previous UX patterns, or  are becoming obsolete or are less commonly used.  The **V1** APIs are also more difficult to use than the new API, for both the UX design and  the associated APIs.

The following **V1** concepts should not be used when **V2** APIs can be used instead.

* Blades containing Parts
* **V1** Blade-opening -- Selectable/SelectableSet APIs
* EditScope
* Fixed-width Blades
* **V1** Forms that use EditScope
* ParameterCollector/ParameterProvider
* PDL

**NOTE**: Building the **V2** space is still in process, therefore  the previously-listed **V1** concepts are not completely deprecated. For example, the source code for small, medium, and large blades is located in the `<dir>\Client\V1\Blades\BladeWidth` directory. In the meantime, use **V1** APIs in places where a **V2** replacement is not evident.

## Sample Source Code

Sample source code is included in topics that discuss the various Azure SDK API items. In the following tables, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to Dogfood copies of sample experiences are included in the tables as appropriate.

Samples are primarily categorized into forms, controls, and other factors. 

* Introductions

    | API Topic             | Document                                                                                             | Sample                                                            | Experience |
    | ------------------------------ | ---------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | ---------- |
    | Create ARM Resource Experience | [portalfx-create-engine-sample.md](portalfx-create-engine-sample.md)                 |  | [https://aka.ms/portalfx/sampleCreateEngine](https://aka.ms/portalfx/sampleCreateEngine)  |
    | Create Custom Experience       | [portalfx-create-robot-sample.md](portalfx-create-robot-sample.md)                   |     | |
    | Forms with EditScopes          | [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md)             | `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\DetailViewModels.ts`.     | |`<dir>\Client\V1\MasterDetail\MasterDetailEdit\ViewModels\MasterDetailEditData.ts`  | 
    | Forms Without EditScopes       | [portalfx-forms-editscopeless.md](portalfx-forms-editscopeless.md)      |   | |
    | Getting Started with Parameters               | [portalfx-parameter-collection-getting-started.md](portalfx-parameter-collection-getting-started.md) | `<dir>\Client\V1\ParameterCollection\ ParameterCollectionArea.ts` | |
    
* All Azure API's

  | API Topic            | Document | Sample | 
  | --------------------------  | ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------   | 
  | Bundling and Configuration  | [portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md](portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md)  |       | 
   | Configuration Settings      | [portalfx-load-configuration.md](portalfx-load-configuration.md)                                                                          | `<dir>\Configuration\ArmConfiguration.cs`                                     |
  | Content Delivery Network    | [portalfx-cdn.md](portalfx-cdn.md)                                                                                                        |  `<dir>\Configuration\CustomApplicationContext.cs`                            | 
  | Localizing your extension |  [portalfx-localization.md](portalfx-localization.md) | `<dir>\Client\ClientResources.resx` | |
  | Performant Extensions       | [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md)                                                            | `<dir>\Client\V1\Controls\Grid\ViewModels\ PageableGridViewModel.ts`          | 
  | Type metadata               | [portalfx-data-typemetadata.md](portalfx-data-typemetadata.md)                                                                            | `<dirParent>\SamplesExtension.DataModels\ SamplesExtension.DataModels.csproj` | 
  | Versioning an Extension     | [portalfx-extension-versioning.md](portalfx-extension-versioning.md)                                                                      | `<dir>\Content\SamplesExtension\Scripts\ MsPortalFxDocs.js`                   | 
  | Defining Extensions with TypeScript decorators  | [portalfx-no-pdl-programming.md](portalfx-no-pdl-programming.md)         | `<dir>\Client\V2\Blades\Template\ SimpleTemplateBlade.ts`        | [https://aka.ms/portalfx/sampleTypeScript](https://aka.ms/portalfx/sampleTypeScript) | 

  * Debugging and Logging

    | API Topic      | Document                                                                                         | Sample | 
    | --------------------- | ------------------------------------------------------------------------------------------------ | ------ | 
    | Logging and Debugging | [portalfx-logging-from-typescript-and-dotnet.md](portalfx-logging-from-typescript-and-dotnet.md) | `<dir>\Client\V1\Diagnostics\Logging\ ViewModels\LoggingViewModels.ts` |  
    | Logging Telemetry     | [portalfx-telemetry-logging.md](portalfx-telemetry-logging.md)                                   | `<dir>\Configuration\ApplicationConfiguration.cs` |  
    
  The following tables are categorized by the Model-View-View-Model methodology.

  * Modeling Data

    | API  Data Model Element                   | Document                                                                     | Sample | 
    | ----------------------------------- | ---------------------------------------------------------------------------- | ------ | 
    | Data View                           | [portalfx-data-overview.md](portalfx-data-overview.md)                       |  `<dir>\Client\V1\MasterDetail\MasterDetailEdit\ ViewModels\MasterViewModels.ts`  | 
    | Data Transformations                | [portalfx-data-projections.md](portalfx-data-projections.md)                 | `<dir>\Client\V1\Data\Projection\ ViewModels\MapAndMapIntoViewModels.ts`     <br> `<dir>\Client\V1\Data\Projection\ ViewModels\ProjectionBladeViewModel.ts`     <br>      `<dir>\Client/V1/Data/Projection/ViewModels/ProjectionBladeViewModel.ts`      | 
    | Extension Outputs                   | [portalfx-blades-outputs.md](portalfx-blades-outputs.md)                     |  `<dir>\Client\Bindings\OutputBindings\ OutputBindings.pdl` | 
    | Loading Data                        | [portalfx-data-loadingdata.md](portalfx-data-loadingdata.md)                 | `<dir>\Client\V1\Data\SupplyData\SupplyData.ts` | 
    | Polling and Refreshing Data         | [portalfx-data-refreshingdata.md](portalfx-data-refreshingdata.md)           | `<dir>\Client\V1\ResourceTypes\SparkPlug \SparkPlugData.ts` <br>    `<dir>\Client\V1\Hubs\RobotData.ts` <br>    `<dir>/Client/V1/Hubs/RobotData.ts` <br> `<dir>/Client/V1/Hubs/ComputerData.ts` | 
    
  * View Components
    
    | API ScreenObject           | Document | Sample | Experience |
    | -------------------------- | -------- | ------ | ---------- |
    | Browse Experience          | [portalfx-browse.md](portalfx-browse.md)                                             | `<dir>\Client\V1\Hubs\Browse\Browse.pdl` <br>  `<dir>\Client\Hubs\Browse\Services\RobotGridColumnsService.ts`  `<dir>\Client\Shared\SharedArea.ts` <br>`<dir>\Client\Hubs\Browse\Services\RobotBrowseService.ts`     | |
      | Button Parts               | [portalfx-parts.md](portalfx-parts.md)                                               | `<dir>\Client\V1\Parts\Intrinsic\ ViewModels\ButtonPartViewModel.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction) | 
    | Display data across blades | [portalfx-data-masterdetailsbrowse.md](portalfx-data-masterdetailsbrowse.md)         | `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\DetailViewModels.ts`  <br>      `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`  <br>      `<dir>\Client\V1\MasterDetail\MasterDetailArea.ts`  <br>      `<dir>Client\V1\Data\MasterDetailBrowse\MasterDetailBrowseData.ts` | |
    | Essentials panel           | [portalfx-essentials.md](portalfx-essentials.md)                                     | `<dir>\Client\V1\ResourceTypes\Engine\EngineData.ts` <br>      `<dir>\Client\V1\ResourceTypes\Engine\ViewModels\EngineResourceSummaryViewModel.ts` | | 
    | Extension User Interface   | [portalfx-blades-ui.md](portalfx-blades-ui.md)                                       | `<dir>\Client\Blades\Template\ViewModels\ TemplateBladeViewModels.ts`  <br>      `<dir>\Client\ContentState\ViewModels\ContentStateViewModels.ts`      | |
    | Fx Controls in EditScope forms | [portalfx-editscopeless-procedure.md](portalfx-editscopeless-procedure.md)  [portalfx-extension-pricing-tier.md](portalfx-extension-pricing-tier.md) | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` <br>      `<dir>\Client/V1/Hubs/PricingV3/ViewModels/Robot/RobotSpecPickerV3BladeViewModel.ts` <br>    `<dir>\Client/V1/Hubs/PricingV3/ViewModels/Robot/RobotSpecPickerV3Extender.ts`      | [https://aka.ms/portalfx/samplecreateengine](https://aka.ms/portalfx/samplecreateengine) | 
    | Hubs Extension             | [portalfx-hubsextension-pde.md](portalfx-hubsextension-pde.md)                       | `<dir>\Client\Hubs\PricingV3` <br>     `<dir>\Client/Hubs/ScopedBrowse/ViewModels/ScopedBrowseLauncherPartViewModel.ts`      | [https://aka.ms/portalfx/sampleHub](https://aka.ms/portalfx/sampleHub) |
    | Icon                       | [portalfx-icons.md](portalfx-icons.md)                                               | `<dir>\Client\V1\UI\ViewModels\Blades\ IconBladeViewModels.ts` | | 
    | Intrinsic Tile             | [portalfx-parts-intrinsic.md](portalfx-parts-intrinsic.md)                           | `<dir>\Client\V1\Parts\Intrinsic\ ViewModels\IntrinsicBladeViewModel.ts` | [https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade](https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade) | 
    | Pinning Parts              | [portalfx-parts-pinning.md](portalfx-parts-pinning.md)                               | `<dir>\Client\V1\Hubs\Browse\Browse.pdl` | | 
    | Portal Parts               | [portalfx-parts.md](portalfx-parts.md)  | `<dir>\Client\V1\Parts\PartsArea.ts` <br>     `<dir>\Client/V1/Parts/TileGallery/ViewModels/GeneralGalleryPart.ts`  <br>     `<dir>\Client/V1/Parts/Intrinsic/ViewModels/ButtonPartViewModel.ts` <br>     `<dir>\Client/V1/Parts/Custom/ViewModels/ExampleCustomPartViewModel.ts` <br>     `<dir>\Client/V1/Parts/PartSizes/ViewModels/PartSizesViewModels.ts`     |
    