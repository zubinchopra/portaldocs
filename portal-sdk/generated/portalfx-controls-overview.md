
<a name="overview"></a>
## Overview

Controls are the building blocks of the Azure extension experience. They allow users to view, edit, and analyze data.

The Azure Portal team ships sample code that extension developers can leverage. All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples).

The Azure components of the experience are documented several ways. 
*  There may be a document that provides guidance about the component, in terms of what it is, what it does, or how it is used. 
* The location of the sample code is included  so that the developer can view the source for the component, or modify it as appropriate for the extensions they develop.  
* A completed version of the component can be viewed in the Dogfood environment; in some instances, links are provided to the API reference for the component.

**NOTE**: In the following tables, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it can be experienced by using the link in the table.

The following tables include information about Portal controls, including the location of samples that are shipped with the SDK and working copies in the Dogfood environment.

<a name="basic-screen-controls"></a>
## Basic Screen Controls

| Control |  Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Button  | | |  http://aka.ms/portalfx/samples#blade/SamplesExtension/SimpleButtonBlade |
| Copyable Label | |  `<dir>\Client\V2\Controls\ CopyableLabel\CopyableLabelBlade.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/CopyableLabelBlade |
| File Download Button |  | `<dir>\Client\V1\Controls\FileDownloadButton\ViewModels\ FileDownloadButtonViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/FileDownloadButtonInstructions/selectedItem/FileDownloadButtonInstructions/selectedValue/FileDownloadButtonInstructions |  
| File Upload (async) |  | `<dir>\Client\V1\Controls\AsyncFileUpload\ViewModels\ AsyncFileUploadViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/AsyncFileUploadInstructions/selectedItem/AsyncFileUploadInstructions/selectedValue/AsyncFileUploadInstructions |
| Markdown Control | |`<dir>\Client\V1\Controls\Markdown\ViewModels\ MarkdownViewModels.ts`| http://aka.ms/portalfx/samples#blade/SamplesExtension/MarkdownInstructions/selectedItem/MarkdownInstructions/selectedValue/MarkdownInstructions |
| OAuth Button  | | `<dir>\Client\V2\Controls\ OAuthButton\OAuthButtonBlade.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/OAuthButtonBlade | 
| Settings | | `<dir>\Client\V1\Controls\Settings\ViewModels\ SettingsViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SettingsInstructions/selectedItem/SettingsInstructions/selectedValue/SettingsInstructions | 
| Single Setting |   | `<dir>\Client\V1\Controls\SingleSetting\ViewModels\ SingleSettingViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SingleSettingInstructions/selectedItem/SingleSettingInstructions/selectedValue/SingleSettingInstructions | 
| Splitter | | `<dir>\Client\V2\Controls\ Splitter\SplitterBlade.ts` |  http://aka.ms/portalfx/samples#blade/SamplesExtension/SplitterBlade | 
| Text Block  |  | `<dir>\Client\V1\Controls\TextBlock\ViewModels\ TextBlockViewModels.ts` | https://df.onecloud.azure-test.net/?samplesExtension=true#blade/SamplesExtension/TextBlockInstructions/selectedItem/TextBlockInstructions/selectedValue/TextBlockInstructions | 
| Text Box |  [portalfx-controls-textbox.md](portalfx-controls-textbox.md)  | `<dir>\Client\V2\Controls\TextBox\TextBoxBlade.ts` | [http://aka.ms/portalfx/samples#blade/SamplesExtension/Textboxblade](http://aka.ms/portalfx/samples#blade/SamplesExtension/Textboxblade) | 
| Toolbar   | [portalfx-controls-toolbar.md](portalfx-controls-toolbar.md)  |  `<dir>\Client\V1\Controls\Toolbar\ViewModels\ ToolbarViewModels.ts` | (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/ToolbarInstructions/selectedItem/ToolbarInstructions/selectedValue/ToolbarInstructions |

<a name="date-and-time"></a>
## Date and Time

| Date/time Object | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
|  Date Picker  |  | `<dir>\Client\V2\Controls\ DatePicker\DatePickerBlade.ts` |   (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/DatePickerInstructions/selectedItem/DatePickerInstructions/selectedValue/DatePickerInstructions |
| Date/Time Picker   |  [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md)  |  `<dir>\Client\V2\Controls\ DateTimePicker\DateTimePickerBlade.ts`   | (experience does not work) <br>  http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimePickerInstructions/selectedItem/DateTimePickerInstructions/selectedValue/DateTimePickerInstructions |
| Date/Time Range Picker  |  |   `<dir>\Client\V2\Controls\ DateTimeRangePicker\DateTimeRangePickerBlade.ts` | (experience does not work) <br>  http://aka.ms/portalfx/samples#blade/SamplesExtension/DateTimeRangePickerInstructions/selectedItem/DateTimeRangePickerInstructions/selectedValue/DateTimeRangePickerInstructions |
| Date Polyfills |  | `<dir>\Client\V1\Controls\DatePolyFills\ViewModels\ DatePolyFillsViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/DatePolyFillsInstructions/selectedItem/DatePolyFillsInstructions/selectedValue/DatePolyFillsInstructions |
| Day Picker (does not work) |  | `<dir>\Client\V2\Controls\ DayPicker\DayPickerBlade.ts`   |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/DayPickerInstructions/selectedItem/DayPickerInstructions/selectedValue/DayPickerInstructions |
| Duration Picker |  | `<dir>\Client\V1\Controls\DurationPicker\ViewModels\ DurationPickerViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/DurationPickerInstructions/selectedItem/DurationPickerInstructions/selectedValue/DurationPickerInstructions |
| Time Picker |  | `<dir>\Client\V1\Controls\TimePicker\ViewModels\ TimePickerViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/TimePickerInstructions/selectedItem/TimePickerInstructions/selectedValue/TimePickerInstructions |

<a name="drop-downs"></a>
## Drop downs

| Drop Down | Document | Sample | Experience |
| --------- | -------- | ------ | ---------- |
| Drop Down | [portalfx-controls-dropdown.md](portalfx-controls-dropdown.md) | `<dir>\Client\V2\Controls\ DropDown\DropDownBlade.ts` | |
| Console   | [portalfx-controls-console.md]([portalfx-controls-console.md]) | `<dir>\Client\V2\Controls\ Console\ConsoleBlade.ts` | |

<a name="editors"></a>
## Editors

| Editor      | Document | Sample | Experience |
| ----------- | -------- | ------ | ---------- |
| Code editor | [portalfx-controls-editor.md](portalfx-controls-editor.md) | | 
| Diff editor |  |  |http://aka.ms/portalfx/samples#blade/SamplesExtension/DiffEditorInstructions/selectedItem/DiffEditorInstructions/selectedValue/DiffEditorInstructions | 

<a name="forms"></a>
## Forms

| Forms | Document | Sample | Experience |
| --------- | -------- | ------ | ---------- |
| Standard Check Box  |   |   |  (experience does not work) <br>  http://aka.ms/portalfx/samples#blade/SamplesExtension/CheckBoxInstruction |
| Tri State Check Box  |   |   |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/TriStateCheckBoxInstructions  |
| Custom HTML |   |   | http://aka.ms/portalfx/samples#blade/SamplesExtension/CustomFormFieldsBlade  |
| MultiLine Text Box  |   |   |  (experience does not work) <br>  http://aka.ms/portalfx/samples#blade/SamplesExtension/MultiLineTextBoxInstructions/selectedItem/MultiLineTextBoxInstructions/selectedValue/MultiLineTextBoxInstructions |
| Numeric Text Box  |   |   |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/NumericTextBoxInstructions/selectedItem/NumericTextBoxInstructions/selectedValue/NumericTextBoxInstructions  |
| Text Box  |   |   |   (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/TextBoxInstructions/selectedItem/TextBoxInstructions/selectedValue/TextBoxInstructions |
| Option Picker  |   |   |   (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/OptionPickerInstructions/selectedItem/OptionPickerInstructions/selectedValue/OptionPickerInstructions |
| Password Box   |   |   |   (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/PasswordInstructions/selectedItem/PasswordInstructions/selectedValue/PasswordInstructions |
| Search Box |   |   |  http://aka.ms/portalfx/samples#blade/SamplesExtension/SearchBoxBlade/selectedItem/SearchBoxBlade/selectedValue/SearchBoxBlade |
| Standard Slider |   |   |   (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/SliderInstructions/selectedItem/SliderInstructions/selectedValue/SliderInstructions |
| Custom Value Slider |   |   |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/SlidersInstructions/selectedItem/SlidersInstructions/selectedValue/SlidersInstructions |
| Range Slider |   |   |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/RangeSliderInstructions/selectedItem/RangeSliderInstructions/selectedValue/RangeSliderInstructions  |
| Custom Range Slider |   |   |   (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/RangeSliderInstructions/selectedItem/CustomRangeSliderInstructions/selectedValue/CustomRangeSliderInstructions  |

<a name="lists"></a>
## Lists

| Gallery | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Gallery | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/GalleryInstructions/selectedItem/GalleryInstructions/selectedValue/GalleryInstructions |
| List View | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/ListViewInstructions/selectedItem/ListViewInstructions/selectedValue/ListViewInstructions
| Tree View | | |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/TreeViewInstructions/selectedItem/TreeViewInstructions/selectedValue/TreeViewInstructions
| String List | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/StringListInstructions/selectedItem/StringListInstructions/selectedValue/StringListInstructions
| Query Builder | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/QueryBuilderInstructions/selectedItem/QueryBuilderInstructions/selectedValue/QueryBuilderInstructions
| Grid |  [portalfx-controls-grid.md](portalfx-controls-grid.md) | | | 

<a name="helpers-and-indicators"></a>
## Helpers and Indicators

| Helpers | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Docked Balloon | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/DockedBalloonInstructions/selectedItem/DockedBalloonInstructions/selectedValue/DockedBalloonInstructions | 
| Info Box | | |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/InfoBoxInstructions/selectedItem/InfoBoxInstructions/selectedValue/InfoBoxInstructions |
| Progress Bar | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/ProgressBarInstructions/selectedItem/ProgressBarInstructions/selectedValue/ProgressBarInstructions |

<a name="data-visualization-objects"></a>
## Data Visualization Objects

| Screen Objects  | Document | Sample | Experience |
| ------------- | -------- | ------ | ---------- |
| | | Aggregates  | |
| Chart         | [portalfx-controls-chart.md](portalfx-controls-chart.md) | | |
| Donut         | [portalfx-controls-donut.md](portalfx-controls-donut.md) | `<dir>\Client\V2\Controls\Donut\DonutBlade.ts`  | |
|       | |  Gauges | |
| Quota Gauge   | | |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/QuotaGaugeBlade |
| Single Value Gauge | | |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/SingleValueGaugeBlade |
| Step Gauge | | |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/StepGaugeBlade |
| | | Graphs   | | |
| Standard Graph  | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/graphInstructions |
| Custom Html Nodes | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/graphCustomNodeInstructions
| Metrics | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/MetricsInstructions/selectedItem/MetricsInstructions/selectedValue/MetricsInstructions | 
| | | Maps  | |
| Base Map | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/BaseMapInstructions |
| Hexagon Layout Map | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/HexagonMapInstructions |
| Menu | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/MenuInstructions/selectedItem/MenuInstructions/selectedValue/MenuInstructions |
| Log Stream | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/LogStreamInstructions/selectedItem/LogStreamInstructions/selectedValue/LogStreamInstructions |
| Spec Comparison Table | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/SpecComparisonTableInstructions/selectedItem/SpecComparisonTableInstructions/selectedValue/SpecComparisonTableInstructions |
| Video Control | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/VideoInstructions/selectedItem/VideoInstructions/selectedValue/VideoInstructions |
| Legend | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/Legend/selectedItem/Legend/selectedValue/Legend  | 
| HotSpot | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/HotSpotInstructions/selectedItem/HotSpotInstructions/selectedValue/HotSpotInstructions |
| Video | | |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/VideoInstructions/selectedItem/VideoInstructions/selectedValue/VideoInstructions |
| Terminal Emulator | | |  (experience does not work) <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/TerminalEmulatorInstructionsBlade/selectedItem/TerminalEmulatorInstructionsBlade/selectedValue/TerminalEmulatorInstructionsBlade |


<a name="deprecated-controls"></a>
## Deprecated controls

The following controls have been deprecated.  They have been replaced with more performant controls, or  with best practices that reduce issues in usability testing and improve the Create success rate. However, they are included in the following list for backward compatibility.

| Control  | Image | Document | Sample | Experience |
| -------- | ----- | -------- | ------ | ---------- |
| Selector | ![alt-text](../media/portalfx-ux-create-forms/creator_selector.jpg "creator_selector") | |  `<dir>\Client\V1\Controls\Selector\ViewModels\ SelectorViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SelectorInstructions/selectedItem/SelectorInstructions/selectedValue/SelectorInstructions | 
