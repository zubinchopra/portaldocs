## Status Codes and Error Messages
Status codes or error messages that are encountered while developing an extension may be dependent on the type of extension that is being created, or the development phase in which the message is encountered.

### ERR_INSECURE_RESPONSE

ERR_INSECURE_RESPONSE in the browser console

My Extension fails to side load and I get an ERR_INSECURE_RESPONSE in the browser console.

![alt-text](../media/portalfx-testinprod/errinsecureresponse.png "ERR_INSECURE_RESPONSE Log")

ERROR: the browser is trying to load the extension but the SSL certificate from localhost is not trusted.

SOLUTION: Install and trust the certificate.

* * *

###  ERR_CONNECTION_RESET

***Cannot load `localhost` Ibiza extension with ERR_CONNECTION_RESET***

ERROR: The SAN is missing in the certificate.

SOLUTION: [https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595](https://stackoverflow.microsoft.com/questions/48581/cannot-load-localhost-ibiza-extension-with-err-connection-reset/49595#49595)

* * *
