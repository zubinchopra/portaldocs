<a name="frame-blades"></a>
### Frame Blades

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

<a name="sending-messages-between-the-iframe-and-ibiza-fx"></a>
### Sending messages between the IFrame and Ibiza Fx

The FrameBlade view model is hosted in the hidden IFrame in which the extension is loaded. This is just like TemplateBlades. However, the contents of the FrameBlade are hosted in a different IFrame that is visible on the screen. The Ibiza extension IFrame and the UI IFrame communicate by sending and receiving messages, as described in [https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage).

<a name="creating-a-frameblade"></a>
### Creating a FrameBlade

The following sample demonstrates how to create a FrameBlade. It illustrates a few key concepts.

1. Adding the standard Ibiza command bar to the top of your blade

1. Communicating between your IFrame and your blade `ViewModel`

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

The iframe code that includes the html is located at `<dir>/Content/SamplesExtension/framebladepage.html`.  It is also in the following code.

```html

﻿<!DOCTYPE html>
<html>

<head>
    <title></title>
    <meta charset="utf-8" />
</head>

<body>
    <h1 class="fxs-frame-header" style="margin: 0;"></h1>
    <div class="fxs-frame-token"></div>
    <input type="text"/>
    <script src="../Scripts/_oss/q-1.4.1.js"></script>
    <script>var frameSignature = "FxFrameBlade";</script>
    <script src="../Scripts/framepage.js"></script>
</body>

</html>


```

Create the `ViewModel`, as in the code located at  `<dir>/Client/V2/Blades/FrameBlade/SampleFrameBlade.ts` and in the following example.

```typescript

/**
 * View model for a FrameBlade.
 */
@FrameBlade.Decorator()
export class SampleFrameBlade {
    public title = ClientResources.sampleFrameBladeTitle;
    public subtitle: string;  // This FrameBlade doesn't make use of a subtitle.

    public viewModel: FrameBlade.ViewModel;

    public context: FrameBlade.Context<void, BladesArea.DataContext>;

    public onInitialize() {
        const { container } = this.context;

        const viewModel = this.viewModel = new FrameBlade.ViewModel(container, {
            src: MsPortalFx.Base.Resources.getContentUri("/Content/SamplesExtension/framebladepage.html")
        });
			

```

The code that connects the viewmodel to the extension is located at  `<dir>/Content/Scripts/framepage.js` and is in the following example.

```javascript

(function() {
    "use strict";

    // ---------------------------------------------------------------------------------------------
    // ------------------------------------- Helper Functions --------------------------------------
    // ---------------------------------------------------------------------------------------------

    // var frameSignature = ...;  Defined by .html page that loaded this script.

    // Capture the client session ID to use to correlate user actions and events within this
    // client session.
    var sessionId = location.hash.substr(1);

    var queryMap = (function() {
        var query = window.location.search.substring(1);
        var parameterList = query.split("&");
        var map = {};
        for (var i = 0; i < parameterList.length; i++) {
            var pair = parameterList[i].split("=");
            map[decodeURIComponent(pair[0])] = decodeURIComponent(pair[1]);
        }
        return map;
    })();

    function getQueryParameter(name) {
        return queryMap[name] || "";
    }

    function postMessageToParent(kind) {
        window.parent.postMessage({
            signature: frameSignature,
            kind: kind
        }, trustedParentOrigin);
    }

    // ---------------------------------------------------------------------------------------------
    // --------------------------------------- Security Code ---------------------------------------
    // ---------------------------------------------------------------------------------------------

    // Get the below trusted origins from configuration to include the origin of the portal in
    // which the page needs to be iframe'd.
    var allowedParentFrameAuthorities = ["localhost:55555", "portal.azure.com"];

    // Capture the origin of the parent and validate that it is trusted. If it is not a trusted
    // origin, then DO NOT setup any listeners and IGNORE messages from the parent/owner window
    var trustedParentOrigin = getQueryParameter("trustedAuthority");
    var isTrustedOrigin = (function() {
        var trustedAuthority = (trustedParentOrigin.split("//")[1] || "").toLowerCase();

        return allowedParentFrameAuthorities.some(function(origin) {
            // Verify that the requested trusted authority is either an allowed origin or is a
            // subdomain of an allowed origin.
            return origin === trustedAuthority
                || (trustedAuthority.indexOf("." + origin) === trustedAuthority - origin - 1);
        });
    })();

    // TODO: Uncomment below code to prevent untrusted origins from accessing the site.
    // if (!isTrustedOrigin) {
    //     var errorMessage = "The origin '" + trustedParentOrigin + "' is not trusted.";
    //     console.error(sessionId, errorMessage);
    //     throw new Error(errorMessage);
    // }

    // ---------------------------------------------------------------------------------------------
    // -------------------------------- Handshake Code with Portal ---------------------------------
    // ---------------------------------------------------------------------------------------------

    window.addEventListener("message", function(evt) {
        // It is critical that we only allow trusted messages through. Any domain can send a
        // message event and manipulate the html.
        if (evt.origin.toLowerCase() !== trustedParentOrigin) {
            return;
        }

        var msg = evt.data;

        // Check that the signature of the message matches that of frame parts.
        if (!msg || msg.signature !== frameSignature) {
            return;
        }

        // Handle different message kinds.
        if (msg.kind === "frametitle") {
            makeViewPresentableToUser(msg);
        } else if (msg.kind === "framecontent") {
            document.getElementsByClassName("fxs-frame-content")[0].innerText = msg.data;
        } else if (msg.kind === "getAuthTokenResponse") {
            document.getElementsByClassName("fxs-frame-token")[0].innerText = "Token: " + msg.data;
        } else {
            console.warn(sessionId, "Message not recognized.", msg);
        }
    }, false);

    // ---------------------------------------------------------------------------------------------
    // -------------------------------- Code to reveal view to user --------------------------------
    // ---------------------------------------------------------------------------------------------

    function makeViewPresentableToUser(msg) {
        document.getElementsByClassName("fxs-frame-header")[0].innerText = msg.data;
        document.head.getElementsByTagName("title")[0].innerText = msg.data;

        // Post message 'revealcontent' to the parent to indicate that the part is now in a state to
        // dismiss the opaque spinner and reveal content.
        postMessageToParent("revealcontent");

        completeInitialization();
    }

    // ---------------------------------------------------------------------------------------------
    // ------------------------------ Code to complete initialization ------------------------------
    // ---------------------------------------------------------------------------------------------

    function completeInitialization() {
        // Mimic an async operation that takes 2 seconds.
        Q.delay(2000).then(() => {
            // Post message the 'initializationcomplete' to the parent to indicate that the part is
            // now ready for user interaction.
            postMessageToParent("initializationcomplete");
        });
    }

    // Send a post message indicate that the frame is ready to start initialization.
    postMessageToParent("ready");

    // This is an example of posting the 'getAuthToken' event to Portal.
    postMessageToParent("getAuthToken");
})();


```

