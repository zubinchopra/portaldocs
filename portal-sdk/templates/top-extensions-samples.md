# Portal Extension Samples

## Overview

The Azure Portal team ships many samples that extension developers can use to learn.

When you install the Portal SDK, located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download), the samples are installed as well. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

First-party extension developers, also known as Microsoft employees, can access a live, up-to-date version of the samples at [https://aka.ms/portalfx/viewSamples](https://aka.ms/portalfx/viewSamples).

For the latest controls we have developed a new playground, located at  [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground). The playground gives you a listing of all the recommended controls as well as a sample page for each control. The sample pages  have documentation for each option and view model property, and they will let you see a working copy of the control and try out different control options.

For help you can ask a question in the internal StackOverflow tool located at [https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza). The Ibiza team monitors certain tags as defined in [portalfx-stackoverflow.md](portalfx-stackoverflow.md).

## V1 versus V2

The samples are structured into two directories, **V1** and **V2**, as in the following example. 

 ![alt-text](../media/top-extensions-samples/v1-and-v2.png  "V1 and V2 Directories")

<!--TODO: Can "meant" be changed to "will"  or "intended" ? -->

### V2

The samples in the **V2** directories use the most recent patterns. They contain the collection of new APIs that are meant to be the only set of APIs needed to develop an Ibiza extension that performs well and is accessible.

The **V2** samples address the following API areas.

* New variations TemplateBlade, FrameBlade, MenuBlade 

* Blade-opening and closing `container.openBlade`, among others

* no-PDL TypeScript decorators that define all recommended Blade/Part variations

* Forms that do not use **V1** EditScope. For more information about EditScope, see [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md).

### V1

The **V1** APIs use APIs that support previous UX patterns, are becoming obsolete, or are less commonly used.  The **V1** APIs are also more difficult to use than the new APIs, for both the UX design and  the associated APIs.

The following **V1** concepts should not be used when **V2** APIs can be used instead.

* Blades that contain Parts
* **V1** Blade-opening -- Selectable/SelectableSet APIs
* EditScope
* Fixed-width Blades
* **V1** Forms that use EditScope
* ParameterCollector/ParameterProvider
* PDL

**NOTE**: Building the **V2** support is still in process, therefore  the previously-listed **V1** concepts are not completely deprecated. For example, the source code for small, medium, and large blades is located in the `<dir>\Client\V1\Blades\BladeWidth`  directory. In the meantime, use **V1** APIs in places where a **V2** replacement is not evident.

### Running your local samples extension

After installing **Visual Studio** and the Portal Framework SDK, locate the samples in the ...\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension folder.

* Open the SamplesExtension solution file to experiment with samples in the IDE. 

* Press the F5 key to start debugging the sample extensions. 

*  When it loads, click on the More Services option in the menu, as in the following example.
  
 	![alt-text](../media/top-extensions-samples/samples-services.png  "Portal Extensions Services")

In the filter box, search for "Azure Portal SDK". You can use `Shift + Space` to mark it as a favorite site. Clicking this item opens a menu blade that allows you to get to all the samples.

    

 {"gitdown": "include-file", "file": "../templates/portalfx-extensions-faq-samples.md"}
