
# Extension flags
    
There are five types of flags that are associated with extensions. The purpose of each type of flag is similar but not identical. For example, flags that modify the browser in which the extension is running are not  flags that modify the extension itself. Extension flags are invoked by appending them to the query string, as in the following example: `https://portal.azure.com/?<extensionName>_<extensionFlag>=<value>`, where ```extensionFlag```, without angle brackets, is the feature to enable for the extension named `extensionName`.

Using these flags allows the developer to make modifications to the server, to the browser, and to the extension code, or make use of Azure-supplied extensions, regardless of the stage in which the extension is being tested.  

**NOTE**: Features that are invoked through the extensiondefinition are outside of the scope of this document.

The following table specifies the flags that can be used with the Azure portal and its extensions, categorized by the type of flag.

| Flag | Purpose | Document | 
| -- | -- | -- |
| Trace mode | Instructions to the debugging environment. Temporarily set server characteristics, toggle a behavior, or enable event logging. | [portalfx-extensions-feature-flags-trace-mode.md](portalfx-extensions-feature-flags-trace-mode.md) |
| Developer features | Allow the extension to specify its own features. Developers can create and maintain their own flags. |  [portalfx-extensions-feature-flags-developer.md](portalfx-extensions-feature-flags-developer.md)  |
| Shell flags | Connect the developer's extension to Azure API features. The Shell features are maintained by the Azure Portal team. Shell features do not require changes to the code in the extension. |  [portalfx-extensions-feature-flags-shell.md](portalfx-extensions-feature-flags-shell.md) |


<!-- The following sentence is from portalfx-domain-based-configuration-pattern.md. -->
  Changing the default feature flags that are sent to the extension requires Shell configuration changes and redeployment.