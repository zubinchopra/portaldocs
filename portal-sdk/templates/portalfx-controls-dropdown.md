## DropDown

The AMD dropdown contains all the features of the previous dropdowns.

Previously, adding a feature meant porting the code to a different control, or was not possible depending on the combination of features. Now, extensions can turn on filtering or add grouping to a multiselect dropdown.

For more information about migrating to this control, see [portalfx-controls-dropdown-migration.md](portalfx-controls-dropdown-migration.md).

### How to use the AMD module

1. The  AMD module is used by importing the module, as in the following code.

    ```typescript
    import * as DropDown from "Fx/Controls/DropDown";
    ```

1. Then, create the ViewModel.

    ```typescript
    // Items to populate the dropdown with.
    let myItems = [{
        text: "Sample text",
        value: "SampleValue"
    }, {
        text: "Sample text 2",
        value: "SampleValue2"
    }];

    this.dropDownVM = DropDown.create(container, {
    items: myItems
    });
    ```

### Features

The AMD dropdown supports the following functionality.
* [Accessibility](#accessibility)
* [Filtering and searching](#filtering-and-searching) 
* [Grouping](#grouping)
* [isPopUpOpen](#isPopUpOpen)
* [Multiselect](#multiselect)
* [Multiselect and Filtering](#multiselect-and-filtering) 
* [Placeholder](#placeholder)
* [Rich Templating](#rich-templating)

### Accessibility 

The Azure Portal handles most accessibility.

**NOTE**: If an html template or image binding is used in item text, an `ariaLabel` should be added on that item.


### Filtering and searching
For large lists of items, an extension can turn on `filtering: true` to enable searching.

```typescript
this.dropDownVM = DropDown.create(container, {
   items: myItems,
   filter: true
});
```

#### filterPlaceholder 

Populates the search with a placeholder. It overwrites the `placeholder` property on the dropdown.

```typescript
this.dropDownVM = DropDown.create(container, {
   items: myItems,
   filter: true,
   filterPlaceholder: "Search items"
});
```

### Grouping

Dropdown items can be grouped together by expanding the dropdown item with a group type, as in the following example.
 
```typescript
let myItems = [{
    text: "Sample header text",
    children: [{
        text: "Sample text",
        value: "SampleValue"
      }, {
          text: "Sample text 2",
          value: "SampleValue2"
      }]
}]
```

Multiple groups can be grouped together to create a nested layout.

### isPopUpOpen

This a readonly observable to which an extension can subscribe, so that it will be informed when the dropdown is opened or closed. It is used when the loading of items is delayed because they are populated from an expensive **AJAX** call.

```typescript
this.dropDownVM.isPopUpOpen.subscribe(container, (opened) => {
    if (opened) {
        // make your expensive call here.
    }
});
```

### Multiselect

When an extension needs to select multiple items, the `multiselect` can be set to `true` to allow this. Then, the selected items are displayed as "X selected". The multiselect dropdown does not use `placeholder`. Instead, use [`multiItemDisplayText`](#multiitemdisplaytext) as in the following example.

```typescript
this.dropDownVM = DropDown.create(container, {
   items: myItems,
   multiselect: true
});
```

#### MultiItemDisplayText 

The `multiItemDisplayText` changes the format of the default text. Include a {0} in the replaced string to include the number of items selected, as in the following example.

```typescript
this.dropDownVM = DropDown.create(container, {
   items: myItems,
   multiselect: true,
   multiItemDisplayText: "{0} subscriptions"
});
```

### Multiselect and filtering

The dropdown supports both filtering and  multiselect states as active. The filter textbox will move into the dropdown, as in the following example.

```typescript
this.dropDownVM = DropDown.create(container, {
   items: myItems,
   filter: true,
   multiselect: true
});
```

### Placeholder

This functionality adds a default string to show that nothing is selected.

```typescript
this.dropDownVM = DropDown.create(container, {
   items: myItems,
   placeholder: "Select an item"
});
```

### Rich Templating

The dropdown supports both filtering & multiselect states as active. The filter textbox will move into the dropdown, as in the following example.

```typescript
let myItems = [{
        text: "<b>G1</b> - large"
        value: "large"
    },{
        text: "<b>G2</b> - small"
        value: "small"
}];

this.dropDownVM = DropDown.create(container, {
   items: myItems
});
```

