<a name="editscopes-and-editscopeless-forms"></a>
# EditScopes and EditScopeless  Forms


<a name="editscopes-and-editscopeless-forms-editscope-less-forms"></a>
## EditScope-less Forms

Edit scopes provide a standard way of managing edits over a collection of input fields, blades, and extensions. They provide common functions that would otherwise be difficult to orchestrate, like tracking changes in field values across a form, or simplifying the merge  of form changes from the server into the current edit. In contrast, editscope-less forms are compatible with new controls and consequently, EditScopes are becoming obsolete. It is recommended that extensions be developed without editScopes.

<!-- TODO: Determine whether controls like OptionsGroup, that are not located in Fx/Controls, are considered part of the EditScopeless pattern.   -->

The EditScope-less controls are located in the `Fx/Controls` namespace. They support creating forms without initializing their `editscope`. The controls and a list of documents that discusses them in more detail are listed in  [portalfx-controls-overview.md](portalfx-controls-overview.md).  For samples and experiences that are associated with editscope-less form controls, see [portalfx-extensions-samples-overview.md](portalfx-extensions-samples-overview.md).

 Less association with `editscope` accessors  makes the initialization of the controls easier. The  `editScope` is no longer tied to each control, and the controls become stateless. This means two things.

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

<a name="editscopes-and-editscopeless-forms-editscope-less-forms-dropdown-loading-indicator"></a>
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

<a name="editscopes-and-editscopeless-forms-editscope-less-forms-customizing-alerts"></a>
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

<a name="editscopes-and-editscopeless-forms-editscope-less-forms-customizing-alerts-other-css-classes"></a>
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

<a name="editscopes-and-editscopeless-forms-editscope-less-forms-replacing-action-bar-with-button"></a>
### Replacing Action Bar with Button

Out-of-the-box CSS classes can be used to dock a button at the bottom of blade and make it look like an Action Bar.

The following sample demonstrates how to replace the action bar by docking a button and errorInfo box at the bottom of the blade by using the `msportalfx-docking-footer` css class. The `msportalfx-padding` class  adds 10 x 10 padding to the docked footer.

```html

<div class='msportalfx-docking-footer msportalfx-padding'>
    <div data-bind='pcControl: errorBox, visible: showErrorBox'></div>
    <div data-bind='pcControl: okButton' class='ext-ok-button'></div><a>Link</a>
</div>

```

<a name="editscopes-and-editscopeless-forms-editscope-less-forms-closing-the-blade"></a>
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


<a name="editscopes-and-editscopeless-forms-using-fx-controls-in-editscope-backed-forms"></a>
## Using Fx/Controls in EditScope backed forms

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

   In order to modify the `valid` computation, the existing logic that was used to validate the state of action bar is removed.  It is replaced by the following logic that computes validation using the editScope, along with validation for new TextBox.

    ```ts
    ko.computed<boolean>(container, () => {
                this.actionBar.valid(this.valid() && this.engineName.valid());
    });
    ```
1. Modify ARM provisioner to use value from new control

    The `_supplyTemplateDeploymentOptions` provides the  ARM provisioner with the template deployment options.
    Because  the form is not backed by editscope we need to change the way the value of Engine name is sent to the template, as in the following example.

    ```ts
    var engineName = this.engineName.value(); 
    ```

When this procedure is complete, all the changes that are required for an EditScope-backed form to work with editscope-less controls have been added.


<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes"></a>
## Legacy Edit Scopes

**NOTE**:  EditScopes are becoming obsolete.   It is recommended that extensions be developed without edit scopes, as specified in [portalfx-forms-editscopeless.md](portalfx-forms-editscopeless.md).

<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes-working-with-edit-scopes"></a>
### Working with Edit Scopes

Edit scopes provide a standard way of managing edits over a collection of input fields, blades, and extensions. They provide many common functions that would otherwise be difficult to orchestrate, like the following:

  * Track changes in field values across a form
  * Track validation of all fields in a form
  * Provide a way to discard all changes in a form
  * Persist unsaved changes from the form to the cloud
  * Simplify merging changes from the server into the current edit

