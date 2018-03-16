
<a name="procedure"></a>
## Procedure

To use a control, there are basically three steps.

1. The control is used by importing the module, as in the following code.

   ```c#
    import * as <control>  from "Fx/Controls/<control> ";
		   ```

		   where
		   
	<control>  is the name of the control, for example, infoBox.
	
1. Change the link element in the HTML template to a control container.

    ```html
    <div>This is an example template blade that shows a link.</div>

    <div data-bind="pcControl:infoBox"></div>
    ```

1. Then, create the ViewModel.

   ```c#
   public infoBoxr: infoBox.Contract;

   this.infoBox = infoBox.create(container, {
       label: "someLabel"
       //Other options...
   });

   ```

The ViewModel can be created by experimenting with controls in the Controls Playground located at  [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples). Alternatively, an extension can be developed by using the samples located at  `<dir>\Client\V1\Controls` or `<dir>\Client\V2\Controls\`, where `<dir>` is the `SamplesExtension\Extension\` directory, based on where the samples were installed when the developer set up the SDK.