
<a name="onboarding"></a>
# Onboarding
<a name="azure-portal-onboarding"></a>
# Azure Portal Onboarding

<a name="azure-portal-onboarding-start-onboarding"></a>
## Start Onboarding

* For onboarding a **first-party extension** i.e. an extension  in Azure Portal, please email with following information to:

Stakeholders: [Leon Welicki, Adam Abdelhamed, Amit Modi](mailto:ibiza-onboading-kick@microsoft.com?subject=Azure%20portal%20onboarding)

    * Is your service targeting public Azure, on-prem, or both?
    * Service name
    * VP, PM, and engineering owners
    * Timelines (preview, GA)
    * Summary of the service and target scenarios

* For onboarding a **third-party extension** i.e. you are an external partner, please email with following information to:

Stakeholders: [Leon Welicki, Adam Abdelhamed](mailto:ibiza-onboading-kick@microsoft.com?subject=Azure%20portal%20onboarding)

    * Is your service targeting public Azure, on-prem, or both?
    * Service name
    * Summary of the service and target scenarios

Most extensions have been successful by setting up early design review with Azure portal team. This gives extension owners an opportunity to understand how they can leverage Azure portal's design patterns in their extension.

feasible.
<a name="azure-portal-onboarding-subscribe-to-announcements"></a>
## Subscribe to announcements

Extension developers and program managers can stay upto date on product roadmap , latest features and workshop announcements by subscribing  to follwing DLs:

