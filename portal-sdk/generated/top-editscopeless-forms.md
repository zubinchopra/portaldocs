
<a name="editscopeless-forms"></a>
## EditScopeless Forms

Edit scopes provide a standard way of managing edits over a collection of input fields, blades, and extensions. They provide common functions that would otherwise be difficult to orchestrate, like tracking changes in field values across a form, or simplifying the merge of form changes from the server into the current edit. In contrast, forms that do not use `editScopes` are compatible with new controls and consequently, EditScopes are becoming obsolete. It is recommended that extensions be developed without `editScopes`.

<!-- TODO: Determine whether controls like OptionsGroup, that are not located in Fx/Controls, are considered part of the EditScopeless pattern.   -->

Form controls are located in the `Fx/Controls` namespace. They support creating forms without initializing an  `editscope`.  The form controls are specified in [top-extensions-controls.md](top-extensions-controls.md). 

 Without an editscope, the controls become stateless. This means that there is no initial value for the control, and the developer can update the state of the control by setting the `dirty` value when the control's data changes.

 In the following example, the value of a control is initialized by setting it.

    ```ts
    textboxViewModel.value("Some Initial Value");
    ```  

1. In the following example, the state of the control is updated.

    ```ts
    textboxViewModel.dirty(true);
    ```  
 
The following controls also have their own documentation.

| Control                 | Document                                                                             | 
| ----------------------- | ------------------------------------------------------------------------------------ |  
| CustomHtml              | [portalfx-forms-designing.md](portalfx-forms-designing.md)                           | 
| DateTimePicker          | [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md)           |  
| DateTimeRangePicker     | [portalfx-controls-datetimerangepicker.md](portalfx-controls-datetimerangepicker.md) | 
| DropDown                | [portalfx-controls-dropdown.md](portalfx-controls-dropdown.md)                       | 
| Section (Form Sections) | [portalfx-forms-designing.md](portalfx-forms-designing.md)                           | 
| TextBox                 | [portalfx-controls-textbox.md](portalfx-controls-textbox.md)                         |
| TimePicker              | [portalfx-controls-datetimepicker.md](portalfx-controls-datetimepicker.md)           | 

 For samples and experiences that are associated with form controls that do not use `EditScopes`, see [top-extensions-samples.md](top-extensions-samples.md).

<a name="changing-forms-to-work-without-editscopes"></a>
## Changing forms to work without EditScopes

Several new Azure controls are compatible with EditScope-backed controls. 

This process specifies how to add the editscopeless **Name**  TextBox control from the `Fx/Controls/TextBox` module to an EditScope-based control. 

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

When this procedure is complete, all the changes that are required for an EditScope-compatible form to work with editscope-less controls have been added.

<a name="replacing-the-action-bar-with-a-button"></a>
## Replacing the action bar with a button

Out-of-the-box CSS classes can be used to dock a button at the bottom of blade and make it look like an Action Bar.

The following sample demonstrates how to replace the action bar by docking a button and errorInfo box at the bottom of the blade by using the `msportalfx-docking-footer` css class. The `msportalfx-padding` class  adds 10 x 10 padding to the docked footer.

```html

<div class='msportalfx-docking-footer msportalfx-padding'>
    <div data-bind='pcControl: errorBox, visible: showErrorBox'></div>
    <div data-bind='pcControl: okButton' class='ext-ok-button'></div><a>Link</a>
</div>

```

Other CSS classes are in the following list.

* msportalfx-docking-header
* msportalfx-docking-body
* msportalfx-docking-footer
* msportalfx-padding

 The `msportalfx-docking-*` classes are used when elements will be docked at the header, body or footer of the blade. 

<!-- TODO: Determine whether 10 x 10 is px or some other unit of measurement. -->
The `msportalfx-padding` class adds 10 x 10 padding to the blade.

These blade styling css classes allow the blade to be used as a canvas.

**NOTE**: Unlike previous version of SDK, No-PDL blades do not add padding or docking content behavior by default. This  makes style management easier.