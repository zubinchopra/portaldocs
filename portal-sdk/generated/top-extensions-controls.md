
<a name="extension-controls"></a>
# Extension Controls



<a name="extension-controls-overview"></a>
## Overview

Controls are the building blocks of the Azure extension experience. They allow users to view, edit, and analyze data.

The Azure Portal team ships sample code that extension developers can leverage. All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder. The source specifies the namespace in which the control is located. The working copy for sample controls in the Dogfood environment is located at [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls). This document also contains links to working copies of individual controls.

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples).

The Azure components of the experience are documented several ways. 
*  There may be a document that provides guidance about the component, in terms of what it is, what it does, or how it is used. 
* The location of the sample code is included so that the developer can view the source for the component, or modify it as appropriate for the extensions they develop.  
* A working copy of the component can be viewed in the Dogfood environment; in some instances, links are provided to the API reference for the component.


<a name="extension-controls-samples-controls"></a>
## Samples Controls


**NOTE**: In the following tables, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it can be experienced by using the link in the table.

The following tables include information about Portal controls, including the location of samples that are shipped with the SDK and working copies in the Dogfood environment.

<a name="extension-controls-controls-that-are-used-by-other-controls"></a>
## Controls that are used by other controls

<!-- TODO:  Determine whether there are samples and experiences that are best documented inside an existing document instead of being  documented in separate documents.  If so, determine whether it is appropriate for them to be combined into the following separate table.-->

