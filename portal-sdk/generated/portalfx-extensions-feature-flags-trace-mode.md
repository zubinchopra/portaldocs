
<a name="trace-mode-flags"></a>
## Trace Mode Flags

Trace mode flags are associated with code that exists inside the portal, and can be configured externally through the `.config` file. Trace mode is also enabled by appending flags to the end of the querystring.  For example, [https://portal.azure.com/?trace=diagnostics](https://portal.azure.com/?trace=diagnostics) will enable verbose debugging information in the console. The trace mode allows the developer to enable, disable, and filter tracking output.

The information that trace mode displays is associated with debugging, moreso than with regular operation of the extension. This information is an addition to standard console errors, and it can be used to monitor application execution and performance in a deployed environment.  The errors that are presented in the console assist in fixing extension issues. For more information about trace modes, see [https://docs.microsoft.com/en-us/dotnet/framework/debug-trace-profile/how-to-create-initialize-and-configure-trace-switches](https://docs.microsoft.com/en-us/dotnet/framework/debug-trace-profile/how-to-create-initialize-and-configure-trace-switches).

Often the errors that are displayed in the console can lead you down the path of fixing your issues. In addition to viewing the standard errors displayed in the console, it's often useful to load the portal in trace mode. 
 <!--TODO:  Verify whether this section contains all trace modes for the Azure Portal. -->

Trace modes are enabled by appending them to the query string, as in the following example: `https://portal.azure.com/?trace=<settingName>`, where ```settingName```, without angle brackets, is the type of trace to run on the extension. The Azure trace mode flags are in the following list.

**desktop**: Log all shell desktop operations. Useful for reporting errors to the alias.

**diagnostics**: Display the debug hub, and add verbose tracing. Also used to enable callstack capturing for all communication that occurs between iframes.

**inputsset.debug.viewModelOrPdlName**: Break into debugger when `onInputsSet` is about to be called on extension side. This trace can use the `viewmodel` name or the blade or part name to filter trace.

**inputsset.log.CommandViewModel**:  Add refinement to the selection of which view model to trace.

<!--TODO:  Validate how this works if onInputSet is being replaced. -->
**inputsset.log.viewModelOrPdlName**: Log in console when `onInputsSet` is about to be called on extension side. This trace can use the `viewmodel` name or the blade or part name to filter trace.

**inputsset.log.WebsiteBlade**: Further refine which view model to trace.

**inputsset.verbose.viewModelOrPdlName**: Log in the console every time the shell evaluates whether `onInputsSet` should be called. This trace can use the viewmodel name or the part or blade name to filter trace. 

**partsettings.viewModelOrPartName**: Shows writes and reads of settings for the specified part. This trace can use the `viewmodel` name or the part name to filter the trace. 

**usersettings**:  Show all writes and reads to the user settings service. Great for debugging issues that require a 'reset desktop'. 
