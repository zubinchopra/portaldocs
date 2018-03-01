
<a name="appblades"></a>
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

<a name="creating-an-appblade"></a>
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

<a name="the-ibiza-command-bar"></a>
## The Ibiza command bar

The Ibiza command bar can optionally be used in an AppBlade to leverage Framework support and make Azure navigation a more consistent experience. To use a command bar, add it to the PDL file for the extension PDL and configure it in the AppBlade ViewModel, as in the following example.

```typescript

// You can add command bars to app blades.
this.commandBar = new Toolbar(container);
this.commandBar.setItems([this._openLinkButton()]);

```

There should also be a command button on the command bar, as in the following example.

```typescript

private _openLinkButton(): Toolbars.OpenLinkButton {
    var button = new Toolbars.OpenLinkButton("http://microsoft.com");

    button.label(ClientResources.ToolbarButton.openLink);
    button.icon(MsPortalFx.Base.Images.Hyperlink());

    return button;
}

```

<a name="exchanging-messages-between-the-iframe-and-ibiza-fx"></a>
## Exchanging messages between the IFrame and Ibiza Fx

The AppBlade ViewModel is hosted in the hidden IFrame in which the extension is loaded. However, the contents of the AppBlade are hosted in different IFrame that is visible on the screen. The Ibiza extension IFrame and the UI IFrame communicate by sending and receiving messages. The following sections demonstrate how to exchange messages between the two IFrames.

<a name="exchanging-messages-between-the-iframe-and-ibiza-fx-ibiza-extension-iframe-messaging"></a>
### Ibiza extension IFrame messaging

* Listen to a message

    The extension can listen to messages that are sent from the UI IFrame to the Ibiza extension ViewModel by using the **on** method in the **AppBlade** ViewModel, as in the following example.

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

    The Ibiza extension ViewModel can post messages to the UI IFrame by using the **postMessage** method in the AppBlade ViewModel, as in the following example.

    ```typescript

// This is another example of how to post a message back to your iframe.
this.postMessage(new FxAppBlade.Message("favoriteAnimal", "porcupine"));

```

<a name="exchanging-messages-between-the-iframe-and-ibiza-fx-ui-iframe-messaging"></a>
### UI IFrame messaging

* Listen to a message

    The extension can listen for messages that are sent from the Ibiza extension ViewModel to the UI Frame by adding an event listener to the application window, as shown in the following code.

    ```xml

window.addEventListener("message", receiveMessage, false);

```

    The extension should also provide a handler for the incoming message. In the following example, the **receiveMessage** method handles three different incoming message types, and reacts to theming changes in the Portal.

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

    The  UI IFrame can post messages back to the Portal using the **postMessage** method. There is a required message that the  IFrame sends to the Portal to indicate that it is ready to receive messages.

    The following code snippet demonstrates how to post the  required message, in addition to posting other messages.

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

## Changing UI themes

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