In some instances, development approaches that do not use `editScopes` are preferred.  For more information about forms without editScopes, see  [portalfx-forms-editscopeless.md](portalfx-forms-editscopeless.md) and [portalfx-controls-dropdown.md#migration-to the-new-dropdown.md](portalfx-controls-dropdown.md#migration-to the-new-dropdown.md).

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK. 

Any edits that were made by the user and collected in an `EditScope` are saved in the storage for the browser session. This is managed by the shell. Parts or blades may request an `EditScope`, but the most common usage is in a blade. A blade defines a `BladeParameter` with a `Type` of `NewEditScope`. This informs the shell that a blade is asking for a new `editScope` object. Within the rest of the blade, that parameter can be attached to an `editScopeId` property on any part. Using this method, many parts and commands on the blade can all read from the same editScopeId. This is common when a command needs to save information about a part. After sending the `editScopeId` to the part as a property, the `viewModel`  loads the `editScope` from the cloud. 

For more information about edit scopes and  managing unsaved edits, watch the video located at 
[https://aka.ms/portalfx/editscopes](https://aka.ms/portalfx/editscopes).

<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes-request-an-editscope-from-pdl"></a>
### Request an editscope from pdl

For an example of requesting an `editScope` from PDL, view the following code.  The sample is also located at `<dir>\Client\V1\MasterDetail\MasterDetailEdit\MasterDetailEdit.pdl`.  The `valid` is using the `section` object of the form to determine if the form is currently valid.  This is not directly related to the edit scope, but will be relevant in the section named []().


```xml
<!-- Display detail blade with an edit scope. Blade consists of a form and commands.-->
<Blade Name="DetailBlade"
       ViewModel="DetailBladeViewModel">
    <Blade.Parameters>
        <Parameter Name="currentItemId" Type="Key" />
        <Parameter Type="NewEditScope" />
        <Parameter Name="formValid" Type="Output" />
    </Blade.Parameters>

    <Lens Title="SamplesExtension.Resources.Strings.masterDetailEditDetailTitle">
        <CustomPart Name="DetailPart"
                    ViewModel="DetailPartViewModel"
                    Template="{Html Source=&#039;Templates\\WebsitesDetail.html&#039;}"
                    InitialSize="HeroWideFitHeight">
        <CustomPart.Properties>
            <!-- Generated by the shell. -->
            <Property Name="editScopeId"
                      Source="{BladeParameter editScopeId}" />
            <!-- Output parameter indicating whether the form is valid. -->
            <Property Name="valid"
                      Source="{BladeParameter formValid}"
                      Direction="Output" />
            <!-- Master passes an id of object that will be used to seed the edit scope. -->
            <Property Name="currentItemId"
                      Source="{BladeParameter currentItemId}" />
        </CustomPart.Properties>
      </CustomPart>
    </Lens>
</Blade>
```

<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes-load-an-edit-scope"></a>
### Load an edit scope

The data in the `editScope` includes original values and saved edits. The method to access inputs on a part is the `onInputsSet` method. In the constructor, a new `MsPortalFx.Data.EditScopeView` object is created from the `dataContext`. The `EditScopeView` provides a stable observable reference to an `EditScope` object. The `editScopeId` will be sent in as a member of the `inputs` object when the part is bound.

For an example of loading an edit scope, view the following code.  The sample is also located at `<dir>\Client\V1\MasterDetail\MasterDetailEdit\ViewModels\DetailViewModels.ts`. 

<!-- TODO: Determine whether this inline code should be replaced when the samples code is replaced and linked in gitHub, or whether the links to the SDK samples are sufficient. -->
```ts
// create a new editScopeView
constructor(container: MsPortalFx.ViewModels.PartContainerContract,
            initialState: any,
            dataContext: DataContext) {
    super();
    ...
    this._editScopeView = dataContext.masterDetailEditSample.editScopeCache.createView(container);
    // Initialize editScope of the base class.
    this.editScope = this._editScopeView.editScope;
    ...
}
```

```ts
// update the editScopeView with a new id
public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
    // Acquires edit scope seeded with an item with id currentItemId.
    return this._editScopeView.fetchForExistingData(inputs.editScopeId, inputs.currentItemId);
}
```

<!--TODO:  Determine which piece of code is associated with this paragraph.  -->

 The code that loads the `EditScope` is largely related to data loading, so the data context is the preferred location for the code. 

<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes-load-an-edit-scope-from-a-data-context"></a>
### Load an edit scope from a data context

 <!--TODO:  The following sample code does not exist by this name.  -->
 For an example of loading an edit scope from a data context, view the sample that is located at `<dir>\Client\Data\MasterDetailEdit\MasterDetailEditData.ts`.
 <!--TODO:  The  previous sample code does not exist by this name.  -->

The following code creates a new `EditScopeCache`, which is bound to the `DataModels.WebsiteModel` object type. It uses an edit scope within a form.  The `fetchForExistingData()` method on the cache provides a promise, which informs the `ViewModel` that the `editScope` is loaded and available.

```ts
this.editScopeCache = MsPortalFx.Data.EditScopeCache.create<DataModels.WebsiteModel, number>({
    entityTypeName: DataModels.WebsiteModelType,
    supplyExistingData: (websiteId: number) => {
        var deferred = $.Deferred<JQueryDeferredV<DataModels.WebsiteModel>>();

        this.initializationPromise.then(() => {
            var website = this.getWebsite(websiteId);
            if (website) {
                deferred.resolve(website);
            } else {
                deferred.reject();
            }
        });
        return deferred;
    }
});
```

<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes-create-new-objects-and-bind-them-to-the-editscope"></a>
### Create new objects and bind them to the editScope

The following code creates a new set of form field objects and binds them to the `editScope`. The sample is also located at  `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\ViewModels\DetailViewModels.ts`.  

```ts
private _initializeForm(): void {

        // Form fields.
        var websiteNameFieldOptions = <MsPortalFx.ViewModels.Forms.TextBoxOptions>{
            label: ko.observable(ClientResources.masterDetailEditWebsiteNameLabel),
            validations: ko.observableArray([
                new MsPortalFx.ViewModels.RequiredValidation(ClientResources.masterDetailEditWebsiteNameRequired),
                new MsPortalFx.ViewModels.RegExMatchValidation("^[a-zA-Z _]+$", ClientResources.masterDetailEditWebsiteNameValidation)
            ]),
            emptyValueText: ko.observable(ClientResources.masterDetailEditWebsiteNameInitial),
            labelPosition: ko.observable(MsPortalFx.ViewModels.Forms.LabelPosition.Left)
        };

        this.websiteNameField = new MsPortalFx.ViewModels.Forms.TextBox(this._container, this, "name", websiteNameFieldOptions);

        var isRunningFieldOptions = <MsPortalFx.ViewModels.Forms.OptionsGroupOptions<boolean>>{
            label: ko.observable(ClientResources.masterDetailEditRunningLabel),
            options: ko.observableArray([
                {
                    text: ko.observable(ClientResources.masterDetailEditRunningOn),
                    value: true
                },
                {
                    text: ko.observable(ClientResources.masterDetailEditRunningOff),
                    value: false
                }
            ]),
            labelPosition: ko.observable(MsPortalFx.ViewModels.Forms.LabelPosition.Left)
        };

        this.isRunningField = new MsPortalFx.ViewModels.Forms.OptionsGroup(this._container, this, "running", isRunningFieldOptions);

        var generalSectionOptions = <MsPortalFx.ViewModels.Forms.SectionOptions>{
            children: ko.observableArray([
                this.websiteNameField,
                this.isRunningField
            ]),
            style: ko.observable(MsPortalFx.ViewModels.Forms.SectionStyle.Wrapper),
        };

        this.generalSection = new MsPortalFx.ViewModels.Forms.Section(this._container, generalSectionOptions);
    }
```

For more information about form fields, see [portalfx-controls.md#forms](portalfx-controls.md#forms).

<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes-editscopeaccessor"></a>
### EditScopeAccessor

Form fields require a binding to one or more `EditScope` observables. Consequently, they have two constructor overloads.  Extension developers can configure this binding by supplying a path from the root of the EditScope/Form model down to the observable to which the form field should bind. They can do this by selecting one of the two form field constructor variations. 

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

1. **EditScopeAccessor** This is the preferred, compile-time verified methodology. The form field ViewModel constructor accepts an EditScopeAccessor, wraps a compile-time verified lambda, and returns the EditScope observable to which the Form field should bind, as in the following code.

    `<dir>/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts`

    <!--gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts", "section": "formsEditScopeFaq#editScopeAccessor"} -->
    The EditScopeAccessor methodology is preferred for the following reasons.

    * The supplied lambda will be compile-time verified. This code is more maintainable, for example, when the property names on the Form model types are changed.
    * There are advanced variations of `EditScopeAccessor` that enable less-common scenarios like binding multiple `EditScope` observables to a single form field or translating form model data for presentation to the user, as in the following code.

      `<dir>/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts`
  
    <!-- gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts", "section": "formsEditScopeFaq#editScopeAccessorAdvanced"} -->

1. **String-typed path** This methodology is discouraged because it is not compile-time verified. The form field ViewModel constructor accepts a string-typed path that contains the location of the EditScope observable to which the Form field should bind, as in the following code.

    `<dir>/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts`

  <!--gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts", "section": "formsEditScopeFaq#editScopePath"} -->

<!-- TODO:  The following content seems to belong with editscopes instead of the form documents.  However, it is not properly formatted.  -->

<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes-editable-entity-arrays"></a>
### Editable entity arrays

***Q: The user added/removed rows from my editable grid, but I don't see the corresponding adds/removes in my EditScope array.  What gives?***

SOLUTION: EditScope 'entity' arrays were designed with a few requirements in mind:
* The user's edits need to be serialized so that Journey-switching works with unsaved Form edits. For editing large arrays, the FX should not serialize array edits by persisting two full copies of the potentially very large array.
* In the UI, the FX will want to render an indication of what array items were created/updated/deleted. In some cases, array removes need to be rendered with strike-through styling.
* Array adds/remove need to be revertable for some scenarios.

The resulting design made EditScope 'entity' arrays behave differently than regular JavaScript arrays.  Importantly:
* 'Creates' are kept out-of-band
* 'Deletes' are non-destructive

To conveniently see the *actual* state of an EditScope 'entity' array, use the '`getEntityArrayWithEdits`' EditScope method. This returns:
* An array that includes 'created' entities and doesn't include 'deleted' entities
* Discrete arrays that individually capture 'created', 'updated' and 'deleted' entities  

This '`getEntityArrayWithEdits`' is particularly useful in ParameterProvider's '`mapOutgoingDataForCollector`' callback when returning an edited array to some ParameterCollector, as in the following code.

```typescript

this.parameterProvider = new MsPortalFx.ViewModels.ParameterProvider<DataModels.ServerConfig[], KnockoutObservableArray<DataModels.ServerConfig>>(container, {
    editScopeMetadataType: DataModels.ServerConfigType,
    mapIncomingDataForEditScope: (incoming) => {
        return ko.observableArray(incoming);  // Editable grid can only bind to an observable array.
    },
    mapOutgoingDataForCollector: (outgoing) => {
        const editScope = this.parameterProvider.editScope();

        // Use EditScope's 'getEntityArrayWithEdits' to return an array with all created/updated/deleted items.
        return editScope.getEntityArrayWithEdits<DataModels.ServerConfig>(outgoing).arrayWithEdits;
    }
});

```

<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes-editable-entity-arrays-apply-array-as-edits"></a>
#### Apply array as edits

And there is a corresponding '`applyArrayAsEdits`' EditScope method that simplifies applying edits to an existing EditScope 'entity' array. This is often done in a ParameterCollector's '`receiveResult`' callback, as in the following example.

```typescript

this.itemsCollector = new MsPortalFx.ViewModels.ParameterCollector<DataModels.ServerConfig[]>(container, {
    selectable: this.itemsSelector.selectable,
    supplyInitialData: () => {
        const editScope = this._editScopeView.editScope();

        // Use EditScope's 'getEntityArrayWithEdits' to develop an array with all created/updated/deleted items
        // in this entity array.
        return editScope.getEntityArrayWithEdits<DataModels.ServerConfig>(editScope.root.serverConfigs).arrayWithEdits;
    },
    receiveResult: (result: DataModels.ServerConfig[]) => {
        const editScope = this._editScopeView.editScope();

        // Use EditScope's 'applyArrayWithEdits' to examine the array returned from the Provider Blade
        // and apply any differences to our EditScope entity array in terms of created/updated/deleted entities.
        editScope.applyArrayAsEdits(result, editScope.root.serverConfigs);
    }
});

```

This pair of EditScope methods significantly simplifies working with EditScope 'entity' arrays.  
  
* * *

<a name="editscopes-and-editscopeless-forms-legacy-edit-scopes-key-value-pairs"></a>
### Key-value pairs

<!-- TODO: Determine whether this section remains here, or should be moved to the edit grid document -->

***Q: My Form data is just key/value-pairs. How do I model a Dictionary/StringMap in EditScope? Why can't I just use a JavaScript object like a property bag?***

Like all models and view models treated by the Azure Portal FX, after the object/array is instantiated and returned to the FX in the process of rendering the UI, any subsequent mutation of that object/array should be done by changing/mutating **Knockout** observables. Portal controls and Knockout HTML template rendering both subscribe to these observables and re-render only when these observables change value.

This poses a challenge to the common JavaScript programming technique of treating a JavaScript object as a property bag of key-value-pairs. If an extension only adds or removes keys from a model or ViewModel object, the FX will not be aware of these changes. EditScope will not recognize these changes as user edits and therefore such key adds/removes will put EditScope edit-tracking in an inconsistent state.

So, how does an extension model a Dictionary/StringMap/property bag when using the Portal FX and EditScope?  

The pattern is to develop the Dictionary/StringMap/property bag as an observable array of key/value-pairs, like `KnockoutObservableArray<{ key: string; value: TValue; }>`. 

Often, additionally, it is important to let users edit the Dictionary/StringMap/property bag using *an editable grid*. In such cases, it is important to describe the array of key/value-pairs as an 'entity' array since editable grid can only be bound to an EditScope 'entity' array. For more information about how to develop type metadata to use the array with editable grid, see [#editable-grid](#editable-grid).

Here's a sample that does something similar, converting - in this case - an array of strings into an 'entity' array for consumption by editable grid.  

* * *


<a name="editscopes-and-editscopeless-forms-glossary"></a>
## Glossary

 This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                 | Meaning |
| ---                  | --- |
| compile-time verified lambda | A lambda expression that is verified at compile time.  |
| eirty | The contents of a textbox or similar object have been changed from the time that they were originally displayed or instantiated. Related to the most recent value of a variable or observable. |
| DOM              | Document Object Model   |
| journey  | A user-defined collection of Azure blades to which the user has navigated in order to accomplish a specific goal or task. A set of experiences, each of which has its own goals, that combine to result in a greater level of competency or knowledge. |
| lambda expression | An anonymous function that is used to create delegates or expression tree types. |
| observable | Special Knockout or JavaScript objects that can notify subscribers or other code about changes, and can automatically detect dependencies.  |
| observable array | An observable that allows code to to detect and respond to changes on  a collection of things.   |
| promise | An object that is returned from asynchronous processing which binds together the results of multiple asynchronous operations.  This is in accordance with a contract that async operation(s) will either complete successfully or will have been rejected. | 
| property bag | A container that contains different types of object properties. Allows the   addition of properties without modifying the server side object, and with minimal changes to the client code.|
| validation |  The process of ensuring that form or field contents are within the specified constraints for an application.  This includes items like field length or numeric checks. |

