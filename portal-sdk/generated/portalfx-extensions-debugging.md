
<a name="debugging-an-extension"></a>
# Debugging an Extension

<!--  required Intro section has moved to the overview document for this topic. -->

<!--  required section -->
<a name="debugging-an-extension-conceptual-overview"></a>
## Conceptual Overview


<a name="debugging-an-extension-introduction"></a>
## Introduction

Occasionally, difficulties may be encountered while developing an extension. When that happens, the debug tool that is contained in the Portal can help remove obstacles.  

Other samples and tools are also available to assist in the debugging process.  Any that are not included in the context of the discussion are  included in [portalfx-extensions-samples.md](portalfx-extensions-samples.md).    

Here are a few tips that help get extension development back on track. If you still have questions, reach out to Ibiza team in by using the Stackoverflow tags as specified in [StackOverFlow Forums](portalfx-extensions-stackoverflow.md).

<a name="debugging-an-extension-overview"></a>
## Overview

<a name="debugging-an-extension-overview-using-the-debug-tool"></a>
### Using the Debug Tool
The Portal contains a debug tool to aid with extension development. The keyboard shortcut CTRL+ALT+D toggles the visibility of the debug tool, as in the following image.

 ![alt-text](../media/portalfx-debugging/debugMode.png "Portal Debug Tool")

When visible, the tool overlays stickys onto Portal parts, and onto the Portal window itself. The stickys provide quick statistics and fast access to specific types of testing functionality.

The sticky that is associated with the application window is located at the bottom on the right side of the window.  It provides the following  information and functionality.

* **Version**:  The version of the Portal
* **Load time**: The amount of time that was required for the extension to load. <!-- TODO: Validate whether the following sentence is accurate:    This number has a direct impact on the create success rate of the extension.     -->
* **Client optimizations**: Turns on or off client optimizations such as minification and bundling.
* **User settings**:  The list of settings is as follows.
  * **Dump**: Logs all user settings to the console.
  * **Clear**: Resets a user's startboard and all other customizations. This feature is equivalent to clicking ```Settings -> Discard modifications```.
  * **Save**: Reserved for automated `Selenium` testing purposes.
* **Telemetry**: Allows the user to send telemetry to the server in batches. This feature is only for automated `Selenium` testing purposes.
* **Portal services**: Dumps information about Portal services. This feature is reserved for runtime debugging for the shell team.
* **Enabled features**: A list of features that are currently enabled.
* **Loaded extensions**: Provides a list of all extensions that are currently loaded and their load times. Clicking an extension name will log information to the console, including the extension definition and manifest.


The stickys that are associated with each part provide the following information.
<!-- Determine whether information is ever logged to any destination other than the console.  If so, document how to change the destination.  If not, this phrase can be shortened. -->
* **The name and owning extension**: Displays the name of the blade or part and the name of the extension that is the parent of the blade or part. Clicking on this logs debugging information to the console including the composition instance, view model and definition.
<!-- How is performance information selected? -->
* **Revealed**: The revealed time and all other performance information that is logged by that part or

* **ViewModel**: contains the following functionality.
    * **Dump**: dumps the view model to the console for debugging purposes. Display its name, parent extension and load time. Click on the div to log more information such as the part definition, view model name and inputs.
    * **Track**: dump the view model observables
* **Deep link**: Optional. Links to the blade.

<a name="debugging-an-extension-overview-toggling-optimizations"></a>
### Toggling optimizations

Bundling and minification can be enabled or disabled for debugging.

The following modes are available.
* `true`: All optimizations are enabled
* `false`: All optimizations are turned off
* `bundle`: Files are bundled together, but they are not minified. This mode assists in debugging non-minified code with friendly names, and enables a reasonably fast Portal on most browsers.
* `minify`: Files are minified however not bundled

To set the optimizations mode for the Portal and all extensions, use the following query string.

`https://portal.azure.com/?clientoptimizations=<value>`

where

**value**: One of the previously-specified four modes, without the angle brackets.

