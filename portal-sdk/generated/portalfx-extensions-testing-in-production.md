<a name="testing-in-production"></a>
# Testing in Production

<a name="testing-in-production-introduction"></a>
## Introduction

This document describes the various components of testing an extension in production, including status codes and testing procedures.  For information about regular testing and debugging, see [portalfx-test.md](portalfx-test.md) and [portalfx-debugging.md](portalfx-debugging.md).

<a name="testing-in-production-overview"></a>
## Overview

Sideloading is the process of loading an extension for a specific user session from any source other than the `uri` that is registered in the Portal. During standard Portal use, the Portal web application loads the UI extension from a URL that is part of the Portal's configuration. However, when testing the UI extension, the developer can instruct the Portal to load the extension from a URL that they specify. The extension can be loaded using the query string, or it can be loaded programmatically. 

Sideloading allows the testing and debugging of extensions locally against any environment. This is the preferred method of testing. However, an extension can be tested in production under specific conditions. It allows the developer to include hotfixes, customize the extension for different environments, and other factors. 

Sideloading can be used when developing an extension, in addition to private preview and some forms of usability testing. It is also useful when testing multiple versions of an extension, or determining which features should remain in later editions.
To load the extension using a query string, see [#sideloading](#sideloading).

To load the extension programmatically, see [#registering-extensions-with-the-registertestextension-api](#registering-extensions-with-the-registertestextension-api).

<a name="testing-in-production-sideloading"></a>
## Sideloading
The difference betweeen sideloading and testing in production is the endpoint from which the extension is loaded. The following query string can be used to load an extension by using the address bar.

```https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"<extensionName>":"<protocol>://<endpoint>:<portNumber>"}```

where 

**portal.azure.com**: Portal environment in which to load the extension. Other Portal environments are `rc.portal.azure.com`, `mpac.portal.azure.com`, and `df.onecloud.azure-test.net`.

**extensionName**: Matches the name of the extension, without the angle brackets, as specified in the `<Extension>` element  in the  `extension.pdl` file.  For more information about the configuration file, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

**protocol**: Matches the protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

**endpoint**: The [localhost](glossary), or the computer on which the extension is being developed.

**portNumber**: The port number associated with the endpoint that serves the extension.

For example, the following query string can be used to sideload the extension named "Microsoft_Azure_Demo" onto the localhost for testing on the developer's computer.

```https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"Microsoft_Azure_Demo":"https://localhost:44300/"}```

In the following example, the endpoint is a server that the developer specifies. The server can be a development server, or a production server in any region or environment.

```https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"Microsoft_Azure_Demo":"https://DemoServer:59344/}"```

Extensions can be loaded on a per-user basis on production deployments. Sideloading can be used to test a new extension or an existing extension on a developer's machine with production credentials. To reduce phishing risks, the extension is hosted on `localhost`, although it can be hosted on any port.

 There are other ways of testing extensions in production, like using diagnostic switches. For more information, see [portalfx-extension-flags.md](portalfx-extension-flags.md).

## Registering extensions with the registerTestExtension API

If you want to make programmatic changes to an extension instead of using the URL in the query string, you can use the existing `registerTestExtension` API. It allows the developer to register a custom extension from `localhost`, or register a custom extension from a custom environment. Use the following steps for the `registerTestExtension` API. 
 
 <!-- TODO: Determine whether the registerTestExtension API can be used with the hosting service or if the hosting service only allows query strings. If the registerTestExtension API allows use of a hosting service, find the example code so that the following sentence can be  re-included into the document:
  or load an extension from a custom environment using a hosting service.
 -->
 
1. Sign in to a production account at [https://portal.azure.com?feature.canmodifyextensions=true](https://portal.azure.com?feature.canmodifyextensions=true).

1.  Click F12 to open the developer tools in the browser.

1.  Run the following command in the browser console to register a custom extension.

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
      true);
    ```
    where

    * **extensionName**: Matches the name of the extension, without the angle brackets, as specified in the `<Extension>` element  in the  `extension.pdl` file.  

    * **protocol**: The protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

    * **endpoint**: The extension endpoint when using a host other than `localhost`. 

    * **portNumber**: The port number associated with the endpoint that serves the extension, as in the following example: `https://DemoServer:59344/`. 

1. Navigate to [https://portal.azure.com?feature.canmodifyextensions=true&clientOptimizations=false](https://portal.azure.com?feature.canmodifyextensions=true&clientOptimizations=false).
 
The following example describes a complete URL and [query string](portalfx-extensions-testing-in-production-glossary.md) that instructs the Portal to load the extension named "Microsoft_Azure_Demo" from endpoint "https://DemoServer:59344". It registers the extension only for the current user session. 

   ```ts
   MsPortalImpl.Extension.registerTestExtension({
     name: "Microsoft_Azure_Demo",
     uri: "https://DemoServer:44300" }, true);
   ```
 
## Unregistering test extensions

When testing is completed, the developer can run the `unregisterTestExtension` method in the Developer Tools Console to reset the user settings and unregister the extension, as in the following example.

```ts
  MsPortalImpl.Extension.unregisterTestExtension("<extensionName>");
```


## Loading customized extensions

Custom extension stamps that are used for testing can be loaded into the Portal by using feature flags. The `uriFormat` parameter, in conjunction with the `uri` parameter, can increase the number of extension stamps that can be loaded in various Portal environments. These parameters are located in the `extensions.<EnvironmentName>.json` file, in conjunction with the `Client\extension.pdl` file. Changing the `uri` and `uriFormat` parameters instead of using the **endpoint** and **portNumber** in the query string, will change the extension stamp. For more information about extension configuration, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

To register a customized extension, or register a different extension stamp, use the following parameters in the Portal extension query string.
 
```https://portal.azure.com/?feature.canmodifyextensions=true#?testExtensions={"<extensionName>":"<protocol>://<uri>/"}```

where

* **portal.azure.com**: Portal environment in which to load the extension. Other Portal environments are  `rc.portal.azure.com`, `mpac.portal.azure.com`, and   `df.onecloud.azure-test.net`, although extension developers can sideload their extensions in any environment. 

* **feature.canmodifyextensions**: Required to support loading untrusted extensions for security purposes.  This feature flag grants permission to the Portal to load extensions from URLs other than the ones that are typically used by customers.  It triggers an additional Portal UI that indicates that the Portal is running with untrusted extensions. This feature flag has a value of `true`.  For more information about feature flags, see [portalfx-extensions-flags.md](portalfx-extensions-flags.md).

* **testExtensions**: Contains the name of the extension, and the environment in which the extension is located. It specifies the intent to load the extension `<extensionName>` from the `localhost:<portNumber>` into the current session of the Portal.

  * **extensionName**: Matches the name of the extension, without the angle brackets, as specified in the `<Extension>` element  in the  `extension.pdl` file.  

  * **protocol**: Matches the protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

  * **uri**: The extension endpoint. If there is a port number associated with the extension, it can be appended to the `uri` by separating it from the `uri` by a colon, as in the following example: `https://localhost:1234/`. 

 The custom extension that was registered will be saved to user settings, and available in future sessions. When using the Portal in this mode, a banner is displayed that indicates that the state of the configured extensions has been changed, as in the following image.

![alt-text](../media/portalfx-testinprod/localExtensions.png "Local extensions")

<details>
<summary>Load localhost from development computer</summary>


</details>
<details>
<summary>Load extension that was deployed to a test environment</summary>

<!-- TODO:  Determine whether this is trying to split registerTestExtension  from mention in the address bar.
-->

The Portal provides options for sideloading an extension for testing. If you wish to sideload an extension, the `registerTestExtension` function can be used either as a localhost extension or as a deployed extension, with the appropriate query strings.  For a localhost extension you can just set a query string. For more information, see [registering-extensions-with-the-registertestextension-api](#registering-extensions-with-the-registertestextension-api).

The developer may want to programmatically register a deployed extension with JavaScript and then reload the Portal. This step is optional if they use a [query string](portalfx-extensions-testing-in-production-glossary.md) method to load the extension into the browser from the localhost. To load an extension from the test environment or an unregistered source, extension developers can leverage the following approach.

1. Sign in to a production account at [https://portal.azure.com?feature.canmodifyextensions=true](https://portal.azure.com?feature.canmodifyextensions=true)
1.# Click **F12** to open the Developer Tools in the browser
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

The registered extension will be saved to User Settings , and will be available in future sessions. When the Portal is used in this mode, it displays a banner that indicates that the state of the configured extensions has been changed, as in the following image.

![Local extensions](../media/portalfx-testinprod/localExtensions.png)
</details>

For more information on loading, see [portalfx-testing-ui-test-cases.md](portalfx-testing-ui-test-cases.md).

<a name="testing-in-production-completing-the-extension-test"></a>
## Completing the extension test

When all steps are complete, the developer can submit a pull request to enable the extension, as specified in [portalfx-extensions-publishing](portalfx-extensions-publishing). When the extension is enabled, users will be able to access it in all environments, as specified in [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

<a name="testing-in-production-deploying-test-extensions-using-the-hosting-service"></a>
## Deploying test extensions using the hosting service
 
 For more information about common hosting scenarios, see  [portalfx-extensions-hosting-service-scenarios.md#sideloading](portalfx-extensions-hosting-service-scenarios.md#sideloading).  For information about debugging switches or feature flags that are used in hosting, see  [portalfx-extensions-flags.md](portalfx-extensions-flags.md).  For more information about alternatives to the local host environment, see [portalfx-extensions-hosting-service.md](portalfx-extensions-hosting-service.md). 

<a name="testing-in-production-common-use-cases-for-custom-stamps"></a>
## Common use cases for custom stamps

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



<a name="testing-in-production-best-practices"></a>
## Best Practices

This section contains best practices for testing extensions in production.

<a name="testing-in-production-best-practices-onebox-stb-is-not-available"></a>
### Onebox-stb is not available

    Onebox-stb has been deprecated. Please do not use it. Instead, migrate extensions to sideloading. For help on migration, send an email to  ibiza-onboarding@microsoft.com.

* * * 


<a name="testing-in-production-frequently-asked-questions"></a>
## Frequently asked questions

If there are enough FAQ's on the same subject, like sideloading, they have been grouped together in this document. Otherwise, FAQ's are listed in the order that they were encountered. Items that are specifically status codes or error messages can be located in [portalfx-extensions-status-codes.md](portalfx-extensions-status-codes.md).

<a name="testing-in-production-frequently-asked-questions-faqs-for-debugging-extensions"></a>
### FAQs for Debugging Extensions

***Where are the FAQ's for normal debugging?***

The FAQs for debugging extensions is located at [portalfx-extensions-faq-debugging.md](portalfx-extensions-faq-debugging.md).

* * *

<a name="testing-in-production-frequently-asked-questions-sandboxed-iframe-security"></a>
### Sandboxed iframe security

*** I get an error 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'. How do I fix this? ***

You need to allow the Azure Portal to frame your extension URL. For more information, [click here](portalfx-creating-extensions.md).

* * *

<a name="testing-in-production-sideloading-faqs"></a>
## Sideloading FAQs

<a name="testing-in-production-sideloading-faqs-sideloading-extension-gets-an-err_insecure_response"></a>
### Sideloading Extension gets an ERR_INSECURE_RESPONSE

*** My Extension fails to side load and I get an ERR_INSECURE_RESPONSE in the browser console ***

![ERR_INSECURE_RESPONSE](../media/portalfx-testinprod/errinsecureresponse.png)

In this case the browser is trying to load the extension but the SSL certificate from localhost is not trusted the solution is to install/trust the certificate.

Please checkout the stackoverflow post: [https://stackoverflow.microsoft.com/questions/15194/ibiza-extension-unable-to-load-insecure](https://stackoverflow.microsoft.com/questions/15194/ibiza-extension-unable-to-load-insecure)

* * *

<a name="testing-in-production-sideloading-faqs-sideloading-in-chrome"></a>
### Sideloading in Chrome

***Ibiza sideloading in Chrome fails to load parts***
    
Enable the `allow-insecure-localhost` flag, as described in [https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts](https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts)

* * *

<a name="testing-in-production-sideloading-faqs-sideloading-in-chrome-sideloading-gallery-packages"></a>
#### Sideloading gallery packages

***Trouble sideloading gallery packages***

SOLUTION:  Some troubleshooting steps are located at [https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages](https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages)

* * *

<a name="testing-in-production-sideloading-faqs-sideloading-in-chrome-sideloading-friendly-names"></a>
#### Sideloading friendly names

***Sideloading friendly names is not working in the Dogfood environment***

In order for Portal to load  a test version of an extension, i.e., load without using the PROD stamp, developers can append the feature flag `feature.canmodifystamps`. The following example uses the sideload url to load the "test" version of extension.

`https://portal.azure.com?feature.canmodifystamps=true&<extensionName>=test`

The parameter `feature.canmodifystamps=true` is required for side-loading, and 
 **extensionName**, without the angle brackets, is replaced with the unique name of extension as defined in the `extension.pdl` file. For more information, see [https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood](https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood).

* * *

<a name="testing-in-production-sideloading-faqs-other-testing-questions"></a>
### Other testing questions

***How can I ask questions about testing ?***

You can ask questions on Stackoverflow with the tag [ibiza-test](https://stackoverflow.microsoft.com/questions/tagged/ibiza-test).

--------


<a name="testing-in-production-status-codes-and-error-messages"></a>
## Status Codes and Error Messages
Status codes or error messages that are encountered while developing an extension may be dependent on the type of extension that is being created, or the development phase in which the message is encountered.  Terms that are encountered in the error messages may be defined in the [Glossary](portalfx-extensions-status-codes-glossary.md).
<!-- TODO:  Find at least one status code for each of these conditions. -->

<a name="testing-in-production-status-codes-and-error-messages-console-error-messages"></a>
### Console Error Messages

***Console error messages in F12 developer tools***

Some console and HTTP error messages are located at[https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx](https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx).

* * *

<a name="testing-in-production-status-codes-and-error-messages-err_connection_reset"></a>
### ERR_CONNECTION_RESET

***Cannot load `localhost` Ibiza extension with ERR_CONNECTION_RESET***

ERROR: The Storage Area Network (SAN) is missing in the certificate.

SOLUTION: [https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595](https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595)

* * * 

<a name="testing-in-production-status-codes-and-error-messages-err_insecure_response"></a>
### ERR_INSECURE_RESPONSE

ERR_INSECURE_RESPONSE in the browser console

***My Extension fails to sideload and I get an ERR_INSECURE_RESPONSE in the browser console***.
   
![alt-text](../media/portalfx-testinprod/errinsecureresponse.png "ERR_INSECURE_RESPONSE Log")

ERROR: the browser is trying to load the extension but the SSL certificate from localhost is not trusted.

SOLUTION: Install and trust the certificate.

* * *

<a name="testing-in-production-status-codes-and-error-messages-failed-to-initialize"></a>
### Failed To Initialize

ERROR: The extension failed to initialize. One or more calls to methods on the extension's entry point class failing.

SOLUTION: Scan all the relevant error messages during the timeframe of the failure. These errors should have information about what exactly failed while trying to initialize the extension, e.g. the initialize endpoint, the getDefinition endpoint, etc.

* * * 

<a name="testing-in-production-status-codes-and-error-messages-first-response-not-received"></a>
### First Response Not Received

ERROR: The shell loaded the extension URL obtained from the config into an IFrame; however there wasn't any response from the extension.

SOLUTION: 

1. Verify that the extension is correctly hosted and accessible from the browser.

1. The extension should have code injected in the  `layout.cshtml` which includes a postMessage call. Verify that this code gets executed.

* * * 

<a name="testing-in-production-status-codes-and-error-messages-invalid-definition"></a>
### Invalid Definition

ERROR: The definition that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension definition and fix them.

* * * 

<a name="testing-in-production-status-codes-and-error-messages-invalid-extension-name"></a>
### Invalid Extension Name

ERROR: The name of the extension as specified in the `extensions.json` configuration file doesn't match the name of the extension in the extension manifest.

SOLUTION: Verify what the correct name of the extension should be, and if the name in config is incorrect, update it.

If the name in the manifest is incorrect, contact the relevant extension team to update the  `<Extension>` tag in the PDL file with the right extension name and recompile.

* * * 

<a name="testing-in-production-status-codes-and-error-messages-invalid-indicate-loaded"></a>
### Invalid Indicate Loaded

ERROR: The manifest for an extension was received at an invalid time. e.g. if the manifest was already obtained or the extension was already loaded.

SOLUTION: Report this issue to the framework team for investigation.

* * * 

<a name="testing-in-production-status-codes-and-error-messages-invalid-manifest"></a>
### Invalid Manifest

ERROR: The manifest that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension manifest and fix them.

* * * 

<a name="testing-in-production-status-codes-and-error-messages-manifest-not-received"></a>
### Manifest Not Received

ERROR: The bootstrap logic was completed, however the extension did not return a manifest to the shell. The shell waits for a period of time (currently 40 seconds as of 2014/10/06) and then times out.

SOLUTION:
1. Verify that the extension is correctly hosted and accessible from the browser.

1. If the extension is using AMD modules, verify that the `manifest.js` file is accessible from the browser. Under default settings it should be present at `/Content/Scripts/_generated/manifest.js`.

* * * 

<a name="testing-in-production-status-codes-and-error-messages-portal-error-520"></a>
### Portal Error 520

***The Portal encountered a part it cannot render***

ERROR: The Portal displays a 520 error, as in the following image.

![alt-text](../media/portalfx-debugging/failure.png "Portal Error Message")

The Web server is returning an unknown error. 

SOLUTION: Use the following troubleshooting steps.

* Check the browser console, and look for errors that describe the error condition in more detail. 
* Click on the failed part. With some types of errors, this will add a stack trace to the browser console.
* Double check the Knockout template for correct syntax.
* Ensure that all variables that are used in the template are public properties on the corresponding view model class.
* Reset the desktop state.
* Enable first chance exceptions in the JavaScript debugger.
* Set break points inside the viewModel constructor to ensure no errors are thrown.

* * *

<a name="testing-in-production-status-codes-and-error-messages-sandboxed-iframe-security"></a>
### Sandboxed iframe security

***Error: 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'.***
 
The Azure Portal should frame the extension URL, as specified in [portalfx-extensions-developerInit-procedure.md](portalfx-extensions-developerInit-procedure.md) and [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).  Also see [#console-error-messages](#console-error-messages).

* * *

<a name="testing-in-production-status-codes-and-error-messages-timed-out"></a>
### Timed Out

ERROR: The extension failed to load after the predefined timeout, which is currently 40 seconds.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="testing-in-production-status-codes-and-error-messages-too-many-bootgets"></a>
### Too Many BootGets

ERROR: The extension tried to send the bootGet message to request for Fx scripts multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION:  Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="testing-in-production-status-codes-and-error-messages-too-many-refreshes"></a>
### Too Many Refreshes

ERROR: The extension tried  to reload itself within the IFrame multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 


<a name="testing-in-production-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term                 | Meaning |
| ---                  | --- |
| endpoint             | A device that is connected to a LAN and accepts or transmits communications across a network. In terms of directories or Web pages, there may be several endpoints that are defined on the same device.  | 
| localhost            | A hostname that means this computer or this host.  |
| obsolete script      | A script that makes certain parts of the Portal act as legacy code, in order to limit the performance costs of the old functionality to only extensions that are using them. | 
| query string       | The part of a uniform resource locator (URL) that contains data. Query strings are generated by form submission, or by being entered into the address bar of the browser after the URL. The  query string is specified by the values following the question mark (?). The values are used in Web processing, along with the path component of the URL. Query strings should not be used to transfer large amounts of data.  | 
| sandboxed iframe     | Enables an extra set of restrictions for the content in the iframe.  It can treat the content as being from a unique origin, block form submission or script execution, prevent links from targeting other browsing context, and other items that restrict the behavior of the iframe during testing. | 
| SAN                  | Storage Area Network  | 
| sideloading          | Loading an extension for a specific user session from any source other than the uri that is registered in the Portal.  The process of transferring data between two local devices, or between the development platform and the local host. Also side load, side-load. |   
| synthetic traffic    | Traffic that has been created with a traffic generators and that behaves like real traffic. It can be used to capture the behavior the network or device under test. | 
| untrusted extension | An extension that is not accompanied by an SSL certificate. |

