
# Extension flags and Feature Flags
    
There are three types of flags that are associated with extensions. The purpose of each type of flag is similar but not identical. The extension makes use of a flag's value by making modifications to the server, to the browser, and to the extension at runtime.

**NOTE**: Features that are invoked through `extensiondefinition` are outside of the scope of this document. For more information about using `extensiondefinition`, see [portalfx-parameter-collection-getting-started.md](portalfx-parameter-collection-getting-started.md) and the `Microsoft.Portal.Framework.ExtensionDefinition` class.

The following table specifies the types of flags that can be used with the Azure portal.

| Flag               | Purpose | Document | 
| ------------------ | ------- | -------- |
| Trace mode         | Invoked with  `https://portal.azure.com/?trace=<settingName>`. <br> Temporarily set server characteristics, toggle a behavior, or enable event logging.  | [portalfx-extensions-feature-flags-trace-mode.md](portalfx-extensions-feature-flags-trace-mode.md) |
| Developer features |  Extension flags that are invoked with `https://portal.azure.com/?<extensionName>_<extensionFlag>=<value>`. <br> Allow the extension developers to specify features that they maintain. |  [portalfx-extensions-feature-flags-developer.md](portalfx-extensions-feature-flags-developer.md)  |
| Shell flags        |  Feature flags that are invoked with  `https://portal.azure.com/?<featureName>=<value>`. <br> Connect the developer's extension to features that are maintained by the Azure Portal team. Shell features do not require changes to the code in the extension. |  [portalfx-extensions-feature-flags-shell.md](portalfx-extensions-feature-flags-shell.md) |

<!-- The following sentence is from portalfx-domain-based-configuration-pattern.md. -->
  Changing the default feature flags that are sent to the extension requires Shell configuration changes and redeployment.