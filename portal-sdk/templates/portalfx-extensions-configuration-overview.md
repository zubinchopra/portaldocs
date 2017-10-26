<a name="portalfxExtensionsConfigurationOverview.md"></a>
<!-- link to this document is [portalfx-extensions-configuration-overview.md]()
-->

## Conceptual Overview

### Understanding which extension configuration to modify

The Azure portal uses five different extension configuration files to manage the extension configuration. The following table explains the mapping of the portal environment to the extension configuration that is contained in the portal repository:
| Environment	| URL	|  Configuration File (in portal repo) |
| --- | --- | --- |
| DOGFOOD | 	df.{extension}.onecloud-ext.azure-test.net | 	Extensions.test.json | 
| RC | rc.{extension}.onecloud-ext.azure-test.net	 | Extensions.prod.json | 
| MPAC | 	ms.{extension}.onecloud-ext.azure-test.net | 	Extensions.prod.json | 
| Preview | 	preview.{extension}.onecloud-ext.azure-test.net | 	Extensions.prod.json | 
| PROD | 	main.{extension}.ext.azure.com	 | Extensions.prod.json | 
|  BLACKFOREST | 	main.{extension}.ext.microsoftazure.de | 	Extensions.bf.json | 
|  FAIRFAX | 	main.{extension}.ext.azure.us	 | Extensions.ff.json | 
|  MOONCAKE	 | main.{extension}.ext.azure.cn	 | Extensions.mc.json | 

The preceding table implies that to manage extension configuration in Dogfood, BlackForest, FairFax and MoonCake, the developer will need to send the pull request for modifying Extensions.test.json, Extensions.bf.json, Extensions.ff.json and Extensions.mc.json. However, the extension configuration for RC, MPAC, Preview and PROD is managed by the same file Extensions.prod.json. Therefore, the extension can not host different stamps for these environments.

Since hosting service provides a mechanism for extensions to deploy using safe deployment practice, the portal will load the version of your extension based on the region from where the customer is accessing the portal. For more details, see the Hosting Service documentation located at [https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-extension-hosting-service.md](https://github.com/Azure/portaldocs/blob/dev/portal-sdk/templates/portalfx-extension-hosting-service.md).

If you are using Legacy DIY deployment registration format then the portal will always serve the stamp that is registered in the uri. In the preceding  examples, the portal will always serve main stamp of the extension.

To use a secondary test stamp, specify the ```feature.canmodifystamps ``` flag in addition to a parameter that matches the name of your extension as registered in the portal. For instance, 
```https://portal.azure.com?feature.canmodifystamps=true&Microsoft_Azure_Demo=perf ```
 would replace the ```{0}``` in the uriFormat string with ```perf```, and attempt to load the extension from there, making the extension URL ```https://perf.demo.ext.azure.com```. 

 NOTE: You must specify the flag ```feature.canmodifystamps=true ``` in order to override the stamp.

<a name="extensionPdl"></a> 

## The extension.pdl file
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