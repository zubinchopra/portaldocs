## Customer experience metrics tracked for Public preview or Global Availability

Every new extension provides an opportunity for the Azure portal to improve the customer experience. By using set criteria to meet customer expectations, we can improve the customer experience for the extension and overall portal. Extension developers can improve the customer experience of Azure portal by ensuring that their extension meets the following criteria prior to enabling the extension for Public preview or Global Availability. 

These customer experience metrics are tracked by Azure portal team and are reported to the VP sponsoring your extension through a weekly status email. Also, these metrics are reported as part of weekly S360 meeting, an executive review meeting. Any extension that does not meet the criteria listed in customer experience metrics is required to justify to the executives the reason for poor customer experience.

Here is a list of the customer experience metrics tracked for Public preview or Global Availability

1. **Usability**

Usability is about making your extension as user-friendly as possible. Since partners understand the businss context of their services, we ask our partners to define the critical P0 scenarios for their extension. P0 scenarios are the most important scenrios in your extension. Without executing these scenarios, customer cannot provision or manage their resources through your extension. 

Once you have identified the P0 scenrios, we ask you to recruit 10 candidates for the usability study. This group of candidates should represent the potential customers for your service. In order to organize the usability study or to request for help with recruiting candidates, you can reach out to [Joe Hallock and Mariah Jackson](mailto:ibiza-usability@microsoft.com?subject=Azure%20portal%20Usability).

NOTE: Organizing a usability study can take up to 3 months so please start the process as soon as possible.

During the usability study we ask the candidates to execute the taks on the service that will require them to execute P0 scenarios. 

Public Preview success criteria:

A usability success rate of 70% qualifies your extension for public preview i.e. 7 out of 10 candidates were able to execute the tasks.

Global Availability success criteria:

A usability success rate of 80% qualifies your extension for global availability  i.e. 8 out of 10 candidates were able to execute the tasks.

2. **Accessibility**

<!-- TODO: Product Backlog Item 1849649: Update the exit criteria for Accessibility and Localization  -->

Accessibility is about making the portal usable by people who have limitations that prevent or impede the use of conventional user interfaces. Microsoft requires all blocking accessibility issues to be addressed. Moreover, in some situations such as goverment contracts, accessibility requirements are imposed by law. 

Azure portal framework has taken an inclusive design approach in incorporating keyboard, programmatic, and visual design support throughout the portal. You are responsible for ensuring that any graphics, styling, and custom HTML you include in your design is accessible.

Public Preview success criteria:

Please reach out to [Paymon Parsadmehr and Erica Mohler](mailto:ibiza-accessibility@microsoft.com?subject=Azure%20portal%Accessibility) to schedule vendor testing for your extension. After scheduling the vendor testing, extensions will be signed off for public preview 

Global availability success criteria: 

1. Every service must meet the [MAS accessibility standards](https://www.1eswiki.com/wiki/Trusted_Tester_with_Keros#Full_MAS_compliance_assessment) for all scenarios.

2. Vendor testing scheduled at the time of public preview should be completed prior to global availability for all extension scenarios. Once your have resolved all the issues please assign them back to vendor team for regress testing.
If you identify any issues with the framework, please assign them to [Paymon Parsadmehr]. Once regress testing is complete,vendor team will send sign off to the accessibility team. At this point extension is signed-off for global availability.

**NOTE**: Accessibility is a blocking requirement for global availability.

For more information about accessibility, see [portalfx-accessibility.md](portalfx-accessibility.md).
    
3. **Create Success Rate**

<!-- TODO: Product Backlog Item 1850312: Update the exit criteria for Create Success Rate and Resource move-->

The success of an extension is combined of several factors, the most important of which is customer satisfaction. In order to ensure that every customer has a great customer experience, the extension should be within the create success rate.   The create success rate is defined as the number of times the UX completes the generation process when the create button is clicked. When the extension meets or exceeds those factors, it is eligible for public preview or Global Availability.
     
Extensions and Resource Providers (RPs) are responsible for validating all inputs to ensure the Create is not submitted unless that Create will be successful. This applies to all services.

Services that use ARM template deployment and other ARM-based services should also validate resource provider registration, permissions, and deployment to avoid common issues and improve extension success rates. Validating against some factors is required for the preview and GA phases.

Check the Power BI Dashboard for Service Level Agreements (SLA) that are associated with Creating extensions. The Ibiza Extension Perf/Reliability/Usage Dashboard is located at [aka.ms/ibizaperformance](aka.ms/ibizaperformance).

It is important to meet the success rate previous to moving the extension to the next phase, because various phases are associated with service level agreements and other items that are affected if an extension does not work.  For example, extensions with a success rate below 99% will result in sev 2 incidents. Also, if the success rate drops by 5% during a rolling 24-hour period that contains at least 50 Creates, a sev 2 incident will be filed. This applies to every error that causes Creates to fail when the `Create` button is clicked.

Success rates are a non-blocking requirement.  Some exceptions can be granted to move an extension from the private preview stage to the public preview stage, but in general, the overall customer experience is reduced.
   
For more information about creating success, see [portalfx-create.md#validation](portalfx-create.md#validation).

4. **Resource move**

<!-- TODO: Product Backlog Item 1850312: Update the exit criteria for Create Success Rate and Resource move-->

ARM-based services allow customers to move resources between subscriptions and resource groups.

For more information on resource moves, see the following resources.
    
* Documentation 

    [portalfx-resourcemove.md](portalfx-resourcemove.md)
	
* Dashboard
        
    [http://aka.ms/portalfx/resourcemove/dashboard](http://aka.ms/portalfx/resourcemove/dashboard)

5. **Performance**

<!-- TODO: Product Backlog Item 1850307: Update the exit criteria for Reliability and Performance -->

The Weighted Experience Score (WxP) determines the percentage of blade usage that meets the performance bar. The metrics for all blades within an extension are combined into the WxP, which requires a passing score of greater than 80. Meeting the performance bar is a requirement for public preview or Global Availability (GA).

MPAC and PROD performance are included in weekly status emails and each extension is expected to investigate regressions.

For more information about the Weighted Experience Score, see  [portalfx-performance.md#wxp-score](portalfx-performance.md#wxp-score).

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

### Reliability

<!-- TODO: Product Backlog Item 1850307: Update the exit criteria for Reliability and Performance -->

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

### **Localization**

<!-- TODO: Product Backlog Item 1849649: Update the exit criteria for Accessibility and Localization  -->

* For onboarding localization, please reach out to [Bruno Lewin](mailto:ibiza-interntnl@microsoft.com)

Nearly 70% of Azure users are from outside of the United States. Therefore, it is important to make Azure a globalized product.
There are a few requirements under the "Internationalization" criteria that your service is required to support.  This is the same set of languages that are supported by Azure Portal for GA. Learn more about [internationalization requirements](http://aka.ms/azureintlrequirements).
