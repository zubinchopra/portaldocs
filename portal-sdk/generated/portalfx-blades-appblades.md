
<a name="introduction-to-appblades"></a>
## Introduction to AppBlades

AppBlade provides an IFrame where an extension can render content, which results in maximum flexibility and reduces additional developer responsibilities.

We recommend using AppBlades under the following conditions.

* An existing experience that should be migrated to Ibiza without needing to be re-implemented 
* Developers want to implement user interactions and/or experiences that are not supported by the components in Ibiza framework
*  An existing experience needs to be re-hosted in several environments

When using AppBlade, developers are responsible for the following.

* Accessibility

    Making the blade accessible up to Microsoft standards

* Theming

    The extension should respond to theming behavior

* Consistent Look & feel

    Designing a visual experience that is consistent with the rest of Ibiza

* Controls

    Build your own controls, or use available alternatives to Ibiza Fx controls

<a name="introduction-to-appblades-creating-an-appblade"></a>
### Creating an AppBlade

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

<a name="introduction-to-appblades-the-ibiza-command-bar"></a>
### The Ibiza command bar

The Ibiza command bar can optionally be used in an AppBlade to leverage  Framework support and making Azure navigation a more consistent  experience. To use a command bar, add it to the PDL file for the extension PDL and configure it in the AppBlade ViewModel, as in the following example.

```typescript

// You can add command bars to app blades.
this.commandBar = new Toolbar(container);
this.commandBar.setItems([this._openLinkButton()]);

```

```typescript

private _openLinkButton(): Toolbars.OpenLinkButton {
    var button = new Toolbars.OpenLinkButton("http://microsoft.com");

    button.label(ClientResources.ToolbarButton.openLink);
    button.icon(MsPortalFx.Base.Images.Hyperlink());

    return button;
}

```

<a name="introduction-to-appblades-exchanging-messages-between-the-iframe-and-ibiza-fx"></a>
### Exchanging messages between the IFrame and Ibiza Fx

The AppBlade ViewModel is hosted in the hidden IFrame in which the extension is loaded. The contents of the AppBlade are hosted in different IFrame that is visible on the screen. The Ibiza extension IFrame and the UI IFrame communicate by sending and receiving messages. The following sections demonstrate how to exchange messages between the two IFrames.

<a name="introduction-to-appblades-exchanging-messages-between-the-iframe-and-ibiza-fx-ibiza-extension-iframe-messaging"></a>
#### Ibiza extension IFrame messaging

* Listen to a message

    You can listen to messages using the **on** method in the **AppBlade** view-model.

    The following code snippet demonstrates how to listen to a message from the UI IFrame in the Ibiza extension ViewModel.

    ```typescript

// This is an example of how to listen for messages from your iframe.
this.on("getAuthToken", () => {
    // This is an example of how to post a message back to your iframe.
    MsPortalFx.Base.Security.getAuthorizationToken().then((token) => {
        let header = token.header;
        let message = new FxAppBlade.Message("getAuthTokenResponse", header);

        this.postMessage(message);
    });
});

```

*  Post a message

    The extension can post messages to the UI IFrame by using the **postMessage** method in the AppBlade ViewModel.

    The following code snippet demonstrates how to send a message from the Ibiza extension ViewModel to the IFrame ViewModel.

    ```typescript

// This is another example of how to post a message back to your iframe.
this.postMessage(new FxAppBlade.Message("favoriteAnimal", "porcupine"));

```

<a name="introduction-to-appblades-exchanging-messages-between-the-iframe-and-ibiza-fx-ui-iframe-messaging"></a>
#### UI IFrame messaging

* Listen to a message

    The extension can listen for incoming messages by adding an event listener to the application window, as shown in the following code.

    ```xml

window.addEventListener("message", receiveMessage, false);

```

    The extension should also provide a handler for the incoming message. In the following example below, the **receiveMessage** method handles three different incoming message types, and reacts to theming changes in the Portal.

    ```xml

// The message format is { signature: "pcIframe", data: "your data here" }
function receiveMessage(event) {
    // It is critical that we only allow trusted messages through. Any domain can send a message event and manipulate the html.
    // It is recommended that you enable the commented out check below to get the portal URL that is loading the extension.
    // if (event.origin.toLowerCase() !== trustedParentOrigin) {
    //     return;
    // }

    if (event.data["signature"] !== "FxAppBlade") {
        return;
    }
    var data = event.data["data"];
    var kind = event.data["kind"];

    if (!data) {
        return;
    }

    var postMessageContainer = document.getElementById("post-message-container");
    var divElement = document.createElement("div");
    divElement.className = "post-message";

    var message;

    switch (kind) {
        case "getAuthTokenResponse":
            message = data;
            divElement.style.background = "yellow";
            break;
        case "favoriteAnimal":
            message = "My favorite animal is: " + data;
            divElement.style.background = "pink";
            break;
        case "theme":
            message = "The current theme is: " + data;
            divElement.style.background = "lightblue";
            break;
    }

    var textNode = document.createTextNode(message);

    divElement.appendChild(textNode);
    postMessageContainer.appendChild(divElement);
}

```

*  Post a message

    You can post messages back to the Portal using the **postMessage**. There is a required message that your IFrame needs to send back to the portal to indicate that it is ready to receive messages.

    The code snippet below shows how to post that first required message and also how to send another additional message.

```xml

if (window.parent !== window) {
    // This is a required message. It tells the shell that your iframe is ready to receive messages.
    window.parent.postMessage({
        signature: "FxAppBlade",
        kind: "ready"
    }, shellSrc);

    // This is an example of a post message.
    window.parent.postMessage({
        signature: "FxAppBlade",
        kind: "getAuthToken"
    }, shellSrc);
}

```

<a name="introduction-to-appblades-post-theming-information"></a>
### Post theming information

When using a template blade, extension developers can implement themes. Typically, the user selects a theme, which in turn is sent to the UI IFrame. The following code snippet demonstrates how to pass the selected theme to the UI IFrame using the **postMessage** method,  as specified in the section named [Exchanging messages between the IFrame and Ibiza Fx](#exchanging-messages-between-the-iframe-and-ibiza-fx).

```typescript

// Get theme class and pass it to App Blade
MsPortalFx.Services.getSettings().then(settings => {
    let theme = settings["fxs-theme"];
    theme.subscribe(container, theme =>
        this.postMessage(new FxAppBlade.Message("theme", theme.name))
    ).callback(theme());
});

```