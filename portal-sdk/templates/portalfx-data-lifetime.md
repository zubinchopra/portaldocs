## Lifetime Manager

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

The 'lifetime manager'  makes sure that any resources that are specifically associated with a blade are disposed of when the blade is closed. Each blade has its own lifetime manager. Controls, knockout projections and APIs that use a lifetime manager will be disposed when the lifetime manager is disposed. That means, for the most part, extensions in the portal will implicity perform efficient memory management.

<!-- TODO: Determine whether a reactor is an object. If not, delete it. -->
There are some scenarios that call for more fine-grained memory management. The most common case is the `map()` or `mapInto()` function, especially when it is used with a reactor or control in the callback that generates individual items. These items can be destroyed previous to the closing of the blade by being removed from the source array. When dealing with large amounts of data, especially virtualized data, memory leaks can quickly add up and lead to poor performance. 

**NOTE**: The  `pureComputed()` method does not use a lifetime manager because it already uses memory as efficiently as possible.  This is by design, therefore it is good practice to use it. Generally, any computed the extension creates in a `map()` should be a `pureComputed()` method, instead of a `ko.reactor` method.

For more information on pureComputeds, see [portalfx-blade-viewmodel.md#data-pureComputed](portalfx-blade-viewmodel.md#data-pureComputed).


Before we get into a discussion of child lifetime managers 

In this example, there is data in a data cache. Each item should be displayed as a row in a grid. A button is displayed separately in a section located below the grid. The `mapInto()` function is used to map the data cache items to the grid items, and in the map function create a button and add it to the section.

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

A few things to note here. 
1. Everywhere we read the value an observable in the mapping function, we wrapped it in a ko.pureComputed. This is important and we have documentation [here](portalfx-data-projections.md#data-shaping) that goes into the reasons why.

1. Rather than sending 'container' into the button constructor, we sent  `itemLifetime` which the  mapping function receives as a parameter. This is a "child" lifetime manager that was automatically created by the mapInto function. 

Child lifetime managers have a lifetime that is at most the lifetime of their parent but importantly they can be disposed before their parent is disposed. When you know you have resources whose lifetime is shorter than that of the blade you can do `container.createChildLifetimeManager()` to create a child lifetime manager and pass that in to ViewModel constructors or anywhere else a lifetime manager object is needed. When you know you are done with those resources you can explictly call `dispose()` on the child lifetime manager. If you forget the child lifetime manager will be disposed when its parent is disposed to prevent memory leaks.

In the case of `map()` and `mapInto()` the item lifetime manager will be disposed when the associated object is removed from the source array. In the example above this means the button ViewModel will be disposed at the correct time but notice the now disposed button ViewModel will still be in the Section. Nobody has removed the button from the section's `children()` array. Fortunately extension authors can register callbacks with the lifetime manager that are called when it's disposed using `registerForDispose`. To fix up the sample above we can do:

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

Now our mapInto function is working properly.