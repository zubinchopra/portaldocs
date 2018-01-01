
## Azure portal onboarding

### Prerequisites to Azure portal onboarding

Many extensions have been made more successful by setting up early design reviews with the Azure portal team. Taking the time to review the design gives extension owners an opportunity to understand how they can leverage Azure portal design patterns, and ensure that the desired outcome is feasible. When you are ready to build the extension, schedule a UX feasibility review with the Ibiza team UX contact by emailing the following contacts for "Onboarding and Extension Feasibility Review” in the subject line of the e-mail.

* For onboarding a **first-party extension** i.e. extension developed by Microsoft , please email with following information to: [Leon Welicki, Adam Abdelhamed, Amit Modi](mailto:ibiza-onboading-kick@microsoft.com?subject=Azure%20portal%20onboarding%20and%20Extension%20Feasibility%20Review)
    * Is your service targeting public Azure, on-prem, or both?
    * Service name
    * VP, PM, and engineering owners
    * Timelines (preview, GA)
    * Summary of the service and target scenarios

* For onboarding a **third-party extension** i.e. extension developed by partners outside Microsoft , please email with following information to: [Leon Welicki, Adam Abdelhamed](mailto:ibiza-onboading-kick@microsoft.com?subject=Azure%20portal%20onboarding%20and%20Extension%20Feasibility%20Review)
    * Is your service targeting public Azure, on-prem, or both?
    * Service name
    * Summary of the service and target scenarios

### Join DLs and request permissions 

Request the following permissions to stay current on product roadmaps, get news on latest features, and read workshop announcements.

* PMs and Developer Leads need to join the  ```ibizapartners PM```  group by clicking on this link: [http://igroup/join/ibizapartners-pm](http://igroup/join/ibizapartners-pm). 

* Developers should join the  ```ibizapartners DEV ``` group by clicking on this  link:  [http://igroup/join/ibizapartners-dev](http://igroup/join/ibizapartners-dev). 

* Developers should join the  ```Azure Portal Core Team - 15003(15003)``` group by using this link: [http://ramweb](http://ramweb).

* PMs, Developers, and Developer Leads should receive notifications on breaking changes by joining the ```ibizabreak ``` group at  this  link:  [http://igroup/join/ibizabreak](http://igroup/join/ibizabreak).

* PMs, Developers, and Developer Leads  should join Stackoverflow Forums that are located at [https://stackoverflow.microsoft.com](https://stackoverflow.microsoft.com)  to ask any questions. Azure portal strives to answer the questions within 24 hours for the tags listed on [portalfx-extensions-stackoverflow.md](portalfx-extensions-stackoverflow.md)

* Developers who want to contribute to the Azure documentation or test framework should join groups from the site located at [http://aka.ms/azuregithub](http://aka.ms/azuregithub).

### 3 Developments phases of Azure portal extensions

Onboarding a service on Azure portal has three phases: private preview, public preview, and Global Availability (GA).

#### Private Preview

This section of the document assumes that you have completed the prerequisites for Azure portal onboarding.

A new extension is [registered in hidden (or disabled state)](portalfx-how-to-register-extension.md) in Azure portal. In the hidden state, extension is not visible to the customers of Azure portal. 
 
Azure portal allows loading hidden extensions for a particular session for following scenarios:

1. [Loading a hidden extension for Development and Testing](portalfx-loading-hidden-extension.md)
1. [Providing access to limited set of customers for feedback](portalfx-hidden-extension-feedback.md)

#### Public Preview

This section assumes that you have leveraged the private preview phase of your extension development to validate the business model of your service and to test your extension. 

**NOTE**:
 If you choose to enable Public preview for your extension then you need to be aware of [customer experience metrics](portalfx-customer-experience-metrics.md) that are tracked for your extension. These customer experience metrics are tracked by Azure portal team and are reported to the VP sponsoring your extension through a weekly status email. Also, these metrics are reported as part of weekly S360 meeting, an executive review meeting. Any extension that does not meet the criteria listed in customer experience metrics is required to justify to the executives the reason for poor customer experience.

Enabling your [extension for public preview](portalfx-public-preview.md) will make your extension visible to all the customers in Azure portal along with a preview tag assosciated with it.

In the following image, the icon to the right of the extension indicates that the extension is in the public preview state.

![alt-text](../media/portalfx-extensions/previewMode.png "Public Preview")

#### Global Availability

This section assumes that 
1. You have leveraged the private preview phase of your extension development to validate the business model of your service and to test your extension. 
2. Your extension meets the criteria for all [customer experience metrics](portalfx-customer-experience-metrics.md)

Enabling your [extension for public preview](portalfx-global-availability.md) will make your extension visible to all the customers in Azure portal **without** a preview tag assosciated with it.

![alt-text](../media/portalfx-extensions/GAMode.png "Global Availability")