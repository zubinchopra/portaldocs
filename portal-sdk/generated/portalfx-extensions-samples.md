<a name="portal-extension-samples"></a>
# Portal Extension Samples

 ## Overview

One of the most productive ways to learn how to develop code is by reviewing program source.  The Azure portal team ships samples that extension developers can leverage.

All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation the process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKBlade](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKBlade).

<a name="portal-extension-samples-samples-extension"></a>
## Samples extension

The samples extension provides an individual sample for each feature available in the framework, as described in the following image.

 ![alt-text](../media/portalfx-extensions-samples/samples.png  "Samples Extension Solution")

After installing the Portal Framework SDK, the local instance of the portal will open with the samples extension pre-registered.  You can open the `SamplesExtension` solution file to experiment with samples in the IDE.

```bash
[My Documents]\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\SamplesExtension.sln
```

The samples and the portal can be located with **IntelliMirror** in the following location.

```bash
%LOCALAPPDATA%\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\SamplesExtension.sln
```

You can edit the samples and then refresh the portal to see the changes. Each sample demonstrates a single usage of the API.  It is great for detailed information on any one API.

For help other than documentation and samples, send an email to the Ibiza team on [Stackoverflow@MS](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza). For a list of topics and stackoverflow tags, see [portalfx-extensions-stackoverflow.md](portalfx-extensions-stackoverflow.md).

<!-- TODO: Determine whether there should be a list of samples and whether they are V1 or V2.   
The alternative is to let the list default to the contents of the SamplesExtension.sln project, and the reverse cross-reference that is created by documents like portalfx-blades-appblades.md. -->

<a name="portal-extension-samples-v1-versus-v2"></a>
## V1 versus V2

The samples are structured into two directories, **V1** and **V2**, as in the following example. 

 ![alt-text](../media/portalfx-extensions-samples/v1-and-v2.png  "V1 and V2 Directories")

<!--TODO: Can "meant" be changed to "will"  or "intended" ? -->

<a name="portal-extension-samples-v1-versus-v2-v2"></a>
### V2

The samples in the **V2** directories use the latest patterns. It contains the post-GA collection of new APIs that are meant to be the only set of APIs needed to develop an Ibiza extension.

The **V2** samples address the following API areas.

* New Blade variations TemplateBlade, FrameBlade, MenuBlade 

* Blade-opening/closing `container.openBlade`, et al

* no-PDL TypeScript decorators that define all recommended Blade/Part variations

* Forms that do not use **V1** EditScope. For more information about EditScope, see [portalfx-forms-edit-scope-faq.md](portalfx-forms-edit-scope-faq.md).

<a name="portal-extension-samples-v1-versus-v2-v1"></a>
### V1

Our **V1** APIs use APIs that support previous UX patterns, or  are becoming obsolete or are less commonly used.  The **V1** APIs are also more difficult to use than the new API, for both the UX design and  the associated APIs.

The following **V1** concepts should be avoided when **V2** APIs can be used instead.

* PDL
* EditScope
* ParameterCollector/ParameterProvider
* Blades containing Parts
* Non-full-screen Blades, i.e., ones that open with a fixed width
* **V1** Blade-opening -- Selectable/SelectableSet APIs
* **V1** Forms that use EditScope

**NOTE**: The **V2** space is not yet entirely built. In the meantime, use **V1** APIs in places, even the previously-listed **V1** concepts. For example, the source code for small, medium, and large blades is located in the `<dir>\Client\V1\Blades\BladeWidth` directory.

