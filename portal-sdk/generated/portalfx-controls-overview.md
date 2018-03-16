
<a name="overview"></a>
## Overview

Controls are the building blocks of the Azure extension experience. They allow users to view, edit, and analyze data.

The Azure Portal team ships sample code that extension developers can leverage. All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder. The source specifies the namespace in which the control is located. 

Devlopers can view working copies of  sample controls in the Dogfood environment, which is located at [https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/controls). This site also contains links to working copies of individual controls. In some instances, controls describe the properties that they use in various interfaces, as in the following image.

![alt-text](controlProperties.png "Property for Filterable Grid Extensions Options Interface")

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples).

They can also access the controls playground located at [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground), which allows them to build their own code instead of using the provided samples.

The Azure components of a UI experience are documented several ways. 
* There may be a document that provides guidance about the component, in terms of what it is, what it does, or how it is used. 
* The location of the sample code is included so that the developer can view the source for the component, or modify it as appropriate for the extensions they develop.  
* A working copy of the component can be viewed in the Dogfood environment or the controls playground.