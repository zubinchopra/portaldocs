## Overview

**TypeScript** is the recommended alternative to PDL.

Using the PDL language to develop the metadata that accompanies a Blade or Part reduces developer productivity and code quality. It also negatively impacts the definition of the API for a blade or part by the following factors.
* It is burdensome for developers to manage an extra file authored in a different language, like PDL or XAML. 
* The API that is used to open Blades or pin Parts is not strongly-typed.  This can lead to run-time bugs when extensions update Blade or Part APIs or choose to display different ones.

By using the most recent edition of the Azure SDK, extension teams can develop Blades and Parts using **TypeScript** decorators as specified in [https://www.typescriptlang.org/docs/handbook/decorators.html](https://www.typescriptlang.org/docs/handbook/decorators.html), instead of PDL.  

Decorators allow you to define metadata in **TypeScript** while implementing the Blade or Part.  Also, the  API for a Blade or Part can be defined in terms of **TypeScript** interfaces, for example, for the Blade or Part's parameters.  With this, when **TypeScript** code is used to open the Blade or pin the Part, the **TypeScript** compiler validates calls to `openBlade(...)` or `PartPinner.pin(...)` and issues conventional **TypeScript** compilation errors.

PDL is still supported for backward compatibility, but **TypeScript** decorators are the recommended pattern for new Blades and Parts and migration of old PDL Blades and Parts.

The next few sections provide an overview on what decorators are and how to use them.

### Current **TypeScript** decorator support

All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install SDK samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\Extension\` folder.  

<!-- TODO: Determine whether the environment that is being described is Dogfood, or whether a different environment would be more appropriate. -->
First-party extension developers, i.e. Microsoft employees, can view the interfaces with jsdoc comments that are located at [https://msazure.visualstudio.com/One/_git/AzureUX-PortalFx?path=%2Fsrc%2FSDK%2FFramework.Client%2FTypeScript%2FFx%2FComposition&version=GBdev&_a=content](https://msazure.visualstudio.com/One/_git/AzureUX-PortalFx?path=%2Fsrc%2FSDK%2FFramework.Client%2FTypeScript%2FFx%2FComposition&version=GBdev&_a=content).

External partners may need to contact  [ibizafxpm@microsoft.com](mailto:ibizafxpm@microsoft.com) or [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com) instead of using the internal sites that are in this document. 

We will eventually export the jsdocs for the SDK to a public location.  That effort is in progress.
<!-- TODO: The effort that is in progress should not be included in the doc until there is an actuality that can be published.  -->

<!-- TODO: Validate this list against the existing files in the .ts directories. doc to ensure that none of them are missing. Are these the same interfaces in both places? -->

<!-- TODO:  Add this list to the new samples doc as appropriate. -->

The following SDK features can be built with **TypeScript** decorators. 

<details>
<summary>Blades</summary>

* **Template Blade**:  A Blade where you develop the Blade's content using an HTML template bound to properties on the Blade's **TypeScript** class
* **Menu Blade**:  A Blade that exposes menu items where each item opens a sub-Blade
* **Frame Blade**:  A Blade that provides you with an IFrame where you develop your Blade content as a conventional web page (or rehost an existing web page)
* **Blade**: A special case of Template Blade, where the Blade's UI uses only a single FX control (like Grid) and doesn't require an HTML template to apply styling or compose multiple FX controls.
</details>

<details>
<summary>Parts (a.k.a. Tiles)</summary>
- **Template Part** - Like Template Blade, you'll develop your Part's content using an HTML template
Parts (tiles)
- **Frame Part** - Like Frame Blade, you'll develop your Blade content as a conventional web page and the FX will render your Blade in an IFrame
- **Button Part** - A simple API that allows you develop standard Parts with title/subtitle/icon
- **Part** - Like 'Blade' above, this is a special case of Template Part for cases where a single FX control is used (like Chart, Grid).
</details>

These SDK features cannot yet be built with decorators:

* Unlocked blades:  Blades with tiles on them are not a recommended pattern for any experience. 
* The asset model:  Defines the asset types (usually ARM resources) in the extension
* Extension definition: A very small amount of PDL that provides general metadata about the extension

### Building a hello world template blade using decorators 

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to Dogfood copies of samples are included as appropriate. 

This section demonstrates how to create a "Hello World" template blade using decorators. The template blade is represented by a single TypeScript file in a Visual Studio project. The source code for the template blade is located at `<dir>/Client/V2/Blades/Template/SimpleTemplateBlade.ts` in the Azure samples. The working copy of the same source can be viewed at [simple Template Blade](https://df.onecloud.azure-test.net/?SamplesExtension=true#blade/SamplesExtension/TemplateBladesBlade/simpleTemplateBlade).

There are several options that can be specified as properties on the object that is sent to the decorator. The following code contains the simplest scenario where only an HTML template is needed.  The template is provided inline.

<!--TODO:  Determine where gitHub generates the samples from.  they do not appear to be in https://github.com/Azure/portaldocs/tree/dev/portal-sdk/samples -->

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V2/Blades/Template/SimpleTemplateBlade.ts", "section": "docs#HelloWorld"}

A relative path to an html file that contains the template can also be provided. In the following code, if the blade is in a file called `MyBlade.ts`, then a file named `MyBlade.html` can be added in the same directory; then, send  `./MyBladeName.html` to the htmlTemplate property of the decorator.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V2/Blades/Template/SimpleTemplateBlade.ts", "section": "docs#DecoratorReference"}

In addition, the TypeScript programming model requires a context property to be present in the  blade class. For more information about the context property, see [the context property](#the-context-property).  The context property is populated by the framework by default and contains APIs that can be called to interact with the shell. The following code describes the context property.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V2/Blades/Template/SimpleTemplateBlade.ts", "section": "docs#Context"}

For more information about building single page applications, and how to develop blades and parts for the Portal using **TypeScript** decorators, see the video located at  [https://aka.ms/portalfx/typescriptdecorators](https://aka.ms/portalfx/typescriptdecorators).

### The context property

The context property contains APIs that can be called to interact with the shell. It will be populated by the framework before the `onInitialize()` function is called.  It is not populated in a constructor.  In fact, it is recommended not to use a constructor and instead doing all initialization work in the onInitialize function. This is a fairly common [dependency injection technique](portalfx-extensions-glossary-typescript.md).

Declaring the type of this property can be a little tricky, and the declaration can change if more typeScript decorators are added to the  file.  This is because certain APIs on the context object get enhanced when new decorators are used.  Let's start with a basic example and build from there.

This is the simplest declaration of the context property, and it is included in the following code.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V2/Blades/Template/SimpleTemplateBlade.ts", "section": "docs#Context"}

The framework provided `TemplateBlade.Context` type takes in two generic parameters.

* The first parameter represents the type of object that represents the parameters to the blade.  This simple blade takes no parameters, hence the value of `void` for the first generic parameter.  
* The second generic parameter represents the type of the model data, which – today – must be the DataContext object for your Blade or Part. 

This makes the context property aware of your data context in a strongly typed way.

**NOTE**: In this example there is an API on the context called `context.container.closeCurrentBlade()`.  This function takes no parameters.

Now let's say this blade will be changed so that it returns data to its parent (i.e. the blade or part that opened it). First, add the `returns data` decorator. 

**NOTE**: Not all blades need this behavior, and it does come with the consequence that the child blade is not deep-linkable if it requires a parent blade. Use only as appropriate.

        @TemplateBlade.ReturnsData.Decorator()

That will cause a compiler error because that decorator changes the context in a way that must be declared.  The `closeCurrentBlade()` function that previously took no arguments now needs to accept the data to return to the parent blade. 

To fix the error, add `& TemplateBlade.ReturnsData.Context<{ value: string }>` to the declaration, as in the following example.

```
  public context: TemplateBlade.Context<void, BladesArea.DataContext> & TemplateBlade.ReturnsData.Context<{ value: string }>;
```

This uses **TypeScript** [intersection types](portalfx-extensions-glossary-typescript.md) to overload the `closeCurrentBlade` function to look like `closeCurrentBlade(data: { value: string })` so that when it is used, the compiler will enforce that data is provided to it in the following format. 

```
  context.container.closeCurrentBlade({
        value: "Data to return to parent blade"
    });
```

Intersection types combine the members of all types that get and'd together.

When the project is built, the compiler will also produce an auto generated blade reference file that gives the same level of type safety to the parent blade.  The following is code that the parent blade would have.  

**NOTE**: The callback that fires when `SimpleTemplateBlade` closes has the type information about the data being returned.

```
    context.container.openBlade(new BladeReferences.SimpleTemplateBlade((reason: BladeClosedReason, data: {value: string}) => {
            if (reason === BladeClosedReason.ChildClosedSelf) {
                const newValue = data && data.value ? data.value : noValue;
                this.previouslyReturnedValue(newValue);
            }
        }));
```

Each time an additional decorator is added, it should be incorporated into the context declaration as done here. 


### Building a menu blade using decorators

The following is an example of a menu blade built using decorators.  It uses the `@MenuBlade` decorator.  This decorator puts two constraints on the type.

1.  It requires  the public `viewModel` property.  The property is of type `MenuBlade.ViewModel2` and provides APIs to setup the menu.
1.  It requires the public 'context' property.  The property is of type `MenuBlade.Context`, as in the following code.

```ts
/// <reference path="../../../TypeReferences.d.ts" />

import BladesArea = require("../BladesArea");
import ClientResources = require("ClientResources");
import BladeReferences = require("../../../_generated/BladeReferences");
import MenuBlade = require("Fx/Composition/MenuBlade");

export = Main;

module Main {
    "use strict";

    @MenuBlade.Decorator()
    export class TemplateBladesBlade {
        public title = ClientResources.templateBladesBladeTitle;
        public subtitle = ClientResources.samples;

        public context: MenuBlade.Context<void, BladesArea.DataContext>;

        public viewModel: MenuBlade.ViewModel2;

        public onInitialize() {
            const { container } = this.context;

            this.viewModel = MenuBlade.ViewModel2.create(container, {
                groups: [
                    {
                        id: "default",
                        displayText: "",
                        items: [
                            {
                                id: "simpleTemplateBlade",
                                displayText: ClientResources.simpleTemplateBlade,
                                icon: null,
                                supplyBladeReference: () => {
                                    return new BladeReferences.SimpleTemplateBladeReference();
                                }
                            },
                            {
                                id: "templateBladeWithShield",
                                displayText: ClientResources.templateBladeWithShield,
                                icon: null,
                                supplyBladeReference: () => {
                                    return new BladeReferences.TemplateBladeWithShieldReference();
                                }
                            },
                            {
                                id: "templateBladeWithCommandBar",
                                displayText: ClientResources.templateBladeWithCommandBar,
                                icon: null,
                                supplyBladeReference: () => {
                                    return new BladeReferences.TemplateBladeWithCommandBarReference();
                                }
                            },
                            {
                                id: "templateBladeReceivingDataFromChildBlade",
                                displayText: ClientResources.templateBladeReceivingDataFromChildBlade,
                                icon: null,
                                supplyBladeReference: () => {
                                    return new BladeReferences.TemplateBladeReceivingDataFromChildBladeReference();
                                }
                            },
                            {
                                id: "templateBladeWithSettings",
                                displayText: ClientResources.templateBladeWithSettings,
                                icon: null,
                                supplyBladeReference: () => {
                                    return new BladeReferences.TemplateBladeWithSettingsReference();
                                }
                            },
                            {
                                id: "templateBladeInMenuBlade",
                                displayText: ClientResources.templateBladeInMenuBlade,
                                icon: null,
                                supplyBladeReference: () => {
                                    return new BladeReferences.TemplateBladeInMenuBladeReference();
                                }
                            },
                        ]
                    }
                ],
                defaultId: "simpleTemplateBlade"
            });

            return Q();  // This sample loads no data.
        }
    }
}
```

