
## Overview
   
Sideloading allows the testing and debugging of extensions locally against any environment. It loads an extension for a specific user session from any source other than the `uri` that is registered in the Portal. When unit-testing the UI extension, the developer can instruct the Portal to load the extension from a URL that they specify.  The extension can be loaded using a development environment, a query string, or it can be loaded programmatically.  This is the preferred method of testing, and is a basic first step.
 
This helps the developer validate that the extension is ready for standard Portal use in private preview or public preview mode.  During standard Portal use, the Portal web application loads the UI extension from a URL that is part of the Portal's configuration, as specified in the environment configuration file(s) for the extension.

Extensions can also be tested in production under specific conditions. It allows the developer to include hotfixes, customize the extension for different environments, and other factors. 

Sideloading can be used when developing an extension, in addition to private preview and some forms of usability testing. It is also useful when testing multiple versions of an extension, or determining which features should remain in various editions of an extension.  For example, an English-language extension may have other UX editions that include localization for various languages, each of which may ship separately when the extension is deployed or geodistributed.

During standard Portal use, the Portal web application loads the UI extension from a URL that is part of the Portal's configuration.  When developing and testing the UI extension, the developer can instruct the Portal to load the extension from a specified URL.  For more information, see [top-extensions-architecture.md](top-extensions-architecture.md).


* [Sideloading](#sideloading)

  Loading extensions using a query string

To load the extension programmatically, see [#registering-extensions-with-the-registertestextension-api](#registering-extensions-with-the-registertestextension-api).

* * * 

## Sideloading

The difference between sideloading and testing in production is the endpoint from which the extension is loaded. The following query string can be used to load an extension by using the address bar.

```<protocol>://<environment>/?feature.canmodifyextensions=true#?testExtensions={"<extensionName>":"<protocol>://<endpoint>:<portNumber>"}```

where 

**protocol**: Matches the protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

**environment**: Portal environment in which to load the extension. Portal environments are `portal.azure.com`, `rc.portal.azure.com`, `mpac.portal.azure.com`, and `df.onecloud.azure-test.net`.

**extensionName**: Matches the name of the extension, without the angle brackets, as specified in the `<Extension>` element  in the  `extension.pdl` file.  For more information about the configuration file, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

**endpoint**: The [localhost](glossary), or the computer on which the extension is being developed.

**portNumber**: The port number associated with the endpoint that serves the extension.

For example, the following query string can be used to sideload the extension named "Microsoft_Azure_Demo" onto the localhost for testing on the developer's computer.

```https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"Microsoft_Azure_Demo":"https://localhost:44300/"}```

In the following example, the endpoint is a server that the developer specifies. The server can be a development server, or a production server in any region or environment.

```https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"Microsoft_Azure_Demo":"https://DemoServer:59344/}"```

Extensions can be loaded on a per-user basis on production deployments. Sideloading can be used to test a new extension or an existing extension on a developer's machine with production credentials. To reduce phishing risks, the extension is hosted on `localhost`, although it can be hosted on any port.

Two mechanisms that can be used to sideload an extension are as follows.

1. [Load from development computer](#load-from-development-computer)

1. [Load from test environment](#load-from-test-environment)

### Load from development computer

To load an extension from the development machine or the localhost, extension developers need to register it. 

For more information, see [portalfx-extensions-production-testing-overview.md#Registering-a-customized-extension](portalfx-extensions-production-testing-overview.md#registering-a-customized-extension).
 
For more information about alternatives to the local host environment, see [top-extensions-hosting-service.md](top-extensions-hosting-service). 

For more information about feature flags that are used in hosting, see [top-extensions-flags.md](top-extensions-flags.md).

### Load from test environment

The Portal provides options for sideloading your extension for testing. To sideload an extension, either as a localhost extension or as a deployed extension, you can set the appropriate query strings and execute the `registerTestExtension` function for deployed extensions. For a localhost extension you can just set a query string. For more information, see [portalfx-extensions-production-testing-overview.md#registering-test-extensions](portalfx-extensions-production-testing-overview.md#registering-test-extensions).

The developer may want to programmatically register a deployed extension with JavaScript and then reload the Portal. This step is optional if they use a query string method to load the extension into the browser from the localhost. To load an extension from the test environment or an unregistered source, extension developers can leverage the following approach.

1. Sign in to a production account at [https://portal.azure.com?feature.canmodifyextensions=true](https://portal.azure.com?feature.canmodifyextensions=true)

1. Click **F12** to open the Developer Tools in the browser

1. In the **Console** window of the browser's Developer Tools, evaluate the following JavaScript snippet to register an extension in the Portal.

    `MsPortalImpl.Extension.registerTestExtension({name,uri},settings)` 

where

* **name** and **uri** parameters are as specified in [portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal](portalfx-extensions-configuration-overview.md#understanding-the-extension-configuration-in-portal).
 
* **settings**: Registers the extension in the portal. It is a boolean value that specifies the timeframe for which the Portal will run the registered extension.  A value of  `true` means that the registered extension is valid only for the current browser session.  A value of `false` means that the registered extension is valid across browser sessions. This state is saved in the browser's local storage. This is the default.

The following example registers the extension in User Settings.

```ts
   MsPortalImpl.Extension.registerTestExtension({ name: "<extensionName>", uri: "https://<serverName>:<portNumber>" });
```

where

* **extensionName**: The name of the extension in the `extension.pdl` file

* **serverName**: The server where the extension will be hosted

* **portNumber**: The port where extension is hosted on `<serverName>`

The registered extension will be saved to User Settings, and will be available in future sessions. When the Portal is used in this mode, it displays a banner that indicates that the state of the configured extensions has been changed, as in the following image.

![alt-text](../media/portalfx-productiontest/localExtensions.png "Local extensions")

* * *

The following example describes a complete URL and query string that instructs the Portal to load the extension named "Microsoft_Azure_Demo" from endpoint "https://DemoServer:44300". It registers the extension only for the current user session. 

```ts
   MsPortalImpl.Extension.registerTestExtension({ name: "Microsoft_Azure_Demo", uri: "https://DemoServer:44300" }, true);
```

For more information on loading, see [portalfx-testing-ui-test-cases.md](portalfx-testing-ui-test-cases.md).

* * *

When testing is completed, the developer can run the `unregisterTestExtension` method in the Developer Tools Console to reset the user settings and unregister the extension, as in the following example.

```ts
  MsPortalImpl.Extension.unregisterTestExtension("<extensionName>");
```

When all steps are complete, the developer can submit a pull request to enable the extension, as specified in [top-extensions-publishing.md](top-extensions-publishing.md). When the extension is enabled, users will be able to access it in all environments, as specified in [top-extensions-developmentPhases.md](top-extensions-developmentPhases.md).