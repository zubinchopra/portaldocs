<a name="the-debug-tool"></a>
## The debug tool

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

<a name="the-debug-tool-toggling-optimizations"></a>
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

<a name="the-debug-tool-restore-default-settings"></a>
### Restore default settings

The Portal tracks the state of the desktop for users as they navigate through the Portal. It stores the list of opened blades, active journeys, part selection status, and various other states of the Portal. At development time, it is often necessary to clear this information. If new parts are not displayed as expected, this is often the cause.

The default settings can be restored by  using the Settings pane, which is activated by clicking on the `settings` icon in the navigation bar, as in the following image.  

 ![alt-text](../media/portalfx-debugging/settings.png "Settings Pane")

<!-- TODO:  Validate that the 'apply' button should be used, instead of the label text -->
Next, click the `Restore default settings` option, as in the following image.  

 ![alt-text](../media/portalfx-debugging/restoreDefaultSettings.png "Restore Settings")

The Portal refreshes when the `Apply` button is clicked, and user settings are cleared.

