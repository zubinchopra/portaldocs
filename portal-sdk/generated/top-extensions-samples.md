<a name="portal-extension-samples"></a>
# Portal Extension Samples

 ## Overview

One of the most productive ways to learn how to develop code is by reviewing program source.  The Azure Portal team ships samples that extension developers can leverage.

All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples).

<a name="portal-extension-samples-samples-extension"></a>
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

<a name="portal-extension-samples-v1-versus-v2"></a>
## V1 versus V2

The samples are structured into two directories, **V1** and **V2**, as in the following example. 

 ![alt-text](../media/top-extensions-samples/v1-and-v2.png  "V1 and V2 Directories")

<!--TODO: Can "meant" be changed to "will"  or "intended" ? -->

<a name="portal-extension-samples-v1-versus-v2-v2"></a>
### V2

The samples in the **V2** directories use the most recent patterns. It contains the post-GA collection of new APIs that are meant to be the only set of APIs needed to develop an Ibiza extension.

The **V2** samples address the following API areas.

* New variations TemplateBlade, FrameBlade, MenuBlade 

* Blade-opening and closing `container.openBlade`, among others

* no-PDL TypeScript decorators that define all recommended Blade/Part variations

* Forms that do not use **V1** EditScope. For more information about EditScope, see [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md).

<a name="portal-extension-samples-v1-versus-v2-v1"></a>
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

<a name="portal-extension-samples-sample-source-code"></a>
## Sample Source Code

Sample source code is included in topics that discuss the various Azure SDK API items. In the following tables, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to Dogfood copies of sample experiences are included in the tables as appropriate.

* All Azure API's

  | API Topic            | Document | Sample | 
  | --------------------------  | ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------   | 
  | Bundling and Configuration  | [portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md](portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md)  |                                                                               | 
  | Commands  | [portalfx-commands.md](portalfx-commands.md)  |   `\Client\V1\Commands\SimpleBladeCommand\ViewModels\SimpleBladeCommandViewModels.ts` <br>   `\Client\V1\Commands\Dialogs\ViewModels\CommandDialogsViewModels.ts` <br> `\Client\V1\Commands\UrlCommand\ViewModels\UrlCommandViewModels.ts` <br>    `\Client\V1\Commands\OpenBladeCommand\ViewModels\OpenBladeCommandViewModels.ts`  |      | 
  | Configuration Settings      | [portalfx-load-configuration.md](portalfx-load-configuration.md)                                                                          | `<dir>\Configuration\ArmConfiguration.cs`                                     |
  | Content Delivery Network    | [portalfx-cdn.md](portalfx-cdn.md)                                                                                                        |  `<dir>\Configuration\CustomApplicationContext.cs`                            | 
  | Localizing your extension |  [portalfx-localization.md](portalfx-localization.md) | `<dir>\Client\ClientResources.resx` | |
  | Performant Extensions       | [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md)                                                            | `<dir>\Client\V1\Controls\Grid\ViewModels\ PageableGridViewModel.ts`          | 
  | Testing Commands            | [portalfx-testing-using-commands.md](portalfx-testing-using-commands.md)                                                                  |                                                                               |
  | Testing Forms               | [portalfx-testing-filling-forms.md](portalfx-testing-filling-forms.md)                                                                    | `<dir>`                                                                       | 
  | Testing Parts and Blades    | [portalfx-testing-parts-and-blades.md](portalfx-testing-parts-and-blades.md)   | `<dir>\Client\Blades\BladeKind\ViewModels\BladeKindsViewModels.ts` <br>  `<dir>\Client\Blades\BladeKind\ViewModels\InfoListPartViewModel.ts`  <br> `<dir>\Client\Blades\BladeKind\ViewModels\PropertiesPartViewModel.ts`  <br> `<dir>\Client\Blades\BladeKind\ViewModels\NoticePartViewModel.ts`  <br> `<dir>\Client\Blades\BladeKind\ViewModels\SettingListPartViewModel.ts`                           | 
  | Type metadata               | [portalfx-data-typemetadata.md](portalfx-data-typemetadata.md)                                                                            | `<dirParent>\SamplesExtension.DataModels\ SamplesExtension.DataModels.csproj` | 
  | Versioning an Extension     | [portalfx-extension-versioning.md](portalfx-extension-versioning.md)                                                                      | `<dir>\Content\SamplesExtension\Scripts\ MsPortalFxDocs.js`                   | 

