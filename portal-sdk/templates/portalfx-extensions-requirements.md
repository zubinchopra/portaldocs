<a name="portalfxExtensionsRequirements"></a>
<!-- link to this document is [portalfx-extensions-requirements.md]()
-->

## Requirements for Azure Services
All services using Azure Billing must be exposed by using the Azure Resource Manager (ARM). Services that do not use Azure Billing can use either ARM or Microsoft Graph. Usually, services that integrate deeply with Office 365 use Graph, while all others are encouraged to use ARM.

The Azure portal SDK doesn't require any specific back-end, but does provide extra support for ARM-based resources. 

All new services should be listed in the Azure Web site. This isn't a requirement for onboarding the portal, but service categorization is the same between the azure.com Products menu, portal Services menu, and the Azure Marketplace. The services should not be listed in the portal unless it is also on azure.com.