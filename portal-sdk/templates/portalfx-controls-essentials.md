## Essentials control

The essentials control is used for displaying resource information with multiple properties.
It has the flexibility to customize the layout of properties in a column, to display properties for non-ARM resources, and to responsively redistribute properties into one column or more than three columns, depending on the width of the blade that contains it, as in the following example.

![alt-text](../media/portalfx-controls/essentials.png "Essentials")

The first five items in the left pane of the essentials are obtained by calling Azure Resource Manager APIs with the specified resource id.
More items can be specified in the constructor, or can be added dynamically in both the left and right panes.

When there are more than five items in any pane, only the first five items in each pane are displayed. The rest of the items are revealed when the **See more** link is clicked.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

The essentials control is basically divided into the following three categories.

* [Options](#options)

* [Types](#types)

* [Features](#features)

### Options

There are three types of options in the `Essentials` control: the default, the custom, and the non-resource options. They all allow an extension to control the behavior of the `Essentials` control by using initialization options and provided feature functions. They are all used in approximately the same way, although the instructions for use differ slightly by the type of option that is being developed.

To use the appropriate `Essentials` control, the extension can include it in an HTML template by using a `pcControl` binding. The extension should also import the module to use the `Essentials` control. Then, the developer should set up the `Settings` interface in the extension to persist the `expanded` property that contains the state of the control, and include a `Decorator` object in the code to set the `TemplateBlade` and provide access to the blade settings. 

After that, the extension should use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel.

Lastly, the extennsion defines the `_initializeControl` method that initializes the control.

#### Default Layout

The defaults are the most common use case.  The  default `Essentials` control is in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`. This code is also included in the following example. To use the default `Essentials` control, compose a template blade that contains it.

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsDefaultBlade.ts","section":"essentials#setupBladeDefault"}

1. Set up the `Settings` interface. 

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel, as in the following example.

    {"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsDefaultBlade.ts","section":"essentials#startBladeDefault"}

1. Define the `_initializeControl` method that initializes the control, as in the following example.

    {"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsDefaultBlade.ts","section":"essentials#startBladeDefault"}

#### Custom Layout

The custom layout allows the extension to change freely the layout order of built-in and other properties.  The `Essentials` control is in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsCustomLayoutBlade.ts`. This code is also included in the following example. To use the custom layout `essentials` control, compose a template blade that contains it.

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsCustomLayoutBlade.ts","section":"essentials#setupBladeCustomLayout"} 

1. Set up the `Settings` interface to persist the `expanded` property that contains the state of the `Essentials` control.  

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel, as in the following example.

    {"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsCustomLayoutBlade.ts","section":"essentials#startBladeCustomLayout"} 

1. Define the `_initializeControl` that initializes the control, as in the following example.

    {"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsCustomLayoutBlade.ts","section":"essentials#initControlCustomLayout"}

#### Non-Resource Layout

Non-resource essentials allow an extension to use the `Essentials` control without a resource id. It can change layout orders of all properties freely. To use the non-resource `essentials` control, compose a template blade that contains it.  The non-resource `Essentials` control is in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsNonResourceBlade.ts`. This code is also included in the following example. 

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsNonResourceBlade.ts","section":"essentials#setupBladeNonResource"} 

1. Set up the `Settings` interface. 

    {"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsNonResourceBlade.ts","section":"essentials#setupBladeNonResource"} 

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel, as in the following example.

    {"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsNonResourceBlade.ts","section":"essentials#startBladeNonResource"} 

1. Define the `_initializeControl` that initializes the control, as in the following example.

    {"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsNonResourceBlade.ts","section":"essentials#initControlNonResource"} 

### Types

### Properties

<!-- TODO: Determine whether this section should be more verbose, and if so, what the descriptive content should be. -->

#### Built-In Properties
 
Built-In properties those can be obtained from resource data, as in the following code.

```typescript
/**
 * Built-In properties those can be obtained from resource data.
 */
const enum BuiltInType {
    /**
     * Built-in resource group property.
     */
    ResourceGroup = 1,

    /**
     * Built-in status property.
     */
    Status,

    /**
     * Built-in location property.
     */
    Location,

    /**
     * Built-in subscription name property.
     */
    SubscriptionName,

    /**
     * Built-in subscription id property.
     */
    SubscriptionId
}
```

#### Other Properties

##### Text
```typescript
{
    label: "Sample Label",
    value: "Sample Value"
}
```

##### Link
```typescript
{
    lable: "Sample Label",
    value: "Bing.com",
    onClick: new ClickableLink(ko.observable("http://www.bing.com"))
}
```

##### CustomLink
```typescript
{
    label: "Sample Label",
    value: "Click to do something",
    onClick: () => {
        something();
    }
}
```

### Items

  A label with a property
```typescript
{
	label: "Sample Label",
    value: "Sample Value"
}
```

#### Multi-line Item

A label with multiple properties

```typescript
{
    label: "Sample Label",
    lines: [
    	{
            value: "text only"
        },
        {
            value: "Bing.com",
            onClick: new ClickableLink(ko.observable("http://www.bing.com"))
        }
    ]
}
```
### Features


#### Callbacks

Resource blade `open` and `close` callback functions are provided and can be used for logging telemetry or other needed tasks.

**NOTE**: This feature is not available in `NonResource` essentials.

The `Essentials` control is in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`. This code is also included in the following example.

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsDefaultBlade.ts","section":"essentials#bladeCallbacks"}

#### Dynamic Properties

In the following code, the sample **AJAX** response contains four properties. The first two items are dynamically added to the left pane, and the last two  items are added to the right pane, as in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`. 

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsDefaultBlade.ts","section":"essentials#addDynamicProps"} 


#### Responsive Columns

In the following code, the optional `boolean` property named `responsiveColumns` can be set to `true` to use the responsive columns feature. The sample is located at `<dir>\Client\V2\Controls\Essentials\EssentialsResponsiveBlade.ts`. The blade whose property is set to `Small` contains a single column, and full screen will contain several columns depending on the width of the blade. This code is also included in the following example.

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsResponsiveBlade.ts","section":"essentials#responsive"} 