
<a name="editscopes-and-editscopeless-forms"></a>
# EditScopes and EditScopeless  Forms


<a name="editscopes-and-editscopeless-forms-legacy-editscopes"></a>
## Legacy EditScopes

**NOTE**:  EditScopes are becoming obsolete.  It is recommended that extensions be developed without edit scopes, as specified in [portalfx-editscopeless-procedure.md](portalfx-editscopeless-procedure.md). For more information about forms without editScopes, see  [portalfx-editscopeless-overview.md](portalfx-editscopeless-overview.md) and [portalfx-controls-dropdown.md#migration-to-the-new-dropdown](portalfx-controls-dropdown.md#migration-to-the-new-dropdown).

<!-- TODO: Compare document with the pieces of the portalfx-editscopes*.md document -->

Edit scopes provide a standard way of managing edits over a collection of input fields, blades, and extensions. They provide many common functions that would otherwise be difficult to orchestrate, like the following:

  * Track changes in field values across a form
  * Track validation of all fields in a form
  * Provide a way to discard all changes in a form
  * Persist unsaved changes from the form to the cloud
  * Simplify merging changes from the server into the current edit
 
This document is organized into the following sections.

* [The EditScope Data Model](#the-editscope-data-model)

* [The EditScopeCache](#the-editscopecache)

* [EditScope View Models](#editScope-view-models)

* [Loading the EditScope](#loading-the-editscope)

For more information about edit scopes and managing unsaved edits, watch the video located at 
[https://aka.ms/portalfx/editscopes](https://aka.ms/portalfx/editscopes).

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK.

* * *

<a name="editscopes-and-editscopeless-forms-legacy-editscopes-the-editscope-data-model"></a>
### The EditScope Data Model

<a name="editscopes-and-editscopeless-forms-legacy-editscopes-editscope-entity-arrays"></a>
### EditScope entity arrays

An EditScope is a hierarchy of 'entity' objects.  EditScope 'entity' arrays were designed with a few requirements in mind.

* User edits are serialized so that journey-switching works with unsaved Form edits. For editing large arrays, the FX should not serialize array edits by persisting two full copies of the array.

* In the UI, the FX will indicate which array items were created/updated/deleted by the user. In some cases, array removes are rendered with strike-through styling.

* Array adds/removes need to be revertable for some scenarios.

Consequently, EditScope 'entity' arrays behave differently than regular JavaScript arrays. Importantly:

* 'Creates' are kept out-of-band
* 'Deletes' are non-destructive

By default, when the EditScope's `root` is an object, this object is considered an 'entity'. The EditScope becomes a hierarchy of 'entities' when the EditScope includes an array of 'entity' objects, or when some EditScope object includes a property that is 'entity'-typed. An object is treated by EditScope as an 'entity' when type metadata associated with the object is marked as an 'entity' type.

Every 'entity' object is tracked by the EditScope as being created/updated/deleted. Extension developers define 'entities' at a granularity that suit the scenario, making it easy to determine what data in the  EditScope/Form data model was edited by the user.

After the `EditScope` is initialized and loaded, entities can be introduced and removed from the EditScope only by using EditScope APIs. Unfortunately, extensions cannot simply make an observable change to add a new 'entity' object or remove an existing 'entity' from the EditScope. If an extension tries to make an observable change that introduces an 'entity' object into the EditScope, it will  encounter the error message discussed in [portalfx-extensions-status-codes.md#unknown-entity-typed-object-array](portalfx-extensions-status-codes.md#unknown-entity-typed-object-array).

An `editScope` entity array is an array where created/updated/deleted items are tracked individually by `EditScope`. Array adds/removes are revertable for some scenarios. Rows can be added or removed from an editable grid, but the corresponding adds/removes may not be immediately viewable from the `EditScope` array. To grant this treatment to an array in the `EditScope`/`Form` model, the extension supplies type metadata for the type of the array items. For example, the  `T` in `KnockoutObservableArray<T>` contains the type. 

Any edits that were made by the user and collected in an `EditScope` are saved in the storage for the browser session. This is managed by the shell. 

`EditScope` integration can manage changes and warn customers that they might lose data if they leave the form without saving their changes.  The `parameterProvider` instantiates and initializes an `EditScope`, so all that needs to be done is to connect the form's `EditScope` to the `parameterProvider's` `EditScope`.

Parts or blades may request an `EditScope`, but the most common usage is in a blade. A blade defines a `BladeParameter` with a `Type` of `NewEditScope`. This informs the shell that a blade is asking for a new `editScope` object. Within the rest of the blade, that parameter can be attached to an `editScopeId` property on any part. Using this method, many parts and commands on the blade can all read from the same editScopeId. This is common when a command needs to save information about a part. After sending the `editScopeId` to the part as a property, the `viewModel`  loads the `editScope` from the cloud. 

The properties that are associated with the entity's 'id' are specified in the following examples. 
 
The TypeScript sample is located at     `<dir>\Client\V1\Forms\Scenarios\ChangeTracking\Models\EditableFormData.ts`. This code is also included in the following working copy.

 ```typescript

MsPortalFx.Data.Metadata.setTypeMetadata("GridItem", {
properties: {
    key: null,
    option: null,
    value: null
},
entityType: true,
idProperties: [ "key" ]
});

```

The C# sample is located at `<dirParent>\SamplesExtension.DataModels/Person.cs`. This code is also included in the following working copy.

 ```csharp

[TypeMetadataModel(typeof(Person), "SamplesExtension.DataModels")]
[EntityType]
public class Person
{
    /// <summary>
    /// Gets or sets the SSN of the person.
    /// The "Id" attribute will be serialized to TypeScript/JavaScript as part of type metadata, and will be used
    /// by MsPortalFx.Data.DataSet in its "merge" method to merge data by identity.
    /// </summary>
    [Id]
    public int SsnId { get; set; }
    
```

The following enumerations simplify the conversation between the `EditScope` and the `EditScopeCache`. 

* [The AcceptEditScopeChangesAction enum](#the-accepteditscopechangesaction-enum)

The following properties simplify working with `EditScope` entity arrays.

* [The trackEdits property](#the-trackedits-property)

The following methods are used with `EditScope` entity arrays.

* [The getCreated and addCreated methods](#the-getcreated-and-addcreated-methods)

* [The markForDelete method](#the-markfordelete-method)

* [The getEntityArrayWithEdits method](#the-getentityarraywithedits-method)

* [The applyArrayAsEdits method](#the-applyarrayasedits-method)

* * *

<a name="editscopes-and-editscopeless-forms-legacy-editscopes-editscope-entity-arrays-the-accepteditscopechangesaction-enum"></a>
#### The AcceptEditScopeChangesAction enum

These enumerated values allow the extension to specify conditions like the following.

* The EditScopeCache is to implicitly reload the EditScope data as part of completing the 'save' operation.

* The EditScope's data is to be reverted/cleared as part of completing the 'save' operation (the "create new record" UX scenario).

For more information about each enum value, see the jsdoc comments around `MsPortalFx.Data.AcceptEditScopeChangesAction` or in `MsPortalFxDocs.js` in Visual Studio or any code editor.

<a name="editscopes-and-editscopeless-forms-legacy-editscopes-editscope-entity-arrays-the-trackedits-property"></a>
#### The trackEdits property

 Some properties on the EditScope/Form model are only for presentation instead of for editing. In these instances, the extension can instruct `EditScope` to opt out of tracking user edits for the specified properties.

In TypeScript:  

    MsPortalFx.Data.Metadata.setTypeMetadata("Employee", {
        properties: {
            accruedVacationDays: { trackEdits: false },
            ...
        },
        ...
    });  

In C#:  

    [TypeMetadataModel(typeof(Employee))]
    public class Employee
    {
        [TrackEdits(false)]
        public int AccruedVacationDays { get; set; }

        ...
    }  

Extensions can supply type metadata to configure an `EditScope` as follows.

* When using `ParameterProvider`, supply the `editScopeMetadataType` option to the `ParameterProvider` constructor. 

* When using `EditScopeCache`, supply the `entityTypeName` option to `MsPortalFx.Data.EditScopeCache.createNew`.

Extensions can pass the type name used to register type metadata to either of these options by using `MsPortalFx.Data.Metadata.setTypeMetadata`.

<a name="editscopes-and-editscopeless-forms-legacy-editscopes-editscope-entity-arrays-the-getcreated-and-addcreated-methods"></a>
#### The getCreated and addCreated methods

These methods APIs allow for the addition of new, 'created' entity objects. The `getCreated` method returns a distinct, out-of-band array that collects all 'created' entities corresponding to a given 'entity' array. The `addCreated` method is a helper method that places a new 'entity' object in this getCreated array.

<a name="editscopes-and-editscopeless-forms-legacy-editscopes-editscope-entity-arrays-the-markfordelete-method"></a>
#### The markForDelete method

The `markForDelete` APIs allows an extension to delete an 'entity' from the EditScope as a non-destructive operation. This allows the extension to render 'deleted' edits with strike-through or similar styling. Calling this method puts the associated 'entity' in a deleted state, although the deletion is not yet saved.

<a name="editscopes-and-editscopeless-forms-legacy-editscopes-editscope-entity-arrays-the-getentityarraywithedits-method"></a>
#### The getEntityArrayWithEdits method

To see the actual state of an EditScope `EntityArray`, use the `getEntityArrayWithEdits` EditScope method. The `getEntityArrayWithEdits` EditScope method returns the following types of arrays.

* An array that includes 'created' entities and does not include 'deleted' entities

* Discrete arrays that individually capture 'created', 'updated' and 'deleted' entities

This method is particularly useful in the `mapOutgoingDataForCollector` callback of the `ParameterProvider` when returning an edited array to some ParameterCollector, as in the following code.

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

In the UI, the FX renders an indication of what array items were created/updated/deleted. 

The following example converts an array of strings into an 'entity' array for consumption by an editable grid.  When modeling your data as an 'entity' array, the editable grid can only be bound to an `EditScope` 'entity' array.

 ```typescript

const wrapperTypeMetadataName = "ParameterProviderWithEditableStringsBladeViewModel_StringWrapperType";
MsPortalFx.Data.Metadata.setTypeMetadata(wrapperTypeMetadataName, {
name: wrapperTypeMetadataName,
properties: {
    value: null
},
entityType: true
});

export interface StringWrapperType {
value: KnockoutObservable<string>;
}

```

The following example demonstrates converting data to an 'entity' array for consumption by an editable grid.

 ```typescript

this.parameterProvider = new MsPortalFx.ViewModels.ParameterProvider<string[], KnockoutObservableArray<StringWrapperType>>(container, {
    editScopeMetadataType: wrapperTypeMetadataName,
    mapIncomingDataForEditScope: (incoming) => {
        // Editable grid only accepts an array of editable entities (that is, objects and not strings).
        const wrappedStrings = incoming.map((str) => {
            return {
                value: ko.observable(str)
            };
        });
        return ko.observableArray(wrappedStrings);  // Editable grid can only bind to an observable array.
    },
    mapOutgoingDataForCollector: (outgoing) => {
        const editScope = this.parameterProvider.editScope();

        // Use EditScope's 'getEntityArrayWithEdits' to return an array with all created/updated/deleted items.
        const entityArrayWithEdits = editScope.getEntityArrayWithEdits<StringWrapperType>(outgoing);

        // Unwrap each string to produce the expected string array.
        return entityArrayWithEdits.arrayWithEdits.map((wrapper) => {
            return wrapper.value();
        });
    }
});

```

#### The applyArrayAsEdits method

The `applyArrayAsEdits` method simplifies applying edits to an existing `EditScope` entity array. This API accepts a new array of 'entity' objects. The `EditScope` will compare  this new array to  the existing `EditScope` array items, determine which 'entity' objects are created/updated/deleted, and then records the corresponding user edits.

This is often performed in a ParameterCollector's `receiveResult` callback, as in the following example.

```ts
// The parameter provider takes care of instantiating and initializing an edit scope for you,
// so all we need to do is point our form's edit scope to the parameter provider's edit scope.
this.editScope = this.parameterProvider.editScope;
```

 The  following example uses a discrete array that individually capture 'created', 'updated' and 'deleted' entities.

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

The  following example uses an array that includes 'created' entities and does not include 'deleted' entities.

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

### The EditScopeCache

The `EditScopeCache` class is less commonly used. It loads and manages instances of `EditScope`, which is a change-tracked, editable model.  Typically, the blade uses an `EditScopeView`, as specified in  `editScopeCache.createView(...)`, to load/acquire the EditScope.  If the extension uses an `EditScopeCache` component to manage its `EditScope`, the extension should initialize the `EditScope` data in the `supplyNewData` and `supplyExistingData` callbacks that are sent to EditScopeCache. 

 The `EditScopeCache` is  used for the following scenarios.

 * **Save/Revert blade**: There are 'Save' and 'Revert changes' commands in the CommandBar of the blade. Typically, these commands keep the blade open so the user can perform successive edit and save cycles without closing and reopening the form.

 * **Document editing**: In the document-editing scenario, the user can make edits to a single EditScope/Form model across multiple parent-child blades.  The parent blade sends its `inputs.editScopeId` input to any child blade that edits the same model as the parent Blade. The child blade uses this `inputs.editScopeId` in its call to `editScopeView.fetchForExistingData(editScopeId)` to fetch the EditScope of the parent Blade.
 
#### The saveEditScopeChanges method

When creating an EditScopeCache, the `saveEditScopeChanges` callback supplied by the extension is called to push `EditScope` edits to a server. This callback returns a `Promise` that should be resolved when the 'save' AJAX call completes, which occurs after the server accepts the user's edits. 

When the extension resolves this `Promise`, it can supply a value that instructs the EditScope to reset itself to a clean/unedited state. If no such value is returned during `promise` resolution, then the `EditScope` is reset by default.  This means using the user's client-side edits as the new, clean/unedited EditScope state. This works for many scenarios.  

There are other scenarios where the default `saveEditScopeChanges` behavior does not work, like the following. 

* During 'save', the server produces new data values that need to be merged into the EditScope.

* For "create new record" scenarios, after 'save', the extension should clear the form, so that the user can enter a new record.

For these cases, the extension will resolve the `saveEditScopeChanges` promise with a value from the `AcceptEditScopeChangesAction` enum. 

#### Sample EditScopeCache

 <!--TODO:  The following sample code does not exist by this name.  -->
 For an example of loading an edit scope from a data context, view the sample that is located at `<dir>\Client\Data\MasterDetailEdit\MasterDetailEditData.ts`.
 <!--TODO:  The previous sample code does not exist by this name.  -->

The following code creates a new `EditScopeCache`, which is bound to the `DataModels.WebsiteModel` object type. It uses an `editScope` within a form.  The `fetchForExistingData()` method on the cache provides a `promise`, which informs the `ViewModel` that the `EditScope` is loaded and available.

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
 
### View Model

### The editScopeView 

In most cases, editable forms are accompanied by commands which act upon those forms. Form data can be made available to the command by binding a value from a part `ViewModel` to a command `ViewModel`, or the `editScopeId` requested by the blade can be bound to the part and the command. The extension can instantiate an `EditScope` by using a `MsPortalFx.Data.EditScopeView` object. The `EditScopeView` object makes edited data available at `editScopeView.editScope().root` after the `editScope()` observable is populated. When the data to view and edit is already located on the client, an `EditScopeView` can also be obtained from other data cache objects. 

The data in the `editScope` includes original values and saved edits. The method to access inputs on a part is the `onInputsSet` method. In the constructor, a new `MsPortalFx.Data.EditScopeView` object is created from the `dataContext`. The `EditScopeView` provides a stable observable reference to an `EditScope` object. The `editScopeId` will be sent in as a member of the `inputs` object when the part is bound.

An example of loading an edit scope is in the following code.  The sample is also located at `<dir>\Client\V1\MasterDetail\MasterDetailEdit\ViewModels\DetailViewModels.ts`. 

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

In the following example, the `editScopeView` is refreshed with new data from the data context.

```ts
// update the editScopeView with a new id
public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
    // Acquires edit scope seeded with an item with id currentItemId.
    return this._editScopeView.fetchForExistingData(inputs.editScopeId, inputs.currentItemId);
}
```

### Loading the EditScope

The code that loads the `EditScope` is largely related to data loading, so the data context is the preferred location for the code. 

#### Binding Observables

Form fields require a binding to one or more `EditScope` observables. Consequently, they have two constructor overloads. Extension developers can configure this binding by supplying a path from the root of the EditScope/Form model down to the observable to which the form field should bind. They can do this by selecting one of the two form field constructor variations.

The `EditScopeAccessor` is the preferred, compile-time verified methodology. The form field `ViewModel` constructor accepts an EditScopeAccessor, wraps a compile-time verified lambda, and returns the `EditScope` observable to which the Form field should bind, as in the following code located at     `<dir>/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts`.  It is also in the following code.

 ```typescript

this.textBoxSimpleAccessor = new MsPortalFx.ViewModels.Forms.TextBox.ViewModel(
    container,
    this,
    this.createEditScopeAccessor<string>((data) => { return data.state; }),
    textBoxSimpleAccessorOptions);

``` 

The EditScopeAccessor methodology is preferred for the following reasons.

* The supplied lambda will be compile-time verified. This code is more maintainable, for example, when the property names on the Form model types are changed.

* There are advanced variations of `EditScopeAccessor` that enable less-common scenarios like binding multiple `EditScope` observables to a single form field.  There are others that demonstrate translating form model data for presentation to the user, as in the code located at       `<dir>/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts`. It is also in the following code.
  
 ```typescript

this.textBoxReadWriteAccessor = new MsPortalFx.ViewModels.Forms.TextBox.ViewModel(
    container,
    this,
    this.createEditScopeAccessor<string>(<MsPortalFx.ViewModels.Forms.EditScopeAccessors.Options<FormIntegratedFormData.FormIntegratedFormData, string>>{
        readFromEditScope: (data: FormIntegratedFormData.FormIntegratedFormData): string => {
            return data.state2().toUpperCase();
        },
        writeToEditScope: (data: FormIntegratedFormData.FormIntegratedFormData, newValue: string): void => {
            data.state2(newValue);
        }
    }),
    textBoxReadWriteAccessorOptions);

```

The string-typed path  methodology can be used instead of the `EditScopeAccessor`.  The string-typed path is discouraged because it is not compile-time verified. The form field ViewModel constructor accepts a string-typed path that contains the location of the EditScope observable to which the Form field should bind, as in the code located at    `<dir>/Client/V1/Forms/Scenarios/FormFields/ViewModels/FormFieldsFormIntegratedViewModels.ts`. It is also in the following code.

 ```typescript

this.textBoxViewModel = new MsPortalFx.ViewModels.Forms.TextBox.ViewModel(container, this, "name", textBoxOptions);

``` 

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

<!--TODO: Determine whether there are other documents that discuss form fields, like validation.  -->

For more information about form fields, see [top-extensions-controls.md](top-extensions-controls.md).

<a name="editscopes-and-editscopeless-forms-legacy-editscopes-editscope-entity-arrays-editscope-by-using-ajax"></a>
#### EditScope by using AJAX

An extension can read and write data to the server directly by using `ajax()` calls. It loads and saves data by creating an `EditScopeCache` object and defining two functions. The `supplyExistingData` function reads the data from the server, and the `saveEditScopeChanges` function writes it back.

The code for this example is associated with the basic form sample. It is located at 
* `<dir>\Client\V1\Forms\Samples\Basic\FormsSampleBasic.pdl`
* `<dir>\Client\V1\Forms\Samples\Basic\Templates\FormSampleBasic.html`
* `<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`

The code instantiates an `EditScope` by using a `MsPortalFx.Data.EditScopeView` object. When the data to manipulate is already located on the client, an `EditScopeView` can also be obtained from other data cache objects, as in the following example.

 ```typescript

const editScopeCache = EditScopeCache.createNew<WebsiteModel, number>({
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
        const website = editScope.root;

        // if you need to do conversion on the data before posting to server you can do that
        // all we need to do here is turn the knockout object into json
        const serializableWebsite = ko.toJSON(website);

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
            };
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

this._form = new Form.ViewModel<WebsiteModel>(this._ltm);
this._form.editScope = this._editScopeView.editScope;

```

This form displays one textbox that allows the user to edit the name of the website, as specified in the following code.

 ```typescript

const websiteName = new TextBox.ViewModel(
    this._ltm,
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
this.section = new Section.ViewModel(this._ltm, {
    children: ko.observableArray<any>([
        websiteName
    ])
});

```

The form is rendered using a section. The code loads all the controls that should be displayed into the `children` observable array of the section. This positions the controls sequentially on a blade, by default, so it is an easy way to standardize the look of forms in the Portal. An alternative to the default positioning is to manually author the HTML for the form by binding each control into an HTML template for the blade.

This sample includes two commands at the top of the blade that save or discard data. Commands are used because this blade stays open after a save/discard operation. If the blade were to close after the operation, then there would be an action bar at the bottom of the blade to use instead. 

The commands check to make sure that the `EditScope` has been populated previous to enabling themselves by using the `canExecute` portion of the `ko.pureComputed` code.

The commands also keep themselves disabled during save operations by using a `_saving` observable that the blade maintains, as in the code located at `<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`.

<!-- TODO:  Determine whether this is the sample that is causing the npm run docs build to blow up. -->

 ```typescript

// set up save command
const saveCommand = new Toolbars.CommandButton();
saveCommand.label(ClientResources.saveText);
saveCommand.icon(FxBase.Images.Save());
saveCommand.command = {
    canExecute: ko.pureComputed(() => {
        // user can save when edit scope is dirty and we're not in the middle of a save operation
        const editScope = this._editScopeView.editScope();
        const editScopeDirty = !!editScope ? editScope.dirty() : false;
        return !this._saving() && editScopeDirty;
    }),
    execute: (context: any): FxBase.Promise => {
        return this._editScopeView.editScope().saveChanges();
    }
};

// set up discard command
const discardCommand = new Toolbars.CommandButton();
discardCommand.label(ClientResources.discardText);
discardCommand.icon(MsPortalFx.Base.Images.Delete());
discardCommand.command = {
    canExecute: ko.pureComputed(() => {
        // user can save when edit scope is dirty and we're not in the middle of a save operation
        const editScope = this._editScopeView.editScope();
        const editScopeDirty = !!editScope ? editScope.dirty() : false;
        return !this._saving() && editScopeDirty;
    }),
    execute: (context: any): FxBase.Promise => {
        this._editScopeView.editScope().revertAll();
        return null;
    }
};

this.commandBar = new Toolbars.Toolbar(this._ltm);
this.commandBar.setItems([saveCommand, discardCommand]);

```

Because the `EditScope` is being used, the save/discard commands can just call the `saveChanges()` or `revertAll()` methods on the edit scope to trigger the right action.

For more information, see [http://knockoutjs.com/documentation/computed-writable.html](http://knockoutjs.com/documentation/computed-writable.html).

<a name="editscopes-and-editscopeless-forms-legacy-editscopes-editscope-entity-arrays-editscope-request"></a>
#### Editscope request

The following sample PDL file demonstrates requesting an `editScope`.  The sample is also located at `<dir>\Client\V1\MasterDetail\MasterDetailEdit\MasterDetailEdit.pdl`.  The `valid` element is using the `section` object of the form to determine if the form is currently valid. 

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



<a name="editscopes-and-editscopeless-forms-forms-without-editscopes"></a>
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

<a name="editscopes-and-editscopeless-forms-forms-without-editscopes-dropdown-loading-indicator"></a>
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

<a name="editscopes-and-editscopeless-forms-forms-without-editscopes-customizing-alerts"></a>
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

<a name="editscopes-and-editscopeless-forms-forms-without-editscopes-css-classes"></a>
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

<a name="editscopes-and-editscopeless-forms-forms-without-editscopes-replacing-action-bars-with-buttons"></a>
### Replacing action bars with buttons

Out-of-the-box CSS classes can dock a button at the bottom of blade to make it look like an Action Bar.

The following sample demonstrates how to replace the action bar by docking a button and errorInfo box at the bottom of the blade by using the `msportalfx-docking-footer` css class. The `msportalfx-padding` class  adds 10 x 10 padding to the docked footer.

```html

<div class='msportalfx-docking-footer msportalfx-padding'>
    <div data-bind='pcControl: errorBox, visible: showErrorBox'></div>
    <div data-bind='pcControl: okButton' class='ext-ok-button'></div><a>Link</a>
</div>

```

<a name="editscopes-and-editscopeless-forms-forms-without-editscopes-closing-the-blade"></a>
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




<a name="editscopes-and-editscopeless-forms-using-azure-ccontrols-in-editscope-backed-forms"></a>
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

<a name="editscopes-and-editscopeless-forms-frequently-asked-questions"></a>
## Frequently asked questions

<a name="editscopes-and-editscopeless-forms-frequently-asked-questions-discard-change-pop-up-always-displayed"></a>
### Discard change pop-up always displayed

***Q: My users see the 'discard change?' pop-up, even when they've made no changes on my Form Blade. What's wrong?*** 

The EditScope `root` property returns an object or array that includes uses of Knockout observables (`KnockoutObservable<T>` and `KnockoutObservableArray<T>`). Any observable located within the EditScope is designed to be modified/updated only by the user, via Form fields that are bound to EditScope observables. Importantly, these EditScope observables were not designed to be modified directly from extension TypeScript code. If extension code modifies an observable during the Form/Blade initialization process, the EditScope will record this as a user edit, and this accidental edit will trigger the `discard changes` pop-up when the user tries to close the associated Blade.

SOLUTION:
Rather than initializing the EditScope by programmatically modifying/updating EditScope observables, use these alternative techniques:
* If the extension uses a `ParameterProvider` component to manage its EditScope, initialize the EditScope data in the `mapIncomingData[Async]` callback supplied to ParameterProvider.
* If the extension uses an EditScopeCache component to manage its EditScope, initialize the EditScope data in the `supplyNewData` and `supplyExistingData` callbacks supplied to EditScopeCache.
* If neither of the above techniques suits the scenario, the `editScope.resetValue()` method can be used to set a new/initial value for an EditScope observable in a way that *is not recorded as a user edit* (although this only works for observables storing primitive-typed values).  
  
* * *

<a name="editscopes-and-editscopeless-forms-frequently-asked-questions-editscope-location"></a>
### EditScope Location

***Q: I need to integrate my Form with an EditScope. Where do I get the EditScope?*** 

**NOTE**:  EditScopes are becoming obsolete.  It is recommended that extensions and forms be developed without edit scopes, as specified in [portalfx-editscopeless-procedure.md](portalfx-editscopeless-procedure.md).

SOLUTION: Integrate forms with `EditScopes` varies according to the UX design. Developers can choose between using a `ParameterProvider` component or `EditScopeCache` component as follows:

* Use `ParameterProvider` for the following scenario:
    * **Pop-up/dialog-like form** - The blade uses an ActionBar with an 'Ok'-like button that commits user edits. Typically, when the user commits the edits, the blade is implicitly closed, like a conventional UI pop-up/dialog. The blade uses `parameterProvider.editScope` to access the loaded/initialized EditScope.

* Use `EditScopeCache` for the following scenarios:
    * **Save/Revert blade** - There are 'Save' and 'Revert changes' commands in the CommandBar of the blade. Typically, these commands keep the blade open so the user can perform successive edit and save cycles without closing and reopening the form. 

    * **Document editing** - In the document-editing scenario, the user can make edits to a single EditScope/Form model across multiple parent-child blades. The parent blade sends its `inputs.editScopeId` input to any child blade that edits the same model as the parent Blade. The child blade uses this `inputs.editScopeId` in its call to `editScopeView.fetchForExistingData(editScopeId)` to fetch the EditScope of the parent Blade. 

* * *
  
<a name="editscopes-and-editscopeless-forms-frequently-asked-questions-what-is-an-editscopeaccessor"></a>
### What is an EditScopeAccessor?

***Q: Form fields have two constructor overloads, which should I use? What is an EditScopeAccessor?*** 

SOLUTION: For more information about EditScopeAccessors, see [top-legacy-editscopes.md#the-editscopeaccessor](top-legacy-editscopes.md#the-editscopeaccessor).

* * * 

<a name="editscopes-and-editscopeless-forms-frequently-asked-questions-type-metadata"></a>
### Type metadata
<!-- TODO:  Move this back to the TypeScript  document -->
***Q: When do I need to worry about type metadata for my EditScope?***

SOLUTION: For many of the most common Form scenarios, there is no need to describe the EditScope/Form model in terms of type metadata. Typically, supplying type metadata is the way to turn on advanced FX behavior, in the same way that .NET developers apply custom attributes to .NET types to tailor .NET FX behavior for each customized types. 

For more information about type metadata, see [portalfx-data-typemetadata.md](portalfx-data-typemetadata.md).

 For EditScope and Forms, extensions supply type metadata for the following scenarios.

 * Editable grid
 
    Specified in [top-legacy-editscopes.md#editScope-entity-arrays](top-legacy-editscopes.md#editScope-entity-arrays).

 * Opting out of edit tracking 

    Specified in [top-legacy-editscopes.md#the-trackedits-property](top-legacy-editscopes.md#the-trackedits-property).


* * *

<a name="editscopes-and-editscopeless-forms-frequently-asked-questions-keeping-editscope-from-tracking-changes"></a>
### Keeping EditScope from tracking changes

***Q: Some of my Form data is not editable. How do I keep EditScope from tracking changes for this data?***

SOLUTION: For more information about configuring an EditScope by using type metadata, see [top-legacy-editscopes.md#the-trackedits-property](top-legacy-editscopes.md#the-trackedits-property).
  
* * *

<a name="editscopes-and-editscopeless-forms-frequently-asked-questions-key-value-pairs"></a>
### Key-value pairs

***Q: My Form data is just key/value pairs. How do I model a Dictionary/StringMap in EditScope? Why can't I just use a JavaScript object like a property bag?***

DESCRIPTION:  The  Azure Portal FX instantiates an object/array and returns it to the extension to render the UI. Like all data models and `ViewMmodels`, any subsequent mutation of that object/array should be performed by changing/mutating **Knockout** observables. Portal controls and **Knockout** **HTML** template rendering both subscribe to these observables and re-render them only when these observables change value.

This poses a challenge to the common `JavaScript` programming technique of treating a `JavaScript` object as a property bag of key-value pairs. If an extension only adds or removes keys from a datamodel or a `ViewModel` object, the Portal will not be aware of these changes. `EditScope` will not recognize these changes as user edits and therefore such adds/removes will put `EditScope` edit-tracking in an inconsistent state.

SOLUTION:  An extension can model a Dictionary/StringMap/property bag for an `EditScope` by instantiating an  observable array of key/value-pairs, like `KnockoutObservableArray<{ key: string; value: TValue; }>`. 

The users can edit the contents of the  Dictionary/StringMap/property bag by using an editable grid. The editable grid can only be bound to an `EditScope` 'entity' array. This allows the extension to describe the array of key/value-pairs as an 'entity' array.

For more information about how to develop type metadata to use the array with the editable grid, see [top-legacy-editscopes.md#the-getEntityArrayWithEdits-method](top-legacy-editscopes.md#the-getEntityArrayWithEdits-method).

* * *



