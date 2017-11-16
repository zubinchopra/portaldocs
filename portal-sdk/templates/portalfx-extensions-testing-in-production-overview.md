
<a name="portalfxExtensionsTestingInProductionOverview"></a>
<!-- link to this document is 
[portalfx-extensions-testing-in-production-overview.md]()
-->

## Introduction 

Side-loading allows you to test and debug your extension locally against any environment. This is the preferred method of testing.

This document describes the various components of testing an extension in production. This includes status codes in addition to procedures for testing.  

## Overview
Extensions can be loaded on a per-user basis on production deployments. This can be used to test a new extension or an existing extension on a developer's machine with production credentials. To reduce phishing risks, the extension is hosted on `localhost`, although it can be hosted on any port. 

### Registering a Custom Extension 
<a name="customExtensionStamp"></a>
To register a custom extension, or register a different extension stamp, use the following parameters in the portal extension query string.
 
```https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"<ExtensionName>":"<protocol>://<uri>/"}```


where

`portal.azure.com`: portal environment in which to load the extension. Other portal environments are  ` rc.portal.azure.com` , `mpac.portal.azure.com`, and   `df.onecloud.azure-test.net`, although extension developers can side-load their extensions in any environment. 

`feature.canmodifyextensions`: Required to support loading untrusted extensions for security purposes. This feature flag has a value of `true`. For more information about feature flags, see [portalfx-extension-flags.md](portalfx-extension-flags.md).

`testExtensions`: contains the name of the extension, and the environment in which the environment is located.

* `ExtensionName`: matches the name of the extension, without the angle brackets, as specified in the extension configuration file.  For more information about the configuration file, see [portalfx-extensions-configuration-overview.md]().

* `protocol`: matches the protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

* `uri`: the extension endpoint. The actual host is `localhost`.  If you are using a host other than `localhost`, see the section named [Registering Test Extensions](portalfx-extensions-testing-in-production-overview.md#registeringTestExtensions)'. If there is a port number associated with the extension, it can be appended to the uri if it is separated from the uri by a colon, as in the following example: `https://localhost:1234/`.

The custom extension that was registered will be saved to user settings, and available in future sessions. When using the portal in this mode, a banner is  displayed that indicates that the state of the configured extensions has been changed, as in the following image.

![alt-text](../media/portalfx-testinprod/localExtensions.png "Local extensions")

For more information about testing switches, see the debugging guide that is located at [portalfx-debugging.md](portalfx-debugging.md).

### Registering Test Extensions
<a name="registeringTestExtensions"></a>
 If you need to use a different hostname than `localhost`, the existing `registerTestExtension` API is still available. It allows the developer to register a custom extension from `localhost`, register a custom extension from a custom environment, or load an extension from a custom environment using a hosting service. Use the following steps for the `registerTestExtension` API. 
 
 1. Sign in to a production account at https://portal.azure.com?feature.canmodifyextensions=true
 1. Hit F12 to open the developer tools in the browser
 1. Run the following command in the browser console to register your custom extension:
 
     ```
     // use this command if you want the change to persist until the user resets the settings or executes MsPortalImpl.Extension.unregisterTestExtension("ExtensionName")
     MsPortalImpl.Extension.registerTestExtension({ name: "ExtensionName", uri: "https://someserver:59344" });
 
     // use this command if you want the extension to be registered only for the current portal load
     MsPortalImpl.Extension.registerTestExtension({ name: "ExtensionName", uri: "https://someserver:59344" }, true);
     ```

 1. Navigate to https://portal.azure.com?feature.canmodifyextensions=true&clientOptimizations=false
 
 For more information about common hosting scenarios, see [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-extension-hosting-service.md#other-common-scenarions](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-extension-hosting-service.md#other-common-scenarions).

 For information about debugging switches, see  [https://github.com/Azure/portaldocs/blob/e78ff94d9c90fc71830173cec608f2d6f2f6679c/portal-sdk/generated/portalfx-debugging.md#diagnostic-switches](https://github.com/Azure/portaldocs/blob/e78ff94d9c90fc71830173cec608f2d6f2f6679c/portal-sdk/generated/portalfx-debugging.md#diagnostic-switches)

### Loading custom stamps by using feature flags

#### The uriFormat and its capabilities

The `uriFormat` parameter, in conjunction with the `uri` parameter, can extend the number of extension stamps that can be loaded in various portal environments. 

For more information on the `uri` parameter, see [portalfx-extensions-configuration-overview.md#extensionUri](portalfx-extensions-configuration-overview.md#extensionUri).   For more information on the  `uriFormat` parameter, see [portalfx-extensions-configuration-overview.md#extensionUriFomat](portalfx-extensions-configuration-overview.md#extensionUriFomat).  

####	Common Use cases
There are several scenarios in which a developer may use custom stamps to test various aspects of an extension. Some of them are as follows. 

  1. Running automated tests:
  1. Running smoke test
  1. Testing a specific version of extension

### Marking automated tests as test/synthetic traffic

Automated tests that run against a production environment should be marked as test/synthetic traffic. In order to accomplish this, you can do one of the following:

* Add the TestTraffic phrase to the `userAgentString` field. Replace `TeamName` and `Component` in the following example with the appropriate values, without the angle brackets.

  ``` TestTraffic-<TeamName>-<Component>  ```

* Set the query string parameter to `feature.UserType=test`. 
This allows us to exclude test traffic from our reports.

### Obsolete script bundles

If you are using deprecated features that have been moved to obsolete script bundles, then the `obsoleteBundlesBitmask` flag should be specified, as in the following example.

```
  MsPortalImpl.Extension.registerTestExtension({
      name: "YourExtensionName",
      uri: "https://someserver:59344",
      obsoleteBundlesBitmask: 1 // or the relevant value as appropriate.
  });
```
The current list of obsoleted bundles is in the following table.

| Definition file | Flag |  Bundle description | 
| --- | --- | --- |
| Obsolete0.d.ts |  1 | Parameter collector V1/V2 |
| Obsolete1.d.ts |  2 | CsmTopology control | 


For example, if  Parameter collector V1/V2 is used, then the `obsoleteBundlesBitmask` flag should have a value of  1. If you are  using both parameter collector V1/V2 and CsmTopology control, specify 3 (1 + 2).

**NOTE**:  If your extension uses obsolete bundles, there may be a performance penalty when it is loaded.  Its performance can be  improved by migrating away from these dependencies, i.e. PCV1, PCV2 and  `CsmTopology` control. For more information about improving extension performance, see [portalfx-extensions-configuration-scenarios.md#PCV1PCV2Removal](portalfx-extensions-configuration-scenarios.md#PCV1PCV2Removal).