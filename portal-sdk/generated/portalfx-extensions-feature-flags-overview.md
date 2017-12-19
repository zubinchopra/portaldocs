
<a name="extension-flags"></a>
# Extension flags
    
There are three types of flags that are associated with extensions. Using these flags allows the developer to make modifications to the server, to the browser, and to the extension code, regardless of the environment in which the extension is being tested.  Consequently, the purpose of each type of flag is similar but not identical. For example, flags that modify the environment in which the extension is running, instead of the extension itself, are either trace mode flags or diagnostic switches. 

* [portalfx-extensions-feature-flags-trace-mode.md](portalfx-extensions-feature-flags-trace-mode.md)

  These instructions to the debugging environment will temporarily set specific server characteristics, toggle a specific behavior, or enable the logging of specific types of events. 

* [portalfx-extensions-feature-flags-diagnostics.md](portalfx-extensions-feature-flags-diagnostics.md)

  These are directives to JavaScript. For example, the `clientOptimizations` flag is a directive to the browser instead of the portal extension that is running in the browser. Switches that have functionality other than selecting content for the browser `console.log` are outside of the scope of this document.
  
* [portalfx-extensions-feature-flags-developer.md](portalfx-extensions-feature-flags-developer.md)

  These flags connect the extension to testing features that are within the Azure API. Developers can create and maintain their own flags.

*  [portalfx-extensions-feature-flags-shell.md](portalfx-extensions-feature-flags-shell.md)

  These flags connect the extension to testing features that are within the Azure API. The Shell features are maintained by the Azure Portal team.