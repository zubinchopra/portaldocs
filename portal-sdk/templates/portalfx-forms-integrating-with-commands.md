
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
