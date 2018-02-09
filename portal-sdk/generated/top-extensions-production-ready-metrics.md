<a name="production-ready-metrics-and-quality-metrics"></a>
## Production Ready Metrics and Quality Metrics
      
In order to meet customer expectations and continue to increase customer satisfaction, there are quality metrics that are tracked for every extension, and part.  These metrics help developers build extensions that compile, that contain the items that are requested by the partners of the developer, and that pass acceptance tests that are created by the partners that are associated with a specific phase. When the extension meets the criteria, it becomes a candidate for being moved from the private preview stage to the public preview stage, or from the public preview stage to Global Availability (GA).

Every new extension provides an opportunity for the Ibiza team to improve the customer experience. By using set criteria to meet customer expectations, we can improve the customer experience for the extension and overall Portal. Extension developers can drastically improve the customer experience by following these criteria. 

<a name="customer-experience-metrics"></a>
## Customer experience metrics

The criteria that are tracked for each extension are reported as part of an executive summary every Friday. Extensions that fail to meet the criteria are typically prime candidates for having brought down the customer experience in the Azure Portal. Such extensions are highlighted in the weekly status report.

Customer experience metrics are tracked by the Azure Portal team, and are reported to the VP sponsor of the extension by using weekly status emails. These metrics are also reported as part of the weekly S360 meeting, and the executive review meeting. Any extension that does not meet the following criteria is required to justify the reasons for a negative customer experience. Extension developers can improve the customer experience of Azure Portal by ensuring that their extensions meet the following criteria previous to enabling the extension for public preview or Global Availability. 

