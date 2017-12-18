<a name="overview"></a>
## Overview

Sideloading an extension is useful when developing an extension, in addition to private preview and some forms of usability testing. It is also useful when testing multiple versions of an extension, or determining which features should remain in later editions.

During standard portal use, the portal web application loads the UI extension from a URL that is part of the portal's configuration.  When developing and testing the UI extension, the developer can instruct the Portal to load the extension from the specified URL.  For more information, see [portalfx-extensions.architecture.md](portalfx-extensions.architecture.md).

Two mechanisms that can be used to sideload an extension are as follows.

1. [Load from development computer](#load-from-development-computer)
1. [Load from test environment](#load-from-test-environment)

<a name="load-from-development-computer"></a>
## Load from development computer

To load an extension from the development machine or the localhost, extension developers need to register it.  For more information, see [portalfx-extensions-testing-in-production-overview.md#Registering-a-customized-extension](portalfx-extensions-testing-in-production-overview.md#registering-a-customized-extension). For more information about alternatives to the local host environment, see [portalfx-extensions-hosting-service.md](portalfx-extensions-hosting-service). 
For more information about feature flags that are used in hosting, see [portalfx-extensions-flags.md](portalfx-extensions-flags.md).

<a name="load-from-test-environment"></a>
## Load from test environment

The Portal provides options for sideloading your extension for testing. If you wish to sideload your extension, either as a localhost extension or as a deployed extension, you can set the appropriate query strings and execute the `registerTestExtension` function for deployed extensions. For a localhost extension you can just set a query string. For more information, see [portalfx-extensions-testing-in-production-overview.md#registering-test-extensions](portalfx-extensions-testing-in-production-overview.md#registering-test-extensions).
 
The developer may want to programmatically register a deployed extension via JavaScript and then reload the portal. This step is optional if they use the query string method to load the extension from the localhost. To load an extension from the test environment or an unregistered source, extension developers can leverage the following approach.

1. Sign in to a production account at [https://portal.azure.com?feature.canmodifyextensions=true](https://portal.azure.com?feature.canmodifyextensions=true)
1. Click **F12** to open the Developer Tools in the browser
1. In the **Console** window of the browser's Developer Tools, evaluate the following JavaScript snippet to register an extension in the portal.

    `MsPortalImpl.Extension.registerTestExtension({name,uri},settings)` 

where
* **name** and **uri** parameters are as specified in [portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal](portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal).
 
* **settings**: Registers the extension in the portal. It is a boolean value that specifies the timeframe for which the portal will run the registered extension.  A value of  `true` means that the registered extension is valid only for the current browser session.  A value of `false` means that the registered extension is valid across browser sessions. This state is saved in the browser's local storage. This is the default.

The following example registers the extension in User Settings.

```ts
   MsPortalImpl.Extension.registerTestExtension({ name: "<extensionName>", uri: "https://<serverName>:<portNumber>" });
```

where

* **extensionName**: The name of the extension in the `extension.pdl` file

* **serverName**: The server where the extension will be hosted

* **portNumber**: The port where extension is hosted on `<serverName>`

The registered extension will be saved to User Settings , and will be available in future sessions. When the portal is used in this mode, it displays a banner that indicates that the state of the configured extensions has been changed, as in the following image.

![Local extensions](../media/portalfx-testinprod/localExtensions.png)

* * *

The following example illustrates a complete URL and query string that instructs the portal to load the extension named "Microsoft_Azure_Demo" from endpoint "https://DemoServer:44300". It registers the extension only for the current user session. 

```ts
   MsPortalImpl.Extension.registerTestExtension({ name: "Microsoft_Azure_Demo", uri: "https://DemoServer:44300" }, true);
```

For more information on loading, see [portalfx-testing-ui-test-cases.md](portalfx-testing-ui-test-cases.md).

* * *

When testing is completed, the developer can run the `unregisterTestExtension` method in Console (Developer Tools) to reset the user settings and unregister the extension, as in the following example.

```ts
  MsPortalImpl.Extension.unregisterTestExtension("<extensionName>");
```

When all steps are complete, the developer can submit a pull request to enable the extension, as specified in [portalfx-extensions-publishing](portalfx-extensions-publishing). When the extension is enabled, users will be able to access it in all environments, as specified in [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).