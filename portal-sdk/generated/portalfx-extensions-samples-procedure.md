<a name="procedures-for-portal-sample-source-code"></a>
## Procedures for Portal Sample Source Code

After installing Visual Studio and the Portal Framework SDK, you should be able to locate samples in the `...\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

Open the `SamplesExtension` solution file to experiment with samples in the IDE.

You may make changes to the samples in order to prepare to copy and modify for your own development efforts.

Click the F5 key to start debugging the samples extension. This will rebuild the project, which will allow you to check for items like the most recent version of the SDK.

Sideload the extension. When it loads, click on the "More Services" option in the menu, as in the following example.

 ![alt-text](../media/portalfx-extensions-samples/samples-services.png  "Portal Extensions Services")

In the filter box, search for "Azure Portal SDK". You can use shift + space to mark it as a favorite site.

 search (can favor as quick access)

Make changes to the sample that best fits the needs of the development project, then refresh the portal to view the changes. 

<a name="procedures-for-portal-sample-source-code-v1-versus-v2"></a>
### V1 versus V2

The samples are partially structured into two directories, **V1** and **V2**, as in the following example. 


As for V1 concepts, these are concepts we're asking extensions to avoid where there are V2 APIs that can be used:
- __PDL__
- __EditScope__
- __ParameterCollector/ParameterProvider__
- __"Blades containing Parts"__
- __Non-full-screen Blades__ -- that is, ones that open with a fixed width
- __V1 Blade-opening__ -- Selectable/SelectableSet APIs
- __V1 Forms__ -- using EditScope

Bear in mind that we don't have the V2 space entirely built out. In the meantime, you will have to use V1 APIs in places, even the V1 concepts listed above.