<a name="essentials-control"></a>
## Essentials control

The essentials control is used for showing resource information with multiple properties.
First 5 items in left pane of the essentials are obtained by calling Azure Resource Manager APIs with given resource id.
More items can be specified in constructor or can be added dynamically later in both left and right panes.
It has flexibility to customize layout and showing items without resource id.
When there are more than 5 items in any panes, only first 5 items in each panes will be shown and rest of the items can be revealed when **View All** is clicked.

![Essentials][essentials-sample]

<a name="essentialsOptions"></a>
<a name="essentials-control-options"></a>
### Options
- [Default](#defaultEssentials) (Most common use case)
- [Custom Layout](#customLayoutEssentials)
- [Non-Resource](#nonResourceEssentials)

<a name="essentialsTypes"></a>
<a name="essentials-control-types"></a>
### Types
- [Properties](#essentialsProperties)
- [Items](#essentialsItems)

<a name="essentialsFeatures"></a>
<a name="essentials-control-features"></a>
### Features
- [Resource Blade Open/Close Callbacks](#essentialsCallbacks)
- [Add Dynamic Properties](#essentialsDynamicProps)

<br><br>

---

<br>

<a name="essentialsProperties"></a>
<a name="essentials-control-types"></a>
### Types

<a name="essentials-control-types-type-of-properties"></a>
#### Type of Properties

<a name="essentials-control-types-type-of-properties-text"></a>
##### Text
```typescript
{
    label: "Sample Label",
    value: "Sample Value"
}
```
<a name="essentials-control-types-type-of-properties-link"></a>
##### Link
```typescript
{
    lable: "Sample Label",
    value: "Bing.com",
    onClick: new ClickableLink(ko.observable("http://www.bing.com"))
}
```
<a name="essentials-control-types-type-of-properties-customlink"></a>
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

<a name="essentials-control-types-type-of-properties-built-in-builtinproperties"></a>
##### <a href="#builtInProperties">Built-In</a>
<br>
<a name="builtInProperties"></a>
<a name="essentials-control-types-built-in-properties"></a>
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
<a name="essentials-control-type-of-items"></a>
### Type of Items
<a name="essentials-control-type-of-items-item"></a>
#### Item
  A label with a property
```typescript
{
	label: "Sample Label",
    value: "Sample Value"
}
```

<a name="essentials-control-type-of-items-multi-line-item"></a>
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

<a name="essentials-control-options"></a>
### Options
<a name="defaultEssentials"></a>
<a name="essentials-control-options-default"></a>
#### Default

To use the essentials, compose a template blade that hosts the essentials control, then use it from your extension.

You can control the behavior of the essentials via initialization [options](#essentialsOptions) and provided [feature](#essentialsFeatures) functions.

**Step 1**: Define the Html template for your part:

`\Client\V1\Controls\Essentials\Templates\Essentials.html`

**Step 2**: Create a viewmodel to bind your control to `DefaultEssentialsViewModel` implements the viewmodel for the editor.

`\Client\V1\Controls\Essentials\ViewModels\DefaultEssentialsViewModel.ts.`

code sample coming soon to SamplesExtension in D:\ws\Ship-Sync-AuxDocs-Github\doc\portal-sdk\Samples\SamplesExtension\Extension\Client\V1\Controls\Essentials\ViewModels\DefaultEssentialsViewModel.ts

**Step 3**: Now you can consume your part from an extension by referencing it in the PDL:

`\Client\V1\Controls\Essentials\Essentials.pdl`

code sample coming soon to SamplesExtension in D:\ws\Ship-Sync-AuxDocs-Github\doc\portal-sdk\Samples\SamplesExtension\Extension\Client\V1\Controls\Essentials\Essentials.pdl

<a name="customLayoutEssentials"></a>
<a name="essentials-control-options-custom-layout"></a>
#### Custom Layout

To use the essentials, compose a template blade that hosts the essentials control, then use it from your extension.

Custom layout essentials allows you to change layout orders of built-in properties and any other properties freely.

You can control the behavior of the essentials via initialization [options](#essentialsOptions) and provided [feature](#essentialsFeatures) functions.

**Step 1**: Define the Html template for your part:

`\Client\V1\Controls\Essentials\Templates\Essentials.html`

**Step 2**: Create a viewmodel to bind your control to `CustomLayoutEssentialsViewModel` implements the viewmodel for the editor.

`\Client\V1\Controls\Essentials\ViewModels\CustomLayoutEssentialsViewModel.ts.`

code sample coming soon to SamplesExtension in D:\ws\Ship-Sync-AuxDocs-Github\doc\portal-sdk\Samples\SamplesExtension\Extension\Client\V1\Controls\Essentials\ViewModels\CustomLayoutEssentialsViewModel.ts

**Step 3**: Now you can consume your part from an extension by referencing it in the PDL:

`\Client\V1\Controls\Essentials\Essentials.pdl`

code sample coming soon to SamplesExtension in D:\ws\Ship-Sync-AuxDocs-Github\doc\portal-sdk\Samples\SamplesExtension\Extension\Client\V1\Controls\Essentials\Essentials.pdl

<a name="nonResourceEssentials"></a>
<a name="essentials-control-options-non-resource"></a>
#### Non-Resource

To use the essentials, compose a template blade that hosts the essentials control, then use it from your extension.

Non-resource essentials allows you to use the essentials without a resource id. You change layout orders of all properties freely.

You can control the behavior of the essentials via initialization [options](#essentialsOptions) and provided [feature](#essentialsFeatures) functions.

**Step 1**: Define the Html template for your part:

`\Client\V1\Controls\Essentials\Templates\Essentials.html`

**Step 2**: Create a viewmodel to bind your control to `NonResourceEssentialsViewModel` implements the viewmodel for the editor.

`\Client\V1\Controls\Essentials\ViewModels\NonResourceEssentialsViewModel.ts.`

code sample coming soon to SamplesExtension in D:\ws\Ship-Sync-AuxDocs-Github\doc\portal-sdk\Samples\SamplesExtension\Extension\Client\V1\Controls\Essentials\ViewModels\NonResourceEssentialsViewModel.ts

**Step 3**: Now you can consume your part from an extension by referencing it in the PDL:

`\Client\V1\Controls\Essentials\Essentials.pdl`

code sample coming soon to SamplesExtension in D:\ws\Ship-Sync-AuxDocs-Github\doc\portal-sdk\Samples\SamplesExtension\Extension\Client\V1\Controls\Essentials\Essentials.pdl

<a name="essentials-control-features"></a>
### Features

<a name="essentialsCallbacks"></a>
<a name="essentials-control-features-resource-blade-open-close-callbacks"></a>
#### Resource Blade Open/Close Callbacks

Resource blade open/close callback functions are provided and can be used for logging telemetry or some other needed tasks.

Note that this feature is not available in `NonResource` essentials.

`\Client\V1\Controls\Essentials\ViewModels\DefaultEssentialsViewModel.ts.`

code sample coming soon to SamplesExtension in D:\ws\Ship-Sync-AuxDocs-Github\doc\portal-sdk\Samples\SamplesExtension\Extension\Client\V1\Controls\Essentials\ViewModels\DefaultEssentialsViewModel.ts

<a name="essentialsDynamicProps"></a>
<a name="essentials-control-features-add-dynamic-properties"></a>
#### Add Dynamic Properties

`\Client\V1\Controls\Essentials\ViewModels\DefaultEssentialsViewModel.ts.`

code sample coming soon to SamplesExtension in D:\ws\Ship-Sync-AuxDocs-Github\doc\portal-sdk\Samples\SamplesExtension\Extension\Client\V1\Controls\Essentials\ViewModels\DefaultEssentialsViewModel.ts

As the above code shows, the sample AJAX response contains 4 properties. First 2 items are added to left pane and last 2 items are added to right pane.


[essentials-sample]: ../media/portalfx-controls/essentials.png
