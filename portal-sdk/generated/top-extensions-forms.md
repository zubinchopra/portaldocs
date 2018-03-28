<a name="portal-forms"></a>
# Portal Forms

<a name="developing-forms"></a>
# Developing Forms


The Portal SDK includes extensive support for displaying and managing user input through the use of Forms. Forms offer the ability to take advantage of features like consistent form layout styles, form-integrated UI widgets, user input validation, and data change tracking.

Forms are created using `HTML` templates, `ViewModels`, and `EditScopes`. Developers can use standard `HTML` and **Knockout** to build forms, in addition to the following items for which  the SDK Framework includes support.

  * Labels
  * Validation, as in the following image

    ![alt-text](../media/portalfx-forms/forms.png "Forms Example") 
  * Change tracking
  * Form reset
  * Persisting edits across journeys and browser sessions

<a name="developing-forms-form-layout"></a>
### Form Layout

Use form sections to group controls, and other sections, into structured layouts based on rows and columns. Form sections provide the following benefits.

* Predefined forms styles
* Maintains consistency with proven user usability tests
* Retains the flexibility to layout the forms in accordance with team designs.

Some form layout styles are as follows.

* Columns

![alt-text](../media/portalfx-ux-forms/columns.png "Columns")

* Create

![alt-text](../media/portalfx-ux-forms/create.png "Create")

* In-line labels

![alt-text](../media/portalfx-ux-forms/in_line.png "In-line")

* Full width

![alt-text](../media/portalfx-ux-forms/form_style_full_border.png "Full width")

<!--TODO:  Determine what is recommended instead of the custom layouts. -->

**NOTE**: Custom layouts are not recommended.
 
<a name="developing-forms-form-content"></a>
### Form Content

Form-integrated controls are the UI widgets that are compatible with forms. They can be used in a majority of forms scenarios. They automatically enable good form patterns, built-in validation, and auto-tracking of changes.

Some form-integrated controls are as follows.

<!--TODO:  Determine whether this table should still exist. -->

| Button       | Content Cell |
| ------------ | ------------ |
| Content Cell | Content Cell |

* Button

![alt-text](../media/portalfx-ux-forms/Button.png "Button" )

* Checkboxes

![alt-text](../media/portalfx-ux-forms/checkbox.png "Checkbox")

* Copy label

![alt-text](../media/portalfx-ux-forms/copy_label.png "Copy label")

* Date picker

![alt-text](../media/portalfx-ux-forms/dropdown.png "Dropdowns")

* Date - time picker

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

* Date - time range picker

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

* Day picker

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

* Dropdowns (Single-select, Multi-select, Filterable, Groupable, Tokenized)

![alt-text](../media/portalfx-ux-forms/dropdown.png "Dropdowns")

* File download

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

* File upload

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

<a name="developing-forms-form-topics"></a>
### Form Topics

There are a number of subtopics in the forms topic.  Sample source code is included in subtopics that discuss the various Azure SDK API items.

| API Topic             | Document              | 
| --------------------- | --------------------- | 
| Designing and Arranging the Form | [portalfx-forms-designing.md](portalfx-forms-designing.md)                 |  
| Forms Construction        | [portalfx-forms-construction.md](portalfx-forms-construction.md)      |  
| Integrating Forms with Commands          | [portalfx-forms-integrating-with-commands.md](portalfx-forms-integrating-with-commands.md)        | 
| Form Field Validation       | [portalfx-forms-field-validation.md](portalfx-forms-field-validation.md)      |  

For more information about how forms and parameters interact with an extension, see [portalfx-parameter-collection-overview.md](portalfx-parameter-collection-overview.md).

For more information about forms with editScopes, see  [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md).

For more information about forms without editScopes, see  [portalfx-editscopeless-overview.md](portalfx-editscopeless-overview.md).


<a name="developing-forms-designing-and-arranging-the-form"></a>
## Designing and Arranging the Form

<a name="developing-forms-designing-and-arranging-the-form-the-section-viewmodel"></a>
### The section ViewModel

