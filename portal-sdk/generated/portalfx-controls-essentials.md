<a name="essentials-control"></a>
## Essentials control

The essentials control is used for displaying resource information with multiple properties.
It has the flexibility to customize the layout of properties in a column, to display properties for non-ARM resources, and to responsively redistribute properties into more or fewer columns, depending on the width of the blade that contains it, as in the following example.

![alt-text](../media/portalfx-controls/essentials.png "Essentials")

The first five items in the left pane of the essentials are obtained by calling Azure Resource Manager APIs with the specified resource id.
More items can be specified in the constructor, or can be added dynamically in both the left and right panes.

When there are more than five items in any pane, only the first five items in each pane are displayed. The rest of the items are revealed when the **See more** link is clicked.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. The  working copy of the `Essentials` control in the Dogfood environment is located at [https://df.onecloud.azure-test.net/#blade/SamplesExtension/EssentialsIndexBlade/Default/selectedItem/EssentialsIndexBlade/selectedValue/EssentialsIndexBlade](https://df.onecloud.azure-test.net/#blade/SamplesExtension/EssentialsIndexBlade/Default/selectedItem/EssentialsIndexBlade/selectedValue/EssentialsIndexBlade).

The `Essentials` control is basically divided into the following three categories.

* [Options](#options)

* [Types](#types)

* [Features](#features)

<a name="essentials-control-options"></a>
### Options

There are four options in the `Essentials` control: the default, the custom, the non-resource, and the responsive options. They all allow an extension to control the behavior of the `Essentials` control by using initialization options and provided feature functions. They are all used in approximately the same way, although the instructions for use differ slightly by the type of option that is being developed.

To use the appropriate `Essentials` control, the extension can include it in an HTML template by using a `pcControl` binding. The extension should also import the module to use the `Essentials` control. Then, the developer should set up the `Settings` interface in the extension to persist the `expanded` property that contains the state of the control, and include a `Decorator` object in the code to set the `TemplateBlade` and provide access to the blade settings. 

After that, the extension should use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel.

Lastly, the extension defines the `_initializeControl` method that initializes the control.

<a name="essentials-control-options-default-layout"></a>
#### Default Layout

The defaults are the most common use case.  The default `Essentials` control is in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`. This code is also included in the following example. To use the default `Essentials` control, compose a template blade that contains it.

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

```

1. Set up the `Settings` interface. 

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel, as in the following example.
    ```cs
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

```
    ```
1. Define the `_initializeControl` method that initializes the control, as in the following example.

    ```typescript

/**
 * Initializes the Essentials control.
 */
private _initializeControl(): void {
    this.essentials =  Essentials.create(this.context.container, {
        resourceId: "/subscriptions/sub123/resourcegroups/snowtraxpsx/providers/Microsoft.Test/snowmobiles/snowtraxpsx600",
        additionalRight: [{
            label: ClientResources.essentialsItem,
            value: ClientResources.essentialsSampleString,
            icon: {
                image: MsPortalFx.Base.Images.SmileyHappy(),
                position: Essentials.IconPosition.Right
            }
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
                onClick: new ClickableLink(ko.observable("http://www.bing.com")),
                icon: {
                    image: MsPortalFx.Base.Images.SmileyHappy(),
                    position: Essentials.IconPosition.Left
                }
            }]
        }],
        //essentials#bladeCallbacks
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
        //essentials#bladeCallbacks
    });
}

```

<a name="essentials-control-options-custom-layout"></a>
#### Custom Layout

The custom layout allows the extension to change freely the layout order of built-in and other properties. The `Essentials` control is in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsCustomLayoutBlade.ts`. This code is also included in the following example. To use the custom layout `essentials` control, compose a template blade that contains it.

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

``` 

1. Set up the `Settings` interface to persist the `expanded` property that contains the state of the `Essentials` control.

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel, as in the following example.

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

``` 

1. Define the `_initializeControl` that initializes the control, as in the following example.

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

```

<a name="essentials-control-options-non-resource-layout"></a>
#### Non-Resource Layout

Non-resource essentials allow an extension to use the `Essentials` control without a resource id. It can change layout orders of all properties freely. To use the non-resource `essentials` control, compose a template blade that contains it.  The non-resource `Essentials` control is in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsNonResourceBlade.ts`. This code is also included in the following example. 

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

``` 

1. Set up the `Settings` interface. 

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

``` 

1. Use a `Configurable` decorator to persist the Read/Write `expanded` state in the blade settings and create the ViewModel, as in the following example.

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

``` 

1. Define the `_initializeControl` that initializes the control, as in the following example.

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

``` 

#### Responsive Layout

The `responsive essentials` control customizes the display based on the size and orientation of the screen. The maximum number of columns is based on the width of the parent blade. It is similar to the default sample, in that it sets up the HTML and uses the `Settings` interface and the `Configurable` decorator. The major difference is in the control initialization, as in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsResponsiveBlade.ts` and in  the following code. 

1. Define the `_initializeControl` that initializes the control, as in the following example.

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

``` 

<a name="essentials-control-types"></a>
### Types

There are two types: [properties](#properties) and [items](#items).

<a name="essentials-control-types-properties"></a>
#### Properties

<!-- TODO: Determine whether this section should be more verbose, and if so, what the descriptive content should be. -->

Built-in properties can be obtained from resource data. Other properties are for text, link, and custom link properties. 

* Built-in properties
 

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

* Text
    ```typescript
    {
        label: "Sample Label",
        value: "Sample Value"
    }
    ```

* Link
    ```typescript
    {
        label: "Sample Label",
        value: "Bing.com",
        onClick: new ClickableLink(ko.observable("http://www.bing.com"))
    }
    ```

* CustomLink
    ```typescript
    {
        label: "Sample Label",
        value: "Click to do something",
        onClick: () => {
            something();
        }
    }
    ```

<a name="essentials-control-types-items"></a>
#### Items

Items may contain single values, or they may contain multiple values on separate lines, as in the following examples.

  * A label with a property
    ```typescript
    {
        label: "Sample Label",
        value: "Sample Value"
    }
    ```

* Multi-line Item

    The following code contains a label with multiple values.

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

<a name="essentials-control-features"></a>
### Features


<a name="essentials-control-features-callbacks"></a>
#### Callbacks

Resource blade `open` and `close` callback functions are provided and can be used for logging, telemetry and  other needed tasks.

**NOTE**: This feature is not available in `NonResource` essentials.

The `Essentials` control is in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`. This code is also included in the following example.

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

```

<a name="essentials-control-features-dynamic-properties"></a>
#### Dynamic Properties

In the following code, the sample **AJAX** response contains four properties. The first two items are dynamically added to the left pane, and the last two  items are added to the right pane, as in the sample located at `<dir>\Client\V2\Controls\Essentials\EssentialsDefaultBlade.ts`. 

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

``` 

<a name="essentials-control-features-responsive-columns"></a>
#### Responsive Columns

In the following code, the optional `boolean` property named `responsiveColumns` can be set to `true` to use the responsive columns feature. The sample is located at `<dir>\Client\V2\Controls\Essentials\EssentialsResponsiveBlade.ts`. The blade whose property is set to `Small` contains a single column, and the full-screen blade contains several columns depending on the width of the blade. This code is also included in the following example.

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

``` 