* PMs should join [ibizapartners-pm](http://igroup/join/ibizapartners-pm)
* Devs should join [ibizapartners-dev](http://igroup/join/ibizapartners-dev)
* To learn about upcoming breaking changes, join [ibizabreak](http://igroup/join/ibizabreak)

<a name="azure-portal-onboarding-ask-questions-on-stackoverflow-ms-https-stackoverflow-microsoft-com"></a>
## Ask questions on <a href="https://stackoverflow.microsoft.com">Stackoverflow@MS</a>

Join the extension developer community on [Stackoverflow@MS](https://stackoverflow.microsoft.com)  and let us know if you have any questions. Don't forget to tag questions with "ibiza" or [related](portalfx-stackoverflow.md) tags.

<a name="azure-portal-onboarding-learn-from-samples"></a>
## Learn from Samples

1. Explore samples in Dogfood environment:

We understand that the best way to learn extension development is by looking at the code so Azure portal team ships samples that extension developers can leverage .

First-party extension developers i.e. Microsoft employees have access to Dogfood environment so they can browse thorugh the [samples](http://aka.ms/portalfx/samples#blade/SamplesExtension/SDKBlade) in DOGFOOD environment.

Both First-party and Third-party extension developers can install and run samples extension on their local machine.


7. **[Side-load your extension for local testing](/portal-sdk/generated/index-portalfx-extension-development.md#debugging-testing-in-production)**

   Side-loading allows you to test and debug your extension locally against any environment. This is the preferred method of testing.

9. **Marketplace integration**

   At a high level, each icon you see in the Azure Portal Marketplace is referred to as a Gallery item. Gallery items
   take the form of a file with the .azpkg extension. You can think of this file as a zip which contains all assets for
   your gallery item: icons, screenshots, descriptions.

   **PROD**: The Marketplace team accepts fully finished .azkpg files from your team and performs upload to Production <a HREF="mailto:1store@microsoft.com?subject=Marketplace Onboarding Request&body=Attach your *.azpkg to this email, fill in the replacements and send.%0A%0AHi 1store, I would like to onboard the attached package to Prod. %0A%0AIn addition to the Marketplace I &lt;do/don't&gt; want to be included in the '+' New flyout experience">Click to request 1store onboarding</a> your gallery package.

   **DOGFOOD**: Use AzureGallery.exe to upload items to DOGFOOD using the following command:

   `AzureGallery.exe upload -p ..\path\to\package.azpkg -h [optional hide key]`

   In order to use the gallery loader you will need to set some values in the AzureGallery.exe.config file for details see [AzureGallery.exe docs](../../gallery-sdk/generated/index-gallery.md#gallery-item-specificiations). For dev/test scenarios see [Test In Prod](../../gallery-sdk/generated/index-gallery.md##gallery-package-development-and-debugging-testing-in-production)

1. **Recommended patterns**

   The following patterns are recommended for every extension based on customer feedback and usability studies, but are
   not required:

   - **Menu blade**

     All services should use the menu blade instead of the Settings blade. ARM resources should opt in to the resource
     menu for a simpler, streamlined menu.

     See also:
     - [#ibiza-blades-parts on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-blades-parts) for menu blade questions
     - [#ibiza-resources on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-resources) for resource menu questions
     - [Ask a menu blade question](https://stackoverflow.microsoft.com/questions/ask?tags=ibiza-blades-parts)
     - [Ask a resource menu question](https://stackoverflow.microsoft.com/questions/ask?tags=ibiza-resources)

   - **Activity logs** (Stakeholder: [Rajesh Ramabathiran](mailto:ibiza-activity-logs@microsoft.com))

      Activity/event/operation/audit logs should be available from the menu for all services. Subscription-based
      resources (not just tracked resources) get this for free when implementing the resource menu. All other services
      should add the equivalent experience for their service.

   - **Create blades**

     All Create blades should be a single blade. **Do not use wizards or picker blades.** Use form sections and
     dropdowns. Subscription-based resources should use the built-in subscription, resource group, location, and
     pricing dropdowns; especially in Create blades. These each cover common scenarios that will save time and avoid
     deployment failures. The subscription, resource group, and location picker blades have been deprecated.

     Every service should also expose a way to get scripts to automate provisioning. Automation options should include
     CLI, PowerShell, .NET, Java, Node, Python, Ruby, PHP, and REST (in that order). ARM-based services that use
     template deployment are opted in by default.

     See also:
     - [Create documentation](/portal-sdk/generated/index-portalfx-extension-development.md#common-scenarios-building-create-experiences)
     - [#ibiza-create on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-create)
     - [Ask a question](https://stackoverflow.microsoft.com/questions/ask?tags=ibiza-create)

   - **Browse (resource list) blades**

      All Browse blades should have:
      - "Add" command to help customers create new resources quickly
      - Context menu commands in the "..." menu for each row
      - Show all resource properties in the column chooser

      See also:
      - [Browse documentation](portalfx-browse.md)
      - [Asset documentation](portalfx-assets.md)
      - [#ibiza-browse on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-browse)
      - [Ask a question](https://stackoverflow.microsoft.com/questions/ask?tags=ibiza-browse)

   - **Export template / RP schema**

     ARM RPs must provide a schema for all tracked and nested resource types to ensure they support the export template
     capability. Export template is enabled by default from the resource menu.

     See also:
     - [RP schema documentation](http://aka.ms/rpschema)

0. **Register your extension**

   Once your service name is finalized, request to have your extension registered in all environments. Once deployed to
   DOGFOOD (aka DF), contact the Fx team to request that it be enabled (if applicable). Your extension will be enabled
   in production once all exit criteria have been met.

   Extension names must use standard extension name format: `Company_BrandOrSuite_ProductOrComponent` 
   (e.g. `Contoso_Azure_{extension}` or `Microsoft_Azure_{extension}`). Set the extension name in `extension.pdl` as
   follows:

   `<Extension Name="Company_BrandOrSuite_ProductOrComponent" Preview="true">`

   Extension URLs must use a standard CNAME pattern. Create CNAMEs using
   [Microsoft's DNS](http://msinterface/form.aspx?ID=4260) (use any Azure property as the identity).

   | Environment     | URL |
   | --------------- | ----- |
   | **DOGFOOD**     | `df.{extension}.onecloud-ext.azure-test.net` |
   | **PROD**        | `main.{extension}.ext.azure.com` |
   | **BLACKFOREST** | `main.{extension}.ext.microsoftazure.de` |
   | **FAIRFAX**     | `main.{extension}.ext.azure.us` |
   | **MOONCAKE**    | `main.{extension}.ext.azure.cn` |

   Use a wildcard SSL cert for each environment to simplify maintenance (e.g. `*.{extension}.onecloud-ext.azure-test.net`
   or `*.{extension}.ext.azure.com`). If your team is building separate, independent extensions, you can also use
   `{extension}.{team}.ext.azure.com` and create a wildcard SSL cert for `*.{team}.ext.azure.com` to simplify overall
   management. Internal teams can create SSL certs for DF using [http://ssladmin](http://ssladmin). Production certs
   must follow your organizations PROD cert process -- **do not use SSL Admin for production certs**.

   **NOTE** : Registering an extension in Portal requires deployment so it can take almost 10 days. Please plan accordingly.

   [Request to register your extension (internal only)](https://aka.ms/portalfx/newextension) and email the work item id
   to [ibizafxpm](mailto:ibizafxpm@microsoft.com?subject=Register%20extension). You'll automatically be notified when the
   configuration change is pushed to PROD. External teams can
   <a href="mailto:ibizafxpm@microsoft.com?subject=[Onboarding Request] Add &lt;Name&gt; extension to the portal&body=Extension name:  Company_[BrandOrSuite_]ProductOrComponent (e.g. Contoso_SomeSku_SomeProduct or Contoso_SomeProduct)%0A%0AURLs  (must adhere to pattern)%0APROD-- main.&lt;extension&gt;.ext.contoso.com%0A%0AContact info%0ABusiness Contacts:_________%0ADev leads: _________%0APROD on-call email: _________%0A">submit their request via email</a>.

1. **[Exit criteria + quality metrics](portalfx-onboarding-exitcriteria.md)**

   Every extension must meet required exit criteria / quality metrics before it will be enabled.

For any other questions, don’t hesitate to ask us on [https://stackoverflow.microsoft.com](https://stackoverflow.microsoft.com).

* [Onboarding](#onboarding)
* [Azure Portal Onboarding](#azure-portal-onboarding)
    * [Start Onboarding](#azure-portal-onboarding-start-onboarding)
    * [Subscribe to announcements](#azure-portal-onboarding-subscribe-to-announcements)
    * [Ask questions on [Stackoverflow@MS](https://stackoverflow.microsoft.com)](#azure-portal-onboarding-ask-questions-on-stackoverflow-ms-https-stackoverflow-microsoft-com)
    * [Learn from Samples](#azure-portal-onboarding-learn-from-samples)
    * [Exit criteria & quality metrics](#azure-portal-onboarding-exit-criteria-quality-metrics)
        * [Performance (Stakeholder: [Sean Watson](mailto:ibiza-perf@microsoft.com))](#azure-portal-onboarding-exit-criteria-quality-metrics-performance-stakeholder-sean-watson-mailto-ibiza-perf-microsoft-com)
        * [Reliability (Stakeholder: [Sean Watson](mailto:ibiza-reliability@microsoft.com))](#azure-portal-onboarding-exit-criteria-quality-metrics-reliability-stakeholder-sean-watson-mailto-ibiza-reliability-microsoft-com)
        * [Usability (Stakeholder: [Angela Moulden](ibiza-usability@microsoft.com))](#azure-portal-onboarding-exit-criteria-quality-metrics-usability-stakeholder-angela-moulden-ibiza-usability-microsoft-com)
        * [Accessibility (Stakeholder: [Paymon Parsadmehr](ibiza-accessibility@microsoft.com))](#azure-portal-onboarding-exit-criteria-quality-metrics-accessibility-stakeholder-paymon-parsadmehr-ibiza-accessibility-microsoft-com)
        * [Create success (Stakeholder: [Paymon Parsadmehr](mailto:ibiza-create@microsoft.com))](#azure-portal-onboarding-exit-criteria-quality-metrics-create-success-stakeholder-paymon-parsadmehr-mailto-ibiza-create-microsoft-com)
        * [Resource move (Stakeholder: [Edison Park](mailto:ibiza-resourceMove@microsoft.com))](#azure-portal-onboarding-exit-criteria-quality-metrics-resource-move-stakeholder-edison-park-mailto-ibiza-resourcemove-microsoft-com)
    * [Leveraging Ibiza's alerts to provide great customer experience](#azure-portal-onboarding-leveraging-ibiza-s-alerts-to-provide-great-customer-experience)


<a name="azure-portal-onboarding-exit-criteria-quality-metrics"></a>
## Exit criteria &amp; quality metrics

In order to meet customer expectations and continue to increase customer satisfaction, the following quality metrics
are tracked for every extension:

1. Performance
2. Reliability
3. Usability
4. Accessibility
5. Create success
6. Resource move (ARM subscription-based services only)



<a name="azure-portal-onboarding-exit-criteria-quality-metrics-performance-stakeholder-sean-watson-mailto-ibiza-perf-microsoft-com"></a>
### Performance (Stakeholder: <a href="mailto:ibiza-perf@microsoft.com">Sean Watson</a>)

**All blades must meet the required blade reveal time of < 4 seconds for the 80th percentile and < 8 seconds for the 95th percentile** before being enabled in PROD. Extensions must be enabled in MPAC (the internal environment) to start tracking performance. 
Resource and Create blades are tracked explicitly. 
All blades are rolled up into **Weighted Experience Score (WxP), which must be > 80**. WxP
determines the percentage of blade usage that meets the performance bar.

Blade reveal time is the time it takes for all the parts above to fold to call revealContent() (load 1st level data)
or to resolve `onInputSet()` promises, whichever is earlier.

MPAC and PROD performance is included in weekly status emails and each team is expected to investigate regressions.

> Meeting the performance bar is a requirement for public preview or GA.

**We require roughly 100+ loads of your experience (extension/blade/tiles) to get a signal, if you are unable to generate that traffic genuinely in your desired timeframe please hold a bug bash to drive up the traffic. Ensure your URL does not include feature.canmodifyextensions**

To calculate your performance/reliability use [the following query:](https://aka.ms/portalfx/perfsignoff)

```
// First parameter startDate
// Second parameter timeSpan
// Third parameter includeTestTraffic - set this to `false` if you are already in public preview
GetExtensionPerfReliability(now(),7d,true) 
| where extension == "YOUR_EXTENSION_NAME"
```

If any of your performance numbers are below the bar please investigate and resolve the related issues.

See also:
- [Dashboard - latest geninue traffic only](http://aka.ms/portalfx/dashboard/extensionperf)
    - [Telemetry Access](http://aka.ms/portalfx/docs/telemetryaccess) for access
- [Checklist](/portal-sdk/generated/index-portalfx-extension-monitor.md#performance-checklist)
- [Portal COP](/portal-sdk/generated/index-portalfx-extension-monitor.md#portalcop)
- [Best pracitces](/portal-sdk/generated/index-portalfx-extension-monitor.md#performance-best-practices)
- [#ibiza-performance on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-performance)
- [Ask a question](https://stackoverflow.microsoft.com/questions/ask?tags=ibiza-performance)


<a name="azure-portal-onboarding-exit-criteria-quality-metrics-reliability-stakeholder-sean-watson-mailto-ibiza-reliability-microsoft-com"></a>
### Reliability (Stakeholder: <a href="mailto:ibiza-reliability@microsoft.com">Sean Watson</a>)

Every extension, blade, and part must meet the **reliability SLA (> 99.9)**. Extension, resource blade, and Create blade
reliability metrics must be met before your extension will be enabled in PROD. Extensions must be enabled in MPAC to
start tracking reliability.

MPAC and PROD reliability is included in weekly status emails and each team is expected to investigate regressions.

> Meeting the reliability bar is a requirement for public preview or GA.

**We require roughly 100+ loads of your experience (extension/blade/tiles) to get a signal, if you are unable to generate that traffic genuinely in your desired timeframe please hold a bug bash to drive up the traffic. Ensure your URL does not include feature.canmodifyextensions**

To calculate your performance/reliability use [the following query:](https://aka.ms/portalfx/perfsignoff)

```
// First parameter startDate
// Second parameter timeSpan
// Third parameter includeTestTraffic - set this to `false` if you are already in public preview
GetExtensionPerfReliability(now(),7d,true) 
| where extension == "YOUR_EXTENSION_NAME"
```

If any of your reliability numbers are below the bar please investigate and resolve the related issues.

See also:
- [Dashboard - latest geninue traffic only](http://aka.ms/portalfx/dashboard/extensionperf)
    - [Telemetry Access](http://aka.ms/portalfx/docs/telemetryaccess) for access
- [#ibiza-reliability on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-reliability)
- [Ask a question](https://stackoverflow.microsoft.com/questions/ask?tags=ibiza-reliability)


<a name="azure-portal-onboarding-exit-criteria-quality-metrics-usability-stakeholder-angela-moulden-ibiza-usability-microsoft-com"></a>
### Usability (Stakeholder: <a href="ibiza-usability@microsoft.com">Angela Moulden</a>)

Each service must define the critical, P0 scenarios for their business. These scenarios must be usability tested to
ensure 80% success rate and an 80% experience score (based on a short survey). Usability must be measured by testing
with at least 10 participants.


<a name="azure-portal-onboarding-exit-criteria-quality-metrics-accessibility-stakeholder-paymon-parsadmehr-ibiza-accessibility-microsoft-com"></a>
### Accessibility (Stakeholder: <a href="ibiza-accessibility@microsoft.com">Paymon Parsadmehr</a>)

Similar to the usability bar, every service must meet the Microsoft standards for accessibility for their critical, P0
scenarios. Teams within C+E should work with the C+E Accessibility team to verify accessibility.

_**NOTE:** Accessibility is a **non-blocking** requirement today, but it will be blocking in CY2017._

- [Accessibility documentation](/portal-sdk/generated/index-portalfx-extension-accessibility.md)
- [#ibiza-accessibility on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-accessibility)
- [Ask a question](https://stackoverflow.microsoft.com/questions/ask?tags=ibiza-accessibility)


<a name="azure-portal-onboarding-exit-criteria-quality-metrics-create-success-stakeholder-paymon-parsadmehr-mailto-ibiza-create-microsoft-com"></a>
### Create success (Stakeholder: <a href="mailto:ibiza-create@microsoft.com">Paymon Parsadmehr</a>)

Every Create blade must meet the create success rate. For Create SLA check the Power BI Dashboard. If success drops 5% on a rolling 24h period with 50+ Creates, a
sev 2 incident will be filed. This covers every error that causes Creates to fail after the user clicks the Create
button. Extensions/RPs are responsible for validating all inputs to ensure the Create isn't submitted unless that
Create will be successful. This applies to all services, whether using ARM or not.

Services that use ARM template deployment must opt in to [RP registration checks, deployment validation, and required
permission checks](http://aka.ms/portalfx/create#validation) to avoid common issues and help improve your success rates.

_**NOTE:** Create success rates are a **non-blocking** requirement, but opting into applicable validation is required
for preview/GA (for ARM-based services). Any blades with a success rate below 99% will result in sev 2 incidents based
on the above logic._

See also:
- [Create validation](http://aka.ms/portalfx/create#validation)
- [#ibiza-create on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-create)
- [Ask a question](https://stackoverflow.microsoft.com/questions/ask?tags=ibiza-create)


<a name="azure-portal-onboarding-exit-criteria-quality-metrics-resource-move-stakeholder-edison-park-mailto-ibiza-resourcemove-microsoft-com"></a>
### Resource move (Stakeholder: <a href="mailto:ibiza-resourceMove@microsoft.com">Edison Park</a>)

ARM-based services must allow customers to move resources between subscriptions and resource groups.

See also:
- [Documentation](portalfx-resourcemove.md)
- [Dashboard](http://aka.ms/portalfx/resourcemove/dashboard)
- [#ibiza-resources on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-resources)
- [Ask a question](https://stackoverflow.microsoft.com/questions/ask?tags=ibiza-resources)

<a name="azure-portal-onboarding-leveraging-ibiza-s-alerts-to-provide-great-customer-experience"></a>
## Leveraging Ibiza&#39;s alerts to provide great customer experience

1. SDK Age alerts
1. Extension Availability Alerts
1. Create Alerts
1. Hosting Servie Alerts


