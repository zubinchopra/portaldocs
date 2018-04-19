
## Opening blades 

This section describes how to open blades using container APIs and declarative APIs. A working copy of blades that open and close is located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi).

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

## Container APIs

It is recommended that extensions use the container APIs. Typically, each of these methods returns a `promise` that returns `true`.  If a blade on the screen contains  unsaved edits to a form, the Framework will issue a prompt that allows the user to keep the unsaved blade open.  If the user chooses to continue working on their unsaved edits, then the `promise` that is returned when the blade closes will return `false`.

### Strongly typed blade reference classes

A strongly typed blade reference class is auto-generated for each blade in the project when the extension is compiled.  For example, if the blade is named 'MyBlade', then a **TypeScript** class named  'MyBladeReference' will be generated in the `_generated` folder.  These blade reference classes are used to open blades programmatically. Blade references for `parameterProviders` have a different signature that is similar to the options that are provided to the `ParameterCollector` class.
 
In the following example, the `BladeReference` constructor accepts parameters and callback functions that allow the child blade to communicate with the parent blade. In this instance, the `BladeReference` that is instantiated represents a Website blade.

```javascript 
import { WebsiteBladeReference } from "../_generated/BladeReferences"; 
…
var bladeRef = new WebsiteBladeReference({
    parameters: { id: "_ARM_ID_HERE" }
});
```

Blade references are also generated for external extensions. The compiler creates a  `BladeReferences` module for every PDE file that is included.

Perform the following steps to open a blade from  a different extension.

1. Ensure the project references the external extension's PDE file. 

1. Import the blade reference from `../../_generated/<ExtensionName>/BladeReference`, as in the following example. 

    ```javascript
    import { LocationPickerV3BladeReference } from "../../_generated/HubsExtension/BladeReferences"
    ```

### Open blade methods

The following `openBlade` methods are now available on the template blade container.

<!-- TODO: Determine whether   openContextBlade exists on this object. -->

```javascript
    // opens a blade right now
    openBlade(bladeToOpen: BladeReference): Promise<boolean>; 
     
    // displays the blade placeholder right now, but shows a spinner until the given promise resolves
    openBladeAsync(promiseToDetermineBladeToOpen: Promise<BladeReference>): Promise<boolean>; 
     
    // opens a context blade right now
    openContextBlade(bladeToOpen: BladeReference): Promise<boolean>; 
     
    // displays the context blade placeholder right now, but shows a spinner until the given promise resolves
    openContextBladeAsync(promiseToDetermineBladeToOpen: Promise<BladeReference>): Promise<boolean>; 
```

### Opening blades within the menu

When the template blade is in the context of a menu blade, for example, when the template blade is the child of a menu blade, the following methods are available on the `menu` object within the PDL `container` object or the no-PDL `context` object. 

**NOTE**: If the blade is opened outside the context of a `MenuBlade`, then the `MenuBlade` will be null. If so, the extension should account for that by including the standard blade opening APIs.

```typescript
    /**
    * This method causes the menu blade to navigate to a different item
    *
    * @param id Identifier of the item to navigate too
    */
    switchItem(id: string): void;

    /**
    * Opens a child Blade in place.
    *
    * @param bladeToOpen A BladeReference describing the Blade to be opened.
    */
    openBlade(bladeToOpen: BladeReference): Promise<boolean>;

    /**
    * Opens a child Blade asynchronously in place.  While the Blade to be shown is being determined (via 'bladeReferencePromise') a loading
    * indicator will be displayed on the new child Blade.
    *
    * @param promiseToDetermineBladeToOpen A Promise that will be resolved with a BladeReference describing the Blade to be opened.
    */
    openBladeAsync(promiseToDetermineBladeToOpen: Promise<BladeReference>): Promise<boolean>;
```

Each of these methods returns a `promise` that typically returns `true`. If a blade on the screen contains unsaved edits to a form, the Framework will prompt the user, giving them the option to keep the unsaved blade open.  If the user chooses to continue working on their unsaved edits then the blade opening promise will return false.

For the asynchronhous methods, your code provides a `promise`.  If that `promise` fails or is rejected, then the promise returned from this API returns `false`.

### Click callbacks

