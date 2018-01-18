<a name="portal-extension-samples"></a>
# Portal Extension Samples

 ## Overview

One of the most productive ways to learn how to develop code is by reviewing program source.  The Azure Portal team ships samples that extension developers can leverage.

All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples).

<a name="portal-extension-samples-samples-extension"></a>
## Samples extension

The samples extension provides an individual sample for each feature available in the framework, as described in the following image.

 ![alt-text](../media/Portalfx-extensions-samples/samples.png  "Samples Extension Solution")

After installing the Portal Framework SDK, the local instance of the Portal will open with the samples extension pre-registered.  You can open the `SamplesExtension` solution file to experiment with samples in the IDE.

```bash
[My Documents]\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\SamplesExtension.sln
```

The samples and the Portal can be located with **IntelliMirror** in the following location.

```bash
%LOCALAPPDATA%\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\SamplesExtension.sln
```

Each sample demonstrates a single usage of the API. It is great for detailed information on any one API. You can edit the samples and then refresh the Portal to see the changes. 

For help other than documentation and samples, send an email to the Ibiza team on [Stackoverflow@MS](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza). For a list of topics and stackoverflow tags, see [Portalfx-extensions-stackoverflow.md](Portalfx-extensions-stackoverflow.md).

<!-- TODO: Determine whether there should be a list of samples and whether they are V1 or V2.   
The alternative is to let the list default to the contents of the SamplesExtension.sln project, and the reverse cross-reference that is created by documents like Portalfx-blades-appblades.md. -->

<a name="portal-extension-samples-v1-versus-v2"></a>
## V1 versus V2

The samples are structured into two directories, **V1** and **V2**, as in the following example. 

 ![alt-text](../media/Portalfx-extensions-samples/v1-and-v2.png  "V1 and V2 Directories")

<!--TODO: Can "meant" be changed to "will"  or "intended" ? -->

<a name="portal-extension-samples-v1-versus-v2-v2"></a>
### V2

The samples in the **V2** directories use the most recent patterns. It contains the post-GA collection of new APIs that are meant to be the only set of APIs needed to develop an Ibiza extension.

The **V2** samples address the following API areas.

* New variations TemplateBlade, FrameBlade, MenuBlade 

* Blade-opening and closing `container.openBlade`, among others

* no-PDL TypeScript decorators that define all recommended Blade/Part variations

* Forms that do not use **V1** EditScope. For more information about EditScope, see [Portalfx-forms-edit-scope-faq.md](Portalfx-forms-edit-scope-faq.md).

<a name="portal-extension-samples-v1-versus-v2-v1"></a>
### V1

Our **V1** APIs use APIs that support previous UX patterns, or  are becoming obsolete or are less commonly used.  The **V1** APIs are also more difficult to use than the new API, for both the UX design and  the associated APIs.

The following **V1** concepts should be avoided when **V2** APIs can be used instead.

* Blades containing Parts
* **V1** Blade-opening -- Selectable/SelectableSet APIs
* EditScope
* Fixed-width Blades
* **V1** Forms that use EditScope
* ParameterCollector/ParameterProvider
* PDL

**NOTE**: Building the **V2** space is still in process, therefore  the previously-listed **V1** concepts are not completely deprecated. For example, the source code for small, medium, and large blades is located in the `<dir>\Client\V1\Blades\BladeWidth` directory. In the meantime, use **V1** APIs in places where a ***v2*** replacement is not evident.

<a name="portal-extension-samples-sample-source-code"></a>
## Sample Source Code

Sample source code is included in topics that discuss the various Azure SDK API items. In the following tables, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to Dogfood copies of samples are included in the tables as appropriate.

