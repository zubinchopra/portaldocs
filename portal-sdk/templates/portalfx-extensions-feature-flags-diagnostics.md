
## Diagnostic switches

 <!--TODO:  Validate that this statement is accurate for Azure Portal -->
 A variety of diagnostic switches can be used when debugging an extension. Diagnostic switches are slightly different from trace switches in that diagnostics may be controlled by the system, whereas traces are more dependent upon the logic of the code that is being debugged.

 The diagnostic switches are in the following list.

**clientOptimizations**: Turns off bundling and minification of JavaScript to make debugging easier.    A value of `true` turns on bundling and minification,  and a value of `false` turns them off.

  **NOTE**:  This applies to both the portal and extensions source. If testing extensions that are already deployed to production, use the **clientOptimizations** flag instead of the ***IsDevelopmentMode** appSetting. If working in a development environment instead, use the ***IsDevelopmentMode** appSetting instead of the **clientOptimizations** flag to turn off bundling and minification for this extension only. This will speed up portal load during development and testing.  To change the ***IsDevelopmentMode** appSetting, locate the appropriate `web.config` file and change the value of the ***IsDevelopmentMode** appSetting to `true`.
