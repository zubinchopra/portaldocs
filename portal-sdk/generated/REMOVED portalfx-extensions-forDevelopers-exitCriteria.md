<a name="exit-criteria-and-quality-metrics"></a>
## Exit Criteria and Quality Metrics

Every new extension provides an opportunity for the Ibiza team to improve the customer experience. By using set criteria to meet customer expectations, we can improve the customer experience for the extension and overall portal.

The following are the criteria to meet for an extension to be moved from the private preview stage to the public preview stage, or from the public preview stage to Global Availability (GA). The criteria are tracked for each extension and are sent out as part of an executive summary every Friday. Extensions that fail to meet the criteria are usually prime candidates for having brought down the customer experience in the Azure portal. Such extensions are highlighted in the weekly status report.

Basic information on metrics is located at  [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).

Extension developers can drastically improve the customer experience by following these criteria. 

<a name="exit-criteria-and-quality-metrics-performance"></a>
### Performance

Blade reveal time is the time it takes for all the parts above the fold to call ```revealContent()``` to load first level data, or to resolve ```onInputSet()``` promises, whichever is earlier.

All blades meet the required blade reveal time of less than 4 seconds for the 80th percentile before being enabled in PROD. Extensions should be enabled in MPAC to start tracking performance. Resource and Create blades are tracked explicitly. 

We require at least 100 loads of the UX (extension/blade/tiles) to get a signal. If you cannot generate that traffic authentically in the expected timeframe, please hold a bug bash to increase the traffic.

For more information about performance and reliability, see the following resources:

* Dashboard 

  [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf)

  * Telemetry Access for access 
        
    [http://aka.ms/portalfx/docs/telemetryaccess](http://aka.ms/portalfx/docs/telemetryaccess)

  * Query - including test/dev traffic

    [https://aka.ms/portalfx/perfsignoff](https://aka.ms/portalfx/perfsignoff)

* Checklist

    [portalfx-performance.md](portalfx-performance.md)
        
   [http://aka.ms/portalfx/performance/checklist](http://aka.ms/portalfx/performance/checklist)

* Portal COP (Telemetry)

    [portalfx-performance-portalcop.md](portalfx-performance-portalcop.md)

<a name="exit-criteria-and-quality-metrics-reliability"></a>
### Reliability
    
We require at least 100 loads of the UX (extension/blade/tiles) to get a signal, if you cannot generate that traffic authentically in the desired timeframe, please hold a bug bash to increase traffic.

Use the following query to calculate the performance and reliability of your extension.
    
```json 
    // First parameter startDate
    // Second parameter timeSpan
    // Third parameter includeTestTraffic - set this to `false` if you are already in public preview
    GetExtensionPerfReliability(now(),7d,true) 
    | where extension == "YOUR_EXTENSION_NAME"
```

If any of the reliability numbers of the extension are below the bar, please investigate and resolve the related issues.

<a name="exit-criteria-and-quality-metrics-usability"></a>
### Usability



<a name="exit-criteria-and-quality-metrics-accessibility"></a>
### Accessibility



<a name="exit-criteria-and-quality-metrics-create-success"></a>
### Create success

In order to ensure that every customer has a great customer experience, the extension  meets the create success rate.  The success rate is defined as the number of times the UX completes the generation process when the Create button is clicked. 

Check the Power BI Dashboard for Service Level Agreements (SLA) that are associated with Create blades. The Ibiza Extension Perf/Reliability/Usage Dashboard is located at [aka.ms/ibizaperformance](aka.ms/ibizaperformance).

If the success rate drops by 5% during a rolling 24-hour period that contains at least 50 Creates, a sev 2 incident will be filed. 

This applies to every error that causes Creates to fail when the `Create` button is clicked.

Extensions and Resource Providers (RPs) are responsible for validating all inputs to ensure the Create is not submitted unless that
Create will be successful. This applies to all services, whether using ARM or not.

<a name="resource-move"></a>
## Resource move