| Control        | Sample | Experience |
| -------------- | --------- | -------------- |
| Copyable Label | `<dir>\Client\V2\Controls\ CopyableLabel\CopyableLabelBlade.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/CopyableLabelBlade |
  
<a name="extension-controls-basic-screen-controls"></a>
## Basic Screen Controls

Controls that do not have a link to a unique experience can be located from  the selection list at [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls).

| Control |  Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Button and SimpleButton | |  `<dir>\Client\V2\Controls\SimpleButton\ SimpleButtonBlade.ts` |  http://aka.ms/portalfx/samples#blade/SamplesExtension/SimpleButtonBlade |
| File Download Button |  | `<dir>\Client\V1\Controls\FileDownloadButton\ViewModels\ FileDownloadButtonViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/FileDownloadButtonInstructions/selectedItem/FileDownloadButtonInstructions/selectedValue/FileDownloadButtonInstructions |  
| File Upload (async) |  | `<dir>\Client\V1\Controls\AsyncFileUpload\ViewModels\ AsyncFileUploadViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/AsyncFileUploadInstructions/selectedItem/AsyncFileUploadInstructions/selectedValue/AsyncFileUploadInstructions |
| OAuth Button  | | `<dir>\Client\V2\Controls\ OAuthButton\OAuthButtonBlade.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/OAuthButtonBlade | 
| Settings | | `<dir>\Client\V1\Controls\Settings\ViewModels\ SettingsViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SettingsInstructions/selectedItem/SettingsInstructions/selectedValue/SettingsInstructions | 
| Single Setting |   | `<dir>\Client\V1\Controls\SingleSetting\ViewModels\ SingleSettingViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SingleSettingInstructions/selectedItem/SingleSettingInstructions/selectedValue/SingleSettingInstructions | 
| Splitter | | `<dir>\Client\V2\Controls\ Splitter\SplitterBlade.ts` |  http://aka.ms/portalfx/samples#blade/SamplesExtension/SplitterBlade | 
| Text Block  |  | `<dir>\Client\V1\Controls\TextBlock\ViewModels\ TextBlockViewModels.ts` | https://df.onecloud.azure-test.net/?samplesExtension=true#blade/SamplesExtension/TextBlockInstructions/selectedItem/TextBlockInstructions/selectedValue/TextBlockInstructions | 
| Toolbar   | [portalfx-controls-toolbar.md](portalfx-controls-toolbar.md) <br> [portalfx-blades-procedure.md](portalfx-blades-procedure.md)  |  `<dir>\Client\V1\Controls\Toolbar\ViewModels\ ToolbarViewModels.ts` <br> `<dir>\Client\V1\Blades\Toolbar\BladeWithToolbarViewModels.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/controls](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/controls) |

<a name="extension-controls-advanced-screen-controls"></a>
## Advanced Screen Controls

| Control | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Accordion |  | `<dir>\Client\V2\Controls\Accordion\AccordionBlade.ts` |  |
| Essentials Control | [portalfx-controls-essentials.md](portalfx-controls-essentials.md)    | `<dir>\Client\V2\Controls\Essentials\ EssentialsDefaultBlade.ts` <br>  `<dir>\Client\V2\Controls\Essentials\ EssentialsCustomLayoutBlade.ts` <br>   `<dir>\Client\V2\Controls\Essentials\EssentialsNonResourceBlade.ts` <br> `<dir>\Client\V2\Controls\Essentials\EssentialsResponsiveBlade.ts` |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/EssentialsIndexBlade/Default/selectedItem/EssentialsIndexBlade/selectedValue/EssentialsIndexBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/EssentialsIndexBlade/Default/selectedItem/EssentialsIndexBlade/selectedValue/EssentialsIndexBlade) |
| Graph |  | `<dir>\Client\V1\Controls\Graph\ViewModels\ GraphCustomNodesViewModels.ts` <br> `<dir>\Client\V1\Controls\Graph\ViewModels\ GraphIndexViewModels.ts` <br> `<dir>\Client\V1\Controls\Graph\ViewModels\ GraphViewModels.ts` |  |
| Legend |  | `<dir>\Client\V1\Controls\Legend\ViewModels\LegendViewModels.ts` |  |
| LogStream |  | `<dir>\Client\V1\Controls\LogStream\ViewModels\LogStreamViewModel.ts` |  |
| Metrics |  | `<dir>\Client\V1\Controls\Metrics\ViewModels\MetricsViewModels.ts` |  |
| Pill |  | `<dir>\Client\V2\Controls\Pill\ PillBlade.ts` |  |
| Preview |  | `<dir>\Client\V1\Controls\Preview\Menu\ViewModels\MenuViewModels.ts` |  |
| ProgressBar |  | `<dir>\Client\V1\Controls\ProgressBar\ViewModels\ProgressBarViewModels.ts` |  |
| SearchBox |  | `<dir>\Client\V2\Controls\SearchBox\SearchBoxBlade.ts` |  |
| Storage |  | `<dir>\Client\V2\Controls\Storage\ FileShareDropDownBlade.ts` |  |
| Video |  | `<dir>\Client\V2\Controls\Video\VideoBlade.ts` | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/styleguidevideotitle](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/styleguidevideotitle) |

<a name="extension-controls-date-and-time"></a>
## Date and Time

| Date/time Object | Document | Sample | Experience |
| ---------------- | -------- | ------ | ---------- |
|  Date Picker  |  | `<dir>\Client\V2\Controls\ DatePicker\DatePickerBlade.ts` |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/DatePickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/DatePickerBlade) |
| Date/Time Picker   |  [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md)  |  `<dir>\Client\V2\Controls\ DateTimePicker\DateTimePickerBlade.ts`   | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/DateTimePickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/DateTimePickerBlade)   |
| Date/Time Range Picker  | [portalfx-controls-datetimerangepicker.md](portalfx-controls-datetimerangepicker.md)  |   `<dir>\Client\V2\Controls\ DateTimeRangePicker\DateTimeRangePickerBlade.ts` | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/DateTimeRangePickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/DateTimeRangePickerBlade) |
| Date Polyfills |  | `<dir>\Client\V1\Controls\DatePolyFills\ViewModels\ DatePolyFillsViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/DatePolyFillsInstructions/selectedItem/DatePolyFillsInstructions/selectedValue/DatePolyFillsInstructions |
| Day Picker  |  | `<dir>\Client\V2\Controls\ DayPicker\DayPickerBlade.ts`   |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/DayPickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/DayPickerBlade) |
| Duration Picker |  | `<dir>\Client\V1\Controls\DurationPicker\ViewModels\ DurationPickerViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/DurationPickerInstructions/selectedItem/DurationPickerInstructions/selectedValue/DurationPickerInstructions |
| Time Picker |  | `<dir>\Client\V1\Controls\TimePicker\ViewModels\ TimePickerViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/TimePickerInstructions/selectedItem/TimePickerInstructions/selectedValue/TimePickerInstructions |


