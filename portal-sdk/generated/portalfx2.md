<a name="home"></a>
# Home
<!--TODO
This document currently contains the links from the following index documents
portalfx.md
portalfx-main.md
The previous documents can be deprecated, regardless of whether the links in the TODO sections are completely rewritten or organized.
-->
This is the home page for all documentation related to onboarding, developing, operating, and anything else to do with owning an Azure portal extension.

* [How the Azure Documentation is Organized](readme.md) 
* [Downloads](/portal-sdk/generated/downloads.md)
* [Release Notes](/portal-sdk/generated/release-notes.md)
* [Breaking Changes](/portal-sdk/generated/breaking-changes.md)

Couldn't find what you needed? [Ask about the docs on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-bad-samples-docs).
* [Stackoverflow Tags](portalfx-extensions-stackoverflow.md)
* [Contact List](portalfx-extensions-contacts.md)

<a name="home-onboarding-a-new-extension-portalfx-extensions-onboarding-md"></a>
## Onboarding a new extension(portalfx-extensions-onboarding.md)
* [Overview / Getting Started](portalfx-extensions-onboarding-overview.md)
* [Steps that do not involve the Ibiza team (e.g. compliance, marketplace integration)](portalfx-extensions-onboarding-procedures.md#join-dls-and-request-permissions)
* [Configuring an extension](portalfx-extensions-configuration.md)
* [Manage cloud/environment specific configuration](portalfx-extensions-configuration-scenarios.md)
<!--TODO: Determine where the following documents would fit within this section or subtopic
* Domain Configuration
    * [When to use dynamic configuration](portalfx-domain-based-configuration.md#domain-based-configuration)
    * [How to use dynamic configuration](portalfx-domain-based-configuration-pattern.md#expected-design-pattern)
    * [Configuration](portalfx-dictionaryconfiguration.md)
    * [Sample for accessing dynamic configuration](portalfx-domain-based-configuration-example.md)
* [Extension Definition]
* [CustomApplicationContext]
* [Controllers]
* [Gallery package]
-->
* [Exit criteria](portalfx-extensions-exitCriteria.md)
[Ask an onboarding question on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding)

<a name="home-azure-portal-architecture"></a>
## Azure portal architecture
Learn how the framework is structured and how it is designed to run in multiple clouds / environments.
* [Architecture overview](http://needsalink)

<!--TODO: Determine where the following documents would fit within this section
 [Architecture Overview](portalfx-howitworks.md)
-->

<a name="home-what-s-new"></a>
## What&#39;s new
* [No-PDL Blades](portalfx-no-pdl-programming.md#defining-blades-and-parts-using-typescript-decorators-aka-no-pdl) - *Reduces the number of files and concepts to build UI*
* [Forms without edit scope](portalfx-editscopeless-forms.md) - *More intuitive APIs for building forms*
* [Editable Grid V2]() - *Improved APIs designed to work with new forms*
* [Extension Avialability Alerts](portalfx-telemetry-alerting.md#alerting) - *Get notified if your extension goes down*
* [Actionable Notifications]() - *Point users to well known next steps*
* [EV2 support for the Extension Hosting Service](portalfx-extensions-hosting-service-advanced.md) 
* [Multi-Column for Essentials Controls](portalfx-controls-essentials.md) - *Better use of screen real estate*
* [TreeView improvements]() - *Checkboxes, commands, and Load More / Virtualization*
<!--TODO: Determine where the following documents would fit within this section
* SDK Update alerts(Coming Soon....)
 [Notifying your customers what's new](portalfx-extension-posting-whats-new-notification.md)
-->
<a name="home-development-guide-portalfx-extensions-developerinit-md"></a>
## Development guide(portalfx-extensions-developerInit.md)
Azure portal extension development is supported on the Microsoft Windows 8, Windows Server 2012 R2, and Windows 10.
1. Install the SDK
* [Option 1 - MSI Installer](portalfx-extensions-onboarding-procedures.md#install-software)
* [Option 2 - Nuget packages](portalfx-extensions-onboarding-nuget.md)

/* remove step 2.  It has been included at the topic level */
2. Configure your IDE - *Typescript version / Compile on save* 
* [Visual Studio](portalfx-ide-setup.md) *(with Extension project template)*
* [VS Code]()

/* use this step 2 instead. It has been included at the topic level */
<a name="home-topics-in-extension-development"></a>
## Topics in Extension Development
* [Development Tutorials](portalfx-extensions-helloWorld.md)
<!--TODO: Determine where the following subtopics would fit within the helloWorld topic 
* Add a text box to your Hello World Extension
* Dock button at the bottom of your blade
* Add Menu Bar 
* Open Blade from your Hello World Extension
* Open Context pane from your Hello World Extension 
-->
<!--TODO: Determine where the following documents would fit within this section
* [Samples Extension](portalfx-extensions-samples.md)
-->


* [Feature Flags](portalfx-extensions-flags.md)
<!--TODO: Determine where the following documents would fit within this section
<a name="home-extension-lifecycle"></a>
## Extension lifecycle
* Lifecycle
* What is a Blade's/Part's API?  How is it invoked?
* How / when to go the IFrame route?

* [Program.ts / entry point]
* [Extension.pdl]
* [Is there some thing that executes when we unload the extension??]
* [Performance implications of referencing another extension]
* [ When is extension loaded / unloaded]
-->
[Ask an sdk setup question on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-sdkupdate)

<a name="home-developing-your-user-interface-ui"></a>
## Developing your user interface (UI)
<!--TODO: Determine where the following documents would fit within this section
* [Ui Concepts](portalfx-ui-concepts.md#ui-concepts)
* Cross-extension UX integration
-->
<a name="home-developing-your-user-interface-ui-blades"></a>
### Blades
The primary UI building block is a called a blade. A blade is like a page. It generally takes up the full screen, has a presence in the portal breadcrumb, and has an 'X' button to close it.
<!--TODO: Determine where the following documents would fit within this section
* [Introduction](portalfx-ui-concepts.md#ui-concepts)
-->
[Developing blades](portalfx-blades.md#blades)
<!--TODO: Determine where the following documents would fit within this subtopic 
<a name="home-developing-your-user-interface-ui-blades-developing-blades"></a>
#### Developing Blades
* [Reference "TemplateBlade/Blade" doc re: developing content for my Blade
* [Reference "Common features / behavior for Blades and Parts"
* [Reference to sections of common Blade/Part features/behaviors
* [Title/subtitle/icon]
    * Include icon in FAQ and cross-reference here
* ['container' APIs (like 'openBlade')
    * How you to choose your Container type for legacy PDL Blades?
* [CommandBar / Toolbar](portalfx-blades.md#adding-commands-to-a-templateblade)
* [Dialogs]
    * Reference "developing content area" doc
* [StatusBar]
* [Unauthorized]
* [NoData]
* ["form" API]
-->

<!--TODO: Determine where the following documents would fit within the above subtopic 
* [FrameBlade 
* [MenuBlade]
* [Resource Menu Blade]

    * Associate my Blade with an <AssetType> so it is opened from Browse
    * [Add my Blade as an entry in a Resource Blade or a Menu Blade]
        * [No-PDL](portalfx-no-pdl.md#building-a-menu-blade-using-decorators)
        * [PDL](portalfx-blades-menublade.md)
        * [FAQ]
    * When should I make my Blade pinnable?
        * Include "why no access to DOM?"
-->
[Ask a question about blades on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-blades-parts)
<a name="home-developing-your-user-interface-ui-parts"></a>
### Parts
If you want your experience to have a presence on Azure dashboards then you will want to build parts (a.k.a. tiles).
[Developing parts](portalfx-blades.md#blades)
<!--TODO: Determine where the following documents would fit within this section
* [Adding part to Part/Tile Gallery]
* [Parts]
    * Make my Blades pinnable using @Blade.Pinnable.Decorator/onPin
    * Call Fx/Pinner/pinParts from some Blade
        ◊ …even encourage partner extensions to do so
    * Add 'galleryMetadata' to my Part to make it available to users in the Part Gallery
* [Types of Parts])
    * [TemplatePart]
    * [FramePart]
    * [ButtonPart]

    * [Building a Part Gallery Part](portalfx-parts.md#how-to-integrate-your-part-into-the-part-gallery)
    * [Retiring a Part](portalfx-parts-how-to-retire.md)
    * [Redirecting a Part](portalfx-parts.md#removing-a-part-from-a-blades-default-layout)

    #### Developing my Part
    * [Reference "Common features / behavior for Blades and Parts"]
    * [Title/subtitle/icon]
    * [Activation ('onClick')]
    * ['container' APIs (like 'openBlade')]

-->
[Ask a question about parts on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-blades-parts)
<a name="home-developing-your-user-interface-ui-controls"></a>
### Controls
Any template based UI in the portal (e.g. [template blades]() or [template parts]()) can make use of a rich controls library maintained by the Ibiza team.
* [Controls overview](portalfx-controls.md)
* [Controls playground]()
<!--TODO: Determine where the following documents would fit within this section

* [Azue Storage Controls]
* [Button]
* [Checkbox]
* [Console](portalfx-controls-console.md)
* [Copyable Label]
* [Chart](portalfx-controls-chart.md)
* [Date Picker]
* [Date Polyfills]
* [Date Time Picker](portalfx-controls-datetimepicker.md)
* [Date Time Range Picker](portalfx-controls-datetimerangepicker.md)
* [Day Picker]
* [Diff Editor]
* [Editor](portalfx-controls-editor.md)
* [Docked Ballon]
* [Donut](portalfx-controls-donut.md)
* [Dropdown](portalfx-controls-dropdown.md)
    * [Migration](portalfx-controls-dropdown-migration.md)
    * [Loading Indicator](portalfx-editscopeless-forms.md#using-the-loading-indicator-for-dropdown)
* [Duration Picker]
* [Essentials](portalfx-controls-essentials.md)
* [File Download]
* [File Upload]
* [Gallery]
* [Gauges]
* [Graph](portalfx-controls-graph-nuget.md)
* [Infobox]
* [Legend]
* [List View]
* [Tree View]
* [Toolbar](portalfx-controls-toolbar.md)
* [Log Stream]
* [Map]
* [Markdown]
* [Menu]
* [Monitor Chart](portalfx-controls-monitor-chart.md)
* [Textbox](portalfx-controls-textbox.md)
    * [Textbox]
    * [Numeric Textbox]
    * [Multiline Textbox]
    * [Password Box]
    * [TextBlock]
    * [TextBlock]
* [Option Picker]
* [OAuth Button]
* [Progress Bar]
* [Query Builder]
* [Search Box]
* [Search Box]
* [Sliders]
    * [Sliders]
    * [Custom Sliders]
    * [Range Sliders]
    * [Custom Range Sliders]
* [Grid](portalfx-controls-grid.md)
    * [Data Virtualization](portalfx-data-virtualizedgriddata.md)
* [Editable Grid]
* [Spec Picker Blade](portalfx-extension-pricing-tier.md)
* [Subscription Dropdown](portalfx-create.md#subscriptions-dropdown-1)
* [Resource Group dropdown](portalfx-create.md#resource-groups-legacy-dropdown)
* [Location dropdown](portalfx-create.md#locations-legacy-dropdown)
* [Pricing Dropdown](portalfx-create.md#pricing-dropdown)

-->
[Ask a controls related question on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-controls)
<a name="home-developing-your-user-interface-ui-forms"></a>
### Forms
Many experiences require the user to fill out a form. The Ibiza controls library provides support for forms. 
* [Developing forms](portalfx-forms.md)
<!--TODO: Determine where the following documents would fit within this section

* [Building UI for Form](portalfx-forms.md#laying-out-your-ui-on-the-blade)
* [Submit Style UI]
    * [Save/ Cancel Button](portalfx-editscopeless-forms.md#other-css-classes-that-can-be-useful)
    * [Legacy Action Bar](portalfx-fxcontrols-editscope-forms.md)
* [Prompt user to Save/Discard changes](portalfx-editscopeless-forms.md#customizing-alert-on-form-close)
* [EditScopeless Forms](portalfx-editscopeless-forms.md)
* [Legacy Editscope based Forms](portalfx-forms.md)
* [Using Editscopeless controls in EditScoped Forms](portalfx-fxcontrols-editscope-forms.md)
-->


[Ask a forms related question on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-forms)
<a name="home-developing-your-user-interface-ui-common-scenarios-and-integration-points"></a>
### Common scenarios and integration points
* [Blades that __create__ or provision resources and services](portalfx-create.md)
* [Adding your resource or service into the __browse__ menu]()
* [Common UX for Azure Resource Manager (ARM) based services]()
[Ask about browse integration on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-browse)
[Ask about create scenarios on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-create)
<a name="home-developing-your-user-interface-ui-styling-and-theming"></a>
### Styling and Theming
<!--TODO: Determine where the following documents would fit within this section
portalfx-style-guide.md
-->
* [CSS Style sanitization]()
* [Adding Custom CSS]()
* [Layout classes]()
* [Typography]()
* [Iconography]()
* [Theming]()
<a name="home-developing-your-user-interface-ui-other-ui-concepts"></a>
### Other UI concepts
* [Context panes]()
* [Dialogs]()
* [Notifications]()
* [Blade opening and communication between blades](portalfx-blades-opening.md)
<!--TODO: Determine where the following documents would fit within this section
    * [Work with other teams to have other extensions call 'container.openBlade(...)' to open my Blade](portalfx-blades-opening.md#importing-the-pde-file)

    ### [Blade/Part reuse across extensions]
    * [Making Blades/Parts reusable by other extensions](portalfx-extension-sharing-pde.md)
        * [Reusing Blades/Parts from other extensions](portalfx-integrating-with-other-extensions.md)
    * [RPC](portalfx-rpc.md#remote-procedure-calls-rpc)  // TODO: Find Home
    -->
<!--TODO: Determine whether the following are still used
[Settings Blades]
* [FrameBlade/AppBlade]
* [Pinnable Blades]
* [Adding part to Part/Tile Gallery]
* [Invoking Blade/Part reuse across extensions]
* [Shairing Blade/Part across extensions]
-->
<a name="home-developing-your-user-interface-ui-loading-and-managing-data"></a>
### Loading and managing data
Since your extension is just web code, you can make AJAX calls to various backend services to load data into your UI. The framework provides a data library you can use to manage this data.
* [Making authenticated calls to Azure Resource Manager (ARM)](portalfx-data.md#making-authenticated-ajax-calls)
* [Data Context, data views, and data caches](portalfx-data.md)
* [Auto-refreshing client data](portalfx-data-refreshingdata.md#auto-refreshing-client-side-data-aka-polling)
* [Shaping and filtering data](portalfx-data-projections.md) 
* [Adressing Data Merge Failures](portalfx-data.md#data-merging)
* [Legacy accessing C# model objects](portalfx-data-typemetadata.md#type-metadata)
* [Legacy Data Atomization](portalfx-data-atomization.md#data-atomization)
[Ask about data management on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-data-caching)
<!--TODO: Determine where the following documents would fit within this section
* Making Ajax calls to ARM and ARM APIs
    * [Authentication](portalfx-authentication.md#calling-arm)
    
-->


<!--TODO: Determine where the following documents would fit within this section
* [Debugging](portalfx-extensions-debugging.md#debugging)
-->


<a name="home-testing"></a>
## Testing
The Ibiza team provides limited testing support. Due to resource constraints the C# and Node.js framework is open source. This is so that partners can unblock themselves in case the Ibiza team cannot make requested improvements as quickly as you might expect.
<!--TODO: Determine where the following documents would fit within this section
[Test](portalfx-extension-test.md)
-->
* [Unit testing support]()
* [Testing in Production](portalfx-extensions-testing-in-production.md)
* [Trace modes and diagnostics](portalfx-extensions-flags-trace.md)
* [C# Test Framework (Open source)]()
* [Node.js Test Framework (Open source)]()
[Ask a test related question on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-tets)

<a name="home-telemetry-and-alerting"></a>
## Telemetry and alerting
The Ibiza team collects standard telemetry for __generic actions__ like blade opening and commmand execution. It also collects __performance__, __reliability__, and __user feedback__ information that facilitate the operation of your extension. You can also write your own events via the telemetry system. Ibiza supports alerting for common operations scenarios.
<!--TODO: Determine where the following documents would fit within this section
[Test]
portalfx-extension-monitor.md
-->
* [Portal telemetry overview]()
* [Getting access to raw portal telemetry data]()
* [Consuming telemetry via pre-build Power BI Dashboards]()
* [Performance and reliability monitoring / alerting]()
<!--TODO: Determine where the following documents would fit within this section
* [Improving extension reliability/ Adding peristent caching](portalfx-extension-persistent-caching-of-scripts.md)
-->
* [Collecting feedback from your users]()
* [Set up and verify telemetry logging from your extension]()
[Ask about telemetry on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-telemetry)
[Ask about performance and reliability on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-performance)

<a name="home-localization-globalization"></a>
## Localization / Globalization
The Azure portal supports multiple languages and locales. You will need to localize your content.
<!--TODO: Determine where the following documents would fit within this section
portalfx-localization.md
portalfx-globalization.md
-->
* [Localization overview and supported languages](portalfx-localization.md#understanding-localization)
* [Setting up Localization for your extension]()
* [Setting up Localization for your gallery package]()
* [Testing locaization with side-loading]()
* [Formatting numbers, currencies and dates](portalfx-globalization.md#globalization-api)
[Ask about localization / globalization on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-localization-global)

<a name="home-accessibility"></a>
## Accessibility
The Azure portal strives to meet high accessibility standards to ensure the product is accessible to to users of all levels of ability. There is regular testing and a process with SLAs for getting issues addressed quickly.
<!--TODO: Determine where the following documents would fit within this section
portalfx-extension-accessibility.md
-->
* [Accessibility guidelines]()
* [Accessibility testing and SLAs]()
[Ask about accessibility on stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-accessibility)

<a name="home-deploying-your-extension"></a>
## Deploying your extension
Learn how to deploy your extension to the various clouds and environments.
* [Extension registration, environments (e.g. dogfood, prod), clouds (e.g. Mooncake, BlackForest, Fairfax) and Ibiza team SLAs]()
* [Understanding the journey from private preview to public preview to GA](top-extensions-developmentPhases.md)
[Ask a deployment question on Stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment)
<!--TODO: Determine where the following documents would fit within this section
portalfx-extension-development.md
portalfx-extension-deployment.md
-->
* [Publishing your extension](portalfx-extensions-publishing.md)
<!--TODO: 
Determine whether the previous document covers the following cases:
* [Updating extension configuraiton for national clouds](portalfx-deployment-sovereign.md)
* [Register your extension in disabled mode in Dogfood]
* [Register your extension in disabled mode in Public cloud]
* [Register your extension in disabled mode in Mooncake]
* [Register your extension in disabled mode in Blackforest]
* [Register your extension in disabled mode in FairFax]
* [SLA for registering your extension]
* [Reducing SLA for registering your extension]
* [Enable your extension in Dogfood]
* [Enable your extension in Public cloud]
* [Enable your extension in Mooncake]
* [Enable your extension in Blackforest]
* [Enable your extension in FairFax]
* [SLA for enabling your extension]
* [Reducing SLA for enabling your extension]
-->
<a name="home-deploying-your-extension-deployment-using-the-ibiza-hosting-service"></a>
### Deployment using the Ibiza hosting service
The Ibiza team provides and operates a common extension hosting service that makes it easy to get your bits into a globally distributed system without having to manage your own infrastructure.
* [Hosting service overview](portalfx-extensions-hosting-service.md)
* [Onboarding your extension to hosting service](portalfx-extensions-hosting-service-procedures.md)
* [Validating extension registeration with hosting service]()
* [Versioning your extension](portalfx-extensions-hosting-service-procedures.md#checklist-for-onboarding-hosting-service)
<!--TODO: Determine where the following documents would fit within this section
* [Versioning your extension](portalfx-extension-versioning.md)
-->
* [Deploying your extension using Express V2 + Hosting Service](portalfx-extensions-hosting-service-advanced.md#ev2-integration-with-hosting-service)
* [SLA for registering extension with hosting service](portalfx-extensions-hosting-service-procedures.md#-service-level-agreement-for-hosting-service)

<a name="home-deploying-your-extension-custom-extension-deployment-infrastructure"></a>
### Custom extension deployment infrastructure
You should strive to use the Ibiza hosting service. If for some reason this is not possible then [learn how to build a custom extension deployment infrastructure]().

<a name="home-upgrading-the-ibiza-sdk"></a>
## Upgrading the Ibiza SDK
Extensions are required to be running a version of the Ibiza SDK that has been published withing the past 4 months. 
* [Upgrade policy and alerts](portalfx-deploy.md#3-understand-extension-runtime-compatibility)
* [Upgrading Ibiza NuGet packages](portalfx-extensions-onboarding-nuget.md)
* [Updating the C# test framework]()
* [Updating the msportalfx-test framework]()

<a name="home-advanced-topics"></a>
## Advanced topics
* [Memory management]()
<!--TODO: Determine where the following documents would fit within this section
* Content:
    * [Relate this to Blade/Part lifecycle]
    * [What are child lifetimes?]
    * [Why do all ctors/factories require 'lifetimeManager']
        * [Controls]
        * [KO factories]
        * [EntityView/QueryView]
        -->
* [Custom domains (e.g. aad.portal.azure.com)]()
* [Sharing blades and parts across extensions]()

<a name="home-legacy-features"></a>
## Legacy features
These features are supported, but have had no recent investment. No additional investment is planned. There are modern capabilities that should be used instead if you are developing new features.
* [PDL based blades and parts]()
* [Controls in the msportalfx namespace]()
* [EditScope]()

<!--TODO: Determine where the following documents would fit within this section
 [Sharing PDE](portalfx-extension-sharing-pde.md)
 * legacy ]
     * [Legacy PDL intrinsic Parts](portalfx-parts.md#how-to-use-one-of-the-built-in-parts-to-expose-your-data-in-pre-built-views)
         * [Legacy PDL intrinsic Parts](portalfx-parts.md#how-to-use-one-of-the-built-in-parts-to-expose-your-data-in-pre-built-views)
-->

<a name="home-best-practices-portalfx-extensions-bp-md"></a>
## Best Practices (portalfx-extensions-bp.md)
* All Best Practices for all topics.  The BP's are also included in the individual topics when you select at the topic level.

<a name="home-frequently-asked-questions-portalfx-extensions-faq-md"></a>
## Frequently asked questions(portalfx-extensions-faq.md)
* All FAQ's for all topics.  The FAQ's are also included in the individual topics when you select at the topic level.

<a name="home-glossary-portalfx-extensions-glossary-md"></a>
## Glossary(portalfx-extensions-glossary.md)
* All glossaries for all topics.  The glossaries are included in the individual topics when you select at the topic level.


*
*
