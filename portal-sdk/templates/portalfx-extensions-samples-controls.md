
## Samples Controls

Most controls are available in the playground located at  [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground), which also generates custom code. The following tables include the location of code samples that are shipped with the SDK for developers who are not generating custom code.

The experience for the control may include a link to the Dogfood environment in addition to or instead of a link to the playground.

The documents that describe a control, if any, include information other than the three development steps. For example, a developer may need assistance in migrating from a previous edition of a control.
 
**NOTE**: In the following tables, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it can be experienced by using the link in the table. 

## Controls that are used by other controls

<!-- TODO:  Determine whether the controls that are used by other controls need to have their own document, or can just be explained in a control that uses them. Also determine whether there are more controls than just the label that belong in the list. -->

| Control        | Sample | Experience |
| -------------- | --------- | -------------- |
| CopyableLabel | `<dir>\Client\V2\Controls\ CopyableLabel\CopyableLabelBlade.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/CopyableLabelBlade |

## Basic Screen Controls

<!-- TODO:  Determine whether the separate documents still contain data that should be separated from the main controls-procedure document.   If so, determine whether it is appropriate for them to be combined into the following separate table.-->

Controls that do not have a link to a unique experience can be located in the playground at  [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground) or in the selection list at [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls).

| Control |  Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Button and SimpleButton | |  `<dir>\Client\V2\Controls\SimpleButton\ SimpleButtonBlade.ts` |  http://aka.ms/portalfx/samples#blade/SamplesExtension/SimpleButtonBlade |
| File Download Button |  | `<dir>\Client\V1\Controls\FileDownloadButton\ViewModels\ FileDownloadButtonViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/FileDownloadButtonInstructions/selectedItem/FileDownloadButtonInstructions/selectedValue/FileDownloadButtonInstructions |  
| File Upload (async) |  | `<dir>\Client\V1\Controls\AsyncFileUpload\ViewModels\ AsyncFileUploadViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/AsyncFileUploadInstructions/selectedItem/AsyncFileUploadInstructions/selectedValue/AsyncFileUploadInstructions |
| OAuth Button  | | `<dir>\Client\V2\Controls\ OAuthButton\OAuthButtonBlade.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/OAuthButtonBlade | 
| Settings | | `<dir>\Client\V1\Controls\Settings\ViewModels\ SettingsViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SettingsInstructions/selectedItem/SettingsInstructions/selectedValue/SettingsInstructions | 
| Single Setting |   | `<dir>\Client\V1\Controls\SingleSetting\ViewModels\ SingleSettingViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/SingleSettingInstructions/selectedItem/SingleSettingInstructions/selectedValue/SingleSettingInstructions | 
| Splitter | | `<dir>\Client\V2\Controls\ Splitter\SplitterBlade.ts` |  http://aka.ms/portalfx/samples#blade/SamplesExtension/SplitterBlade | 
| TextBlock  |  | `<dir>\Client\V1\Controls\TextBlock\ViewModels\ TextBlockViewModels.ts` | https://df.onecloud.azure-test.net/?samplesExtension=true#blade/SamplesExtension/TextBlockInstructions/selectedItem/TextBlockInstructions/selectedValue/TextBlockInstructions | 
| Toolbar   | [portalfx-controls-toolbar.md](portalfx-controls-toolbar.md) <br> [portalfx-blades-procedure.md](portalfx-blades-procedure.md)  |  `<dir>\Client\V1\Controls\Toolbar\ViewModels\ ToolbarViewModels.ts` <br> `<dir>\Client\V1\Blades\Toolbar\BladeWithToolbarViewModels.ts` | [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/controls](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/controls) |

## Advanced Screen Controls

