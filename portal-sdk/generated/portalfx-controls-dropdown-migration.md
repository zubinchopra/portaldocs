<a name="migrating-from-obsolete-dropdown-controls"></a>
## Migrating from obsolete dropdown controls

The biggest reason to replace usage of older dropdown controls with the AMD dropdown is that all the features
of the other dropdowns are now present in the AMD dropdown. Extensions can now turn on filtering or add grouping to a multiselect dropdown.

The AMD dropdown supports:

* Grouping
* Rich Templating
* Filtering 
* Custom Filtering, this also gives you a hook to replace items on keystroke.
* Multiselect
* Objects as the value

This applies to upgrading the following controls to the new AMD dropdown pattern.

```typescript
    MsPortalFx.ViewModels.Obsolete.Forms.DropDown
    MsPortalFx.ViewModels.Obsolete.Forms.FilterComboBox
    MsPortalFx.ViewModels.Obsolete.Forms.GroupDropDown
    MsPortalFx.ViewModels.Obsolete.Forms.MultiSelectDropDown
```

<a name="migrating-from-obsolete-dropdown-controls-how-to-convert-to-a-new-dropdown"></a>
### How to convert to a new DropDown

<details>

   <summary>MultiSelectDropDown was bound to an EditScope observable</summary>

   The following code is a sample of using  `multiSelectDropDownValue` as a path to an `EditScope` observable.

   ```typescript
       this.myMultiSelectDropDown = new MultiSelectDropDown.ViewModel(this._container, this, "multiSelectDropDownValue", {
           ...
       });
   ```

   The following code is an example of using  `multiSelectDropDownValue` as a path to an  `EditScopeAccessor` observable.

   ```typescript
       MultiSelectDropDown.ViewModel(this._container, this, this.createEditScopeAccessor<string>((data) => { return data.multiSelectDropDownValue; }), {
           ...
       });
   ```

   Instead of using either of the previous two samples, switch to the new AMD Dropdown, by performing the following steps.

   1. Add the import that is in the following code. 

        ```typescript
            // Add this import @ the top of the file
            import * as DropDown from "Fx/Controls/DropDown";
        ```

    1. Add the property to the `ViewModel` of the blade.

        ```typescript
            /**
            * ViewModel for the drop down control.
            */
            public dropDown: DropDown.ViewModel<string>; 
        ```

    1. And finally switch to the following code.

        ```typescript
            this.dropDown = new DropDown.ViewModel(container, this, "multiSelectDropDownValue" {
                label: ClientResources.multiSelectDropDownSingleSelectLabel,
                infoBalloonContent: ko.observable(ClientResources.multiSelectDropDownInfoBalloon),
                items: items,
            });
        ```

        Or, switch to the following code if the extension uses the `EditScopeAccessor`.

        ```typescript
            this.dropDown = new DropDown.ViewModel(container, this, this.createEditScopeAccessor<string>((data) => { return data.multiSelectDropDownValue; }) {
                label: ClientResources.multiSelectDropDownSingleSelectLabel,
                infoBalloonContent: ko.observable(ClientResources.multiSelectDropDownInfoBalloon),
                items: items,
            });
        ```

    1. Follow the instructions in the section named [Add multi-select functionality](#add-multi-select-functionality) to add multiselect and filtering to the new DropDown in your extension.
</details>

<details>

   <summary>MultiSelectDropDown was not bound to an EditScope observable</summary>

   If the `MultiSelectDropDown` in the extension does not use an `EditScope`, it can be converted to an AMD DropDown using the new form field APIs that are EditScope-less. 

   For more information about the EditScope-less form field APIs  that are recommended for developing new blades, see [portalfx-editscopeless-forms.md](portalfx-editscopeless-forms.md).

   The previous scenario for the MultiSelectDropDown->DropDown resembled the following code.
   
```typescript
    /**
    * ViewModel for the multiselect drop down control.
    */
    public multiSelectDropDownVM: MultiSelectDropDown.ViewModel<string>;
        
    const items: MsPortalFx.ViewModels.Forms.ISelectableOption<string>[] = [
    	{ text: ko.observable("Item 1"), value: "Value 1" },
    	{ text: ko.observable("Item 2"), value: "Value 2" },
    	{ text: ko.observable("Item 3"), value: "Value 3" },
    	{ text: ko.observable("Item 4"), value: "Value 4" },
    ];

    this.oldMultiSelectDropDownVM = new MultiSelectDropDown.ViewModel<string>(container, {
    	label: ko.observable(ClientResources.multiSelectDropDownLabel),
    	groups: ko.observableArray<MsPortalFx.ViewModels.Forms.IGroup<string>>([
    		<MsPortalFx.ViewModels.Forms.IGroup<string>>{
    			options: ko.observableArray<MsPortalFx.ViewModels.Forms.ISelectableOption<string>>(items)
    		}
    	]),
    	validations: ko.observableArray([
    		new MsPortalFx.ViewModels.RequiredValidation(),
    		new MsPortalFx.ViewModels.ContainsValidation("Value 1")
    	])
    });
```

1. To convert to the AMD Dropdown, modify the code to resemble the following example.

New import:
```typescript
    // Add this import @ the top of the file
    import * as DropDown from "Fx/Controls/DropDown";
```

1. Add the property to your Blade ViewModel:
```typescript
    /**
    * ViewModel for the drop down control.
    */
    public dropDown: DropDown.Contract<string>;
```

1. Then inside your constructor: 
   
```typescript
     const items = [ 
        { text: ko.observable("Item 1"), value: "Value 1" },
        { text: ko.observable("Item 2"), value: "Value 2" },
        { text: ko.observable("Item 3"), value: "Value 3" },
        { text: ko.observable("Item 4"), value: "Value 4" },
     ];

    // New basic drop down 
    this.dropDown = DropDown.create<string>(container, {
    	label: ClientResources.multiSelectDropDownSingleSelectLabel,
    	infoBalloonContent: ko.observable(ClientResources.multiSelectDropDownInfoBalloon), 
    	items: items, 
    });
```


</details>

<a name="migrating-from-obsolete-dropdown-controls-add-multi-select-functionality"></a>
### Add multi-select functionality


Just add `multiselect: true` to your options in the create call like this:

```typescript
    // DropDown with multiselect
    this.dropDown = DropDown.create<string>(container, {
    	...
    	multiselect: true,
    	selectAll: true // Optional, adds a select all checkbox to the top of the dropdown popup.
    });
```

-----------------------------------------------------------------

<a name="migrating-from-obsolete-dropdown-controls-add-filtering-functionality-to-your-new-dropdown"></a>
### Add filtering functionality to your new DropDown

Just add `filter: true` to your options in the create call like this:
  
```typescript
    // DropDown with filtering
    this.dropDown = DropDown.create<string>(container, {
        ...
        filter: true,
        filterPlaceholder: ClientResources.fitlerPlaceholder,   // Optional if you want placeholder text in the filter text box.
    });
```

-----------------------------------------------------------------
**Notes:**
 - You can mix filtering/multiselect to have a filterable multiselect DropDown.
 - When multi-select is true, the 'value' property of your DropDown ViewModel (that is, `dropDown.value`) is no longer a semicolon-separated string. Rather, it's of type `TValue[]`, where `TValue` is the generic type argument supplied to `DropDown.create<TValue>`.

