<a name="overview"></a>
## Overview

One of the most productive ways to learn how to develop code is by reviewing program source.  The Azure Portal team ships samples that extension developers can leverage.

All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples).

<a name="samples-extension"></a>
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

For help other than documentation and samples, review the StackOverflow forum located at [https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza). For a list of topics and stackoverflow tags, see [top-extensions-stackoverflow.md](top-extensions-stackoverflow.md).

<!-- TODO: Determine whether there should be a list of samples and whether they are V1 or V2.   
The alternative is to let the list default to the contents of the SamplesExtension.sln project, and the reverse cross-reference that is created by documents like portalfx-blades-appblades.md. -->

<a name="v1-versus-v2"></a>
## V1 versus V2

The samples are structured into two directories, **V1** and **V2**, as in the following example. 

 ![alt-text](../media/top-extensions-samples/v1-and-v2.png  "V1 and V2 Directories")

<!--TODO: Can "meant" be changed to "will"  or "intended" ? -->

<a name="v1-versus-v2-v2"></a>
### V2

The samples in the **V2** directories use the most recent patterns. It contains the post-GA collection of new APIs that are meant to be the only set of APIs needed to develop an Ibiza extension.

The **V2** samples address the following API areas.

* New variations TemplateBlade, FrameBlade, MenuBlade 

* Blade-opening and closing `container.openBlade`, among others

* no-PDL TypeScript decorators that define all recommended Blade/Part variations

* Forms that do not use **V1** EditScope. For more information about EditScope, see [portalfx-forms-edit-scope-faq.md](portalfx-forms-edit-scope-faq.md).

<a name="v1-versus-v2-v1"></a>
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

<a name="sample-source-code"></a>
## Sample Source Code

Sample source code is included in topics that discuss the various Azure SDK API items. In the following tables, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to Dogfood copies of sample experiences are included in the tables as appropriate.

* All Azure API's

  | API Topic            | Document | Sample | 
  | --------------------------  | ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------   | 
  | Bundling and Configuration  | [portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md](portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md)  |                                                                               | 
  | Configuration Settings      | [portalfx-load-configuration.md](portalfx-load-configuration.md)                                                                          | `<dir>\Configuration\ArmConfiguration.cs`                                     |
  | Content Delivery Network    | [portalfx-cdn.md](portalfx-cdn.md)                                                                                                        |  `<dir>\Configuration\CustomApplicationContext.cs`                            | 
  | Localizing your extension |  [portalfx-localization.md](portalfx-localization.md) | `<dir>\Client\ClientResources.resx` | |
  | Performant Extensions       | [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md)                                                            | `<dir>\Client\V1\Controls\Grid\ViewModels\ PageableGridViewModel.ts`          | 
  | Testing Commands            | [portalfx-testing-using-commands.md](portalfx-testing-using-commands.md)                                                                  |                                                                               |
  | Testing Forms               | [portalfx-testing-filling-forms.md](portalfx-testing-filling-forms.md)                                                                    | `<dir>`                                                                       | 
  | Testing Parts and Blades    | [portalfx-testing-parts-and-blades.md](portalfx-testing-parts-and-blades.md)                                                              | `<dir>`                                                                       | 
  | Type metadata               | [portalfx-data-typemetadata.md](portalfx-data-typemetadata.md)                                                                            | `<dirParent>\SamplesExtension.DataModels\ SamplesExtension.DataModels.csproj` | 
  | Versioning an Extension     | [portalfx-extension-versioning.md](portalfx-extension-versioning.md)                                                                      | `<dir>\Content\SamplesExtension\Scripts\ MsPortalFxDocs.js`                   | 

