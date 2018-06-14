## Frame Blades

FrameBlades provide an alternative programming model for developing UI in Ibiza. This alternative gives the extension author full control over the DOM via an IFrame. Fx controls cannot be used within FrameBlades. 

Because Frame blades do not use Ibiza Fx controls, extension developers are fully responsible for accessibility, theming, and consistency.

While this programming model results in maximum flexibility, it  also adds a significant burden of accessibility, theming, and consistency on the developer.   We recommend using Frame blades under the following conditions.

*  An existing web experience needs to be migrated to Ibiza without being re-implemented
*  An existing web experience needs to be hosted in many environments where Ibiza is just one of the hosts
* Developers want to implement user interactions and experiences that are not supported by Ibiza Framework components. For example, you need to build a very rich, custom UX that is not likely to be reused across services.

When using AppBlade, developers are responsible for the following.

* Accessibility

    Making the blade accessible, as specified in [portalfx-accessibility.md](portalfx-accessibility.md)

* Theming

    The extension's UI should always reflect the user's currently selected theme, and should react dynamically when the user changes themes

* Consistent Look & feel

    Designing a visual experience that is consistent with the rest of Ibiza

* Controls

    Building your own controls, or using available alternatives to Ibiza Fx controls

## Sending messages between the IFrame and Ibiza Fx

The FrameBlade view model is hosted in the hidden IFrame in which the extension is loaded. This is just like TemplateBlades. However, the contents of the FrameBlade are hosted in a different IFrame that is visible on the screen. The Ibiza extension IFrame and the UI IFrame communicate by sending and receiving messages, as described in [https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage).

## Creating a FrameBlade

The following sample demonstrates how to create a FrameBlade. It illustrates a few key concepts.

1. Adding the standard Ibiza command bar to the top of your blade

1. Communicating between your IFrame and your blade `ViewModel`

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

1. Create an iframe that includes the html, like the one located at `<dir>/Content/SamplesExtension/framebladepage.html` and in the following example.

    ```html

    {"gitdown": "include-file", "file": 
    "../Samples/SamplesExtension/Extension/Content/SamplesExtension/framebladepage.html"}

    ```

1. Create the `ViewModel` that connects to the `html`, as in the code located at  `<dir>/Client/V2/Blades/FrameBlade/SampleFrameBlade.ts` and in the following example.

    {"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V2/Blades/FrameBlade/SampleFrameBlade.ts", "section": "top-blades-frameblades#viewmodel"}

1. The frame receives information with which to build the contents of the frame blade in the   `window.addEventListener` method. When the window receives all of the frame information, the `makeViewPresentableToUser()` method injects the final frame fields into the frame and signals the parent of the frame that its content should be revealed. Sending "revealcontent" to the parent window enables the parent to use blocking and non-blocking loading indicators as appropriate. The child frame sends  "initializationcomplete" to remove all loading indicators after all data is loaded and rendered. The child frame sends the 'ready' message when the Iframe completes the loading process. The code that connects the `ViewModel` to the extension is located at  `<dir>/Content/Scripts/framepage.js`, and is also in the following example.

    ```javascript
    {"gitdown": "include-file", "file": 
    "../Samples/SamplesExtension/Extension/Content/Scripts/framepage.js"}
    ```

The working sample can be viewed at [http://df.onecloud.azure-test.net/?feature.samplesextension=true#blade/SamplesExtension/SampleFrameBlade](http://df.onecloud.azure-test.net/?feature.samplesextension=true#blade/SamplesExtension/SampleFrameBlade).

## Sending messages between the IFrame and Ibiza Fx

The AppBlade `ViewModel` is hosted in the hidden IFrame in which the extension is loaded. However, the contents of the AppBlade are hosted in a different IFrame that is visible on the screen. The Ibiza extension IFrame and the UI IFrame communicate by sending and receiving messages. The following sections demonstrate how to exchange messages between the two IFrames and the Portal.

## Ibiza extension IFrame messaging

### Listen to a message

The extension can listen to messages that are sent from the UI IFrame to the Ibiza extension ViewModel by using the **on** method in the **AppBlade** ViewModel, as in the following example.

### Post a message

The Ibiza extension ViewModel can post messages to the UI IFrame by using the **postMessage** method in the AppBlade ViewModel, as in the following example.

## UI IFrame messaging

### Listen to a message

The extension can listen for messages that are sent from the Ibiza extension ViewModel to the UI Frame by adding an event listener to the application window, as shown in the following code.

The extension should also provide a handler for the incoming message. 

### Post a message

The  UI IFrame can post messages back to the Portal using the **postMessage** method. There is a required message that the  IFrame sends to the Portal to indicate that it is ready to receive messages.

## Changing UI themes

When using a FrameBlade, extension developers can implement themes. Typically, the user selects a theme, which in turn is sent to the UI IFrame. The following code snippet demonstrates how to pass the selected theme to the UI IFrame using the **postMessage** method.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/AppBlade/ViewModels/AppBladeViewModel.ts", "section": "appBlade#postThemingInfo"}
