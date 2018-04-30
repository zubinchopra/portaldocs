<a name="testing-in-production"></a>
# Testing in Production

<a name="testing-in-production-introduction"></a>
## Introduction

This document describes the various components of testing an extension in production, including status codes and testing procedures. 

For information about regular testing and debugging, see [portalfx-test.md](portalfx-test.md) and [top-extensions-debugging.md](top-extensions-debugging.md).

For more information about testing extensions in the hosting service, see  [portalfx-extensions-hosting-service-scenarios.md#sideloading](portalfx-extensions-hosting-service-scenarios.md#sideloading).  
 
For information about debugging switches or feature flags that are used in hosting, see  [top-extensions-flags.md](top-extensions-flags.md).

For more information about alternatives to the local host environment, see [top-extensions-custom-deployment.md](top-extensions-custom-deployment.md). 

<a name="testing-in-production-registering-extensions-with-the-registertestextension-api"></a>
## Registering extensions with the registerTestExtension API

The developer may want to programmatically register a deployed extension with JavaScript and then reload the Portal. This step is optional if they use a [query string](portalfx-extensions-production-testing-glossary.md) method to load the extension into the browser from the localhost. Using the  `registerTestExtension` API for programmatic changes allows the developer to register a custom extension from `localhost`, or register a custom extension from a custom environment. To load an extension from the test environment or an unregistered source, extension developers can leverage the following approach.

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
 
The following example describes a complete uri and [query string](portalfx-extensions-glossary-production-testing.md) that instructs the Portal to load the extension named "Microsoft_Azure_Demo" from endpoint "https://DemoServer:59344". It registers the extension only for the current user session. 

<!--TODO: This example contradicts the previous definition.  Determine which one is correct.  -->

   ```ts
   MsPortalImpl.Extension.registerTestExtension({
     name: "Microsoft_Azure_Demo",
     uri: "https://DemoServer:44300"});
   ```
 
<a name="testing-in-production-unregistering-test-extensions"></a>
## Unregistering test extensions

When testing is completed, the developer can run the `unregisterTestExtension` method in the Developer Tools Console to reset the user settings and unregister the extension, as in the following example.

```ts
  MsPortalImpl.Extension.unregisterTestExtension("<extensionName>");
```

<a name="testing-in-production-loading-customized-extensions"></a>
## Loading customized extensions

Custom extensions that are used for testing can be loaded into the Portal by using feature flags. The `uriFormat` parameter, in conjunction with the `uri` parameter, can increase the number of extension editions that can be loaded in various Portal environments. These parameters are located in the `extensions.<EnvironmentName>.json` file, in conjunction with the `Client\extension.pdl` file. The edition of the extension that is loaded can be changed by modifying the `uri` and `uriFormat` parameters instead of using  **endpoint** and **portNumber** in the query string. For more information about extension configuration, see [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

To register a customized extension, or register a different extension edition, use the following parameters in the Portal extension query string.
 
```<protocol>://<environment>/?feature.canmodifyextensions=true#?testExtensions={"<extensionName>":"<protocol>://<uri>/"}```

where

* **protocol**: Matches the protocol of the shell into which the extension is loaded, without the angle brackets.  It can have a value of `HTTP` or a value of `HTTPS`. For the production shell, the value is `HTTPS`.  If the value of this portion of the parameter is incorrectly specified, the browser will not allow the extension to communicate. 

* **environment**: Portal environment in which to load the extension. Portal environments are `portal.azure.com`, `rc.portal.azure.com`, `mpac.portal.azure.com`, and `df.onecloud.azure-test.net`, although extension developers can sideload their extensions in any environment. 

* **feature.canmodifyextensions**: Required to support loading untrusted extensions for security purposes.  This feature flag grants permission to the Portal to load extensions from URLs other than the ones that are typically used by customers.  It triggers an additional Portal UI that indicates that the Portal is running with untrusted extensions. This feature flag has a value of `true`.  For more information about feature flags, see [top-extensions-flags.md](top-extensions-flags.md).

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

![alt-text](../media/portalfx-productiontest/localExtensions.png "Local extensions")

For more information on loading, see [top-extensions-csharp-test-framework.md](top-extensions-csharp-test-framework.md).

## Completing the extension test

When all steps are complete, the developer can submit a pull request to enable the extension, as specified in [top-extensions-publishing.md](top-extensions-publishing.md). When the extension is enabled, users will be able to access it in all environments, as specified in [top-extensions-developmentPhases.md](top-extensions-developmentPhases.md).

## Common use cases for custom extensions

There are several scenarios in which a developer test various aspects of an extension with different editions of the same extension. Three of them are as follows. 

1. Running automated tests

    Automated tests that run against a production environment should be marked as test/synthetic traffic. Use one of the following options to accomplish this.

   1. Add the `TestTraffic` phrase to the `userAgentString` field. Replace `TeamName` and `Component` in the following example with the appropriate values, without the angle brackets.

      ```TestTraffic-<TeamName>-<Component>  ```

   1. Set the query string parameter to `feature.UserType=test`. 
  This setting excludes test traffic from our reports.

1. Running regression tests

   Regression tests and build verification tests are    .
   <!-- TODO: Determine how extension editions are used to run partial tests. -->

1. Obsolete script bundles

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

    **NOTE**:  If the extension uses obsolete bundles, there may be a performance penalty when it is loaded.  Its performance can be  improved by migrating away from these dependencies, i.e. PCV1, PCV2 and  `CsmTopology` control. For more information about improving extension performance, see [portalfx-extensions-configuration-procedure.md#pcv1-and-pcv2-removal](portalfx-extensions-configuration-procedure.md#pcv1-and-pcv2-removal).

    For more information about obsolete bundles and obsolete script bundles, see [portalfx-extension-reference-obsolete-bundle.md](portalfx-extension-reference-obsolete-bundle.md).




## Best Practices

### Onebox-stb is not available

Onebox-stb has been deprecated. Please do not use it. Instead, migrate extensions to sideloading. For help on migration, send an email to  <a href="mailto:ibiza-onboarding@microsoft.com?subject=Help on Migration">ibiza-onboarding@microsoft.com</a>.

* * * 


## Frequently asked questions

<!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->

If there are enough FAQ's on the same subject, like sideloading, they have been grouped together in this document. Otherwise, FAQ's are listed in the order that they were encountered. Items that are specifically status codes or error messages can be located in [portalfx-extensions-status-codes.md](portalfx-extensions-status-codes.md).

### FAQs for Debugging Extensions

***Where are the FAQ's for normal debugging?***

The FAQs for debugging extensions is located at [portalfx-extensions-faq-debugging.md](portalfx-extensions-faq-debugging.md).

* * *

### Sandboxed iframe security

*** I get an error 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'. How do I fix this? ***

You need to allow the Azure Portal to frame your extension URL. For more information, [click here](portalfx-creating-extensions.md).

* * *

## Sideloading FAQs

### Sideloading Extension gets an ERR_INSECURE_RESPONSE

*** My Extension fails to side load and I get an ERR_INSECURE_RESPONSE in the browser console ***

![ERR_INSECURE_RESPONSE](../media/portalfx-productiontest/errinsecureresponse.png)

In this case the browser is trying to load the extension but the SSL certificate from localhost is not trusted the solution is to install/trust the certificate.

Please checkout the stackoverflow post: [https://stackoverflow.microsoft.com/questions/15194/ibiza-extension-unable-to-load-insecure](https://stackoverflow.microsoft.com/questions/15194/ibiza-extension-unable-to-load-insecure)

* * *

### Sideloading in Chrome

***Ibiza sideloading in Chrome fails to load parts***
    
Enable the `allow-insecure-localhost` flag, as described in [https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts](https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts)

* * *

#### Sideloading gallery packages

***Trouble sideloading gallery packages***

SOLUTION:  Some troubleshooting steps are located at [https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages](https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages)

* * *

#### Sideloading friendly names

***Sideloading friendly names is not working in the Dogfood environment***

In order for Portal to load a test version of an extension, i.e., load without using the PROD configuration, developers can append the feature flag `feature.canmodifystamps`. The following example uses the sideload url to load the "test" version of extension.

`https://portal.azure.com?feature.canmodifystamps=true&<extensionName>=test`

The parameter `feature.canmodifystamps=true` is required for side-loading, and 
 **extensionName**, without the angle brackets, is replaced with the unique name of extension as defined in the `extension.pdl` file. For more information, see [https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood](https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood).

* * *

### Other testing questions

***How can I ask questions about testing ?***

You can ask questions on Stackoverflow with the tag [ibiza-test](https://stackoverflow.microsoft.com/questions/tagged/ibiza-test).

--------


## FAQs for Debugging Extensions

### SSL certificates

   <!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->
   
***How do I use SSL certs?***
 
SSL Certs are relevant only for teams that host their own extensions.  Azure Portal ONLY supports loading extensions from HTTPS URLs. Use a wildcard SSL cert for each environment to simplify maintenance, for example,   ``` *.<extensionName>.onecloud-ext.azure-test.net  ``` or  ``` *.<extensionName>.ext.azure.com) ``` .    To simplify overall management when your team is building separate, independent extensions, you can also use  ``` <extensionName>.<team>.ext.azure.com ``` and create a wildcard SSL cert for  ``` *.<team>.ext.azure.com ```. Internal teams can create SSL certs for the DogFood environment using the SSL Administration Web page that is located at [http://ssladmin](http://ssladmin). 
 
 Production certs must follow your organization’s PROD cert process. 

 **NOTE** Do not use the SSL Admin site for production certs.

* * *

### Loading different versions of an extension

***How do I load different versions of an extension?***

Understanding which extension configuration to modify is located at [portalfx-extensions-configuration-overview.md#(#configuration-file-locations-and-structure](portalfx-extensions-configuration-overview.md#(#configuration-file-locations-and-structure).

* * * 

### Checking the version of a loaded extension

***I have set ApplicationContext.Version for my extension, how do I check what version of my extension is currently loaded in shell ?***

1.  Navigate to the Portal where your extension is hosted or side loaded.
1. Press F12 in the browser and select the console tab.
1. Set the current frame dropdown to that of your extension.
1. In the console type `fx.environment.version` and click enter to see the version of the extension on the client, as in the following image.

    ![alt-text](../media/portalfx-debugging/select-extension-iframe.png "Select extension iframe")

1. In addition, any requests that are made to the extension, including **Ajax** calls, should also return the version on the server in the response, as in the following image.

    ![alt-text](../media/portalfx-debugging/response-headers-show-version.png "Response Headers from extension show version")

  **NOTE**: There  can be a difference in the `fx.environment.version` on the client and the version in the `x-ms-version` returned from the server.  This can occur when the user starts a session and the extension is updated/deployed while the session is still active.

* * *

### Onboarding FAQ

***Where are the onboarding FAQs for Sparta (ARM/CSM-RP)?***

The SharePoint Sparta Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx).

* * *

 ### Compile on Save

**What is Compile on Save ?**

Compile on Save is a **TypeScript** option that   . To use it, make sure that **TypeScript** 2.0.3 was installed on your machine. The version can be verified by executing the following  command:

```bash
$>tsc -version
```
Then, verify that when a **TypeScript** file is saved, that the following text is displayed in the bottom left corner of your the **Visual Studio** application.

![alt-text](../media/portalfx-ide-setup/ide-setup.png "CompileOnSaveVisualStudio")

 * * *
 
### Other debugging questions

***How can I ask questions about debugging ?***

You can ask questions on Stackoverflow with the tag [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza).




## Status Codes and Error Messages

Status codes or error messages that are encountered while developing an extension may be dependent on the type of extension that is being created, or the development phase in which the message is encountered.  Terms that are encountered in the error messages may be defined in the [Glossary](portalfx-extensions-glossary-status-codes.md).
<!-- TODO:  Find at least one status code for each of these conditions. -->

### Console Error Messages

***Console error messages in F12 developer tools***

Some console and HTTP error messages are located at [https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx](https://msdn.microsoft.com/en-us/library/dn423949(v=vs.85).aspx).

* * *

### UNKNOWN ENTITY-TYPED OBJECT ARRAY 

***Error: "Entity-typed object/array is not known to this edit scope..."***

DESCRIPTION: After an `EditScope` is initialized and loaded, entities can be introduced and removed from the `EditScope` only by using `EditScope` APIs. Unfortunately, extensions cannot make an observable change to add or remove 'entity' objects from the `EditScope`. If an extension tries to make an observable change that introduces an 'entity' object into the EditScope, they will encounter this error. For any object residing in the `EditScope`, merely adding and removing keys cannot be detected by `EditScope` or by the FX at large and, consequently, edits cannot be tracked. When an extension attempts to add or remove keys from an `EditScope` object, this puts the `EditScope` edit-tracking in an inconsistent state.

SOLUTION: To correctly add or remove 'entity' objects, use the API's that are specified in 
[portalfx-legacy-editscopes.md#editScope-entity-arrays](portalfx-legacy-editscopes.md#editScope-entity-arrays).
 It is good practice to use only observable changes and `EditScope` APIs to mutate/change the EditScope/Form model.   A partial list is as follows.

* `applyArrayAsEdits`: This API accepts a new array of 'entity' objects. The `EditScope` will diff this new array against the existing `EditScope` array items, determine which 'entity' objects are created/updated/deleted, and then records the corresponding user edits.

* `getCreated/addCreated`: Addes new, 'created' entity objects to an `EditScope`.

* `markForDelete`: Marks 'entity'  objects in an `EditScope`  for deletion.

DESCRIPTION: Often, extensions encounter this error because the data is modeled  as 'entities' binding with [editable grid](#editable-grid) in a `ParameterProvider` Blade as specified in [portalfx-legacy-editscopes.md#editScope-entity-arrays](portalfx-legacy-editscopes.md#editScope-entity-arrays).  The error may also be encountered when applying the array edits in a corresponding `ParameterCollector` Blade. 

SOLUTION:  Here are two schemes that can be used to avoid this error.

* Use the `applyArrayAsEdits` to commit array edits to an `EditScope`.

* Define type metadata for this array twice. One copy is for array items typed as 'entities', and is used to edit the data in an editable grid. The other copy is for array items typed as not 'entities', and is used to commit data to an `EditScope` in the `ParameterCollector` blade.  
  
* * *

### Form improperly allows edits

*** Error: Form should not allow edits until an EditScope is loaded***

ERROR:

This error is commonly the result of making an observable change to `EditScope` data that is not due to the user making edits in the UI.   For example, establishing default values by writing to `EditScope` observables when a viewModel is initializing might cause this error.

SOLUTION: 

Extensions should use the `mapIncomingDataForEditScope` option when instantiating `ParameterProvider`, in order to establish initial values in the `EditScope`.

* * *

### ERR_CONNECTION_RESET

***Cannot load `localhost` Ibiza extension with ERR_CONNECTION_RESET***

ERROR: The Storage Area Network (SAN) is missing in the certificate.

SOLUTION: [https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595](https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595)

* * * 

### ERR_INSECURE_RESPONSE

ERR_INSECURE_RESPONSE in the browser console

***My Extension fails to sideload and I get an ERR_INSECURE_RESPONSE in the browser console***.
   
![alt-text](../media/portalfx-productiontest/errinsecureresponse.png "ERR_INSECURE_RESPONSE Log")

ERROR: the browser is trying to load the extension but the SSL certificate from localhost is not trusted.

SOLUTION: Install and trust the certificate.

* * *

### Failed To Initialize

ERROR: The extension failed to initialize. One or more calls to methods on the extension's entry point class failing.

SOLUTION: Scan all the relevant error messages during the timeframe of the failure. These errors should have information about what exactly failed while trying to initialize the extension, e.g. the initialize endpoint, the getDefinition endpoint, etc.

* * * 

### First Response Not Received

ERROR: The shell loaded the extension URL obtained from the config into an IFrame; however there wasn't any response from the extension.

SOLUTION: 

1. Verify that the extension is correctly hosted and accessible from the browser.

1. The extension should have code injected in the  `layout.cshtml` which includes a postMessage call. Verify that this code gets executed.

* * * 

### Invalid Definition

ERROR: The definition that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension definition and fix them.

* * * 



### Invalid Extension Name

ERROR: The name of the extension as specified in the `extensions.json` configuration file doesn't match the name of the extension in the extension manifest.

SOLUTION: Verify what the correct name of the extension should be, and if the name in config is incorrect, update it.

If the name in the manifest is incorrect, contact the relevant extension team to update the  `<Extension>` tag in the PDL file with the right extension name and recompile.

* * * 

### Invalid Indicate Loaded

ERROR: The manifest for an extension was received at an invalid time. e.g. if the manifest was already obtained or the extension was already loaded.

SOLUTION: Report this issue to the framework team for investigation.

* * * 

### Invalid Manifest

ERROR: The manifest that was received from an extension had validation errors.

SOLUTION: Scan the error logs for all the validation errors in the extension manifest and fix them.

* * * 

### Manifest Not Received

ERROR: The bootstrap logic was completed, however the extension did not return a manifest to the shell. The shell waits for a period of time (currently 40 seconds as of 2014/10/06) and then times out.

SOLUTION:
1. Verify that the extension is correctly hosted and accessible from the browser.

1. If the extension is using AMD modules, verify that the `manifest.js` file is accessible from the browser. Under default settings it should be present at `/Content/Scripts/_generated/manifest.js`.


* * * 

### Server Error 404 

ERROR: 404, Not Found.

DESCRIPTION: The Portal's built-in data layer automatically detects HTTP 404 responses from **AJAX** calls, in order to cover the most common scenarios.  When a part depends on data and a 404 has been detected, Ibiza automatically makes the part non-interactive and displays a message of 'Not Found'.  The effect is that in most "not found" scenarios, extensions will display the more accurate 'Not found' message instead of the sad cloud UX that is reserved for unexpected errors.

This distinction allows the Portal telemetry system to differentiate between bugs and deleted assets when parts  fail to render.

SOLUTION: Extensions should allow the Portal to handle 404 responses by default. However, there are exceptions where this behavior may not be the best action.  In those cases, the extension can opt out of automatic 404 handling by setting the `showNotFoundErrors` flag to `false` when creating the extension's `dataViews`. The following code makes 404s result in rejected promises, which allows individual extensions to apply special handling.

```js
this._dataView = dataContext.createView(container, { interceptNotFound: false });
```

**NOTE**: Instances of 'Not Found' do not count against a part's reliability KPI.



<a name="testing-in-production-loading-customized-extensions-internal-server-error-500"></a>
### Internal Server Error 500

ERROR: Received 500, Internal Server Error when loading the extension. The extension logs the message "*Unable to find AMD modules '_generated/Manifest'*".

SOLUTION:

1. Make sure the **JavaScript** files are embedded as resources in the extension assembly. To see embedded resources, open the assembly in Reflector or some similar tool and explore resources. It should display `<YourExtensionNamespace>/Content/ … /_generated/Manifest.js` and with similar resources, although the dots and slashes are interchangeable. 

1. If those resources are embedded, make sure the assembly contains the following attribute.

    `[assembly: AllowEmbeddedContent("<YourExtensionNamespace>")]` 
    
    This indicates that the **JavaScript** is an embedded resource with this prefix.

* * *

<a name="testing-in-production-loading-customized-extensions-portal-error-520"></a>
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

<a name="testing-in-production-loading-customized-extensions-sandboxed-iframe-security"></a>
### Sandboxed iframe security

***Error: 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'.***
 
The Azure Portal should frame the extension URL, as specified in [portalfx-extensions-getting-started-procedure.md](portalfx-extensions-getting-started-procedure.md) and [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).  Also see [#console-error-messages](#console-error-messages).

* * *

<a name="testing-in-production-loading-customized-extensions-timed-out"></a>
### Timed Out

ERROR: The extension failed to load after the predefined timeout, which is currently 40 seconds.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="testing-in-production-loading-customized-extensions-too-many-bootgets"></a>
### Too Many BootGets

ERROR: The extension tried to send the bootGet message to request for Fx scripts multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION:  Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 

<a name="testing-in-production-loading-customized-extensions-too-many-refreshes"></a>
### Too Many Refreshes

ERROR: The extension tried  to reload itself within the IFrame multiple times. The error should specify the number of times it refreshed before the extension was disabled.

SOLUTION: Scan the errors to see if there are any other relevant error messages during the time frame of the failure.

* * * 


<a name="testing-in-production-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term                 | Meaning |
| ---                  | --- |
| Developer Tools Console | | 
| diagnostic switch | | 
| endpoint             | A device that is connected to a LAN and accepts or transmits communications across a network. In terms of directories or Web pages, there may be several endpoints that are defined on the same device.  |
| extension stamp | An instance of a service in a region. Every extension can deploy one or more extension editions based on testing requirements. The main extension is used for production and is the only one that the Portal will load by default. Also known as configuration or configuration file.   | 
| hotfix | |
| localhost            | A hostname that means this computer or this host.  |
| obsolete script      | A script that makes certain parts of the Portal act as legacy code, in order to limit the performance costs of the old functionality to only extensions that are using them. | 
| phishing | | 
| pull request | |
| private preview | |
| query string       | The part of a uniform resource locator (URL) that contains data. Query strings are generated by form submission, or by being entered into the address bar of the browser after the URL. The  query string is specified by the values following the question mark (?). The values are used in Web processing, along with the path component of the URL. Query strings should not be used to transfer large amounts of data.  | 
| sandboxed iframe     | Enables an extra set of restrictions for the content in the iframe.  It can treat the content as being from a unique origin, block form submission or script execution, prevent links from targeting other browsing context, and other items that restrict the behavior of the iframe during testing. | 
| SAN                  | Storage Area Network  | 
| sideloading          | Loading an extension for a specific user session from any source other than the uri that is registered in the Portal.  The process of transferring data between two local devices, or between the development platform and the local host. Also side load, side-load. |   
| synthetic traffic    | Traffic that has been created with a traffic generators and that behaves like real traffic. It can be used to capture the behavior the network or device under test. | 
| untrusted extension | An extension that is not accompanied by an SSL certificate. |
| usability testing | |

