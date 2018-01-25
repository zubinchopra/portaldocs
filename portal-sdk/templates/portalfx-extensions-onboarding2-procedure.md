## Development Procedures
   
Perform the following tasks to develop an Azure extension.

1. [Learn about the hosting service](#learn-about-the-hosting-service)

1. [Develop the extension](#develop-the-extension)

1. [Register the extension](#register-the-extension)

You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).

### Learn about the hosting service

 Teams that are new to Azure development can learn about the hosting service and plan the deployment strategy for new extensions. Your team should network with support teams by reaching out to the following teams.

1. Azure Resource Manager team 

   For onboarding your resource provider

1. Azure Marketing Team

   To ensure that the business goals of the new extension or service are aligned with Azure's business strategy, please reach out to the Integrated Marketing Team or the L&R - Operations - GD&F team at [ibiza-bmr@microsoft.com](mailto:ibiza-bmr@microsoft.com?subject=Azure%20Business%20model%20review). Brian Hillger’s team and Stacey Ellingson’s team will guide you through the business model review process. The extension or service is not ready to be onboarded to Azure until its business model has received approval from those teams. Do not proceed with the next step until the business model has received approval.

1. Support team 

   For integrating with the support system and UX integration

1. Azure.com team 
   
   For a presence on the marketing site

1. Billing team
   
   To register your meters and other billing related activities.

1. AAD onboarding

   Reach out to AAD onboarding if the new extension service needs special permissions besides just calling your own resource provider servers.  If the extension requires additional built-in support for standard Graph or ARM APIs, submit a partner request at the site located at [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice). 

1. Azure fundamentals and compliance

1. Security and privacy reviews

1. Schedule a UX feasibility review with the Ibiza team UX contact by emailing [mailto:ibiza-onboarding@microsoft.com?subject=Extension%20Feasibility%20Review](mailto:ibiza-onboarding@microsoft.com?subject=Extension%20Feasibility%20Review).  Many extensions have been made more successful by setting up early design reviews with the Azure Portal team. Taking the time to review the design gives extension owners an opportunity to understand how they can leverage Azure Portal design patterns, and ensure that the desired outcome is feasible. 

1. Start the CSS onboarding process with the CSS team at least three months previous to public preview. This process may coincide with the following step. For more information about development phases, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

While the portal team cannot help directly with all of these factors, we we do maintain, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).

### Develop the extension

1. Build the extension and sideload it for local testing. Sideloading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about sideloading, see [portalfx-extensions-sideloading-overview.md](portalfx-extensions-sideloading-overview.md) and [portalfx-testinprod.md](portalfx-testinprod.md). 

1. Complete the development and unit testing of the extension. For more information on debugging, see [portalfx-debugging.md](portalfx-debugging.md) and [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).

1. Address the exit criteria to meet previous to moving the extension to the next development phase. The exit criteria are located at [top-exit-criteria.md](top-exit-criteria.md).

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

### Register the extension

Once the name of the extension or service name is finalized, request to have the extension registered in all environments. Registering an extension in Portal requires deployment so it can take almost 10 days in the Production environment. Please plan accordingly.

* For internal partners, the request to register an extension is a pull request, as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).
 
* External teams can submit their requests by reaching out to the <a href="mailto:ibizafxpm@microsoft.com?subject=Onboarding Request: Add <extensionName> to the Portal&body=Extension Name:  <br><br>Company:  <br><br>Brand or Suite:  <br><br>Product or Component:  <br><br> URLs: <br><br>Production: main.<extensionName>.ext.<company>.com<br><br>  Contact info: <br><br>Business Contacts <br><br> Dev leads: <br><br> PROD on-call email: <br><br>">ibizafxpm team</a> with an onboarding request, as in the following example.

  ![alt-text](../media/portalfx-extensions-onboarding/registrationRequest.png "Extension Registration Onboarding Request")
 
* After deploying the extension to the DOGFOOD (DF) environment, contact the Fx team to request that they enable the extension, if applicable. Every extension  meets required exit criteria / quality metrics before it will be enabled. The  extension will be enabled in production once all exit criteria have been met.

   Extension names must use standard extension name format, as in the example located at [portalfx-extensions-configuration-overview.md#name](portalfx-extensions-configuration-overview.md#name).

* Extension URLs must use a standard CNAME pattern. For more information about CNAMES, see [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md).
