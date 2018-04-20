
## Overview 

The Portal uses a `viewModel` abstraction to allow extensions to deal with data and manipulate UI without worrying about the differences in DOM events across browsers or having to remember to include the right accessiblity attributes.

<!--  TODO: Determine whether each control item still has its own ViewModel or if they are combined with the parent somehow. -->

The DOM is in an iframe controlled by the Portal, or the 'shell' iframe.  The extension is in a separate iframe, or the 'extension' iframe. The shell iframe and the extension iframe communicate through `ViewModels`. They often use **Knockout** observable values.

When a blade is opened by the user,  the Portal calls the extension iframe and requests the `ViewModel` for that blade. The blade `ViewModel` consists of other `ViewModels` for items like textboxes, buttons, and other controls. These `ViewModels` are used to communicate with the user by displaying or collecting information. The blade `ViewModel` coordinates the transfer of the data to, from, and between the `ViewModels` for the controls. The `ViewModels` have a performance impact on the blades. Accessibility attributes are encapsulated in the controls.

**NOTE**: It is good practice to use a section control to layout the blade controls, instead of directly putting them in the template. A section control provides default styling, and is typically an easier way to deal with dynamically adding and removing of controls.
 
In this example, the blade loads a person object from the server and displays it in readonly textbox controls. The practice of putting the textbox controls in a section control was omitted to simplify the example. To make the scenario more dynamic, the blade does not display a textbox for the person's smartphone if the string is empty. Consequently, the UI resembles one of the following two images.

![alt-text](../media/portalfx-blade-viewmodel/SmartPhone.png "Person with smartphone")

Or this:

![alt-text](../media/portalfx-blade-viewmodel/NoSmartPhone.png "Person without a smartphone")

The properties on the `ViewModel` that creates this blade are in the following example.

{"gitdown": "include-section", "file":"../Samples/InternalSamplesExtension/Extension/Client/Blades/ViewModelInitExample/ViewModels/ViewModelInitExample.ts", "section": "bladeViewModel#properties"}

Private members of the blade `ViewModel` are properties whose name starts with an underscore. The proxied observable layer does not transfer private members to the shell iframe. For example, the `EntityView` object named `_view` is not directly used in the rendering of the blade, therefore it does not appear in the blade template, nor is it proxied to the shell iframe.

**NOTE**: Incorrect selection of the data that is to be proxied to the shell can greatly reduce the performance of the blade.

The template for this blade is in the following example.

{"gitdown": "include-section", "file":"../Samples/InternalSamplesExtension/Extension/Client/Blades/ViewModelInitExample/Templates/Template.html", "section": "bladeViewModel#template"}

### The blade constructor

