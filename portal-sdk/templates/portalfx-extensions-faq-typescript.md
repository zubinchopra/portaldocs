
## Frequently asked questions

<!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->

### How do I know what properties/methods to add to my Blade or Part class?

***How do I know what properties/methods to add to my Blade or Part class?***

I'm used to my **TypeScript** class inheriting an interface.

SOLUTION: The short answer here is that:
- Yes, interface types exist for every **TypeScript** decorator. For every decorator (@TemplateBlade.Decorator, for instance), there is a corresponding interface type that applies to the Blade/Part class (for instance, TemplateBlade.Contract).  

- No, it is **not necessary** to follow this extra step of having your Blade/Part class inherit an interface.  

***To the larger question now, if it's unnecessary to inherit the 'Contract' interface in my Blade/Part class, how is this workable in practice?  How do I know what properties to add to my class and what their typing should be?***

SOLUTION: Here, the 'Contract' interface is applied *implicitly* as part of the implementation of the Blade/Part **TypeScript** decorator.  

So, once you've applied a **TypeScript** decorator to your Blade/Part class, **TypeScript** **Intellisense** and compiler errors should inform you what is missing from your Blade/Part class.  By hovering the mouse over **Intellisense** errors in your IDE, you can act on each of the **TypeScript** errors to:
- add a missing property  
- determine the property's type or the return type of your added method.

