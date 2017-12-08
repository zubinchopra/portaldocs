
## Development Phases

### Private Preview

The extension is in private preview stage when it has been added to the Azure portal configuration. It is still in hidden/ disabled state, and the preview tag in the the `extension.pdl` file is set to `Preview="true"`. This means that the developer and their team have acquired a small team of reviewers with which to collaborate on the development and testing of the extension.  The developer can then modify the extension until it meets specific criteria for usability, reliability, performance, and other factors. The criteria are located at [Exit Criteria and Quality Metrics](portalfx-extensions-exitCriteria.md). 

When the criteria are met, the developer starts the processes that will move the extension from the private preview state to the public preview state. They should also start the CSS onboarding process at least three months previous to public preview. The CSS onboarding process requires information like the disclosure level, and the key contacts for the release. It allows the appropriate teams enough time to ensure that customers of the extension have access to Azure support and other permissions necessary to access the site.  To start the process, send an email to ibiza-css@microsoft.com. For more information about CSS contacts, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md). For more information about the CSS onboarding process, see [http://spot/intake](http://spot/intake).

When all requirements are met, CSS will release the extension from private preview to public preview. The extension will be enabled, but the preview tag in the the `extension.pdl` file is still set to `Preview="true"`.

This process is separate from onboarding to Azure.

<!-- TODO:  If all extensions eventually leave the private preview state, this paragraph can be removed.  The iterative process does not need to be described. -->

**NOTE**: Not all extensions will be moved to public preview, because factors exist that require that the extension remain in the private preview state.

### Public Preview

In the public preview state, the extension undergoes more development and review, this time with a larger audience.  The exit criteria for the public preview state are the same as the exit criteria for the private preview state. An extension that meets the exit criteria with this new audience can be moved from public preview to Global Availability.

The icon to the right of the extension indicates whether the extension is in the private preview state or the public preview state, as in the following image.

 ![alt-text](../media/portalfx-extensions/previewMode.png "Private Preview State")

### Global Availability

When an extension passes all exit criteria for the public preview state, it can be promoted to the Global Availability state. In order to move the extension to GA, the preview tag in the `extension.pdl` file is removed.