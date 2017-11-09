
<a name="portalfxExtensionsHostingServiceOverview"></a>
<!-- link to this document is [pportalfx-extensions-hosting-service-overview.md]()
-->

## Overview
The hosting service is 

## Reasons for using the Hosting Service
Some reasons for using the Hosting Service are as follows:
<details>
<summary>Simple Deployments and hosting out of the box </summary>
    
   * Use Safe Deployment practices

   * Distributes the extension to all data centers in various geographical locations

   * CDN configured

   * Use portal's MDS so no need to onboard to MDS

   * Use optimizations like persistent caching, index page caching, manifest caching and others 

</details>
<details>
<summary>Enhanced Monitoring </summary>

* Removes need for on-call rotation for hosting specific issues because the portal is now hosting. On-call is still required for dev code live site issues

* Hosting service provides full visibility into the health and activity for your extension
</details>
<details>
<summary>Reduced COGS</summary>

*  No hosting COGS
*  Reduced development costs allow the team to focus on building the domain specifics of the
</details>

## Hosting service and Server-Side Code
Extensions that have server-side code or controllers can use hosting services.  In fact, you can supplement your legacy DIY deployment infrastructure to use a hosting service, and deploy your extension in a way that complies with  safe-deployment practices. 
1.	In most cases controllers are legacy, and it is easy to get rid of controllers. One advantage of getting rid of controllers is that all your clients, such as Ibiza and powershell, will now have a consistent experience. In order to get rid of controllers, you can use either of the following  approaches.
    *	If the functionality is already available from another service
    *	By hosting server-side code within an existing RP
1.	If getting rid of controllers is not a short term task, you can deploy the extension  through a hosting service by modifying the relative controller URLs.  They are located in  client code, and can be changed to specify absolute URLS. 
The following is a sample pull-request for a cloud services extension: [https://msazure.visualstudio.com/One/_git/AzureUX-CloudServices/commit/ac183c0ec197de7c7fd3e1eee1f7b41eb5f2dc8b](com/One/_git/AzureUX-CloudServices/commit/ac183c0ec197de7c7fd3e1eee1f7b41eb5f2dc8b).
    
    When this code change is posted, you can deploy the extension as a server-only service that will be behind `Traffic Manager`.
 
 ## How To Deploy Extensions using Hosting Service 
1.	You integrate content unbundler, a tool shipped with with Azure Portal SDK, as part of your build. 
<!-- TODO:  if framework ships separately, where would it be located? -->
1.  Use the content unbundler tool to generates a zip that has all the static files in your extension.
1.	Upload the zip file to a public read-only storage account owned by your team.
1.	Hosting service polls the storage account, detects the new version and downloads the zip file in each data center within 5 minutes 
1.  Hosting service  starts serving the new version to customers around the world.

 ## Prerequisites for onboarding hosting service
1.  For all extensions
    * SDK Version 

        To generate the zip file during build process from your extension, use Portal SDK 5.0.302.454 or above
    
        NOTE: If your team plans to use EV2 for uploading zip file to storage account, we recommend using Portal SDK 5.0.302.817 or above. We have recently added some new features that make it easier to use EV2 with hosting service.

    * Build Output Format
        *	Verify build output directory is called bin
        * 	Verify you can point IIS to bin directory and load extension

1. For extensions with controllers or server-side code

    Modify the relative controller URLs to absolute URLS. The Controllers will deploy a new server-only service that will be behind Traffic Manager.

Since this process is typically same across all extension you can leverage the pull-request for cloud services extension : https://msazure.visualstudio.com/One/_git/AzureUX-CloudServices/commit/ac183c0ec197de7c7fd3e1eee1f7b41eb5f2dc8b
