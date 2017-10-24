
# Azure portal extension development documentation

<details>
  <summary>Click to expand</summary>
## 1. Getting Started

Azure portal extension development is supported on the Microsoft Windows 8, Windows Server 2012 R2, and Windows 10.

:bulb: **Productivity Tip:** Install Chrome http://google.com/dir so that you can levrage the debugger tools while developing your extension.

### 1.1 Installation

* [Option 1 - MSI Installer](downloads.md)
* [Option 2 - Nuget packages](portalfx-nuget-overview.md)

### 1.2 Getting Set up in an IDE - *Typescript version / Compile on save*

* [Visual Studio](portalfx-ide-setup.md) *(with Extension project template)*
* VS Code (Coming Soon....)
* [Need Help with setup?](https://stackoverflow.microsoft.com/questions/tagged/ibiza-sdkupdate)

### 1.3 Developing Hello World Extension

* [Architecture Overview](portalfx-howitworks.md)
* [Creating your first extension from project template](portalfx-creating-extensions.md)
* [Building a Hello World Blade]()
* Add a text box to your Hello World Blade
* Dock button at the bottom of your blade
* Add Menu Bar to your Blade
* Open Blade from your Hello World Blade
* Open Context pane from your Hello World Blade
 

### 1.4 Extension development resources

* [Start Onboarding]
* [Subscribe to announcements]()
* [Update your team's contact information]
* [Samples Extension](portalfx-sample-extensions.md)
* [Understand what it takes to build great extension](portalfx-onboarding-exitcriteria.md#exit-criteria-quality-metrics)
* [Need Help with onboarding?](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding)

### 1.4 Deploying your extension

* [Deploy your extension using hosting service](portalfx-extension-hosting-service.md)
* [Register your extension with hosting service]
* [Validating extension registeration with hosting service]
* [SLA for registering extension with hosting service]
* [Need Help with hosting service?](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment)

### 1.5 Registering your extension

* [Understanding how registeration works](portalfx-extension-onboarding-developer-guide.md)
* [Register your extension in disabled mode in Dogfood]
* [Register your extension in disabled mode in Public cloud]
* [Register your extension in disabled mode in Mooncake]
* [Register your extension in disabled mode in Blackforest]
* [Register your extension in disabled mode in FairFax]
* [SLA for registering your extension]
* [Reducing SLA for registering your extension]
* [Need Help with hosting service?](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding)

### 1.6 Enabling extension for Public Preview/ GA

* [Understand the crtieria for Public Preview in public cloud](portalfx-onboarding-exitcriteria.md#exit-criteria-quality-metrics)
* [Enable your extension in Dogfood]
* [Enable your extension in Public cloud]
  * [Updating extension configuraiton for national clouds](portalfx-deployment-sovereign.md)
* [Enable your extension in Mooncake]
* [Enable your extension in Blackforest]
* [Enable your extension in FairFax]
* [SLA for enabling your extension]
* [Reducing SLA for enabling your extension]
* [Need Help with enabling your extension ?](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding)
</details>



## 2. Developing your extension

### 2.1 What's new

* [No-PDL Blades](portalfx-no-pdl-programming.md#defining-blades-and-parts-using-typescript-decorators-aka-no-pdl) - *Reduces the number of files and concepts to build UI*
* [Forms without edit scope](portalfx-editscopeless-forms.md) - *More intuitive APIs for building forms*
* [Editable Grid V2](TBD) - *Improved APIs designed to work with new forms*
* [Extension Avialability Alerts](portalfx-telemetry-alerting.md#alerting) - *Get notified if your extension goes down*
* [Actionable Notifications](TBD) - *Point users to well known next steps*
* [EV2 support for the Extension Hosting Service](portalfx-extension-hosting-service-advanced.md#advanced-section) - *Nuff said*
* [Multi-Column for Essentials Controls](portalfx-controls-essentials.md) - *Better use of screen real estate*
* [TreeView improvements](TBD) - *Checkboxes, commands, and Load More / Virtualization*

### 2.1 Understanding the extension
* (TBD)
    Portal SDL uses "convention over configuration" to configure itself. This typically means that the name and location of files is used instead of explicit configuration, hence you need to familiarize yourself with the directory structure provided by portal SDK.
    Here is a breakdown and links to the relevant sections:
    * App Data
    * App Start
    * Client
    * Configuration
    * Content
    * Controllers 
    * Definitions
    * GalleryPackages
    * packages.config
    * web.config
    * .config

2. DataContext
* [Packaging and running for different environments]
  * [Verioning your extension](portalfx-extension-versioning.md)
  * [Side-loading your extension in a real portal environment](portalfx-testinprod.md#testing-in-production)
  * [Deep linking to a blade you are developing](portalfx-creating-extensions.md#hello-world-for-blades)
  * [Deploying an extension ](portalfx-extension-hosting-service.md#extension-hosting-service)
* [Debugging](portalfx-debugging.md#debugging)
* Domain Configuration
    * [When to use dynamic configuration](portalfx-domain-based-configuration.md#domain-based-configuration)
    * [How to use dynamic configuration](portalfx-domain-based-configuration-pattern.md#expected-design-pattern)
    * [Configuration](portalfx-dictionaryconfiguration.md)
    * [Sample for accessing dynamic configuration](portalfx-domain-based-configuration-example.md)
 
  * [In the public cloud](portalfx-extension-onboarding-developer-guide.md)
  * [Improving extension reliability/ Adding peristent caching](portalfx-extension-persistent-caching-of-scripts.md)

## Upgrading Extension to use latest version of SDK
  * [Upgrade policy](portalfx-deploy.md#3-understand-extension-runtime-compatibility)
  * [Updating the NuGet packages](portalfx-nuget-overview.md)
  * [Updating the C# test framework](TBD)
  * [Updating the msportalfx-test framework](TBD)

## [Extensions](portalfx-howitworks.md#how-extensions-work)
* What is an extension? 
    * [Ui Concepts](portalfx-ui-concepts.md#ui-concepts)
    * [Extension lifecycle](portalfx-howitworks.md#how-the-portal-works)
    * [Cross-extension UX integration] (TBD)

##  Blades and Parts

* [What are they?](portalfx-ui-concepts.md#ui-concepts)
    * How/when are Blades/Parts invoked?  How can I get my Blade/Part in front of more users?
    * [Blades]
        * [Use 'container.openBlade(…)' to open my Blade](portalfx-blades-opening.md)
        * [Work with other teams to have other extensions call 'container.openBlade(…)' to open my Blade](portalfx-blades-opening.md#importing-the-pde-file)
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
    * [RPC](portalfx-rpc.md#remote-procedure-calls-rpc)  // TOD: Find Home

### Blades
#### [Type of Blades](portalfx-blades.md#blades)
    * [TemplateBlade]
        * Blade
            * Special-case of TemplateBlade (without HTML template)
        * Refer to 'Common document for developing "content"'
    * [FrameBlade (and legacy <AppBlade>)]
        * Refer to AppBlade
        * Refer to "How / when to go the IFrame route?"
    * [MenuBlade]
        * Refer to Resource Menu Blade
    * [Resource Menu Blade]
        * Refer to Menu
    * [Context Pane]
#### Scenarios -- How do I choose?
* [Create Blades](portalfx-create.md)
* [Context Pane
        * [Create Blades
        * [Full-screen Blades
        * [Settings Blades
        * [FrameBlade/AppBlade
            * Content:
                ◊ Reference "How/When to go the IFrame route?"
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
* Scenarios
    * [Building a Part Gallery Part](portalfx-parts.md#how-to-integrate-your-part-into-the-part-gallery)
    * [Retiring a Part](portalfx-parts-how-to-retire.md)
    * [Redirecting a Part](portalfx-parts.md#removing-a-part-from-a-blades-default-layout)
* Developing my Part
    * [Reference "Common features / behavior for Blades and Parts"]
    * [Title/subtitle/icon]
    * [Activation ('onClick')]
    * ['container' APIs (like 'openBlade')]
* HTML template + Knockout + Controls
    * Include "why no access to DOM?"
## Loading data
* [Area](portalfx-data.md#organizing-your-extension-source-code-into-areas)
* Making Ajax calls to ARM and ARM APIs
    * [Authentication](portalfx-authentication.md#calling-arm)
    * [GET calls to ARM](portalfx-data.md#making-authenticated-ajax-calls)
* [Data Context](portalfx-data.md#shared-data-access-using-datacontext)
* [Data Views](portalfx-data.md#using-dataviews)
* [Data Cache](portalfx-data.md#using-datacache-to-load-and-cache-data)
    * [GET calls to ARM with Data Cache](portalfx-data.md#querying-for-data)
    * [Controlling the AJAX calls for Data Cache](portalfx-data.md#loading-data)
    * [Optimizing redundant calls](portalfx-data.md#loading-data)
* Common Scenarios
    * [Auto-refreshing client data](portalfx-data-refreshingdata.md#auto-refreshing-client-side-data-aka-polling)
    * [Shaping and filtering data](portalfx-data-projections.md) // TODO: Find better name
    * [Master Detail](portalfx-data.md#working-with-data)
    * [Adressing Data Merge Failures](portalfx-data.md#data-merging)
    * [Legacy accessing C# model objects](portalfx-data-typemetadata.md#type-metadata)
    * [Legacy Data Atomization](portalfx-data-atomization.md#data-atomization)
* [Making Ajax calls to servies other than ARM](portalfx-authentication.md#calling-other-services)

* [Controls](portalfx-controls.md)
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
    * [Location dropdown](/portalfx-create.md#locations-legacy-dropdown)
    * [Pricing Dropdown](portalfx-create.md#pricing-dropdown)
* Forms
    * [Building UI for Form](portalfx-forms.md#laying-out-your-ui-on-the-blade)
    * [Submit Style UI]
        * [Save/ Cancel Button](portalfx-editscopeless-forms.md#other-css-classes-that-can-be-useful)
        * [Legacy Action Bar] (portalfx-fxcontrols-editscope-forms.md)
    * [Prompt user to Save/Discard changes](portalfx-editscopeless-forms.md#customizing-alert-on-form-close)
    * [EditScopeless Forms](portalfx-editscopeless-forms.md)
    * [Legacy Editscope based Forms](portalfx-forms.md)
    * [Using Editscopeless controls in EditScoped Forms](portalfx-fxcontrols-editscope-forms.md)
* Advanced Styling
• [Extension memory management / Lifetime manager](portalfx-data-lifetime.md#lifetime-manager)
	○ Content:
		* [Relate this to Blade/Part lifecycle]
		* [What are child lifetimes?]
		* [Why do all ctors/factories require 'lifetimeManager']
			* [Controls]
			* [KO factories]
			* [EntityView/QueryView]

Table of Contents

1. Introduction 
    1.1 What's new ?
        1.1.1. No-PDL Blades
        1.1.2. EditScopeless forms
        1.1.3. Editable Grid V2
        1.1.4. Extension Avialability Alerts
        1.1.5. Actionable Notifications
        1.1.6. EV2 support for Extension Hosting Service 
        1.1.7. Other Novelties 
            - Multi-Column for Essentials Controls
            - Adding checkbox, supplyCommands and Load More / Virtualization on Tree view
 
---------------------------------------------------------
1. What's new list will be reviewed on 1 st of every month to ensure that the stuff listed here is not too old
2. PMs can update the list at any point to highlight new features
---------------------------------------------------------

2. Getting Started
    2.1 Installation Requirements
    2.2 Downloading and Installing
        2.2.1 Using the msi
        2.2.2 Using the Nuget packages [ CoreXT and Non-CoreXT]
    2.3 Creating an application
        2.3.1 Using the project template
    2.4 Hello World Example
        2.4.1 On top of project template application
    2.5 Getting Setup in an IDE
        2.5.1 Visual Studio [ Typescript tool version/ Compile on Save]
        2.5.2 VS Code [ Typescript tool version/ Compile on Save]
    2.6 "Convention over configuration"
        Portal SDL uses "convention over configuration" to configure itself. This typically means that the name and location of files is used instead of explicit configuration, hence you need to familiarize yourself with the directory structure provided by portal SDK.
        Here is a breakdown and links to the relevant sections:
        1. App Data
        2. App Start
        3. Client
        4. Configuration
        5. Content
        6. Controllers 
        7. Definitions
        8. GalleryPackages
        9. packages.config
        10. web.config
        10. .config
        2. DataContext
        3. 
    2.7 Running and Debugging an extension
        1. Side-loading the application
        2. Specifying a different Blade


4. Configuration
    4.1 Explaining web.config properties
        4.1.2. ThreadPoolConfiguration
        4.1.3. SettingsReader
        4.1.3. ServicePointManager
        4.1.4  CamelCasedSerializedPropertyNames
        4.1.5 IsDevelopmentMode
        4.1.6 Logging
    4.2 Per environment Configuration 
        4.2.1. portal.azure.com.json
        4.2.2. mooncake.azure.com.json
        4.2.3. rc.azure.com.json
        4.2.4. bf.azure.com.json
        4.2.5. Other ARM/ AAD url settings
    4.3 Packaging and running for different environments
        4.3.1 Local [Settings in web.debug.config]
        4.3.2 Public [Settings in web.release.config]
        4.3.3 National Cloud specific settings [Settings in web.release.config]
 6. Understanding Application lifecycle
    6.1 When is extension loaded / unloaded
    6.2 Performance implications of referencing another extension ?
 7. Blades and Parts
    7.1 What are Blades ? Deep-linkable Blades 
    7.2 What are Parts ? When and Why make blades pinnable ?
    7.3 Types of Blade (Blade, Template Blade, Context Pane, Resource Menu, Create Blade Full Screen Blade)
    7.4 Framework Concepts to build these blades? Template Blade, Menu Blade, Frame Blade, Resource Menu Blade
    7.4 How to integrate your part into the part gallery
    7.5 Best way to load data in Blade/ Part ? 
    7.5 Lifecycle of Blade ?
    7.6 Why use Context Pane ?
    7.6 How does pinning work in Blades  ?
    7.7 Building and debugging my first IFrame Blade / Sample + Doc that shows opening a blade by clicking on button in IFrame
    7.8 Updating Title, Subtitle and Icons on the blade? Why can't I have custom blades ?
    7.9 Sharing Blade with other extensions 
    7.10 Invoking Blade of other extensions 
 5. Querying the data
    5.1 Understanding Area and Data Context 
    5.2 Making Ajax calls to ARM and ARM APIs   [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-authentication.md#calling-arm]
    5.3 Making Ajax calls to servies other than ARM [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-authentication.md#calling-other-services]
    5.4 Understanding Framework caches [https://github.com/Azure/portaldocs/blob/master/portal-sdk/generated/portalfx-data.md#working-with-data]
        5.4.1 Entity Cache
        5.4.2 Query Cache
    


