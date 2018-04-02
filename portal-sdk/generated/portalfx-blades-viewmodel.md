
<a name="overview"></a>
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

```typescript

/**
 * Textbox control containing the user's name.
 */
public nameTextBox: TextBox.ViewModel;

/**
 * Observable containing either a numeric textbox or a textbox.
 */
public smartPhone: KnockoutObservable<TextBox.ViewModel>

/**
 * OK button for submitting updated user data back to server.
 */
public okButton: Button.Contract;

/**
 * EntityView containing the person being edited
 */
private _view: MsPortalFx.Data.EntityView<Person, any>;

```

Private members of the blade `ViewModel` are properties whose name starts with an underscore. The proxied observable layer does not transfer private members to the shell iframe. For example, the `EntityView` object named `_view` is not directly used in the rendering of the blade, therefore it does not appear in the blade template, nor is it proxied to the shell iframe.

**NOTE**: Incorrect selection of the data that is to be proxied to the shell can greatly reduce the performance of the blade.

The template for this blade is in the following example.

```xml

<div data-bind="pcControl: nameTextBox"></div>
<div data-bind="pcControl: smartPhone"></div>
<div data-bind="pcControl: okButton"></div>

```

<a name="overview-the-blade-constructor"></a>
### The blade constructor

When a blade is opened, the Portal creates a blade that displays a loading UX indicator, as specified in [portalfx-blades-procedure.md#displaying-a-loading-indicator-ux](portalfx-blades-procedure.md#displaying-a-loading-indicator-ux).  This indicator is displayed while the `ViewModel` for the blade is requested from the extension. Then,  the constructor for the blade `ViewModel` runs. The constructor should include the  `ViewModels` for the UI, and as much initialization as possible. 

This example will always need a readonly textbox for the name and an OK button to close the blade, so they are created in the constructor.  The constructor is not aware of  the value of the name textbox yet, because the values are only known after the  data is retrieved.  The value can be updated later because the `value` property of the textbox view model is observable, as in the following example of the blade  `ViewModel` constructor.

```typescript

this._view = dataContext.personData.peopleEntities.createView(container);

this.nameTextBox = new TextBox.ViewModel(container, {
    readonly: true,
    label: ko.observable("Name")
});

this.smartPhone = ko.observable<TextBox.ViewModel>();

this.okButton = Button.create(container, {
    text: "OK",
    onClick: () => {
        container.closeChildBlade();
    }
});

```

<a name="overview-the-blade-constructor-observable-and-non-observable-values"></a>
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

<a name="overview-the-oninputsset-method"></a>
### The onInputsSet method

When the input values for the blade are ready, the framework will call the `onInputsSet` method. This is often when the extension fetches the data for the blade and update the view models that were created in the constructor. When the promise  that is returned from the `onInputsSet` method is resolved, the blade is considered 'loaded' the loading UI indicator will be removed from the blade. The following is the `onInputsSet` method for the person object example.

```typescript

return this._view.fetch(inputs.id).then(() => {
    let person = this._view.data;

    // populate name textbox value
    this.nameTextBox.value(person.name());

    // if smartphone has a value create a control to display it
    // otherwise leave it empty
    let smartPhone = person.smartPhone();
    if (smartPhone) {
        let textBox = new TextBox.ViewModel(this._container, {
            readonly: true,
            label: ko.observable("Smart phone"),
            defaultValue: ko.observable(smartPhone)
        });
        this.smartPhone(textBox);
    }
});

```

The extension uses a `fetch()` to get data from the server, based on the inputs provided by the Framework. The return value for the `onInputSet` is the `promise` that is returned by the fetch call, so that the blade can be displayed as soon as the data is loaded. There is  also a `then()` on the fetch promise so that the extension can populate the dynamic pieces of the blade. The steps to display the person object with the data that was retrieved from the server are as follows.

1. Update the value of `nameTextBox` by writing to the `value` observable on the textbox.  If the textbox is not read-only, the extension could subscribe to the value observable and receive any changes that the user makes to the textbox in the subscription callback.

1. Determine whether or not to populate the blade's `smartPhone` observable with a textbox `ViewModel`. 

    When the textbox `ViewModel` is written to the `smartPhone` observable, the `pcControl` binding handler in the blade template observes the new `ViewModel` and constructs a textbox control. If the observable is not populated, the `<div>` in the template remains empty, and nothing is displayed on the blade.

<a name="overview-best-practices-when-using-observables"></a>
### Best practices when using observables

* Proper naming of `ViewModel` properties

  - The easiest thing you can do to improve performance is make sure proxied observables is not copying data to the shell that is only needed in the extension iframe. The shell will warn you when it sees certain types of objects (like an editscope) being sent to the shell but it can't guard against everything. It is on the extension author to review their view model and ensure the right data is public vs private. Any private member name should start with an underscore so that proxied observables knows not to send the property to the shell.

* Efficient mutation of observable arrays
  - While doing:

  ```ts
  let numbers = ko.observable([]);
  for (i = 0; i < 100; i++) {
      numbers.push(i);
  }
  ```

  and

  ```ts
  let tempArray = [];
  for (i = 0; i < 100; i++) {
      tempArray.push(i);
  }
  let numbers = ko.observable(tempArray);
  ```

  Might look more or less equivalent the first example above can lead to SEVERE performance problems. In terms of observable   changes the first example queues 100 observable updates of one item each. The second example queues a single observable update   with 100 items.

  This is obviously a fictional example but let's say we were pushing data points to a series displayed on a chart that had   auto-scaling of it's axes turned on. Let's assume it takes 0.01 seconds to render an extra data point but 0.5 seconds to   recalcuate the scale of the x-axis and the y-axis every time the data is updated.

  In this case the first example would take 100 * (0.01 + 0.5) = 51 seconds to process all the changes. The second example   would take (100 * 0.01) + 0.5 = 1.5 seconds to process the changes. That is a *3400% difference*. Again, this is a made up   example but we have seen this mistake made by extension authors again and again that results in real performance problems.

  This is such a common problem the framework attempts to detect when an extension writes this type of code and warns them   with the message:

  Performance warning: A proxied observable array is mutated inefficiently.

  Generally this means you have somewhere in your code doing a repeated push() on an observable array (although there are a few  other inefficient array mutations it attempts to catch). If you ever see this warning in the console please take them time   to figure out what is going on and address the issue.

<a name="data-pureComputed">
<a name="overview-ko-purecomputed"></a>
### ko.pureComputed()

You might have noticed unlike `ko.reactor` or knockout's observable subscribe method the Portal's version of the knockout `pureComputed()` has not been modified to take a lifetime manager. Knockout has some good documentation on pureComputeds [here](http://knockoutjs.com/documentation/computed-pure.html) but in a nut shell the reason is that any knockout dependencies (which are the things that will pin a computed or observable in memory) associated with the pureComputed are allocated only when someone is listening to the pureComputed and are cleaned up as soon everyone stops listening to the pureComputed. This works great for 'pure' functions where there are no side effects which applies to the vast majority of cases where you would like to create a computed so you should always try to use a pureComputed as opposed to a ko.reactor. Here's an example to help you understand the difference between the two so you know when you need to use a reactor as opposed to a pureComputed:

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

Here incrementing `pureComputedCounter` or `reactorCounter` is a side-effect because it has no bearing on the value of the observables produced by the functions (`pure` and `reactor`). If you need a side effect use `ko.reactor()`. If you don't use `ko.pureComputed()`. (Note: if we had added `pure.subscribe(lifetime, (val) => console.log(val.toString()))` right after creating `pure` then `pureComputedCounter` would have been incremented to 3 as well because the pureComputed becomes live as soon as a listener is attached).

<a name="overview-the-ko-reactor-method"></a>
### The ko.reactor method

Any observables read in the function that are sent to `ko.reactor()` will become a dependency for that reactor.  The reactor will recompute whenever any of those observable values change. The same is true for the  `ko.pureComputed()` method  and the observable array's `map()` and `mapInto()` functions. This can lead to a situation where a computed is recalculating at times you never intended. For more information about `map` and `mapInto`, see [portalfx-data-projections.md#shaping-and-filtering-data](portalfx-data-projections.md#shaping-and-filtering-data).

Whenever you write a pureComputed or a reactor it's always a good idea to put a breakpoint in the computed function and see when and why. We have seen computed functions that should run once actually run 30+ time and waste CPU time recalculating things that didn't need to be recalculated. If another computed takes a dependency on that computed the problem grows expontentially.

This is actually such a common problem the framework has code that attempts to detect problematic computed functions. When a computed is created that has dependencies on 30 or more other observables the shell will output an error to the console. This should be an 
indication to the extension author the computed has likely picked up unnecessary dependencies and is wasting time recomputing when  those dependencies change.

There are a few strategies you can use to ensure your computed only calculates when you intend it to:

* Try to avoid calling other functions in your computed method. When the entire implementation of the computed is visible in one place it's not too hard to scan the code and figure out what observables are dependencies of the function. If you write something like:

```ts
let computed = ko.pureComputed(() => {
    let foo = this.foo();
    this._processfoo(foo);
});
```

And `_processFoo()` calls three more helper methods it becomes a lot of work to figure out which observables will cause `computed()` to 
recalculate.

* Use the explicit dependency overload of ko.reactor()/ko.pureComputed(). There is an overload of those functions that takes as a second parameter a list of observables to subscribe to. When this overload is used an observable that is read is the computed function will not become a dependency. No matter what code is called inside the body of the computed you can be sure it will only recalculate when the observables you listed as dependencies are changed.

* Use ko.ignoreDependencies() inside your computed function. Doing:

```ts
let computed = ko.reactor(lifetime, () => {
    let foo = this.foo();
    let bar = this.bar();
    ko.ignoreDependencies(() => {
        this._processFoo(foo, bar);
    });
});
```

Is equivalent to doing:

```ts
let computed = ko.reactor(lifetime, [this.foo, this.bar], (foo, bar) => {
    this._processFoo(foo, bar);
});
```

(The second just looks a lot cleaner).
