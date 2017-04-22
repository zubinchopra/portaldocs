<properties title="" pageTitle="Parts" description="" authors="alvarorahul" />

<a name="introduction-to-framepart"></a>
### Introduction to FramePart

Like an AppBlade, FramePart is a type of part that provides you with an IFrame
where you can render your content, resulting in maximum flexibility at the
expense of additional developer responsibilities.

We recommend consider using AppBlade when:

* You have an existing experience that you want to bring to Ibiza without having
to re-implement it
* You want to implement user interactions and/or experiences that are not
supported by the components in Ibiza framework
* You have an experience that needs to be re-hosted in several environments

When using FramePart you are responsible for:

* **Accessibility**: you are reponsible for making your blade accessible up to
Microsoft standards
* **Theming**: you are responsible for responding to theming behavior
* **Consistent Look & feel**: you are responsible for coming up with a visual
design that is consistent with the rest of Ibiza
* **Controls**: since you can't use Ibiza Fx controls you need to build your own
controls or use available alternatives 

<a name="introduction-to-framepart-creating-your-first-framepart"></a>
#### Creating your first FramePart

You can build a frame part using TypeScript decorators defined on the view model
you define for it. Here's a sample.

```ts
@FramePart.Decorator({
    galleryMetadata: {
        title: ClientResources.noPdlSampleFramePartTitle,
        category: ClientResources.partGalleryCategorySample,
        thumbnail: {
            image: MsPortalFx.Base.Images.ArrowUp()
        }
    }
})
export class SampleFramePart {
    public title: string;  // This sample doesn't make use of a title.
    public subtitle: string;  // This sample doesn't make use of a subtitle.
    public onClick: () => void;  // This FramePart doesn't have click behavior.

    public viewModel: FramePart.ViewModel;

    public context: FramePart.Context<void, DataContext>;

    public onInitialize() {
        const { container } = this.context;
        const viewModel = this.viewModel = new FramePart.ViewModel(container, {
            src: MsPortalFx.Base.Resources.getContentUri("/Content/SamplesExtension/framepartpage.html"),
        });

        return mockAsyncOperationToGetDataToSendToFrame().then(info => {
            viewModel.postMessage("frametitle", info.title);
        });
    }
}
```

In the above sample, mockAsyncOperationToGetDataToSendToFrame denotes async
operations that are typically performed during initialize.

<a name="introduction-to-framepart-sending-messages-to-from-the-iframe"></a>
#### Sending messages to/from the iframe.

You can send messages from your extension view model to the FramePart using the
postMessage method available on the view model as demonstrated in the code
snippets above.

Similarly, you can send messages from the iframe to the extension by calling the
built-in browser API as follows.

```js
window.parent.postMessage({
    signature: "FxFramePart",
    kind: "appdata", // any key indicating the kind of data being sent
    data: {}, // the data being sent across - optional and must be cloneable
})
```

When the iframe sents messages using the format above, the extension view model
can listen and react to them by registering event handlers like below.

```ts
const callback = data => {
    // perform some work
};

// Listen to messages of a specific kind
viewModel.on("appdata", callback);

// When no longer interested in listening to messages of a kind, you can removed
// the listener
viewModel.off("appdata", callback);
```

<a name="introduction-to-framepart-special-messages-that-the-iframe-can-send"></a>
#### Special messages that the IFrame can send

<a name="introduction-to-framepart-special-messages-that-the-iframe-can-send-revealcontent"></a>
##### revealcontent
When the contents of the iframe are in a state presentable to
the user (i.e. the opaque loading indicator can be removed), though not
necessarily fully ready, the message with kind: "revealcontent" can be sent to
display the iframe to the user with a shield over it to prevent interactions.

<a name="introduction-to-framepart-special-messages-that-the-iframe-can-send-initializationcomplete"></a>
##### initializationcomplete
When the part is fully ready, the iframe should
send a message with kind: "initializationcomplete" so that the user can start
interacting with it.

<a name="introduction-to-framepart-deprecated-legacy-api-using-pdl"></a>
#### (Deprecated) Legacy API using PDL

Below references are only for existing frame parts. Any new code should use the
new APIs demonstrated above.

1. Add the **part definition** to your PDL file

```xml
<!-- Deprecated approach for building a FramePart -->
<FramePart
    Name="PdlSampleFramePart"
    ViewModel="{ViewModel Name=SampleFramePart, Module=../PDL/Parts/FramePart/ViewModels/SampleFramePart}">
    <PartGalleryInfo
        Title="{Resource sampleFramePartTitle, Module=ClientResources}"
        Category="{Resource partGalleryCategorySample, Module=ClientResources}"
        Thumbnail="MsPortalFx.Base.Images.ArrowUp()" />
</FramePart>
```

2. Create a **ViewModel** TypeScript class. The code snippet below shows the view-model for the template blade defined above. In this case, it is showing the docs.microsoft.azure.com into an AppBlade in Ibiza portal.

```javascript
// Deprecated approach for building a FramePart
export class SampleFramePart extends FramePart.ViewModel implements Def.Contract {
    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: DataContext) {
        super(container, {
            src: MsPortalFx.Base.Resources.getContentUri("/Content/SamplesExtension/framepartpage.html"),
        });
    }

    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        return Q.all([
            this.waitForFrameReady(),
            mockAsyncOperationToGetDataToSendToFrame().then(info => {
                this.postMessage("frametitle", info.title);
            }),
        ]);
    }
}
```

The source location for the contents of the IFrame is passed to the container
using the **src** property in the **Options** (second parameter in the code
snippet above).

In the above sample, mockAsyncOperationToGetDataToSendToFrame denotes async
operations that are typically performed during initialize.
