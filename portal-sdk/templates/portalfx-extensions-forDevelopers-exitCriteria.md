## Exit Criteria and Quality Metrics

Every new extension provides an opportunity for the iBiza team to improve the customer experience. By using the  following criteria to meet customer expectations, we can improve the customer experience for your extension and overall portal.

The following are the criteria to meet for an extension to be moved from the private preview stage to the public preview stage.  The criteria that an extension meets previous to being moved from the public preview stage to GA may be different. 

Basic information on metrics is located at  [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).

Extension developers can drastically improve the customer experience by following these criteria. 

1. Performance

    Blade reveal time is the time it takes for all the parts above to fold to call ```revealContent()``` to load first level data, or to resolve ```onInputSet()``` promises, whichever is earlier.

    All blades meet the required blade reveal time of less than 4 seconds for the 80th percentile before being enabled in PROD. Extensions should be enabled in MPAC to start tracking performance. Resource and Create blades are tracked explicitly. 

    We require at least 100 loads of the UX (extension/blade/tiles) to get a signal. If you cannot generate that traffic genuinely in the expected timeframe, please hold a bug bash to increase the traffic.

    For more information about performance, see the following resources:
    * Dashboard 

        [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf)

        * Telemetry Access for access 
        
            [http://aka.ms/portalfx/docs/telemetryaccess](http://aka.ms/portalfx/docs/telemetryaccess)


    *	Checklist

        [portalfx-performance.md](portalfx-performance.md)

    *	Portal COP (Telemetry)

        [portalfx-performance-portalcop.md](portalfx-performance-portalcop.md)


1. Reliability
    
    We require at least 100 loads of the UX (extension/blade/tiles) to get a signal, if you cannot to generate that traffic genuinely in the desired timefram, please hold a bug bash to drive up the traffic.

1. Usability

   Remember to follow the guidelines in [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).

1. Accessibility

   Remember to follow the guidelines in [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).

1. Create success
In order to ensure that every customer has a great customer experience, the app meets the create success rate.  The success rate is defined as the number of times the UX completes the generation process when the create button is clicked.  Some exceptions can be granted to move an extension from the private preview stage to the public preview stage, but in general, the overall customer experience is reduced.

    Check the Power BI Dashboard for Service Level Agreements (SLA) that are associated with Create blades. The  Power BI Dashboard is located at   
    [https://msit.powerbi.com/groups/4f11aaa4-1faf-4bf3-9983-1dc7351bf5b6/dashboards/d6d0161c-88ce-40c7-b255-30d127f0aa11](https://msit.powerbi.com/groups/4f11aaa4-1faf-4bf3-9983-1dc7351bf5b6/dashboards/d6d0161c-88ce-40c7-b255-30d127f0aa11).

    If the success rate drops by 5% during a rolling 24-hour period that contains at least 50 Creates, a sev 2 incident will be filed. 

    This applies to every error that causes Creates to fail when the `Create` button is clicked.

## Resource move 

   Remember to follow the guidelines in [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).