* All Azure API's

  | API Topic            | Document | Sample | 
  | --------------------------  | ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------   | 
  | Bundling and Configuration  | [Portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md](Portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md)  |                                                                               | 
  | Configuration Settings      | [Portalfx-load-configuration.md](Portalfx-load-configuration.md)                                                                          | `<dir>\Configuration\ArmConfiguration.cs`                                     |
  | Content Delivery Network    | [Portalfx-cdn.md](Portalfx-cdn.md)                                                                                                        |  `<dir>\Configuration\CustomApplicationContext.cs`                            | 
  | Localizing your extension |  [Portalfx-localization.md](Portalfx-localization.md) | `<dir>\Client\ClientResources.resx` | |
  | Performant Extensions       | [Portalfx-performance-bestpractices.md](Portalfx-performance-bestpractices.md)                                                            | `<dir>\Client\V1\Controls\Grid\ViewModels\ PageableGridViewModel.ts`          | 
  | Testing Commands            | [Portalfx-testing-using-commands.md](Portalfx-testing-using-commands.md)                                                                  |                                                                               |
  | Testing Forms               | [Portalfx-testing-filling-forms.md](Portalfx-testing-filling-forms.md)                                                                    | `<dir>`                                                                       | 
  | Testing Parts and Blades    | [Portalfx-testing-parts-and-blades.md](Portalfx-testing-parts-and-blades.md)                                                              | `<dir>`                                                                       | 
  | Type metadata               | [Portalfx-data-typemetadata.md](Portalfx-data-typemetadata.md)                                                                            | `<dirParent>\SamplesExtension.DataModels\ SamplesExtension.DataModels.csproj` | 
  | Versioning an Extension     | [Portalfx-extension-versioning.md](Portalfx-extension-versioning.md)                                                                      | `<dir>\Content\SamplesExtension\Scripts\ MsPortalFxDocs.js`                   | 

