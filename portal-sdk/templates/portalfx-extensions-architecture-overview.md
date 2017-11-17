

## Understanding the Azure Portal Architecture

The IFRAMEs loaded by the portal are entirely hidden. The scripts loaded by these IFRAMEs interact with the portal using Azure Portal SDK APIs. This allows the extensions to provide a consistent, and predictable, experience for Azure portal users.

When a user visits the Azure portal, extensions will be loaded based on the users subscription. Extensions can be loaded asynchronously, and even deactivated when they are not currently in use.

The Azure portal architecture is displayed in the following image.

 ![alt-text](../media/portalfx-deployment/deployment.png  "Portal Extension Architecture")

## Understanding the Extension Architecture

1.	Typically an extension is an ASP.NET Web API project, which is modified to include content specific to the portal.
1.	The client APIs use TypeScript to provide a productive experience for building JavaScript.
1.	TypeScript is built using the Asynchronous Module Loader (AMD) module system via require.js.
1.	The core programming model follows the Model View ViewModel pattern. Most UI elements in the portal are backed by dynamic view models, which provide a 'live tile' style of UX.
1.	View models make heavy use of Knockout for binding data to the client.
1.	Building custom UI is enabled using standard web technologies like HTML and CSS.
1.	Extension developers can provide a consistent experience to customers of the  service across all clients, i.e. UI, powershell or CLI, by implementing business logic in APIs exposed through ARM.
1.	Azure portal creates, or mints, tokens on behalf of extensions. This allows extensions to invoke ARM APIs out of the box. In case the extension needs to invoke services such as Graph then we recommend reviewing the Authentication guide to check if you need help from our team.
1.	Extension developers can leverage the extension hosting service to deploy the extension's UI in all Azure data centers.