In many cases, blade opening is the result of a user interaction, like a click.  Many Portal controls support click callbacks.  The blade opening APIs can be used within these callbacks.  If the control supports highlighting the item that was clicked, like the grid, then the highlight automatically will be added to the click target and cleared when the child blade closes.

The following examples open blades when controls are clicked.

* Button

    This control opens a blade when a button is clicked, as in the following example.

    ```javascript
    var button = new BasicButton.ViewModel({
        // … skipping over other button options
        onClick: () => {
            container.openBlade(new SomeBladeReference(…));
        }
    });
    ```

* Grid

    This control opens a blade when a row on a grid is clicked, as in the following example.

    ``` javascript 
    var grid= new Grid.ViewModel<Website, WebsiteId>({
        // … skipping over other grid options
        onRowClicked: (item: Website) => {
            container.openBlade(new SomeBladeReference(/* website id likely passed as an input here */));
        }
    });
    ```

* Custom HTML

    This control opens a blade when the user clicks on an **HTML** element that uses the `fxclick` **Knockout** data-binding, as in the following example.
    
    ```javascript
    // Your html template
    <a href="#" data-bind="fxClick: myOnClick">Click me!</a>
     
    // Your template blade or part view model
    public myOnClick(): void {
        container.openBlade(new SomeBladeReference(…));
    }
    ```

## Declarative APIs