While blade templates allow manual layout of controls as specific **DOM** elements, the generally recommended approach is to bind a section `viewModel` into the **DOM** and then add control `viewModels` to the `children` observable array of the section. For example, the following image contains two sections with varying numbers of child objects in their respective arrays.

![alt-text](../media/portalfx-forms-designing/forms-sections.png "Form Section")

The section `viewModel` provides default styling for spacing and margins and is an easy way to dynamically add and remove controls.

<a name="developing-forms-designing-and-arranging-the-form-the-customhtml-control"></a>
### The CustomHtml control

The `CustomHtml` control can be used to author `HTML` in an autogenerated layout. Many extensions use these two controls to avoid large amounts of `HTML` in the blade template. However, placing the controls in the DOM manually is always an option if needed.

<!-- TODO:  Determine whether "two controls" means the section viewModel and the customHtml control.
-->

A working copy of a basic Portal form is located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup). Click on 'Basic Create Form'.

<a name="developing-forms-designing-and-arranging-the-form-the-customhtml-control-procedure"></a>
#### Procedure

To add a section to an extension, use the following five steps.

1. Import the module to make the section available to the extension.
	
2. Change the link element in the HTML template to a control container.

    Use a `pcControl` binding handler to link the ViewModel to the HTML.

3. Then, create the section `ViewModel` in the code.

    Bind the section `ViewModel` into the **DOM** in the blade template. Then add all the controls that should be displayed into the `children` observable array of the section. This positions the controls sequentially on a blade, by default. 

    The section's `style` property can be used to achieve other layouts. This includes table layouts that display controls in multiple rows and columns, as a list of tabs, or as a combination of layouts.

    **NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK. 

4. The code to create the section is located at  `<dir>\Client\V1\Forms\Samples\BasicCreate\ViewModels\Parts\FormsSampleBasicCreatePart.ts`. It is also in the following code.

    ```typescript

const mySectionOptions: Section.Options = {
    children: ko.observableArray<any>([
        this.myTextBox,
        this.myChecklessTextBox,
        this.myPasswordBox,
        this.myGroupDropDown,
        myDependentSection,
        this.myCheckBox,
        this.mySelector,
        this.myDropDown,
    ])
};
this.mySection = new Section.ViewModel(this._container, mySectionOptions);

```

5. The HTML template located at `<dir>\Client\V1\Forms\Samples\BasicCreate\Templates\FormSampleBasicCreate.html` binds the section into the DOM, and will autogenerate the layout for all of the child objects.  It is included in the following example.

    ﻿<div class="msportalfx-form" data-bind="pcControl: mySection"></div>



## Forms Construction

### Loading, editing and saving data

This sample reads and writes data to the server directly via `ajax()` calls. It loads and saves data by creating an `EditScopeCache` object and defining two functions. The `supplyExistingData` function reads the data from the server, and the `saveEditScopeChanges` function writes it back.

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory. Links to the Dogfood environment will display working copies of the samples that were made available with the SDK.

The code for this example is associated with the basic form sample. It is located at 
* `<dir>\Client\V1\Forms\Samples\Basic\FormsSampleBasic.pdl`
* `<dir>\Client\V1\Forms\Samples\Basic\Templates\FormSampleBasic.html`
* `<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`

The code instantiates an `EditScope` via a `MsPortalFx.Data.EditScopeView` object. When the data to manipulate is already located on the client, an edit scope view can also be obtained from other data cache objects, as in the following example.

