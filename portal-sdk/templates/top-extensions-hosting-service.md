
## Portal Extension Hosting Service

## Overview

The Ibiza team provides and operates a common extension hosting service that makes it easy to get an extension into a global distribution system without having to manage your own infrastructure.

A hosting service can make your web sites accessible through the World Wide Web by providing server space, Internet connectivity and data center security.

Teams that deploy UI for extensions with the classic cloud service model typically have to invest significant amounts of time to onboard to [MDS](portalfx-extensions-hosting-service-glossary.md), setup compliant deployments across all data centers, and configure [cdn](portalfx-extensions-hosting-service-glossary.md), storage and caching optimizations for each extension.

The cost of setting up and maintaining this infrastructure can be high. By leveraging the extension hosting service, developers can deploy extensions in all data centers without resource-heavy investments in the Web infrastructure.

For less common scenarios, you might need to do a custom deployment. For example, if the extension needs to reach server services using certificate based authentication, then there should be controller code on the server that our hosting service does not support. You should be very sure that a custom hosting solution is the correct solution previous to developing one. For more information, see [top-extensions-custom-deployment.md](top-extensions-custom-deployment.md).

The SLA for onboarding the extension to the hosting service is located at [top-extensions-svc-lvl-agreements.md](top-extensions-svc-lvl-agreements.md).

