
## AppBlades

AppBlade provides an IFrame where an extension can render content, which results in maximum flexibility and reduces additional developer responsibilities. We recommend using AppBlades under the following conditions.

* An existing extension that should be migrated to Ibiza without needing to be re-implemented 
* Developers want to implement user interactions and experiences that are not supported by Ibiza Framework components
*  An existing extension needs to be re-hosted in several environments

When using AppBlade, developers are responsible for the following.

* Accessibility

    Making the blade accessible, as specified in [portalfx-accessibility.md](portalfx-accessibility.md)

* Theming

    The extension should respond to theming behavior

* Consistent Look & feel

    Designing a visual experience that is consistent with the rest of Ibiza

* Controls

    Building your own controls, or using available alternatives to Ibiza Fx controls

## Creating an AppBlade

1. Add the blade definition to your PDL file, as in the following example.

    ```xml
    <AppBlade Name="MicrosoftDocs"
            ViewModel="{ViewModel Name=MicrosoftDocsBladeViewModel, Module=./Summary/ViewModels/MicrosoftDocsBladeViewModel}"
            InitialDisplayState="Maximized">
    </AppBlade>
    ```

1. Create a ViewModel TypeScript class. The following code snippet displays the ViewModel for the template blade defined in the previous step. In this case, it is showing the docs.microsoft.azure.com by using  an AppBlade in the Portal.

    ```javascript
    export class MicrosoftDocsBladeViewModel extends MsPortalFx.ViewModels.AppBlade.ViewModel {
        constructor(container: FxViewModels.ContainerContract, initialState: any, dataContext: any) {

            super(container, {
                source: 'https://docs.microsoft.com/'
            });

            this.title("docs.microsoft.com");
        }
    }
    ```

**NOTE**: The source location for the contents of the IFrame is sent to the container by using the `source` property.

## The Ibiza command bar

The Ibiza command bar can optionally be used in an AppBlade to leverage Framework support and make Azure navigation a more consistent experience. To use a command bar, add it to the PDL file for the extension PDL and configure it in the AppBlade ViewModel, as in the following example.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/AppBlade/ViewModels/AppBladeViewModel.ts", "section": "appBlade#commandBar"}

There should also be a command button on the command bar, as in the following example.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/AppBlade/ViewModels/AppBladeViewModel.ts", "section": "appBlade#commandBarButton"}

## Sending messages between the IFrame and Ibiza Fx

The AppBlade ViewModel is hosted in the hidden IFrame in which the extension is loaded. However, the contents of the AppBlade are hosted in different IFrame that is visible on the screen. The Ibiza extension IFrame and the UI IFrame communicate by sending and receiving messages. The following sections demonstrate how to exchange messages between the two IFrames and to the Portal.

## Ibiza extension IFrame messaging

* Listen to a message

    The extension can listen to messages that are sent from the UI IFrame to the Ibiza extension ViewModel by using the **on** method in the **AppBlade** ViewModel, as in the following example.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/AppBlade/ViewModels/AppBladeViewModel.ts", "section": "appBlade#listenForMessageFromIFrame"}

*  Post a message

    The Ibiza extension ViewModel can post messages to the UI IFrame by using the **postMessage** method in the AppBlade ViewModel, as in the following example.

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/AppBlade/ViewModels/AppBladeViewModel.ts", "section": "appBlade#postMessageToIFrame"}

## UI IFrame messaging

* Listen to a message

  The extension can listen for messages that are sent from the Ibiza extension ViewModel to the UI Frame by adding an event listener to the application window, as shown in the following code.

  {"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Content/SamplesExtension/appBladeSampleIFrame.html", "section": "appBlade#listenMessageFromPortal"}

  The extension should also provide a handler for the incoming message. In the following example, the **receiveMessage** method handles three different incoming message types, and reacts to theming changes in the Portal.

  {"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Content/SamplesExtension/appBladeSampleIFrame.html", "section": "appBlade#listenMessageFromPortalHandler"}

*  Post a message

  The  UI IFrame can post messages back to the Portal using the **postMessage** method. There is a required message that the  IFrame sends to the Portal to indicate that it is ready to receive messages.

  The following code snippet demonstrates how to post the  required message, in addition to posting other messages.

  {"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Content/SamplesExtension/appBladeSampleIFrame.html", "section": "appBlade#postMessageToPortal"}

## Changing UI themes

When using a template blade, extension developers can implement themes. Typically, the user selects a theme, which in turn is sent to the UI IFrame. The following code snippet demonstrates how to pass the selected theme to the UI IFrame using the **postMessage** method,  as specified in the section named [Exchanging messages between the IFrame and Ibiza Fx](#exchanging-messages-between-the-iframe-and-ibiza-fx).

{"gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Blades/AppBlade/ViewModels/AppBladeViewModel.ts", "section": "appBlade#postThemingInfo"}