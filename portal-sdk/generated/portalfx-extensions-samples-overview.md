<a name="overview"></a>
## Overview

One of the most productive ways to learn how to develop code is by reviewing program source.  The Azure portal team ships samples that extension developers can leverage.

All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation the process. The samples are located in the `...\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

First-party extension developers, i.e. Microsoft employees, have access to the Dogfood environment, therefore they can view the samples that are located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKBlade](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKBlade).

<a name="samples-extension"></a>
## Samples extension

The samples extension provides an individual sample for each feature available in the framework, as described in the following image.

 ![alt-text](../media/portalfx-extensions-samples/samples.png  "Samples Extension Solution")

After installing the Portal Framework SDK, the local instance of the portal will open with the samples extension pre-registered.  You can open the `SamplesExtension` solution file to experiment with samples in the IDE.

```bash
[My Documents]\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\SamplesExtension.sln
```

The samples and the portal can be located with IntelliMirror in the following location.

```bash
%LOCALAPPDATA%\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\SamplesExtension.sln
```



If you make edits to the samples, you can refresh the portal to see your changes. Each sample demonstrates a single usage of the API.  It's great for detailed information on any one API.

> If you need help beyond the documentation and samples, you reach out to Ibiza team on [Stackoverflow@MS](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza).

<a name="samples-extension-v1-versus-v2"></a>
### V1 versus V2

The samples are partially structured into two directories, **V1** and **V2**, as in the following example. 

 ![alt-text](../media/portalfx-extensions-samples/v1-and-v2.png  "V1 and V2 Directories")

The samples in `V2` directories use the latest patterns.

The `V2` directory contains the post-GA collection of new APIs are meant to be the only set of APIs needed to develop a modern Ibiza extension.

Our `V1` APIs are contain or use APIs that support old UX patterns that are becoming obsolete or are less commonly used.  The `V1` APIs are also more difficult to use than the new API, for both the UX design and  the associated APIs.

The V2 samples address the following  API areas.

- New Blade variations
    TemplateBlade, FrameBlade, MenuBlade 

- Blade-opening/closing 
    'container.openBlade, et al'

- no-PDL TypeScript decorators 
    to define all recommended Blade/Part variations

- Forms -- No V1 EditScope concept

As for V1 concepts, these are concepts we're asking extensions to avoid where there are V2 APIs that can be used:
- __PDL__
- __EditScope__
- __ParameterCollector/ParameterProvider__
- __"Blades containing Parts"__
- __Non-full-screen Blades__ -- that is, ones that open with a fixed width
- __V1 Blade-opening__ -- Selectable/SelectableSet APIs
- __V1 Forms__ -- using EditScope

Bear in mind that we don't have the V2 space entirely built out. In the meantime, you will have to use V1 APIs in places, even the V1 concepts listed above.