| Control | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Accordion |  | `<dir>\Client\V2\Controls\Accordion\AccordionBlade.ts` |  |
| Essentials Control | [portalfx-controls-essentials.md](portalfx-controls-essentials.md)    | `<dir>\Client\V2\Controls\Essentials\ EssentialsDefaultBlade.ts` <br>  `<dir>\Client\V2\Controls\Essentials\ EssentialsCustomLayoutBlade.ts` <br>   `<dir>\Client\V2\Controls\Essentials\EssentialsNonResourceBlade.ts` <br> `<dir>\Client\V2\Controls\Essentials\EssentialsResponsiveBlade.ts` |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/EssentialsIndexBlade/Default/selectedItem/EssentialsIndexBlade/selectedValue/EssentialsIndexBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/EssentialsIndexBlade/Default/selectedItem/EssentialsIndexBlade/selectedValue/EssentialsIndexBlade) |
| Graph | [portalfx-controls-graph-nuget.md](portalfx-controls-graph-nuget.md) | `<dir>\Client\V1\Controls\Graph\ViewModels\ GraphCustomNodesViewModels.ts` <br> `<dir>\Client\V1\Controls\Graph\ViewModels\ GraphIndexViewModels.ts` <br> `<dir>\Client\V1\Controls\Graph\ViewModels\ GraphViewModels.ts` |  |
| LogStream |  | `<dir>\Client\V1\Controls\LogStream\ViewModels\LogStreamViewModel.ts` |  |
| Metrics |  | `<dir>\Client\V1\Controls\Metrics\ViewModels\MetricsViewModels.ts` |  |
| Pill |  | `<dir>\Client\V2\Controls\Pill\ PillBlade.ts` |  |
| Preview |  | `<dir>\Client\V1\Controls\Preview\Menu\ViewModels\MenuViewModels.ts` |  |
| SearchBox |  | `<dir>\Client\V2\Controls\SearchBox\SearchBoxBlade.ts` | [https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/SearchBoxPlayground](https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/SearchBoxPlayground) |
| Storage |  | `<dir>\Client\V2\Controls\Storage\ FileShareDropDownBlade.ts` |  |
| Video |  | `<dir>\Client\V2\Controls\Video\VideoBlade.ts` | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/styleguidevideotitle](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/styleguidevideotitle) |

## Date and Time

