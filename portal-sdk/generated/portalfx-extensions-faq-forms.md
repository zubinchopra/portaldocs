<a name="frequently-asked-questions"></a>
## Frequently asked questions

<a name="frequently-asked-questions-should-i-use-an-action-bar-or-a-commands-toolbar-on-my-form"></a>
### Should I use an action bar or a commands toolbar on my form?

It depends on the scenario that drives the UX. If the form will capture some data from the user and expect the blade to be closed after submitting the changes, then use an action bar, as specified in [portalfx-ux-create-forms.md#action-bar-+-blue-buttons](portalfx-ux-create-forms.md#action-bar-+-blue-buttons).  However, if the form will edit or update some data, and expect the user to make multiple changes before the blade is closed, then use commands, as specified in [portalfx-commands.md](portalfx-commands.md). 

* Action Bar

  The action bar will have one button whose label is something like "OK", "Create", or "Submit". The blade should automatically close immediately after the action bar button is clicked. Users can abandon the form by clicking the Close button that is located at the top right of the application bar. Developers can use a `ParameterProvider` to simplify the code, because it provisions the `editScope` and implicitly closes the blade based on clicking on the action bar. 

  Alternatively, the action bar can contain two buttons, like "OK" and "Cancel", but that requires further configuration. The two-button method is not recommended because the "Cancel" button is made redundant by the Close button.

* Commands
  
  Typically, the two commands at the top of the blade are the "Save" command and the "Discard" command. The user can make edits and click "Save" to commit the changes. The blade should show the appropriate UX for saving the data, and will stay on the screen after the data has been saved. The user can make further changes and click "Save" again. The user can also discard their changes by clicking "Discard". Once the user is satisfied with the changes, they can close the blade manually.
  
* * * 

<a name="frequently-asked-questions-discard-change-pop-up-always-displayed"></a>
### Discard change pop-up always displayed

***Q: My users see the 'discard change?' pop-up, even when they've made no changes on my Form Blade. What's wrong?*** 

The EditScope `root` property returns an object or array that includes uses of Knockout observables (`KnockoutObservable<T>` and `KnockoutObservableArray<T>`). Any observable located within the EditScope is designed to be modified/updated only by the user, via Form fields that are bound to EditScope observables. Importantly, these EditScope observables were not designed to be modified directly from extension TypeScript code. If extension code modifies an observable during the Form/Blade initialization process, the EditScope will record this as a user edit, and this accidental edit will trigger the `discard changes` pop-up when the user tries to close the associated Blade.  

SOLUTION:
Rather than initializing the EditScope by programmatically modifying/updating EditScope observables, use these alternative techniques:
* If the extension uses a ParameterProvider component to manage its EditScope, initialize the EditScope data in the '`mapIncomingData[Async]`' callback supplied to ParameterProvider.
* If the extension uses an EditScopeCache component to manage its EditScope, initialize the EditScope data in the '`supplyNewData`' and '`supplyExistingData`' callbacks supplied to EditScopeCache.
* If neither of the above techniques suits the scenario, the '`editScope.resetValue()`' method can be used to set a new/initial value for an EditScope observable in a way that *is not recorded as a user edit* (although this only works for observables storing primitive-typed values).  
  
* * *

<a name="frequently-asked-questions-editscope-location"></a>
### EditScope Location

***Q: I need to integrate my Form with an EditScope. Where do I get the EditScope?*** 

SOLUTION: This varies according to the UX design. Developers can choose between using a `ParameterProvider` component or `EditScopeCache` component as follows:

* Use `ParameterProvider` for the following scenario:
    * **Pop-up/dialog-like form** - The blade uses an ActionBar with an 'Ok'-like button that commits user edits. Typically, when the user commits the edits, the blade is implicitly closed, like a conventional UI pop-up/dialog. The blade uses `parameterProvider.editScope` to access the loaded/initialized EditScope.

* Use `EditScopeCache` for the following scenarios:
    * **Save/Revert blade** - There are 'Save' and 'Revert changes' commands in the CommandBar of the blade. Typically, these commands keep the blade open so the user can perform successive edit and save cycles without closing and reopening the form. The blade uses an `EditScopeView`, as specified in  `editScopeCache.createView(...)`, to load/acquire the EditScope.  

    * **Document editing** - The blade uses an `EditScopeView`, as specified in  `editScopeCache.createView(...)`, to load/acquire the EditScope.   The user can make edits to a single EditScope/Form model across multiple parent-child blades. The parent blade sends its `inputs.editScopeId` input to any child blade that edits the same model as the parent Blade. The child blade uses this `inputs.editScopeId` in its call to `editScopeView.fetchForExistingData(editScopeId)` to fetch the EditScope of the parent Blade. Scenarios like these resemble document editing. 

* * *
  
<a name="frequently-asked-questions-what-is-an-editscopeaccessor"></a>
### What is an EditScopeAccessor?

***Q: Form fields have two constructor overloads, which should I use? What is an EditScopeAccessor?*** 

SOLUTION: For more information about EditScopeAccessors, see [portalfx-legacy-editscopes.md#editscopeaccessor](portalfx-legacy-editscopes.md#editscopeaccessor).

* * * 


<a name="frequently-asked-questions-keeping-editscope-from-tracking-changes"></a>
### Keeping EditScope from tracking changes

***Q: Some of my Form data is not editable. How do I keep EditScope from tracking changes for this data?***

SOLUTION: For more information about configuring an EditScope by using type metadata, see [portalfx-extensions-faq-forms.md#track-edits](portalfx-extensions-faq-forms.md#track-edits).
  
* * *


<a name="frequently-asked-questions-keeping-editscope-from-tracking-changes-modeling-your-data-as-an-entity-array"></a>
#### Modeling your data as an &#39;entity&#39; array

SOLUTION: 
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

* * *

<a name="frequently-asked-questions-keeping-editscope-from-tracking-changes-converting-your-data-to-an-entity-array-for-consumption-by-editable-grid"></a>
#### Converting your data to an &#39;entity&#39; array for consumption by editable grid

SOLUTION: 
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
  
* * *

<a name="frequently-asked-questions-q-what-should-be-returned-from-saveeditscopechanges-i-don-t-understand-the-different-values-of-the-accepteditscopechangesaction-enum"></a>
### Q: What should be returned from &#39;saveEditScopeChanges&#39;? I don&#39;t understand the different values of the <code>AcceptEditScopeChangesAction</code> enum.

<!-- TODO:  Move this to the EditScope document -->

SOLUTION: 
When creating an EditScopeCache, the `saveEditScopeChanges` callback supplied by the extension is called to push EditScope edits to a server/backend. This callback returns a `Promise` that should be resolved when the 'save' AJAX call completes, which occurs after the server/backend accepts the user's edits. 

When the extension resolves this `Promise`, it can supply a value that instructs the EditScope to  reset itself to a clean/unedited state. If no such value is returned during Promise resolution, then the EditScope is reset by default.  This means taking the user's client-side edits and considering these values to be the new, clean/unedited EditScope state. This works for many scenarios.  

There are scenarios where the default `saveEditScopeChanges` behavior does not work, like: the following. 
* During 'save', the server/backend produces new data values that need to be merged into the EditScope.
* For "create new record" scenarios, after 'save', the extension should clear the form, so that the user can enter a new record.

For these cases, the extension will resolve the `saveEditScopeChanges` Promise with a value from the `AcceptEditScopeChangesAction` enum. These values allow the extension to specify conditions like the following.
* The EditScopeCache is to implicitly reload the EditScope data as part of completing the 'save' operation.
* The EditScope's data is to be reverted/cleared as part of completing the 'save' operation (the "create new record" UX scenario).

For more information about each enum value, see the jsdoc comments around `MsPortalFx.Data.AcceptEditScopeChangesAction` or in `MsPortalFxDocs.js` in Visual Studio or any code editor.

<a name="frequently-asked-questions-q-what-should-be-returned-from-saveeditscopechanges-i-don-t-understand-the-different-values-of-the-accepteditscopechangesaction-enum-caveat-anti-pattern"></a>
#### Caveat / anti-pattern

There is an important anti-pattern to avoid here re: '`saveEditScopeChanges`'. If the AJAX call that saves the user's edits fails, the extension should merely **reject** the '`saveEditScopeChanges`' Promise (which is natural to do with Q Promise-chaining/piping). The extension *should not* resolve their Promise with '`AcceptEditScopeChangesAction.DiscardClientChanges`', since this will lose the user's Form edits (a data-loss bug).
  
* * *

<a name="frequently-asked-questions-common-error-entity-typed-object-array-is-not-known-to-this-edit-scope"></a>
### Common error: &quot;Entity-typed object/array is not known to this edit scope...&quot;

SOLUTION: 
EditScope data follows a particular data model. In short, the EditScope is a hierarchy of 'entity' objects. By default, when the EditScope's '`root`' is an object, this object is considered an 'entity'. The EditScope becomes a hierarchy of 'entities' when:
* the EditScope includes an array of 'entity' objects
* some EditScope object includes a property that is 'entity'-typed  

An object is treated by EditScope as an 'entity' when type metadata associated with the object is marked as an 'entity' type (see [here](#entity-type) and the EditScope video located at [here](portalfx-legacy-editscopes.md) for more details).

Every 'entity' object is tracked by the EditScope as being created/updated/deleted. Extension developers define 'entities' at a granularity that suit their scenario, making it easy to determine what in their larger EditScope/Form data model has been user-edited.  

Now, regarding the error above, once the EditScope is initialized/loaded, 'entities' can be introduced and removed from the EditScope only via EditScope APIs. It is an unfortunate design limitation of EditScope that extensions cannot simply make an observable change to add a new 'entity' object or remove an existing 'entity' from the EditScope. If an extension tries to do an observable add (make an observable change that introduces an 'entity' object into the EditScope), they'll encounter the error discussed here.  

To correctly (according to the EditScope design) add or remove an 'entity' object into/out of an EditScope, here are APIs that are useful:
* ['`applyArrayAsEdits`'](#apply-array-as-edits) - This API accepts a new array of 'entity' objects. The EditScope proceeds to diff this new array against the existing EditScope array items, determine which 'entity' objects are created/updated/deleted, and then records the corresponding user edits.
* '`getCreated/addCreated`' - These APIs allow for the addition of new, 'created' entity objects. The '`getCreated`' method returns a distinct, out-of-band array that collects all 'created' entities corresponding to a given 'entity' array. The '`addCreated`' method is merely a helper method that places a new 'entity' object in this '`getCreated`' array.
* '`markForDelete`' - 'Deleting' an 'entity' from the EditScope is treated as a non-destructive operation. This is so that - if the extension chooses - they can render 'deleted' (but unsaved) edits with strike-through styling (or equivalent). Calling this '`markForDelete`' method merely puts the associated 'entity' in a 'deleted' state.  

* * *

<a name="frequently-asked-questions-common-error-entity-typed-object-array-is-not-known-to-this-edit-scope-common-error-scenario"></a>
#### Common error scenario

SOLUTION: 
Often, extensions encounter this "Entity-typed object/array is not known to this edit scope..." error as a side-effect of modeling their data as 'entities' binding with [editable grid](#editable-grid) in some ParameterProvider Blade.  Then, commonly, the error is encountered when applying the array edits in a corresponding ParameterCollector Blade.  Here are two schemes that can be useful to avoid this error:
* Use the [`applyArrayAsEdits'](#apply-array-as-edits) EditScope method mentioned above to commit array edits to an EditScope.
* Define type metadata for this array *twice* - once only for editing the data in an editable grid (array items typed as 'entities'), and separately for committing to an EditScope in the ParameterCollector Blade (array items typed as not 'entities').  
  
* * *

<a name="frequently-asked-questions-editable-object-not-present"></a>
### Editable object not present

***"Encountered a property 'foo' on an editable object that is not present on the original object..."***

SOLUTION: 
As discussed in [portalfx-extensions-faq-forms.md#key-value-pairs](portalfx-extensions-faq-forms.md#key-value-pairs), the extension should mutate the EditScope/Form model by making observable changes and by calling EditScope APIs. For any object residing in the `EditScope`, merely adding and removing keys cannot be detected by `EditScope` or by the FX at large and, consequently, edits cannot be tracked. When an extension attempts to add or remove keys from an `EditScope` object, this puts the `EditScope` edit-tracking in an inconsistent state. When the `EditScope` detects such an inconsistency, it issues the `Encountered a property...` error to encourage the extension developer to use only observable changes and `EditScope` APIs to mutate/change the EditScope/Form model.  

* * *