
## Advanced Topics

The following sections discuss advanced topics in template blade development.

* [Deep linking](#deep-linking)

* [Displaying notifications](#displaying-notifications)

* [Pinning the blade](#pinning-the-blade)

* [Storing settings](#storing-settings)

* [Displaying Unauthorized UI](#displaying-unauthorized-ui)

* [Dynamically displaying Notice UI](#dynamically-displaying-notice-ui)

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

* * *

### Deep linking

Deep linking is the feature that gives the user a URL that directly navigates to the new blade when a blade is opened and the portal URL is updated. By design, only certain blades can be deep linked. Blades that cannot be deep linked are the ones that cannot be opened independent of some parent blade or part, like blades that return values to a calling module. An example of blades that cannot be deep-linked is a Web page in the middle of an website's check-out experience.

One of the easiest ways to make your blade deep linkable is to mark your TemplateBlade as pinnable. For more information about pinning blades, see [#pinning-the-blade](#pinning-the-blade).

### Displaying notifications

A status bar can be displayed at the top of a blade that contains both text and coloration that can be used to convey information and status to users. For example, when validation fails in a form, a red bar with a message can be displayed at the top of the blade. This area is clickable and can either open a new blade or an external url.

This capability is exposed through the **statusBar** member in the Blade base class by using `this.statusBar(myStatus)` in your blade view-model, as in the code located at `<dir>Client/V1/Blades/ContentState/ViewModels/ContentStateViewModels.ts`.
It is also included in the following code.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/ContentState/ViewModels/ContentStateViewModels.ts", "section": "templateBlade#contentState"}

### Pinning the blade

Blades can be marked as able to be pinned to the dashboard by setting `Pinnable="true"` in the TemplateBlade's PDL definition file. By default, blades are pinned as button parts to the dashboard. If a different represention should be used, it should be specified in the PDL file. 

### Storing settings

Settings that are associated with a blade can be stored. Those settings need to be declared both in the PDL definition file and in the ViewMmodel that is associated with the blade.  The code that describes how to store settings is located at  `<dir>Client/V1/Blades/Template/Template.pdl` and  `<dir>Client/V1/Blades/Template/ViewModels/TemplateBladeViewModels.ts`.

The process is as follows.

1. Specify the settings in the PDL file using the `TemplateBlade.Settings` element.

   {"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/Template/Template.pdl", "section": "templateBlade#settingsPDL"}

1. After the settings are declared, they should also be specified in the ViewModel, as in the following example.

   {"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/Template/ViewModels/TemplateBladeViewModels.ts", "section": "templateBlade#settingsVMDef"}

1. Retrieve the settings by using the blade container.

   {"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/Template/ViewModels/TemplateBladeViewModels.ts", "section": "templateBlade#settingsVMUse"}

1.  Also send the settings to the `onInputsSet` method.

   {"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/Template/ViewModels/TemplateBladeViewModels.ts", "section": "templateBlade#settingsVMois"}

### Displaying Unauthorized UI

You can set the blade to Unauthorized UI using the `unauthorized` member of the blade container. The code that describes how to set the blade is located at  `<dir>/Client/V1/Blades/Unauthorized/ViewModels/UnauthorizedBladeViewModel.ts`.

The following code does this statically, but it can also be done dynamically, based  on a condition after data is loaded.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/Unauthorized/ViewModels/UnauthorizedBladeViewModel.ts", "section": "templateBlade#Unauthorized"}

### Dynamically displaying Notice UI

You can set the blade to the Notice UI using `enableNotice` member of the blade container. The code that describes how to set the blade is located at  `<dir>Client/V1/Blades/DynamicNotice/ViewModels/DynamicNoticeViewModels.ts`.

Enabling the blade can be done statically with the constructor, or it can be done dynamically. In the following example, the blade is set to Notice UI if the **id** input parameter has a specific value.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/DynamicNotice/ViewModels/DynamicNoticeViewModels.ts", "section": "templateBlade#dynamicNotice"}