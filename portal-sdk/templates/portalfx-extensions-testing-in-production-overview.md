## Introduction

This document describes the various components of testing an extension in production. This includes status codes and testing procedures.  

## Overview

Sideloading allows the testing and debugging of extensions locally against any environment. This is the preferred method of testing. However, an extension can be tested in production under specific conditions. It allows the developer to include hotfixes, customize the extension for different environments, and other factors. 

Extensions can be loaded on a per-user basis on production deployments. This can be used to test a new extension or an existing extension on a developer's machine with production credentials. To reduce phishing risks, the extension is hosted on `localhost`, although it can be hosted on any port. 

## Registering a Customized Extension 

To register a customized extension, or register a different extension stamp, use the following parameters in the portal extension query string.
 
```https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"<extensionName>":"<protocol>://<uri>/"}```

where

**portal.azure.com**: Portal environment in which to load the extension. Other portal environments are  ` rc.portal.azure.com`, `mpac.portal.azure.com`, and   `df.onecloud.azure-test.net`, although extension developers can sideload their extensions in any environment. 

**feature.canmodifyextensions**: Required to support loading untrusted extensions for security purposes.  This feature flag grants permission to the portal to load extensions from URLs other than the ones that are typically used by customers.  It triggers an additional portal UI that indicates that the portal is running with untrusted extensions. This feature flag has a value of `true`.  For more information about feature flags, see [portalfx-extension-flags.md](portalfx-extension-flags.md).

**testExtensions**: Contains the name of the extension, and the environment in which the environment is located. It specifies the intent to load the extension `<extensionName>` from the `localhost:<portNumber>` into the current session of the portal.

* **extensionName**: Matches the name of the extension, without the angle brackets, as specified in the `<Extension>` element  in the  `extension.pdl` file.  For more information about the configuration file, see [portalfx-extensions-configuration-overview.md]().

* **protocol**: Matches the protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

* **uri**: The extension endpoint. The actual host is `localhost`.  If using a host other than `localhost`, see the section named [#registering-test-extensions](#registering-test-extensions). If there is a port number associated with the extension, it can be appended to the `uri` if it is separated from the `uri` by a colon, as in the following example: `https://localhost:1234/`. For example, the following  `uri`  loads an extension named Microsoft_Azure_Demo from localhost: 

[https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"Microsoft_Azure_Demo":"https://localhost:44300/"}](https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"Microsoft_Azure_Demo":"https://localhost:44300/"})


The custom extension that was registered will be saved to user settings, and available in future sessions. When using the portal in this mode, a banner is  displayed that indicates that the state of the configured extensions has been changed, as in the following image.

![alt-text](../media/portalfx-testinprod/localExtensions.png "Local extensions")

For more information about testing switches, see the debugging guide that is located at [portalfx-debugging.md](portalfx-debugging.md).

## Registering Test Extensions

 If you need to use a different hostname than  `localhost`, the existing `registerTestExtension` API is still available. It allows the developer to register a custom extension from `localhost`, register a custom extension from a custom environment, or load an extension from a custom environment using a hosting service. Use the following steps for the `registerTestExtension` API. 
 
 1. Sign in to a production account at [https://portal.azure.com?feature.canmodifyextensions=true](https://portal.azure.com?feature.canmodifyextensions=true).
 1. Click F12 to open the developer tools in the browser.
 1. Run the following command in the browser console to register your custom extension:
 
   ```ts
     // use this command if the changes should persist until the user resets the settings or executes MsPortalImpl.Extension.unregisterTestExtension("extensionName")
     MsPortalImpl.Extension.registerTestExtension({ name: "extensionName", uri: "https://someserver:59344" });
 
     // use this command if the extension should be registered only for the current portal load
     MsPortalImpl.Extension.registerTestExtension({ name: "extensionName", uri: "https://someserver:59344" }, true);
   ```

 1. Navigate to [https://portal.azure.com?feature.canmodifyextensions=true&clientOptimizations=false](https://portal.azure.com?feature.canmodifyextensions=true&clientOptimizations=false).
 

 portalfx-debugging.md

 
 For more information about common hosting scenarios, see [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-extension-hosting-service.md#other-common-scenarions](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-extension-hosting-service.md#other-common-scenarions).

<!-- TODO: Update this link to the extension flags document when it is complete. -->

 For information about debugging switches, see  [https://github.com/Azure/portaldocs/blob/e78ff94d9c90fc71830173cec608f2d6f2f6679c/portal-sdk/generated/portalfx-debugging.md#diagnostic-switches](https://github.com/Azure/portaldocs/blob/e78ff94d9c90fc71830173cec608f2d6f2f6679c/portal-sdk/generated/portalfx-debugging.md#diagnostic-switches)

## Loading custom stamps

Custom extension stamps can be loaded into the portal by using feature flags.  Diagnostic switches can also be used for testing in production.  For more information, see [portalfx-extension-flags.md](portalfx-extension-flags.md).

The `uriFormat` parameter, in conjunction with the `uri` parameter, can increase the number of extension stamps that can be loaded in various portal environments. 

For more information on the `uri` parameter, see [portalfx-extensions-configuration-overview.md#uri](portalfx-extensions-configuration-overview.md#uri).   For more information on the  `uriFormat` parameter, see [portalfx-extensions-configuration-overview.md#uriFomat](portalfx-extensions-configuration-overview.md#uriFomat).  

### Common use cases

There are several scenarios in which a developer may use custom stamps to test various aspects of an extension. Some of them are as follows. 

<details>

<summary>Running automated tests</summary>

Automated tests that run against a production environment should be marked as test/synthetic traffic. Use one of the following options to accomplish this.

1. Add the TestTraffic phrase to the `userAgentString` field. Replace `TeamName` and `Component` in the following example with the appropriate values, without the angle brackets.

    ```TestTraffic-<TeamName>-<Component>  ```

1. Set the query string parameter to `feature.UserType=test`. 
This setting excludes test traffic from our reports.
</details>
<details>
<summary>Running regression tests</summary>

Regression tests and build verification tests are    .
<!-- TODO: Determine how extension stamps are used to run partial tests. -->
</details>
<details>
<summary>Obsolete script bundles</summary>

If the extension uses deprecated features that have been moved to obsolete script bundles, then the ```obsoleteBundlesBitmask``` flag should be specified, as in the following example.

```
  MsPortalImpl.Extension.registerTestExtension({
      name: "extensionName",
      uri: "https://someserver:59344",
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