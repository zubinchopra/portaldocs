## Menu Blade

Menu blades are rendered as a menu on the left side of the screen. The Shell combines this blade with the blade that is immediately to its right. Each item that is referenced from the left menu is rendered using the same header as the menu blade, resulting in the two blades being displayed as one blade.  This is similar to the way that the resource menu blade operates.

The process is as follows.

1. The menu blade is displayed as a menu, or list of items that open blades when clicked
1. The menu blade is rendered to the left of the screen
1. The blades that are opened from the menu share the chrome with the menu blade 

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

Menu blades are defined in the PDL file in the following code. The code is also located at `<dir>\Client/V1/Blades/MenuBlade/MenuBlade.pdl`.

{"gitdown": "include-section",  "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/MenuBlade/MenuBlade.pdl", "section": "menuBlade#pdlDef"}

The following code demonstrates how to define a menu blade `ViewModel` to open four different items.

 {"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/MenuBlade/ViewModels/SampleMenuBlade.ts", "section": "menuBlade#ctor"}

There are a few things to notice in the preceding code.

* Menus can have different groups. In this code there are two groups.
* Each menu item opens a blade, and all necessary parameters are provided.
* Menu items can integrate with `EditScope` and `ParameterProvider`, as displayed in the `createengine` item.
* At the end of the constructor, options for the menu are set. The option set defines the `id` of the default item.

You can view a working copy of the MenuBlade  in the Dogfood environment sample located at [https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/PdlSampleMenuBlade/browserelated](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/PdlSampleMenuBlade/browserelated).