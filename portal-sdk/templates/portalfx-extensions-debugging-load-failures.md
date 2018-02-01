## Debugging extension load failures

You can check if the  extension is loaded in the debug panel (CTRL+ALT+D) by clicking 'Loaded extensions', as in the following example.

![alt-text](../media/portalfx-debugging/loadedExtensions.png "Loaded Extensions")

If the extension throws an error while trying to load, try clicking on the url in the console. That will lead to the location on the client computer where the extension is running. The browser should display a blank web page. If the extension is available for the shell to load, the Portal will display a page similar to the following image.

![alt-text](../media/portalfx-debugging/extensionPageError.png "Blank page returned by an extension")

Extensions load failures are logged along with an associated failure code.  This error code is printed out as part of the error message logged by the client trace controller. A list of failure codes and what they mean is located at [portalfx-extensions-status-codes.md](portalfx-extensions-status-codes.md).

If the extension is not loaded, or if the extension site is not running, another guide that may be of assistance is "Creating an Extension", located at [portalfx-extensions-create-blank-procedure.md](portalfx-extensions-create-blank-procedure.md).