* Version 2 API 

  | API Topic                             | Document                                                                 | Sample                                                           | Experience |
  | ----------------------------------------------  | ------------------------------------------------------------------------ | ---------------------------------------------------------------- | ---------- |
  | Defining Extensions with TypeScript decorators  | [Portalfx-no-pdl-programming.md](Portalfx-no-pdl-programming.md)         | `<dir>\Client\V2\Blades\Template\ SimpleTemplateBlade.ts`        | [https://aka.ms/Portalfx/sampleTypeScript](https://aka.ms/Portalfx/sampleTypeScript) | 
  | Extension Controls                              | [Portalfx-controls.md](Portalfx-controls.md)                             |                                                                  | [http://aka.ms/Portalfx/controls](http://aka.ms/Portalfx/controls) |
  | Essentials Control                              | [Portalfx-controls-essentials.md](Portalfx-controls-essentials.md)       | `<dir>\Client\V2\Controls\Essentials\ EssentialsDefaultBlade.ts` | |
  | Plotting Metrics                                | [Portalfx-controls-monitor-chart.md](Portalfx-controls-monitor-chart.md) | `<dir>\Client\V2\Preview\MonitorChart\ MonitorChartBlade.ts`     | [https://aka.ms/Portalfx/sampleMonitorChart](https://aka.ms/Portalfx/sampleMonitorChart) |
  | Textbox Control                                 | [Portalfx-controls-textbox.md](Portalfx-controls-textbox.md)             | `<dir>\Client\V2\Controls\TextBox\ TextBoxBlade.ts`              | [https://aka.ms/Portalfx/sampleTextBox](https://aka.ms/Portalfx/sampleTextBox) |

* Version 1 API

  * Introductions

    | API Topic             | Document                                                                                             | Sample                                                            | Experience |
    | ------------------------------ | ---------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | ---------- |
    | Create ARM Resource Experience | [Portalfx-create-engine-sample.md](Portalfx-create-engine-sample.md)                                 |                                                                   | [https://aka.ms/Portalfx/sampleCreateEngine](https://aka.ms/Portalfx/sampleCreateEngine)  |
    | Create Custom Experience       | [Portalfx-create-robot-sample.md](Portalfx-create-robot-sample.md)                                   |                                                                   | |
    | Forms with EditScopes          | [Portalfx-forms-working-with-edit-scopes.md](Portalfx-forms-working-with-edit-scopes.md)             | `<dir>\Client\V1\MasterDetail\ MasterDetailEdit\ViewModels.ts`    | |
    | Forms Without EditScopes       | [Portalfx-editscopeless-forms.md](Portalfx-editscopeless-forms.md)                                   |                                                                   | |
    | Getting Started                | [Portalfx-parameter-collection-getting-started.md](Portalfx-parameter-collection-getting-started.md) | `<dir>\Client\V1\ParameterCollection\ ParameterCollectionArea.ts` | |
 
  * Scenarios 
    
    | Scenario        | Document                                                                                         | Sample | 
    | --------------------- | ------------------------------------------------------------------------------------------------ | ------ | 
    | EditScopeAccessor | [portalfx-forms-working-with-edit-scopes.md#editscopeaccessor](portalfx-forms-working-with-edit-scopes.md#editscopeaccessor) |     `<dir>/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts` |  
  
  * Debugging and Logging

    | API Topic      | Document                                                                                         | Sample | 
    | --------------------- | ------------------------------------------------------------------------------------------------ | ------ | 
    | Logging and Debugging | [Portalfx-logging-from-typescript-and-dotnet.md](Portalfx-logging-from-typescript-and-dotnet.md) | `<dir>\Client\V1\Diagnostics\Logging\ ViewModels\LoggingViewModels.ts` |  
    | Logging Telemetry     | [Portalfx-telemetry-logging.md](Portalfx-telemetry-logging.md)                                   | `<dir>\Configuration\ApplicationConfiguration.cs` |  
    
  The following tables are categorized by the Model-View-Controller model, rather than the Model-View-View-Model model.

  * Modeling Data

    | API  Data Model Element                   | Document                                                                     | Sample | 
    | ----------------------------------- | ---------------------------------------------------------------------------- | ------ | 
    | Data View                           | [Portalfx-data-overview.md](Portalfx-data-overview.md)                       |  `<dir>\Client\V1\MasterDetail\MasterDetailEdit\ ViewModels\MasterViewModels.ts`  | 
    | Data Transformations                | [Portalfx-data-projections.md](Portalfx-data-projections.md)                 | `<dir>\Client\V1\Data\Projection\ ViewModels\MapAndMapIntoViewModels.ts` | 
    | DataNavigator for Virtualized Data  | [Portalfx-data-virtualizedgriddata.md](Portalfx-data-virtualizedgriddata.md) | `<dir>\Client\V1\Controls\Grid\Templates\ PageableGridViewModel.ts` | 
    | Extension Outputs                   | [Portalfx-blades-outputs.md](Portalfx-blades-outputs.md)                     |  `<dir>\Client\Bindings\OutputBindings\ OutputBindings.pdl` | 
    | Loading Data                        | [Portalfx-data-loadingdata.md](Portalfx-data-loadingdata.md)                 | `<dir>\Client\V1\Data\SupplyData\SupplyData.ts` | 
    | Polling and Refreshing Data         | [Portalfx-data-refreshingdata.md](Portalfx-data-refreshingdata.md)           | `<dir>\Client\V1\ResourceTypes\SparkPlug \SparkPlugData.ts` | 
    
  * View Components
    
    | API ScreenObject           | Document | Sample | Experience |
    | -------------------------- | -------- | ------ | ---------- |
    | AppBlades                  | [Portalfx-blades-appblades.md](Portalfx-blades-appblades.md)                         | `<dir>\Client\V1\Blades\AppBlade\ ViewModels\AppBladeViewModel.ts`   |  |
    | Basic Form                 | [Portalfx-forms-sections.md](Portalfx-forms-sections.md) | `<dir>\Client\V1\Forms\Samples\Basic\ ViewModels\Parts\FormsSampleBasicBlades.ts` | [http://aka.ms/Portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup](http://aka.ms/Portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup) |
    | Basic Form Create          | [Portalfx-forms-sections.md](Portalfx-forms-sections.md)                             | `<dir>\Client\V1\Forms\Samples\BasicCreate\ ViewModels\Parts\FormsSampleBasicCreatePart.ts` | 
    | Browse Experience          | [Portalfx-browse.md](Portalfx-browse.md)                                             | `<dir>\Client\V1\Hubs\Browse\Browse.pdl` | |
    | Button Parts               | [Portalfx-parts.md](Portalfx-parts.md)                                               | `<dir>\Client\V1\Parts\Intrinsic\ ViewModels\ButtonPartViewModel.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction) | 
    | Console                    | [Portalfx-controls-console.md](Portalfx-controls-console.md)                         | `<dir>\Client\V1\Controls\Console2\ ViewModels\Console2ViewModels.ts` |  |
    | Create Form                | [Portalfx-create.md](Portalfx-create.md)                                             | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | |
    | DateTimePicker             | [Portalfx-controls-datetimepicker.md](Portalfx-controls-datetimepicker.md)           | `<dir>\Client\V1\Controls\DateTimePicker\ ViewModels\DateTimePickerViewModels.ts`  | [http://aka.ms/Portalfx/samples#blade/SamplesExtension/DateTimePickerInstructions/selectedItem/DateTimePickerInstructions/selectedValue/DateTimePickerInstruction](http://aka.ms/Portalfx/samples#blade/SamplesExtension/DateTimePickerInstructions/selectedItem/DateTimePickerInstructions/selectedValue/DateTimePickerInstruction) |
    | DateTimeRangePicker        | [Portalfx-controls-datetimerangepicker.md](Portalfx-controls-datetimerangepicker.md) | `<dir>\Client\V1\Controls\DateTimeRangePicker\ ViewModels\DateTimeRangePickerViewModels.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions)  
    | Display data across blades | [Portalfx-data-masterdetailsbrowse.md](Portalfx-data-masterdetailsbrowse.md)         | `<dir>\Client\V1\MasterDetail\MasterDetailArea.ts` | |
    | Editor Control             | [Portalfx-controls-editor.md](Portalfx-controls-editor.md)                           | `<dir>\Client\V1\Controls\Editor\ ViewModels\EditorViewModels.ts` | |
    | Essentials panel           | [Portalfx-essentials.md](Portalfx-essentials.md)                                     | `<dir>\Client\V1\ResourceTypes\Engine\EngineData.ts` | | 
    | Extension User Interface   | [Portalfx-blades-ui.md](Portalfx-blades-ui.md)                                       | `<dir>\Client\Blades\Template\ViewModels\ TemplateBladeViewModels.ts` | |
    | Form Construction          | [Portalfx-forms-construction.md](Portalfx-forms-construction.md)                     | `<dir>\Client\V1\Forms\Samples\Basic\ ViewModels\FormsSampleBasicBlade.ts` | |
    | Form Field Validation      | [Portalfx-forms-field-validation.md](Portalfx-forms-field-validation.md)             | `<dir>\Client\V1\Forms\Samples\Validations\ ViewModels\FormValidationsViewModels.ts` | |
    | Form Sections                  | [Portalfx-forms-sections.md](Portalfx-forms-sections.md)                         | `<dir>\Client\V1\Forms\Samples\Validations\ ViewModels\FormValidationsViewModels.ts` | |
    | Fx Controls in EditScope forms | [Portalfx-fxcontrols-editscope-forms.md](Portalfx-fxcontrols-editscope-forms.md) | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | [https://aka.ms/Portalfx/samplecreateengine](https://aka.ms/Portalfx/samplecreateengine) | 
    | Grid and Grid Controls     | [Portalfx-controls-grid.md](Portalfx-controls-grid.md)                               | `<dir>\Client\V1\Controls\Grid\ ViewModels\ScrollableGridWithFilteringAndSorting.ts` | [http://aka.ms/Portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions](http://aka.ms/Portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions) |
    | Hubs Extension             | [Portalfx-hubsextension-pde.md](Portalfx-hubsextension-pde.md)                       | `<dir>\Client\Hubs\PricingV3` | [https://aka.ms/Portalfx/sampleHub](https://aka.ms/Portalfx/sampleHub) |
    | Icon                       | [Portalfx-icons.md](Portalfx-icons.md)                                               | `<dir>\Client\V1\UI\ViewModels\Blades\ IconBladeViewModels.ts` | | 
    | Intrinsic Tile             | [Portalfx-parts-intrinsic.md](Portalfx-parts-intrinsic.md)                           | `<dir>\Client\V1\Parts\Intrinsic\ ViewModels\IntrinsicBladeViewModel.ts` | [https://aka.ms/Portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade](https://aka.ms/Portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade) | 
    | Pinning Parts              | [Portalfx-parts-pinning.md](Portalfx-parts-pinning.md)                               | `<dir>\Client\V1\Hubs\Browse\Browse.pdl` | | 
    | Portal Parts               | [Portalfx-parts.md](Portalfx-parts.md)                                               | `<dir>\Client\V1\Parts\PartsArea.ts` |
    | Toolbar        | [Portalfx-blades-templateBlade.md](Portalfx-blades-templateBlade.md)|  `<dir>\Client\V1\Blades\Toolbar\BladeWithToolbarViewModels.ts` | 
    | View Model                 | [Portalfx-blade-viewmodel.md](Portalfx-blade-viewmodel.md)                           | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels` |  |
    
  * Controller Components

    | API Controller Topic               | Document | Sample | Experience |
    | ------------------------------ | -------- | ------ | ---------- |
    | Blade Properties               | [Portalfx-blades-properties.md](Portalfx-blades-properties.md)                           | `<dir>\Client\V1\Blades\Properties\ ViewModels\BladePropertyViewModels.ts` | | 
    | Closing an Extension           | [Portalfx-blades-closing.md](Portalfx-blades-closing.md)                                 | `<dir>\Client\V1\Commands\OpenBladeCommand\ ViewModels\OpenBladeCommandViewModels.ts` |  [http://aka.ms/Portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/Portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi) |
    | Menu Blade                     | [Portalfx-blades-menublade.md](Portalfx-blades-menublade.md)                             | `<dir>\Client\V1\Blades\MenuBlade\ ViewModels\SampleMenuBlade.ts`| [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions) | 
    | Opening an Extension           | [Portalfx-blades-opening.md](Portalfx-blades-opening.md)                                 | `<dir>\Client\V1\Commands\OpenBladeCommand\ ViewModels\OpenBladeCommandViewModels.ts` |  [http://aka.ms/Portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/Portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi) |
    | Pricing Tier Blade             | [Portalfx-extension-pricing-tier.md](Portalfx-extension-pricing-tier.md)                 | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | |
    | Template Blades                | [Portalfx-blades-templateblade-reference.md](Portalfx-blades-templateblade-reference.md) | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels.ts` | |
    | TemplateBlade Advanced Options | [Portalfx-blades-templateblade-advanced.md](Portalfx-blades-templateblade-advanced.md)   |  |


 ## Procedures for Portal Sample Source Code

After installing Visual Studio and the Portal Framework SDK, locate the samples in the `...\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

Open the `SamplesExtension` solution file to experiment with samples in the IDE.

You can make changes to the samples as appropriate.

Click the F5 key to start debugging the sample extensions. This rebuilds the project, which will allow you to check for items like the most recent version of the SDK.

Sideload the extension. When it loads, click on the `More Services` option in the menu, as in the following example.

 ![alt-text](../media/portalfx-extensions-samples/samples-services.png  "Portal Extensions Services")

In the filter box, search for "Azure Portal SDK". You can use `Shift + Space` to mark it as a favorite site.

Make changes to the sample that best fits the needs of the development project, then refresh the Portal to view the changes. 


 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                  | Meaning | 
| ---                   | --- |
| AMD                   | |
| EditScope             | An Azure SDK object that provides a standard way of managing edits over a collection of input fields, blades, and extensions. |
| ParameterCollector    | A collection of Parameter and Parameter-derived objects that are used by data source controls in advanced data-binding scenarios. |
