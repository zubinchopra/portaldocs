   
## Development Phases

Typically, there are three typical types of releases for an extension: private preview, public preview, and Global Availability(GA).  For the purposes of deployment, public preview and GA are the same, except that the UI may show preview labels and disclaimers where appropriate.

### Private Preview

The extension is in private preview stage when it has been registered into the Azure Portal configuration. 
The goal is to hide the extension from the general public, but show it to a limited audience. After registration the new extension can be discovered on the browse page, also known as the `All services` menu, as in the following image.

![alt-text](../media/portalfx-extensions-developmentPhases/browseMenu.png "Browse Menu")

It is still in hidden/ disabled state, and the preview tag in the the `extension.pdl` file is set to `Preview="true"`.  In this state the extension is not visible to all the customers of Azure Portal; instead, the developer and their team have acquired a small team of reviewers with which to collaborate on the development and testing of the extension. 

Some teams also leverage this phase for testing the business model by providing a specific URL to their customers that allows them to access this extension. For more information about providing access to a limited set of customers, see [portalfx-hidden-extension-feedback.md](portalfx-hidden-extension-feedback.md).

The developer can then modify the extension until it meets specific criteria for usability, reliability, performance, and other factors. The criteria are located at [top-exit-criteria.md](top-exit-criteria.md). 

When the criteria are met, the developer starts the processes that will move the extension from the private preview state to the public preview state. They should also start the CSS onboarding process with the CSS team at least three months previous to public preview. The CSS onboarding process requires information like the disclosure level, and the key contacts for the release. It allows the appropriate teams enough time to ensure that customers of the extension have access to Azure support and other permissions necessary to access the site.  To start the process, send an email to ibiza-css@microsoft.com. For more information about CSS contacts, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md). For more information about the CSS onboarding process, see [http://spot/intake](http://spot/intake).

When all requirements are met, CSS will release the extension from private preview to public preview. The extension will be enabled, but the preview tag in the the `extension.pdl` file is still set to `Preview="true"`.

This process is separate from onboarding to Azure.

### Public Preview

The public preview state assumes that the extension met the exit criteria for the private preview phase, and that the private preview phase validated the business model of the service. This includes new user experiences, or entry points, within an existing extension.

Developers are required to check the quality of the  extension. The Azure Portal has standardized ways of measuring reliability and performance at key areas. When an extension is in the  private preview stage, then this data has already been collected.  For more information about quality checks and Portal tools, see [top-exit-criteria.md](top-exit-criteria.md).  

If the extension will be integrated into the Marketplace, then the hidden/ disabled rules follow Marketplace guidance. For more information about hiding Marketplace items, reach out to  <a href="mailto:1store@microsoft.com?subject=Marketplace Onboarding Request&body=Hello, I would like to onboard the attached package to the production environment. The .azkpg package is named <packageName>. ">1store.com</a>.

In the public preview state, the extension undergoes more development and review, and it can be used by all customers in Azure Portal.  The exit criteria for the public preview state are the same as the exit criteria for the private preview state, except for Usability. Public Preview requires extensions to have a score of 7/10, whereas GA requires extensions to have a score of 8/10.  An extension that meets the exit criteria with this public audience can be moved from public preview to Global Availability. The criteria that are used to validate promoting the extension out of the public preview state are located at [top-exit-criteria.md](top-exit-criteria.md).

The icon to the right of the extension indicates whether the extension is in the private preview state or the public preview state, as in the following image.

 ![alt-text](../media/portalfx-extensions-onboarding/previewMode.png "Private Preview State")

* **NOTE**: Any user that receives this URL will be able to see the new extension. Any users who receives a deep link to blades within the extension will be able to see the new experience.

### Global Availability

The global availability state assumes that the extension met the exit criteria for the public preview phase, and that the public  preview phase validated the business model of the service.

When an extension passes all exit criteria for the public preview state, it can be promoted to the Global Availability state. The criteria that are used to validate promoting the extension out of the public preview state are located at [top-exit-criteria.md](top-exit-criteria.md).

<!-- the `extension.pdl` file is not the JSON file. -->

 Enabling the extension for public preview will make the extension visible to all the customers in Azure Portal. Remove the preview tag in the `extension.pdl` configuration file to make the extension visible, as in the following example.
 
![alt-text](../media/portalfx-extensions-onboarding/GAMode.png "Global Availability")