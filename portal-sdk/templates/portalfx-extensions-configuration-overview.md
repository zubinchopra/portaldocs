## Conceptual Overview

### Understanding the extension configuration in Portal

 The extension configuration file contains  information for all extensions registered in the Azure portal. It is located in the portal repository in the  `src/RDPackages/OneCloud/` directory that is located at [https://msazure.visualstudio.com/One/_git/AzureUX-PortalFx?version=GBdev](https://msazure.visualstudio.com/One/_git/AzureUX-PortalFx?version=GBdev).
 
  The configuration file name is based on the environment name, as in the following code.  
 
 `Extensions.<EnvironmentName>.json`
 
 For example, ```Extensions.Prod.json``` contains the configuration for all extensions in Production, and  `Extensions.dogfood.json` contains the configuration for all extensions in the dogfood environment.

 The following sample configuration file contains a typical configuration for an extension.

```json
{
     name: "Microsoft_Azure_Demo",
     uri: "//demo.hosting.portal.azure.net/demo",
     uriFormat: "//demo.hosting.portal.azure.net/demo/{0}",
     feedbackEmail: "azureux-demo@microsoft.com",
     cacheability: "manifest",
     disabled: true,
}
```

<!-- TODO:  Include the definition of flightUri and explain that it is an optional parameter --->

Its options are as follows.
#### name

The name for the extension, as specified in the `Client\extension.pdl` file of the Visual Studio project. The name is the same as the one specified by the developer in the code base.
    
Typically, the ``` extension.pdl``` file looks like the following.
  ```json
    <?xml version="1.0" encoding="utf-8" ?>
    <Definition xmlns="http://schemas.microsoft.com/aux/2013/pdl">
    <Extension Name="Microsoft_Azure_Demo" Version="1.0" EntryPointModulePath="Program"/>
    </Definition>
  ```
    
Extension names must use standard extension name format, as in the following example. 

  ``` <Company>_<BrandOrSuite>_<ProductOrComponent>  ```

  Examples:  ```Contoso_Azure_<extension>  ```      
             ```Microsoft_Azure_<extension> ```


Set the extension name in  ```extension.pdl ``` as follows:

  ``` Extension Name="Company_BrandOrSuite_ProductOrComponent" Preview="true"> ``` 

If the extension is in preview mode then the preview tag should also be added, as in the following code. 

  ```<Extension Name="Microsoft_Azure_Demo" Version="1.0" Preview="true" EntryPointModulePath="Program"/>```
 
#### uri
  
The uniform resource identifier for the extension. This consists of the uri of the provider, followed by a forward slash, followed by the directory that contains the extension. 
   
When the user loads the extension in the portal, it is loaded from the `uri` specified in the extension configuration. 

The following code contains the ```uri``` for an extension  that is being hosted by an extension hosting service.
    
```json
uri: "//demo.hosting.portal.azure.net/demo",
```

where

**demo.hosting.portal.azure.net**:   the address of the resource provider (RP)

**demo**: the name of the directory.


The following code contains the ```uri``` for an extension  that is still using the DIY deployment.
    
```json
uri: "//main.demo.ext.azure.com",
```

where

**main.demo.ext.azure.com**:   the address of the resource provider (RP).

Additional extension stamps can be loaded by specifying the stamp name in the  `url` and specifying the feature flag `feature.canmodifystamps=true`. For more information about feature flags, see [portalfx-extension-flags.md](portalfx-extension-flags.md).

**NOTE** We recommend that the `uri` follow the standard CNAME pattern, as specified in  [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md). 

To update the ```uri```, send a pull request as specified in [portalfx-extensions-pullRequest.md](portalfx-extensions-pullRequest.md).

#### uriFormat
The `uri` for the extension, concatenated with a parameter marker that allows modification of the extension stamp.
    
The following code contains the `uriFormat` for an extension that is being hosted by an extension hosting service.
    
```json
uriFormat: "//demo.hosting.portal.azure.net/demo/{0}",
```

where 

**demo.hosting.portal.azure.net**:   the address of the resource provider (RP)

**demo**: the name of the directory

 ``` {0} ```: the parameter marker that will contain the value to substitute into the name string, when the extension is loading, in order to specify the environment from which to load the extension. The position of the parameter marker is different for DIY deployment. The following code describes the ```uriFormat``` parameter for extensions that have not yet onboarded a hosting service.

   ```json
    uri: "//main.demo.ext.azure.com",
    uriFormat: "//{0}.demo.ext.azure.com",
   ```

   **NOTE** We recommend that the `uriFormat` follow  the standard CNAME pattern, as specified in  [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md). 

   To update the `uriFormat`, send a pull request as specified in [portalfx-extensions-pullRequest.md](portalfx-extensions-pullRequest.md).
  
For more information about loading extension stamps, see [portalfx-extensions-testing-in-production-overview.md#registering-a-custom-extension](portalfx-extensions-testing-in-production-overview.md#registering-a-custom-extension).

For information on how developers can leverage secondary stamps, see [portalfx-extensions-configuration-overview.md#extension-stamps](./portalfx-extensions-configuration-overview.md#extension-stamps).
  
#### feedbackEmail

The email id to which to send all feedback about the extension. 

To update the feedback email, send a pull request as specified in [portalfx-extensions-pullRequest.md](portalfx-extensions-pullRequest.md).

#### cacheability

Enables caching of the extension on your extension server or on the client. The default value is "manifest".
      
If legacy DIY deployment is being used, then you will need to do some work before the value of the cacheability attribute can be set to ```manifest```. Otherwise, the extension will reduce the performance of Azure Portal.

**NOTE**: Setting the value of the cacheability attribute to ```manifest``` is a requirement for registering the extension into the portal.  For assistance with caching, send an email to ibizaFXPM@microsoft.com.
    
For more information about caching, see [portalfx-extension-homepage-caching.md](portalfx-extension-homepage-caching.md).
   

#### disabled
Registers the extension configuration into the portal in hidden mode.  A value of  `true` disables an extension, and a value of `false` enables the extension for display. 
    
All extensions are registered into the portal in the disabled state, therefore they are disabled by default.  This hides the extension from users, and it will not be displayed in the portal. The extension will remain in hidden mode until it is ready for general use. This is useful if the extension is not  yet ready for the public preview phase or the GA phase. Most partners use this capability to test the extension, or to host it for private preview.

To temporarily enable a disabled extension in private preview for this session only, change the configuration by adding an extension override in the portal URL, as in the following example.

``` https://portal.azure.com?Microsoft_Azure_Demo=true ```

where

``` Microsoft_Azure_Demo ```

is the name of the extension as registered with the portal.

Conversely, the  extension can temporarily be disabled for a session by changing this configuration attribute to a value of `false`. The extension cannot be temporarily enabled or disabled in the production environment.


### Understanding which extension configuration to modify
The Azure portal uses five different extension configuration files to manage the extension configuration. The description of mapping of the portal environment to the extension configuration is located at [portalfx-extensions-cnames.md#creating-cnames](portalfx-extensions-cnames.md#creating-cnames).

### Extension Stamps

Because the hosting service provides a mechanism for deploying extensions using safe deployment practices, the portal will load the version of the extension that is based on the region from where the customer is accessing the portal. For more details, see the Hosting Service documentation located at [https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-extension-hosting-service.md](https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-extension-hosting-service.md).

If the Legacy DIY deployment registration format is used, then the portal will always serve the stamp that is registered in the ```uri```. In the preceding  examples, the portal will always serve main stamp of the extension.

Additional stamps can be accessed by using the ```uriFormat``` parameter that is specified in the extension config file.

To use a secondary test stamp, specify the ```feature.canmodifystamps ``` flag, and add a parameter that matches the name of the  extension as registered in the portal, as in the following example.

```json
name: "Microsoft_Azure_Demo",
uri: "//main.demo.ext.azure.com",
uriFormat: "//{0}.demo.ext.azure.com",
. . .
https://portal.azure.com?feature.canmodifystamps=true&Microsoft_Azure_Demo=perf 
```

 The portal  will replace the ```{0}``` in the ```uriFormat``` string with ```perf```, and attempt to load the ```Microsoft_Azure_Demo``` extension from the ```https://perf.demo.ext.azure.com``` URL. The portal always uses the  HTTPS protocol.

 **NOTE** To override the stamp, specify the flag ```feature.canmodifystamps=true ```.
