
## Forms Construction

### Loading, editing and saving data

This sample reads and writes data to the server directly via `ajax()` calls. It loads and saves data by creating an `EditScopeCache` object and defining two functions. The `supplyExistingData` function reads the data from the server, and the `saveEditScopeChanges` function writes it back.

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory. Links to the Dogfood environment will display working copies of the samples that were made available with the SDK.

The code for this example is associated with the basic form sample. It is located at 
* `<dir>\Client\V1\Forms\Samples\Basic\FormsSampleBasic.pdl`
* `<dir>\Client\V1\Forms\Samples\Basic\Templates\FormSampleBasic.html`
* `<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FromsSampleBasicBlade.ts`

The code instantiates an `EditScope` via a `MsPortalFx.Data.EditScopeView` object. When the data to manipulate is already located on the client, an edit scope view can also be obtained from other data cache objects.

<!--
{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Samples/Basic/ViewModels/FormsSampleBasicBlade.ts", "section": "forms#editScopeCache"}
-->

Then, the code transforms the data to make it match the model type. The server returns strings, but the `WebsiteModel` type that is used is defined in the following code.

  ```ts
   interface WebsiteModel {
      id: KnockoutObservable<number>;
      name: KnockoutObservable<string>;
      running: KnockoutObservable<boolean>;
  }
  ```
  Therefore, the save and load functions have to transform the data to make it match the `WebsiteModel` model type. The control `viewModels` require a reference to a `Form.ViewModel`, so the code creates a form and sends the reference to the `editScope` to it, as in the following example.

`<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`
<!--
{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Samples/Basic/ViewModels/FormsSampleBasicBlade.ts", "section": "forms#formViewModel"}
-->

This form displays one textbox that allows the user to edit the name of the website, as specified in the following code.

`<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`
<!--
{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Samples/Basic/ViewModels/FormsSampleBasicBlade.ts", "section": "forms#controls"}
-->

The form is rendered using a section. The code loads all the controls that should be displayed into the `children` observable array of the section. This positions the controls sequentially on a blade, by default, so it is an easy way to standardize the look of forms in the Portal. An alternative to the default positioning is to manually author the HTML for the form by binding each control into an HTML template for the blade.

This sample includes two commands at the top of the blade that will save or discard data. Commands are used because this blade stays open after a save/discard operation. If the blade were to close after the operation, then there would be an action bar at the bottom of the blade to use instead. 

The commands check to make sure that the `EditScope` has been populated previous to enabling themselves via the `canExecute` portion of the `ko.pureComputed` code.

The commands also keep themselves disabled during save operations via a `_saving` observable that the blade maintains, as in the following code.

`<dir>\Client\V1\Forms\Samples\Basic\ViewModels\FormsSampleBasicBlade.ts`

<!--
{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Forms/Samples/Basic/ViewModels/FormsSampleBasicBlade.ts", "section": "forms#commands"}
-->

Because the `EditScope` is being used, the save/discard commands can just call the `saveChanges()` or `revertAll()` methods on the edit scope to trigger the right action.

For more information, see [http://knockoutjs.com/documentation/computed-writable.html](http://knockoutjs.com/documentation/computed-writable.html).