* Version 2 API 

  | API Topic                             | Document                                                                 | Sample                                                           | Experience |
  | ----------------------------------------------  | ------------------------------------------------------------------------ | ---------------------------------------------------------------- | ---------- |
  | Defining Extensions with TypeScript decorators  | [portalfx-no-pdl-programming.md](portalfx-no-pdl-programming.md)         | `<dir>\Client\V2\Blades\Template\ SimpleTemplateBlade.ts`        | [https://aka.ms/portalfx/sampleTypeScript](https://aka.ms/portalfx/sampleTypeScript) | 
  | Copyable Label | | `<dir>\Client\V2\Controls\ CopyableLabel\CopyableLabelBlade.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/CopyableLabelBlade |
  | Extension Controls                              | [portalfx-controls.md](portalfx-controls.md)     |      | [http://aka.ms/portalfx/controls](http://aka.ms/portalfx/controls) |
  | Essentials Control                              | [portalfx-controls-essentials.md](portalfx-controls-essentials.md)       | `<dir>\Client\V2\Controls\Essentials\ EssentialsDefaultBlade.ts` <br>  `<dir>\Client\V2\Controls\Essentials\ EssentialsCustomLayoutBlade.ts` <br>   `<dir>\Client\V2\Controls\Essentials\EssentialsNonResourceBlade.ts` <br> `<dir>\Client\V2\Controls\Essentials\EssentialsResponsiveBlade.ts` | |
  | Plotting Metrics                                | [portalfx-controls-monitor-chart.md](portalfx-controls-monitor-chart.md) | `<dir>\Client\V2\Preview\MonitorChart\ MonitorChartBlade.ts`     | [https://aka.ms/portalfx/sampleMonitorChart](https://aka.ms/portalfx/sampleMonitorChart) |
  | Textbox Control                                 | [portalfx-controls-textbox.md](portalfx-controls-textbox.md)             | `<dir>\Client\V2\Controls\TextBox\ TextBoxBlade.ts`              | [https://aka.ms/portalfx/sampleTextBox](https://aka.ms/portalfx/sampleTextBox) |

* Version 1 API

  * Introductions

    | API Topic             | Document                                                                                             | Sample                                                            | Experience |
    | ------------------------------ | ---------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | ---------- |
    | Create ARM Resource Experience | [portalfx-create-engine-sample.md](portalfx-create-engine-sample.md)                 |  | [https://aka.ms/portalfx/sampleCreateEngine](https://aka.ms/portalfx/sampleCreateEngine)  |
    | Create Custom Experience       | [portalfx-create-robot-sample.md](portalfx-create-robot-sample.md)                   |     | |
    | Forms with EditScopes          | [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md)             | `<diriewModels.ts`    | |`<dir>\Client\V1\MasterDetail\MasterDetailEdit\ViewModels\MasterDetailEditData.ts`  | 
    | Forms Without EditScopes       | [portalfx-forms-editscopeless.md](portalfx-forms-editscopeless.md)      |   | |
    | Getting Started                | [portalfx-parameter-collection-getting-started.md](portalfx-parameter-collection-getting-started.md) | `<dir>\Client\V1\ParameterCollection\ ParameterCollectionArea.ts` | |
 
  * Scenarios 
    
    | Scenario        | Document                                                                                         | Sample | 
    | --------------------- | ------------------------------------------------------------------------------------------------ | ------ | 
    | EditScopeAccessor | [portalfx-legacy-editscopes.md#editscopeaccessor](portalfx-legacy-editscopes.md#editscopeaccessor) |     `<dir>/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts`       `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\DetailViewModels.ts`     |  
  
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
    | Data Transformations                | [portalfx-data-projections.md](portalfx-data-projections.md)                 | `<dir>\Client\V1\Data\Projection\ ViewModels\MapAndMapIntoViewModels.ts`     <br> `<dir>\Client\V1\Data\Projection\ ViewModels\ProjectionBladeViewModel.ts`     <br>      `<dir>\Client/V1/Data/Projection/ViewModels/ProjectionBladeViewModel.ts`      | 
    | DataNavigator for Virtualized Data  | [portalfx-data-virtualizedgriddata.md](portalfx-data-virtualizedgriddata.md) | `<dir>\Client\V1\Controls\Grid\Templates\ PageableGridViewModel.ts` <br>      `<dir>\Client\V1\Controls\ProductData.ts`  <br>    `<dir>\Client\V1\Controls\ProductPageableData.ts`     | 
    | Extension Outputs                   | [portalfx-blades-outputs.md](portalfx-blades-outputs.md)                     |  `<dir>\Client\Bindings\OutputBindings\ OutputBindings.pdl` | 
    | Loading Data                        | [portalfx-data-loadingdata.md](portalfx-data-loadingdata.md)                 | `<dir>\Client\V1\Data\SupplyData\SupplyData.ts` | 
    | Polling and Refreshing Data         | [portalfx-data-refreshingdata.md](portalfx-data-refreshingdata.md)           | `<dir>\Client\V1\ResourceTypes\SparkPlug \SparkPlugData.ts` <br>    `<dir>\Client\V1\Hubs\RobotData.ts` <br>    `<dir>/Client/V1/Hubs/RobotData.ts` <br> `<dir>/Client/V1/Hubs/ComputerData.ts` | 
    
  * View Components
    
    | API ScreenObject           | Document | Sample | Experience |
    | -------------------------- | -------- | ------ | ---------- |
    | AppBlades                  | [portalfx-blades-appblades.md](portalfx-blades-appblades.md)                         | `<dir>\Client\V1\Blades\AppBlade\ ViewModels\AppBladeViewModel.ts`   |  |
    | Basic Form                 | [portalfx-forms-sections.md](portalfx-forms-sections.md) | `<dir>\Client\V1\Forms\Samples\Basic\ ViewModels\Parts\FormsSampleBasicBlades.ts` | [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup) |
    | Basic Form Create          | [portalfx-forms-sections.md](portalfx-forms-sections.md)                             | `<dir>\Client\V1\Forms\Samples\BasicCreate\ ViewModels\Parts\FormsSampleBasicCreatePart.ts` | 
    | Browse Experience          | [portalfx-browse.md](portalfx-browse.md)                                             | `<dir>\Client\V1\Hubs\Browse\Browse.pdl` <br>  `<dir>\Client\Hubs\Browse\Services\RobotGridColumnsService.ts`  `<dir>\Client\Shared\SharedArea.ts` <br>`<dir>\Client\Hubs\Browse\Services\RobotBrowseService.ts`     | |
    | Button Parts               | [portalfx-parts.md](portalfx-parts.md)                                               | `<dir>\Client\V1\Parts\Intrinsic\ ViewModels\ButtonPartViewModel.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction) | 
    | Console                    | [portalfx-controls-console.md](portalfx-controls-console.md)                         | `<dir>\Client\V1\Controls\Console2\ ViewModels\Console2ViewModels.ts` |  |
    | Controls Chart    | [portalfx-controls-chart.md](portalfx-controls-chart.md)     |  `<dir>\Client\V1\Controls\Chart\ViewModels\BarChartViewModels.ts` <br>     `<dir>\Client\V1\Controls\Chart\ViewModels\OverlayedViewChartViewModel.ts` `\Client\Controls\Chart\ViewModels\LineChartDateBasedViewModels.ts` |  |
    | Create Form                | [portalfx-create.md](portalfx-create.md)                                             | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts`      | |
    | Donut                 | [portalfx-controls-donut.md](portalfx-controls-donut.md)          | `<dir>/Client/V2/Controls/Donut/DonutBlade.ts`      | |
    | DateTimePicker             | [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md)           | `<dir>\Client\V2\Controls\DateTimePicker\ DateTimePickerBlade.ts`  | [http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimePickerInstructions/selectedItem/DateTimePickerInstructions/selectedValue/DateTimePickerInstruction](http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimePickerInstructions/selectedItem/DateTimePickerInstructions/selectedValue/DateTimePickerInstruction) |
    | DateTimeRangePicker        | [portalfx-controls-datetimerangepicker.md](portalfx-controls-datetimerangepicker.md) | `<dir>\Client\V2\Controls\ DateTimeRangePicker\DateTimeRangePickerBlade.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions)  
    | Display data across blades | [portalfx-data-masterdetailsbrowse.md](portalfx-data-masterdetailsbrowse.md)         | `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\DetailViewModels.ts`  <br>      `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\MasterViewModels.ts`  <br>      `<dir>\Client\V1\MasterDetail\MasterDetailArea.ts`  <br>      `<dir>Client\V1\Data\MasterDetailBrowse\MasterDetailBrowseData.ts` | |
    | Drop Down | [portalfx-controls-dropdown.md](portalfx-controls-dropdown.md)         |         `<dir>/Client/V2/Controls/ DropDown/DropDownBlade.ts` | |
    | Editor Control             | [portalfx-controls-editor.md](portalfx-controls-editor.md)                           | `<dir>\Client\V1\Controls\Editor\ ViewModels\EditorViewModels.ts` <br> `<dir>\Client\V1\Controls\Editor\ ViewModels\CustomLanguageEditorViewModels.ts`      | |
    | Essentials panel           | [portalfx-essentials.md](portalfx-essentials.md)                                     | `<dir>\Client\V1\ResourceTypes\Engine\EngineData.ts` <br>      `<dir>\Client\V1\ResourceTypes\Engine\ViewModels\EngineResourceSummaryViewModel.ts` | | 
    | Extension User Interface   | [portalfx-blades-ui.md](portalfx-blades-ui.md)                                       | `<dir>\Client\Blades\Template\ViewModels\ TemplateBladeViewModels.ts`  <br>      `<dir>\Client\ContentState\ViewModels\ContentStateViewModels.ts`      | |
    | File Download Button |  | `<dir>\Client\V1\Controls\FileDownloadButton\ViewModels\ FileDownloadButtonViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/FileDownloadButtonInstructions/selectedItem/FileDownloadButtonInstructions/selectedValue/FileDownloadButtonInstructions |  
    | File Upload (async) |  | `<dir>\Client\V1\Controls\AsyncFileUpload\ViewModels\ AsyncFileUploadViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/AsyncFileUploadInstructions/selectedItem/AsyncFileUploadInstructions/selectedValue/AsyncFileUploadInstructions |
    | Form Construction          | [portalfx-forms-construction.md](portalfx-forms-construction.md)                     | `<dir>\Client\V1\Forms\Samples\Basic\ ViewModels\FormsSampleBasicBlade.ts` | |
    | Form Field Validation      | [portalfx-forms-field-validation.md](portalfx-forms-field-validation.md)             | `<dir>\Client\V1\Forms\Samples\Validations\ ViewModels\FormValidationsViewModels.ts` | |
    | Form Sections                  | [portalfx-forms-sections.md](portalfx-forms-sections.md)                         | `<dir>\Client\V1\Forms\Samples\Validations\ ViewModels\FormValidationsViewModels.ts` | |
    | Fx Controls in EditScope forms | [portalfx-fxcontrols-editscope-forms.md](portalfx-fxcontrols-editscope-forms.md)  [portalfx-extension-pricing-tier.md](portalfx-extension-pricing-tier.md) | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` <br>      `<dir>\Client/V1/Hubs/PricingV3/ViewModels/Robot/RobotSpecPickerV3BladeViewModel.ts` <br>    `<dir>\Client/V1/Hubs/PricingV3/ViewModels/Robot/RobotSpecPickerV3Extender.ts`      | [https://aka.ms/portalfx/samplecreateengine](https://aka.ms/portalfx/samplecreateengine) | 
    | Grid and Grid Controls     | [portalfx-controls-grid.md](portalfx-controls-grid.md)                               | `<dir>\Client\V1\Controls\Grid\ ViewModels\ScrollableGridWithFilteringAndSorting.ts`     `<dir>/Client/V1/Controls/Grid/ViewModels/BasicGridViewModel.ts`     `<dir>Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts`      | [http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions) |
    | Hubs Extension             | [portalfx-hubsextension-pde.md](portalfx-hubsextension-pde.md)                       | `<dir>\Client\Hubs\PricingV3` <br>     `<dir>\Client/Hubs/ScopedBrowse/ViewModels/ScopedBrowseLauncherPartViewModel.ts`      | [https://aka.ms/portalfx/sampleHub](https://aka.ms/portalfx/sampleHub) |
    | Icon                       | [portalfx-icons.md](portalfx-icons.md)                                               | `<dir>\Client\V1\UI\ViewModels\Blades\ IconBladeViewModels.ts` | | 
    | Intrinsic Tile             | [portalfx-parts-intrinsic.md](portalfx-parts-intrinsic.md)                           | `<dir>\Client\V1\Parts\Intrinsic\ ViewModels\IntrinsicBladeViewModel.ts` | [https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade](https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade) | 
    | Markdown Control | |`<dir>\Client\V1\Controls\Markdown\ViewModels\ MarkdownViewModels.ts`| http://aka.ms/portalfx/samples#blade/SamplesExtension/MarkdownInstructions/selectedItem/MarkdownInstructions/selectedValue/MarkdownInstructions |
    | Pinning Parts              | [portalfx-parts-pinning.md](portalfx-parts-pinning.md)                               | `<dir>\Client\V1\Hubs\Browse\Browse.pdl` | | 
    | Portal Parts               | [portalfx-parts.md](portalfx-parts.md)  | `<dir>\Client\V1\Parts\PartsArea.ts` <br>     `<dir>\Client/V1/Parts/TileGallery/ViewModels/GeneralGalleryPart.ts`  <br>     `<dir>\Client/V1/Parts/Intrinsic/ViewModels/ButtonPartViewModel.ts` <br>     `<dir>\Client/V1/Parts/Custom/ViewModels/ExampleCustomPartViewModel.ts` <br>     `<dir>\Client/V1/Parts/PartSizes/ViewModels/PartSizesViewModels.ts`     |
    | Single Setting |   | `<dir>\Client\V1\Controls\SingleSetting\ViewModels\ SingleSettingViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SingleSettingInstructions/selectedItem/SingleSettingInstructions/selectedValue/SingleSettingInstructions | 
    | Text Block  |  | `<dir>\Client\V1\Controls\TextBlock\ViewModels\ TextBlockViewModels.ts` | https://df.onecloud.azure-test.net/?samplesExtension=true#blade/SamplesExtension/TextBlockInstructions/selectedItem/TextBlockInstructions/selectedValue/TextBlockInstructions | 
    | Toolbar   | [portalfx-blades-templateBlade.md](portalfx-blades-templateBlade.md)  <br> [portalfx-controls-toolbar.md](portalfx-controls-toolbar.md)  |`<dir>\Client\V1\Blades\Toolbar\BladeWithToolbarViewModels.ts` <br> `<dir>\Client\V1\Controls\Toolbar\ViewModels\ToolbarViewModels.ts` <br> `<dir>\Client\V1\Controls\Toolbar\ViewModels\ ToolbarViewModels.ts` | (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/ToolbarInstructions/selectedItem/ToolbarInstructions/selectedValue/ToolbarInstructions |
    | View Model                 | [portalfx-blade-viewmodel.md](portalfx-blade-viewmodel.md)                           | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels`       |  |
    
  * Controller Components

    | API Controller Topic               | Document | Sample | Experience |
    | ------------------------------ | -------- | ------ | ---------- |
    | Blade Properties               | [portalfx-blades-properties.md](portalfx-blades-properties.md)                           | `<dir>\Client\V1\Blades\Properties\ ViewModels\BladePropertyViewModels.ts`  <br> `<dir>\Client\V1\Hubs\Browse\ViewModels\RobotBladeViewModel.ts`     | | 
    | Closing an Extension           | [portalfx-blades-closing.md](portalfx-blades-closing.md)                                 | `<dir>\Client\V1\Commands\OpenBladeCommand\ ViewModels\OpenBladeCommandViewModels.ts` |  [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi) |
    | Menu Blade                     | [portalfx-blades-menublade.md](portalfx-blades-menublade.md)                             | `<dir>\Client\V1\Blades\MenuBlade\ ViewModels\SampleMenuBlade.ts`| [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions) | 
    | Opening an Extension      | [portalfx-blades-opening.md](portalfx-blades-opening.md)                                 | `<dir>\Client\V1\Commands\OpenBladeCommand\ ViewModels\OpenBladeCommandViewModels.ts` <br>     `<dir>\Client\V1\Bindings\InputBindingsDifferentBlades\ViewModels\InputBindingsDifferentBladesViewModels.ts` <br>     `<dir>\Client\Navigation\DynamicBlades\ViewModels\DynamicBladesViewModels.ts` <br> `<dir>\Client\ParameterCollection\CollectorAsHotSpot\ViewModels\CompositePartHotSpotViewModel.ts` <br>   `<dir\Client\V1\Bindings\DynamicSelectableRegistration\ViewModels\DynamicHotspots.ts` |  [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi)  |
    | Pricing Tier Blade             | [portalfx-extension-pricing-tier.md](portalfx-extension-pricing-tier.md)                 | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | |
    | Template Blades                | [portalfx-blades-templateblade-reference.md](portalfx-blades-templateblade-reference.md) | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels.ts` <br>     `<dir>\Client\V1\Data\ClientSideSortFilter\ViewModels\ViewModels.ts` <br>     `<dir>\Client\V1\Blades\Template\ViewModels\TemplateBladeViewModels.ts`  | |
    | TemplateBlade Advanced Options | [portalfx-blades-templateblade-advanced.md](portalfx-blades-templateblade-advanced.md)   | `<dir>/Client/V1/Blades/Template/ViewModels/TemplateBladeViewModels.ts` <br> `<dir>/Client/V1/Blades/ContentState/ViewModels/ContentStateViewModels.ts` <br>      `<dir>/Client/V1/Blades/DynamicNotice/ViewModels/DynamicNoticeViewModels.ts` <br> `<dir>Client/V1/Blades/Unauthorized/ViewModels/UnauthorizedBladeViewModel.ts`  | 

 ## Procedures for Portal Sample Source Code

After installing Visual Studio and the Portal Framework SDK, locate the samples in the `...\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

Open the `SamplesExtension` solution file to experiment with samples in the IDE.

You can make changes to the samples as appropriate.

Click the F5 key to start debugging the sample extensions. This rebuilds the project, which will allow you to check for items like the most recent version of the SDK.

Sideload the extension. When it loads, click on the `More Services` option in the menu, as in the following example.

 ![alt-text](../media/top-extensions-samples/samples-services.png  "Portal Extensions Services")

In the filter box, search for "Azure Portal SDK". You can use `Shift + Space` to mark it as a favorite site.

Make changes to the sample that best fits the needs of the development project, then refresh the Portal to view the changes. 


 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                  | Meaning | 
| ---                   | --- |
| AMD                   | |
| EditScope             | An Azure SDK object that provides a standard way of managing edits over a collection of input fields, blades, and extensions. |
| ParameterCollector    | A collection of Parameter and Parameter-derived objects that are used by data source controls in advanced data-binding scenarios. |
