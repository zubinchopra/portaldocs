<a name="portalfxExtensionsConfigurationOverview.md"></a>
<!-- link to this document is [portalfx-extensions-configuration-overview.md]()
-->

## Conceptual Overview

### Understanding the extension configuration in Portal

 The extension configuration file is named ```extension.config```, and contains the configuration for all the extensions for a specific environment. For example, ```Extensions.Prod.json``` contains the configuration for all extensions in Production.

The following ```extension.config ``` file contains a typical configuration for an extension.

```
{
     name: "Microsoft_Azure_Demo",
     uri: "//demo.hosting.portal.azure.net/demo",
     uriFormat: "//demo.hosting.portal.azure.net/demo/{0}",
     feedbackEmail: "azureux-demo@microsoft.com",
     cacheability: "manifest",
     disabled: true,
}
```
Its components are as follows.
1. name
    <details>
        <summary> The name for the extension, as specified in the Client\extension.pdl file of the extension.</summary>
    <a name="extensionPdl"></a> 

    Typically, the extension.pdl file looks like the following.
    ```
    <?xml version="1.0" encoding="utf-8" ?>
    <Definition xmlns="http://schemas.microsoft.com/aux/2013/pdl">
    <Extension Name="Microsoft_Azure_Demo" Version="1.0" EntryPointModulePath="Program"/>
    </Definition>
    ```
    
    Extension names must use standard extension name format, as in the following example. 

    ``` <Company>_<BrandOrSuite>_<ProductOrComponent>  ```

    Examples:  ```Contoso_Azure_{extension}  ```      
                ```Microsoft_Azure_{extension} ```


    Set the extension name in  ```extension.pdl ``` as follows:

    ``` Extension Name="Company_BrandOrSuite_ProductOrComponent" Preview="true"> ``` 

    If your extension is in preview mode then you also need to add the preview tag:

    ```<Extension Name="Microsoft_Azure_Demo" Version="1.0" Preview="true" EntryPointModulePath="Program"/>```
 
    </details>
1. uri 
    <details>
        <summary>
        The uniform resource identifier for the extension. This consists of the uri of the provider, followed by a forward slash, followed by the directory that contains the extension.
        </summary>
        <a name="extensionUri"></a> 

    The following code contains the uri for an extension.
    
    ```
    uri: "//demo.hosting.portal.azure.net/demo",
    ```

    where

    ```     demo.hosting.portal.azure.net     ```:   the address of the resource provider (RP)

    ```      demo      ```: the name of the directory.


     To update the uri, send a pull request   .
     <!-- TODO:  To where should the pull request be sent? -->
    </details>
      <a name="uriAndUriFormat"></a>
 

1.  uriFormat
    <details>
        <summary>
        The uri for the extension, concatenated with a parameter marker that allows modification of the extension stamp.
        </summary>
        <a name="extensionUriFomat"></a> 

    The following code contains the uriFormat for an extension.
    
    ```
    uriFormat: "//demo.hosting.portal.azure.net/demo/{0}",
    ```

    where

    ``` demo.hosting.portal.azure.net     ```:   the address of the resource provider (RP)

    ```  demo      ```: the name of the directory

    ``` {0} ```: the parameter marker that will contain the value to substitute into the name string, when the extension is loading, in order to specify the environment from which to load the extension.
    
    The position of the parameter marker in the uriFormat is different for DIY deployment. The following code describes the uri and uriFormat for DIY deployment for extensions that have not yet onboarded a hosting service.

    ```  
    uri: "//main.demo.ext.azure.com",
    uriFormat: "//{0}.demo.ext.azure.com",
    ```

    To update the uriFormat, send a pull request   .
         <!-- TODO:  To where should the pull request be sent? -->
    </details>


1. feedbackEmail
    <details>
        <summary>
    The email id to which to send all feedback about the extension. 
        </summary>

     To update the feedback email, send a pull request   .
         <!-- TODO:  To where should the pull request be sent? -->
    </details>

