
<a name="frequently-asked-questions"></a>
## Frequently Asked Questions

This section contains all Azure Portal FAQ's.

<!-- TODO:  FAQ Format in the individual docs  is ###Link, ***title***, Description, Solution, 3 Asterisks -->

<a name="debugging-extensions"></a>
## Debugging Extensions

FAQ's that are associated with ordinary extension testing.

<a name="faqs-for-debugging-extensions"></a>
## FAQs for Debugging Extensions

<a name="faqs-for-debugging-extensions-ssl-certificates"></a>
### SSL certificates

   <!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->
   
***How do I use SSL certs?***
 
SSL Certs are relevant only for teams that host their own extensions.  Azure Portal ONLY supports loading extensions from HTTPS URLs. Use a wildcard SSL cert for each environment to simplify maintenance, for example,   ``` *.<extensionName>.onecloud-ext.azure-test.net  ``` or  ``` *.<extensionName>.ext.azure.com) ``` .    To simplify overall management when your team is building separate, independent extensions, you can also use  ``` <extensionName>.<team>.ext.azure.com ``` and create a wildcard SSL cert for  ``` *.<team>.ext.azure.com ```. Internal teams can create SSL certs for the DogFood environment using the SSL Administration Web page that is located at [http://ssladmin](http://ssladmin). 
 
 Production certs must follow your organization’s PROD cert process. 

 **NOTE** Do not use the SSL Admin site for production certs.

* * *

<a name="faqs-for-debugging-extensions-loading-different-versions-of-an-extension"></a>
### Loading different versions of an extension

***How do I load different versions of an extension?***

Understanding which extension configuration to modify is located at [portalfx-extensions-configuration-overview.md#(#configuration-file-locations-and-structure](portalfx-extensions-configuration-overview.md#(#configuration-file-locations-and-structure).

* * * 

<a name="faqs-for-debugging-extensions-checking-the-version-of-a-loaded-extension"></a>
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

<a name="faqs-for-debugging-extensions-onboarding-faq"></a>
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
 
<a name="faqs-for-debugging-extensions-other-debugging-questions"></a>
### Other debugging questions

***How can I ask questions about debugging ?***

You can ask questions on Stackoverflow with the tag [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza).



<a name="extension-configurations"></a>
## Extension Configurations

FAQ's that are associated with configurations for extensions.

<a name="frequently-asked-questions"></a>
## Frequently asked questions

<a name="frequently-asked-questions-ssl-certs"></a>
### SSL certs

***How do I use SSL certs?***

Instructions are located at [portalfx-extensions-faq-debugging.md#sslCerts](portalfx-extensions-faq-debugging.md#sslCerts).

* * *

<a name="frequently-asked-questions-loading-different-versions-of-an-extension"></a>
### Loading different versions of an extension

***How do I load different versions of an extension?***

Understanding which extension configuration to modify is located at [portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify](portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify).




<a name="forms"></a>
## Forms

FAQ's for forms.

<a name="frequently-asked-questions"></a>
## Frequently asked questions

<a name="frequently-asked-questions-should-i-use-an-action-bar-or-a-commands-toolbar-on-my-form"></a>
### Should I use an action bar or a commands toolbar on my form?

It depends on the scenario that drives the UX. If the form will capture some data from the user and expect the blade to be closed after submitting the changes, then use an action bar, as specified in [portalfx-ux-create-forms.md#action-bar-+-blue-buttons](portalfx-ux-create-forms.md#action-bar-+-blue-buttons).  However, if the form will edit or update some data, and expect the user to make multiple changes before the blade is closed, then use commands, as specified in [portalfx-commands.md](portalfx-commands.md). 

* Action Bar

  The action bar will have one button whose label is something like "OK", "Create", or "Submit". The blade should automatically close immediately after the action bar button is clicked. Users can abandon the form by clicking the Close button that is located at the top right of the application bar. Developers can use a `ParameterProvider` to simplify the code, because it provisions the `editScope` and implicitly closes the blade based on clicking on the action bar. 

  Alternatively, the action bar can contain two buttons, like "OK" and "Cancel", but that requires further configuration. The two-button method is not recommended because the "Cancel" button is made redundant by the Close button.

* Commands
  
  Typically, the two commands at the top of the blade are the "Save" command and the "Discard" command. The user can make edits and click "Save" to commit the changes. The blade should show the appropriate UX for saving the data, and will stay on the screen after the data has been saved. The user can make further changes and click "Save" again. The user can also discard their changes by clicking "Discard". Once the user is satisfied with the changes, they can close the blade manually.
  
* * * 

<a name="hosting-service"></a>
## Hosting Service

FAQ's that are associated with extension hosting. 



<a name="frequently-asked-questions"></a>
## Frequently asked questions

<!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->


<a name="frequently-asked-questions-content-unbundler-throws-aggregate-exception"></a>
### Content Unbundler throws aggregate exception

***Content Unbundler throws an Aggregate Exception during build.***

This usually happens when the build output generated by content unbundler is different from expected format.  The solution is as follows.

1. Verify build output directory is called **bin**
1. Verify you can point IIS to **bin** directory and load extension

For more information, see [portalfx-extensions-hosting-service-overview.md#prerequisites-for-onboarding-hosting-service](portalfx-extensions-hosting-service-overview.md#prerequisites-for-onboarding-hosting-service).

* * *

<a name="frequently-asked-questions-finding-old-ux-after-deployment"></a>
### Finding old UX After Deployment

***Some customers of my extension are finding the old UX even after deploying the latest package. Is there a bug in hosting service ?***

No this is not a bug. All clients will not get the new version as soon as it gets deployed. The new version is only served when the customer refreshes the Portal. We have seen customers that keep the Portal open for long periods of time. In such scenarios, when customer loads the extension they are going to get the old version that has been cached.
We have seen scenarios where customers did not refresh the Portal for 2 weeks. 

* * * 

<a name="frequently-asked-questions-friendly-name-support"></a>
### Friendly name support

***When will support for friendly names become available ?***

Azure support for friendly names became available in SDK release 5.0.302.834.

* * *

<a name="frequently-asked-questions-how-extensions-are-served"></a>
### How extensions are served

***How does hosting service serve my extension?***

The runtime component of the hosting service is hosted inside an Azure Cloud Service. When an extension onboards, a publicly accessible endpoint is provided by the extension developer which will contain the contents that the hosting service should serve. For the hosting service to pick them up, it will look for a file called `config.json` that has a specific schema described below. 

The hosting service will upload the config file, look into it to figure out which zip files it needs to download. There can be multiple versions of the extension referenced in `config.json`. The hosting service will upload them and unpack them on the local disk. After it has successfully uploaded and expanded all versions of the extension referenced in `config.json`, it will write `config.json` to disk.

For performance reasons, once a version is uploaded, it will not be uploaded again. 

* * * 

<a name="frequently-asked-questions-output-zip-file-incorrectly-named"></a>
### Output zip file incorrectly named

***When I build my project, the output zip is called HostingSvc.zip instead of \<some version>.zip.***

The primary cause of this issue is that your `web.config` appSetting for **IsDevelopmentMode** is `true`.  It needs to be set to `false`.  Most do this using a `web.Release.config` transform. For example,

```xml
    <?xml version="1.0" encoding="utf-8"?>

    <!-- For more information on using web.config transformation visit http://go.microsoft.com/fwlink/?LinkId=125889 -->

    <configuration xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
      <appSettings>
        <!-- dont forget to ensure the Key is correct for your specific extension -->
        <add key="Microsoft.Portal.Extensions.Monitoring.ApplicationConfiguration.IsDevelopmentMode" value="false" xdt:Transform="SetAttributes" xdt:Locator="Match(key)"/>
      </appSettings>
    </configuration>

```

* * * 

<a name="frequently-asked-questions-rollout-time-for-stages"></a>
### Rollout time for stages

***How much time does hosting service take to rollout a new version of extension to the relevant stage?*** 

The hosting service takes about 5 minutes to publish the latest version to all data centers.

* * *


<a name="frequently-asked-questions-sas-tokens"></a>
### SAS Tokens

***Can I provide a SAS token instead of keyvault for EV2 to access the storage account ?***

The current rolloutspec generated by **ContentUnbundler** only provides support for using keyvault. If you would like to use SAS tokens, please submit a request on [UserVoice](https://aka.ms/portalfx/uservoice)

* * *

<a name="frequently-asked-questions-speed-up-test-cycles"></a>
### Speed up test cycles

***My local build is slow. How can I speed up the dev/test cycles ?***

The default F5 experience for extension development remains unchanged however with the addition of the **ContentUnbundler** target some teams prefer to optimize to only run it on official builds or when they set a flag to force it to run.  The following example demonstrates how the Azure Scheduler extension is doing this within **CoreXT**.

```xml
    <PropertyGroup>
        <ForceUnbundler>false</ForceUnbundler>
    </PropertyGroup>
    <Import Project="$(PkgMicrosoft_Portal_Tools_ContentUnbundler)\build\Microsoft.Portal.Tools.ContentUnbundler.targets" 
            Condition="'$(IsOfficialBuild)' == 'true' Or '$(ForceUnbundler)' == 'true'" />
```

* * * 

<a name="frequently-asked-questions-storage-account-registration"></a>
### Storage account registration

***Do I need to register a new storage account everytime I need to upload zip file ?***

No. Registering a storage account with the hosting service is one-time process, as specified in . This allows the hosting service to find the latest version of your extension.

* * * 

<a name="frequently-asked-questions-zip-file-replaced-in-storage-account"></a>
### Zip file replaced in storage account

***What happens if instead of publishing new version to my storage account I replace the zip file ?***

Hosting service will only serve the new versions of zip file. If you replace version `1.0.0.0.zip` with a new version of `1.0.0.0.zip`, then hosting service will not detect.
It is required that you publish new zip file with a different version number, for example `2.0.0.0.zip`, and update `config.json` to reflect that hosting service should service new version of extension.

Sample config.json for version 2.0.0.0

```json
    {
        "$version": "3",
        "stage1": "2.0.0.0",
        "stage2": "2.0.0.0",
        "stage3": "2.0.0.0",
        "stage4": "2.0.0.0",
        "stage5": "2.0.0.0",
    }
```
**NOTE**: This samples depicts that all stages are serving version 2.0.0.0.

* * * 

<a name="frequently-asked-questions-other-hosting-service-questions"></a>
### Other hosting service questions

***How can I ask questions about hosting service ?***

You can ask questions on Stackoverflow with the tag [ibiza-deployment](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment).

* * * 

<a name="samples"></a>
## Samples

FAQ's that are associated with Azure samples.

<a name="frequently-asked-questions"></a>
## Frequently asked questions


<!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->
<a name="frequently-asked-questions-samples-will-not-compile"></a>
### Samples will not compile

***How do I fix this?***

 Description:
 Right out of the box, the samples are not aware of whether V1 or V2 is being used, or whether the IDE options match the version. There may be an error message TS1219.  Errors may also occur based on the version of the SDK.

 SOLUTION:  Add a `tsconfig.json` file to the project that specifies that decorators are experimental, as in the following code.

 ```cs
 {
  "compilerOptions": {
    "noImplicitAny": false,
    "noEmitOnError": true,
    "removeComments": false,
    "sourceMap": true,
    "target": "es5",
    "experimentalDecorators": true
  },
  "exclude": [
    "node_modules"
  ]
}
 ```
 
 For more information, see [https://stackoverflow.com/questions/35460232/using-of-typescript-decorators-caused-errors](https://stackoverflow.com/questions/35460232/using-of-typescript-decorators-caused-errors).

 * * *

<a name="frequently-asked-questions-cannot-launch-iis"></a>
### Cannot launch IIS

*** Unable to launch the Microsoft Visual Studio IIS Express Web server***

Description:
Failed to register URL "https://localhost:44306/" for site "SamplesExtension" application "/". Error description: Cannot create a file when that file already exists. (0x800700b7)

SOLUTION:  Terminate IIS express processes in Task Manager and click F5 again.

* * *

<a name="sideloading"></a>
## Sideloading

<a name="frequently-asked-questions"></a>
## Frequently asked questions
   
<a name="frequently-asked-questions-extension-will-not-sideload"></a>
### Extension will not sideload

*** My Extension fails to side load and I get an ERR_INSECURE_RESPONSE in the browser console ***

![ERR_INSECURE_RESPONSE](../media/portalfx-productiontest/errinsecureresponse.png)

In this case the browser is trying to load the extension but the SSL certificate from localhost is not trusted the solution is to install/trust the certificate.

Please checkout the stackoverflow post: [https://stackoverflow.microsoft.com/questions/15194/ibiza-extension-unable-to-load-insecure](https://stackoverflow.microsoft.com/questions/15194/ibiza-extension-unable-to-load-insecure)

* * *

<a name="frequently-asked-questions-sandboxed-iframe-security"></a>
### Sandboxed iframe security

*** I get an error 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'. How do I fix this? ***

You need to allow the Azure Portal to frame your extension URL. For more information, [click here](portalfx-creating-extensions.md).

* * *



<a name="testing-in-production"></a>
## Testing in Production

FAQ's that are associated with testing an extension in the production environment.

<a name="frequently-asked-questions"></a>
## Frequently asked questions

<!-- TODO:  FAQ Format is ###Link, ***title***, Description, Solution, 3 Asterisks -->

If there are enough FAQ's on the same subject, like sideloading, they have been grouped together in this document. Otherwise, FAQ's are listed in the order that they were encountered. Items that are specifically status codes or error messages can be located in [portalfx-extensions-status-codes.md](portalfx-extensions-status-codes.md).

<a name="frequently-asked-questions-faqs-for-debugging-extensions"></a>
### FAQs for Debugging Extensions

***Where are the FAQ's for normal debugging?***

The FAQs for debugging extensions is located at [portalfx-extensions-faq-debugging.md](portalfx-extensions-faq-debugging.md).

* * *

<a name="frequently-asked-questions-sandboxed-iframe-security"></a>
### Sandboxed iframe security

*** I get an error 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'. How do I fix this? ***

You need to allow the Azure Portal to frame your extension URL. For more information, [click here](portalfx-creating-extensions.md).

* * *

<a name="sideloading-faqs"></a>
## Sideloading FAQs

<a name="sideloading-faqs-sideloading-extension-gets-an-err_insecure_response"></a>
### Sideloading Extension gets an ERR_INSECURE_RESPONSE

*** My Extension fails to side load and I get an ERR_INSECURE_RESPONSE in the browser console ***

![ERR_INSECURE_RESPONSE](../media/portalfx-productiontest/errinsecureresponse.png)

In this case the browser is trying to load the extension but the SSL certificate from localhost is not trusted the solution is to install/trust the certificate.

Please checkout the stackoverflow post: [https://stackoverflow.microsoft.com/questions/15194/ibiza-extension-unable-to-load-insecure](https://stackoverflow.microsoft.com/questions/15194/ibiza-extension-unable-to-load-insecure)

* * *

<a name="sideloading-faqs-sideloading-in-chrome"></a>
### Sideloading in Chrome

***Ibiza sideloading in Chrome fails to load parts***
    
Enable the `allow-insecure-localhost` flag, as described in [https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts](https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts)

* * *

<a name="sideloading-faqs-sideloading-in-chrome-sideloading-gallery-packages"></a>
#### Sideloading gallery packages

***Trouble sideloading gallery packages***

SOLUTION:  Some troubleshooting steps are located at [https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages](https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages)

* * *

<a name="sideloading-faqs-sideloading-in-chrome-sideloading-friendly-names"></a>
#### Sideloading friendly names

***Sideloading friendly names is not working in the Dogfood environment***

In order for Portal to load a test version of an extension, i.e., load without using the PROD configuration, developers can append the feature flag `feature.canmodifystamps`. The following example uses the sideload url to load the "test" version of extension.

`https://portal.azure.com?feature.canmodifystamps=true&<extensionName>=test`

The parameter `feature.canmodifystamps=true` is required for side-loading, and 
 **extensionName**, without the angle brackets, is replaced with the unique name of extension as defined in the `extension.pdl` file. For more information, see [https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood](https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood).

* * *

<a name="sideloading-faqs-other-testing-questions"></a>
### Other testing questions

***How can I ask questions about testing ?***

You can ask questions on Stackoverflow with the tag [ibiza-test](https://stackoverflow.microsoft.com/questions/tagged/ibiza-test).

--------