The working sample can be viewed at [http://df.onecloud.azure-test.net/?feature.samplesextension=true#blade/SamplesExtension/SampleFrameBlade](http://df.onecloud.azure-test.net/?feature.samplesextension=true#blade/SamplesExtension/SampleFrameBlade).

<a name="sending-messages-between-the-iframe-and-ibiza-fx"></a>
### Sending messages between the IFrame and Ibiza Fx

The AppBlade `ViewModel` is hosted in the hidden IFrame in which the extension is loaded. However, the contents of the AppBlade are hosted in a different IFrame that is visible on the screen. The Ibiza extension IFrame and the UI IFrame communicate by sending and receiving messages. The following sections demonstrate how to exchange messages between the two IFrames and the Portal.

<a name="ibiza-extension-iframe-messaging"></a>
### Ibiza extension IFrame messaging

<a name="ibiza-extension-iframe-messaging-listen-to-a-message"></a>
#### Listen to a message

The extension can listen to messages that are sent from the UI IFrame to the Ibiza extension ViewModel by using the **on** method in the **AppBlade** ViewModel, as in the following example.

<a name="ibiza-extension-iframe-messaging-post-a-message"></a>
#### Post a message

The Ibiza extension ViewModel can post messages to the UI IFrame by using the **postMessage** method in the AppBlade ViewModel, as in the following example.

<a name="ui-iframe-messaging"></a>
### UI IFrame messaging

<a name="ui-iframe-messaging-listen-to-a-message"></a>
#### Listen to a message

The extension can listen for messages that are sent from the Ibiza extension ViewModel to the UI Frame by adding an event listener to the application window, as shown in the following code.

The extension should also provide a handler for the incoming message. 

<a name="ui-iframe-messaging-post-a-message"></a>
#### Post a message

The  UI IFrame can post messages back to the Portal using the **postMessage** method. There is a required message that the  IFrame sends to the Portal to indicate that it is ready to receive messages.

<a name="changing-ui-themes"></a>
### Changing UI themes

When using a FrameBlade, extension developers can implement themes. Typically, the user selects a theme, which in turn is sent to the UI IFrame. The following code snippet demonstrates how to pass the selected theme to the UI IFrame using the **postMessage** method.

```typescript

// Get theme class and pass it to App Blade
MsPortalFx.Services.getSettings().then(settings => {
    let theme = settings["fxs-theme"];
    theme.subscribe(container, theme =>
        this.postMessage(new FxAppBlade.Message("theme", theme.name))
    ).callback(theme());
});

```
