<a name="parts"></a>
# Parts

<a name="parts-overview"></a>
## Overview

Parts, also known as Tiles, are the units of UI that can participate on Azure dashboards. This includes the procedures used to create parts.

* [Creating a basic part](creating-a-basic-part)

* [Pinning a part manually](#pinning-a-part-manually) 

* [Pinning a part programmatically](#pinning-a-part-programmatically) 

* [Offering a part in the Tile gallery](#offering-a-part-in-the-tile-gallery)

<a name="parts-overview-creating-a-basic-part"></a>
### Creating a basic part

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. 

Creating a part is very similar to creating a blade. And like blades, there are important decisions to be made while planning to implement the part.  The recommended way is to implement a template part.  Template parts are like template blades. You define an html template and bind it to a TypeScript view model, as in the following example.

import * as PartsArea from "../PartsArea";
import * as ClientResources from "ClientResources";
import * as TemplatePart from "Fx/Composition/TemplatePart";

export = Main;

module Main {
    "use strict";

    @TemplatePart.Decorator({
        htmlTemplate: "" +
            "<div class='msportalfx-padding'>" +
            "  <div>This is a Template Part.</div>" +
            "</div>",
        galleryMetadata: {
            title: ClientResources.simpleTemplatePart,
            category: ClientResources.partGalleryCategorySample,
            thumbnail: {
                image: MsPortalFx.Base.Images.ArrowDown()
            }
        }
    })
    export class SimpleTemplatePart {
        public title = ClientResources.simpleTemplatePart;
        public subtitle: string;
        public onClick: () => void = null;  // This Part isn't clickable.

        public context: TemplatePart.Context<void, PartsArea.DataContext>;

        public onInitialize() {
            return Q();  // This sample loads no data.
        }
    }
}


**NOTE**: The context property on the part view model contains useful APIs on it for things like opening blades, putting the part into an error state, and more.

If you need more control over the DOM and are willing to take on additional burdens regarding accessibility and theming then you can also choose to build a `FramePart` where the contents of the part are implemented by using an iFrame that you can control. The following  example demonstrates  a simple FramePart that shows how to communicate between the visible iFrame and the hidden extension iFrame.

import { DataContext } from "../PartsArea";
import * as FramePart from "Fx/Composition/FramePart";
import * as ClientResources from "ClientResources";

export = Main;

module Main {
    const global = window;

    "use strict";

    function mockAsyncOperationToGetDataToSendToFrame() {
        return Q.delay(2000).then(() => {
            return {
                title: ClientResources.noPdlSampleFramePartTitle,
            };
        });
    }

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

            // This is an example of how to listen for messages from your iframe.
            viewModel.on("getAuthToken", () => {
                // This is an example of how to post a message back to your iframe.
                MsPortalFx.Base.Security.getAuthorizationToken().then((token) => {
                    const header = token.header;
                    viewModel.postMessage("getAuthTokenResponse", header);
                });
            });

            let counter = 0;
            const timeoutHandle = global.setInterval(() => {
                viewModel.postMessage("framecontent", "" + (++counter));
            }, 1000);
            container.registerForDispose({
                dispose: () => { global.clearInterval(timeoutHandle); }
            })

            return mockAsyncOperationToGetDataToSendToFrame().then(info => {
                viewModel.postMessage("frametitle", info.title);
            });
        }
    }
}


<a name="parts-overview-pinning-a-part-manually"></a>
### Pinning a part manually

This is for when a user clicks on the pin icon on a blade.

If you have built a blade and have added the `@TemplateBlade.Pinnable.Decorator()` decorator then the compiler will force you to implement an `onPin()` function. This function is called by the framework when the user manually clicks the blade's pin icon. The extension returns a `PartReference` in that function. When the  extension is built, a part reference will be autogenerated  for each part that is defined in the extension. 

To access the  part references from within a blade, the extension imports the following reference.

```typescript

import { PinnableBladePinnedPartReference } from "../../../_generated/PartReferences";

```

Then in the `onPin()` function you can do something like this:

```typescript

// This method is called by the FX when the user clicks the "Pin" icon on the Blade.
// It's required because @TemplateBlade.Pinnable.Decorator is applied to this class.
public onPin() {
    return this._getPartReferenceForPinning();
}

```

This enables the extension to initialize the part, as in the following example.

```typescript

private _getPartReferenceForPinning() {
    const { parameters } = this.context;

    // Here, when the user clicks the "Pin" UI in the opened Blade, the Blade has the opportunity to run some code
    // to choose the Part to be pinned and to capture some Blade state to pass along to the Part.
    const favoriteColor = this.colorDropDown.value() || undefined;
    const partParameters = $.extend({}, parameters, { favoriteColor: favoriteColor });  // Here, supply extra parameters to the Part.
    const partSize = this._getPinnedPartSize(favoriteColor);

    return new PinnableBladePinnedPartReference(partParameters, { initialSize: partSize });  // Here, specify the initial size of the Part.
}

```

<a name="parts-overview-pinning-a-part-programmatically"></a>
### Pinning a part programmatically

You can programmatically pin a part to the current dashboard when a user is interacting with one of your blades. To do this, first import the PartPinner module like this.

```typescript

import * as PartPinner from "Fx/Pinner";

```

Then from within your code you can imperatively call the `pin()` function, as in the following code.

```typescript

// An example of UI in the Blade that the user can interact with to pin some artifact from the Blade UI.
// This method is called from the 'fxclick' handler in the HTML template for this TemplateBlade.
public onPinFromUiClick() {
    const partReference = this._getPartReferenceForPinning();
    return PartPinner.pin([partReference]);
}

```

<a name="parts-overview-offering-a-part-in-the-tile-gallery"></a>
### Offering a part in the Tile gallery

The Tile Gallery is presented when users create new dashboards or when they put their dashboard in edit mode. The Gallery lets users browse and search through all parts built by all extensions, as long as the parts have the right metadata. If you want your part to be included in the tile gallery then you just need to provide a little bit of metadata inside of your part's decorator. 

The following example includes the `galleryMetadata` property that lets the developer specify a localized title and category, in addition to a thumbnail image. 

```typescript

@TemplatePart.Decorator({
    htmlTemplate: "" +
        "<div class='ext-gallery-part' data-bind='css: css'>" +
        "    <div>Color: <span data-bind='text: colorName'></span></div>" +
        "    <div>Time range: <span class='ext-gallery-part-time-range' data-bind='text: timeRange'></span></div>" +
        "    <div>Other parameter: <span data-bind='text: otherParameter'></span></div>" +
        "</div>" +
        "<p/>" +
        "<div>Part location: <span class='ext-gallery-part-location' data-bind='text: location'></span></div>" +
        "<p/>" +
        "<a class='ext-general-gallery-part-configure' data-bind='fxclick: onConfigureClick'>Configure</a>",
    galleryMetadata: {
        title: ClientResources.noPdlGeneralGalleryPartTitle,
        category: ClientResources.partGalleryCategorySample,
        thumbnail: {
            image: MsPortalFx.Base.Images.Favorite()
        }
    },
    parameterMetadata: {
        timeRange: {
            // TODO: Use FX constant.
            valueType: "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        }
    }
})

```

 
<a name="parts-best-practices"></a>
## Best Practices

Portal development patterns or architectures that are recommended based on customer feedback and usability studies may be categorized by the type of part.

<a name="parts-best-practices-loading-indicators"></a>
#### Loading indicators

Loading indicators should be consistently applied across all blades and parts of the extension.  To achieve this:

* Call `container.revealContent()` to limit the time when the part displays  **blocking loading** indicators.

* Return a `Promise` from the `onInputsSet` method that reflects all data-loading for the part. Return the `Promise` from the blade if it is locked or is of type  `<TemplateBlade>`.

* Do not return a `Promise` from the `onInputsSet` method previous to the loading of all part data if it removes loading indicators.   The part will seem to be broken or unresponsive if no **loading** indicator is displayed while the data is loading, as in the following code.

```ts
public onInputsSet(inputs: MyPartInputs): Promise {
    this._view.fetch(inputs.resourceId);
    
    // DO NOT DO THIS!  Removes all loading indicators.
    // Your Part will look broken while the `fetch` above completes.
    return Q();
}
```

<a name="parts-best-practices-handling-part-errors"></a>
### Handling part errors

The sad cloud UX is displayed when there is no meaningful error to display to the user. Typically this occures when the error is unexpected and the only option the user has is to try again.

If an error occurs that the user can do something about, then the extension should launch the UX that allows them to correct the issue.    Extension  developers and domain owners are aware of  how to handle many types of errors.

For example, if the error is caused because the user's credentials are not known to the extension, then it is best practice to use one of the following options instead of failing the part.

1. The part can handle the error and change its content to show the credentials input form

1. The part can handle the error and show a message that says ‘click here to enter credentials’. Clicking the part would launch a blade with the credentials form.

 

 ## Frequently asked questions

<a name="parts-best-practices-"></a>
### 

* * * 

 ## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                | Meaning |
| ------------------- | --- |
|  | |