## Overview

### Understanding the Azure Portal Architecture

The IFRAMEs loaded by the Portal are entirely hidden. The scripts loaded by these IFRAMEs interact with the Portal using Azure Portal SDK APIs. This allows the extensions to provide a consistent, and predictable, experience for Azure Portal users.

When a user visits the Azure Portal, extensions will be loaded based on the users subscription. Extensions can be loaded asynchronously, and even deactivated when they are not currently in use.

The Azure Portal architecture is displayed in the following image.

 ![alt-text](../media/portalfx-deployment/deployment.png  "Portal Extension Architecture")

### Understanding the Extension Architecture

1.	Typically an extension is an ASP.NET Web API project, which is modified to include content specific to the Portal.
1.	The client APIs use TypeScript to provide a productive experience for building JavaScript.
1.	TypeScript is built using the Asynchronous Module Loader (AMD) module system via require.js.
1.	The core programming model follows the Model View ViewModel pattern. Most UI elements in the Portal are backed by dynamic view models, which provide a 'live tile' style of UX.
1.	View models make heavy use of Knockout for binding data to the client.
1.	Building custom UI is enabled using standard web technologies like HTML and CSS.
1.	Extension developers can provide a consistent experience to customers of the  service across all clients, i.e. UI, powershell or CLI, by implementing business logic in APIs exposed through ARM.
1.	Azure Portal creates, or mints, tokens on behalf of extensions. This allows extensions to invoke ARM APIs out of the box. In case the extension needs to invoke services such as Graph then we recommend reviewing the Authentication guide to check if you need help from our team. 
The Authentication guide is located at  .
<!-- TODO:  find the authentication guide. -->
1.	Extension developers can leverage the extension hosting service to deploy the extension's UI in all Azure data centers.



This section contains links to documents that describe Azure Portal Architecture.

* Asynchronous Module Loader (AMD) 

    [http://requirejs.org/docs/whyamd.html](http://requirejs.org/docs/whyamd.html)

* ASP.NET Web API

    [http://www.asp.net/web-api](http://www.asp.net/web-api)

* Authentication guide 

    [https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-authentication.md](https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-authentication.md)

* Azure Portal 

    [https://ms.portal.azure.com](https://ms.portal.azure.com/)

* CSS 

    [https://developer.mozilla.org/en-US/docs/Web/CSS](https://developer.mozilla.org/en-US/docs/Web/CSS)

* HTML 

    [https://developer.mozilla.org/en-US/docs/Web/HTML](https://developer.mozilla.org/en-US/docs/Web/HTML)

* Knockout 

    [http://knockoutjs.com/](http://knockoutjs.com/)

* Model View ViewModel 

    [http://en.wikipedia.org/wiki/Model_View_ViewModel](http://en.wikipedia.org/wiki/Model_View_ViewModel)

* Require.js 

    [http://requirejs.org/](http://requirejs.org/) 

* Typescript   

    [http://www.typescriptlang.org/](http://www.typescriptlang.org/)

* UI elements 

    [https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-ui-concepts.md](https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-ui-concepts.md)