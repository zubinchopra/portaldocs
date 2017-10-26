<a name="portalfxExtensionsConfiguration-intro.md"></a>
<!-- link to this document is [portalfx-extensions-configuration-intro.md]()
-->

## Introduction 

It is important you read this guide carefully, as we rely on you to manage your extension registration / configuration management in the portal repository. External partners should also read this guide to understand the capabilities that Portal can provide for your extension through configuration. However, external partner requests should be submitted by sending emails instead of using the internal sites that are mentioned in this document.

### Understanding the extension configuration in Portal

 The extension configuration file contains the configuration for all the extensions for a specific environment. For example, Extensions.Prod.json contains configuration for all extensions in Production.

The following is a typical configuration for an extension.
```
{
     name: "Microsoft_Azure_Demo",
     uri: "//demo.hosting.portal.azure.net/demo",
     uriFormat: "//demo.hosting.portal.azure.net/demo/{0}",
     feedbackEmail: "azureux-demo@microsoft.com",
     cacheability: "none",
     disabled: true,
}
```
Its components are as follows.
1. name

    The name that is specified in the Client\extension.pdl file of your extension. For more information about the extension.pdl file, see [the extension pdl file](portalfx-extensions-configuration-overview.md#extensionPdl) that is located at [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

1. uri and uriFormat

    Every extension can deploy one or more stamps based on their testing requirements. A stamp is an instance of a service in a region. The main stamp is used for production and is the only one that the portal will load by default. Additional stamps can be accessed using the URI format specified in extension config. For more information about extension config, see     .

    If you are using an extension hosting service to deploy your extension, then the uri and uri format will look like the following.
    ```
    uri: "//demo.hosting.portal.azure.net/demo",
    uriFormat: "//demo.hosting.portal.azure.net/demo/{0}",  
    ```

    If you have not yet onboarded a hosting service and your extension is still using the DIY deployment, then the uri and uri format will look like the following.
    ```
    uri: "//main.demo.ext.azure.com",
    uriFormat: "//{0}.demo.ext.azure.com",
    ```

    NOTE: Extension using legacy DIY URLs must use a standard CNAME pattern, as specified in  [portalfx-extensions-cname-patterns.md](portalfx-extensions-cname-patterns.md). |

1. feedbackEmail

    This is the email id where you you want all the feedback should be sent. To update the feedback email, see     .

1. Cacheability

    If you are using a hosting service, then you do not need to worry about this attribute. The default value of cacheability is manifest, as in the following example.

    ``` cacheability: "manifest", ``` 

    If you are using the legacy DIY deployment, then you will need to do some work before you can set the value of the cacheability attribute to "manifest", or your extension will reduce the performance of Azure Portal.

    Please read about Client-Side caching to improve the performance of your extension before setting the value to none. For more information about Client-Side caching, see     .

    NOTE: Setting the value of the cacheability attribute to "manifest" is a pre-requisite for Public Preview / GA. For private preview, you can set the value of the cacheability attribute to  "none".

1. disabled

    All extensions are registered as disabled,  i.e., they are in hidden mode. This is useful if you are not yet ready to host your extension for Public preview / GA. Most partners use this capability to either test the extension or host it for private preview.

    To temporarily enable a disabled extension for your session only, add an extension override in the portal URL, as in the following example.

    ``` https://portal.azure.com?Microsoft_Azure_Demo=true ```

    where

    ``` Microsoft_Azure_Demo ```

    is the name of the extension as registered with the portal.

    Conversely, you can temporarily disable an extension by setting this attribute to a value of false.

