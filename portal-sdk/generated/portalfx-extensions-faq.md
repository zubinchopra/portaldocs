
<a name="azure-portal-frequently-asked-questions"></a>
# Azure Portal Frequently Asked Questions

This section contains all Azure Portal FAQ's.


<!-- TODO:  FAQ Format in the individual docs  is ###Link, ***title***, Description, Solution, 3 Asterisks -->


<!--
<a name="azure-portal-frequently-asked-questions-debugging-extensions"></a>
## Debugging Extensions

FAQ's that are associated with ordinary extension testing.

"gitdown": "include-file", "file": "../templates/portalfx-extensions-faq-debugging.md"
-->

<a name="azure-portal-frequently-asked-questions-extension-configurations"></a>
## Extension Configurations

FAQ's that are associated with configurations for extensions.

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions"></a>
## Frequently asked questions

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions-ssl-certs"></a>
### SSL certs

***How do I use SSL certs?***

[portalfx-extensions-faq-onboarding.md#sslCerts](portalfx-extensions-faq-onboarding.md#sslCerts)

* * *

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions-loading-different-versions-of-an-extension"></a>
### Loading different versions of an extension

***How do I load different versions of an extension?***

Understanding which extension configuration to modify is located at [portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify](portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify).


<a name="azure-portal-frequently-asked-questions-extensions-onboarding"></a>
## Extensions Onboarding

FAQ's for developers that are new to the Azure Portal Extension development process.

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions"></a>
## Frequently asked questions

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions-onboarding-faq"></a>
### Onboarding FAQ

***Where are the onboarding FAQs for Sparta (ARM/CSM-RP)?***

The SharePoint Sparta Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx).

* * *
<a name="azure-portal-frequently-asked-questions-frequently-asked-questions-ssl-certs"></a>
### SSL Certs

***How do I use SSL certs?***
 
 SSL Certs are relevant only for teams that host their own extensions.  Azure portal ONLY supports loading extensions from HTTPS URLs. Use a wildcard SSL cert for each environment to simplify maintenance, for example,   ``` *.<extensionName>.onecloud-ext.azure-test.net  ``` or  ``` *.<extensionName>.ext.azure.com) ``` .    To simplify overall management when your team is building separate, independent extensions, you can also use  ``` <extensionName>.<team>.ext.azure.com ``` and create a wildcard SSL cert for  ``` *.<team>.ext.azure.com ```. Internal teams can create SSL certs for the DogFood environment using the SSL Administration Web page that is located at [http://ssladmin](http://ssladmin). 
 
  Production certs must follow your organization’s PROD cert process. 

 **NOTE** Do not use the SSL Admin site for production certs.
 * * *

<a name="azure-portal-frequently-asked-questions-testing-in-production"></a>
## Testing in Production

FAQ's that are associated with testing an extension in the production environment.

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions"></a>
## Frequently asked questions

If there are enough FAQ's on the same subject, like sideloading, they have been grouped together in this document. Otherwise, FAQ's are listed in the order that they were encountered. Items that are specifically status codes or error messages can be located in [portalfx-extensions-status-codes.md](portalfx-extensions-status-codes.md).

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions-faqs-for-debugging-extensions"></a>
### FAQs for Debugging Extensions

***Where are the FAQ's for normal debugging?***

The FAQs for debugging extensions is located at [portalfx-extensions-faq-debugging.md](portalfx-extensions-faq-debugging.md).

* * *

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions-sideloading-in-chrome"></a>
### Sideloading in Chrome

***Ibiza sideloading in Chrome fails to load parts***
    
Enable the `allow-insecure-localhost` flag, as described in [https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts](https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts)

* * *

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions-sideloading-in-chrome-sideloading-gallery-packages"></a>
#### Sideloading gallery packages

***Trouble sideloading gallery packages***

SOLUTION:  Some troubleshooting steps are located at [https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages](https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages)

* * *

<a name="azure-portal-frequently-asked-questions-frequently-asked-questions-sideloading-in-chrome-sideloading-friendly-names"></a>
#### Sideloading friendly names

***Sideloading friendly names is not working in the Dogfood environment***

In order for portal to load  a test version of an extension, i.e., load without using the PROD stamp, developers can append the feature flag `feature.canmodifystamps`. The following example uses the sideload url to load the "test" version of extension.

`https://portal.azure.com?feature.canmodifystamps=true&<extensionName>=test`

The parameter `feature.canmodifystamps=true` is required for side-loading, and 
 **extensionName**, without the angle brackets, is replaced with the unique name of extension as defined in the `extension.pdl` file. For more information, see [https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood](https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood).

* * *

<!--
<a name="azure-portal-frequently-asked-questions-hosting-service"></a>
## Hosting Service

"gitdown": "include-file", "file": "../templates/portalfx-extensions-faq-hosting-service.md"
-->