* Version 2 API 

  | API Topic                             | Document                                                                 | Sample                                                           | Experience |
  | ----------------------------------------------  | ------------------------------------------------------------------------ | ---------------------------------------------------------------- | ---------- |
  | Defining Extensions with TypeScript decorators  | [portalfx-no-pdl-programming.md](portalfx-no-pdl-programming.md)         | `<dir>\Client\V2\Blades\Template\ SimpleTemplateBlade.ts`        | [https://aka.ms/portalfx/sampleTypeScript](https://aka.ms/portalfx/sampleTypeScript) | 
  | Extension Controls                              | [portalfx-controls.md](portalfx-controls.md)                             |                                                                  | [http://aka.ms/portalfx/controls](http://aka.ms/portalfx/controls) |
  | Essentials Control                              | [portalfx-controls-essentials.md](portalfx-controls-essentials.md)       | `<dir>\Client\V2\Controls\Essentials\ EssentialsDefaultBlade.ts` | |
  | Plotting Metrics                                | [portalfx-controls-monitor-chart.md](portalfx-controls-monitor-chart.md) | `<dir>\Client\V2\Preview\MonitorChart\ MonitorChartBlade.ts`     | [https://aka.ms/portalfx/sampleMonitorChart](https://aka.ms/portalfx/sampleMonitorChart) |
  | Textbox Control                                 | [portalfx-controls-textbox.md](portalfx-controls-textbox.md)             | `<dir>\Client\V2\Controls\TextBox\ TextBoxBlade.ts`              | [https://aka.ms/portalfx/sampleTextBox](https://aka.ms/portalfx/sampleTextBox) |

* Version 1 API

  * Introductions

    | API Topic             | Document                                                                                             | Sample                                                            | Experience |
    | ------------------------------ | ---------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | ---------- |
    | Create ARM Resource Experience | [portalfx-create-engine-sample.md](portalfx-create-engine-sample.md)                                 |                                                                   | [https://aka.ms/portalfx/sampleCreateEngine](https://aka.ms/portalfx/sampleCreateEngine)  |
    | Create Custom Experience       | [portalfx-create-robot-sample.md](portalfx-create-robot-sample.md)                                   |                                                                   | |
    | Forms with EditScopes          | [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md)             | `<dir>\Client\V1\MasterDetail\ MasterDetailEdit\ViewModels.ts`    | |
    | Forms Without EditScopes       | [portalfx-editscopeless-forms.md](portalfx-editscopeless-forms.md)                                   |                                                                   | |
    | Getting Started                | [portalfx-parameter-collection-getting-started.md](portalfx-parameter-collection-getting-started.md) | `<dir>\Client\V1\ParameterCollection\ ParameterCollectionArea.ts` | |
 
  * Scenarios 
    
    | Scenario        | Document                                                                                         | Sample | 
    | --------------------- | ------------------------------------------------------------------------------------------------ | ------ | 
    | EditScopeAccessor | [portalfx-legacy-editscopes.md#editscopeaccessor](portalfx-legacy-editscopes.md#editscopeaccessor) |     `<dir>/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts` |  
  
  * Debugging and Logging

    | API Topic      | Document                                                                                         | Sample | 
    | --------------------- | ------------------------------------------------------------------------------------------------ | ------ | 
    | Logging and Debugging | [portalfx-logging-from-typescript-and-dotnet.md](portalfx-logging-from-typescript-and-dotnet.md) | `<dir>\Client\V1\Diagnostics\Logging\ ViewModels\LoggingViewModels.ts` |  
    | Logging Telemetry     | [portalfx-telemetry-logging.md](portalfx-telemetry-logging.md)                                   | `<dir>\Configuration\ApplicationConfiguration.cs` |  
    
  The following tables are categorized by the Model-View-Controller model, rather than the Model-View-View-Model model.

  * Modeling Data

    | API  Data Model Element                   | Document                                                                     | Sample | 
    | ----------------------------------- | ---------------------------------------------------------------------------- | ------ | 
    | Data View                           | [portalfx-data-overview.md](portalfx-data-overview.md)                       |  `<dir>\Client\V1\MasterDetail\MasterDetailEdit\ ViewModels\MasterViewModels.ts`  | 
    | Data Transformations                | [portalfx-data-projections.md](portalfx-data-projections.md)                 | `<dir>\Client\V1\Data\Projection\ ViewModels\MapAndMapIntoViewModels.ts` | 
    | DataNavigator for Virtualized Data  | [portalfx-data-virtualizedgriddata.md](portalfx-data-virtualizedgriddata.md) | `<dir>\Client\V1\Controls\Grid\Templates\ PageableGridViewModel.ts` | 
    | Extension Outputs                   | [portalfx-blades-outputs.md](portalfx-blades-outputs.md)                     |  `<dir>\Client\Bindings\OutputBindings\ OutputBindings.pdl` | 
    | Loading Data                        | [portalfx-data-loadingdata.md](portalfx-data-loadingdata.md)                 | `<dir>\Client\V1\Data\SupplyData\SupplyData.ts` | 
    | Polling and Refreshing Data         | [portalfx-data-refreshingdata.md](portalfx-data-refreshingdata.md)           | `<dir>\Client\V1\ResourceTypes\SparkPlug \SparkPlugData.ts` | 
    
  * View Components
    
    | API ScreenObject           | Document | Sample | Experience |
    | -------------------------- | -------- | ------ | ---------- |
    | AppBlades                  | [portalfx-blades-appblades.md](portalfx-blades-appblades.md)                         | `<dir>\Client\V1\Blades\AppBlade\ ViewModels\AppBladeViewModel.ts`   |  |
    | Basic Form                 | [portalfx-forms-sections.md](portalfx-forms-sections.md) | `<dir>\Client\V1\Forms\Samples\Basic\ ViewModels\Parts\FormsSampleBasicBlades.ts` | [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup) |
    | Basic Form Create          | [portalfx-forms-sections.md](portalfx-forms-sections.md)                             | `<dir>\Client\V1\Forms\Samples\BasicCreate\ ViewModels\Parts\FormsSampleBasicCreatePart.ts` | 
    | Browse Experience          | [portalfx-browse.md](portalfx-browse.md)                                             | `<dir>\Client\V1\Hubs\Browse\Browse.pdl` | |
    | Button Parts               | [portalfx-parts.md](portalfx-parts.md)                                               | `<dir>\Client\V1\Parts\Intrinsic\ ViewModels\ButtonPartViewModel.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction) | 
    | Console                    | [portalfx-controls-console.md](portalfx-controls-console.md)                         | `<dir>\Client\V1\Controls\Console2\ ViewModels\Console2ViewModels.ts` |  |
    | Create Form                | [portalfx-create.md](portalfx-create.md)                                             | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | |
    | DateTimePicker             | [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md)           | `<dir>\Client\V1\Controls\DateTimePicker\ ViewModels\DateTimePickerViewModels.ts`  | [http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimePickerInstructions/selectedItem/DateTimePickerInstructions/selectedValue/DateTimePickerInstruction](http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimePickerInstructions/selectedItem/DateTimePickerInstructions/selectedValue/DateTimePickerInstruction) |
    | DateTimeRangePicker        | [portalfx-controls-datetimerangepicker.md](portalfx-controls-datetimerangepicker.md) | `<dir>\Client\V1\Controls\DateTimeRangePicker\ ViewModels\DateTimeRangePickerViewModels.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions)  
    | Display data across blades | [portalfx-data-masterdetailsbrowse.md](portalfx-data-masterdetailsbrowse.md)         | `<dir>\Client\V1\MasterDetail\MasterDetailArea.ts` | |
    | Editor Control             | [portalfx-controls-editor.md](portalfx-controls-editor.md)                           | `<dir>\Client\V1\Controls\Editor\ ViewModels\EditorViewModels.ts` | |
    | Essentials panel           | [portalfx-essentials.md](portalfx-essentials.md)                                     | `<dir>\Client\V1\ResourceTypes\Engine\EngineData.ts` | | 
    | Extension User Interface   | [portalfx-blades-ui.md](portalfx-blades-ui.md)                                       | `<dir>\Client\Blades\Template\ViewModels\ TemplateBladeViewModels.ts` | |
    | Form Construction          | [portalfx-forms-construction.md](portalfx-forms-construction.md)                     | `<dir>\Client\V1\Forms\Samples\Basic\ ViewModels\FormsSampleBasicBlade.ts` | |
    | Form Field Validation      | [portalfx-forms-field-validation.md](portalfx-forms-field-validation.md)             | `<dir>\Client\V1\Forms\Samples\Validations\ ViewModels\FormValidationsViewModels.ts` | |
    | Form Sections                  | [portalfx-forms-sections.md](portalfx-forms-sections.md)                         | `<dir>\Client\V1\Forms\Samples\Validations\ ViewModels\FormValidationsViewModels.ts` | |
    | Fx Controls in EditScope forms | [portalfx-fxcontrols-editscope-forms.md](portalfx-fxcontrols-editscope-forms.md) | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | [https://aka.ms/portalfx/samplecreateengine](https://aka.ms/portalfx/samplecreateengine) | 
    | Grid and Grid Controls     | [portalfx-controls-grid.md](portalfx-controls-grid.md)                               | `<dir>\Client\V1\Controls\Grid\ ViewModels\ScrollableGridWithFilteringAndSorting.ts` | [http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions) |
    | Hubs Extension             | [portalfx-hubsextension-pde.md](portalfx-hubsextension-pde.md)                       | `<dir>\Client\Hubs\PricingV3` | [https://aka.ms/portalfx/sampleHub](https://aka.ms/portalfx/sampleHub) |
    | Icon                       | [portalfx-icons.md](portalfx-icons.md)                                               | `<dir>\Client\V1\UI\ViewModels\Blades\ IconBladeViewModels.ts` | | 
    | Intrinsic Tile             | [portalfx-parts-intrinsic.md](portalfx-parts-intrinsic.md)                           | `<dir>\Client\V1\Parts\Intrinsic\ ViewModels\IntrinsicBladeViewModel.ts` | [https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade](https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade) | 
    | Pinning Parts              | [portalfx-parts-pinning.md](portalfx-parts-pinning.md)                               | `<dir>\Client\V1\Hubs\Browse\Browse.pdl` | | 
    | Portal Parts               | [portalfx-parts.md](portalfx-parts.md)                                               | `<dir>\Client\V1\Parts\PartsArea.ts` |
    | Toolbar        | [portalfx-blades-templateBlade.md](portalfx-blades-templateBlade.md)|  `<dir>\Client\V1\Blades\Toolbar\BladeWithToolbarViewModels.ts` | 
    | View Model                 | [portalfx-blade-viewmodel.md](portalfx-blade-viewmodel.md)                           | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels` |  |
    
  * Controller Components

    | API Controller Topic               | Document | Sample | Experience |
    | ------------------------------ | -------- | ------ | ---------- |
    | Blade Properties               | [portalfx-blades-properties.md](portalfx-blades-properties.md)                           | `<dir>\Client\V1\Blades\Properties\ ViewModels\BladePropertyViewModels.ts` | | 
    | Closing an Extension           | [portalfx-blades-closing.md](portalfx-blades-closing.md)                                 | `<dir>\Client\V1\Commands\OpenBladeCommand\ ViewModels\OpenBladeCommandViewModels.ts` |  [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi) |
    | Menu Blade                     | [portalfx-blades-menublade.md](portalfx-blades-menublade.md)                             | `<dir>\Client\V1\Blades\MenuBlade\ ViewModels\SampleMenuBlade.ts`| [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions) | 
    | Opening an Extension           | [portalfx-blades-opening.md](portalfx-blades-opening.md)                                 | `<dir>\Client\V1\Commands\OpenBladeCommand\ ViewModels\OpenBladeCommandViewModels.ts` |  [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi) |
    | Pricing Tier Blade             | [portalfx-extension-pricing-tier.md](portalfx-extension-pricing-tier.md)                 | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | |
    | Template Blades                | [portalfx-blades-templateblade-reference.md](portalfx-blades-templateblade-reference.md) | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels.ts` | |
    | TemplateBlade Advanced Options | [portalfx-blades-templateblade-advanced.md](portalfx-blades-templateblade-advanced.md)   |  |
