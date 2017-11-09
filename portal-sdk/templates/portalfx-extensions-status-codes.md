<a name="portalfxExtensionsStatusCodes"></a>

<!-- link to this document is [portalfx-extensions-status-codes.md]()
-->

## Status Codes and Error Messages
Status codes or error messages that are encountered while developing an extension may be dependent on the type of extension that is being created, or the development phase in which the message is encountered.

* <a name="insecureResponse">ERR_INSECURE_RESPONSE in the browser console</a>

    My Extension fails to side load and I get an ERR_INSECURE_RESPONSE in the browser console.

    ![alt-text](../media/portalfx-testinprod/errinsecureresponse.png "ERR_INSECURE_RESPONSE Log")
    ERROR: the browser is trying to load the extension but the SSL certificate from localhost is not trusted.

    SOLUTION: Install and trust the certificate.
 * * *