Sample source code is included in topics that discuss the various Azure SDK API items. The list of topics and samples is as follows, where `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. If there is a working copy of the sample in the Dogfood environment, it can be experienced by using the link in the table.

* All Azure API's

  | API ScreenObject | Document |  Sample | 
  | ---------------- | -------- |  ------ | 
  | Bundling and Configuration | [portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md](portalfx-extensions-migrate-existing-to-extensioncontrollerbase.md)  | | 
  | Configuration Settings | [portalfx-load-configuration.md](portalfx-load-configuration.md)  | `<dir>\Configuration\ArmConfiguration.cs` |
  | Content Delivery Network | [portalfx-cdn.md](portalfx-cdn.md)  | `<dir>\Configuration\CustomApplicationContext.cs` | 
  | Performant Extensions | [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md) | `<dir>\Client\V1\Controls\Grid\ViewModels\ PageableGridViewModel.ts` | 
  | Testing Commands | [portalfx-testing-using-commands.md](portalfx-testing-using-commands.md) |  
  | Testing Forms | [portalfx-testing-filling-forms.md](portalfx-testing-filling-forms.md) |  `<dir>` | 
  | Testing Parts and Blades | [portalfx-testing-parts-and-blades.md](portalfx-testing-parts-and-blades.md) | `<dir>` | 
  | Type metadata | [portalfx-data-typemetadata.md](portalfx-data-typemetadata.md) |`<dirParent>\SamplesExtension.DataModels\ SamplesExtension.DataModels.csproj` | 
  | Versioning an Extension | [portalfx-extension-versioning.md](portalfx-extension-versioning.md) | `<dir>\Content\SamplesExtension\Scripts\ MsPortalFxDocs.js`| 


* Version 2 API 

  | API ScreenObject | Document | Sample | Experience |
  | ---------------- | -------- | ------ | ---------- |
  | Defining Extensions with TypeScript decorators | [portalfx-no-pdl-programming.md](portalfx-no-pdl-programming.md) | `<dir>\Client\V2\Blades\Template\ SimpleTemplateBlade.ts` | [https://aka.ms/portalfx/sampleTypeScript](https://aka.ms/portalfx/sampleTypeScript) | 
  | Extension Controls  | [portalfx-controls.md](portalfx-controls.md) |  | [http://aka.ms/portalfx/controls](http://aka.ms/portalfx/controls) |
  | Essentials Control | [portalfx-controls-essentials.md](portalfx-controls-essentials.md) | `<dir>\Client\V2\Controls\Essentials\ EssentialsDefaultBlade.ts` | |
  | Plotting Metrics | [portalfx-controls-monitor-chart.md](portalfx-controls-monitor-chart.md) | `<dir>\Client\V2\Preview\MonitorChart\ MonitorChartBlade.ts`  | [https://aka.ms/portalfx/sampleMonitorChart](https://aka.ms/portalfx/sampleMonitorChart) |
  | Textbox Control | [portalfx-controls-textbox.md](portalfx-controls-textbox.md) | `<dir>\Client\V2\Controls\TextBox\ TextBoxBlade.ts` | [https://aka.ms/portalfx/sampleTextBox](https://aka.ms/portalfx/sampleTextBox) |

* Version 1 API

  * Introductions

    | API ScreenObject | Document | Sample | Experience |
    | ---------------- | -------- | ------ | ---------- |
    | Create ARM Resource Experience | [portalfx-create-engine-sample.md](portalfx-create-engine-sample.md) | | [https://aka.ms/portalfx/sampleCreateEngine](https://aka.ms/portalfx/sampleCreateEngine)  |
    | Create Custom Experience  | [portalfx-create-robot-sample.md](portalfx-create-robot-sample.md) |  | |
    | Extension Outputs | [portalfx-blades-outputs.md](portalfx-blades-outputs.md) |   `<dir>\Client\Bindings\OutputBindings\ OutputBindings.pdl` | |
    | Extension User Interface | [portalfx-blades-ui.md](portalfx-blades-ui.md) |  `<dir>\Client\Blades\Template\ViewModels\ TemplateBladeViewModels.ts` | |
    | Forms with EditScopes | [portalfx-forms-working-with-edit-scopes.md](portalfx-forms-working-with-edit-scopes.md) |   `<dir>\Client\V1\MasterDetail\ MasterDetailEdit\ViewModels.ts` | |
    | Forms Without EditScopes | [portalfx-editscopeless-forms.md](portalfx-editscopeless-forms.md) | | |
    | Hubs Extension | [portalfx-hubsextension-pde.md](portalfx-hubsextension-pde.md)  | `<dir>\Client\Hubs\PricingV3` | [https://aka.ms/portalfx/sampleHub](https://aka.ms/portalfx/sampleHub) |

  
  * Form Samples

    | API ScreenObject | Document | Sample | Experience |
    | ---------------- | -------- | ------ | ---------- |
    | Basic Form       | [portalfx-forms-sections.md](portalfx-forms-sections.md) |`<dir>\Client\V1\Forms\Samples\BasicCreate\ ViewModels\Parts\FormsSampleBasicCreatePart.ts` | [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup) |
    | Create Form | [portalfx-create.md](portalfx-create.md)  | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | |
    | Form Creation  |  [portalfx-forms-construction.md](portalfx-forms-construction.md) |`<dir>\Client\V1\Forms\Samples\Basic\ ViewModels\FormsSampleBasicBlade.ts` | |
    
  *      Samples 

    | API ScreenObject | Document | Sample | Experience |
    | ---------------- | -------- | ------ | ---------- |
    | AppBlades| [portalfx-blades-appblades.md](portalfx-blades-appblades.md) |  `<dir>\Client\V1\Blades\AppBlade\ ViewModels\AppBladeViewModel.ts` |  |
    | Blade Properties | [portalfx-blades-properties.md](portalfx-blades-properties.md) |`<dir>\Client\V1\Blades\Properties\ ViewModels\BladePropertyViewModels.ts` | | 
    | Browse Experience | [portalfx-browse.md](portalfx-browse.md) |  `<dir>\Client\V1\Hubs\Browse\Browse.pdl` | |
    | Button Parts| [portalfx-parts.md](portalfx-parts.md) |`<dir>\Client\V1\Parts\Intrinsic\ ViewModels\ButtonPartViewModel.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/ButtonPartIntrinsicInstructions/selectedItem/ButtonPartIntrinsicInstructions/selectedValue/ButtonPartIntrinsicInstruction) | 
    | Closing an Extension | [portalfx-blades-closing.md](portalfx-blades-closing.md) | `<dir>\Client\V1\Commands\OpenBladeCommand\ ViewModels\OpenBladeCommandViewModels.ts` |  [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi) |
    | Console | [portalfx-controls-console.md](portalfx-controls-console.md)  | `<dir>\Client\V1\Controls\Console2\ ViewModels\Console2ViewModels.ts` |  |
    | DataNavigator for Virtualized Data | [portalfx-data-virtualizedgriddata.md](portalfx-data-virtualizedgriddata.md) | `<dir>\Client\V1\Controls\Grid\Templates\ PageableGridViewModel.ts` | |
    | Data Transformations | [portalfx-data-projections.md](portalfx-data-projections.md) | `<dir>\Client\V1\Data\Projection\ ViewModels\MapAndMapIntoViewModels.ts` | |
    | Data View| [portalfx-data-overview.md](portalfx-data-overview.md) |  `<dir>\Client\V1\MasterDetail\MasterDetailEdit\ ViewModels\MasterViewModels.ts`  | |
    | DateTimePicker | [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md) | `<dir>\Client\V1\Controls\DateTimePicker\ ViewModels\DateTimePickerViewModels.ts`  | [http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimePickerInstructions/selectedItem/DateTimePickerInstructions/selectedValue/DateTimePickerInstruction](http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimePickerInstructions/selectedItem/DateTimePickerInstructions/selectedValue/DateTimePickerInstruction) |
    | DateTimeRangePicker | [portalfx-controls-datetimerangepicker.md](portalfx-controls-datetimerangepicker.md) | `<dir>\Client\V1\Controls\DateTimeRangePicker\ ViewModels\DateTimeRangePickerViewModels.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions)  
    | Display data across multiple blades | [portalfx-data-masterdetailsbrowse.md](portalfx-data-masterdetailsbrowse.md) |  `<dir>\Client\V1\MasterDetail\MasterDetailArea.ts` | |
    | Editor | [portalfx-controls-editor.md](portalfx-controls-editor.md) | `<dir>\Client\V1\Controls\Editor\ ViewModels\EditorViewModels.ts` | |
    | Essentials panel | [portalfx-essentials.md](portalfx-essentials.md) | `<dir>\Client\V1\ResourceTypes\Engine\EngineData.ts` | | 
    | Getting Started | [portalfx-parameter-collection-getting-started.md](portalfx-parameter-collection-getting-started.md) |    `<dir>\Client\V1\ParameterCollection\ ParameterCollectionArea.ts` | |
    | Grid and Grid Controls | [portalfx-controls-grid.md](portalfx-controls-grid.md) | `<dir>\Client\V1\Controls\Grid\ ViewModels\ScrollableGridWithFilteringAndSorting.ts` | [http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions) |
    | Icon             | [portalfx-icons.md](portalfx-icons.md) |`<dir>\Client\V1\UI\ViewModels\Blades\ IconBladeViewModels.ts` | | 
    | Intrinsic Tiles | [portalfx-parts-intrinsic.md](portalfx-parts-intrinsic.md) | `<dir>\Client\V1\Parts\Intrinsic\ ViewModels\IntrinsicBladeViewModel.ts` | [https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade](https://aka.ms/portalfx/samples/#blade/SamplesExtension/IntrinsicPartsIndexBlade) | 
    | Loading Data | [portalfx-data-loadingdata.md](portalfx-data-loadingdata.md) | `<dir>\Client\V1\Data\SupplyData\SupplyData.ts` | | 
    | Logging and Debugging | [portalfx-logging-from-typescript-and-dotnet.md](portalfx-logging-from-typescript-and-dotnet.md) |`<dir>\Client\V1\Diagnostics\Logging\ ViewModels\LoggingViewModels.ts` |  |
    | Menu Blade | [portalfx-blades-menublade.md](portalfx-blades-menublade.md) |  `<dir>\Client\V1\Blades\MenuBlade\ ViewModels\SampleMenuBlade.ts`| [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/GroupedGridInstructions) | 
    | Opening an Extension | [portalfx-blades-opening.md](portalfx-blades-opening.md) |  `<dir>\Client\V1\Commands\OpenBladeCommand\ ViewModels\OpenBladeCommandViewModels.ts` |  [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi) |
    | Pinning Parts | [portalfx-parts-pinning.md](portalfx-parts-pinning.md) | `<dir>\Client\V1\Hubs\Browse\Browse.pdl` | | 
    | Polling and Refreshing Data | [portalfx-data-refreshingdata.md](portalfx-data-refreshingdata.md) | `<dir>\Client\V1\ResourceTypes\SparkPlug \SparkPlugData.ts` | |
    | Portal Parts | [portalfx-parts.md](portalfx-parts.md) | `<dir>\Client\V1\Parts\PartsArea.ts` |
    | Pricing Tier Blade | [portalfx-extension-pricing-tier.md](portalfx-extension-pricing-tier.md) | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts` | |
    | Telemetry Logging | [portalfx-telemetry-logging.md](portalfx-telemetry-logging.md) | `<dir>\Configuration\ApplicationConfiguration.cs` |  |
    | Template Blades | [portalfx-blades-templateblade-reference.md](portalfx-blades-templateblade-reference.md) | `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels.ts` | |
    | TemplateBlade Advanced Options| [portalfx-blades-templateblade-advanced.md](portalfx-blades-templateblade-advanced.md) |  |
    | View Model | [portalfx-blade-viewmodel.md](portalfx-blade-viewmodel.md) |  `<dir>\Client\V1\Blades\Template\ ViewModels\TemplateBladeViewModels` |  |


 ## Procedures for Portal Sample Source Code

After installing Visual Studio and the Portal Framework SDK, locate the samples in the `...\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

Open the `SamplesExtension` solution file to experiment with samples in the IDE.

You can make changes to the samples as appropriate.

Click the F5 key to start debugging the sample extensions. This rebuilds the project, which will allow you to check for items like the most recent version of the SDK.

Sideload the extension. When it loads, click on the `More Services` option in the menu, as in the following example.

 ![alt-text](../media/portalfx-extensions-samples/samples-services.png  "Portal Extensions Services")

In the filter box, search for "Azure Portal SDK". You can use `Shift + Space` to mark it as a favorite site.

Make changes to the sample that best fits the needs of the development project, then refresh the portal to view the changes. 


 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                  | Meaning | 
| ---                   | --- |
| EditScope             | An Azure SDK object that provides a standard way of managing edits over a collection of input fields, blades, and extensions. |
| ParameterCollector    | A collection of Parameter and Parameter-derived objects that are used by data source controls in advanced data-binding scenarios. |
