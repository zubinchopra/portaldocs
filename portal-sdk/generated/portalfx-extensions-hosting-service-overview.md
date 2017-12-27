<a name="overview"></a>
## Overview

A hosting service can make your web sites accessible through the World Wide Web by providing server space, Internet connectivity and data center security.

Teams that deploy UI for extensions with the classic cloud service model typically have to invest significant amounts of time to onboard to [MDS](portalfx-extensions-hosting-service-glossary.md), setup compliant deployments across all data centers, and configure [cdn](portalfx-extensions-hosting-service-glossary.md), storage and caching optimizations for each extension.

The cost of setting up and maintaining this infrastructure can be high. By leveraging the extension hosting service, developers can deploy extensions in all data centers without resource-heavy investments in the Web infrastructure.

You can ask questions on Stackoverflow with the tags [ibiza-deployment](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment) and [ibiza-hosting-service](https://stackoverflow.microsoft.com/questions/tagged/ibiza-hosting-service).

<a name="reasons-for-using-the-hosting-service"></a>
## Reasons for using the hosting service

More than 50% of the extensions have been migrated from legacy DIY deployment to extension hosting services. Some reasons for using the hosting service are as follows.
<details>
<summary>Simple deployments and hosting out of the box </summary>
    
   * Use safe deployment practices

   * Distribute the extension to all data centers in various geographical locations

   * CDN configured

   * Use the portal's MDS so there is no need to onboard to MDS

   * Use optimizations like persistent caching, index page caching, manifest caching and others 

</details>
<details>
<summary>Enhanced monitoring </summary>

* Removes the need for on-call rotation for hosting specific issues because the portal is now hosting. On-call support is still required for dev code live site issues

* Provides full visibility into the health and activity for an extension
</details>
<details>
<summary>Reduced COGS</summary>

*  No hosting [COGS](portalfx-extensions-hosting-service-glossary.md)
*  Reduced development costs allow teams to focus on building the domain specific portions of the extension, instead of allocating resources to configuring deployment
</details>

<a name="hosting-services-and-server-side-code"></a>
## Hosting services and server-side code
Extensions that have server-side code or controllers can use hosting services.  In fact, you can supplement a legacy DIY deployment infrastructure to use a hosting service, and deploy extensions in a way that complies with safe-deployment practices. 
1.	In most cases, UI controllers or MVC controllers are legacy, and it is easy to obsolete these controllers. One advantage of replacing obsolete UI controllers is that all client applications, such as **Ibiza** and **PowerShell**, will have a consistent experience. You can replace UI controllers under the following conditions.
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

 ## Prerequisites for onboarding hosting service

The **Visual Studio** project that is associated with developing the extension contains several files that will be updated or overridden while getting the extension ready for the hosting service. This topic discusses the files to create or change to meet requirements for the onboarding process. This procedure uses the **Content Unbundler** tool that was installed with the **nuGet** packages in Visual Studio.  For more information, see [portalfx-extensions-developerInit-procedure.md#create-a-blank-extension](portalfx-extensions-developerInit-procedure.md#create-a-blank-extension) and [portalfx-extensions-onboarding-nuget.md](portalfx-extensions-onboarding-nuget.md).



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

 
 ## How to deploy extensions using the hosting service 
 
1.	Integrate **Content Unbundler**, a tool shipped with with Azure Portal SDK, as part of the  build. For more information, see [portalfx-extensions-developerInit-procedure.md#create-a-blank-extension](portalfx-extensions-developerInit-procedure.md#create-a-blank-extension).
1.  Use the **Content Unbundler** tool to generate a zip file that contains all the static files in the extension.
1.	Upload the zip file to a public read-only storage account that is owned by your team.
1.	The hosting service will poll the storage account, detect the new version and download the zip file in each data center within 5 minutes.
1.  The hosting service starts serving the new version to customers around the world.

<a name="hosting-services-and-server-side-code-monitoring-and-logging"></a>
### Monitoring and Logging
<details>
<summary>Logging</summary>

  The portal provides a way for extensions to log to MDS using a feature that can be enabled in the extension. The logs generated by the extension when this feature is enabled are located in tables in the portal's MDS account. For more information about the portal logging feature, see  [portalfx-telemetry.md#logging](portalfx-telemetry.md#logging).


</details>
<details>
<summary>Trace Events</summary>

Trace events are stored in a **Kusto** database, and can be analyzed with the Kusto.WebExplorer tool. The following link contains a query that specifies which trace events to consider for analysis.
[https://ailoganalyticsportal-privatecluster.cloudapp.net/clusters/Azportal/databases/AzurePortal?query=ExtEvents%7Cwhere+PreciseTimeStamp%3Eago(10m)](https://ailoganalyticsportal-privatecluster.cloudapp.net/clusters/Azportal/databases/AzurePortal?query=ExtEvents%7Cwhere+PreciseTimeStamp%3Eago(10m))

The following image contains a list of tables that are a part of the Kusto database schema. It also displays the columns from the `ExtEvents` table that was used in the previous query.

 ![alt-text](../media/portalfx-extensions-hosting-service/KustoWebExplorerQuery.png  "Trace Event Parameters")

For more information about Kusto WebExplorer and associated functions, see [https://kusto.azurewebsites.net/docs/queryLanguage/query_language_syntax.html?q=cross](https://kusto.azurewebsites.net/docs/queryLanguage/query_language_syntax.html?q=cross). For questions to the developer community, use the  Stackoverflow tag [ibiza-deployment](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment) and [ibiza-hosting-service](https://stackoverflow.microsoft.com/questions/tagged/ibiza-hosting-service).

</details>
<details>
<summary>Telemetry Events</summary>

Telemetry events are stored in the **Kusto** database in the `ExtTelemetry` table.  To  review telemetry events, use the following query against the Kusto.WebExplorer site.

[https://ailoganalyticsportal-privatecluster.cloudapp.net/clusters/Azportal/databases/AzurePortal?query=ExtTelemetry%7Cwhere+PreciseTimeStamp%3Eago(10m)](https://ailoganalyticsportal-privatecluster.cloudapp.net/clusters/Azportal/databases/AzurePortal?query=ExtTelemetry%7Cwhere+PreciseTimeStamp%3Eago(10m))

</details>
<details>
<summary>Monitoring</summary>

 There are two categories of issues that are monitored for each extension.

1.  Portal loading and running the extension

    The portal has alerts that notify extensions when they fail to load for any reason. Issues like blade load failures and part load failures are also monitored.

    <!-- TODO: Determine whether the work that needed to be done to monitor blade load failures and part load failures has been done. -->
    <!-- TODO: Determine whether it is the extension that is notified, or the partner that is notified. -->

1. Hosting Service downloading and servicing the extension

    The hosting service pings the endpoint that contains the extension bits once every minute. It will then download any new configurations and versions it finds. If it fails to download or process the downloaded files, it logs these as errors in its own MDS tables.

    Alerts and monitors have been developed for any issues. The Ibiza team receives notifications if any errors or warnings are generated by the hosting service. 
    You can access the logs of the hosting service at the following location. 
    https://jarvis-west.dc.ad.msft.net/53731DA4.

  </details>