```typescript

let editScopeCache = EditScopeCache.createNew<WebsiteModel, number>({
    supplyExistingData: (websiteId, lifetime) => {
        return FxBaseNet.ajax({
            uri: Util.appendSessionId(MsPortalFx.Base.Resources.getAppRelativeUri("/api/Websites/" + websiteId)), // this particular endpoint requires sessionId to be in query string
            type: "GET",
            dataType: "json",
            cache: false,
            contentType: "application/json"
        }).then((data: any) => {
            // after you get the data from the ajax query you can do whatever transforms
            // you want in it to turn it into the model type you've defined
            return {
                id: ko.observable(data.id),
                name: ko.observable(data.name),
                running: ko.observable(data.running)
            };
        });
    },
    saveEditScopeChanges: (websiteId, editScope, edits, lifetime, dataToUpdate) => {
        // get the website from the edit scope
        let website = editScope.root;

        // if you need to do conversion on the data before posting to server you can do that
        // all we need to do here is turn the knockout object into json
        let serializableWebsite = ko.toJSON(website);

        this._saving(true);
        return FxBaseNet.ajax({
            uri: Util.appendSessionId(MsPortalFx.Base.Resources.getAppRelativeUri("/api/Websites/" + websiteId)),
            type: "POST",
            dataType: "json",
            cache: false,
            contentType: "application/json",
            data: serializableWebsite
        }).then(() => {
            // Instruct the EditScope to accept the user-authored, client-side changes as the new state of the
            // EditScope after the 'saveChanges' has completed successfully.
            // ('AcceptClientChanges' is the default behavior.  This promise could also be resolved with 'null' or 'undefined'.)
            return {
                action: Data.AcceptEditScopeChangesAction.AcceptClientChanges
            }
        }).finally(() => {
            this._saving(false);
        });
    }
});

```

Then, the code transforms the data to make it match the model type. The server returns strings, but the `WebsiteModel` type that is used is defined in the following code.

  ```ts
   interface WebsiteModel {
      id: KnockoutObservable<number>;
      name: KnockoutObservable<string>;
      running: KnockoutObservable<boolean>;
  }
  ```

Therefore, the save and load functions have to transform the data to make it match the `WebsiteModel` model type. The control `viewModels` require a reference to a `Form.ViewModel`, so the code creates a form and sends the reference to the `editScope` to it, as in the following example.

```typescript

this._form = new Form.ViewModel<WebsiteModel>(this._lifetime);
this._form.editScope = this._editScopeView.editScope;

```

This form displays one textbox that allows the user to edit the name of the website, as specified in the following code.

```typescript

let websiteName = new TextBox.ViewModel(
    this._lifetime,
    this._form,
    this._form.createEditScopeAccessor(data => data.name),
    {
        label: ko.observable(ClientResources.masterDetailEditWebsiteNameLabel),
        validations: ko.observableArray([
            new FxViewModels.RequiredValidation(ClientResources.masterDetailEditWebsiteNameRequired)
        ]),
        valueUpdateTrigger: ValueUpdateTrigger.Input // by default textboxes only update the value when the user moves focus. Since we don't do any expensive validation we can get updates on keypress
    });

// Section
this.section = new Section.ViewModel(this._lifetime, {
    children: ko.observableArray<any>([
        websiteName
    ])
});

```

The form is rendered using a section. The code loads all the controls that should be displayed into the `children` observable array of the section. This positions the controls sequentially on a blade, by default, so it is an easy way to standardize the look of forms in the Portal. An alternative to the default positioning is to manually author the HTML for the form by binding each control into an HTML template for the blade.

This sample includes two commands at the top of the blade that will save or discard data. Commands are used because this blade stays open after a save/discard operation. If the blade were to close after the operation, then there would be an action bar at the bottom of the blade to use instead. 

The commands check to make sure that the `EditScope` has been populated previous to enabling themselves via the `canExecute` portion of the `ko.pureComputed` code.

The commands also keep themselves disabled during save operations via a `_saving` observable that the blade maintains, as in the following code.

`<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`