<a name="extension-controls-drop-down-controls"></a>
## Drop down controls

| Drop Down | Document | Sample | Experience |
| --------- | -------- | ------ | ---------- |
| Drop Down | [portalfx-controls-dropdown.md](portalfx-controls-dropdown.md) | `<dir>\Client\V2\Controls\ DropDown\DropDownBlade.ts` | |
| Console   | [portalfx-controls-console.md](portalfx-controls-console.md) | `<dir>\Client\V2\Controls\ Console\ConsoleBlade.ts` <br>  `<dir>\Client\V1\Controls\Console2\ ViewModels\Console2ViewModels.ts` |  |

<a name="extension-controls-editors"></a>
## Editors

| Editor      | Document | Sample | Experience |
| ----------- | -------- | ------ | ---------- |
| Code Editor | [portalfx-controls-editor.md](portalfx-controls-editor.md)    | `<dir>\Client\V1\Controls\Editor\ ViewModels\EditorViewModels.ts` <br> `<dir>\Client\V1\Controls\Editor\ ViewModels\CustomLanguageEditorViewModels.ts`      | |
| JSONEditor |  | `<dir>\Client\V1\Controls\JSONEditor\ViewModels\JSONEditorViewModels.ts` |  |

<a name="extension-controls-forms-controls"></a>
## Forms controls

