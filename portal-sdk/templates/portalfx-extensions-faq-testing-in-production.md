
<a name="portalfxExtensionsFaqTestingInProduction"></a>
<!-- link to this document is [portalfx-extensions-faq-testing-in-production.md]()
-->

## Portal Extension Testing in Production FAQs 

<!-- If there are other FAQ documents that are relevant to testing in production, include links  to them here. Otherwise, remove this section. -->

If there are enough FAQ's on the same subject, like side-loading, they have been grouped together in this document.
Otherwise, they are listed in the order that they were encountered.

* <a name=" ">Where are the FAQs for    ?</a>

    The FAQ  for    is located at []().

    * * *

* I get an error 'Security of a sandboxed iframe is potentially compromised by allowing script and same origin access'. 
 
    The Azure Portal should frame your extension URL, as specified in [portalfx-extensions-developerInit-extension.md](portalfx-extensions-developerInit-extension.md) and 
    [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).


* Cannot load `localhost` Ibiza extension with ERR_CONNECTION_RESET

    [https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595](https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595)

### Side-Loading Errors

* My Extension fails to side load and I get an ERR_INSECURE_RESPONSE message in the browser console.

    [portalfx-extensions-status-codes.md#insecureResponse](portalfx-extensions-status-codes.md#insecureResponse)


* Ibiza sideloading in Chrome fails to load parts
    
    Enable the `allow-insecure-localhost` flag, as specified in [https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts](https://stackoverflow.microsoft.com/questions/45109/ibiza-sideloading-in-chrome-fails-to-load-parts)

* Trouble side-loading gallery packages 
    [https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages](https://stackoverflow.microsoft.com/questions/12136/trouble-side-loading-gallery-packages)

* Side-loading friendly names is not working in the Dogfood environment
    [https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood](https://stackoverflow.microsoft.com/questions/64951/extension-hosting-service-side-loading-friendlynames-not-working-in-dogfood)