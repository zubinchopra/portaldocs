<a name="essentials-control"></a>
## Essentials control

The essentials control is used for displaying resource information with multiple properties.
It has the flexibility to customize the layout of properties in a column, to display properties for non-ARM resources, and to responsively redistribute properties into one column or more than three columns, depending on the width of the blade that contains it, as in the following example.

![alt-text](../media/portalfx-controls/essentials2.png "Essentials")

The first five items in the left pane of the essentials are obtained by calling Azure Resource Manager APIs with the specified resource id.
More items can be specified in the constructor, or can be added dynamically in both the left and right panes.

When there are more than five items in any pane, only the first five items in each pane are displayed. The rest of the items are revealed when **See more** is clicked.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

<a name="essentials-control-options"></a>
### Options
- [Default Layout](#default-layout) 
- [Custom Layout](#custom-layout) 
- [Non-Resource](#non-resource)


<a name="essentials-control-types"></a>
### Types
- [Properties](#essentialsProperties)
- [Items](#essentialsItems)

<a name="essentials-control-features"></a>
### Features
- [Resource Blade Open/Close Callbacks](#essentialsCallbacks)
- [Add Dynamic Properties](#essentialsDynamicProps)
- [Responsive Columns](#responsiveEssentials)


<a name="essentialsProperties"></a>
<a name="essentials-control-types"></a>
### Types

<a name="essentials-control-types-types-of-properties"></a>
#### Types of Properties

<a name="essentials-control-types-types-of-properties-text"></a>
##### Text
```typescript
{
    label: "Sample Label",
    value: "Sample Value"
}
```
<a name="essentials-control-types-types-of-properties-link"></a>
##### Link
```typescript
{
    lable: "Sample Label",
    value: "Bing.com",
    onClick: new ClickableLink(ko.observable("http://www.bing.com"))
}
```
<a name="essentials-control-types-types-of-properties-customlink"></a>
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

<a name="essentials-control-options-default-layout"></a>
#### Default Layout

The defaults are the most common use case. The extension will control the behavior of the `Essentials` control by using initialization options and provided feature functions.

To use the default `Essentials` control, compose a template blade that contains it. The  `Essentials` control can be included in an HTML template by using a 'pcControl' binding, as in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`. This code is also included in the following example.

<!-- 
```typescript

export interface Settings {
expanded: boolean;
}

/*
 * Most common usage of essentials with a resourceId.
 * It has fixed order of specific resource related items.
 * This sample creates an essentials with resourceId and adds some items dynamically after the essentials control is initially rendered.
 */
@TemplateBlade.Decorator({
htmlTemplate: `<div data-bind="pcControl: essentials"></div>`
})
// The 'Configurable' decorator is applied here so the Blade can persist the 'expanded' property of the essentials control.
@TemplateBlade.Configurable.Decorator()
export class EssentialsDefaultBlade {

```  -->
<!-- TODO: Determine how to include the samples in gitHub. Otherwise, the reader can use the annotated code that was shipped with the SDK.  It contains all of the bookmarks for the snippets  -->

1. Import the module to use the `Essentials` control. Set up the `Settings` interface to persist the `expanded` property that contains the state of the `Essentials` control. Include a `Decorator` object that sets the `TemplateBlade` and provides access to the blade settings. 

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel. 

    <!--
    ```typescript

public title = ClientResources.essentialsDefaultEssentials;
public subtitle = ClientResources.controls;

public context: TemplateBlade.Context<void, DataContext> & TemplateBlade.Configurable.Context<Settings>;

/**
 * View model for the essentials.
 */
public essentials: Essentials.ViewModel;

/**
 * Creating an essentials and using data-loading for the blade.
 * Note that it is returning a Promise of AJAX calling function.
 */
public onInitialize(): Q.Promise<void> {
    const { container, configuration } = this.context;

    // Create an essentials
    this._initializeControl();

    // Read from the blade settings and set "expand" state value for the essentials
    const configValues = configuration.getValues();
    if (typeof configValues.settings.expanded === "boolean") {
        this.essentials.expanded(configValues.settings.expanded);
    }

    // Update the blade settings when "expanded" value is changed
    this.essentials.expanded.subscribe(container, (expanded) => {
        configuration.updateValues({
            settings: { expanded }
        });
    });

    // Once the Essentials control is instantiated, this Blade contains enough UI that it can remove the blocking loading indicator
    container.revealContent();

    //essentials#addDynamicProps
    // Sample AJAX Action
    let clickCounter = 0;
    return sampleAJAXFunction()
        .then((results: any) => {
            // Generate array of Essentials.Item | Essentials.MultiLineItem from the results
            const items: ((Essentials.Item | Essentials.MultiLineItem)[]) = results.map((data: any): Essentials.Item | Essentials.MultiLineItem => {
                switch (data.type) {
                    case "connectionString":
                        const connectionString = ko.observable(ClientResources.essentialsConnectionStringValue);
                        return {
                            label: data.label,
                            value: connectionString,
                            onClick: () => {
                                connectionString(data.value);
                            }
                        };
                    case "text":
                        return {
                            label: data.label,
                            value: data.value,
                            icon: {
                                image: MsPortalFx.Base.Images.SmileyHappy(),
                                position: Essentials.IconPosition.Right
                            }
                        };
                    case "url":
                        return {
                            label: data.label,
                            value: data.value,
                            onClick: new ClickableLink(ko.observable(data.url))
                        };
                    case "changeStatus":
                        return {
                            label: data.label,
                            value: data.value,
                            onClick: () => {
                                this.essentials.modifyStatus(`${++clickCounter} ${ClientResources.essentialsTimesClicked}!`);
                            }
                        };
                }
            });

            // Dynamically adding generated items to the essentials
            this.essentials.addDynamicProperties(
                // Add first two items to the left
                items.slice(0, 2),
                // Add next two items to the right
                items.slice(2, 4)
            );
        });
    //essentials#addDynamicProps
}

``` -->

1. Define the `_initializeControl` method that initializes the control.

#### Custom Layout

The custom layout allows the extension to change freely the layout order of built-in and other properties. The extension will control the behavior of the `Essentials` control by using initialization options and provided feature functions.

To use the custom layout `essentials` control, compose a template blade that contains it.   The  `Essentials` control can be included in an HTML template by using a 'pcControl' binding, as in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsCustomLayoutBlade.ts`. This code is also included in the following example. 

<!--
```typescript

export interface Settings {
expanded: boolean;
}

/*
 * Mostly similar to EssentialsDefaultBlade sample.
 * Unlike the default one, this sample shows the way to change orders of resource-related and user-defined items.
 */
@TemplateBlade.Decorator({
htmlTemplate: `<div data-bind="pcControl: essentials"></div>`
})
// The 'Configurable' decorator is applied here so the Blade can persist the 'expanded' property of the essentials control.
@TemplateBlade.Configurable.Decorator()
export class EssentialsCustomLayoutBlade {

``` -->

1. Import the module to use the `Essentials` control. Set up the `Settings` interface to persist the `expanded` property that contains the state of the `Essentials` control. Include a `Decorator` object that sets the `TemplateBlade` and provides access to the blade settings. 

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel. 

<!--
```typescript

public title = ClientResources.essentialsCustomLayoutEssentials;
public subtitle = ClientResources.controls;

public context: TemplateBlade.Context<void, DataContext> & TemplateBlade.Configurable.Context<Settings>;

/**
 * View model for the essentials.
 */
public essentials: Essentials.ViewModel;

/**
 * Creating an essentials and not using data-loading for the blade.
 */
public onInitialize(): Q.Promise<void> {
    const { container, configuration } = this.context;

    // Create an essentials
    this._initializeControl();

    // Read from the blade settings and set "expand" state value for the essentials
    const configValues = configuration.getValues();
    if (typeof configValues.settings.expanded === "boolean") {
        this.essentials.expanded(configValues.settings.expanded);
    }

    // Update the blade settings when "expanded" value is changed
    this.essentials.expanded.subscribe(container, (expanded) => {
        configuration.updateValues({
            settings: { expanded }
        });
    });

    // Once the Essentials control is instantiated, this Blade contains enough UI that it can remove the blocking loading indicator
    container.revealContent();

    // Does not use data-loading for the blade.
    return Q();
}

```  -->

1. Define the `_initializeControl` that initializes the control.

<!--
```typescript

/**
 * Initializes the Essentials control.
 */
private _initializeControl(): void {
    let clickCounter = 0;
    this.essentials =  Essentials.create(this.context.container, {
        resourceId: "/subscriptions/sub123/resourcegroups/snowtraxpsx/providers/Microsoft.Test/snowmobiles/snowtraxpsx600",
        left: [
            Essentials.BuiltInType.Status,
            {
                label: ClientResources.essentialsItem,
                value: ClientResources.essentialsSampleString
            },
            Essentials.BuiltInType.ResourceGroup,
            {
                label: ClientResources.essentialsDynamicChangeStatus,
                value: ClientResources.essentialsStatusWillBeChanged,
                onClick: () => {
                    this.essentials.modifyStatus(`${++clickCounter} ${ClientResources.essentialsTimesClicked}!`);
                }
            },
            {
                label: ClientResources.essentialsItem,
                value: "Bing.com",
                onClick: new ClickableLink(ko.observable("http://www.bing.com"))
            }
        ],
        right: [
            Essentials.BuiltInType.Location,
            {
                label: ClientResources.essentialsItem,
                value: ClientResources.essentialsSampleString
            },
            Essentials.BuiltInType.SubscriptionId,
            Essentials.BuiltInType.SubscriptionName
        ],
        onBladeOpen: (origin: Essentials.BuiltInType) => {
            switch (origin) {
                case Essentials.BuiltInType.ResourceGroup:
                    this.essentials.modifyStatus(ClientResources.essentialsResourceGroupOpened);
                    break;
                case Essentials.BuiltInType.SubscriptionName:
                    this.essentials.modifyStatus(ClientResources.essentialsSubscriptionOpened);
                    break;
            }
        },
        onBladeClose: (origin: Essentials.BuiltInType) => {
            switch (origin) {
                case Essentials.BuiltInType.ResourceGroup:
                    this.essentials.modifyStatus(ClientResources.essentialsResourceGroupClosed);
                    break;
                case Essentials.BuiltInType.SubscriptionName:
                    this.essentials.modifyStatus(ClientResources.essentialsSubscriptionClosed);
                    break;
            }
        }
    });
}

``` -->

#### Non-Resource

Non-resource essentials allow an extension to use the essentials without a resource id. It can change layout orders of all properties freely. The extension will control the behavior of the `Essentials` control by using initialization options and provided feature functions.

To use the Non-resource `essentials` control, compose a template blade that contains it.   The  `Essentials` control can be included in an HTML template by using a 'pcControl' binding, as in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsNonResourceBlade.ts`. This code is also included in the following example. 

1. Import the module to use the `Essentials` control. Set up the `Settings` interface to persist the `expanded` property that contains the state of the `Essentials` control. Include a `Decorator` object that sets the `TemplateBlade` and provides access to the blade settings. 

<!--
```typescript

export interface Settings {
expanded: boolean;
}

/*
 * Essentials sample without a resourceId.
 * Since there is no resource items, all items should be provided by the author.
 */
@TemplateBlade.Decorator({
htmlTemplate: `<div data-bind="pcControl: essentials"></div>`
})
// The 'Configurable' decorator is applied here so the Blade can persist the 'expanded' property of the essentials control.
@TemplateBlade.Configurable.Decorator()
export class EssentialsNonResourceBlade {

``` -->

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel.

<!--
```typescript

public title = ClientResources.essentialsNonResourceEssentials;
public subtitle = ClientResources.controls;

public context: TemplateBlade.Context<void, DataContext> & TemplateBlade.Configurable.Context<Settings>;

/**
 * View model for the essentials.
 */
public essentials: Essentials.ViewModel;

/**
 * Custom Status.
 */
private _customStatus: KnockoutObservable<string> = ko.observable(null);

/**
 * Creating an essentials and not using data-loading for the blade.
 */
public onInitialize(): Q.Promise<void> {
    const { container, configuration } = this.context;

    // Create an essentials
    this._initializeControl();

    // Read from the blade settings and set "expand" state value for the essentials
    const configValues = configuration.getValues();
    if (typeof configValues.settings.expanded === "boolean") {
        this.essentials.expanded(configValues.settings.expanded);
    }

    // Update the blade settings when "expanded" value is changed
    this.essentials.expanded.subscribe(container, (expanded) => {
        configuration.updateValues({
            settings: { expanded }
        });
    });

    // Once the Essentials control is instantiated, this Blade contains enough UI that it can remove the blocking loading indicator
    container.revealContent();

    // Does not use data-loading for the blade.
    return Q();
}

``` -->

1. Define the `_initializeControl` that initializes the control.

<!--
```typescript

/**
 * Initializes the Essentials control.
 */
private _initializeControl(): void {
    let clickCounter = 0;
    this.essentials = Essentials.create(this.context.container, {
        left: [
            {
                label: ClientResources.essentialsItem,
                value: ClientResources.essentialsSampleString
            },
            {
                label: ClientResources.essentialsDynamicChangeStatus,
                value: ClientResources.essentialsStatusWillBeChanged,
                onClick: () => {
                    this._customStatus(`${++clickCounter} ${ClientResources.essentialsTimesClicked}!`);
                }
            },
            {
                label: ClientResources.essentialsItem,
                value: "Bing.com",
                onClick: new ClickableLink(ko.observable("http://www.bing.com"))
            },
            {
                label: ClientResources.essentialsItem,
                value: ClientResources.essentialsSampleString
            },
            {
                label: ClientResources.essentialsItem,
                value: ClientResources.essentialsSampleString
            }
        ],
        right: [
            {
                label: ClientResources.essentialsCustomStatus,
                value: this._customStatus
            },
            {
                label: ClientResources.essentialsItem,
                value: "Bing.com",
                onClick: new ClickableLink(ko.observable("http://www.bing.com"))
            },
            {
                label: ClientResources.essentialsItem,
                value: "Bing.com",
                onClick: new ClickableLink(ko.observable("http://www.bing.com"))
            },
            {
                label: ClientResources.essentialsItem,
                value: ClientResources.essentialsSampleString
            },
            {
                label: ClientResources.essentialsItem,
                value: ClientResources.essentialsSampleString
            }
        ]
    });
}

``` -->

### Features

<a name="essentialsCallbacks"></a>
#### Resource Blade Open/Close Callbacks

Resource blade open/close callback functions are provided and can be used for logging telemetry or some other needed tasks.

Note that this feature is not available in `NonResource` essentials.

`\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`

<!--
```typescript

onBladeOpen: (origin: Essentials.BuiltInType) => {
    switch (origin) {
        case Essentials.BuiltInType.ResourceGroup:
            this.essentials.modifyStatus(ClientResources.essentialsResourceGroupOpened);
            break;
        case Essentials.BuiltInType.SubscriptionName:
            this.essentials.modifyStatus(ClientResources.essentialsSubscriptionOpened);
            break;
    }
},
onBladeClose: (origin: Essentials.BuiltInType) => {
    switch (origin) {
        case Essentials.BuiltInType.ResourceGroup:
            this.essentials.modifyStatus(ClientResources.essentialsResourceGroupClosed);
            break;
        case Essentials.BuiltInType.SubscriptionName:
            this.essentials.modifyStatus(ClientResources.essentialsSubscriptionClosed);
            break;
    }
}

``` -->

<a name="essentialsDynamicProps"></a>
#### Add Dynamic Properties

`\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`

<!--
```typescript

// Sample AJAX Action
let clickCounter = 0;
return sampleAJAXFunction()
    .then((results: any) => {
        // Generate array of Essentials.Item | Essentials.MultiLineItem from the results
        const items: ((Essentials.Item | Essentials.MultiLineItem)[]) = results.map((data: any): Essentials.Item | Essentials.MultiLineItem => {
            switch (data.type) {
                case "connectionString":
                    const connectionString = ko.observable(ClientResources.essentialsConnectionStringValue);
                    return {
                        label: data.label,
                        value: connectionString,
                        onClick: () => {
                            connectionString(data.value);
                        }
                    };
                case "text":
                    return {
                        label: data.label,
                        value: data.value,
                        icon: {
                            image: MsPortalFx.Base.Images.SmileyHappy(),
                            position: Essentials.IconPosition.Right
                        }
                    };
                case "url":
                    return {
                        label: data.label,
                        value: data.value,
                        onClick: new ClickableLink(ko.observable(data.url))
                    };
                case "changeStatus":
                    return {
                        label: data.label,
                        value: data.value,
                        onClick: () => {
                            this.essentials.modifyStatus(`${++clickCounter} ${ClientResources.essentialsTimesClicked}!`);
                        }
                    };
            }
        });

        // Dynamically adding generated items to the essentials
        this.essentials.addDynamicProperties(
            // Add first two items to the left
            items.slice(0, 2),
            // Add next two items to the right
            items.slice(2, 4)
        );
    });

``` -->

As the above code shows, the sample AJAX response contains 4 properties. First 2 items are added to left pane and last 2 items are added to right pane.

<a name="responsiveEssentials"></a>
#### Responsive Columns

`\Client\V2\Controls\Essentials\EssentialsResponsiveBlade.ts`

<!--
```typescript

this.essentials =  Essentials.create(this.context.container, {
    responsiveColumns: true,
    resourceId: "/subscriptions/sub123/resourcegroups/snowtraxpsx/providers/Microsoft.Test/snowmobiles/snowtraxpsx600",
    additionalRight: [{
        label: ClientResources.essentialsItem,
        value: ClientResources.essentialsSampleString
    }, {
        label: ClientResources.essentialsItem,
        value: "Bing.com",
        onClick: new ClickableLink(ko.observable("http://www.bing.com"))
    }, {
        label: ClientResources.essentialsMultiLineItem,
        lines: [{
            value: ClientResources.essentialsSampleString
        }, {
            value: "Bing.com",
            onClick: new ClickableLink(ko.observable("http://www.bing.com"))
        }]
    }],
    onBladeOpen: (origin: Essentials.BuiltInType) => {
        switch (origin) {
            case Essentials.BuiltInType.ResourceGroup:
                this.essentials.modifyStatus(ClientResources.essentialsResourceGroupOpened);
                break;
            case Essentials.BuiltInType.SubscriptionName:
                this.essentials.modifyStatus(ClientResources.essentialsSubscriptionOpened);
                break;
        }
    },
    onBladeClose: (origin: Essentials.BuiltInType) => {
        switch (origin) {
            case Essentials.BuiltInType.ResourceGroup:
                this.essentials.modifyStatus(ClientResources.essentialsResourceGroupClosed);
                break;
            case Essentials.BuiltInType.SubscriptionName:
                this.essentials.modifyStatus(ClientResources.essentialsSubscriptionClosed);
                break;
        }
    }
});

``` -->

The optional `boolean` property `responsiveColumns` can be specified to `true` to use responsive columns feature.

`Small` sized blade will contain single column and full screen will contain multiple number of columns depends on the blade's width.