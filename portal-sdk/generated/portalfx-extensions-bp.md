<a name="azure-portal-best-practices"></a>
# Azure Portal Best Practices

This document  contains all Best Practices that have been added to Azure Portal topics. Best Practices that have been documented in textbooks and similar publications are outside of the scope of this document.
   
<a name="azure-portal-best-practices-debugging"></a>
## Debugging


<a name="azure-portal-best-practices-best-practices"></a>
## Best Practices

Methodologies exist that assist developers in improving the product while it is still in the testing stage. Some strategies include describing bugs accurately, including code-coverage test cases in a thorough test plan, and other items.

A number of textbooks are devoted to the arts of software testing and maintenance.  Items that have been documented here do not preclude industry-standard practices.

<a name="azure-portal-best-practices-best-practices-bulb-productivity-tip"></a>
### :bulb: Productivity Tip

**Typescript** 2.0.3 should be installed on your machine. The   version can be verified by executing the following command:

```bash
$>tsc -version
```

Also, **Typescript** files should be set up to Compile on Save.


<a name="azure-portal-best-practices-extensions-onboarding"></a>
## Extensions onboarding


<a name="azure-portal-best-practices-best-practices"></a>
## Best Practices
   
Portal development patterns or architectures that are recommended based on customer feedback and usability studies are located in the topic for the blade that is being developed. For more information, see [portalfx-blades-best-practices.md](portalfx-blades-best-practices.md).

<a name="azure-portal-best-practices-best-practices-performance"></a>
### Performance

There are practices that can improve the performance of the extension.  For more information, see [portalfx-performance-bestpractices.md](portalfx-performance-bestpractices.md).


<a name="azure-portal-best-practices-best-practices-productivity-tip"></a>
### Productivity Tip

Install Chrome that is located at [http://google.com/dir](http://google.com/dir) to leverage the debugger tools while developing an extension.

<a name="azure-portal-best-practices-loading-and-managing-data"></a>
## Loading and managing data

<a name="azure-portal-best-practices-best-practices"></a>
## Best Practices

<a name="azure-portal-best-practices-best-practices-use-querycache-and-entitycache"></a>
### Use QueryCache and EntityCache

When performing data access from your view models, it may be tempting to make data calls directly from the `onInputsSet` function. By using the `QueryCache` and `EntityCache` objects from the `DataCache` class, you can control access to data through a single component. A single ref-counted cache can hold data across your entire extension.  This has the following benefits.

* Reduced memory consumption
* Lazy loading of data
* Less calls out to the network
* Consistent UX for views over the same data.

**NOTE**: Developers should use the `DataCache` objects `QueryCache` and `EntityCache` for data access. These classes provide advanced caching and ref-counting. Internally, these make use of Data.Loader and Data.DataSet (which will be made FX-internal in the future).

To learn more, visit [portalfx-data-caching.md#configuring-the-data-cache](portalfx-data-caching.md#configuring-the-data-cache).



<a name="azure-portal-best-practices-best-practices-avoid-unnecessary-data-reloading"></a>
### Avoid unnecessary data reloading

As users navigate through the Ibiza UX, they will frequently revisit often-used resources within a short period of time.
They might visit their favorite Website Blade, browse to see their Subscription details, and then return to configure/monitor their
favorite Website. In such scenarios, ideally, the user would not have to wait through loading indicators while Website data reloads.

To optimize for this scenario, use the `extendEntryLifetimes` option that is available on the `QueryCache` object and the `EntityCache` object.

```ts

public websitesQuery = new MsPortalFx.Data.QueryCache<SamplesExtension.DataModels.WebsiteModel, any>({
    entityTypeName: SamplesExtension.DataModels.WebsiteModelType,
    sourceUri: MsPortalFx.Data.uriFormatter(Shared.websitesControllerUri),
    supplyData: (method, uri, headers, data) => {
        // ...
    },
    extendEntryLifetimes: true
});

```

The cache objects contain numerous cache entries, each of which are ref-counted based on not-disposed instances of QueryView/EntityView. When a user closes a blade, typically a cache entry in the corresponding cache object will be removed, because all QueryView/EntityView instances will have been disposed. In the scenario where the user revisits the Website blade, the corresponding cache entry will have to be reloaded via an **AJAX** call, and the user will be subjected to loading indicators on
the blade and its parts.

With `extendEntryLifetimes`, unreferenced cache entries will be retained for some amount of time, so when a corresponding blade is reopened, data for the blade and its parts will already be loaded and cached.  Here, calls to `this._view.fetch()` from a blade or part `ViewModel` will return a resolved Promise, and the user will not see long-running loading indicators.

**NOTE**:  The time that unreferenced cache entries are retained in QueryCache/EntityCache is controlled centrally by the FX
 and the timeout will be tuned based on telemetry to maximize cache efficiency across extensions.)

For your scenario to make use of `extendEntryLifetimes`, it is **very important** that you take steps to keep your client-side
QueryCache/EntityCache data caches **consistent with server data**.
See [Reflecting server data changes on the client](portalfx-data-configuringdatacache.md) for details.


<a name="azure-portal-best-practices-sideloading"></a>
## Sideloading


<a name="azure-portal-best-practices-best-practices"></a>
## Best Practices
   
These best practices are in addition to the techniques that are documented in topics like [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).


***What is the best environment for sideloading during initial testing?***

 The FAQs for debugging extensions is located at [portalfx-extensions-hosting-service.md](portalfx-extensions-hosting-service.md).

* * *



<a name="azure-portal-best-practices-testing-in-production"></a>
## Testing in Production


<a name="azure-portal-best-practices-best-practices"></a>
## Best Practices

<a name="azure-portal-best-practices-best-practices-onebox-stb-is-not-available"></a>
### Onebox-stb is not available

Onebox-stb has been deprecated. Please do not use it. Instead, migrate extensions to sideloading. For help on migration, send an email to  ibiza-onboarding@microsoft.com.

* * * 

