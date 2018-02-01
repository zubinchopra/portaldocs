
## Debugging console errors

The Portal logs a significant amount of information into the browser developer console. Often this surfaces common errors and problems.
Most modern browsers include tools that make it easy to debug JavaScript. To understand how the JavaScript debugging tools work in **Chrome**, view  "Chrome DevTools Overview" that is located at [https://developer.chrome.com/devtools](https://developer.chrome.com/devtools). For **Microsoft Edge**, the F12 tools guide is located at [https://docs.microsoft.com/en-us/microsoft-edge/f12-devtools-guide/debugger](https://docs.microsoft.com/en-us/microsoft-edge/f12-devtools-guide/debugger). The debugging tools in other popular browsers are outside of the scope of this document.  The following examples demonstrate Azure debugging techniques using the tools in **Internet Explorer**.  

To open up the **Internet Explorer** debugger tools, click the **F12** key. The console will not start logging messages unless it is already opened.  After opening the developer tools in the browser, locate and open the console, as in the following image.

![alt-text](../media/portalfx-debugging/browserConsole.png "Browser Console")

After opening the console, refresh the Portal to display all messages. Then, do a quick visual scan of the console log. Errors are written to the log in red, as in the following image.

![alt-text](../media/portalfx-debugging/consoleError.png "Error in Console")

<!-- TODO:  Verify whether the following sentence should be included in a document about developer tools and debugging.

As of 9/14/2016 the best, and fastest, Developer Tools are provided by Google Chrome.

-->
### Trace Modes

The errors that are presented in the console can be of great assistance in fixing extension issues. The trace mode that is included in the Portal will display information other than the standard console errors. Trace mode is enabled by appending a flag to the end of the query string. For example,  `https://portal.azure.com/?trace=diagnostics` will enable verbose debugging information in the console. For more information about trace modes, see [portalfx-extensions-feature-flags-trace-mode.md](portalfx-extensions-feature-flags-trace-mode.md). For other debugging services, see [portalfx-extensions-feature-flags.md](portalfx-extensions-feature-flags.md).