<!--
```typescript

// set up save command
let saveCommand = new Toolbars.CommandButton();
saveCommand.label(ClientResources.saveText);
saveCommand.icon(FxBase.Images.Save());
saveCommand.command = {
    canExecute: ko.pureComputed(() => {
        // user can save when edit scope is dirty and we're not in the middle of a save operation
        let editScope = this._editScopeView.editScope();
        let editScopeDirty = !!editScope ? editScope.dirty() : false;
        return !this._saving() && editScopeDirty;
    }),
    execute: (context: any): FxBase.Promise => {
        return this._editScopeView.editScope().saveChanges();
    }
}

// set up discard command
let discardCommand = new Toolbars.CommandButton();
discardCommand.label(ClientResources.discardText);
discardCommand.icon(MsPortalFx.Base.Images.Delete());
discardCommand.command = {
    canExecute: ko.pureComputed(() => {
        // user can save when edit scope is dirty and we're not in the middle of a save operation
        let editScope = this._editScopeView.editScope();
        let editScopeDirty = !!editScope ? editScope.dirty() : false;
        return !this._saving() && editScopeDirty;
    }),
    execute: (context: any): FxBase.Promise => {
        this._editScopeView.editScope().revertAll();
        return null;
    }
}

this.commandBar = new Toolbars.Toolbar(this._lifetime);
this.commandBar.setItems([saveCommand, discardCommand]);

```
-->

Because the `EditScope` is being used, the save/discard commands can just call the `saveChanges()` or `revertAll()` methods on the edit scope to trigger the right action.

