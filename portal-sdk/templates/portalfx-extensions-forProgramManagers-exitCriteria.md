
<a name="portalfxExtensionsForProgramManagersExitCriteria"></a>
<!-- link to this document is [portalfx-extensions-forProgramManagers-exitCriteria.md]()
-->

## Exit Criteria and Quality Metrics

In order to meet customer expectations and continue to increase customer satisfaction, the following quality metrics are tracked for every extension:
1.	Performance

    The Weighted Experience Score (WxP) determines the percentage of blade usage that meets the performance bar. The metrics for all blades within an extension are combined into the WxP, which requires a passing score of greater than 80. Meeting the performance bar is a requirement for public preview or Global Availability (GA).

    MPAC and PROD performance are included in weekly status emails and each team is expected to investigate regressions.

1.	Reliability

    Every extension, blade, and part must meet the reliability Service Level Agreement (SLA). Reliability Metrics for Extensions, resource blades, and Create blades must be met before the extension will be enabled in PROD. Extensions must be enabled in MPAC to start tracking reliability. Meeting the reliability bar is a requirement for public preview or GA.

    MPAC and PROD reliability is included in weekly status emails and each team is expected to investigate regressions.

1.	Usability

    Each service must define the critical P0 scenarios for their business. These scenarios must be usability tested to ensure an 80% success rate and an 80% experience score, based on a short survey. Usability must be measured by testing with at least 10 participants.

1.	Accessibility

    Accessibility is currently a non-blocking requirement, but it will change to a blocking requirement in the calendar year 2017. Every service must meet the Microsoft standards for accessibility for their critical P0 scenarios, similar to the usability bar. Teams within C+E should work with their Accessibility team to verify accessibility. 
    
    For more information about accessibility, see [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-accessibility.md](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-accessibility.md).
    
1.	Success

     The success of an extension is combined of several factors, the most important of which is customer satisfaction. In order to ensure that every customer has a great customer experience, the extension should be within the create success rate.  When the extension meets or exceeds those factors, it is eligible for the for public preview or GA. It is important to meet the success rate previous to moving the extension to the next phase, because various phases are used in association with  service level agreements and other items that are affected if an extension does not work.  For example, blades with a success rate below 99% will result in sev 2 incidents.

     Create success rates are a non-blocking requirement, but opting into applicable validation is required for preview/GA for ARM-based services.

    Services that use ARM template deployment must opt in to RP registration checks, deployment validation, and required permission checks to avoid common issues and help improve your success rates.

    Extensions/RPs are responsible for validating all inputs to ensure the Create isn't submitted unless that Create will be successful. This applies to all services, whether using ARM or not.
    
    For more information about creating success, see [http://aka.ms/portalfx/create#validation](http://aka.ms/portalfx/create#validation).

1.	Resource move

    Resource move is only for ARM subscription-based services. ARM-based services must allow customers to move resources between subscriptions and resource groups.

    For more information on resource moves, see the following resources.
    * Documentation 
        
        [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-resourcemove.md](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-resourcemove.md)
	
    *	Dashboard
        
        [http://aka.ms/portalfx/resourcemove/dashboard](http://aka.ms/portalfx/resourcemove/dashboard)


More information on metrics is located at [Exit Criteria and Quality Metrics for Developers](portalfx-extensions-forDevelopers-exitCriteria.md).