## DropDown
The AMD dropdown has all the features of the old dropdowns. You can now turn on filtering or add grouping to a multiselect dropdown where previously adding a featuring might mean porting your code to a differen control (or 
wasn't possible depending on combination of features you were looking for). The AMD dropdown supports:

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

### Items/Groups
##### Items example
```typescript
[{
    text: "Sample text",
    value: "SampleValue"
}, {
    text: "Sample text 2",
    value: "SampleValue2"
}]
```

##### Group example
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