For more information, see [http://knockoutjs.com/documentation/computed-writable.html](http://knockoutjs.com/documentation/computed-writable.html).


## Integrating Forms with Commands

In most cases, editable forms are accompanied by commands which act upon those forms. There are two ways that form data can be made available to the command:

  * **Part property bindings**: a value from a part ViewModel on a blade may be bound into the command ViewModel
  * **Edit scope loading**: the editScopeId requested by the blade can be bound to a part and a command. By sharing an Id, they can act on the same object.

The most common use of part-to-command binding is sharing the `dirty` or `valid` properties of a form with a command ViewModel. The command ViewModel can enable or disable a save button based on validity, or enable or disable a discard button when edits are made. For example, when `EditScopeId` and `currentItemId` are acquired, the command can be enabled if the editscope is dirty and the form is valid, which implies that the form contains valid data.

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory. Links to the Dogfood environment will display working copies of the samples that were made available with the SDK.

The sample  located at  `<dir>\Client\V1\MasterDetail\MasterDetailEdit\ViewModels\DetailViewModels.ts` demonstrates a `SaveItemCommand` class that uses the binding between a part and a command. This code is also included in the following example.

<!--TODO:  Determine whether the code matches the sample that ships. This task should be performed for all code samples. --> 

```ts
this._editScopeView = dataContext.masterDetailEditSample.editScopeCache.createView(container);
this.enabled = ko.computed((): boolean => {
    // EditScopeId and currentItemId have to be already acquired, editscope dirty and the form valid to
    // command be enabled.
    return !this._editScopeView.loading() &&
        this._editScopeView.editScope() &&
        this._editScopeView.editScope().dirty() &&
        !this._editScopeView.editScope().saving() &&
        this._formValid();
});
```

In the previous snippet, the `enabled` property of the command is toggled based on the validity of the form. Inputs to this command include:

  * **editScopeId**: loaded by using a `NewEditScope` blade parameter
  * **currentItemId**: loaded by using a `Key` blade parameter
  * **formValid**: loaded by using the part that contains a form on the blade



## Form Field Validation

Validating input is one of the primary benefits of the **Forms** API. Many simple and complex validators are available out of the box:

  * Required
  * Contains
  * Not Contains
  * Contains Characters
  * Not Contains Characters
  * Has Digit
  * Has Letter
  * Has Upper Case Letter
  * Has Lower Case Letter
  * Has Punctuation
  * Equals
  * Length Range
  * Min Length
  * Max Length
  * Numeric
  * Range
  * Min Value
  * Max Value
  * RegEx
  * Custom
  * Continuous Update

Validators also provide automatic error messages inside of a balloon control, as in the following image.

![alt-text](../media/portalfx-forms-field-validation/formValidation.png "Form Validation")

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory. Links to the Dogfood environment will display working copies of the samples that were made available with the SDK.

For an example of each of these validators in action, view the sample file that is located at `<dir>\Client\V1\Forms\Samples\Validations\ViewModels\FormValidationsViewModels.ts`.

Validators are added to the form objects that are on the ViewModel, as in the following code.

```ts
var nameTextboxOptions  = <MsPortalFx.ViewModels.Forms.TextBox.Options>{
      label: ko.observable(ClientResources.required),
      validations: ko.observableArray([
          new MsPortalFx.ViewModels.RequiredValidation(ClientResources.pleaseEnterSomeText)
      ])
  };
  this.nameTextbox  = new MsPortalFx.ViewModels.Forms.TextBox.ViewModel(
      this._container, this, "requiredFieldValue", nameTextboxOptions );
```

<a name="developing-forms-designing-and-arranging-the-form-samples-forms"></a>
### Samples Forms

  | API Topic                             | Document                                                                 | Sample                                                           | Experience |
  | ----------------------------------------------  | ------------------------------------------------------------------------ | ---------------------------------------------------------------- | ---------- |
  | Basic Forms, Form Sections, CustomHtml   | [portalfx-forms-designing.md](portalfx-forms-designing.md) | `<dir>\Client\V1\Forms\Samples\Basic\ ViewModels\Parts\FormsSampleBasicBlades.ts` <br> `<dir>\Client\V1\Forms\Samples\BasicCreate\ ViewModels\Parts\FormsSampleBasicCreatePart.ts` <br> `<dir>\Client\V1\Forms\Samples\Validations\ ViewModels\FormValidationsViewModels.ts` | [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/formsallup) http://aka.ms/portalfx/samples#blade/SamplesExtension/CustomFormFieldsBlade  <br>  [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/formsallup](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/SDKMenuBlade/formsallup) |
  | Create Form                | [portalfx-create.md](portalfx-create.md)                                             | `<dir>\Client\V1\Create\EngineV3\ ViewModels\CreateEngineBladeViewModel.ts`      | |
  | Form Construction          | [portalfx-forms-construction.md](portalfx-forms-construction.md)                     | `<dir>\Client\V1\Forms\Samples\Basic\ ViewModels\FormsSampleBasicBlade.ts` | |
  | Form Field Validation      | [portalfx-forms-field-validation.md](portalfx-forms-field-validation.md)             | `<dir>\Client\V1\Forms\Samples\Validations\ ViewModels\FormValidationsViewModels.ts` | |
  | Testing Forms               | [portalfx-testing-filling-forms.md](portalfx-testing-filling-forms.md)                                       | `<dir>`              | 

  

<a name="developing-forms-frequently-asked-questions"></a>
## Frequently asked questions

<a name="developing-forms-frequently-asked-questions-should-i-use-an-action-bar-or-a-commands-toolbar-on-my-form"></a>
### Should I use an action bar or a commands toolbar on my form?

It depends on the scenario that drives the UX. If the form will capture some data from the user and expect the blade to be closed after submitting the changes, then use an action bar, as specified in [portalfx-ux-create-forms.md#action-bar-+-blue-buttons](portalfx-ux-create-forms.md#action-bar-+-blue-buttons).  However, if the form will edit or update some data, and expect the user to make multiple changes before the blade is closed, then use commands, as specified in [portalfx-commands.md](portalfx-commands.md). 

* Action Bar

  The action bar will have one button whose label is something like "OK", "Create", or "Submit". The blade should automatically close immediately after the action bar button is clicked. Users can abandon the form by clicking the Close button that is located at the top right of the application bar. Developers can use a `ParameterProvider` to simplify the code, because it provisions the `editScope` and implicitly closes the blade based on clicking on the action bar. 

  Alternatively, the action bar can contain two buttons, like "OK" and "Cancel", but that requires further configuration. The two-button method is not recommended because the "Cancel" button is made redundant by the Close button.

* Commands
  
  Typically, the two commands at the top of the blade are the "Save" command and the "Discard" command. The user can make edits and click "Save" to commit the changes. The blade should show the appropriate UX for saving the data, and will stay on the screen after the data has been saved. The user can make further changes and click "Save" again. The user can also discard their changes by clicking "Discard". Once the user is satisfied with the changes, they can close the blade manually.
  
* * * 

<a name="developing-forms-glossary"></a>
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
