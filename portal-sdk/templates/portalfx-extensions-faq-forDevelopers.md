
<a name="portalfxExtensionsFaqForDevelopers"></a>
<!-- link to this document is [portalfx-extensions-faq-forDevelopers.md]()
-->

## Portal Extension FAQs for Developers

<a name="onboardingFAQ">Where are the onboarding FAQs?</a>

The Onboarding FAQ is located at [http://sharepoint/sites/AzureUX/Sparta/SpartaWiki/Sparta%20Onboarding%20FAQ.aspx]().

* * *
<a name="sslCerts">How do I use SSL certs?</a>

 Use a wildcard SSL cert for each environment to simplify maintenance, for example,   ``` *.{extension}.onecloud-ext.azure-test.net  ``` or  ``` *.{extension}.ext.azure.com) ``` .    To simplify overall management when your team is building separate, independent extensions, you can also use  ``` {extension}.{team}.ext.azure.com ``` and create a wildcard SSL cert for  ``` *.{team}.ext.azure.com ```. Internal teams can create SSL certs for DogFood using the SSL Administration Web page that is located at [http://ssladmin](). 
    
 Production certs must follow your organization’s PROD cert process. 

 NOTE: Do not use the SSL Admin site for production certs.
 * * *

