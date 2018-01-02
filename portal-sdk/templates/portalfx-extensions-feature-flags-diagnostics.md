
## Diagnostic switches

 <!--TODO:  Validate that this statement is accurate for Azure Portal -->
 A variety of diagnostic switches can be used when debugging an extension. Diagnostic switches are slightly different from trace switches in that diagnostics may be controlled by the system, whereas traces are more dependent upon the logic of the code that is being debugged.

 Diagnostic switches are invoked by appending them to the query string, as in the following example: `https://portal.azure.com/?<diagnosticSwitch>=<value>`. The keyboard shortcut CTRL+ALT+D toggles the visibility of the debug tool, as specified in [portalfx-extensions-debugging-overview.md](portalfx-extensions-debugging-overview.md). The yellow sticky that is located at the bottom on the right side of the window can be used to toggle client optimizations and other diagnostic switches.

 The diagnostic switches are in the following list.

**clientOptimizations**: Turns off bundling and minification of JavaScript to make debugging easier.    A value of `true` turns on bundling and minification,  and a value of `false` turns them both off. A value of `bundle` turns off JavaScript minification but retains bundling so the Portal still loads fairly quickly.  The value `bundle` is the suggested value for Portal extension debugging. 
<!-- Determine whether the following note is what was meant by "The 'bundle' value turns off JavaScript minification but retains bundling so the Portal still loads fairly quickly (which it doesn't for 'false' when bundling is turned off and many loose JavaScript files are loaded).". -->
**NOTE**:  A value of  `false` turns off bundling, but does not unload JavaScript files that were loaded.  
**Recommendation**:  When debugging an extension, the developer should supply `false` for this flag to disable script minification and to turn on additional diagnostics.

  **NOTE**:  This applies to both the portal and extensions source. If testing extensions that are already deployed to production, use the **clientOptimizations** flag instead of the ***IsDevelopmentMode** appSetting. If working in a development environment instead, use the ***IsDevelopmentMode** appSetting instead of the **clientOptimizations** flag to turn off bundling and minification for this extension only. This will speed up portal load during development and testing.  To change the ***IsDevelopmentMode** appSetting, locate the appropriate `web.config` file and change the value of the ***IsDevelopmentMode** appSetting to `true`.

<!--TODO:  Determine whether the nocdn flag is a shell flag or a service flag instead of a diagnostics flag -->

  **nocdn**: A value of `true` will bypass the CDN when loading resources for the portal only. A value of `force` will bypass the CDN when loading resources for the portal and all extensions.
