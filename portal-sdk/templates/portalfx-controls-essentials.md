## Essentials control

The essentials control is used for displaying resource information with multiple properties.
It has the flexibility to customize the layout of properties in a column, to display properties for non-ARM resources, and to responsively redistribute properties into one column or more than three columns, depending on the width of the blade that contains it, as in the following example.

![alt-text](../media/portalfx-controls/essentials.png "Essentials" )

The first five items in the left pane of the essentials are obtained by calling Azure Resource Manager APIs with the specified resource id.
More items can be specified in the constructor, or can be added dynamically in both the left and right panes.

When there are more than five items in any pane, only the first five items in each pane are displayed. The rest of the items are revealed when **See more** is clicked.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

### Options
- [Default Layout](#default-layout) 
- [Non-Resource](#nonResourceEssentials)


### Types
- [Properties](#essentialsProperties)
- [Items](#essentialsItems)

### Features
- [Resource Blade Open/Close Callbacks](#essentialsCallbacks)
- [Add Dynamic Properties](#essentialsDynamicProps)
- [Responsive Columns](#responsiveEssentials)


<a name="essentialsProperties"></a>
### Types

#### Types of Properties

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
#### Built-In Properties

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
<br>
<a name="essentialsItems"></a>
### Type of Items
#### Item
  A label with a property
```typescript
{
	label: "Sample Label",
    value: "Sample Value"
}
```

#### Multi-line Item
A label with multiple [properties](#essentialsProperties)
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

### Options

#### Default Layout

The defaults are the most common use case. The extension will control the behavior of the `Essentials` control by using initialization options and provided feature functions.

To use the `Essentials` control, compose a template blade that contains it. The  `Essentials` control can be included in an HTML template by using a 'pcControl' binding, as in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`. This code is also included in the following example.

<!-- 
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsDefaultBlade.ts","section":"essentials#setupBladeDefault"}  -->
<!-- TODO: Determine how to include the samples in gitHub. Otherwise, the reader can use the annotated code that was shipped with the SDK.  It contains all of the bookmarks for the snippets  -->

1. The `Essentials`  control is used by importing the module. Setup the `Settings` interface to persist the `expanded` property that contains the state of the `Essentials` control. Include a `Decorator` object that sets the `TemplateBlade` and provide access to the blade settings. 

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings, create the ViewModel, and initialize the `Essentials` control.

    <!--
    {"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsDefaultBlade.ts","section":"essentials#startBladeDefault"} -->

1. Define the `_initializeControl` method that initializes the essentials control.

#### Custom Layout

The custom layout allows the extension to change layout orders of built-in properties and any other properties freely.

To use the `essentials` control, compose a template blade that contains the essentials control, then use it from the extension. The sample is located at `<dir>\Client\V2\Controls\Essentials\EssentialsCustomLayoutBlade.ts`. This code is also included in the following example.

<!--
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsCustomLayoutBlade.ts","section":"essentials#setupBladeCustomLayout"} -->

You can control the behavior of the essentials via initialization [options](#options) and provided [feature](#features) functions.

1.  Setup `Settings` interface for preserving `expanded` state for Essentials. `Decorator`s for set `TemplateBlade` and access to the blade settings.

`\Client\V2\Controls\Essentials\EssentialsCustomLayoutBlade.ts`


1. Configurations for Read/Write `expanded` state in the blade settings and initialize the essentials control.

`\Client\V2\Controls\Essentials\EssentialsCustomLayoutBlade.ts`

<!--
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsCustomLayoutBlade.ts","section":"essentials#startBladeCustomLayout"}  -->

1. Define the `_initializeControl` that initializes the essentials control.

`\Client\V2\Controls\Essentials\EssentialsCustomLayoutBlade.ts`

<!--
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsCustomLayoutBlade.ts","section":"essentials#initControlCustomLayout"} -->

<a name="nonResourceEssentials"></a>
#### Non-Resource

To use the essentials, compose a template blade that hosts the essentials control, then use it from your extension.

Non-resource essentials allows you to use the essentials without a resource id. You change layout orders of all properties freely.

You can control the behavior of the essentials via initialization [options](#options) and provided [feature](#features) functions.

**Step 1**: Setup `Settings` interface for preserving `expanded` state for Essentials. `Decorator`s for set `TemplateBlade` and access to the blade settings.

`\Client\V2\Controls\Essentials\EssentialsNonResourceBlade.ts`

<!--
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsNonResourceBlade.ts","section":"essentials#setupBladeNonResource"} -->

**Step 2**: Configurations for Read/Write `expanded` state in the blade settings and initialize the essentials control.

`\Client\V2\Controls\Essentials\EssentialsNonResourceBlade.ts`

<!--
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsNonResourceBlade.ts","section":"essentials#startBladeNonResource"} -->

**Step 3**: Define the `_initializeControl` that initializes the essentials control.

`\Client\V2\Controls\Essentials\EssentialsNonResourceBlade.ts`

<!--
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsNonResourceBlade.ts","section":"essentials#initControlNonResource"} -->

### Features

<a name="essentialsCallbacks"></a>
#### Resource Blade Open/Close Callbacks

Resource blade open/close callback functions are provided and can be used for logging telemetry or some other needed tasks.

Note that this feature is not available in `NonResource` essentials.

`\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`

<!--
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsDefaultBlade.ts","section":"essentials#bladeCallbacks"} -->

<a name="essentialsDynamicProps"></a>
#### Add Dynamic Properties

`\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`

<!--
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsDefaultBlade.ts","section":"essentials#addDynamicProps"} -->

As the above code shows, the sample AJAX response contains 4 properties. First 2 items are added to left pane and last 2 items are added to right pane.

<a name="responsiveEssentials"></a>
#### Responsive Columns

`\Client\V2\Controls\Essentials\EssentialsResponsiveBlade.ts`

<!--
{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V2/Controls/Essentials/EssentialsResponsiveBlade.ts","section":"essentials#responsive"} -->

The optional `boolean` property `responsiveColumns` can be specified to `true` to use responsive columns feature.

`Small` sized blade will contain single column and full screen will contain multiple number of columns depends on the blade's width.