* [Performance](#performance)
* [Reliability](#reliability)
* [Usability](#usability)
* [Accessibility](#accessibility)
* [Localization](#localization)
* [Create Success Rate](#create-success-rate)

<a name="customer-experience-metrics-performance"></a>
### Performance

The Weighted Experience Score (WxP) determines the percentage of blade usage that meets the performance bar. The metrics for all blades within an extension are combined into the WxP, which requires a passing score of greater than 80. Meeting the performance bar is a requirement for public preview or Global Availability (GA).

MPAC and PROD performance are included in weekly status emails and each team is expected to investigate regressions.

For more information about the Weighted Experience Score, see  [portalfx-performance.md#wxp-score](portalfx-performance.md#wxp-score).

Blade reveal time is the time it takes for all the parts above the fold to call ```revealContent()``` to load first level data, or to resolve ```onInputSet()``` promises, whichever is earlier.

All blades meet the required blade reveal time of less than 4 seconds for the 80th percentile before being enabled in PROD. Extensions should be enabled in MPAC to start tracking performance. Resource and Create blades are tracked explicitly. 

We require at least 100 loads of the UX (extension/blade/tiles) to get a signal. If you cannot generate that traffic authentically in the expected timeframe, please hold a bug bash to increase the traffic.

For more information about performance and reliability, see the following resources:

* Dashboard 

  [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf)

  * Telemetry Access for access 
        
    [portalfx-telemetry-getting-started.md](portalfx-telemetry-getting-started.md)

  * Query - including test/dev traffic

    [https://aka.ms/portalfx/perfsignoff](https://aka.ms/portalfx/perfsignoff)

* Checklist

    [portalfx-performance.md](portalfx-performance.md)

* Portal COP (Telemetry)

    [portalfx-performance-portalcop.md](portalfx-performance-portalcop.md)

<a name="customer-experience-metrics-reliability"></a>
### Reliability

Every extension meets the reliability Service Level Agreement (SLA). There are some reliability metrics should be met previous to enabling the extension in the production environment; however, extensions must be enabled in MPAC in order to start tracking reliability. Meeting the reliability bar is a requirement for public preview or GA.

MPAC and PROD reliability are included in weekly status emails and each team is expected to investigate regressions.

We require at least 100 loads of the UX (extension/blade/tiles) to get a signal, if you cannot generate that traffic authentically in the expected timeframe, please hold a bug bash to increase traffic.

Use the following query to calculate the performance and reliability of your extension.
    
```json 
    // First parameter startDate
    // Second parameter timeSpan
    // Third parameter includeTestTraffic - set this to `false` if you are already in public preview
    GetExtensionPerfReliability(now(),7d,true) 
    | where extension == "<extensionName>"
```

If any of the reliability numbers of the extension are below the bar, please investigate and resolve the related issues.

<a name="customer-experience-metrics-usability"></a>
### Usability


Each service or extension defines the critical P0 scenarios for their business. The extension is tested using these usability scenarios, with at least ten participants. A success rate of 80% and an experience score of 80% are required for a passing usability score.

For more information on how to define scenarios, see       .

<a name="customer-experience-metrics-accessibility"></a>
### Accessibility

The accessibility bar is similar to the usability bar, and every service must meet the accessibility standards that are tested in their critical P0 scenarios. C+E teams should work with their own Accessibility teams. 
    
**NOTE**: Accessibility is a blocking requirement.

For more information about accessibility, see [portalfx-accessibility.md](portalfx-accessibility.md).
    
<a name="customer-experience-metrics-localization"></a>
### <strong>Localization</strong>

Nearly 70% of Azure users are from outside of the United States. Therefore, it is important to make Azure a globalized product. There are a few requirements under the "Internationalization" criteria that your service is required to support.  This is the same set of languages that are supported by Azure Portal for GA. For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). For onboarding localization, please reach out to Bruno Lewin and the Internationalization team at <a href="mailto:ibiza-interntnl@microsoft.com?subject=Onboarding localization">Internationalization team</a>.


<a name="customer-experience-metrics-create-success-rate"></a>
### Create Success Rate
    
The success of an extension is combined of several factors, the most important of which is customer satisfaction. In order to ensure that every customer has a great customer experience, the extension should be within the create success rate.   The create success rate is defined as the number of times the UX completes the generation process when the create button is clicked. When the extension meets or exceeds those factors, it is eligible for public preview or Global Availability.
     
Extensions and Resource Providers (RPs) are responsible for validating all inputs to ensure the Create is not submitted unless that Create will be successful. This applies to all services.

Services that use ARM template deployment and other ARM-based services should also validate resource provider registration, permissions, and deployment to avoid common issues and improve extension success rates. Validating against some factors is required for the preview and GA phases.

Check the Power BI Dashboard for Service Level Agreements (SLA) that are associated with Creating extensions. The Ibiza Extension Perf/Reliability/Usage Dashboard is located at [http://aka.ms/ibizaperformance](http://aka.ms/ibizaperformance).

It is important to meet the success rate previous to moving the extension to the next phase, because various phases are associated with service level agreements and other items that are affected if an extension does not work.  For example, extensions with a success rate below 99% will result in sev 2 incidents. Also, if the success rate drops by 5% during a rolling 24-hour period that contains at least 50 Creates, a sev 2 incident will be filed. This applies to every error that causes Creates to fail when the `Create` button is clicked.

Success rates are a non-blocking requirement. 
<!-- TODO: Determine whether any mention at all of the exception process should be on GitHub, as in the following sentence.
   Some exceptions can be granted to move an extension from the private preview stage to the public preview stage, but in general, the overall customer experience is reduced.
-->
   
For more information about creating success, see [portalfx-create.md#validation](portalfx-create.md#validation).

<a name="resource-move"></a>
## Resource move

ARM-based services allow customers to move resources between subscriptions and resource groups.

For more information on resource moves, see the following resources.
    
* Documentation 

    [portalfx-resourcemove.md](portalfx-resourcemove.md)
	
* Dashboard
        
    [http://aka.ms/portalfx/resourcemove/dashboard](http://aka.ms/portalfx/resourcemove/dashboard)