When a blade is opened, the Portal creates a blade that displays a loading UX indicator, as specified in [portalfx-blades-procedure.md#displaying-a-loading-indicator-ux](portalfx-blades-procedure.md#displaying-a-loading-indicator-ux).  This indicator is displayed while the `ViewModel` for the blade is requested from the extension. Then,  the constructor for the blade `ViewModel` runs. The constructor should include the  `ViewModels` for the UI, and as much initialization as possible. 

This example will always need a readonly textbox for the name and an OK button to close the blade, so they are created in the constructor.  The constructor is not aware of  the value of the name textbox yet, because the values are only known after the  data is retrieved.  The value can be updated later because the `value` property of the textbox view model is observable, as in the following example of the blade  `ViewModel` constructor.

{"gitdown": "include-section", "file":"../Samples/InternalSamplesExtension/Extension/Client/Blades/ViewModelInitExample/ViewModels/ViewModelInitExample.ts", "section": "bladeViewModel#constructor"}

#### Observable and non-observable values

Observable values can be updated after their creation. In addition, observables are not limited to primitive types. Any properties that are not observable cannot be observably updated after the proxied observable layer has mirrored the `ViewModel` in the shell iframe.

There are optional UI elements for populating an observable, like the section control's `children` observable array. For example, there is a boolean option in the constructor of a grid control controls that specifies whether column headers should be displayed.

If the grid is not an observable boolean, it cannot be changed after the grid `ViewModel` is created.  If column headers are dependent on some data that is retrieved from the server, then the grid `ViewModel` should be an observable so that constructing the grid with column headers can be delayed until data retrieval is complete. 

In the next  example, the extension iframe will never propagate the following changes in value to the shell iframe because it is a non-observable value.

```ts
viewModel.readonly = false;
```

However, if the new value is stored in an observable, as in the following code, then the proxied observable layer will be notified of the change in the value and will reflect the change in the shell iframe. 

```ts
viewModel.value("updated");
```

The readonly `nameTextBox` control is non-observable because its `ViewModel` will not be removed or replaced, although the properties of the `nameTextBox` textbox might be updated. The `ViewModel` is static for the lifetime of the blade.

The `smartPhone` control  is an observable because the extension cannot know whether to create the textbox control until the data is retrieved in the `onInputsSet` method.

The same applies for properties on controls `ViewModels`. For example, the `okButton` `ViewModel` is created, a static string is specified for the `text` property. It is not an observable value and cannot be updated. The  type signature for the `text` property  is a union type that accepts both a `string` and a `KnockoutObservable<string>`. This means that if an extension wants to revisit the decision of making the property dynamic or updatable, then an observable can be defined at construction time, as in the following example.

```ts
this._buttonText = ko.observable("OK");
this.smartPhone = new SimpleButton.ViewModel(container, {
    text: this._buttonText,
    ...
});
```

Later, the text is updated by writing to that observable.

```ts
this._buttonText("New button text");
```

### The onInputsSet method

When the input values for the blade are ready, the framework will call the `onInputsSet` method. This is often when the extension fetches the data for the blade and update the view models that were created in the constructor. When the promise  that is returned from the `onInputsSet` method is resolved, the blade is considered 'loaded' the loading UI indicator will be removed from the blade. The following is the `onInputsSet` method for the person object example.

{"gitdown": "include-section", "file":"../Samples/InternalSamplesExtension/Extension/Client/Blades/ViewModelInitExample/ViewModels/ViewModelInitExample.ts", "section": "bladeViewModel#onInputsSet"}

The extension uses a `fetch()` to get data from the server, based on the inputs provided by the Framework. The return value for the `onInputSet` is the `promise` that is returned by the fetch call, so that the blade can be displayed as soon as the data is loaded. There is  also a `then()` on the fetch promise so that the extension can populate the dynamic pieces of the blade. The steps to display the person object with the data that was retrieved from the server are as follows.

1. Update the value of `nameTextBox` by writing to the `value` observable on the textbox.  If the textbox is not read-only, the extension could subscribe to the value observable and receive any changes that the user makes to the textbox in the subscription callback.

1. Determine whether or not to populate the blade's `smartPhone` observable with a textbox `ViewModel`. 

    When the textbox `ViewModel` is written to the `smartPhone` observable, the `pcControl` binding handler in the blade template observes the new `ViewModel` and constructs a textbox control. If the observable is not populated, the `<div>` in the template remains empty, and nothing is displayed on the blade.

### Efficient mutation of observable arrays

Using the following example can lead to severe performance problems in an extension because it queues 100 observable updates of one item each.

  ```ts
  let numbers = ko.observable([]);
  for (i = 0; i < 100; i++) {
      numbers.push(i);
  }
  ```

##### Case 1: Code with performance problems

The following code is much more performant because it queues a single observable update that contains 100 items.

  ```ts
  let tempArray = [];
  for (i = 0; i < 100; i++) {
      tempArray.push(i);
  }
  let numbers = ko.observable(tempArray);
  ```

##### Case 2: Performant code

In a more real example, an extension is pushing data points to a series displayed on a chart that is currently using auto-scaling of its axes. It takes 0.01 seconds to render an extra data point, but 0.5 seconds to recalcuate the scale of the x-axis and the y-axis every time the data is updated.

In this example, the code in Case 1 would take 100 * (0.01 + 0.5) = 51 seconds to process all the changes, but the code in Case 2 would take (100 * 0.01) + 0.5 = 1.5 seconds to process the changes, for a difference of 3400%. This non-performant code results in performance problems that are serious enough that the Framework attempts to detect this type of code in an  extension.  When the Framework encounters this type of code, it displays the following warning  message.

```
Performance warning: A proxied observable array is mutated inefficiently.
```

Typically, this means there is a repeated `push()` on an observable array somewhere in the code, although there are other inefficient array mutations that the Framework can call out.

When you encounter this warning in the console, please address the issue.

### The ko.pureComputed method

<!-- TODO: Determine what is meant by "everyone".  Is this multiple extensions, multiple blades, or multiple ViewModels? -->
You might have noticed unlike `ko.reactor` or knockout's observable subscribe method, the Portal's version of the knockout `pureComputed()` has not been modified to use a lifetime manager. The reason is that any **Knockout** dependencies (which are the things that will pin a computed or observable in memory) that are associated with the `pureComputed` are allocated only when someone is listening to the `pureComputed`. They   are cleaned up when everyone stops listening to the `pureComputed`.

This works great for the vast majority of cases for 'pure' functions where there are no side effects. Consequently, it is good practice to use a `pureComputed` instead of a `ko.reactor` method. 

The following example demonstrates the difference between the  `pureComputed` method and the  `ko.reactor` method. 

```ts
let obsNum = ko.observable(0);
let pureComputedCounter = 0;
let reactorCounter = 0;

let pure = ko.pureComputed(() => {
    pureComputedCounter++;
    return obsNum() + 1;
});

let reactor = ko.reactor(lifetime, () => {
    reactorCounter++;
    return obsNum() + 2;
});

obsNum(10);
obsNum(3);
obsNum(5);

console.log("According to pureComputed obsNum changed " + pureComputedCounter + " times");
console.log("According to reactor obsNum changed " + reactorCounter + " times");
```

The output of the above will be:

```
According to pureComputed obsNum changed 0 times
According to reactor obsNum changed 3 times
```

In this example, incrementing `pureComputedCounter` or `reactorCounter` is a side-effect because it has no bearing on the value of the observables that are produced by the functions (`pure` and `reactor`). If the  side-effect is needed, the extension should  use the  `ko.reactor()` method; otherwise, it should  use the  `ko.pureComputed()` method.

**NOTE**: If the extension code contained `pure.subscribe(lifetime, (val) => console.log(val.toString()))` right after creating `pure`, then `pureComputedCounter` would also have been incremented to 3 because the `pureComputed` becomes live as soon as a listener is attached.

For more information about `pureComputeds`, see [http://knockoutjs.com/documentation/computed-pure.html](http://knockoutjs.com/documentation/computed-pure.html).

### The ko.reactor method

Any observables read in the function that are sent to `ko.reactor()` will become a dependency for that reactor.  The reactor will recompute whenever any of those observable values change. The same is true for the  `ko.pureComputed()` method and the observable array's `map()` and `mapInto()` functions. This can lead to a situation where a `computed` is recalculating unintentionally. For more information about `map` and `mapInto`, see [portalfx-data-projections.md#shaping-and-filtering-data](portalfx-data-projections.md#shaping-and-filtering-data).

It is also good practice to put a breakpoint in the `computed` function whenever a `pureComputed` or a `reactor` to determine how many times each function runs.  There have been instances when `computed` functions that should run once actually ran more than thirty times, which wastes CPU time on unnecessary  recalculations.  If another `computed` takes a dependency on the function that runs too often,  the CPU consumption performance issue grows exponentially.

Consequently, the Framework attempts to detect problematic computed functions. When a `computed` is created that has dependencies on 30 or more other observables, the Shell will send an error message to the console. This allows the developer to locate unnecessary dependencies on the `computed` has likely that are wasting time recomputing when the dependencies change.

The following strategies can be used to ensure that the `computed` only calculates when the developer intends that it should.

1. Use the explicit dependency overload of `ko.reactor()`/`ko.pureComputed()`. The functions are overloaded, so that they can subscribe to a list of observables that the extension can send in the second parameter. When this overload is used, an observable that is read by the `computed` function will not become a dependency. Instead, the `computed` will only recalculate when the observables that were listed as dependencies are changed.

1. Avoid calling other functions in the `computed` method. When the entire implementation of the computed is inline, it is easier to scan the code to determine what observables are dependencies of the function. For example, the private member `_processfoo` in the following code may call three more helper methods, which makes it more difficult to determine which observables will cause `computed()` to recalculate.

```ts
let computed = ko.pureComputed(() => {
    let foo = this.foo();
    this._processfoo(foo);
});
```

1. Use `ko.ignoreDependencies()` inside the computed function. For example, the original code might be as in the following example.

```ts
let computed = ko.reactor(lifetime, [this.foo, this.bar], (foo, bar) => {
    this._processFoo(foo, bar);
});
```

The previous code has been refactored for readability by using the `ko.ignoreDependencies()` function. The improved code is in the following example.
 
```ts
let computed = ko.reactor(lifetime, () => {
    let foo = this.foo();
    let bar = this.bar();
    ko.ignoreDependencies(() => {
        this._processFoo(foo, bar);
    });
});
```