It is not recommended that extensions use the declarative APIs to open and close blades.  Instead, they should use the APIs that are specified in the [container APIs](#container-apis) section.

### Basic blade actions 

The `<BladeAction>` tag provides the API required for opening a blade.  The only required information is the name of the blade to launch, as in the sample located at `<dir>\Client\extension.pdl`. In the following example, clicking on the part will launch the `SamplesExtensionBlade`.  

```xml
<Part Name="SamplesExtensionPart"
      PartKind="Button"
      ViewModel="{ViewModel Name=SamplesExtensionPartViewModel, Module=./ViewModels/SamplesViewModels}">
  <BladeAction Blade="SamplesExtensionBlade" />
</Part>
```

The same pattern can be used for commands, as in the sample located at `<dir>\Client\V1\Commands\OpenBladeCommand\OpenBladeCommand.pdl` and in the following example.

```xml
<Command Kind="Blade"
       Name="OpenBladeCommand"
       Text="{Resource openBladeCommandNone, Module=ClientResources}"
       ViewModel="{ViewModel Name=OpenBladeCommand, Module=./OpenBladeCommand/ViewModels/OpenBladeCommandViewModels}">
  <BladeAction Blade="NoParameterChildBlade" />
</Command>
```

**NOTE**: Typically, an extension sends information from the part or the command to the opened blade, which is not demonstrated in the previous code samples.

### Sending parameters with BladeInput 

Extensions, blades, and parts can send parameters to the blade that is being opened.  Typically, at least an {id} is sent to the blade by using a  `<BladeInput>` element.

In the following example, and in the sample located at 
`<dir>\Client\V1\Bindings\InputBindingsDifferentBlades\InputBindingsDifferentBlades.pdl`, the extension instructs the Portal to open the `InputBindingsDifferentBladesChildBlade` blade, while sending a parameter named `currentNumber` to the blade.  The `selectedItem` property of the `InputBindingsDifferentBladesParentPartViewModel` view model is the source of the parameter that is sent to the child blade. 

```xml
<CustomPart Name="ParentPart"
            ViewModel="{ViewModel Name=InputBindingsDifferentBladesParentPartViewModel, Module=./InputBindingsDifferentBlades/ViewModels/InputBindingsDifferentBladesViewModels}"
            Template="{Html Source='Templates\\Parent.html'}">

  <BladeAction Blade="InputBindingsDifferentBladesChildBlade">
    <BladeInput Parameter="currentNumber"
                Source="selectedItem" />
  </BladeAction>
</CustomPart>
```

The elements in the xml are as follows.
 
* **Blade**: The name of the blade to open

* **Parameter**: The name of the blade parameter that the parent blade will send to the `InputBindingsDifferentBladesChildBlade` child blade.

* **Source**: The public observable property on the `InputBindingsDifferentBladesParentPartViewModel` view model which contains the information to send to the new blade.

The remainder of the xml file specifies that the `selectedItem` property exists on the `ViewMmodel`.  The extension may use `content.*`, or it may use `container.*`, which allows binding to properties on the container object that is sent to the `ViewMmodel` constructor.

The `ViewModel` for the part that launches the blade specifies the `selectedItem` property that is used for the source, as in the sample located at `<dir>\Client\Bindings\InputBindingsDifferentBlades\ViewModels\InputBindingsDifferentBladesViewModels.ts` and in the following code.

```ts
/// <reference path="../../../TypeReferences.d.ts" />
import BindingsArea = require("../../BindingsArea");
import ClientResources = require("ClientResources");

export class InputBindingsDifferentBladesParentPartViewModel {

    /**
     * List of options provided in the template.
     */
    public availableOptions: any = [1, 2, 3, 4, 5];

    /**
     * The item selected from the other blade.
     */
    public selectedItem: KnockoutObservable<number> = ko.observable(1);

    /**
     * Part view model constructor.
     */
    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BindingsArea.DataContext) {
        container.partTitle(ClientResources.parentPart);

        this.selectedItem.subscribe((newValue) => {
            console.info(ClientResources.selectedItemChanged);
        });
    }
}
```

### Blade Parameters

Blades explicitly declare the parameters that they are required to receive, similar to a function signature. There are many types of parameters, each of which serves a specific purpose. In the section named [Sending parameters with BladeInput](#sending-parameters-with-bladeinput), a `<BladeInput>` specified a `Parameter` property that matches the name of a parameter on the launched blade.  For more information about blade parameters, see  [portalfx-blades-parameters.md](portalfx-blades-parameters.md).

In the sample located at `<dir>\Client\Bindings\InputBindingsDifferentBlades\InputBindingsDifferentBlades.pdl`, the parameters that are sent to a blade are ound to parts, commands, or the blade `ViewMmodel`.  The following code binds the blade parameters to various observables on the blade.

```xml
<Blade>
  ...
  <Blade.Parameters>

    <!--
      Typically a blade will have a key property (or set of key properties)
      that indicate uniqueness of the data within the blade.
     -->
    <Parameter Name="currentNumber" Type="Supplemental" />

  </Blade.Parameters>
</Blade>
```

 For more information about parameters and properties, see [portalfx-blades-properties.md](portalfx-blades-properties.md).

### Receiving data with BladeOutput 

An extension may return information from the current blade back to the parent blade. Blades can define a list of output properties that are sent to the calling blade.

In the following example, the parent blade defines a `BladeAction` element that sends a `currentNumber` property to the child blade. This allows changes in the child blade `ViewModel` to flow back to the parent blade `ViewModel`, as in the example located at `<dir>\Client\V1\Bindings\OutputBindings\OutputBindings.pdl` and in the following code.

```xml
<CustomPart Name="ParentPart"
            ViewModel="{ViewModel Name=OutputBindingsParentPartViewModel,
                                  Module=./OutputBindings/ViewModels/OutputBindingsViewModels}"
            Template="{Html Source='Templates\\Parent.html'}">

  <BladeAction Blade="OutputBindingsChildBlade">
    <BladeOutput Parameter="currentNumber"
                 Target="currentNumber" />
  </BladeAction>
</CustomPart>
```

In the preceding code, the `onInputsSet` method of the `OutputBindingsParentPartViewModel` will be invoked when the `currentNumber` blade parameter changes in the child blade. The following are the elements in the xml.

* **Parameter**: The name of the blade parameter that is sent to `OutputBindingsChildBlade`.

* **Target**: The name of the `inputs` parameter that is sent to the `onInputsSet` method of the `OutputBindingsParentPartViewModel` view model.

<!-- TODO:  Determine why this is a WACOM note, instead of a generic note.  Does this apply only to WACOM devices?-->

**WACOM.NOTE**: In some instances, the `onInputsSet` method of the part `ViewMmodel` is called multiple times for a specific `ViewModel`. It is invoked when the value of a blade output changes.  The `inputs` object contains or will contain the value of the output binding, which may not have been the first time that the `onInputsSet` method was invoked. 
 
For more information about blade outputs, see [portalfx-blades-outputs.md](portalfx-blades-outputs.md).

### Grids, CollectionParts, and ListViews 

Controls that are bound to a collection of elements, like the grid, can add subtlety to the selection model.  In most cases, the control will send blade inputs that are defined by a property on the model object bound to the control, as in the sample located at  `<dir>\Client\V1\MasterDetail\MasterDetailBrowse\MasterDetailBrowse.pdl` and in the following code.

```xml
<Part Name="MasterBrowseListPart"
      ViewModel="{ViewModel Name=BrowseMasterListViewModel, Module=./MasterDetailBrowse/ViewModels/MasterViewModels}"
      PartKind="Grid">
  <BladeAction Blade="BrowseDetailBlade">
    <BladeInput Parameter="currentItemId"
                Source="{SelectedItem Property=id}" />
  </BladeAction>
</Part>
```

The new twist in the syntax is `Source="{SelectedItem Property=id}`.  This identifies the `id` property on the model object that is bound to the grid.  The `id` property is available on the `Website` model object, as in the following code.  The grid only needs to declare itself as selectable.

```ts
private _websitesQueryView: MsPortalFx.Data.QueryView<SamplesExtension.DataModels.WebsiteModel, MasterDetailBrowseData.WebsiteQuery>;

...

var extensions = MsPortalFx.ViewModels.Controls.Lists.Grid.Extensions.SelectableRow,
    extensionsOptions = {
        selectableRow: {
            selectionMode: MsPortalFx.ViewModels.Controls.Lists.Grid.RowSelectionMode.Single,
            activateOnSelected: ko.observable<boolean>(true),
        }
    };

    super(this._websitesQueryView.items, extensions, <any>extensionsOptions);
```

### Supporting nested selectables 

A part can be selected by clicking the part, or by clicking on an item within the part.  The classic example of this interaction is the `CollectionPart` in the sample located at `<dir>\Client\V1\Parts\Intrinsic\CollectionPart\CollectionPartIntrinsicInstructions.pdl` and in the following example.

```xml
<Part Name="SelectableCollectionPartLarge"
      PartKind="Collection"
      ViewModel="{ViewModel Name=SelectableCollectionPartViewModel, Module=./Intrinsic/ViewModels/CollectionPartViewModel}">
  <BladeAction Blade="CollectionDetailsBlade">
    <BladeInput
        Parameter="title"
        Source="rollupCount" />
  </BladeAction>
  <BladeAction
      Blade="ItemDetailsBlade"
      SelectableSource="selectableData">
    <BladeInput
        Parameter="title"
        Source="{SelectedItem Property=ssnId}" />
  </BladeAction>
</Part>
```

This part contains two separate `<BladeAction>` elements.  The `CollectionDetailsBlade` launches when the part is clicked, and sends  only a parameter that is available from the `ViewMmodel`.  The `ItemDetailsBlade` is launched when clicking on a row in the `CollectionPart`.  The `SelectableSource` defines the direct path to the selectable object on the `CollectionPart` view model.

### Launching blades from another extension 

Typically, `<BladeAction>` is used to launch blades from inside an extension.  In some cases, an extension may import a part from another extension, as specified in [portalfx-extension-sharing-pde.md](portalfx-extension-sharing-pde.md).  Using this technique, the source of the shared part controls the launching of the blade.  However,  in some cases the current extension needs to launch a blade from another extension by using a part from inside the current extension. This is accomplished by using  `BladeReference`, as specified in [portalfx-extensibility-pde.md](portalfx-extensibility-pde.md).

#### Consuming the blade 

<!-- Determine where else the ResourceTypes.pdl file should be located.  At the present time, it only appears to be located in <dir>\Client\_generated\V2.
-->

To launch the blade referenced by the PDE file, use a `<BladeAction>`, and specify the extension as in the code located at `<dir>\Client\ResourceTypes\ResourceTypes.pdl` and in the following example.

```xml
<BladeAction Blade="{BladeReference ResourceMapBlade, extensionName=HubsExtension}">
  <BladeInput
      Source="assetOwner"
      Parameter="assetOwner" />
  <BladeInput
      Source="assetType"
      Parameter="assetType" />
  <BladeInput
      Source="assetId"
      Parameter="assetId" />
</BladeAction>
```

### The DynamicBladeAction method

In the preceding examples, the target blade to launch is known at design time.  In other instances, the blade to launch may not be known until runtime.  To specify the blade at runtime, use `<DynamicBladeAction>` as in the sample located at `<dir>\SamplesExtension\Extension\Client\V1\Blades\DynamicBlade\DynamicBlade.pdl`. This method can also be used to launch a blade from another extension, using the `extension` property of `DynamicBladeSelection`. The  `DynamicBladeAction` is in the following example.

```xml
<CustomPart Name="DynamicBladePart"
            ViewModel="{ViewModel Name=DynamicBladePartViewModel, Module=./DynamicBlade/ViewModels/DynamicBladePartViewModel}"
            Template="{Html Source='..\\..\\Common\\Templates\\PartWithTitle.html'}"
            InitialSize="Small">
  <DynamicBladeAction SelectableSource="container.selectable.value" />
</CustomPart>
```

The  `DynamicBladeAction` element asks for the path to a `selectable` object, instead of a target blade.  Selectables are an advanced aspect of the API, which is typically abstracted for the developer.  In this case, the selectable that belongs to the entire part is targeted, instead of selectables that belong to specific control view models.

The view model specifies the blade to launch at runtime.  When the state of the part changes, the `selectedValue` property of the selectable can be modified to accept a `DynamicBladeSelection` object, as in the code located at `<dir>\Client\Navigation\DynamicBlades\ViewModels\DynamicBladesViewModels.ts` and in the following example.

```ts
import ExtensionDefinition = require("../../../_generated/ExtensionDefinition");

...

this._container.selectable.selectedValue(<MsPortalFx.ViewModels.DynamicBladeSelection>{
    detailBlade: ExtensionDefinition.BladeNames.bladeName,
    detailBladeInputs: {
        // If your blade expects inputs (these do not), you could pass the inputs here.
    }
});
```

The code in the preceding example can be executed any time the target blade will change.  This does not trigger the launching of the blade. Just change the blade to launch when the user clicks on the part, command, or hotspot.  The `ExtensionDefinition.BladeNames` object contains a strongly typed list of available blades in the extension.

**WACOM.NOTE**: Static definitions allow for better compile-time checking of names and inputs. Consequently, dynamic blade selection should be avoided, unless there is a strict requirement for determining the blade at runtime. Also, blade outputs are not supported when using dynamic blade selection.

### Hotspots

<!--TODO:  Determine whether there is a discrepancy between the literal html and the SDK sample.  The html has changed slightly.  It is named `CollectorAsHotSpot.html` instead, and uses the hotSpotViewModel property instead of the hotSpotSelectable property.
-->

When building custom parts as specified in [portalfx-parts-overview.md#custom-parts](portalfx-parts-overview.md#custom-parts), you may want to launch a blade from a div, button, or an anchor  tag. To launch a blade, start with a `pcHotSpot` binding in your HTML template, as in the sample located at `<dir>\Client\V1\ParameterCollection\CollectorAsHotSpot\Templates\CompositePart.html`.

```html
<div data-bind="pcHotSpot: hotSpotSelectable">
  Click me [<span data-bind='text: hotSpotValue'></span>]GB
</div>
```

The `hotSpotSelectable` property is a public property on the part `ViewModel` of type `MsPortalFx.ViewModels.Selectable<boolean>`, as in the sample located at `<dir>\Client\V1\ParameterCollection\CollectorAsHotSpot\ViewModels\CompositePartHotSpotViewModel.ts` and in the following example.

```ts
/**
 * Selectable for the hot spot.
 */
public hotSpotSelectable: MsPortalFx.ViewModels.Selectable<boolean>;

constructor(container: MsPortalFx.ViewModels.PartContainerContract,
            initialState: any,
            dataContext: ParameterCollectionArea.DataContext) {

    // Initialize the alphaSelectable
    this.hotSpotSelectable = new MsPortalFx.ViewModels.Selectable<boolean>({
        isSelected: !!(initialState && initialState.alphaSelectable && initialState.alphaSelectable.isSelected),
        selectedValue: !!(initialState && initialState.alphaSelectable && initialState.alphaSelectable.isSelected)
    });
}
```

The selectable object is referenced from the PDL. This connects the blade action to the selectable, as in the sample located at `<dir>\Client\ParameterCollection\ParameterCollection.pdl` and in the following code.

```xml
<BladeAction Blade="ParameterProviderFormBlade" SelectableSource="hotSpotSelectable" />
```

### Advanced selection 

There are scenarios where the list of selectable items is not known previous to using the extension.  Typically, the extension can point at a single selectble control or selectable set control.  However, the following cases are more problematic.

* A grid that contains other grids

* A grid with hotspots inside of it

* A List view with tree views

In these instances, the extension may need to inform the shell of other controls that are not known at design time. Controls like hotspots, grids, or buttons are generated dynamically.  The same API can be applied to grids, list views, buttons, or any control that exposes a selectable or selectableSet object. For example, the code located at 
`<dir>\Client\Bindings\DynamicSelectableRegistration\Templates\DynamicHotSpots.html` contains  hotspot objects that  support selection, as in the following example.

```html
<div data-bind="foreach: hotspots">
    <div data-bind="pcHotSpot: selectable">
        <span data-bind="text: label"></span>
    </div>
</div>
```

For each hotspot in the previous code, the Shell needs to know which blade to launch.  This is accomplished by using the `container.registerSelectable` API as in the sample located at `<dir>\Client\Bindings\DynamicSelectableRegistration\ViewModels\DynamicHotspots.ts` and in the following code.

```ts
var lifetime = this._container.createChildLifetime(),
    selectable = MsPortalFx.ViewModels.Part.createSelectableViewModel(),
    id = SelectableIdPrefix + this.hotspots().length,
    label = "Hotspot #" + (this.hotspots().length + 1);

// a registered selectable requires unique id.
// the id is used to save and restore the selectable state when the journey is restored
this._container.registerSelectable(lifetime, id, selectable);

// set the blade selector which describes which blade we want to open when this hotspot is clicked
selectable.selectedValue(<MsPortalFx.ViewModels.DynamicBladeSelection>{
    detailBlade: ExtensionDefinition.BladeNames.hotspotChildBlade,
    detailBladeInputs: {
        HotspotId: label
    }
});

// finally add it to our list of hotspots that is displayed
this.hotspots.push({
    label: label,
    selectable: selectable,
    lifetime: lifetime
});
```


## Closing blades programmatically


Code that closes the current blade can be called from either a blade or part container. The extension can optionally return untyped data to the parent blade when the child blade is  closed.

The blade opening sample is located at [http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKMenuBlade/openbladeapi). The 'Close' button on the child blades that open is implemented using the blade closing APIs.

The following methods are now available on the  template blade container.

```typescript

import { Container as BladeContainer } from "Fx/Composition/Blade";
   
// closes the current blade now, optionally passing data back to the parent
closeCurrentBlade(data?: any): Promise<boolean>; 
// closes the current child blade now, if one is present
closeChildBlade(): Promise<boolean>; 
// closes the current child context blade now, if one is present
closeContextBlade(): Promise<boolean>; 
```

The following methods are  available on the  part container contract.

```typescript
// closes the current child blade now, if one is present
closeChildBlade(): Promise<boolean>; 
// closes the current child context blade now, if one is present
closeContextBlade(): Promise<boolean>; 
```

Each of these methods returns a `promise` that typically returns `true`.  If a blade on the screen contains  unsaved edits to a form, the Framework will issue a prompt that allows the user to keep the unsaved blade open.  If the user chooses to continue working on their unsaved edits, then the `promise` that is returned when the blade closes will return `false`.

## Responding to blade closing

When an extension opens a child blade, it can register the optional `onClosed` callback to be notified when the child blade closes.  The child blade can send untyped data that can be used in the  callback, as in the following example.
 
```typescript
import { BladeClosedReason } from "Fx/Composition";
...
container.openBlade(new SomeBladeReference({ … }, (reason: BladeClosedReason, data?: any) => {
        // Code that runs when the blade closes - Data will only be there if the child blade returned it.
        // It  lets you differentiate between things like the user closing the blade via the close button vs. a parent blade programatically closing it
});
```