| Date/time Object | Document | Sample | Experience |
| ---------------- | -------- | ------ | ---------- |
|  DatePicker  |  | `<dir>\Client\V2\Controls\ DatePicker\DatePickerBlade.ts` |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/DatePickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/DatePickerBlade) |
| DateTimePicker   |  [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md)  |  `<dir>\Client\V2\Controls\ DateTimePicker\DateTimePickerBlade.ts`   | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/DateTimePickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/DateTimePickerBlade)   |
| DateTimeRangePicker  | [portalfx-controls-datetimerangepicker.md](portalfx-controls-datetimerangepicker.md)  |   `<dir>\Client\V2\Controls\ DateTimeRangePicker\DateTimeRangePickerBlade.ts` | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/DateTimeRangePickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/DateTimeRangePickerBlade) |
| Date Polyfills |  | `<dir>\Client\V1\Controls\DatePolyFills\ViewModels\ DatePolyFillsViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/DatePolyFillsInstructions/selectedItem/DatePolyFillsInstructions/selectedValue/DatePolyFillsInstructions |
| DayPicker  |  | `<dir>\Client\V2\Controls\ DayPicker\DayPickerBlade.ts`   |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/DayPickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/DayPickerBlade) |
| DurationPicker |  | `<dir>\Client\V1\Controls\DurationPicker\ViewModels\ DurationPickerViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/DurationPickerInstructions/selectedItem/DurationPickerInstructions/selectedValue/DurationPickerInstructions |
| TimePicker |  | `<dir>\Client\V1\Controls\TimePicker\ViewModels\ TimePickerViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/TimePickerInstructions/selectedItem/TimePickerInstructions/selectedValue/TimePickerInstructions |


## Drop down controls

<!-- TODO: Determine whether it is more appropriate to have all the migration instructions located in one document, instead of one for each control. -->
| Drop Down | Document | Sample | Experience |
| --------- | -------- | ------ | ---------- |
| DropDown | [portalfx-controls-dropdown.md](portalfx-controls-dropdown.md) | `<dir>\Client\V2\Controls\ DropDown\DropDownBlade.ts` | [https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/DropDownPlayground](https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/DropDownPlayground) |
| Console   | [portalfx-controls-console.md](portalfx-controls-console.md) | `<dir>\Client\V2\Controls\ Console\ConsoleBlade.ts` <br>  `<dir>\Client\V1\Controls\Console2\ ViewModels\Console2ViewModels.ts` |  |

## Editors

| Editor      | Document | Sample | Experience |
| ----------- | -------- | ------ | ---------- |
| Code Editor | [portalfx-controls-editor.md](portalfx-controls-editor.md)    | `<dir>\Client\V1\Controls\Editor\ ViewModels\EditorViewModels.ts` <br> `<dir>\Client\V1\Controls\Editor\ ViewModels\CustomLanguageEditorViewModels.ts`      | |
| Markdown Editor  |  | `<dir>\Client\V1\Controls\Markdown\ViewModels\ MarkdownViewModels.ts`  | [https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/MarkdownPlayground](https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/MarkdownPlayground) <br>      [http://aka.ms/portalfx/samples#blade/SamplesExtension/MarkdownInstructions/selectedItem/MarkdownInstructions/selectedValue/MarkdownInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/MarkdownInstructions/selectedItem/MarkdownInstructions/selectedValue/MarkdownInstructions)  |
| JSONEditor |  | `<dir>\Client\V1\Controls\JSONEditor\ViewModels\JSONEditorViewModels.ts` |  |

## Forms controls

| Forms | Document | Sample | Experience |
| --------- | -------- | ------ | ---------- |
| CheckBox  |   |   |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/CheckBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/CheckBoxBlade) |
| TriStateCheckBox |   |   |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/TriStateCheckBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/TriStateCheckBoxBlade) |
| TextBox  |  [portalfx-controls-textbox.md](portalfx-controls-textbox.md)   | `<dir>\Client\V2\Controls\TextBox\TextBoxBlade.ts`  |   [https://df.onecloud.azure-test.net/#blade/SamplesExtension/TextBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/TextBoxBlade) <br>  [https://aka.ms/portalfx/sampleTextBox](https://aka.ms/portalfx/sampleTextBox) |
| MultiLineTextBox  |   |  `<dir>\Client\V2\Controls\MultiLineTextBox\MultiLineTextBoxBlade.ts` |   [https://df.onecloud.azure-test.net/#blade/SamplesExtension/MultiLineTextBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/MultiLineTextBoxBlade)  |
| NumericTextBox  |   |  `<dir>\Client\V2\Controls\NumericTextBox\NumericTextBoxBlade.ts` |   [https://df.onecloud.azure-test.net/#blade/SamplesExtension/NumericTextBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/NumericTextBoxBlade) |
| Option Picker  |   | `<dir>\Client\V2\Controls\OptionPicker\OptionPickerBlade.ts`   |  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/OptionPickerBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/OptionPickerBlade) |
| OptionsGroup | |  | [https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/OptionsGroupPlayground](https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/OptionsGroupPlayground) |
| PasswordBox  |  | `<dir>\Client\V2\Controls\Password\PasswordBoxBlade.ts`   | 	[https://df.onecloud.azure-test.net/#blade/SamplesExtension/PasswordBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/PasswordBoxBlade) |
| RadioButtons  |   |  | [https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/RadioButtonsPlayground](https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/RadioButtonsPlayground) |
| SearchBox |   |   |  [http://aka.ms/portalfx/samples#blade/SamplesExtension/SearchBoxBlade/selectedItem/SearchBoxBlade/selectedValue/SearchBoxBlade](http://aka.ms/portalfx/samples#blade/SamplesExtension/SearchBoxBlade/selectedItem/SearchBoxBlade/selectedValue/SearchBoxBlade) |
| Section |   |   |  [https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/SectionPlayground](https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/SectionPlayground) |
| Slider (includes Custom Value Slider, Range Slider, and Custom Range Slider) |  | `<dir>\Client\V2\Controls\Slider\SliderBlade.ts` | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SliderBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SliderBlade) <br> [https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/SliderPlayground](https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/SliderPlayground)   | 
| TabControl |   |  | [https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/TabControlPlayground](https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/TabControlPlayground) |

## List controls

| Gallery | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| Grid and EditableGrid |  [portalfx-controls-grid.md](portalfx-controls-grid.md) | `<dir>\Client\V2\Controls\Grid\ItemsWithDynamicCommandsBlade.ts` <br>   `<dir>\Client\V2\Controls\EditableGrid\ EditableGrid.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridCustomValidation.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridDependentDropDowns.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridDynamicCellTypes.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridMaxEntries.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridOperations.ts` <br> `<dir>\Client\V2\Controls\EditableGrid\ EditableGridValidation.ts` | https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/BasicGridInstructions <br> http://aka.ms/portalfx/samples#blade/SamplesExtension/EditableGridInstructions |
| Grid and Grid Controls     | [portalfx-controls-grid.md](portalfx-controls-grid.md)                               | `<dir>\Client\V1\Controls\Grid\ ViewModels\ScrollableGridWithFilteringAndSorting.ts`     `<dir>/Client/V1/Controls/Grid/ViewModels/BasicGridViewModel.ts`     `<dir>Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts`      | [http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions) |
| ListView |  |  `<dir>\Client\V1\Controls\ListView\ViewModels\BasicListViewViewModels.ts` <br>  `<dir>\Client\V1\Controls\ListView\ViewModels\CustomListViewViewModels.ts` <br>  `<dir>\Client\V1\Controls\ListView\ViewModels\IndexViewModels.ts` <br>  `<dir>\Client\V1\Controls\ListView\ViewModels\ListViewChildBladeViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/ListViewInstructions/selectedItem/ListViewInstructions/selectedValue/ListViewInstructions |
| Tree View|  | `<dir>\Client\V1\Controls\Tree\TreeBlade.ts`  `<dir>\Client\V1\Controls\Tree\TreeItemBlade.ts`  |   [http://aka.ms/portalfx/samples#blade/SamplesExtension/TreeBlade](http://aka.ms/portalfx/samples#blade/SamplesExtension/TreeBlade)
| String List | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/StringListInstructions/selectedItem/StringListInstructions/selectedValue/StringListInstructions

## Helpers and Indicators

| Helpers | Document | Sample | Experience |
| ------- | -------- | ------ | ---------- |
| InfoBalloon |  | `<dir>\Client\V1\Controls\DockedBalloon\ViewModels\DockedBalloonViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/DockedBalloonInstructions/selectedItem/DockedBalloonInstructions/selectedValue/DockedBalloonInstructions  |
| InfoBox |  | `<dir>\Client\V2\Controls\Infobox\InfoboxBlade.ts` | [https://df.onecloud.azure-test.net/#blade/SamplesExtension/InfoBoxBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/InfoBoxBlade) |
| ProgressBar |  | `<dir>\Client\V1\Controls\ProgressBar\ViewModels\ProgressBarViewModels.ts` |  [https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/ProgressBarPlayground](https://ms.portal.azure.com/?Microsoft_Azure_Playground=true#blade/Microsoft_Azure_Playground/ControlsIndex/ProgressBarPlayground) <br> [http://aka.ms/portalfx/samples#blade/SamplesExtension/ProgressBarInstructions/selectedItem/ProgressBarInstructions/selectedValue/ProgressBarInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/ProgressBarInstructions/selectedItem/ProgressBarInstructions/selectedValue/ProgressBarInstructions)  |

## Data Visualization Objects

| Screen Objects  | Document | Sample | Experience |
| ------------- | -------- | ------ | ---------- |
| | |  <p align="center">Aggregates</p> | |
| Controls Chart    | [portalfx-controls-chart.md](portalfx-controls-chart.md)     |  `<dir>\Client\V1\Controls\Chart\ViewModels\BarChartViewModels.ts` <br>     `<dir>\Client\V1\Controls\Chart\ViewModels\OverlayedViewChartViewModel.ts` `\Client\Controls\Chart\ViewModels\LineChartDateBasedViewModels.ts` |  |
| Plotting Metrics  (Monitor Chart and Monitor Chart V2)       | [portalfx-controls-monitor-chart.md](portalfx-controls-monitor-chart.md) | `<dir>\Client\V2\Preview\MonitorChart\ MonitorChartBlade.ts`     | [https://aka.ms/portalfx/sampleMonitorChart](https://aka.ms/portalfx/sampleMonitorChart) |
| Donut         | [portalfx-controls-donut.md](portalfx-controls-donut.md) | `<dir>\Client\V2\Controls\Donut\DonutBlade.ts`  | |
|       | | <p align="center">Gauges</p>   | |
| Quota Gauge   | | | [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground)  |   
| Single Value Gauge | |  | [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground)  |  
| | |<p align="center">Graphs</p>    | | |
| CustomHtml | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/graphCustomNodeInstructions |
| Standard Graph  | [portalfx-controls-graph-nuget.md](portalfx-controls-graph-nuget.md)| | http://aka.ms/portalfx/samples#blade/SamplesExtension/graphInstructions |
| | | <p align="center">Maps</p>  | |
| Base Map | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/BaseMapInstructions |
| Hexagon Layout Map | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/HexagonMapInstructions |
| HotSpot | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/HotSpotInstructions/selectedItem/HotSpotInstructions/selectedValue/HotSpotInstructions |
| Legend | | `<dir>\Client\V1\Controls\Legend\ViewModels\LegendViewModels.ts` | http://aka.ms/portalfx/samples#blade/SamplesExtension/Legend/selectedItem/Legend/selectedValue/Legend  | 
| Log Stream | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/LogStreamInstructions/selectedItem/LogStreamInstructions/selectedValue/LogStreamInstructions |
| Menu | | |http://aka.ms/portalfx/samples#blade/SamplesExtension/MenuInstructions/selectedItem/MenuInstructions/selectedValue/MenuInstructions |
| Spec Comparison Table | | | http://aka.ms/portalfx/samples#blade/SamplesExtension/SpecComparisonTableInstructions/selectedItem/SpecComparisonTableInstructions/selectedValue/SpecComparisonTableInstructions |
