
<a name="development-phases"></a>
## Development Phases

<a name="development-phases-private-preview"></a>
### Private Preview

The extension is in private preview stage when it has been added to the Azure portal configuration. It is still in hidden/ disabled state, and the preview tag in the the `extension.pdl` file is set to `Preview="true"`.  In this state the extension is not visible to all the customers of Azure portal; instead, the developer and their team have acquired a small team of reviewers with which to collaborate on the development and testing of the extension. Some teams also leverage this phase for testing the business model by providing a specific URL to their customers that allows them to access this extension. The developer can then modify the extension until it meets specific criteria for usability, reliability, performance, and other factors. The criteria are located at [Exit Criteria and Quality Metrics](portalfx-extensions-exitCriteria.md). 

When the criteria are met, the developer starts the processes that will move the extension from the private preview state to the public preview state. They should also start the CSS onboarding process with the CSS team at least three months previous to public preview. The CSS onboarding process requires information like the disclosure level, and the key contacts for the release. It allows the appropriate teams enough time to ensure that customers of the extension have access to Azure support and other permissions necessary to access the site.  To start the process, send an email to ibiza-css@microsoft.com. For more information about CSS contacts, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md). For more information about the CSS onboarding process, see [http://spot/intake](http://spot/intake).

When all requirements are met, CSS will release the extension from private preview to public preview. The extension will be enabled, but the preview tag in the the `extension.pdl` file is still set to `Preview="true"`.

This process is separate from onboarding to Azure.

<a name="development-phases-public-preview"></a>
### Public Preview

In the public preview state, the extension undergoes more development and review, and it can be used by all customers in Azure portal.  The exit criteria for the public preview state are the same as the exit criteria for the private preview state, except for Usability.  Public Preview requires extensions to have a score of 7/10, whereas GA requires extensions to have a score of 8/10.  An extension that meets the exit criteria with this public audience can be moved from public preview to Global Availability. The criteria that are used to validate promoting the extension out of the public preview state are located at [Exit Criteria and Quality Metrics](portalfx-extensions-exitCriteria.md).

The icon to the right of the extension indicates whether the extension is in the private preview state or the public preview state, as in the following image.

 ![alt-text](../media/portalfx-extensions/previewMode.png "Private Preview State")

<a name="development-phases-global-availability"></a>
### Global Availability

When an extension passes all exit criteria for the public preview state, it can be promoted to the Global Availability state. In order to move the extension to GA, the preview tag in the `extension.pdl` file is removed. This will remove the preview tag from the display. 