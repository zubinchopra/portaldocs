
# Extension Controls

## Overview 

Controls are the building blocks of the Azure extension experience. They allow users to view, edit, and analyze data.

The Azure Portal team ships sample code that extension developers can leverage. All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder. The source specifies the namespace in which the control is located. 

Developers can view working copies of  sample controls in the Dogfood environment, which is located at [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls). This site also contains links to working copies of individual controls. In some instances, controls describe the properties that they use in various interfaces, as in the following image.

![alt-text](../media/portalfx-controls/controlProperties.png "Property for Filterable Grid Extensions Options Interface")

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples).

They can also access the controls playground located at [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground), which allows them to build their own code instead of using the provided samples.

The Azure components of a UI experience are documented several ways. 
* There may be a document that provides specific guidance about the component, in terms of what it is, what it does, or how it is used. 
* The location of the sample code is included so that the developer can view the source for the component, or modify it as appropriate for the extensions they develop.  
* A working copy of the component can be viewed in the Dogfood environment or the controls playground.

## Procedure

To use a control, there are basically three steps. The following example demonstrates the three steps in **C#**; the three steps still occur in **Typescript**, but they may be programmed slightly differently.

<!-- TODO: Determine whether the import statement is an alternative to referencing the control in the PDL in order to connect it to the extension, and if so, when.   -->

1. The control is used by importing the module, as in the following code.

   ```c#
    import * as <control>  from "Fx/Controls/<control> ";
   ```

   where
		   
	`<control>`  is the name of the control, for example, infoBox.

    In some instances, the control is connected to the extension by being referenced in the pdl file, instead of importing the module for the control.
    
	
1. Change the link element in the HTML template to a control container.

    ```html
    <div>This is an example template blade that shows a link.</div>

    <div data-bind="pcControl:infoBox"></div>
    ```

1. Then, create the ViewModel in the code.

   ```c#
   public infoBox: infoBox.Contract;

   this.infoBox = infoBox.create(container, {
       label: "someLabel"
       //Other options...
   });

   ```

The ViewModel can be created by experimenting with controls in the playground located at  [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground) and the samples located at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples). Alternatively, an extension can be developed by using the samples located at  `<dir>\Client\V1\Controls` or `<dir>\Client\V2\Controls\`, where `<dir>` is the `SamplesExtension\Extension\` directory, based on where the samples were installed when the developer set up the SDK.


{"gitdown": "include-file", "file": "../templates/top-extensions-controls-playground.md"}
<!--

  gitdown": "include-file", "file": "../templates/top-extensions-samples-controls-deprecated.md"}

 gitdown": "include-file", "file": "../templates/portalfx-extensions-bp-controls.md"}
 -->

{"gitdown": "include-file", "file": "../templates/portalfx-extensions-faq-controls.md"}
    
{"gitdown": "include-file", "file": "../templates/portalfx-extensions-glossary-controls.md"}

