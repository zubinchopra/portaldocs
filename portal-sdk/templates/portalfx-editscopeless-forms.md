
## EditScopeless Forms

Edit scopes provide a standard way of managing edits over a collection of input fields, blades, and extensions. They provide common functions that would otherwise be difficult to orchestrate, like tracking changes in field values across a form, or simplifying the merge  of form changes from the server into the current edit. In contrast, editscope-less forms are compatible with new controls and consequently, EditScopes are becoming obsolete. It is recommended that extensions be developed without edit scopes.

<!-- TODO: Determine whether controls like OptionsGroup, that are not located in Fx/Controls, are considered part of the EditScopeless pattern.   -->

The EditScopeless form controls are located in the `Fx/Controls` namespace. They support creating forms without initializing their `editscope`. There is less  association with the `editscope` accessors, which makes the initialization of the controls easier. The  `editScope` is no longer tied to each control, and the controls become stateless. This means two things.

1. There is no initial value for these controls.  The value of a control is initialized by setting it.

    ```ts
    textboxViewModel.value("Some Initial Value");
    ```  

1. Extension developers have the the state of the control after its data has been changed by setting the `dirty` value, as in the following code.

    ```ts
    textboxViewModel.dirty(true);
    ```  
 

### Controls Namespace

The new controls can be used in extensions by importing them, as in the following code.

```ts
import * as Section from "Fx/Controls/Section";
import * as TextBox from "Fx/Controls/TextBox";
``` 

<!-- TODO: Determine whether controls outside of "Fx/Controls" should be included in the table.  -->

The folloiwng is a list of all the new controls that are available in "Fx/Controls", in addition to  a list of documents that discuss the control in more detail. For samples and experiences that are associated with editscope-less form controls, see [portalfx-extensions-samples-overview.md](portalfx-extensions-samples-overview.md).

| Control                 | Document                                                                             | 
| ----------------------- | ------------------------------------------------------------------------------------ |  
| Button                  |                                                                                      | 
| CheckBox                |                                                                                      | 
| CustomHtml              | [portalfx-forms-designing.md](portalfx-forms-designing.md)                             | 
| DateTimePicker          | [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md)           |  
| DateTimeRangePicker     | [portalfx-controls-datetimerangepicker.md](portalfx-controls-datetimerangepicker.md) | 
| DayPicker               |                                                                                      | 
| DropDown                | [portalfx-controls-dropdown.md](portalfx-controls-dropdown.md)                       | 
| DurationPicker          |                                                                                      | 
| FileUpload              |                                                                                      | 
| MultiLineTextBox        |                                                                                      | 
| NumericTextBox          |                                                                                      | 
| OptionsGroup            |                                                                                      | 
| PasswordBox             |                                                                                      | 
| RadioButton             |                                                                                      | 
| RangeSlider             |                                                                                      | 
| Section (Form Sections) | [portalfx-forms-designing.md](portalfx-forms-designing.md)                             | 
| Slider                  |                                                                                      | 
| TabControl              |                                                                                      | 
| TextBox                 | [portalfx-controls-textbox.md](portalfx-controls-textbox.md)                         |
| TimePicker              | [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md)           | 
| TriStateCheckBox        |                                                                                      | 

### Initializing Controls

The controls are initialized through a factory method called `create()`. This function returns an interface. The following example invokes the `create()` method to create a TextBox with specific label, subLabel and a collection of validations.

```ts
import * as TextBox from "Fx/Controls/TextBox";

const firstNameViewModel = TextBox.create(container, {
    label: "First Name",
    subLabel: "Try: John",
    validations: [
        new Validations.Required(ClientResources.emptyFirstName),
        new Validations.RegExMatch("^[a-zA-Z]+", `${ClientResources.startsWithLetterValidationMessage} <a href="https://www.bing.com/search?q=Personal+names+around+the+world" target="_blank">${ClientResources.clickForMoreInfo}</a>`)
    ]
});
```

### Dropdown loading indicator

The Ibiza SDK now supports displaying the loading indicator when data is loaded by an asynchronous **AJAX** call that populates the dropdown. The following code implements a loading indicator that uses a dropdown.

```ts

// Controls Namespace
import * as DropDown from "Fx/Controls/DropDown";

// Initialize control with no data. Set loading indicator to true
const dropDownViewModel = DropDown.create<string>(container, {
    label: ClientResources.spouse,
    validations: [ new Validations.Required(ClientResources.emptySpouse) ],
    loading: true  // ...and dynamically switch to 'false' once the dropdown items are loaded.
});

// fetch data asynchronously and remove loading indicator on data load
const dropdownDataPromise = Q(model.people.fetch("", container)).then((people) => {
    const dropDownItems = people.data.mapInto(container, (childLifetime: MsPortalFx.Base.LifetimeManager, person: SamplesExtension.DataModels.Person) => {
        return {
            text: person.name(),
            value: person.name()
        };
    }, dropDownViewModel.items);
    dropDownViewModel.loading(false);
});
```

### Customizing Alerts

The SDK provides two ways to configure the behavior of an alert, which is the pop-up that is displayed when the  user tries to close a form that contains unsaved edits. 


1. The alert can be suppressed the alert by setting the value to `FxViewModels.AlertLevel.None`, as in the following code.

    ```ts
    form.configureAlertOnClose(FxViewModels.AlertLevel.None);
    ```

1. The value of the alert's behavior can be computed and returned to the `Message` function by using an overloaded definition, which is appropriate for more complex scenarios. The behavior of the alert and message are dynamically set, based on the checkbox and textBox, as in the following code.

```ts

this._container.form.configureAlertOnClose(ko.computed(container, () => {
    return {
        showAlert: configureCheckBox.value(),
        message: configureMessageTextBox.value()
    }
}));

```

#### Other CSS classes

Other CSS classes are in the following list.

* msportalfx-docking-header
* msportalfx-docking-body
* msportalfx-docking-footer
* msportalfx-padding

 The `msportalfx-docking-*` classes are used when elements will be docked at the header, body or footer of the blade. 

<!-- TODO: Determine whether 10 x 10 is px or some other unit of measurement. -->
The `msportalfx-padding` class adds 10 x 10 padding to the blade.

These blade styling css classes  allow the blade to be used as a canvas.

**NOTE**: Unlike previous version of SDK, No-PDL blades do not add padding or docking content behavior by default. This  makes style management easier.

### Replacing Action Bar with Button

Out-of-the-box CSS classes can be used to dock a button at the bottom of blade and make it look like an Action Bar.

The following sample demonstrates how to replace the action bar by docking a button and errorInfo box at the bottom of the blade by using the `msportalfx-docking-footer` css class. The `msportalfx-padding` class  adds 10 x 10 padding to the docked footer.

```html

<div class='msportalfx-docking-footer msportalfx-padding'>
    <div data-bind='pcControl: errorBox, visible: showErrorBox'></div>
    <div data-bind='pcControl: okButton' class='ext-ok-button'></div><a>Link</a>
</div>

```

### Closing the blade

The following code closes the blade.

```ts

const okButtonClick = () => {
    container.closeCurrentBlade({
                            firstName: firstNameViewModel.value(),
                            lastName: lastNameViewModel.value(),
                            spouse: dropDownViewModel.value(),
                            password: passwordViewModel.value(),
                        });
};
```