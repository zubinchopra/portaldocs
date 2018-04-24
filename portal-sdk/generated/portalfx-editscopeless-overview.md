
<a name="forms-without-editscopes"></a>
## Forms without EditScopes

<!-- TODO:  Determine a better term than "editscopeless. -->

Edit scopes provide a standard way of managing edits over a collection of input fields, blades, and extensions. They provide common functions that would otherwise be difficult to orchestrate, like tracking changes in field values across a form, or simplifying the merge of form changes from the server into the current edit.  In contrast, forms without `editScopes` are compatible with new controls and consequently, EditScopes are becoming obsolete. It is recommended that extensions be developed without editScopes.

<!-- TODO: Determine whether controls like OptionsGroup, that are not located in Fx/Controls, are considered part of the EditScopeless pattern.   -->

The controls that do not use `EditScopes` are located in the `Fx/Controls` namespace. They support creating forms without initializing their `editscope`. The controls and a list of documents that discusses them in more detail are listed in  [top-extensions-controls.md](top-extensions-controls.md).  For samples and experiences that are associated with these form controls, see [top-extensions-samples.md](top-extensions-samples.md).

 Less dependence on `editScopeAccessors` makes it easier to initialize controls. The  `editScope` is no longer bound to each control, and the controls become stateless. This has two impacts.

1. There is no initial value for these controls.  The value of a control is initialized by setting it, as in the following example.

    ```ts
    textboxViewModel.value("Some Initial Value");
    ```  

1. Extensions can persist the state of the control after its data has been changed by setting the `dirty` property, as in the following code.

    ```ts
    textboxViewModel.dirty(true);
    ```  

 ### Controls Namespace

The new controls can be used in extensions by importing them, as in the following code.

```ts
import * as Section from "Fx/Controls/Section";
import * as TextBox from "Fx/Controls/TextBox";
``` 

The controls are initialized through a factory method named `create()`. This function returns an interface. The following example invokes the `create()` method to create a TextBox with a specific label, subLabel and a collection of validations.

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

<a name="forms-without-editscopes-dropdown-loading-indicator"></a>
### Dropdown loading indicator

The Azure SDK supports displaying the loading indicator when data is loaded by an asynchronous **AJAX** call that populates the dropdown, as in the following code.

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

For more information about loading indicators, see [top-blades-procedure.md#displaying-a-loading-indicator-ux](top-blades-procedure.md#displaying-a-loading-indicator-ux).

<a name="forms-without-editscopes-customizing-alerts"></a>
### Customizing Alerts

The SDK provides two ways to configure the behavior of an alert, which is the pop-up that is displayed when the user tries to close a form that contains unsaved edits. 


1. The alert can suppress the alert by setting the value to `FxViewModels.AlertLevel.None`, as in the following code.

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

<a name="forms-without-editscopes-css-classes"></a>
### CSS classes

 The `msportalfx-docking-*` classes are used when elements will be docked at the header, body or footer of the blade. They are in the following list.

* msportalfx-docking-header

* msportalfx-docking-body

* msportalfx-docking-footer

* msportalfx-padding

<!-- TODO: Determine whether 10 x 10 is px or some other unit of measurement. -->
The `msportalfx-padding` class adds 10 x 10 padding to the blade.

These blade styling css classes allow the blade to be used as a canvas.

**NOTE**: Unlike previous version of SDK, No-PDL blades do not add padding or docking content behavior by default. This  makes style management easier.

<a name="forms-without-editscopes-replacing-action-bars-with-buttons"></a>
### Replacing action bars with buttons

Out-of-the-box CSS classes can dock a button at the bottom of blade to make it look like an Action Bar.

The following sample demonstrates how to replace the action bar by docking a button and errorInfo box at the bottom of the blade by using the `msportalfx-docking-footer` css class. The `msportalfx-padding` class  adds 10 x 10 padding to the docked footer.

```html

<div class='msportalfx-docking-footer msportalfx-padding'>
    <div data-bind='pcControl: errorBox, visible: showErrorBox'></div>
    <div data-bind='pcControl: okButton' class='ext-ok-button'></div><a>Link</a>
</div>

```

<a name="forms-without-editscopes-closing-the-blade"></a>
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

For more information about opening and closing blades, see [top-blades-opening-and-closing.md](top-blades-opening-and-closing.md).




<a name="using-azure-ccontrols-in-editscope-backed-forms"></a>
## Using Azure cControls in EditScope backed forms

Several new Azure controls are compatible with EditScope-backed controls. This process specifies how to add the editscopeless **Name**  TextBox control from the `Fx/Controls/TextBox` module to an EditScope-based control. 

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. 

This procedure uses the EngineV3 sample that is located at  `<dir>\Client\V1\Create\EngineV3\ViewModels.ts`.  The  control is also included in the working sample located at  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SampleMenuBlade/createengine](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SampleMenuBlade/createengine).

For more information about the create engine, see [portalfx-create-engine-sample.md](portalfx-create-engine-sample.md).

1. Import modules

    All new controls are located in `Fx/Controls` namespace. Use the following snippet to import the `TextBox` module into your code.

    ```ts 
    import * as TextBox from "Fx/Controls/TextBox";
    import * as Validations from "Fx/Controls/Validations"
    ```

1. Modify textBox type

    Change the control type for the name of the engine so that it is using the editscopeless TextBox.

    ```ts
    /**
    * The view model for the form element for the engine name.
    **/
    public engineName: TextBox.Contract;
    ```

1. Modify Control Initialization

    The `engineName` is initialized inside the `_initializeFormFields` function. Controls inside the `Fx/Controls` namespace use the following factory pattern for initialization.

    ```ts
    this.engineName = TextBox.create(container, {
        label: ClientResources.engineNameColumn,
        subLabel: ClientResources.sampleSubLabel,
        placeHolderText: ClientResources.enterEngineName,
        validations: ko.observableArray([
            new Validations.Required(ClientResources.emptyFirstName),
            new Validations.RegExMatchValidation("^[a-zA-Z]+", ClientResources.startsWithLetterValidationMessage),
            // The 'Reserved Resource Name Validator' makes sure the engine name is not a trademark or reserved word.
            new Validations.ReservedResourceNameValidator(resourceType)
        ])
    });
    ```

1. Modify the logic to see initial data in EditScope

    After the data is received, the sample invokes  `_mapIncomingDataForEditScope` to initialize the data in the editScope.  Because the new controls are not tied to editScope, the value of the control is set explicitly.

    Initialize the `dataModel`, and then initialize the value of the TextBox with the following line of code.
    
    ```ts
    this.engineName.value(data.name || "");
    ```

1. Modify the action bar valid computation

   In order to modify the `valid` computation, the existing logic validated the state of the action bar was removed and  replaced by the following logic that computes validation using the `editScope`, along with validation for new TextBox. The new logic is in the following code.

    ```ts
    ko.computed<boolean>(container, () => {
                this.actionBar.valid(this.valid() && this.engineName.valid());
    });
    ```

1. Modify ARM provisioner to use value from new control

    The `_supplyTemplateDeploymentOptions` provides the  ARM provisioner with the template deployment options.
    Because  the form is not backed by editscope, the value of Engine name is sent to the template a little differently, as in the following example.

    ```ts
    var engineName = this.engineName.value(); 
    ```

When this procedure is complete, all the changes that are required for an EditScope-backed form to work with controls that do not use `EditScopes` have been added.