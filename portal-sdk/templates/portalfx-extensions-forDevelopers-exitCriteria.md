<a name="portalfxExtensionsForDevelopersExitCriteria"></a>
<!-- link to this document is [portalfx-extensions-forDevelopers-exitCriteria.md]()
-->

## Exit Criteria and Quality Metrics for Developers

There are criteria that must be met for an extension to be moved from the private preview stage to the public preview stage.  In addition, there are also criteria that an extension must meet previous to being moved from the public preview stage to GA.

Basic information on metrics is located at  [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).

A developer must also be aware of the following conditions.

1. Performance

    All blades must meet the required blade reveal time of < 4 seconds for the 80th percentile before being enabled in PROD. Extensions must be enabled in MPAC to start tracking performance. Resource and Create blades are tracked explicitly. 

    Blade reveal time is the time it takes for all the parts above to fold to call revealContent() (load 1st level data) or to resolve onInputSet() promises, whichever is earlier.

    <!-- > is this associated with the MPAC or PROD teams? <-->
    We require roughly 100+ loads of your experience (extension/blade/tiles) to get a signal, if you are unable to generate that traffic genuinely in your desired timeframe please hold a bug bash to drive up the traffic.

    For more information, see the following resources:
    * Dashboard 

        [http://aka.ms/portalfx/dashboard/extensionperf](http://aka.ms/portalfx/dashboard/extensionperf)

        * Telemetry Access for access 
        
            [http://aka.ms/portalfx/docs/telemetryaccess](http://aka.ms/portalfx/docs/telemetryaccess)


    *	Checklist

        [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-monitor.md#performance-checklist](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-monitor.md#performance-checklist)

    *	Portal COP (Telemetry)

        [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-monitor.md#portalcop](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-monitor.md#portalcop)

        

1. Reliability
    <!-- > is this associated with the MPAC or PROD teams? <-->
    We require roughly 100+ loads of your experience (extension/blade/tiles) to get a signal, if you are unable to generate that traffic genuinely in your desired timeframe please hold a bug bash to drive up the traffic.

1. Usability

   Remember to follow the guidelines in [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).

1. Accessibility

   Remember to follow the guidelines in [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).

1. Create success

    For Create SLA check the Power BI Dashboard. If success drops 5% on a rolling 24h period with 50+ Creates, a sev 2 incident will be filed. This covers every error that causes Creates to fail after the user clicks the Create button.

1. Resource move 

   Remember to follow the guidelines in [portalfx-extensions-forProgramManagers-exitCriteria.md](portalfx-extensions-forProgramManagers-exitCriteria.md).