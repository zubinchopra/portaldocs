## Portal Extension FAQs for Developers

### Onboarding FAQ

***Where are the onboarding FAQs?***

The Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx](http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx).

* * *
### SSL Certs

***How do I use SSL certs?***

 Use a wildcard SSL cert for each environment to simplify maintenance, for example,   ``` *.<extensionName>.onecloud-ext.azure-test.net  ``` or  ``` *.<extensionName>.ext.azure.com) ``` .    To simplify overall management when your team is building separate, independent extensions, you can also use  ``` <extensionName>.<team>.ext.azure.com ``` and create a wildcard SSL cert for  ``` *.<team>.ext.azure.com ```. Internal teams can create SSL certs for the DogFood environment using the SSL Administration Web page that is located at [http://ssladmin](). 
    
 Production certs must follow your organization’s PROD cert process. 

 **NOTE** Do not use the SSL Admin site for production certs.
 * * *

