## DropDown
The AMD dropdown has all the features of the old dropdowns. You can now turn on filtering or add grouping to a multiselect dropdown where previously adding a featuring might mean porting your code to a different control (or 
wasn't possible depending on combination of features you were looking for). 

The AMD dropdown supports:
- Grouping
- Rich Templating
- Filtering 
- Custom Filtering
- Multiselect
- Objects as the value

You can use it by importing the AMD module:

```typescript
import * as DropDown from "Fx/Controls/DropDown";
```

Creating the view model: 

```typescript
// Items to popuplate the dropdown with.
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

## Features

#### Grouping
Grouping is simple by expanding the dropdown item with a group type. 
 
 ###### Group type example
```typescript
[{
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

You are able to group multiple groups together to create a nested layout.

#### Filtering / Searching
For large list of items you are able to turn on `filtering: true` to enable searching.

```typescript
this.dropDownVM = DropDown.create(container, {
   items: myItems,
   filter: true
});
```

#### Multiselect
When you need multiple items selected we support `multiselect: true` to allow this.

```typescript
this.dropDownVM = DropDown.create(container, {
   items: myItems,
   multiselect: true
});
```

#### Filter & Multiselect
The dropdown supports both filtering & multiselect states to be active. The filter textbox will move into the dropdown.

```typescript
this.dropDownVM = DropDown.create(container, {
   items: myItems,
   filter: true,
   multiselect: true
});
```

## Accessibility 
We handle most accessibility, one important note though is if you use an html template or image binding in your item text. You need to add an ariaLabel on that item.