1. Cacheability
    <details>
        <summary>
          Enables caching of the extension on your extension server or on the client. The default value is "manifest".
        </summary>
        <a name="cacheability"></a> 
      
    If you are using legacy DIY deployment, then you will need to do some work before you can set the value of the cacheability attribute to ```manifest```, or your extension will reduce the performance of Azure Portal.

    Please read about Client-Side caching to improve the performance of your extension before setting the value to ``` none```. For more information about Client-Side caching, see     [portalfx-performance.md#performance-best-practices-extension-homepage-caching-client-side-caching-of-extension-home-pages](portalfx-performance.md#performance-best-practices-extension-homepage-caching-client-side-caching-of-extension-home-pages).

    NOTE: Setting the value of the cacheability attribute to ```manifest``` is a pre-requisite for the public preview phase and the GA phase. For the private preview phase, the value of the cacheability attribute can be set to  ```none```.
    
    For more information about caching, see [portalfx-performance.md#"performance-best-practices-extension-homepage-caching](portalfx-performance.md#"performance-best-practices-extension-homepage-caching)
    </details>

1. disabled
    <details>
        <summary>
            Registers the extension into the portal in hidden mode or displayable mode.  A value of  "false" disables an extension, and a value of "true" enables the extension. 
        </summary>

    All extensions are registered into the portal in the disabled state, therefore they are disabled by default.  This hides the extension from users, and it will not be displayed in the portal. The extension will remain in hidden mode until it is ready for general use. This is useful if the extension is not  yet ready for the public preview phase or the GA phase. Most partners use this capability to test the extension, or to host it for private preview.

    To temporarily enable a disabled extension in private preview for your session only, add an extension override in the portal URL, as in the following example.

    ``` https://portal.azure.com?Microsoft_Azure_Demo=true ```

    where

    ``` Microsoft_Azure_Demo ```

    is the name of the extension as registered with the portal.

    Conversely, you can temporarily disable an extension by setting this attribute to a value of false.

    </details>

### Understanding which extension configuration to modify

<a name="configuration-selection"></a>

The Azure portal uses five different extension configuration files to manage the extension configuration. The following table explains the mapping of the portal environment to the extension configuration that is contained in the portal repository:
| Portal Environment	| URL	|  Configuration File  |
| --- | --- | --- |
| DOGFOOD | 	df.{extension}.onecloud-ext.azure-test.net | 	Extensions.test.json | 
| RC | rc.{extension}.onecloud-ext.azure-test.net	 | Extensions.prod.json | 
| MPAC | 	ms.{extension}.onecloud-ext.azure-test.net | 	Extensions.prod.json | 
| Preview | 	preview.{extension}.onecloud-ext.azure-test.net | 	Extensions.prod.json | 
| PROD | 	main.{extension}.ext.azure.com	 | Extensions.prod.json | 
|  BLACKFOREST | 	main.{extension}.ext.microsoftazure.de | 	Extensions.bf.json | 
|  FAIRFAX | 	main.{extension}.ext.azure.us	 | Extensions.ff.json | 
|  MOONCAKE	 | main.{extension}.ext.azure.cn	 | Extensions.mc.json | 

The preceding table implies that to manage extension configuration in Dogfood, BlackForest, FairFax and MoonCake, the developer should send a pull request to modify ```Extensions.test.json```, ```Extensions.bf.json```, ```Extensions.ff.json``` and ```Extensions.mc.json```. 

However, the extension configurations for RC, MPAC, Preview and PROD are all managed by the file ```Extensions.prod.json```. Therefore, the extension can not host different stamps for these environments, and a pull request to modify  ```Extensions.prod.json``` will modify all four environments.

Because the hosting service provides a mechanism for deploying extensions using safe deployment practices, the portal will load the version of your extension based on the region from where the customer is accessing the portal. For more details, see the Hosting Service documentation located at [https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-extension-hosting-service.md](https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-extension-hosting-service.md).

If you are using the Legacy DIY deployment registration format, then the portal will always serve the stamp that is registered in the ```uri```. In the preceding  examples, the portal will always serve main stamp of the extension.

Additional stamps can be accessed by using the ```uriFormat``` parameter that is specified in the extension config file.

To use a secondary test stamp, specify the ```feature.canmodifystamps ``` flag, and add a parameter that matches the name of your extension as registered in the portal, as in the following example.

```
uri: "//main.demo.ext.azure.com",
uriFormat: "//{0}.demo.ext.azure.com",
. . .
https://portal.azure.com?feature.canmodifystamps=true&Microsoft_Azure_Demo=perf 
```

 The portal  will replace the ```{0}``` in the ```uriFormat``` string with ```perf```, and attempt to load the extension from  ```https://perf.demo.ext.azure.com```. 

 NOTE: You must specify the flag ```feature.canmodifystamps=true ``` in order to override the stamp.

  NOTE: We recommend you follow the standard CNAME pattern, as specified in  [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md). |