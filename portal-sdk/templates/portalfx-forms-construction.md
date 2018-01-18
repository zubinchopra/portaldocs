
## Loading, editing and saving data

This sample reads and writes data to the server directly via `ajax()` calls. 

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory. Links to the Dogfood environment will display working copies of the samples that were made available with the SDK.

The code for this example is associated with the 'basic form' sample. It is located at 
* `<dir>\Client\Forms\Samples\Basic\FormsSampleBasic.pdl`
* `<dir>\Client\Forms\Samples\Basic\Templates\FormSampleBasic.html`
* `<dir>\Client\Forms\Samples\Basic\ViewModels\FromsSampleBasicBlade.ts`

The following code will load and save data by creating an `EditScopeCache` object and defining two functions. The `supplyExistingData` function reads the data from the server, and the `saveEditScopeChanges` function writes it back.

1. Instantiate an edit scope via a `MsPortalFx.Data.EditScopeView` object. 

**NOTE**: When the data to manipulate is already on the client, you can also get an edit scope view from other data cache objects.

<!--
{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Samples/Basic/ViewModels/FormsSampleBasicBlade.ts", "section": "forms#editScopeCache"}
-->

2. Transform the data to make it match the model type.

The server returns strings, but the model type that is being used  (`WebsiteModel`) is defined as:

```ts
interface WebsiteModel {
    id: KnockoutObservable<number>;
    name: KnockoutObservable<string>;
    running: KnockoutObservable<boolean>;
}
```

Therefore, the save and load of the data have to transform the data to make it match the model type.

<!-- TODO: Determine whether `Form.ViewModel` is an optional field. -->
The control view models require a reference to a `Form.ViewModel`, so we need to create a form and send the reference to the editScope to it, as in the following example.

`<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`
<!--
{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Samples/Basic/ViewModels/FormsSampleBasicBlade.ts", "section": "forms#formViewModel"}
-->

This form displays one textbox that lets the user edit the name of the website, as in the following code.

`<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`
<!--
{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Samples/Basic/ViewModels/FormsSampleBasicBlade.ts", "section": "forms#controls"}
-->

The form is rendered using a section. Add all the controls that should be displayed into the `children` observable array of the section. This positions the controls sequentially on a blade, by default, so it's often an easy way to standardize the look of most forms in the Portal. An alternative to the default positioning is to manually author the HTML for the form by binding each control into HTML template for the blade.

This sample includes two commands at the top of the blade that will save or discard data. Commands are used because this blade stays open after a save/discard operation. If the blade was to close after the operation, then there would be an action bar at the bottom of the blade to use instead. 

The commands check to make sure the edit scope has been populated previous to enabling themselves via the `canExecute` label in the `ko.pureComputed` code.
<!-- TODO: Determine whether this is a label, a case, or a method. --> 
They also keep themselves disabled during save operations via an observable named `_saving` that the part maintains, as in the following code.

`<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`

<!--
{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Samples/Basic/ViewModels/FormsSampleBasicBlade.ts", "section": "forms#commands"}
-->

Because the edit scope is being used, the save/discard commands can just call the `saveChanges()` or `revertAll()` methods on the edit scope to trigger the right action.

For more information, see [http://knockoutjs.com/documentation/computed-writable.html](http://knockoutjs.com/documentation/computed-writable.html).