If you iteratively refine your class based on **Intellisense** errors, once these are gone, you should be able to compile and run your new Blade / Part.  This technique is demonstrated in the intro located at [https://aka.ms/portalfx/typescriptdecorators](https://aka.ms/portalfx/typescriptdecorators).

* * * 

### How do I know what types to return from the `onInitialize` method?  

SOLUTION: If a 'return' statement is not used in the  `onInitialize` method, or any other method required by the  choice of **TypeScript** decorator, **Intellisense** errors will reflect the expected return type for the method:

```
public onInitialize() {
    // No return statement
}
...
```

### Why can't I return my data-loading Promise directly from 'onInitialize'?

SOLUTION: Extensions will see compile errors when then attempt to return from `onInitialize` the result of a call to `queryView.fetch(...)`, `entityView.fetch(...)`, `Base.Net.ajax2(...)`, as in the following code.

```
public onInitialize() {
    public { container, model, parameters } = this.context;
    public view = model.websites.createView(container);

    // Returns MsPortalFx.Base.PromiseV and not the required Q.Promise<any>.
    return view.fetch(parameters.websiteId).then(...);
}
```

Here, our FX data-loading APIs return an old `MsPortalFx.Base.PromiseV` type that is not compatible with the `Q.Promise` type expected for `onInitialize`.  To workaround this shortcoming of the FX data-loading APIs, until these APIs are revised you'll do:  
```
    ...
    return Q(view.fetch(...)).then(...);
    ...
```
This application of `Q(...)` simply coerces your data-loading Promise into the return type expected for `onInitialize`.  

* * * 

#### I don't understand the **TypeScript** compilation errors that is occuring around my TypeScript Blade/Part.  And there are lots of them.  What should I do?  

SOLUTION: Typically, around  **TypeScript** Blades and Parts (and even PDL-defined Blades/Parts), only the first 1-5 compilation errors are easily understandable and actionable.  

Here, the best practice is to:  
- **Focus on** errors in your Blade/Part **TypeScript** (and in PDL for old Blades/Parts)
- **Ignore** errors in **TypeScript** files in your extension's '_generated' directory
- Until compile errors in your Blade/Part named 'Foo' are fixed, **ignore** errors around uses of the corresponding, code-generated FooBladeReference/FooPartReference in `openBlade(...)` and `PartPinner.pin(...)`.
    - This is because errors in the 'Foo' Blade/Part will cause *no code* to be generated for 'Foo'.  

Some snags to be aware of:

* Read all lines of multi-line **TypeScript** errors.

    **TypeScript** errors are frequently multi-line.  If you compile from your IDE, often only the first line of each error is shown and the first line is often not useful, as in the following example.

  ```
  Argument of type 'typeof TestTemplateBlade' is not assignable to parameter of type 'TemplateBladeClass'.
  Type 'TestTemplateBlade' is not assignable to type 'Contract<any, any>'.
    Types of property `onInitialize` are incompatible.
      Type '() => void' is not assignable to type '() => Promise<any>'.
        Type 'void' is not assignable to type 'Promise<any>'.
  ```

  Be sure to look at the entire error, focusing on the last lines of the multi-line message.

* Don't suppress compiler warnings.

    Azure compilation of **TypeScript** decorators often generates build *warnings* that are specific and more actionable than **TypeScript** errors.  To easily understand warnings/errors and turn these into code fixes, be sure to read *all compiler warnings*, which some IDEs / command-line builds are configured to suppress.

* * * 

### How do I add an icon to my Blade?  

Developers coming from PDL will be used to customizing their Blade's icon like the following example.
```
this.icon(MsPortalFx.Base.Images.Logos.MicrosoftSquares());  
```
With TypeScript decorators, developers are confused as to why this methodology cannot be used.  The answer is that only Blades associated with a resource/asset can show a Blade icon, by Ibiza UX design.  To make this more obvious at the API level, the only place to associate an icon for a Blade is on `<AssetType>`.

The new methodology to add an icon to a TypeScript Blade is as follows.
1. Associate the icon with your `<AssetType>`
```
<AssetType
    Name='Carrots'
    Icon='MsPortalFx.Base.Images.Logos.MicrosoftSquares()'
    ...
```
1. Associate your no-PDL Blade with your AssetType
```
import { AssetTypes, AssetTypeNames } from "../_generated/ExtensionDefinition";

@TemplateBlade.Decorator({
    forAsset: {
        assetType: AssetTypeNames.customer,
        assetIdParameter: "carrotId"
    }
})
export class Carrot {
    ...
}
```
Now, why is this so?  It seems easier to do this in a single-step at the Blade-level. 

* * * 

### How do I control the loading indicators for my Blade?  How is it different than PDL Blades?  

SOLUTION: 
[Controlling the loading indicator](portalfx-parts-revealContent.md) in Blades/Parts is the almost exactly the same for PDL and no-PDL Blades/Parts.  That is:  
- An opaque loading indicator is shown as soon as the Blade/Part is displayed
- The FX calls `onInitialize` (no-PDL) or `onInputsSet` (PDL) so the extension can render its Blade/Part UI
- (Optionally) the extension can all `revealContent(...)` to show its UI, at which point a transparent/translucent loading indicator ("marching ants" at the top of Blade/Part) replaces the opaque loading indicator
- The extension resolves the Promise returned from `onInitialize` / `onInputsSet` and all loading indicators are removed.

The only difference with no-PDL here is that `onInitialize` replaces `onInputsSet` as the entrypoint for Blade/Part initialization.  

For no-PDL, this is demonstrated in the sample [here](https://df.onecloud.azure-test.net/#blade/SamplesExtension/TemplateBladeWithSettings).

If yours is a scenario where your Blade/Part should show the loading indicators in response to some user interaction (like clicking 'Save' or 'Refresh'), read on...

#### When should I use the 'operations' API to control the Blade/Part's loading indicator?  

SOLUTION: 
There are scenarios like 'User clicks "Save" on my Blade/Part' where the extension wants to show loading indicators at the Blade/Part level.  What's distinct about this scenario is that the Blade/Part has already completed its initialization and, now, the user is interacting with the Blade/Part UI.  This is precisely the kind of scenario for the 'operations' API.  

For no-PDL Blades/Parts, the 'operations' API is `this.context.container.operations`, and the API's use is described [here](portalfx-extensions-blades-advanced.md#displaying-a-loading-indicator-UX ).  There is a sample to consult [here](https://df.onecloud.azure-test.net/#blade/SamplesExtension/TemplateBladeWithSettings).

* * * 

### How can I save some state for my no-PDL Blade?  

There is a decorator - @TemplateBlade.Configurable.Decorator for example, available on all Blade variations - that adds a `this.context.configuration` API that can be used to load/save Blade "settings".  See a sample [here](https://df.onecloud.azure-test.net/#blade/SamplesExtension/TemplateBladeWithSettings).

**WARNING** - We've recently identified this API as a source of Portal perf problems.  In the near future, the Ibiza team will break this API and replace it with an API that is functionally equivalent (and better performing). 

* * *