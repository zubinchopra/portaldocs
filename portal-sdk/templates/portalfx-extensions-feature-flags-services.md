
## Flags for Services

Flags are only accessible by the extension in which they are defined, and therefore are not shared across extensions. Typically, the flag is boolean and has a descriptive name. Most feature flags are set to a value of `true` or `false`, which respectively enables or disables the feature. However, some feature flags send non-boolean values to the extension when more than two options are appropriate to test a specific feature.

Features are enabled by appending a flag to the query string, as in the following example: `https://portal.azure.com/?<extensionName>_<flagName>=<value>`, where ```flagName```, without angle brackets, is the feature to enable for the extension. 

### The support extension

<!--TODO:  Determine whether there are other extensions that can be used by developer extensions that require code changes in addition to the query string feature flag. -->

Azure provides a support extension so that every resource that subscribes can assess its health, check the audit logs, get troubleshooting information, or open a support ticket. For questions regarding the process please reach out to the support adoption alias <AzSFAdoption@microsoft.com>.

Code must be added to the extension for each setting that will be used.  The following flags are used in coordination with the support extension, as specified in [portalfx-blades-bladeKinds.md#support-settings](portalfx-blades-bladeKinds.md#support-settings).

After the extension has been modified for the support extension, these flags can be used to obtain various types of support.  They are invoked as follows. 

```js
   &<extensionName>=troubleshootsettingsenabled=true
   &<extensionName>=healthsettingsenabled=true
   &<extensionName>=requestsettingsenabled=true
```

* **troubleshootsettingsenabled**:  A value of `true`   , and a value of `false`    .

* **healthsettingsenabled**: A value of `true`   , and a value of `false`    .

* **requestsettingsenabled**:  A value of `true`   , and a value of `false`    .

### The Azure Content Delivery Network

The Azure Content Delivery Network, as specified in [portalfx-pde-cdn.md](portalfx-pde-cdn.md), requires code changes and allows the use of an extension flag to provide the capability to send audio, video, images, and other files to customers.

### Other feature flag services

<!--TODO: Determine whether any of the following information qualifies as being feature flag services. -->

resource menu blade, as specified in [portalfx-creating-extensions.md](portalfx-creating-extensions.md).

Features provided in [portalfx-data-configuringdatacache.md](portalfx-data-configuringdatacache.md).

Features provided by  `MsPortalFx.Data.QueryCache` and `MsPortalFx.Data.EntityCache` provide. `QueryCache` is used to query for a collection of data. `EntityCache` is used to load an individual entity.

 ?feature.disablebladecustomization

<!--TODO: Determine whether any of the preceding information qualifies as being feature flag services. -->
