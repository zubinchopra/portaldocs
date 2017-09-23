
<a name="getting-started"></a>
# Getting Started

<a name="getting-started-how-the-portal-works"></a>
## How the portal works

The [Azure portal](http://portal.azure.com) provides a consistent user interface that enables integration with various first and third party Microsoft Azure services. The portal is a [single page application](http://en.wikipedia.org/wiki/Single-page_application) which can dynamically load a collection of extensions.  Extensions are loaded via an IFRAME that provides a layer of isolation.  The IFRAMEs loaded by the portal do not project any visuals - they are entirely hidden.  Instead, the scripts loaded by these IFRAME interact with the API provided by the Azure Portal SDK.  This allows the portal to provide a consistent, safe, and predictable experience for users.

![Portal extension architecture][architecture]

<a name="getting-started-how-extensions-work"></a>
## How extensions work

Extensions are simply web applications written using the [Azure Portal SDK](downloads.md).  The web application will provide content loaded by the portal in an isolated context.

- Typically an extension is an [ASP.NET Web API](http://www.asp.net/web-api) project, which is modified to include content specific to the portal.
- The client APIs use [TypeScript](http://www.typescriptlang.org/) to provide a productive experience for building JavaScript.
- TypeScript is built using the [Asynchronous Module Loader (AMD)](http://requirejs.org/docs/whyamd.html) module system via [require.js](http://requirejs.org/).
- The core programming model follows the [Model View ViewModel](http://en.wikipedia.org/wiki/Model_View_ViewModel) pattern. Most [UI elements](portalfx-ui-concepts.md) in the portal are backed by dynamic view models, which provide a 'live tile' style of UX.
- View models make heavy use of [Knockout](http://knockoutjs.com/) for binding data to the client.
- Building custom UI is enabled using standard web technologies like [HTML](https://developer.mozilla.org/en-US/docs/Web/HTML) and [CSS](https://developer.mozilla.org/en-US/docs/Web/CSS).
- Extension UI is deployed using the extension hosting service to an endpoint created for your team by ibiza team. 
- Ibiza recommends not using Controllers so that all the APIs are exposed through ARM. This ensures that Azure portal customers have consistent experience while accessing the resources through UI, powershell or CLI. However, we understand in some scenarios extensions may need to omplement custom business logic. In this case, extension authors are responsible for hosting  controllers.

**NOTE:** Learn more about [deployment](portalfx-deployment.md).

When a user visits the Azure portal, extensions will be loaded based on the users subscription. Extensions can be loaded asynchronously, and even deactivated when it's not currently in use.

<a name="getting-started-how-extensions-work-what-s-different"></a>
### What&#39;s different?

- Instead of a single frame, extensions run in their own IFRAME. This provides a certain level of process isolation, allowing for greater reliability, and data protection.
- Instead of a single code repository, extensions are now developed in a separate repository from the shell.
- Extension authors do not need to enlist the Azure portal source code repository to add new experiences.
- Extension authors are free to deploy their service as frequently or infrequently as desired.
- The new portal only loads the experiences required for the current user. Extensions can be removed from the portal at runtime if they are not being used, and dynamically re-loaded.

[architecture]: ../media/portalfx-deployment/deployment.png