To set the optimization mode for a specific extension only, use the following code.

`https://portal.azure.com/?<extensionName>_clientoptimizations=<value>`

where

**extensionName**: Matches the name of the extension as specified in the extension configuration file. Do not use the angle brackets.  For more information about the configuration file, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

**value**:  One of the previously-specified four modes, without the angle brackets.

The `IsDevelopmentMode` setting can be used on the server to alter the default optimization settings for the extension. for more information about the  `IsDevelopmentMode` setting and its alternatives, see [portalfx-extensions-feature-flags-diagnostics.md](portalfx-extensions-feature-flags-diagnostics.md).

<a name="debugging-an-extension-overview-restore-default-settings"></a>
### Restore default settings

The Portal tracks the state of the desktop for users as they navigate through the Portal. It stores the list of opened blades, active journeys, part selection status, and various other states of the Portal. At development time, it is often necessary to clear this information. If new parts are not displayed as expected, this is often the cause.

The default settings can be restored by  using the Settings pane, which is activated by clicking on the `settings` icon in the navigation bar, as in the following image.  

 ![alt-text](../media/portalfx-debugging/settings.png "Settings Pane")

<!-- TODO:  Validate that the 'apply' button should be used, instead of the label text -->
Next, click the `Restore default settings` option, as in the following image.  

 ![alt-text](../media/portalfx-debugging/restoreDefaultSettings.png "Restore Settings")

The Portal refreshes when the `Apply` button is clicked, and user settings are cleared.

<a name="debugging-an-extension-overview-checking-the-console-for-errors"></a>
### Checking the console for errors

