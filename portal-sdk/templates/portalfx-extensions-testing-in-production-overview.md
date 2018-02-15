## Introduction

This document describes the various components of testing an extension in production, including status codes and testing procedures.  For information about regular testing and debugging, see [portalfx-test.md](portalfx-test.md) and [top-extensions-debugging.md](top-extensions-debugging.md).

## Overview

Sideloading is the process of loading an extension for a specific user session from any source other than the `uri` that is registered in the Portal. During standard Portal use, the Portal web application loads the UI extension from a URL that is part of the Portal's configuration. However, when testing the UI extension, the developer can instruct the Portal to load the extension from a URL that they specify. The extension can be loaded using the query string, or it can be loaded programmatically. 

Sideloading allows the testing and debugging of extensions locally against any environment. This is the preferred method of testing. However, an extension can be tested in production under specific conditions. It allows the developer to include hotfixes, customize the extension for different environments, and other factors. 

Sideloading can be used when developing an extension, in addition to private preview and some forms of usability testing. It is also useful when testing multiple versions of an extension, or determining which features should remain in later editions.
To load the extension using a query string, see [#sideloading](#sideloading).

To load the extension programmatically, see [#registering-extensions-with-the-registertestextension-api](#registering-extensions-with-the-registertestextension-api).

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

## Registering extensions with the registerTestExtension API

The developer may want to programmatically register a deployed extension with JavaScript and then reload the Portal. This step is optional if they use a [query string](portalfx-extensions-testing-in-production-glossary.md) method to load the extension into the browser from the localhost. Using the  `registerTestExtension` API for programmatic changes allows the developer to register a custom extension from `localhost`, or register a custom extension from a custom environment. To load an extension from the test environment or an unregistered source, extension developers can leverage the following approach.

 <!-- TODO: Determine whether the registerTestExtension API can be used with the hosting service or if the hosting service only allows query strings. If the registerTestExtension API allows use of a hosting service, find the example code so that the following sentence can be  re-included into the document:
  or load an extension from a custom environment using a hosting service.
 -->

<!--TODO:  Determine whether the following can be considered a different format
  `MsPortalImpl.Extension.registerTestExtension({name,uri},settings)`     -->
 
1. Sign in to a production account at [https://portal.azure.com?feature.canmodifyextensions=true](https://portal.azure.com?feature.canmodifyextensions=true)

1. Click **F12** to open the Developer Tools in the browser
  
1. Run the following command in the browser console to register a custom extension.
    ```ts
    // use this command if the changes should persist 
    //  until the user resets the settings or
    //  executes MsPortalImpl.Extension.unregisterTestExtension("<extensionName>")
    //
    MsPortalImpl.Extension.registerTestExtension({ 
      name: "<extensionName>", 
      uri: "<protocol>://<endpoint>:<portNumber>" }
    );
 
    // use this command if the extension should be registered 
    //   only for the current Portal load
    //
    MsPortalImpl.Extension.registerTestExtension({
      name: "<extensionName>",
      uri: "<protocol>://<endpoint>:<portNumber>" }, 
      <settings>);
    ```
    where

    * **extensionName**: Matches the name of the extension, without the angle brackets, as specified in the `<Extension>` element  in the  `extension.pdl` file.  

    * **protocol**: The protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

    * **endpoint**: The extension endpoint when using a host other than `localhost`. 

    * **portNumber**: The port number associated with the endpoint that serves the extension, as in the following example: `https://DemoServer:59344/`. 

    * **settings**: Boolean value that registers the extension in the Portal for a specific timeframe. A value of `true` means that the registered extension will run only for the current browser session.  The default value of `false` means that the registered extension is valid across browser sessions. This state is saved in the browser's local storage. 

1. Navigate to [https://portal.azure.com?feature.canmodifyextensions=true&clientOptimizations=false](https://portal.azure.com?feature.canmodifyextensions=true&clientOptimizations=false).
 
The following example describes a complete uri and [query string](portalfx-extensions-testing-in-production-glossary.md) that instructs the Portal to load the extension named "Microsoft_Azure_Demo" from endpoint "https://DemoServer:59344". It registers the extension only for the current user session. 
<!--TODO: This example contradicts the previous definition.  Determine which one is correct.  -->
   ```ts
   MsPortalImpl.Extension.registerTestExtension({
     name: "Microsoft_Azure_Demo",
     uri: "https://DemoServer:44300"});
   ```
 
## Unregistering test extensions

When testing is completed, the developer can run the `unregisterTestExtension` method in the Developer Tools Console to reset the user settings and unregister the extension, as in the following example.

```ts
  MsPortalImpl.Extension.unregisterTestExtension("<extensionName>");
```

## Loading customized extensions

Custom extensions that are used for testing can be loaded into the Portal by using feature flags. The `uriFormat` parameter, in conjunction with the `uri` parameter, can increase the number of extension editions that can be loaded in various Portal environments. These parameters are located in the `extensions.<EnvironmentName>.json` file, in conjunction with the `Client\extension.pdl` file. The edition of the extension that is loaded can be changed by modifying the `uri` and `uriFormat` parameters instead of using  **endpoint** and **portNumber** in the query string. For more information about extension configuration, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

To register a customized extension, or register a different extension edition, use the following parameters in the Portal extension query string.
 
```<protocol>://<environment>/?feature.canmodifyextensions=true#?testExtensions={"<extensionName>":"<protocol>://<uri>/"}```

where

* **protocol**: Matches the protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

* **environment**: Portal environment in which to load the extension. Portal environments are `portal.azure.com`, `rc.portal.azure.com`, `mpac.portal.azure.com`, and `df.onecloud.azure-test.net`, although extension developers can sideload their extensions in any environment. 

* **feature.canmodifyextensions**: Required to support loading untrusted extensions for security purposes.  This feature flag grants permission to the Portal to load extensions from URLs other than the ones that are typically used by customers.  It triggers an additional Portal UI that indicates that the Portal is running with untrusted extensions. This feature flag has a value of `true`.  For more information about feature flags, see [portalfx-extensions-flags.md](portalfx-extensions-flags.md).

* **testExtensions**: Contains the name of the extension, and the environment in which the extension is located. It specifies the intent to load the extension `<extensionName>` from the `localhost:<portNumber>` into the current session of the Portal.

  * **extensionName**: Matches the name of the extension, without the angle brackets, as specified in the `<Extension>` element  in the  `extension.pdl` file.  

  * **protocol**: Matches the protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

  * **uri**: The extension endpoint. If there is a port number associated with the extension, it can be appended to the `uri` by separating it from the `uri` by a colon, as in the following example: `https://localhost:1234/`. 

<!-- TODO:  Determine whether this is a duplication of a previous explanation or is really a separate case. -->

The following example registers the extension in User Settings.

```ts
   MsPortalImpl.Extension.registerTestExtension({ name: "<extensionName>", uri: "https://<serverName>:<portNumber>" });
```

where

* **extensionName**: The name of the extension in the `extension.pdl` file

* **serverName**: The server where the extension will be hosted

* **portNumber**: The port where extension is hosted on `<serverName>`

 The custom extension that was registered will be saved to user settings, and available in future sessions. When using the Portal in this mode, a banner is displayed that indicates that the state of the configured extensions has been changed, as in the following image.

![alt-text](../media/portalfx-testinprod/localExtensions.png "Local extensions")

For more information on loading, see [portalfx-testing-ui-test-cases.md](portalfx-testing-ui-test-cases.md).

## Completing the extension test

When all steps are complete, the developer can submit a pull request to enable the extension, as specified in [top-extensions-publishing.md](top-extensions-publishing.md). When the extension is enabled, users will be able to access it in all environments, as specified in [top-extensions-developmentPhases.md](top-extensions-developmentPhases.md).

## Deploying test extensions using the hosting service 
 
 For more information about common hosting scenarios, see  [portalfx-extensions-hosting-service-scenarios.md#sideloading](portalfx-extensions-hosting-service-scenarios.md#sideloading).  For information about debugging switches or feature flags that are used in hosting, see  [portalfx-extensions-flags.md](portalfx-extensions-flags.md).  For more information about alternatives to the local host environment, see [top-extensions-hosting-service.md](top-extensions-hosting-service.md). 

## Common use cases for custom extensions

There are several scenarios in which a developer test various aspects of an extension with different editions of the same extension. Some of them are as follows. 

<details>

<summary>Running automated tests</summary>

Automated tests that run against a production environment should be marked as test/synthetic traffic. Use one of the following options to accomplish this.

1. Add the `TestTraffic` phrase to the `userAgentString` field. Replace `TeamName` and `Component` in the following example with the appropriate values, without the angle brackets.

    ```TestTraffic-<TeamName>-<Component>  ```

1. Set the query string parameter to `feature.UserType=test`. 
This setting excludes test traffic from our reports.
</details>
<details>
<summary>Running regression tests</summary>

Regression tests and build verification tests are    .
<!-- TODO: Determine how extension editions are used to run partial tests. -->
</details>
<details>
<summary>Obsolete script bundles</summary>

If the extension uses deprecated features that have been moved to obsolete script bundles, then the ```obsoleteBundlesBitmask``` flag should be specified, as in the following example.

```
  MsPortalImpl.Extension.registerTestExtension({
      name: "extensionName",
      uri: "https://<endpoint>:<portNumber>",
      obsoleteBundlesBitmask: 1 // or the relevant value as appropriate.
  });
```

The current list of obsoleted bundles is in the following table.

| Definition file | Flag  |  Bundle description | 
| ---             | ---   | --- |
| Obsolete0.d.ts  | 1     | Parameter collector V1/V2 |
| Obsolete1.d.ts  | 2     | CsmTopology control | 

For example, if parameter collector V1/V2 is used, then the `obsoleteBundlesBitmask` flag should have a value of  1. If the extension uses both parameter collector V1/V2 and CsmTopology control, specify 3 (1 + 2).

**NOTE**:  If the extension uses obsolete bundles, there may be a performance penalty when it is loaded.  Its performance can be  improved by migrating away from these dependencies, i.e. PCV1, PCV2 and  `CsmTopology` control. For more information about improving extension performance, see [portalfx-extensions-configuration-scenarios.md#pcv1-and-pcv2-removal](portalfx-extensions-configuration-scenarios.md#pcv1-and-pcv2-removal).

For more information about obsolete bundles and obsolete script bundles, see [portalfx-extension-reference-obsolete-bundle.md](portalfx-extension-reference-obsolete-bundle.md).
</details>
