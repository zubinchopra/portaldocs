
## Grid

The grid control in the SDK provides a rich set of features to build experiences that display tabular, structured data.

![alt-text](../media/portalfx-controls/grid-intro.png "Grid")

The grid control can be configured with different options such as multiple selection, custom formatters, grouping, filtering, sorting, paging and virtualization. This flexibility provides experiences that range from simple visualization of basic lists, to advanced scenarios such as virtualized hierarchical data.

These behaviors are added to the grid control by using plugins. Grid plugins are also known as "API extensions". This terminology can be confusing to Portal extension developers, therefore, for the purposes of discussion, grid extensions are referred to as plugins.

Plugins are enabled in three ways.

1. With bit flags that are sent to the ViewModel constructor
1. As a dependency of an enabled plugin
1. By default

The following subtopics are discussed in this document.

* [Getting Started](#getting-started)

* [Enabling Plugins](#enabling-plugins)

* [Providing Data](#providing-data)

* [Defining Columns](#defining-columns)

* [Formatting](#formatting)

* [Selection and Activation](#selection-and-activation)

* [Sorting](#sorting)

* [Filtering](#filtering)

* [Editing](#editing)

* [Paging](#paging)

* [Grouping](#grouping)

* [Hierarchical](#hierarchical)

* [Context Menus](#context-menus)

* [Scrolling ](#scrolling)

* [Reordering](#reordering)

* [Dynamic Grid Definition](#dynamic-grid-definition)

### Getting Started

The Grid API is in the `MsPortalFx.ViewModels.Controls.Lists.Grid` namespace.
To create a grid you will need to provide data, column definitions, plugins, and options. 
Some basic implementations are located in the following table.

| Name | Purpose | Location | 
| ---- | ----- | -- |
| All Grid Samples | | [http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/GridInstructions/selectedItem/GridInstructions/selectedValue/GridInstructions)  | 
| Basic Grid | | [http://aka.ms/portalfx/samples#blade/SamplesExtension/BasicGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/BasicGridInstructions) | 
| Context Menu Shortcut Grid | Contains shortcuts to item context menus that are displayed in each row. | [http://aka.ms/portalfx/samples#blade/SamplesExtension/ItemsWithDynamicCommandsBlade](http://aka.ms/portalfx/samples#blade/SamplesExtension/ItemsWithDynamicCommandsBlade) |
| Editable Grid |  Contains editable rows | [http://aka.ms/portalfx/samples#blade/SamplesExtension/EditableGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/EditableGridInstructions) |
| Filterable Grid | Contains filterable rows | [http://aka.ms/portalfx/samples#blade/SamplesExtension/FilterableGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/FilterableGridInstructions) |
| Formatted Grid | | [http://aka.ms/portalfx/samples#blade/SamplesExtension/FormattedGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/FormattedGridInstructions) | 
| Grouped Grid | Groups rows by column value | [http://aka.ms/portalfx/samples#blade/SamplesExtension/GroupedGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/GroupedGridInstructions) |
| Hierarchical Grid | Displays hierarchical items | [http://aka.ms/portalfx/samples#blade/SamplesExtension/HierarchicalGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/HierarchicalGridInstructions) |
| Pageable Grid | Handles and displays large items in sequential pages | [http://aka.ms/portalfx/samples#blade/SamplesExtension/PageableGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/PageableGridInstructions) | 
| Reorder Grid | Reorders rows |[http://aka.ms/portalfx/samples#blade/SamplesExtension/ReorderGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/ReorderGridInstructions) |
| Resizeable Column Grid | Contains have resizable columns |  [http://aka.ms/portalfx/samples#blade/SamplesExtension/ResizableColumnGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/ResizableColumnGridInstructions) |
| Scrollable Grid | Displays items with virtual scrolling | [http://aka.ms/portalfx/samples#blade/SamplesExtension/ScrollableGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/ScrollableGridInstructions) |
| Selectable Grid | Contains selectable rows | [http://aka.ms/portalfx/samples#blade/SamplesExtension/SelectableGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/SelectableGridInstructions) | 
| Sortable Column Grid | Contains sortable columns | [http://aka.ms/portalfx/samples#blade/SamplesExtension/SortableColumnGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/SortableColumnGridInstructions) |

### Enabling Plugins

 Perform the following two actions to enable a plugin.
 
1. Set the appropriate bit flag when the grid is constructed. Bit flags are combined by using the  "|" or the  "+" operator.  The "&" operator cannot be used.  If it is used, a plugin will not be created.
1. Provide plugin options.

The following chart specifies which plugins can be combined. 

![alt-text](../media/portalfx-controls/gridchart.png "No-code Browse grid")

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. 

The sample located at `<dir>\Client/V1/Controls/Grid/ViewModels/ScrollableGridWithFilteringAndSorting.ts` contains a simple method of enabling the plugins.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Controls/Grid/ViewModels/ScrollableGridWithFilteringAndSorting.ts", "section": "grid#enablingplugins"}

### Providing Data

Typically, when data is provided to a grid, it is provided in the `items` parameter as a `KnockoutObservableArray&lt;T>`.
The array can be created within the extension, but it is more common to use the `items` property of a `QueryView` object.

When data is virtualized, it is provided to the grid by using a `DataNavigator` object. Navigators can support two data retrieval patterns.

1. Sequential data access using continuation tokens. Sequential navigation can be enabled by the `Pageable` plugin.
1. Random data access, which is also known as skip-take. Random access navigation can be enabled by the `Pageable` or `Scrollable` plugins.

For more information about data handling, see [top-legacy-data.md](top-legacy-data.md).

### Defining Columns

Columns are defined by setting the `columns` property on the grid `ViewModel`. The header text of the column is declared by using the `name` property. The grid is populated by using property-value or key-value pairs. The `itemKey` contains the name of the data item property. For each data item, the grid will use the `itemKey` to retrieve the value that will be used for each cell value for the column.

There are many other column options that specify the formatting of the value, or enable plugin-specific behaviors, as in the example located at `<dir>/Client/V1/Controls/Grid/ViewModels/BasicGridViewModel.ts` and in the following example.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Controls/Grid/ViewModels/BasicGridViewModel.ts", "section": "grid#columndefinitions"}

### Formatting

Columns are formatted using three key properties.

* **itemKey**: The property of the data item to display.

* **format**: Optional format type from the Format enumeration. 

* **formatOptions**: Optional formatter-specific options.

The column `itemKey` is formated as text by using the default values. The text formatter does a `toString` conversion. There are many built-in formatters for formatting dates, numbers and other objects, as in the sample located at `<dir>/Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts`.

#### Formatting Dates

Dates are formatted using the International API, and the current locale that is set by the user. The data value of the date can be a number, a string, or a date. The formatters will convert that value  to a date, and then use the Intl API to convert it to text.

The following formatters can be used for formatting dates.
* ShortDate: 7/18/2013
* LongDate: Thursday, July 18, 2013 
* MonthDay: July 18
* YearMonth: July, 2013
* ShortTime: 11:20 AM
* LongTime: 11:20:19 AM
* CustomDate: Any format possible using Intl date formatting

The sample located at `<dir>/Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts` demonstrates how to format dates in the grid. It is also in the following code.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts", "section": "grid#dateformatter"}

The extension can use a customized International option, or it can use one of the predefined options from the `Globalization.Intl` namespace that is located at [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/DateTimeFormat).

#### Formatting Numbers

The Number formatter is a single formatter for formatting numbers. It uses the International API and formats to the current locale that the user set in the Portal. It uses many formats, including currency. It is in the sample located at `<dir>/Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts`, and is also in the following code.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts", "section": "grid#numberformatter"}

Predefined options are demonstrated in the `Intl.DateTimeFormat` namespace that is located at 
[https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/NumberFormat](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/NumberFormat).

#### Formatting Images

There are several formatters that display images in cells. For example, there are two formatters that use image URI's instead of SVGs. The preferred formatters are `SvgIcon` and `SvgIconLookup`. The Portal SVGs are preferred because they are themed.

* The `SvgIcon` formatter allows an extension to display an SVG with optional text that contains the SVG as a data value.  It also allows the display of an object that contains both the SVG and text content.

* The `SvgIconLookup` allows an extension to map data values to SVGs for display.

#### Formatting Uris

There is a URI formatter that formats a data value that contains a URI as a clickable link. The data value can also be an object that contains the URI, the text, and the target.

#### Formatting Text

The default formatter for the Grid is the `Text` formatter. There is also a `TextLookup` formatter that uses a map to convert specific data values to text.

#### Formatting Html

The `Html` formatter allows an extension to display `html`. The `html` is specified by data values and can not include **Knockout** data bindings. If **Knockout** bindings are needed, the extension should use the `HtmBindings` formatter.

#### Custom Formatting with HtmlBindings

The grid does custom formatting with the `HtmlBindings` formatter, which is the only way that custom formatting can be accomplished. The `HtmlBindings` formatter allows developers to specify an html template that contains **Knockout** bindings. The `$data` object that is bound to the template is in the following format, where the value specified by the `itemKey` property and `settings.item` is the data item.

```
{
    value: any,
    settings: {
       item: T
    }
}
```

The example is in the code located at `<dir>Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts`, and is also in the following example.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Controls/Grid/ViewModels/FormattedGridViewModel.ts", "section": "grid#customhtmlformatter"}

### Selection and Activation

The `SelectableRow` extension enables blade activations and row selections. Activation and selection are separate concepts that overlap in the grid.

* Activation in the grid is displaying a blade.

* Selection is the selecting of items within the grid.

The act of selecting data may also activate a blade, depending on the settings of the extension. This is performed  by setting the  `activateOnSelected` selection option to `true`, or by setting specific columns to be activatable by defining `activatable = true`.

<!-- TODO: Determine a better definition for heterogenerous and homogeneous blades. -->

Blade activations can be homogeneous or heterogeneous.

* For homogeneous blade activations, use `BladeAction` in the PDL file to specify the blade to open.

* For heterogeneous blade activation, use `DynamicBladeAction` in the PDL file.

You must also implement `createSelection` to return a `DynamicBladeSelection` object for each item.
 
### Sorting

If the `SortableColumn` plugin is enabled, grid headers can be used to sort the data.

If the extension uses a `dataNavigator`, the sorting options are sent to the navigator when they are changed, and the navigator should handle the sorting. This is typically accomplished by sending it to the server as part of the query.

If there is local data in an observable items array, the grid has a default sort callback that will sort the items in the array. A custom sort for local data can be provided for the extension in the `SortableColumnOptions sortCallback` property.
 
The initial `sortOrder` can be set for each column. The extension can also opt out of sorting a column by setting `sortable = false;`.

### Filtering

The grid has a `Filterable` row plugin that can be used for filtering. The plugin provides a simple search box UI that users can use to enter text.
The filtering can occur on the server or in the grid locally.  Filtering occurs in the grid on the client, unless `serverFiltering` is set to true to  enable filtering through the `dataNavigator`.

Client-side filtering works as follows.
<!-- TODO: Determine whether the following is true of server-side filtering also. -->
The set of properties to filter against are the `itemkeys` of all columns, by default. The extension can specify the set of properties to filter against by using the `searchableColumns` option.
<!-- end TODO -->


The grid looks for a column definition for every searchable property.

1. If a column definition is found, the grid looks for a `filterableFormat` option.
1. If a `filterableFormat` is found, it is used to convert the data to value to a searchable string.
1. If a `filterableFormat` is not found, the grid converts the value to a string using the `JSON.stringify` function and the text formatter.
1. The grid then searches for all the search terms in the formatted property values.
1. If every search term is found, the item is added to the filter results.

### Editing

The editable grid allows the user to edit a list of data entities. The user can add new items and edit or delete existing items. A row remains in the edit state until all the validators on the cells indicate the row is valid.

* When a row is being edited, the cells are formatted with the `editableFormat` specified on the column.
* When not being edited, the cells are formatted with the `format` that was specified in the column definition.

There are special formatters for editing that create form controls that allow data editing. These formatters are in the following list.

* CheckBox
* TextBox
* MultiselectDropDown
* CheckBoxRowSelection
* DropDown

### Paging

The pageable plugin enables virtualization for large data sets that use sequential and random access. There is also a scrollable plugin for random access scrolling. The following table compares sequential to random access.

| Item           | Sequential | Random Access |
| -------------- | ---------- | ------------- |
| `type`         | Specified as `PageableType.Sequential` | Specified as `PageableType.Page` |
| data navigator | Supports `loadByContinuationToken` |  Supports `loadBySkipTake` |
| After first page is loaded | Display a button to load more data | Display a pager control for navigation through subsequent data pages |

### Grouping

The groupable plugin orders data into groups of rows, each of which has a group header. The  groups are specified  by using the `groupKey` option to read the property of the data item. Each item that has the same value for the `groupKey` property will be in the same group.

By default, the groups are auto-generated for each unique group.  However, the developer can generate the  groups by using the `groups` property.

### Hierarchical

The hierarchical grid plugin displays hierarchical data and allows the user to expand and collapse parent rows.
To display hierarchical data the extension implements a hierarchy. The hierarchy implementation initializes and keeps track of the expanded states for all items. The hierarchy supplies the current items to display on the grid, and the grid notifies the hierarchy when the user expands or collapses a row, whereupon the hierarchy updates the items.

Hierarchies also supports virtualization with the `Pageable` or `Scrollable` plugins. The developer creates a custom data navigator that implements the hierarchy interface for virtualization. This is because the navigator outputs data items that exclude the child objects of the parent rows that are collapsed. The virtual hierarchy also needs to update the navigator `metatdata totalItemCount` on every expand or collapse action, so that it can return the total number of items that are displayed, which excludes the the collapsed child objects. Updating the count makes the grid aware that the virtualization should be updated. 

The hierarchical grid implementations are located in the following table.

| Name | Location | 
| ---- | -------- |
| Pageable Hierarchical Grid Sample | [http://aka.ms/portalfx/samples#blade/SamplesExtension/PageableHierarchicalGridInstructions](http://aka.ms/portalfx/samples#blade/SamplesExtension/PageableHierarchicalGridInstructions) |
| WorkitemScenarioSample | [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/scenariosworkitem](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/scenariosworkitem) |

### Context Menus

The context menu shortcut is the ellipsis at the end of each grid row. This plugin is enabled by default, and enables displaying the context menu by using a click.

To customize the context menu, the extension supplies a `commandGroup` property on the grid item that contains the command group to be displayed.
 
### Scrolling

The scrollable grid plugin enables scrolling within the grid. This is useful when the grid needs to keep the headers at the top of a container that it is filling. The container element has a width and height so that the scrolling displays correctly. The scrolling can be virtualized or non-virtualized.

To fill a blade with the scrollable grid, set the blade-part size to `FitToContainer`. This sets the blade content area height and width to the viewport size.

Virtualized scrolling requires a data navigator that supports the `loadBySkipTake` method. Non-virtualized grids do not requires a data navigator because the extension sets the grid `items` property directly.

### Reordering

The grid reorder plugin allows users to reorder the items in the grid with drag and drop. The reordering can be automatic or handled by the extension by using the `reorderRow` event.

### Dynamic Grid Definition

In some cases an extension may not be aware of grid columns or other properties previous to being requested by the user. In these scenarios, the extension should define and create the grid at run-time. There are several options for dynamic definition of a grid.

1. Create and add columns when data is available.  The `columns` property is an observable array and allows changes as needed.

1. Make the grid `ViewModel` property on the blade or part observable.

    * Old declaration
   
        `public grid: Grid.ViewModel<T>;` 

    * New declaration
   
        `public grid: KnockoutObservable<Grid.ViewModel<T>>;`. 

    This makes the `ViewModel` property observable, so that it can be set by the extension whenever it is appropriate. It can also be cleared by setting it to null. The binding template would be the same, as in the following code.

     `<div data-bind="pcControl: grid"></div>`.

1. Use sections for layout.  The grid can be added dynamically to the section children.

1. `CustomHtml` control has an updatable inner `ViewModel`.

1. The `htmlTemplate` binding allows the extension  to dynamically specify both the `ViewModel` and the binding template `<div data-bind="htmlTemplate: { data: viewModel, html: template }"></div>`.

<!-- TODO: 
Update this section when these plugins are complete.
### Plugins

- RightClickableRow (Docs coming soon)            - Plugin to have right-clickable row.
- Hoverable (Docs coming soon)                    - Plugin to enable hover index communication with other parts.
-->