The Portal logs a significant amount of information into the browser developer console. Often this surfaces common errors and problems.
Most modern browsers include tools that make it easy to debug JavaScript. To understand how the JavaScript debugging tools work in **Chrome**, view  "Chrome DevTools Overview" that is located at [https://developer.chrome.com/devtools](https://developer.chrome.com/devtools). For **Microsoft Edge**, the F12 tools guide is located at [https://docs.microsoft.com/en-us/microsoft-edge/f12-devtools-guide/debugger](https://docs.microsoft.com/en-us/microsoft-edge/f12-devtools-guide/debugger). The debugging tools in other popular browsers are outside of the scope of this document.  The following examples demonstrate Azure debugging techniques using the tools in **Internet Explorer**.  

To open up the **Internet Explorer** debugger tools, click the **F12** key. The console will not start logging messages unless it is already opened.  After opening the developer tools in the browser, locate and open the console, as in the following image.

![alt-text](../media/portalfx-debugging/browserConsole.png "Browser Console")

After opening the console, refresh the Portal to display all messages. Then, do a quick visual scan of the console log. Errors are written to the log in red, as in the following image.

![alt-text](../media/portalfx-debugging/consoleError.png "Error in Console")

<!-- TODO:  Verify whether the following sentence should be included in a document about developer tools and debugging.

As of 9/14/2016 the best, and fastest, Developer Tools are provided by Google Chrome.

-->
<a name="debugging-an-extension-overview-trace-modes"></a>
### Trace Modes

The errors that are presented in the console can be of great assistance in fixing extension issues. The trace mode that is included in the Portal will display information other than the standard console errors. Trace mode is enabled by appending a flag to the end of the query string. For example,  `https://portal.azure.com/?trace=diagnostics` will enable verbose debugging information in the console. For more information about trace modes, see [portalfx-extensions-feature-flags-trace-mode.md](portalfx-extensions-feature-flags-trace-mode.md). For other debugging services, see [portalfx-extensions-feature-flags.md](portalfx-extensions-feature-flags.md).

<a name="debugging-an-extension-overview-ensuring-the-extension-is-loaded"></a>
### Ensuring the extension is loaded

You can check if the  extension is loaded in the debug panel (CTRL+ALT+D) by clicking 'Loaded extensions', as in the following example.

![alt-text](../media/portalfx-debugging/loadedExtensions.png "Loaded Extensions")

If the extension throws an error while trying to load, try clicking on the url in the console. That will lead to the location on the client computer where the extension is running. The browser should display a blank web page. If the extension is available for the shell to load, the Portal will display a page similar to the following image.

![alt-text](../media/portalfx-debugging/extensionPageError.png "Blank page returned by an extension")

Extensions load failures are logged along with an associated failure code.  This error code is printed out as part of the error message logged by the client trace controller. A list of failure codes and what they mean is located at [portalfx-extensions-status-codes.md](portalfx-extensions-status-codes.md).

If the extension is not loaded, or if the extension site is not running, another guide that may be of assistance is "Creating an Extension", located at [portalfx-extensions-developerInit-procedure.md](portalfx-extensions-developerInit-procedure.md).

<a name="debugging-an-extension-overview-debugging-javascript"></a>
### Debugging JavaScript


In most cases, the code that is being debugged is part of the extension. To locate the source code files, press CTRL+P and search for the extension by name: ```<extensionName>ScriptsCore.js```, without the angle brackets, and open the file. All available source files can be searched using CTRL+SHIFT+F, as in the following image.

![alt-text](../media/portalfx-debugging/debugScript.png "Search for extension source")

To debug a specific view model, search for the code by class name. You can now set breakpoints, add watch variables, and step through the code as described in  the video guide named ***How to step through your code***, located at [https://developers.google.com/web/tools/chrome-devtools/javascript/step-code](https://developers.google.com/web/tools/chrome-devtools/javascript/step-code).

For more information about debugging JavaScript, view the video named ***Debugging tools for the Web***, located at [https://vimeo.com/157292748](https://vimeo.com/157292748).

<a name="debugging-an-extension-overview-debugging-the-data-stack"></a>
### Debugging the data stack

The data stack contains all the information that the browser associates with the current testing session.  If, for example, edit scope changes are not displayed in the query cache,  or if  a row in the grid is updated without immediately apparent cause, the data stack may provide some answers to the debugging process.  Here are tips on how to debug using the data stack.

* When working with a QueryCache or an EntityCache, the ```dump()``` method can be used to inspect the contents of the cache at any point. By default, the ```dump()``` method  will print the data to the console, but the data can be returned as objects using `dump(true)`.  Having the data accessible as objects enables the use of methods like  `queryCache.dump(true)[0].name()`.

* When the edited data is contained in an `EditScope` object, it is accessible via the root property on the `EditScope` object. If `EditScopeView` object is being used, then the edited data is available at `editScopeView.editScope().root` after the `editScope()` observable is populated. The original data can be viewed using the `getOriginal()` method, so to view the original root object, the code can perform the  `editScope.getOriginal(editScope.root)` method.

<a name="debugging-an-extension-overview-debugging-extensions-that-use-knockout"></a>
### Debugging Extensions that use Knockout

All of the Azure UI data that comes from the view model (i.e., the `ViewModel` object that is bound to the HTML source)  is bound to the user interface by  the Knockout(KO) JavaScript library. As a result, when something does not display correctly on the screen, generally there is a discrepancy between the ViewModel and the framework code. This section discusses solutions for oddities that may be  encountered in the UI.

<a name="debugging-an-extension-overview-debugging-extensions-that-use-knockout-knockout-commands"></a>
#### Knockout Commands

One of the most useful commands when debugging knockout user interfaces is in the following code.

```ko.dataFor(element)```

This command returns the View Model that is bound to the specified element via Knockout (KO). The object can be accessed by the element name that is stored in the Document Object Model (DOM). Also, in most modern browsers, `$0` will return the currently selected element in the elements pane. So, to access the object that is data bound to the UI (which is often the contents of the ViewModel object) select the element in the elements pane, and then run the following command:
``` ko.dataFor($0)```.

This allows the developer to observe and examine live data at runtime. For **Intellisense** support you can do the same thing, but assign it to a variable, as in the following example.

```var viewModel = ko.dataFor($0)```

**NOTE**: The debugger is not actually using your ViewModel. Instead, it makes available a copy of your ViewModel in the shell side of the iframe, and keeps it in sync with the ViewModel that is actually in the iframe by using a tool that is named the Proxy Observable (PO), as specified in [https://www.npmjs.com/package/proxy-observable](https://www.npmjs.com/package/proxy-observable).   For now, it is probably best to recognize that it is not the same ViewModel, but can be treated mostly as such, because most bugs  do not involve issues in the proxy observable layer.  

For more information about debugging Knockout, see the following videos.

* ***Using ko.dataFor to get the view model of an element***

  [https://auxdocs.blob.core.windows.net/videos/koDataFor.mp4](https://auxdocs.blob.core.windows.net/videos/koDataFor.mp4)

* ***Using subscribe to figure out what causes observable changes to  view model properties***

  [https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4](https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4)

*  ***How to get call stacks from across iframes***

    [https://auxdocs.blob.core.windows.net/videos/messageContext.mp4](https://auxdocs.blob.core.windows.net/videos/messageContext.mp4)

#### What Causes Data Changes

Often, the focus of debugging is not the contents of the data variables,  but rather what caused the data to change. Fortunately, determining where changes came can be fairly straightforward. You can subscribe to the observable for any changes. The `subscribe` API in Knockout takes a callback that allows you to execute code.

#### The JavaScript debugger

The JavaScript `debugger` keyword, as described in  [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger) will tell the browser to break when the code encounters the keyword. The process to do this is as follows.

1. Access the ViewModel via `ko.dataFor`, as in the following statement.
  
    ```   var myProperty = ko.dataFor($0).observablePropertyICareAbout;   ```

1.  Subscribe to the ViewModel, as in the following statement.
  
    ``` myProperty.subscribe(function (value) { debugger; }) ```

This causes the debugger to break whenever the specified property changes. After the injected breakpoint is encountered, the call stack can be examined to detemine what caused this to trigger. The variable ```value``` is the new value being set to your observable.

For more information about the Knockout `subscribe` method and observable changes to  view model properties, see   [https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4](https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4).

### Crossing the iframe boundary

Previously, the perspective was that all of the extension debugging was in a single iframe, even though  multiple iframes can exist. Actually, both iframes can change, and do change, values in response to one another.

This section discusses how to figure out where changes are coming from when they originate from a different iframe. Note: Unlike [#debugging-extensions-that-use-knockout](#debugging-extensions-that-use-knockout) and [#debugging-the-data-stack](#debugging-the-data-stack), this is very Portal specific. 

You may want to review Azure Portal architecture, as specified in   [portalfx-extensions-architecture.md](portalfx-extensions-architecture.md), previous to continuing with iframe testing.

To debug an extension that sends information across multiple iframes, the Portal should be loaded with diagnostics turned on, by setting the  flag `?trace=diagnostics`.  Without this flag, callstacks are not captured across iframes for performance reasons.  If this debugging is occurring in a  non-dev environment, then client optimizations should be turned off by setting `clientOptimizations=false`. Otherwise, the test session will be debugging minified code.

Next, the test session should break at a point where an observable is changing, as in the following code.

```json
ko.dataFor($0).observablePropertyICareAbout.subscribe(function (value) { debugger; })
```

At that point, you can leverage the framework to see the callstack across iframes.  The following call
 will return the combined callstack of the current frame to the bottom of the stack that is associated with  the other iframe.

```json
MsPortalFx.Base.Rpc.Internal.messageContext.callStack
```

**NOTE**: Do not put this line of code in your actual source.  It will not run properly without diagnostics turned on, and it will not work in the production environment. 

<!--TODO:  determine whether  "real callstack" means "realtime callstack". -->

**NOTE**: This code  traverses the iframe boundary only once.  Also, it's not a real callstack because the call across iframes is asynchronous.  To go further back, the test session requires a breakpoint on the other iframe, so you can repeat this process until you find the code you are seeking.

For more information about getting call stacks across iFrames, see [https://auxdocs.blob.core.windows.net/videos/messageContext.mp4](https://auxdocs.blob.core.windows.net/videos/messageContext.mp4).

For more information:

* Knockout.js Troubleshooting Strategies

    [http://www.knockmeout.net/2013/06/knockout-debugging-strategies-plugin.html](http://www.knockmeout.net/2013/06/knockout-debugging-strategies-plugin.html)

* Essential Knockout and JavaScript Tips

    [https://app.pluralsight.com/library/courses/knockout-tips/table-of-contents](https://app.pluralsight.com/library/courses/knockout-tips/table-of-contents)






## Best Practices

Methodologies exist that assist developers in improving the product while it is still in the testing stage. Some strategies include describing bugs accurately, including code-coverage test cases in a thorough test plan, and other items.

A number of textbooks are devoted to the arts of software testing and maintenance.  Items that have been documented here do not preclude industry-standard practices.

### :bulb: Productivity Tip

Typescript 2.0.3 should be installed on your machine. The typescript  version can be verified by executing the following command:

```bash
$>tsc -version
```

Also, Typescript files should be set up to Compile on Save.


   
## Stackoverflow Forums

The Ibiza team strives to answer the questions that are tagged with Ibiza tags on the Microsoft [Stackoverflow](https://stackoverflow.microsoft.com) Web site within 24 hours. If you do not receive a response within 24 hours, please email the owner associated with the tag. Third-party developers that have Stackoverflow questions should work with their primary contact.  If you do not yet have a primary contact, please reach out to our onboarding team at [mailto:ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com).

To help the Azure UI team answer your questions, the submissions are categorized into various topics that are marked with tags. 
To read forum submissions, enter the following in the address bar of your browser:

```https://stackoverflow.microsoft.com/questions/tagged/<ibizaTag>```

To ask a question in a forum, enter the following in the address bar of your browser.

```https://stackoverflow.microsoft.com/questions/ask?tags=<ibizaTag>```

where
 
**ibizaTag**:  One of the tags from the following table, without the angle brackets.

You can also click on the links in the table to open the correct Stackoverflow forum.
<!--TODO: Determine whether the following UserVoice categories also have Stackoverflow support. 
ibiza-notifications
ibiza-quotas
ibiza-samples-docs
-->

| Tag                                                                                                            | Owner               | Contact |
| -------------------------------------------------------------------------------------------------------------- | ------------------- | ------- |
| [azure-gallery](https://stackoverflow.microsoft.com/questions/tagged/azure-gallery)                            |                     | |
| [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza)                                            | Adam Abdelhamed         | |
| [ibiza-accessibility](https://stackoverflow.microsoft.com/questions/tagged/ibiza-accessibility)                | Paymon Parsadmehr   | [mailto:ibiza-accessibility@microsoft.com](mailto:ibiza-accessibility@microsoft.com) | 
| [ibiza-bad-samples-doc](https://stackoverflow.microsoft.com/questions/tagged/ibiza-bad-samples-doc)            | Adam Abdelhamed          | |
| [ibiza-blades-parts](https://stackoverflow.microsoft.com/questions/tagged/ibiza-blades-parts)                  | Sean Watson         | |
| [ibiza-breaking-changes](https://stackoverflow.microsoft.com/questions/tagged/ibiza-breaking-changes)          | Adam Abdelhamed          | |
| [ibiza-browse](https://stackoverflow.microsoft.com/questions/tagged/ibiza-browse)                              | Sean Watson         | |
| [ibiza-controls](https://stackoverflow.microsoft.com/questions/tagged/ibiza-controls)                          | Shrey Shirwaikar    | |
| [ibiza-controls-grid](https://stackoverflow.microsoft.com/questions/tagged/ibiza-controls-grid)                | Shrey Shirwaikar    | |
| [ibiza-create](https://stackoverflow.microsoft.com/questions/tagged/ibiza-create)                              | Balbir Singh        | |
| [ibiza-data-caching](https://stackoverflow.microsoft.com/questions/tagged/ibiza-data-caching)                  | Adam Abdelhamed          | |
| [ibiza-deployment](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment)                      | Umair Aftab         | |
| [ibiza-forms](https://stackoverflow.microsoft.com/questions/tagged/ibiza-forms)                                | Shrey Shirwaikar    | |
| [ibiza-forms-create](https://stackoverflow.microsoft.com/questions/tagged/ibiza-forms-create)                  | Paymon Parsadmehr; Shrey Shirwaikar | |
| [ibiza-hosting-service](https://stackoverflow.microsoft.com/questions/tagged/ibiza-hosting-service)            | Umair Aftab         | |
| [ibiza-kusto](https://stackoverflow.microsoft.com/questions/tagged/ibiza-kusto)                                |                     | |
| [ibiza-localization-global](https://stackoverflow.microsoft.com/questions/tagged/ibiza-localization-global)    | Paymon Parsadmehr   | |
| [ibiza-missing-docs](https://stackoverflow.microsoft.com/questions/tagged/ibiza-missing-docs)                  |                     | |
| [ibiza-monitoringux](https://stackoverflow.microsoft.com/questions/tagged/ibiza-monitoringux)                  |                     | |
| [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding)                      | Santhosh Somayajula                 | |
| [ibiza-performance](https://stackoverflow.microsoft.com/questions/tagged/ibiza-performance)                    | Sean Watson         | |
| [ibiza-reliability](https://stackoverflow.microsoft.com/questions/tagged/ibiza-reliability)                    | Sean Watson         | |
| [ibiza-resources](https://stackoverflow.microsoft.com/questions/tagged/ibiza-resources)                        | Balbir Singh        | |
| [ibiza-sdkupdate](https://stackoverflow.microsoft.com/questions/tagged/ibiza-sdkupdate)                        | Umair Aftab         | |
| [ibiza-security-auth](https://stackoverflow.microsoft.com/questions/tagged/ibiza-security-auth)                | Santhosh Somayajula | |
| [ibiza-telemetry](https://stackoverflow.microsoft.com/questions/tagged/ibiza-telemetry)                        | Sean Watson         | |
| [ibiza-test](https://stackoverflow.microsoft.com/questions/tagged/ibiza-test)                                  | Adam Abdelhamed          | |
| [ibiza-uncategorized](https://stackoverflow.microsoft.com/questions/tagged/ibiza-uncategorized)                |                     | |



<a name="debugging-an-extension-faqs-for-debugging-extensions"></a>
## FAQs for Debugging Extensions

<a name="debugging-an-extension-faqs-for-debugging-extensions-ssl-certificates"></a>
### SSL certificates

***How do I use SSL certs?***

[portalfx-extensions-faq-onboarding.md#sslCerts](portalfx-extensions-faq-onboarding.md#sslCerts)

* * *

<a name="debugging-an-extension-faqs-for-debugging-extensions-loading-different-versions-of-an-extension"></a>
### Loading different versions of an extension

***How do I load different versions of an extension?***

Understanding which extension configuration to modify is located at [portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify](portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify).

* * *

<a name="debugging-an-extension-faqs-for-debugging-extensions-other-debugging-questions"></a>
### Other debugging questions

***How can I ask questions about debugging ?***

You can ask questions on Stackoverflow with the tag [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza).



<a name="debugging-an-extension-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term                         | Meaning |
| ---                          | --- |
| data stack                   | Contains all the information that the browser associates with the current testing session. |
| deep link                    | A link that jumps directly into the extension within the Portal. Each deep link consists of the Portal URL, the target directory domain name or tenant id (e.g. microsoft.com), the type prefix (i.e. asset, resource, blade, browse, or marketplace), and the actual deep link target. |
| Document Object Model (DOM)  | A methodology that treats an  HTML, XHTML, or XML page as a tree structure that contains hierarchical objects. These nodes   represent every item  that is part of the document and can be manipulated programmatically. Visible changes to DOM nodes may be displayed in the browser. |
| iFrame                       | An inline frame that embeds a document within the current HTML document. | 
| Knockout                     | A standalone JavaScript implementation of the Model-View-ViewModel architecture. | 
| minification                 | The process of removing all unnecessary characters from source code without changing its functionality. These characters may be whitespace, newlines, comments, and other non-executable items that increase code readability. Minification reduces the amount of data that is transferred across the Internet, and can be interpreted immediately without being uncompressed. | 
| proxy observable (PO)        | A tool that synchronizes the ViewModel in an iframe with a copy of that ViewModel that is used by the Knockout debugger. | 
| Selenium                     | Software-testing framework for web applications that  provides a playback tool for authoring tests.  |
| startboard                   | |
| sticky                       | Provides quick statistics and fast access to specific types of testing functionality. |
| ViewModel                    | Holds all the data associated with the screen. Allows user data to be separated from context pane data and to persist through configuration changes. Also view model, View-Model. |



<a name="debugging-an-extension-for-more-information"></a>
## For More Information

The following links point to references that may assist in debugging the extension.

<a name="debugging-an-extension-for-more-information-azure"></a>
### Azure
   
1. Deploying the extension

    [portalfx-deployment.md](portalfx-deployment.md)
    
1. Testing in production

    [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md)

    [portalfx-testinprod.md](portalfx-testinprod.md)


<a name="debugging-an-extension-for-more-information-chrome"></a>
### Chrome

***Chrome DevTools Overview***

   [https://developer.chrome.com/devtools](https://developer.chrome.com/devtools)
     
***Debugging tools for the Web***

   [https://vimeo.com/157292748](https://vimeo.com/157292748)

<a name="debugging-an-extension-for-more-information-edge-f12-developer-tools"></a>
### Edge F12 Developer Tools
    
   [https://docs.microsoft.com/en-us/microsoft-edge/f12-devtools-guide/debugger](https://docs.microsoft.com/en-us/microsoft-edge/f12-devtools-guide/debugger)

<a name="debugging-an-extension-for-more-information-javascript"></a>
### JavaScript

***How to step through your code***

   [https://developers.google.com/web/tools/chrome-devtools/javascript/step-code](https://developers.google.com/web/tools/chrome-devtools/javascript/step-code)

<a name="debugging-an-extension-for-more-information-knockout"></a>
### Knockout

***Knockout.js Troubleshooting Strategies***
    [http://www.knockmeout.net/2013/06/knockout-debugging-strategies-plugin.html](http://www.knockmeout.net/2013/06/knockout-debugging-strategies-plugin.html)


***Essential Knockout and JavaScript Tips***
    [https://app.pluralsight.com/library/courses/knockout-tips/table-of-contents](https://app.pluralsight.com/library/courses/knockout-tips/table-of-contents)

 ***Knockout debugging videos***

* ***Using ko.dataFor to get the view model of an element***
  [https://auxdocs.blob.core.windows.net/videos/koDataFor.mp4](https://auxdocs.blob.core.windows.net/videos/koDataFor.mp4)

* ***Using subscribe to figure out what causes observable changes to  view model properties***
  [https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4](https://auxdocs.blob.core.windows.net/videos/kosubscribe.mp4)

*  ***How to get call stacks from across iframes***
    [https://auxdocs.blob.core.windows.net/videos/messageContext.mp4](https://auxdocs.blob.core.windows.net/videos/messageContext.mp4)

<a name="debugging-an-extension-for-more-information-mozilla"></a>
### Mozilla

***Firefox Debugger***
    [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger)

<a name="debugging-an-extension-for-more-information-npm"></a>
### NPM

***Proxy Observable***

  [https://www.npmjs.com/package/proxy-observable](https://www.npmjs.com/package/proxy-observable)