| Forms | Document | Sample | Experience |
| --------- | -------- | ------ | ---------- |
| Standard Check Box  |   |   |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/CheckBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/CheckBoxBlade) |
| Tri State Check Box |   |   |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/TriStateCheckBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/TriStateCheckBoxBlade) |
|  CustomHtml <br> (Form Sections) |  [portalfx-forms-sections.md](portalfx-forms-sections.md)  |   | http://aka.ms/portalfx/samples#blade/SamplesExtension/CustomFormFieldsBlade  <br>  [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/formsallup](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/formsallup) |
| Text Box  |  [portalfx-controls-textbox.md](portalfx-controls-textbox.md)   | `<dir>\Client\V2\Controls\TextBox\TextBoxBlade.ts`  |   [https://df.onecloud.azure-test.net/#blade/SamplesExtension/TextBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/TextBoxBlade) <br>  [https://aka.ms/portalfx/sampleTextBox](https://aka.ms/portalfx/sampleTextBox) |
| MultiLine Text Box  |   |  `<dir>\Client\V2\Controls\MultiLineTextBox\MultiLineTextBoxBlade.ts` |   [https://df.onecloud.azure-test.net/#blade/SamplesExtension/MultiLineTextBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/MultiLineTextBoxBlade)  |
| Numeric Text Box  |   |  `<dir>\Client\V2\Controls\NumericTextBox\NumericTextBoxBlade.ts` |   [https://df.onecloud.azure-test.net/#blade/SamplesExtension/NumericTextBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/NumericTextBoxBlade) |
| Options Group  |   |    |    |
| Option Picker (includes RadioButton) |   | `<dir>\Client\V2\Controls\OptionPicker\OptionPickerBlade.ts`   |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/OptionPickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/OptionPickerBlade) |
| Password Box  |  | `<dir>\Client\V2\Controls\Password\PasswordBoxBlade.ts`   | 	[https://df.onecloud.azure-test.net/#blade/SamplesExtension/PasswordBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/PasswordBoxBlade) |
| TabControl |   |  | |
| Search Box |   |   |  http://aka.ms/portalfx/samples#blade/SamplesExtension/SearchBoxBlade/selectedItem/SearchBoxBlade/selectedValue/SearchBoxBlade |
|  Slider (includes Custom Value Slider, Range Slider, and Custom Range Slider) |  | `<dir>\Client\V2\Controls\Slider\SliderBlade.ts` | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SliderBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SliderBlade)   | 

<a name="extension-controls-list-controls"></a>
## List controls

| Gallery | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Grid and EditableGrid |  [portalfx-controls-grid.md](portalfx-controls-grid.md) | `<dir>\Client\V2\Controls\Grid\ItemsWithDynamicCommandsBlade.ts` <br>   `<dir>\Client\V2\Controls\EditableGrid\ EditableGrid.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridCustomValidation.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridDependentDropDowns.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridDynamicCellTypes.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridMaxEntries.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridOperations.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridValidation.ts` | https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/BasicGridInstructions <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/EditableGridInstructions |
| ListView |  |  `<dir>\Client\V1\Controls\ListView\ViewModels\BasicListViewViewModels.ts` <br>  `<dir>\Client\V1\Controls\ListView\ViewModels\CustomListViewViewModels.ts` <br>  `<dir>\Client\V1\Controls\ListView\ViewModels\IndexViewModels.ts` <br>  `<dir>\Client\V1\Controls\ListView\ViewModels\ListViewChildBladeViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/ListViewInstructions/selectedItem/ListViewInstructions/selectedValue/ListViewInstructions |
| Tree View|  | `<dir>\Client\V1\Controls\Tree\TreeBlade.ts`  `<dir>\Client\V1\Controls\Tree\TreeItemBlade.ts`  |   [http://aka.ms/portalfx/samples#blade/SamplesExtension/TreeBlade](http://aka.ms/portalfx/samples#blade/SamplesExtension/TreeBlade)
| String List | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/StringListInstructions/selectedItem/StringListInstructions/selectedValue/StringListInstructions

<a name="extension-controls-helpers-and-indicators"></a>
## Helpers and Indicators

| Helpers | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Docked Balloon | Also see Infoballoon. | `<dir>\Client\V1\Controls\DockedBalloon\ViewModels\DockedBalloonViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/DockedBalloonInstructions/selectedItem/DockedBalloonInstructions/selectedValue/DockedBalloonInstructions  |
| Info Box |  | `<dir>\Client\V2\Controls\Infobox\InfoboxBlade.ts` | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/InfoBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/InfoBoxBlade) |
| Progress Bar | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/ProgressBarInstructions/selectedItem/ProgressBarInstructions/selectedValue/ProgressBarInstructions |

<a name="extension-controls-data-visualization-objects"></a>
## Data Visualization Objects

| Screen Objects  | Document | Sample | Experience |
| ------------- | -------- | ------ | ---------- |
| | |  <p align="center">Aggregates</p> | |
| Controls Chart    | [portalfx-controls-chart.md](portalfx-controls-chart.md)     |  `<dir>\Client\V1\Controls\Chart\ViewModels\BarChartViewModels.ts` <br>     `<dir>\Client\V1\Controls\Chart\ViewModels\OverlayedViewChartViewModel.ts` `\Client\Controls\Chart\ViewModels\LineChartDateBasedViewModels.ts` |  |
| Plotting Metrics  (Monitor Chart)       | [portalfx-controls-monitor-chart.md](portalfx-controls-monitor-chart.md) | `<dir>\Client\V2\Preview\MonitorChart\ MonitorChartBlade.ts`     | [https://aka.ms/portalfx/sampleMonitorChart](https://aka.ms/portalfx/sampleMonitorChart) |
| Donut         | [portalfx-controls-donut.md](portalfx-controls-donut.md) | `<dir>\Client\V2\Controls\Donut\DonutBlade.ts`  | |
|       | | <p align="center">Gauges</p>   | |
| Quota Gauge   | | see link to playground  |   |
| Single Value Gauge | | see link to playground  |  |
| | |<p align="center">Graphs</p>    | | |
| Custom Html Nodes | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/graphCustomNodeInstructions |
| Standard Graph  | [portalfx-controls-graph-nuget.md](portalfx-controls-graph-nuget.md)| | http://aka.ms/portalfx/samples#blade/SamplesExtension/graphInstructions |
| | | <p align="center">Maps</p>  | |
| Base Map | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/BaseMapInstructions |
| Hexagon Layout Map | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/HexagonMapInstructions |
| HotSpot | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/HotSpotInstructions/selectedItem/HotSpotInstructions/selectedValue/HotSpotInstructions |
| Legend | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/Legend/selectedItem/Legend/selectedValue/Legend  | 
| Log Stream | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/LogStreamInstructions/selectedItem/LogStreamInstructions/selectedValue/LogStreamInstructions |
| Menu | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/MenuInstructions/selectedItem/MenuInstructions/selectedValue/MenuInstructions |
| Spec Comparison Table | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/SpecComparisonTableInstructions/selectedItem/SpecComparisonTableInstructions/selectedValue/SpecComparisonTableInstructions |


 ## Deprecated controls

The following controls have been deprecated.  They have been replaced with more performant controls, or  with best practices that reduce issues in usability testing and improve the Create success rate. However, they are included in the following list for backward compatibility.

| Control  | Document | Sample | Experience |
| -------- | -------- | ------ | ---------- |
| AzureMediaPlayer | Unsupported | Reserved for Azure media services team  |
| DataNavigator for Virtualized Data  | [portalfx-data-virtualizedgriddata.md](portalfx-data-virtualizedgriddata.md) | `<dir>\Client\V1\Controls\Grid\Templates\ PageableGridViewModel.ts` <br>      `<dir>\Client\V1\Controls\ProductData.ts`  <br>    `<dir>\Client\V1\Controls\ProductPageableData.ts`     | 
| DiffEditor  | Obsolete. Use  Code editor instead. | `<dir>\Client\V1\Controls\DiffEditor\ViewModels\DiffEditorViewModels.ts` |  http://aka.ms/portalfx/samples#blade/SamplesExtension/DiffEditorInstructions/selectedItem/DiffEditorInstructions/selectedValue/DiffEditorInstructions | 
| Drop Down  | Obsolete.  Use V2 control instead.  | `<dir>\Client\V1\Controls\ DropDown\ViewModels\DropDownViewModels.ts`  | |
| Essentials Control | Obsolete.  Use V2 control instead.  | `<dir>\Client\V1\Controls\Essentials\ViewModels\DefaultEssentialsViewModel.ts`  <br> `<dir>\Client\V1\Controls\Essentials\ViewModels\IndexViewModels.ts`  | |
| File Download Button |  | `<dir>\Client\V1\Controls\FileDownloadButton\ViewModels\ FileDownloadButtonViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/FileDownloadButtonInstructions/selectedItem/FileDownloadButtonInstructions/selectedValue/FileDownloadButtonInstructions |  
| File Upload (async) |  | `<dir>\Client\V1\Controls\AsyncFileUpload\ViewModels\ AsyncFileUploadViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/AsyncFileUploadInstructions/selectedItem/AsyncFileUploadInstructions/selectedValue/AsyncFileUploadInstructions |
| Gallery | Obsolete. | `<dir>\Client\V1\Controls\Gallery\ViewModels\GalleryViewModels.ts` |  |
| Grid and Grid Controls     | [portalfx-controls-grid.md](portalfx-controls-grid.md)                               | `<dir>\Client\V1\Controls\Grid\ ViewModels\ScrollableGridWithFilteringAndSorting.ts`     `<dir>/Client/V1/Controls/Grid/ViewModels/BasicGridViewModel.ts`     `<dir>Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts`      | [http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions) |
| HotSpot | Obsolete. Use fx click instead. | `<dir>\Client\V1\Controls\HotSpot\ViewModels\HotSpotViewModels.ts` |  |
| IFrame |  Obsolete. | `<dir>\Client\V1\Controls\IFrame\ViewModels\IFrameViewModels.ts` |  |
| Map | Obsolete.  | `<dir>\Client\V1\Controls\Map\ViewModels\BaseMapViewModels.ts` <br> `<dir>\Client\V1\Controls\Map\ViewModels\HexagonLayoutViewModels.ts` <br> `<dir>\Client\V1\Controls\Map\ViewModels\IndexViewModels.ts`  |  |
| Markdown Control | |`<dir>\Client\V1\Controls\Markdown\ViewModels\ MarkdownViewModels.ts`| http://aka.ms/portalfx/samples#blade/SamplesExtension/MarkdownInstructions/selectedItem/MarkdownInstructions/selectedValue/MarkdownInstructions |
| PairedTimeline |  Unsupported.  Reserved for partner use. <!-- TODO:  Locate one partner team that still uses this. --> | `<dir>\Client\V1\Controls\PairedTimeline\ViewModels\PairedTimelineViewModels.ts` |  |
| QueryBuilder | Obsolete.  Use pill control instead, or build a custom control for complicated queries.  | `<dir>\Client\V1\Controls\QueryBuilder\ViewModels\QueryBuilderViewModels.ts` |  http://aka.ms/portalfx/samples#blade/SamplesExtension/QueryBuilderInstructions/selectedItem/QueryBuilderInstructions/selectedValue/QueryBuilderInstructions |
| Selector | Obsolete. Use single blade experiences and fx clicks to launch blades | `<dir>\Client\V1\Controls\Selector\ViewModels\SelectorViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SelectorInstructions/selectedItem/SelectorInstructions/selectedValue/SelectorInstructions |
| Single Setting |   | `<dir>\Client\V1\Controls\SingleSetting\ViewModels\ SingleSettingViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SingleSettingInstructions/selectedItem/SingleSettingInstructions/selectedValue/SingleSettingInstructions | 
| SpecComparisonTable | Obsolete.   | `<dir>\Client\V1\Controls\SpecComparisonTable\ViewModels\SpecComparisonTableViewModels.ts` |  |
| Step Gauge | Deprecated. Do not use. | |  |
| StringList |   Obsolete.  Use pill control instead, or build a custom control for complicated queries. | `<dir>\Client\V1\Controls\StringList\ViewModels\StringListViewModels.ts` |  |
| Terminal Emulator | Obsolete. Use the V2 Console instead. | |  |
| TokenComboBox |  Obsolete. Use the  V2 Dropdown box instead. | `<dir>\Client\V1\Controls\TokenComboBox\ViewModels\TokenComboBoxViewModels.ts` |  |

<!--
 gitdown": "include-file", "file": "../templates/portalfx-extensions-bp-controls.md"}
 -->

<a name="extension-controls-faqs-for-extension-controls"></a>
## FAQs for Extension Controls


   <!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->

<a name="extension-controls-faqs-for-extension-controls-how-to-use-a-monitorchartpart-from-legacy-blade"></a>
### How to use a MonitorChartPart from Legacy Blade

***My extension is still using legacy blades (locked or unlocked). Is this still applicable to me? If yes, do I get the benefits mentioned above?***

SOLUTION: Even if you are not using template blades, you can reference the MonitorChartPart from the Hubs extension, as specified in [portalfx-controls-monitor-chart.md#legacyBladeUsage](portalfx-controls-monitor-chart.md#legacyBladeUsage).

If there is an Insights/Monitoring Metrics part on your blade already, you can reference the part from Hubs extension instead of referencing the metrics part from Insights/Monitoring extension. Because the Hubs extension is always loaded when you load the portal, it will be loaded before the user loads your extension blade. Hence, you will not load an additional extension and get significant performance benefits. However, for the best performance, we strongly recommend that your extension should use the [Monitor Chart control](#the-monitor-chart control) directly on a template blade. For more information about migrating to template blades, see []().

* * * 

<a name="extension-controls-faqs-for-extension-controls-changing-the-metrics-time-range-chart-type"></a>
### Changing the metrics/time range/chart type

***Can the users change the metrics/time range/chart type of the charts shown in the overview blade?***

SOLUTION: No, users cannot customize what is displayed in the overview blade. For customizations, users can click on the chart, navigate to Azure Monitor, make changes the chart if needed, and then pin it to the dashboard. The dashboard contains all the charts that users want to customize and view.

This means the extension has a consistent story.
1. View the metrics in overview blade
1. Explore the metrics in Azure Monitor
1. Track and monitor metrics in the Azure Dashboard

Removing customizations from blades also provides more reliable blade performance.

    
* * * 
    
<a name="extension-controls-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term             | Meaning |
| ---              | --- |
| big data | Data sets that are  very large or very diverse,  including  structured, semi-structured and unstructured datathat may be located in  different sources. The variation in sizes or types of data stores is beyond the ability of traditional databases to capture, manage, and process the data with low-latency.  | 
| IANA | Internet Assigned Numbers Authority | 
| timezone         | The local time of a region or a country, based on factors like time zone maps and Daylight Savings Time. | 
| timezone offset  | The difference, in minutes, between UTC time and the current time in the current locale.|
| UTC              | Universal Coordinated Time  |

