
<a name="debugging-extensions-that-use-knockout"></a>
## Debugging Extensions that use Knockout

All of the Azure UI data that comes from the view model (i.e., the `ViewModel` object that is bound to the HTML source)  is bound to the user interface by  the **Knockout** (KO) JavaScript library. As a result, when something does not display correctly on the screen, generally there is a discrepancy between the ViewModel and the framework code. This section discusses solutions for oddities that may be  encountered in the UI.

<a name="debugging-extensions-that-use-knockout-knockout-commands"></a>
### Knockout Commands

One of the most useful commands when debugging knockout user interfaces is in the following code.

```ko.dataFor(element)```

This command returns the ViewModel that is bound to the specified element via Knockout (KO). The object can be accessed by the element name that is stored in the Document Object Model (DOM). Also, in most modern browsers, `$0` will return the currently selected element in the elements pane. To access the object that is data bound to the UI, which is often the contents of the ViewModel object, select the element in the elements pane, and then run the following command:
``` ko.dataFor($0)```.

This allows the developer to observe and examine live data at runtime. For **Intellisense** support you can perform  the same action, but assign it to a variable, as in the following example.

```var viewModel = ko.dataFor($0)```

**NOTE**: The debugger is not actually using your ViewModel. Instead, it makes available a copy of your ViewModel in the shell side of the `iframe`, and keeps it in sync with the ViewModel that is actually in the `iframe` by using a tool that is named the Proxy Observable (PO), as specified in [https://www.npmjs.com/package/proxy-observable](https://www.npmjs.com/package/proxy-observable).  For now, it is probably best to recognize that it is not the same ViewModel, but can be treated mostly as such, because most bugs  are not associated with issues in the proxy observable layer.  

For more information about debugging Knockout, see the following videos.

* ***Using ko.dataFor to get the view model of an element***

  [https://auxdocs.blob.core.windows.net/videos/koDataFor.mp4](https://auxdocs.blob.core.windows.net/videos/koDataFor.mp4)

* ***Using subscribe to figure out what causes observable changes to  view model properties***

  [https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4](https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4)

*  ***How to get call stacks from across iframes***

    [https://auxdocs.blob.core.windows.net/videos/messageContext.mp4](https://auxdocs.blob.core.windows.net/videos/messageContext.mp4)

### What Causes Data Changes

Often, the focus of debugging is not the contents of the data variables,  but rather what caused the data to change. Fortunately, determining where changes came can be fairly straightforward. You can subscribe to the `observable` for any changes. The `subscribe` API in **Knockout** takes a callback that allows you to execute code.

### Knockout and the JavaScript debugger

The JavaScript `debugger` keyword, as described in  [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger), will tell the browser to break when the code encounters the keyword. The process to do this is as follows.

1. Access the ViewModel by using  `ko.dataFor`, as in the following statement.
  
    ```   var myProperty = ko.dataFor($0).observablePropertyICareAbout;   ```

1.  Subscribe to the ViewModel, as in the following statement.
  
    ``` myProperty.subscribe(function (value) { debugger; }) ```

This causes the debugger to break whenever the specified property changes. After the injected breakpoint is encountered, the call stack can be examined to detemine what caused this to trigger. The variable ```value``` is the new value being set to your observable.

For more information about the Knockout `subscribe` method and observable changes to  view model properties, see   [https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4](https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4).

### Crossing the iframe boundary

Previously, the perspective was that all of the extension debugging was in a single `iframe`, even though  multiple `iframes` can exist. Actually, both `iframes` can change, and do change, values in response to one another.

This section discusses how to figure out where changes are coming from when they originate from a different iframe. 

**NOTE**:  Unlike [#debugging-extensions-that-use-knockout](#debugging-extensions-that-use-knockout) and [#debugging-the-data-stack](#debugging-the-data-stack), this is very Portal specific. You may want to review Azure Portal architecture, as specified in   [top-extensions-architecture.md](top-extensions-architecture.md), previous to continuing with `iframe` testing.

1. To debug an extension that sends information across multiple `iframes`, the Portal should be loaded with diagnostics turned on, by setting the  flag `?trace=diagnostics`.  Without this flag, callstacks are not captured across `iframes` for performance reasons.  If this debugging is occurring in a  non-development environment, then client optimizations should be turned off by setting `clientOptimizations=false`. Otherwise, the test session will be debugging minified code.

1. Next, the test session should break at a point where an observable is changing, as in the following code.

    ```json
    ko.dataFor($0).observablePropertyICareAbout.subscribe(function (value) { debugger; })
    ```

1. At that point, you can leverage the framework to see the callstack across `iframes`.  The following call returns the combined callstack of the current frame to the bottom of the stack that is associated with the other iframe.

```json
MsPortalFx.Base.Rpc.Internal.messageContext.callStack
```

**NOTE**: Do not put this line of code in your actual source.  It will not run properly without diagnostics turned on, and it will not work in the production environment. 

<!--TODO:  determine whether  "real callstack" means "realtime callstack". -->

**NOTE**: This code  traverses the `iframe` boundary only once.  Also, it is not a real callstack because the call across `iframes` is asynchronous.  To go further back, the test session requires a breakpoint on the other `iframe`, so you can repeat this process until you find the code you are seeking.

For more information about getting call stacks across `iframes`, see [https://auxdocs.blob.core.windows.net/videos/messageContext.mp4](https://auxdocs.blob.core.windows.net/videos/messageContext.mp4).

For more information:

* Knockout.js Troubleshooting Strategies

    [http://www.knockmeout.net/2013/06/knockout-debugging-strategies-plugin.html](http://www.knockmeout.net/2013/06/knockout-debugging-strategies-plugin.html)

* Essential Knockout and JavaScript Tips

    [https://app.pluralsight.com/library/courses/knockout-tips/table-of-contents](https://app.pluralsight.com/library/courses/knockout-tips/table-of-contents)