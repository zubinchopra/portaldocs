## Introduction 

It is important to read this guide carefully, as we rely on you to manage the extension registration / configuration management process  in the Portal repository. External partners should also read this guide to understand the capabilities that Portal can provide for  extensions by using configuration. However, external partner requests should be submitted by sending an email to ```ibizafxpm@microsoft.com ``` instead of using the internal sites that are in this document. 

The subject of the email should contain the following.

``` <Onboarding Request ID> Add <extensionName> extension to the Portal  ```

where 

**Onboarding Request**: the unique identifier for the request, without the angle brackets

**extensionName**: the name of the extension

 The body of the email should contain the following information.

```json
Extension name: <Company>_<BrandOrSuite>_<ProductOrComponent>  
URLs:  (must adhere to pattern)
PROD:  main.<extensionName>.ext.contoso.com
Contact info:_________
Business Contacts:_________
Dev leads: _________
PROD on-call email: _________
```

The email may also contain the extension config file, as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

