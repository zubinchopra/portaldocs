<a name="creating-cnames"></a>
## Creating CNAMEs
 Extension URLs use a standard CNAME pattern. Extensions that host themselves follow the CNAME naming pattern, and extensions that use a hosting service use the hosting service name convention. CNAMEs for hosting services are managed by the Ibiza team. 
 
 The CNAMEs that are created are unique for each environment, and use the formats that are specified in the following table, which describes the URL format and the hosting service name convention for each environment.

| Environment	| Legacy URL | Hosting Service |
| --- | --- | --- |
| **DOGFOOD**	| df.{extension}.onecloud-ext.azure-test.net |`//hosting.onecloud.azure-test.net/{contentUnbundlerRoutePrefix}` |
| **PROD** 	| 	main.{extension}.ext.azure.com | 	{contentUnbundlerRoutePrefix}.hosting.portal.azure.net/{contentUnbundlerRoutePrefix} |
| **BLACKFOREST**	| main.{extension}.ext.microsoftazure.de  |  //{contentUnbundlerRoutePrefix}.hosting.azure-api.de/{contentUnbundlerRoutePrefix} |
| **FAIRFAX**		| main.{extension}.ext.azure.us |  {contentUnbundlerRoutePrefix}.hosting.azureportal.usgovcloudapi.net/{contentUnbundlerRoutePrefix |
| **MOONCAKE**		| main.{extension}.ext.azure.cn |  {contentUnbundlerRoutePrefix}.hosting.azureportal.chinacloudapi.cn/{contentUnbundlerRoutePrefix} |

The relationship between the environments and the configuration files is in the following diagram.

 ![alt-text](../media/portalfx-extensions-cnames/extensionEnvironments.png  "Extension Configurations and Environments")

<a name="creating-cnames-dogfood-and-production-cnames"></a>
### Dogfood and Production CNAMEs
You can create DOGFOOD/PROD CNAMEs using the Azure DNS that is located at
 [https://azure.microsoft.com/en-us/services/dns/](https://azure.microsoft.com/en-us/services/dns/). Its documentation is located at  [https://docs.microsoft.com/en-us/azure/dns/dns-getstarted-portal](https://docs.microsoft.com/en-us/azure/dns/dns-getstarted-portal).  You can also use any DNS hosting system.

The PROD CNAME is used for RC, MPAC, Preview and PROD environments.

<a name="creating-cnames-national-clouds"></a>
### National Clouds
Create National Cloud CNAMEs using the process specified in each cloud.  For more information, search for "DNS" on their wiki pages, as described in the following table.
 | CLOUD | LOCATION |
 | --- | --- |
 | Fairfax | [https://aka.ms/fairfax](https://aka.ms/fairfax) |
 | Blackforest  | [https://aka.ms/blackforest](https://aka.ms/blackforest)  |
 | Mooncake | [https://aka.ms/mooncake](https://aka.ms/mooncake) |
 
<a name="glossary"></a>
## Glossary

 [portalfx-extensions-cnames-glossary.md](portalfx-extensions-cnames-glossary.md)