
### Legacy Blades

A blade is the vertical container that acts as the starting point for any journey. You can define multiple blades, each containing their own collection of statically defined lenses and parts.

**NOTE**: Given the complexity associated with this model, extension authors are encouraged to use TemplateBlades instead, as specified in [portalfx-blades-overview.md](portalfx-blades-overview.md).

The following image depicts a legacy blade.

![alt-text](../media/portalfx-extensions-helloWorld/helloWorldExtensionAlohaBlade.png "Blade")

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

Blades can be created in any PDL file, and they will be aggregated at compile time into the extension definition, as in the code located at `<dir>\Client\V1\Blades\Locked\Locked.pdl`. The code is also in the following example.

```xml
<Blade Name="LockedBlade"
       ViewModel="LockedBladeViewModel">
    <Lens>
        ...
    </Lens>
</Blade>
```

Blades use ViewModels to drive dynamic content, including titles, icons, and status.  To learn more about blades, start with the following topics:

* [Controlling blade UI](portalfx-blades-ui.md)
* [Opening blades](portalfx-blades-opening.md)
* [Blade parameters](portalfx-blades-parameters.md)
* [Blade properties](portalfx-blades-properties.md)
* [Blade outputs](portalfx-blades-outputs.md)
* [Pinning blades](portalfx-blades-pinning.md)
* [Closing blades](portalfx-blades-closing.md)

* * * 

* Controlling blade UI
 {"gitdown": "include-file", "file": "../templates/portalfx-blades-ui.md"}

* Opening blades
 {"gitdown": "include-file", "file": "../templates/portalfx-blades-opening.md"}

* Blade parameters
 {"gitdown": "include-file", "file": "../templates/portalfx-blades-parameters.md"}

* Blade properties
 {"gitdown": "include-file", "file": "../templates/portalfx-blades-properties.md"}

* Blade outputs
 {"gitdown": "include-file", "file": "../templates/portalfx-blades-outputs.md"}

* Pinning blades 
{"gitdown": "include-file", "file": "../templates/portalfx-blades-pinning.md"}

* Closing blades
{"gitdown": "include-file", "file": "../templates/portalfx-blades-closing.md"}



