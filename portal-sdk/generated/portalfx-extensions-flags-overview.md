
<a name="overview"></a>
## Overview
    
There are three types of query string flags that are used with extensions to modify run-time behavior. The purpose of each type of flag is similar but not identical. The Azure Portal makes use of flag values by making modifications to the server or browser, to the shell, and to the extension at runtime. Portal query string flags can be differentiated by the naming convention that is used to invoke them.

* Some feature flags have their own names, like  `https://portal.azure.com/?<featureName>=<value>`

* Most feature flags are invoked with the  syntax: `https://portal.azure.com/?feature.<featureName>=true`

* Otherwise, flags are directives to the extension, in which case the syntax is `<extensionName>_<extensionFlag>=<value>`

**NOTE**: Features that are invoked through `extensiondefinition` are outside of the scope of this document. For more information about using `extensiondefinition`, see `Microsoft.Portal.Framework.ExtensionDefinition` class.

The following table specifies the types of query string flags that are used with the Azure Portal.

| Flag               | Purpose | Document | 
| ------------------ | ------- | -------- |
| Trace mode         | Temporarily set server characteristics, toggle a behavior, or enable event logging. For the most part, trace mode does   not require changes to extension code. The exception is certain types of logging, as specified in [portalfx-logging-from-typescript-and-dotnet.md](portalfx-logging-from-typescript-and-dotnet.md). <br> Invoked with  `https://portal.azure.com/?trace=<settingName>`.   | [portalfx-extensions-flags-trace.md](portalfx-extensions-flags-trace.md) |
| Extension Flags | Allow developers to specify features that they maintain. <br>Invoked with `https://portal.azure.com/?<extensionName>_<extensionFlag>=<value>`.   |  [portalfx-extensions-flags-extension.md](portalfx-extensions-flags-extension.md)  |
| Shell flags        | Connect the developer's extension to features that are maintained by the Azure Portal team. Shell features do not require changes to the code in the developer's extension.<br> Invoked with  `https://portal.azure.com/?feature.<featureName>=<value>`.   |  [portalfx-extensions-flags-shell.md](portalfx-extensions-flags-shell.md) |
  
<!-- The following sentence is from portalfx-domain-based-configuration-pattern.md. -->
  Changing the default feature flags that are sent to the extension requires Shell configuration changes and redeployment.