
<a name="portalfxExtensionsForProgramManagersExitCriteria"></a>
<!-- link to this document is [portalfx-extensions-forProgramManagers-exitCriteria.md]()
-->

## Exit Criteria and Quality Metrics

In order to meet customer expectations and continue to increase customer satisfaction, there are quality metrics that are tracked for every extension. There are metrics for every extension, blade, and part.  These metrics help developers build extensions that compile, that contain the items that are requested by the partners of the developer, and that pass acceptance tests that are created by the partners that are associated with a specific phase. Some exceptions can be granted to move an extension from the private preview stage to the public preview stage, but in general, the overall customer experience is reduced.

The quality metrics that are tracked are as follows.
<!-- TODO:  Each of the following sections should have a "for more information" link, like maybe an external link -->

1.	Performance

    The Weighted Experience Score (WxP) determines the percentage of blade usage that meets the performance bar. The metrics for all blades within an extension are combined into the WxP, which requires a passing score of greater than 80. Meeting the performance bar is a requirement for public preview or Global Availability (GA).

    MPAC and PROD performance are included in weekly status emails and each team is expected to investigate regressions.

    <!-- TODO:  Is there a link to information about the Weighted Experience Score (WxP)?? -->

1.	Reliability

    Every extension meets the reliability Service Level Agreement (SLA). There are some reliability metrics should be met previous to enabling the extension in the production environment; however, extensions must be enabled in MPAC in order to start tracking reliability. Meeting the reliability bar is a requirement for public preview or GA.

    MPAC and PROD reliability is included in weekly status emails and each team is expected to investigate regressions.

    <!-- TODO:  Is there a link to information about the weekly status email for MPAC and PROD reliability?? -->
1.	Usability

    Each service or extension defines the critical P0 scenarios for their business. The extension is tested using these usability scenarios, with at least ten participants. A  success rate of 80% and an experience score of 80% are required for a passing usability score.

    <!-- TODO:  For more information on how to define scenarios, see   -->
1.	Accessibility

    The accessibility bar is similar to the usability bar, and every service must meet the accessibility standards that are tested in their critical P0 scenarios. C+E teams should work with their own Accessibility teams. 
    
    For more information about accessibility, see [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-accessibility.md](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/index-portalfx-extension-accessibility.md).
    
1.	Success
    
    The success of an extension is combined of several factors, the most important of which is customer satisfaction. In order to ensure that every customer has a great customer experience, the extension should be within the create success rate.  When the extension meets or exceeds those factors, it is eligible for public preview or Global Availability. The success rate is defined as the number of times the UX completes the generation process when the create button is clicked.
     
    Extensions and Resource Providers (RPs) should validate all inputs to ensure that the extension is not submitted for the next phase unless the creation of that extension will be successful. This applies to all services.

    Services that use ARM template deployment and other ARM-based services should also validate resource provider registration, permissions, and deployment to avoid common issues and improve extension success rates. Validating against some factors is required for the preview and GA phases.

    It is important to meet the success rate previous to moving the extension to the next phase, because various phases are associated with service level agreements and other items that are affected if an extension does not work.  For example, blades with a success rate below 99% will result in sev 2 incidents.

    Success rates are a non-blocking requirement.  Some exceptions can be granted to move an extension from the private preview stage to the public preview stage, but in general, the overall customer experience is reduced.
   
    For more information about creating success, see [http://aka.ms/portalfx/create.md#validation](http://aka.ms/portalfx/create.md#validation).
<!-- TODO:  portalfx-create.md has a section named Validation, but it does not have a link.     -->

## Resource move

ARM-based services allow customers to move resources between subscriptions and resource groups.

For more information on resource moves, see the following resources.
    
* Documentation 

    [portalfx-resourcemove.md](portalfx-resourcemove.md)
	
* Dashboard
        
    [http://aka.ms/portalfx/resourcemove/dashboard](http://aka.ms/portalfx/resourcemove/dashboard)

More information on exit criteria and quality metrics for developers is located at [portalfx-extensions-forDevelopers-exitCriteria.md](portalfx-extensions-forDevelopers-exitCriteria.md).