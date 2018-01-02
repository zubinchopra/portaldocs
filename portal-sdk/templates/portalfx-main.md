
# Azure portal extension development documentation

<details>
  <summary>Undersrading process for Onboarding your service in Azure portal</summary>

1.1 [Introduction](portalfx-onboarding-introduction.md)

1.2 [Onboarding Azure](portalfx-onboarding-azure.md)

1.3 [Onboarding Azure Portal](portalfx-onboarding-portal-extension.md)

1.4 [Onboarding different environments of Azure Portal](portalfx-extensions-branches.md)

1.5 [Managing your extension's configuration in Azure portal](portalfx-extensions-configuration-scenarios.md)

1.6 [Onboarding Checklist for Azure Portal](portalfx-customer-experience-metrics.md)

1.7 [Pulishing your extension to Marketplace](portalfx-extensions-forDevelopers-procedures.md)

### 1.8 Extension development resources

* [Start Onboarding]
* Subscribe to announcements
* [Update your team's contact information]
* [Samples Extension](portalfx-sample-extensions.md)
* [Need Help with onboarding?](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding)


</details>

<details>
  <summary>Quick reference for Framework SLAs</summary>

  1. [SDK Update SLA](portalfx-sdk-sla.md)
  2. [Azure portal extension onboarding  SLA](portalfx-extension-onboarding.md)
  3. [Hosting service extension onboarding  SLA](portalfx-hosting-service-onboarding-sla.md)
</details>

<details>
  <summary>Design Guidelines for your service's user experience</summary>

### 1. Ibiza or Azure portal design language
### 2. Full screen experiences 
### 3. Maintain Context While Changing Views (menu Blade or resource menu)
### 4. React Immediately [Prompt notification for long running operations]
### 5. Explain what just happened (error, warning or success messages)
### 6. Percieved user performance
### 7. Icons
### 8. [Typography](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/styleguidetypographytitle)
### 9. Commonly used Layouts (Forms , Table (or Grid))
### 10. Navigation (Toolbar, Menu, Breadcrumb, Tabs, Accordion, Steps)
### 11. Data Display (Grid, Accordion, Tree, 
### 12. Feedback (Alert, Notification, Popover (such as password), below the control error message)
### 13. Layout
    - [Docking] (https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/alluplayout)
    = [Old CSS] (https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/styleguidelayoututilitytitle)
### 14. [Color Palette](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/styleguidecolorpalettetitle)
### 15. Hiding vs Disabling items 
### 16. Unsupported feature or operation vs Unauthorized access
### 17. Journey vs context pane
### 18. Save and Cancel Button in Toolbar vs Floating vs Docked at Bottom
### 19. Entry point for your service / blade (Asset, Menu item, toolbar)
### 20. Resource creation design
### 21. Resource Menu overview design 
</details>

<details>
  <summary>Getting Started</summary>

Azure portal extension development is supported on the Microsoft Windows 8, Windows Server 2012 R2, and Windows 10.

### 1.1 Installation

* [Option 1 - MSI Installer](downloads.md)
* [Option 2 - Nuget packages](portalfx-nuget-overview.md)

### 1.2 Getting Set up in an IDE - *Typescript version / Compile on save*

* [Visual Studio](portalfx-ide-setup.md) *(with Extension project template)*
* VS Code (Coming Soon....)
* [Need Help with setup?](https://stackoverflow.microsoft.com/questions/tagged/ibiza-sdkupdate)

### 1.3 Running and Debugging Hello World Extension

* [Architecture Overview](portalfx-howitworks.md)
* [Creating your first extension from project template](portalfx-creating-extensions.md)
* [Building a Hello World Blade](portalfx-creating-extensions.md#hello-world-for-blades)
* [Side-loading your extension in a portal environment](portalfx-testinprod.md#testing-in-production)
* [Debugging](portalfx-debugging.md#debugging)
* [Deep linking to a blade you are developing](portalfx-creating-extensions.md#hello-world-for-blades)
* Add a text box to your Hello World Blade
* Dock button at the bottom of your blade
* Add Menu Bar to your Blade
* Open Blade from your Hello World Blade
* Open Context pane from your Hello World Blade

</details>

<details>
  <summary>Onboarding your extension in Azure portal</summary>

### 1.1 Azure portal infrastructure overview

* Understanding Azure portal environments
* Set up dev, test and prod environment for your extension 
* Understanding hosting service environments 
* Understanding Safe deployment for Azure portal and extensions
* SLA for deploying changes in Azure portal code to different environments
* SLA for deploying changes in Hosting Service code to different environments

### 1.2 Setting up deployment infrastructure for your extension

* [Hosting service: Common Deployment infrastructure for extensions ](portalfx-extension-hosting-service.md)
* [Onboarding your extension to hosting service]
* [Validating extension registeration with hosting service]
* [Versioning your extension](portalfx-extension-versioning.md)
* [Deploying your extension using Express V2 + Hosting Service]
* [SLA for registering extension with hosting service]
* [Ask Questions on Stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment)

### 1.5 Registering your extension

* [Understanding how registeration works](portalfx-extension-onboarding-developer-guide.md)
* [Register your extension in disabled mode in Dogfood]
* [Register your extension in disabled mode in Public cloud]
* [Register your extension in disabled mode in Mooncake]
* [Register your extension in disabled mode in Blackforest]
* [Register your extension in disabled mode in FairFax]
* [SLA for registering your extension]
* [Reducing SLA for registering your extension]
* [Ask Questions on Stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding)

### 1.6 Enabling extension for Public Preview/ GA

* [Tracking the customer experience metrics for Public Preview in public cloud](portalfx-onboarding-exitcriteria.md#exit-criteria-quality-metrics)
* [Enable your extension in Dogfood]
* [Enable your extension in Public cloud]
* [Updating extension configuraiton for national clouds](portalfx-deployment-sovereign.md)
* [Enable your extension in Mooncake]
* [Enable your extension in Blackforest]
* [Enable your extension in FairFax]
* [SLA for enabling your extension]
* [Reducing SLA for enabling your extension]
* [Ask Questions on Stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding)
</details>

<details>
  <summary>New Features</summary>

* [No-PDL Blades](portalfx-no-pdl-programming.md#defining-blades-and-parts-using-typescript-decorators-aka-no-pdl) - *Reduces the number of files and concepts to build UI*
* [Forms without edit scope](portalfx-editscopeless-forms.md) - *More intuitive APIs for building forms*
* Editable Grid V2 - *Improved APIs designed to work with new forms*
* [Extension Avialability Alerts](portalfx-telemetry-alerting.md#alerting) - *Get notified if your extension goes down*
* Actionable Notifications - *Point users to well known next steps*
* [EV2 support for the Extension Hosting Service](portalfx-extension-hosting-service-advanced.md#advanced-section) - *Nuff said*
* [Multi-Column for Essentials Controls](portalfx-controls-essentials.md) - *Better use of screen real estate*
* TreeView improvements - *Checkboxes, commands, and Load More / Virtualization*
</details>

<details>
  <summary>Obsolete Features</summary>
  While these features are not going away anytime soon. We do not recommend taking dependecy on these features for any new development.
  * [Editable Grid V1]
  * PDL-Blades for non-create scenarios
  * Using Edit Scope for non-create scenarios
</details>


<details>
  <summary>Upgrading your extension to latest version of SDK and test framework</summary>

## Upgrading Extension to use latest version of SDK
* [Upgrade policy](portalfx-deploy.md#3-understand-extension-runtime-compatibility)
* SDK Update alerts(Coming Soon....)
* [Updating the NuGet packages](portalfx-nuget-overview.md)
* Updating the C# test framework
* Updating the msportalfx-test framework
</details>

<details>
  <summary>Understanding your extension project</summary>

## Basic Configuration(Coming soon..)
* [Side-loding environment]
* [Developer mode]
* [Telemetry]
* [Any other options ??]

## Extension Configuration(Coming soon..)
* [Extension Definition]
* [ConfigurationSettings]
* [ConfigurationSettings]
* [CustomApplicationContext]
* [Controllers]
* [Gallery package]

</details>

<details>
  <summary>Extension Lifecycle</summary>

## [Extensions]
* [What is an extension?](portalfx-howitworks.md#how-extensions-work)
* [Ui Concepts](portalfx-ui-concepts.md#ui-concepts)
* [Extension lifecycle](portalfx-howitworks.md#how-the-portal-works)
* Cross-extension UX integration


## Extension lifecycle
* [Program.ts / entry point]
* [Extension.pdl]
* [Is there some thing that executes when we unload the extension??]
* [Performance implications of referencing another extension]
* [ When is extension loaded / unloaded]
</details>

<details>
  <summary>7. Common Scenarios for your extension</summary>

#### Common Scenarios for ARM based extensions
* [Create resource](portalfx-create.md)
* [List resources ]
* [Resource overview]

#### Common Scenarios for Non-ARM based extensions
* [Create experience](portalfx-create.md)
* [Custom experience]

</details>

<details>
  <summary>8. Developing your extension</summary>


##  Blades and Parts

* [Introduction](portalfx-ui-concepts.md#ui-concepts)

#### Common Scenarios
* [Create Blades](portalfx-create.md)
* [Context Pane]
* [Full-screen Blades]
* [Settings Blades]
* [FrameBlade/AppBlade]
* [Pinnable Blades]
* [Adding part to Part/Tile Gallery]
* [Invoking Blade/Part reuse across extensions]
* [Shairing Blade/Part across extensions]

### Blades

#### [Type of Blades](portalfx-blades.md#blades)
* [TemplateBlade]
* [FrameBlade (and legacy <AppBlade>)]
* [MenuBlade]
* [Resource Menu Blade]
* [Context Pane]

* How/when are Blades/Parts invoked?  How can I get my Blade/Part in front of more users?
* [Blades]
    * [Use 'container.openBlade(...)' to open my Blade](portalfx-blades-opening.md)
    * [Work with other teams to have other extensions call 'container.openBlade(...)' to open my Blade](portalfx-blades-opening.md#importing-the-pde-file)
    * Associate my Blade with an <AssetType> so it is opened from Browse
    * [Add my Blade as an entry in a Resource Blade or a Menu Blade]
        * [No-PDL](portalfx-no-pdl.md#building-a-menu-blade-using-decorators)
        * [PDL](portalfx-blades-menublade.md)
* [Parts]
    * Make my Blades pinnable using @Blade.Pinnable.Decorator/onPin
    * Call Fx/Pinner/pinParts from some Blade
        ◊ …even encourage partner extensions to do so
    * Add 'galleryMetadata' to my Part to make it available to users in the Part Gallery
* [FAQ]
    * When should I make my Blade pinnable?

### Component model
* Lifecycle
* What is a Blade's/Part's API?  How is it invoked?
* How / when to go the IFrame route?
 
### [Blade/Part reuse across extensions]
    * [Making Blades/Parts reusable by other extensions](portalfx-extension-sharing-pde.md)
    * [Reusing Blades/Parts from other extensions](portalfx-integrating-with-other-extensions.md)
    * [RPC](portalfx-rpc.md#remote-procedure-calls-rpc)  // TODO: Find Home
            
#### Developing my Blade
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

### [Parts]((portalfx-parts.md#parts-aka-tiles)
* [Types of Parts])
    * [TemplatePart]
    * [FramePart]
    * [ButtonPart]
    * [Legacy PDL intrinsic Parts](portalfx-parts.md#how-to-use-one-of-the-built-in-parts-to-expose-your-data-in-pre-built-views)
#### Scenarios
    * [Building a Part Gallery Part](portalfx-parts.md#how-to-integrate-your-part-into-the-part-gallery)
    * [Retiring a Part](portalfx-parts-how-to-retire.md)
    * [Redirecting a Part](portalfx-parts.md#removing-a-part-from-a-blades-default-layout)
#### Developing my Part
    * [Reference "Common features / behavior for Blades and Parts"]
    * [Title/subtitle/icon]
    * [Activation ('onClick')]
    * ['container' APIs (like 'openBlade')]
    
### HTML template + Knockout + Controls
    * Include "why no access to DOM?"

### Debugging

* Using Azure portal's Debug tool 
* Debugging extension load failures
* Debugging console errors 
* [Debugging the Javascript](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-debugging.md#debugging-javascript)
* [Debugging the knockout](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-debugging.md#debugging-knockout)
* [Debugging the data stack](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-debugging.md#debugging-the-data-stack)
* Testing in production
* Marking automated tests as test/synthetic traffic
</details>

<details>
  <summary>Control Libraries</summary>

## [Controls](portalfx-controls.md)

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

</details>
<details>
  <summary>Control Libraries</summary>

## Forms

* [Developing Forms ](Doc with all controls in HTML rather than in typescript)
* [Developing Forms in Typescript](portalfx-forms.md#laying-out-your-ui-on-the-blade)
* Left aligned label vs top aligned label forms
* [Submit Style UI]
    * [Save/ Cancel Button](portalfx-editscopeless-forms.md#other-css-classes-that-can-be-useful)
    * [Legacy Action Bar](portalfx-fxcontrols-editscope-forms.md)
* [Adding validation to form fields]
* [Adding Custom validation to form fields]
* [Prompt user to Save/Discard changes](portalfx-editscopeless-forms.md#customizing-alert-on-form-close)
* [Adding user feedback on Save operation using InfoBox]
* [Adding user feedback on Long running operation using Notifications]
* Customize styling of your controls using Custom Controls
* [Legacy Editscope based Forms](portalfx-forms.md)
* [Using Editscopeless controls in EditScoped Forms](portalfx-fxcontrols-editscope-forms.md)

</details>

<details>
  <summary>Calling ARM and other backend APIs</summary>

* [Area](portalfx-data.md#organizing-your-extension-source-code-into-areas)
* Making Ajax calls to ARM and ARM APIs
    * [Authentication](portalfx-authentication.md#calling-arm)
    * [GET calls to ARM](portalfx-data.md#making-authenticated-ajax-calls)
* [Making Ajax calls to servies other than ARM](portalfx-authentication.md#calling-other-services)
</details>


<details>
  <summary>Publishing Notifications </summary>

* [Client Side Events]
* [Server Side Events]
* [Publishing Notifications through IRIS]

</details>

<details>
  <summary>Advanced Styling Options</summary>

* CSS Style sanitization
* Adding Custom CSS
* [Layout classes]
* [Typography]
* [Adding custom Icons]
* [Adding Badges to Icons]
* [Themed color classes] (https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-style-guide-themed-color-classes.md#style-guide-themed-color-classes)
* Coloring to convey status
* Coloring to differentiate data

</details>


<details>
  <summary>Data Layer</summary>

* [Data Context](portalfx-data.md#shared-data-access-using-datacontext)
* When to use Data Views and Data Cache?
* [Data Views](portalfx-data.md#using-dataviews)
* [Data Cache](portalfx-data.md#using-datacache-to-load-and-cache-data)
    * [GET calls to ARM with Data Cache](portalfx-data.md#querying-for-data)
    * [Controlling the AJAX calls for Data Cache](portalfx-data.md#loading-data)
    * [Optimizing redundant calls](portalfx-data.md#loading-data)
    * [Auto-refreshing client data](portalfx-data-refreshingdata.md#auto-refreshing-client-side-data-aka-polling)
    * [Shaping and filtering data](portalfx-data-projections.md) // TODO: Find better name
    * [Master Detail](portalfx-data.md#working-with-data)
    * [Adressing Data Merge Failures](portalfx-data.md#data-merging)
    * [Legacy accessing C# model objects](portalfx-data-typemetadata.md#type-metadata)
    * [Legacy Data Atomization](portalfx-data-atomization.md#data-atomization)
</details>

<details>
  <summary>Logging </summary>

* [Logging](https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/logging)
</details>


<details>
  <summary>Telemetry - Only for First party extensions </summary>

## 1. Telemetry
* Portal Telemetry Overview
* Set up and verify telemetry logging from your extension
* Available Power BI Dashboards
* Collecting Feedback From Your Users
* Requesting access to portal telemetry data
* Accessing raw events in Kusto

## 2. Monitoring your resource creation Telemetry

* What is resource creation telemetry ?
* Why is resource creation telemetry monitored ?
* How is resource creation telemetry calculated ?
* Monitoring your create telemetry through Power BI Dashboards
* Trobuleshooting failures in create telemetry 
* Alerting for resource creation failures


## 2. Monitoring your extension's performance

* Why is extension performance monitored ?
* How is extension performance monitored ?
* How is your extension's performance calculated ?

* Best practices for improving extension performance 


## 3. Monitoring your extension's reliability

* Why is extension reliability monitored ?
* How is extension reliability monitored ?
* How is your extension's reliability calculated ?
* Best practices for improving extension reliabhility

## 4. Monitoring your extension's availability 

* Why is extension availability monitored ?
* How is extension availability monitored ?
* How is your extension's availability calculated ?
* Configuring alerts for your extension availability 
* Best practices for improving extension availability 

</details>

<details>
  <summary>Localization / Globalization</summary>
  
  * [How loacalization works in framework (Supported languages / fallback)](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-localization.md#understanding-localization)
  * [Setting up Localization for your extension]
  * [Setting up Localization for your gallery package]
  * [Testing locaization with side-loading]
  * [Formatting numbers, currencies and dates](https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-globalization.md#globalization-api)
</details>


<details>
  <summary>Accessibility </summary>
  
  * <!-- TODO: Work with Paymon and Chris to identify what needs to be added here -->
</details>

<details>
  <summary>Memory Management</summary>

## [Extension memory management / Lifetime manager](portalfx-data-lifetime.md#lifetime-manager)
* Content:
    * [Relate this to Blade/Part lifecycle]
    * [What are child lifetimes?]
    * [Why do all ctors/factories require 'lifetimeManager']
        * [Controls]
        * [KO factories]
        * [EntityView/QueryView]

</details>


<details>
  <summary>Setting up infrastructure for different domains</summary>

* Domain Configuration
    * [When to use dynamic configuration](portalfx-domain-based-configuration.md#domain-based-configuration)
    * [How to use dynamic configuration](portalfx-domain-based-configuration-pattern.md#expected-design-pattern)
    * [Configuration](portalfx-dictionaryconfiguration.md)
    * [Sample for accessing dynamic configuration](portalfx-domain-based-configuration-example.md)
</details>

    