You can ask questions on Stackoverflow with the tags [ibiza-deployment](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment) and [ibiza-hosting-service](https://stackoverflow.microsoft.com/questions/tagged/ibiza-hosting-service).

For more information about Stackoverflow, see [portalfx-stackoverflow.md](portalfx-stackoverflow.md).

### How the hosting service serves an extension

 The runtime component of the hosting service is hosted inside an Azure Cloud Service. The extension developer provides a publicly accessible endpoint that contains the contents that the hosting service will serve. When an extension onboards to the service, the service  locates a file named  `config.json` in this endpoint.

The hosting service will upload the config file, and look into it to figure out which zip files it needs. There can be multiple versions of the extension referenced in `config.json`. The hosting service will upload them and unpack them on the local disk. After it has successfully uploaded and expanded all versions of the extension referenced in `config.json`, it will write `config.json` to disk.

For performance reasons, a version of an extension can only be uploaded once.

### Reasons for using the hosting service

More than 50% of the extensions have been migrated from legacy DIY deployment to extension hosting services. Some reasons for using the hosting service are as follows.

1. Simple deployments and hosting out of the box 
    
    * Use safe deployment practices

    * [Geodistributes](portalfx-extensions-hosting-service-glossary.md) the extension to all data centers

    * CDN configured

    * Use the Portal's MDS so there is no need to onboard to MDS

    * Use optimizations like persistent caching, index page caching, manifest caching and others 

1. Enhanced monitoring 

    * Removes the need for on-call rotation for hosting specific issues because the Portal is now hosting. On-call support is still required for dev code live site issues

    * Provides full visibility into the health and activity for an extension

1. Reduced COGS

    *  No hosting [COGS](portalfx-extensions-hosting-service-glossary.md)

    *  Reduced development costs allow teams to focus on building the domain specific portions of the extension, instead of allocating resources to configuring deployment


### Hosting services and server-side code

Extensions that have server-side code or controllers can use hosting services.  In fact, you can supplement a legacy DIY deployment infrastructure to use a hosting service, and deploy extensions in a way that complies with safe-deployment practices. 
1.	In most cases, UI controllers or [MVC](portalfx-extensions-hosting-service-glossary.md) controllers are legacy, and it is easy to obsolete these controllers. One advantage of replacing obsolete UI controllers is that all client applications, such as **Ibiza** and **PowerShell**, will have a consistent experience. You can replace UI controllers under the following conditions.
    *	If the functionality is already available from another service
    *	By hosting server-side code within an existing RP
1.	If replacing UI controllers is not a short-term task, the extension can be deployed through a hosting service by modifying the relative controller URLs.  They are located in  client code, and can be changed to specify absolute URLS. 

    <!--TODO: Locate a better word than "pull-request" for sample code.  This links to the commit branch instead of a request that can be sent to another team for processing. -->

    The following is a sample pull-request for a cloud services extension. [https://msazure.visualstudio.com/One/_git/AzureUX-CloudServices/commit/ac183c0ec197de7c7fd3e1eee1f7b41eb5f2dc8b](https://msazure.visualstudio.com/One/_git/AzureUX-CloudServices/commit/ac183c0ec197de7c7fd3e1eee1f7b41eb5f2dc8b).
    
    When this code change is posted, the extension can be deployed as a server-only service that is behind **Traffic Manager**.
    
    The extension versions that are available in the Hosting Service are located at the following URLs.

    * Dogfood: [https://hosting.onecloud.azure-test.net/api/diagnostics](https://hosting.onecloud.azure-test.net/api/diagnostics)
    * MPAC: [https://hosting-ms.portal.azure.net/api/diagnostics](https://hosting-ms.portal.azure.net/api/diagnostics)
    * PROD: [https://hosting.portal.azure.net/api/diagnostics](https://hosting.portal.azure.net/api/diagnostics)

 ### Prerequisites for onboarding hosting service

The **Visual Studio** project that is associated with developing the extension contains several files that will be updated or overridden while getting the extension ready for the hosting service. This topic discusses the files to create or change to meet requirements for the onboarding process. This procedure uses the **Content Unbundler** tool that was installed with the **nuGet** packages in Visual Studio.  For more information, see [portalfx-extensions-create-blank-procedure.md](portalfx-extensions-create-blank-procedure.md) and [top-extensions-nuget.md](top-extensions-nuget.md).

1. For all extensions
   * SDK Version 

     Use Portal SDK 5.0.302.454 or newer to generate the zip file during the extension build process.
    
     **NOTE**: If your team plans to use EV2 for uploading the zip file to its storage account, we recommend using Portal SDK 5.0.302.817 or newer. Some new features have recently been added that make it easier to use EV2 with a hosting service.

    * Build Output Format
      * Verify that the build output directory is named `bin`
      * Verify that **IIS** can point to the `bin` directory 
      * Verify that **IIS** will load extension from the `bin` directory

1. For extensions with controllers or server-side code

   Modify the relative controller URLs to contain absolute URLS. The controllers will deploy a new server-only service that will be behind the **Traffic Manager**.
   
   Because this process is typically the same across all extensions, you can use the following pull request for a cloud services extension.
  [https://msazure.visualstudio.com/One/_git/AzureUX-CloudServices/commit/ac183c0ec197de7c7fd3e1eee1f7b41eb5f2dc8b](https://msazure.visualstudio.com/One/_git/AzureUX-CloudServices/commit/ac183c0ec197de7c7fd3e1eee1f7b41eb5f2dc8b).

#### Logging

  The Portal provides a way for extensions to log to MDS using a feature that can be enabled in the extension. The logs generated by the extension when this feature is enabled are located in tables in the Portal's MDS account. For more information about the Portal logging feature, see  [portalfx-telemetry.md#logging](portalfx-telemetry.md#logging).

#### Trace Events

Trace events are stored in a **po** database, and can be analyzed with the Kusto.WebExplorer tool. The following link contains a query that specifies which trace events to consider for analysis.
[https://ailoganalyticsportal-privatecluster.cloudapp.net/clusters/Azportal/databases/AzurePortal?query=ExtEvents%7Cwhere+PreciseTimeStamp%3Eago(10m)](https://ailoganalyticsportal-privatecluster.cloudapp.net/clusters/Azportal/databases/AzurePortal?query=ExtEvents%7Cwhere+PreciseTimeStamp%3Eago(10m))

The following image contains a list of tables that are a part of the Kusto database schema. It also displays the columns from the `ExtEvents` table that was used in the previous query.

 ![alt-text](../media/portalfx-extensions-hosting-service/KustoWebExplorerQuery.png  "Trace Event Parameters")

For more information about Kusto WebExplorer and associated functions, see [https://kusto.azurewebsites.net/docs/queryLanguage/query_language_syntax.html?q=cross](https://kusto.azurewebsites.net/docs/queryLanguage/query_language_syntax.html?q=cross). For questions to the developer community, use the  Stackoverflow tag [ibiza-deployment](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment) and [ibiza-hosting-service](https://stackoverflow.microsoft.com/questions/tagged/ibiza-hosting-service).


#### Telemetry Events

Telemetry events are stored in the **Kusto** database in the `ExtTelemetry` table.  To  review telemetry events, use the following query against the Kusto.WebExplorer site.

[https://ailoganalyticsportal-privatecluster.cloudapp.net/clusters/Azportal/databases/AzurePortal?query=ExtTelemetry%7Cwhere+PreciseTimeStamp%3Eago(10m)](https://ailoganalyticsportal-privatecluster.cloudapp.net/clusters/Azportal/databases/AzurePortal?query=ExtTelemetry%7Cwhere+PreciseTimeStamp%3Eago(10m))

#### Monitoring

 There are two categories of issues that are monitored for each extension.

1.  Portal loading and running the extension

    The Portal has alerts that notify extensions when they fail to load for any reason. Issues like blade load failures and part load failures are also monitored.

    <!-- TODO: Determine whether the work that needed to be done to monitor blade load failures and part load failures has been done. -->
    <!-- TODO: Determine whether it is the extension that is notified, or the partner that is notified. -->

1. Hosting Service downloading and servicing the extension

    The hosting service pings the endpoint that contains the extension bits once every 5 minutes. It will then download any new configurations and versions that it finds. If it fails to download or process the downloaded files, it logs these as errors in its own MDS tables.

    Alerts and monitors have been developed for any issues. The Ibiza team receives notifications if any errors or warnings are generated by the hosting service. 
    You can access the logs of the hosting service at [https://jarvis-west.dc.ad.msft.net/53731DA4](https://jarvis-west.dc.ad.msft.net/53731DA4).

 
## Procedures

### Checklist for onboarding hosting service

There are two different ways to onboard an extension to a hosting service. If your extension has never been hosted, and it should be onboarded to the hosting service, use the procedures named [initial onboarding to the hosting service](#initial-onboarding-to-the-hosting-service).
If your extension was previously hosted, and is being migrated from DIY legacy deployment to a hosting service, use the procedure named [converting from DIY deployment to a hosting service](#converting-from-diy-deployment-to-a-hosting-service).

#### Initial onboarding to the hosting service

The procedure for onboarding to the hosting service is as follows. Click on the link for an in-depth discussion of each step.
1. [Update IsDevelopmentMode](#update-isdevelopmentmode-flag) 
1. [Install ContentUnbundler](#install-contentunbundler) 
1. [Verify the version number](#verify-the-version-number)
1. [Provide environment-specific configuration files](#provide-environment-specific-configuration-files)
1. [Execute Content Unbundler](#execute-content-unbundler)
1. [Upload safe deployment config](#upload-safe-deployment-config)
1. [Register the extension](#register-the-extension)

#### Update IsDevelopmentMode flag 

The **Content Unbundler** tool requires setting the development mode to `false` to assign the correct build version to the zip file.

Update the **IsDevelopmentMode** flag in the `web.config` file to false, as in the following example.
```xml
    <add key="Microsoft.Portal.Extensions.<extensionName>.ApplicationConfiguration.IsDevelopmentMode" value="false"/>
```

The following example updates the **IsDevelopmentMode** flag for a monitoring extension.

```xml
    <add key="Microsoft.Portal.Extensions.MonitoringExtension.ApplicationConfiguration.IsDevelopmentMode" value="false"/>
```

If the **IsDevelopmentMode** flag setting should be reserved for release builds only, use a `web.Release.config` transform, as specified in [http://go.microsoft.com/fwlink/?LinkId=125889](http://go.microsoft.com/fwlink/?LinkId=125889).
 
#### Install ContentUnbundler 

**Microsoft.Portal.Tools.ContentUnbundler** provides a **Content Unbundler** tool that can be run against the extension assemblies to extract static content and bundles. 

* If you installed the **Content Unbundler** tool by using **Visual Studio**, **NuGet Package Manager** or `NuGet.exe`, it will automatically add the following target.

```xml
<Import Project="$(PkgMicrosoft_Portal_Tools_ContentUnbundler)\build\Microsoft.Portal.Tools.ContentUnbundler.targets" />
```

* If you are using **CoreXT** global `packages.config`, the previous target should be added to the `.csproj` file manually.

#### Verify the version number

The zip file generated during the build should be named `<BUILD_VERSION>.zip`, where <BUILD_VERSION> is the current version number. For more information about version numbers, see [portalfx-extensions-versioning.md](portalfx-extensions-versioning.md).

* CoreXT extensions

    Display the version number of the build.
    In this example, the computer displays the following build version.

    ```cs
    $>set CURRENT_BUILD_VERSION
    CURRENT_BUILD_VERSION=5.0.0.440
    ```

* Non-CoreXT extensions

    There are multiple build systems used by various teams. After you have determined which build version is used by your team, please send a pull request to help other extension developers. The pull request is located at [https://aka.ms/portalfx/pullrequest](https://aka.ms/portalfx/pullrequest).

    If the extension build does not have a version number, the `AssemblyInfo.cs` file in the **Visual Studio** project can be edited to set the build version to 1.0.0.0.  If the file does not exist, add it in the same folder as the one that contains the `<extensionName>.csproj` and `web.config` files. The process is as follows.

    1. Add new file **AssemblyInfo.cs**.

    ```xml <Compile Include="AssemblyInfo.cs" /> ```

    1. Update **AssemblyInfo.cs** content

    ```cs
    //-----------------------------------------------------------------------------
    // Copyright (c) Microsoft Corporation.  All rights reserved.
    //-----------------------------------------------------------------------------

    using Microsoft.Portal.Framework;

    [assembly: AllowEmbeddedContent("Microsoft.Portal.Extensions.<extensionName>")]
    [assembly: System.Reflection.AssemblyFileVersion("1.0.0.0")]
    ```

    **NOTE**: `Microsoft.Portal.Extensions.<extensionName>` specifies the fully qualified name of the extension. The build version is hard-coded to 1.0.0.0.
 
### Provide environment-specific configuration files

Environment configuration files serve two purposes.

* They [override settings](#overriding-settings) for the target environment 
* They [load the extension](#loading-in-the-target-environment) in the target environment


#### Overriding settings

The content of the configuration file is a json object with key/value pairs for settings to be overridden.  If there are no settings to override, the file should contain an empty json object. 

The settings for the Portal framework are in the format of `Microsoft.Azure.<extensionName>.<settingName>`, where `settingName`, without the angle brackets, is the name of the setting. The framework will propagate the setting to the client in the format of `<settingName>`. For example, the `web.config` file that contains this setting would resemble the following.

```xml
<add key="Microsoft.Azure.<extensionName>.<settingName>" value="myValue" />
```

The equivalent configuration file would resemble the following.

```json
{
    "settingName": "myValue"      
}
```

#### Loading in the target environment

In order to load the extension in a specific environment, the  configuration file should be an embedded resource in the `Content\Config\*` directory of the **Visual Studio** project, as in the following example.

![alt-text](../media/portalfx-extensions-hosting-service/contentConfig.png  "Trace Event Parameters")

If the file is not set as an `EmbeddedResource` in the EmbeddedContentMetadata.txt file, it will not be included in the output that gets generated by the **Content Unbundler** tool. 

The files are named using the following convention:

`<host>.<domain>.json`

where

**host**: Optional. The environment that is associated with the domain. Values are  `ms` and `rc`. When this node is omitted, the dot that precedes the domain name is also omitted.

**domain**: Contains the value `portal.azure.com`.


The following are examples for each environment.

1. Dogfood 

    The configuration file is named  `df.onecloud.azure-test.net.json`, as in the following example.

        ```xml
        <EmbeddedResource Include="Content\Config\df.onecloud.azure-test.net.json" />
        ```

1. Production

    The production environment uses three extension configurations, as in the following table.

    | Environment | Configuration       |
    | ----------- | ------------------- |
    | RC          | rc.portal.azure.com |
    | MPAC        | ms.portal.azure.com |
    | PROD        | portal.azure.com    |

    The `portal.azure.com.json` file  is enough to serve all production environments. If an environment requires a config value that is different from other environments, then an additional environment configuration can be added, for example,  `ms.portal.azure.com.json`.

    ```xml
    <EmbeddedResource Include="Content\Config\portal.azure.com.json" />
    <EmbeddedResource Include="Content\Config\rc.portal.azure.com.json" />
    <EmbeddedResource Include="Content\Config\ms.portal.azure.com.json" />
    ```

1. Mooncake 
        
    The configuration file is named  `portal.azure.cn.json`, as in the following example.

    ```xml
    <EmbeddedResource Include="Content\Config\portal.azure.cn.json" />
    ```

1. Blackforest

    The configuration file is named `portal.microsoftazure.de.json`, as in the following example.

    ```xml
    <EmbeddedResource Include="Content\Config\portal.microsoftazure.de.json" />
    ```

1. FairFax 

    The configuration file name is named `portal.azure.us.json`, as in the following example.

    ```xml
    <EmbeddedResource Include="Content\Config\portal.azure.us.json" />
    ```
#### Execute Content Unbundler to generate zip file

When the extension project is built, the **Content Unbundler** tool generates a folder and a zip file that are named the same as the extension version. The folder contains all content required to serve the extension.

You can override any of the default configuration parameters for the build environment.

* **ContentUnbundlerSourceDirectory**: This contains the path of the build output directory that contains the `web.config` file and the /bin directory. The default value is `$(OutputPath)`.

* **ContentUnbundlerOutputDirectory**: This contains the path of the output directory in which the **Content Unbundler** will place the unbundled content.  It will create a folder named `HostingSvc`. The default value is `$(OutputPath)`.

* **ContentUnbundlerRunAfterTargets**: This is used to sequence when the RunContentUnbundler target will run.  The value of this property is used to set the `AfterTargets` property of the RunContentUnbundler.  The default value is `AfterBuild`. 

* **ContentUnbundlerExtensionRoutePrefix**: This contains the prefix name of the extension that is supplied as part of onboarding to the extension host. This will also be used in creating the extension host name. For example, if the `ContentUnbundlerExtensionRoutePrefix` is set to "myextension", then the host name will be `myextension.hosting.portal.azure.net`.

* **ContentUnbundlerZipOutput**: Zips the unbundled output that can be used for deployment. A value of `true` zips the output, whereas a value of `false`  does not create a .zip file. Defaults to `false`.   

The following examples are customized configuration files.

* CoreXT extension configuration

    The following example is the customized configuration for a **CoreXT**  extension named "scheduler". 

```xml
<PropertyGroup>
    <ContentUnbundlerSourceDirectory>$(WebProjectOutputDir.Trim('\'))</ContentUnbundlerSourceDirectory>
    <ContentUnbundlerOutputDirectory>$(BinariesBuildTypeArchDirectory)\HostingSvc</ContentUnbundlerOutputDirectory>
    <ContentUnbundlerExtensionRoutePrefix>scheduler</ContentUnbundlerExtensionRoutePrefix>
    <ContentUnbundlerZipOutput>true</ContentUnbundlerZipOutput>
</PropertyGroup>
```

* Non-CoreXT extension configuration

    Outside of CoreXT, the default settings in the `targets` file should work for most cases. The only property that needs to be overridden is **ContentUnbundlerExtensionRoutePrefix**, as in the following example.

```xml
<PropertyGroup>
    <ContentUnbundlerExtensionRoutePrefix>scheduler</ContentUnbundlerExtensionRoutePrefix>
</PropertyGroup>
```

#### Upload safe deployment config 

<!-- TODO:  Determine all of the contents of the storage account.  Also determine where else the zip file is discussed. -->
<!-- Then remove the following sentence: 
In addition to the zip files, the hosting service expects a config file to be located in the storage account. 
-->

Safe deployment practices require that extensions are rolled out to all data centers in a staged manner. The out-of-the-box hosting service provides the capability to deploy an extension in five stages, where each stage corresponds to one of five locations, or data centers.  The stages are as follows.

1. **stage1**: "centraluseuap"
1. **stage2**: "westcentralus"
1. **stage3**: "southcentralus"
1. **stage4**: "westus"
1. **stage5**: "*"

<!-- TODO:  Determine whether an extension can use the "stageDefinition" and "$sequence" parameters, or if they are reserved for hosting service use -->

When a user requests an extension in the Azure Portal, the Portal will determine which version to load, based on the datacenter that is nearest to the user's geographical location.

The config file specifies the versions of the extension that the hosting service will download, process and serve. It is authored by the developer as part of creating the extension.  The config file is located in the storage account, and its name is  `config.json`.  The file name is case sensitive, as are the names of the properties that it contains, as in the following example.

```json
{
    "$version": "3",
    "stage1": "1.0.0.5",
    "stage2": "1.0.0.4",
    "stage3": "1.0.0.3",
    "stage4": "1.0.0.2",
    "stage5": "1.0.0.1",
    "<friendlyName>": "2.0.0.0"
}
```

**$version**:  Required attribute. This is the version of the current `config.json` schema. The hosting service requires extension developers to use the latest version, which is 3.

**stage(1-5)**: Required attributes. A valid version number for the extension.  The version number is associated with the datacenter that has the same stage number.

* In this example, based on the preceding `config.json` file, if a user in the Central US region requests to load `Microsoft_Azure_<extensionName>`, then the hosting service will load the stage 1 version for the user, which is version 1.0.0.5. However, if a user in Singapore loads the extension, then the hosting service will load the stage 5 version, which is 1.0.0.1.

**friendlyName**: Optional. A unique name, without the angle brackets, that is assigned to a specific build version for sideloading. There is no limit to the number of friendly names can be provided by the developer for development and testing.

<!-- TODO: are friendly names separated by commas? -->
For more information about testing extensions with stages in configuration files, see [portalfx-extensions-hosting-service-scenarios.md#deploying-a-new-version-to-a-stage](portalfx-extensions-hosting-service-scenarios.md#deploying-a-new-version-to-a-stage).

#### Register the extension

<!-- TODO:  determine how to make a public endpoint in order to copy the build files to it. -->

Extensions should publish the extracted deployment artifacts that are generated during the build to a public endpoint. This means copying the zip files for the build, along with the `config.json` file, to a directory that is located on the endpoint.

1. The developer should have access to two public endpoints, one for the Dogfood environment and one for the production environment.  An example of a Dogfood environment endpoint is `https://mybizaextensiondf.blob.core.windows.net/<extensionName>`.  An example of a PROD environment endpoint is `https://mybizaextensionprod.blob.core.windows.net/<extensionName>`.

1. Make sure that all the zip files and the `config.json` file are in the same directory or are at the same level previous to copying the extension to the endpoints.

1. After these files are available on a public endpoint, file a request to register the public endpoint.  The link is located at   [https://aka.ms/extension-hosting-service/onboarding](https://aka.ms/extension-hosting-service/onboarding). To onboard the extension, please provide following information in the request. 

    * **Extension Name**: The name of the extension, as specified in the  `extension.pdl` file.

    * **Dogfood storage account**:  The public read-only endpoint that serves zip files for the Dogfood environment.

    * **Prod storage account**: The public read-only endpoint that serves zip files for the production environment.


#### Converting from custom  deployment to a hosting service

To minimize the probability of regression, use the following procedure to migrate an extension from custom  deployment to a hosting service. For more information about custom deployment, see [top-extensions-custom-deployment.md](top-extensions-custom-deployment.md).


1. Change the uri format to use a hosting service in the PROD environment

   An example of a pull request for modifying the `uriFormat` parameter is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/c22b81463cab1d0c6b2c1abc803bc25fb2836aad?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/c22b81463cab1d0c6b2c1abc803bc25fb2836aad?refName=refs%2Fheads%2Fdev).

1. Flight changes in MPAC

    An example of a pull request for a flighting extension in MPAC is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev).

1. Enable 100% traffic in MPAC and PROD
  
    An example of a pull request that enables 100% traffic without flighting for `MicrosoftAzureClassicStorageExtension`, and 100% traffic with flighting for `Microsoft_Azure_Storage` is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/b81b415411f54ad83f93d43d37bcad097949a4e3?refName=refs%2Fheads%2Fdev&discussionId=-1&_a=summary&fullScreen=false](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/b81b415411f54ad83f93d43d37bcad097949a4e3?refName=refs%2Fheads%2Fdev&discussionId=-1&_a=summary&fullScreen=false). 

1. Enable flighting in MPAC

    The Azure Portal provides the ability to flight the MPAC customers to multiple editions of an extension. Traffic will be equally distributed between all registered configurations, or stamps.  An example of a pull request is located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/commit/be95cabcf7098c45927e3bb7aff9b5e0f65de341?refName=refs%2Fheads%2Fdev).
        
    * Hosting service `extension.pdl` file

        To flight traffic to multiple stamps, register other stamps in `flightUri`. For example, the friendly name `MPACFlight` is used to flight traffic to another edition of an extension, as in the following example.

        ``` 
        { 
        name: "Microsoft_Azure_Demo", 
        uri: "//demo.hosting.portal.azure.net/demo", 
        uriFormat: "//demo.hosting.portal.azure.net/demo/{0}", 
        feedbackEmail: "azureux-demo@microsoft.com", 
        flightUris: [
            "//demo.hosting.portal.azure.net/demo/MPACFlight",
        ],
        }
        ```
    * Legacy deployment `extension.pdl` file

        Custom deployment can also flight traffic to multiple extension editions, as in the following example.

        ``` 
        {
            name: "Microsoft_Azure_Demo",
            uri: "//main.demo.ext.azure.com",
            uriFormat: "//{0}.demo.ext.azure.com",
            feedbackEmail: "azureux-demo@microsoft.com",
            flightUris: [
                "//flight.demo.ext.azure.com",
            ],
        }
        ``` 

## Advanced Topics

**NOTE**: This section of the document assumes that the reader has reviewed the hosting service document located at [top-extensions-hosting-service.md#procedures](top-extensions-hosting-service.md#procedures). 

**NOTE**: This section is only relevant to extension developers who are using [WARM](portalfx-extensions-hosting-service-glossary.md) and [EV2](portalfx-extensions-hosting-service-glossary.md) for deployment, or who plan to migrate to WARM and EV2 for deployment.

### EV2 Integration with hosting service

If you are not familiar with WARM and EV2, it is recommended that you read the documentation provided by their teams. If you have any questions about these systems please reach out to the respective teams.

* Onboard WARM: [https://aka.ms/warm](https://aka.ms/warm)
* Onboard Express V2: [https://aka.ms/ev2](https://aka.ms/ev2)

Deploying an extension with hosting requires extension developers to upload the zip file that was generated during the build to a  storage account that is read-only to the public.

Since EV2 does not provide an API to upload the zip file, setting up the deployment infrastructure can become an unmanageable task. The deployment process is simplified  by leveraging the EV2 extension that was developed by the Ibiza team. The EV2 extension allows the upload of the zip file to a storage account in a way that is compliant.

#### Configuring ContentUnbundler for Ev2-based deployments

As of SDK version 5.0.302.817, extension developers can leverage the EV2 mode in **Content Unbundler** to generate the rollout spec, service model schema, and parameter files for EV2 deployment.

**Basic Scenario**:

In the most common scenario, extension developers can execute **ContentUnbundler** in EV2 mode. This will generate the rollout spec, service model schema and parameter files. The procedure is as follows. 

1.  Specify the `ContentUnbundlerMode` as ExportEv2. This attribute is provided in addition to other properties.

    The following is the `csproj` configuration for the Monitoring Extension in the **CoreXT** environment.

    ```xml
    <!-- ContentUnbundler parameters -->
    <PropertyGroup>
        <ForceUnbundler>true</ForceUnbundler>
        <ContentUnbundlerExe>$(PkgMicrosoft_Portal_Tools_ContentUnbundler)\build\ContentUnbundler.exe</ContentUnbundlerExe>
        <ContentUnbundlerSourceDirectory>$(WebProjectOutputDir.Trim('\'))</ContentUnbundlerSourceDirectory>
        <ContentUnbundlerOutputDirectory>$(BinariesBuildTypeArchDirectory)\ServiceGroupRoot</ContentUnbundlerOutputDirectory>s
        <ContentUnbundlerExtensionRoutePrefix>monitoring</ContentUnbundlerExtensionRoutePrefix>
        <ContentUnbundlerMode>ExportEv2</ContentUnbundlerMode>
    </PropertyGroup>
    .
    .
    .
    .
    <Import Project="$(PkgMicrosoft_Portal_Tools_ContentUnbundler)\build\Microsoft.Portal.Tools.ContentUnbundler.targets" />
    ```
1. Add a `ServiceGroupRootReplacements.json` file.

    The `ServiceGroupRootReplacements.json` file contains the following parameters, among others:  `TargetContainerName`, `AzureSubscriptionId`, `CertKeyVaultUri`,`TargetStorageConStringKeyVaultUri` and the extension name. This will require you to set up a KeyVault for certificates and other items that are used for connectivity.

    <details>

    <summary>1. Set up KeyVault</summary>

     <!--TODO:  Determine who provides the storage account: the extension developer or the Azure Portal -->

      During deployment, the zip file from the official build will be copied to the storage account that was provided when onboarding to the hosting service.  To do this, Ev2 and the hosting service need two secrets:

      * The certificate that Ev2 will use to call the hosting service to initate a deployment.

        **NOTE**: Azure ignores this certificate but it is still required. The extension is validated based on an allowed list of storage accounts and the storage credential you supply by using the  `TargetStorageConStringKeyVaultUri` and `TargetContainerName` settings.

      * The connection string to the target storage account where the extension will be deployed. The format of the connection string is the default form `DefaultEndpointsProtocol=https;AccountName={0};AccountKey={1};EndpointSuffix={3}`, which is the format provided from portal.azure.com.
      
    </details>
    <details>
    <summary>2. Onboard to KeyVault</summary>

      The official guidance from Ev2 is located at  [https://aka.ms/portalfx/ev2keyvault](https://aka.ms/portalfx/ev2keyvault).  Follow the instructions to:

      1. Create a KeyVault. 
      1. Grant Ev2 read access to your KeyVault
      1. Create an Ev2 Certificate and add it to the KeyVault as a secret. In the following `csproj` config example, the name of the certificate in the KeyVault is `PortalHostingServiceDeploymentCertificate`.
      1. Create a KeyVault secret for the storage account connection string. Any configuration for prod environments is done via [jit](portalfx-extensions-hosting-service-glossary.md) access and on your [SAW](portalfx-extensions-hosting-service-glossary.md).

    </details>
    <details>
    <summary>3. Add the file to your project</summary>

      Add `ServiceGroupRootReplacements.json` to the extension `csproj`, as in the following example.

      ```xml
      <Content Include="ServiceGroupRootReplacements.json">
          <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
      </Content>
      ```
        
      The following file is an example of a `ServiceGroupRootReplacements.json` file.

      ```json
            {
            "production": {
                "AzureSubscriptionId": "<SubscriptionId>",
                "CertKeyVaultUri": "https://sometest.vault.azure.net/secrets/PortalHostingServiceDeploymentCertificate",
                "TargetStorageConStringKeyVaultUri": "https://sometest.vault.azure.net/secrets/PortalHostingServiceStorageConnectionString",
                "TargetContainerName": "hostingservice",
                "ContactEmail": "youremail@microsoft.com",
                "PortalExtensionName": "Microsoft_Azure_Monitoring",
                "FriendlyNames": [ "friendlyname_1", "friendlyname_2", "friendlyname_3" ]
            }
            }
      ```

      Other environments that are supported are the Dogfood test environment and the Production environment.
    </details>
   
1.  Initiate a test deployment


      You can quickly run a test deployment from a local build, previous to onboarding to WARM, by using the `New-AzureServiceRollout` commandlet.  Be sure that you are not testing in production, i.e, that the target storage account in the key vault that is being used is not the production storage account, and the **-RolloutInfra** switch is set to `Test`.  The following is an example.

      ``` PowerShell
        New-AzureServiceRollout -ServiceGroupRoot E:\dev\vso\AzureUX-PortalFX\out\ServiceGroupRoot -RolloutSpec E:\dev\vso\AzureUX-PortalFX\out\ServiceGroupRoot\RolloutSpec.24h.json -RolloutInfra Test -Verbose -WaitToComplete
    ```
      Replace \<RolloutSpec> with the path to `RolloutSpec.24h.json` in the build.


    **NOTE**: The Ev2 Json templates perform either a 24-hour or a 6-hour rollout to each stage within the hosting service's safe deployment stages. Currently, the gating health check endpoint returns `true` in all cases, so really the check only provides a time gated rollout.  This means that you need to validate the health of the deployment in each stage, or cancel the deployment using the `Stop-AzureServiceRollout` command if something goes wrong. Once a stop is executed, you need to rollback the content to the previous version using the `New-AzureServiceRollout` command.  This document will be updated once health check rules are defined and enforced.  If you would like to implement your own health check endpoint you can customize the Ev2 json specs found in the NuGet.



#### What output is generated?

The above configuration will result in a build output as required by Ev2 and the hosting service. The following examples are for different versions of the SDK.

* As of version 5.0.302.834

  ```
  out\retail-amd64\ServiceGroupRoot
                  \HostingSvc\1.2.1.0.zip
                  \Parameters\*.json
                  \buildver.txt
                  \RolloutSpec.6h.json
                  \RolloutSpec.24h.json
                  \production.ServiceModel.6h.json
                  \production.ServiceModel.24h.json
                  \production.friendlyname_1.json
                  \production.friendlyname_2.json
                  \production.friendlyname_3.json

  ```

* As of version 5.0.302.837


  ```
  out\retail-amd64\ServiceGroupRoot
                  \HostingSvc\1.2.1.0.zip
                  \Production.Parameters\*.json
                  \buildver.txt
                  \Production.RolloutSpec.6h.json
                  \Production.RolloutSpec.24h.json
                  \Production.ServiceModel.6h.json
                  \Production.ServiceModel.1D.json
                  \Production.friendlyname_1.json
                  \Production.friendlyname_2.json
                  \Production.friendlyname_3.json
  ```

#### Specify ContentUnbundler bake time

The **ContentUnbundler** EV2 template files that are shipped are now formatted to accept customized monitor durations, which is the time to wait between each stage of a deployment, also known as bake time. To accommodate this, the files have been renamed from:
`Blackforest.RolloutParameters.PT6H.json`
to:
`Blackforest.RolloutParameters.{MonitorDuration}.json`.

The monitor duration can be specified by updating the  `ServiceGroupRootReplacements.json` file to include a new array called "MonitorDuration", as in the following example.

  ```
  "Test": {
      "AzureSubscriptionId": "0531c8c8-df32-4254-a717-b6e983273e5f",
      "CertKeyVaultUri": "https://stzhao0resourcedf.vault.azure.net/secrets/PortalHostingServiceDeploymentCertificate",
      "TargetStorageConStringKeyVaultUri": "https://stzhao0resourcedf.vault.azure.net/secrets/PortalHostingServiceStorageConnectionString",
      "TargetContainerName": "hostingservicedf",
      "ContactEmail": "rowong@microsoft.com",
      "PortalExtensionName": "Microsoft_Azure_Resources",
      "FriendlyNames": [
        "friendlyname1"
      ],
      "MonitorDuration": [
          "PT1H",
          "PT30M"
      ]
  ```

If no monitor durations are specified, then the **ContentUnbundler** EV2 generation will default to 6 hours (PT6H) and 1 day (P1D).

#### Skipping safe deployment

**ContentUnbundler** EV2 templates now support generating deployment files that do not include a delay between stages.  This can be enabled by adding the key/value pair 
`"SkipSafeDeployment": "true" ` in the corresponding environment in the `ServiceGroupRootReplacements.json` file.  The following example adds the SkipSafeDeployment key/value pair to the extension named `Microsoft_MyExtension` in the **MOONCAKE** environment.

  ```
  "Mooncake": {
      "AzureSubscriptionId": "00000000-0000-0000-0000-000000000000",
      "certKeyVaultUri": "https://mykeyvault-.vault.azure.net/secrets/MyCertificate",
      "targetStorageConStringKeyVaultUri": "https://mykeyvault-df.vault.azure.net/secrets/MyConnectionString",
      "targetContainerName": "myService",
      "contactEmail": "myEmail@myCompany.com",
      "portalExtensionName": "Microsoft_MyExtension",
      "friendlyNames": [
        "Name1",
        "F2"
      ],
      "SkipSafeDeployment": "true"
    },
  ```

#### Friendly name removal

To remove a friendly name, just run an EV2 deployment with the `Rolloutspec.RemoveFriendlyName.<friendlyName>.json` file.

### WARM Integration with hosting service

  It is assumed that you have already onboarded to WARM if you will be deploying to production, or deploying by using the WARM UX. The production deployment instructions are  
  specified in the site located at  [https://aka.ms/portalfx/warmproduction](https://aka.ms/portalfx/warmproduction), and the WARM UX deployment instructions are specified in the site located at [https://warm/newrelease/ev2](https://warm/newrelease/ev2).  
  
  If you have not already onboarded to WARM, see the guidance from the Ev2 team that is located at [https://aka.ms/portalfx/warmonboarding](https://aka.ms/portalfx/warmonboarding). If you have questions, you can reach out to ev2sup@microsoft.com.

## Scenarios

{"gitdown": "include-file", "file": "../templates/portalfx-extensions-hosting-service-scenarios.md"}

{"gitdown": "include-file", "file": "../templates/portalfx-extensions-faq-hosting-service.md"}

<!--  required section -->
{"gitdown": "include-file", "file": "../templates/portalfx-extensions-glossary-hosting-service.md"}
