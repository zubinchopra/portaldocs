## Lifetime Manager

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

The `lifetime manager` ensures that any resources that are specifically associated with a blade are disposed of when the blade is closed. Each blade has its own lifetime manager. Controls, **Knockout** projections and APIs that use a `lifetime manager` will be disposed when the `lifetime manager` is disposed. That means, for the most part, extensions in the Portal implicitly perform efficient memory management.

There are some scenarios that call for more fine-grained memory management. The most common case is the `map()` or `mapInto()` function, especially when it is used with a reactor or control in the callback that generates individual items. These items can be destroyed previous to the closing of the blade by being removed from the source array. When dealing with large amounts of data, especially virtualized data, memory leaks can quickly add up and result in poor extension performance. 

**NOTE**: The  `pureComputed()` method does not use a lifetime manager because it already uses memory as efficiently as possible.  This is by design, therefore it is good practice to use it. Generally, any `computed` the extension creates in a `map()` should be a `pureComputed()` method, instead of a `ko.reactor` method.

For more information on pureComputeds, see [portalfx-blade-viewmodel.md#data-pureComputed](portalfx-blade-viewmodel.md#data-pureComputed).

### Child lifetime managers 

Child lifetime managers exist for the amount of time that is, at most, the lifetime of their parent.  However, child lifetime managers can be disposed before their parent is disposed. When the developer is aware that extension child resources will have lifetimes that are shorter than that of the blade, a child lifetime manager can be created with the  `container.createChildLifetimeManager()` command, and sent to `ViewModel` constructors or anywhere else a lifetime manager object is needed. When the extension completes using those resources, the `dispose()` method can be explicitly called on the child lifetime manager. If the `dispose()` method is not called, the child lifetime manager will be disposed when its parent is disposed to prevent memory leaks.

In this example, a data cache contains data. Each item is displayed as a row in a grid. A button is displayed separately in a section located below the grid. The `mapInto()` function is used to map the data cache items to the grid items, and to create a button and add it to the section.

```ts
let gridItems = this._view.items.mapInto(container, (itemLifetime, item) => {
    let button = new Button.ViewModel(itemLifetime, { label: pureComputed(() => "Button for " + item.name())});
    this.section.children.push(button);
    return {
        name: item.name,
        status: ko.pureComputed(() => item.running() ? "Running" : "Stop")
    };
});
```

In this example, whereever the value of an observable is read in the mapping function, it is  wrapped in a `ko.pureComputed`. This is important and the reasons why are discussed in [portalfx-data-projections.md#data-shaping](portalfx-data-projections.md#data-shaping).

In addition, the `itemLifetime` child lifetime manager that was automatically created by the `mapInto()` function was sent to the mapping function as a parameter, instead of sending the  `container` into the button constructor.

In the case of `map()` and `mapInto()`, the item lifetime manager will be disposed when the associated object is removed from the source array. In the previous example, this means the button `ViewModel` will be disposed at the correct time, but the now disposed button `ViewModel` will still be in the Section. The button has not been removed from the section's `children()` array. 

Fortunately, callbacks can be registered with the lifetime manager to use when it is disposed by using the `registerForDispose` command, as in the following example.

```ts
let gridItems = this._view.items.mapInto(container, (itemLifetime, item) => {
    let button = new Button.ViewModel(itemLifetime, { label: pureComputed(() => "Button for " + item.name())});
    this.section.children.push(button);
    itemLifetime.registerForDispose(() => this.section.children.remove(button));
    return {
        name: item.name,
        status: ko.pureComputed(() => item.running() ? "Running" : "Stop")
    };
});
```

Consequently, the `mapInto` function is working as expected, by using the child lifetime manager and the `registerForDispose` command.