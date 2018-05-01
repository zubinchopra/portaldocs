# Azure portal extension documentation

This is the home page for all documentation related to onboarding, developing, operating, and anything else to do with owning an Azure portal extension.

Couldn't find what you needed? [Ask about the docs on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-missing-docs).

## Onboarding a new extension

* [Overview / Getting started](/portal-sdk/generated/top-onboarding.md)

* [Steps that do not involve the Ibiza team](/portal-sdk/generated/top-extensions-onboarding-with-related-teams.md)

* [Manage cloud/environment specific configuration](/portal-sdk/generated/top-extensions-configuration.md)

* [Production-ready metrics](/portal-sdk/generated/top-extensions-production-ready-metrics.md)

Kickoff the onboarding experience by sending mail to <a href="mailto:ibiza-onboarding-kick@microsoft.com?subject=Kickoff Meeting Request&body=My team would like to meet with you to learn about the Azure onboarding process.">Azure Onboarding Team</a>.

## Azure portal architecture

Learn how the framework is structured and how it is designed to run in multiple clouds / environments.

* [Architecture overview](/portal-sdk/generated/top-extensions-architecture.md)

## What's new

* [No-PDL blades and parts](http://top-whats-new#no-pdl.md) - *Reduces the number of files and concepts to build UI*

* [Forms without edit scope](/portal-sdk/generated/top-editscopeless-forms.md) - *More intuitive APIs for building forms*

* [Editable grid V2](http://top-level/editable-grid.md) - *Improved APIs designed to work with new forms*

* [Extension availability alerts](http://top-level/availibility-alerts.md) - *Get notified if your extension goes down*

* [Actionable notifications](http://top-level/availibility-alerts.md) - *Point users to well known next steps*

* [EV2 support for the extension hosting service](http://top-level/hosting-service#ev2.md) - *Nuff said*

* [Multi-column for essentials controls](/portal-sdk/generated/) - *Better use of screen real estate*

* [TreeView improvements](/portal-sdk/generated/) - *Checkboxes, commands, and Load More / Virtualization*

## Development guide

### Getting started

Azure portal extension development is supported on the Microsoft Windows 8, Windows Server 2012 R2, and Windows 10.

1. [Install the SDK](/portal-sdk/generated/top-extensions-install-software.md)

    * [How to update portal Nuget packages](/portal-sdk/generated/top-extensions-nuget.md)

1. Configure your IDE - *Typescript version / Compile on save*

    * [Visual Studio]() *(with Extension project template)*

    * [VS Code]()

1. 	Run your code

    * [Running the extension locally (a.k.a. sideloading)](/portal-sdk/generated/top-extensions-sideloading.md)

[Ask an SDK setup question on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-sdkupdate)

## Developing your user interface

The next few sections walk through the different types of UI that can be built using the framework.

### Samples  

Samples show how to do many common development tasks. 

[Samples](/portal-sdk/generated/top-extensions-samples.md)

### Blades

The primary UI building block is a called a blade. A blade is like a page. It generally takes up the full screen, has a presence in the portal breadcrumb, and has an 'X' button to close it.

* [Overview](/portal-sdk/generated/top-extensions-blades.md)

* [TemplateBlade](/portal-sdk/generated/top-blades-procedure.md)

* [MenuBlade](/portal-sdk/generated/top-blades-menublade.md)

* [ResourceMenuBlade](/portal-sdk/generated/top-blades-resourcemenu.md)

* [Blade settings](/portal-sdk/generated/top-blades-settings.md)

* [FrameBlade](/portal-sdk/generated/top-blades-frameblades.md)

* [Opening and closing blades programmatically](/portal-sdk/generated/top-blades-opening-and-closing.md)

* [Advanced TemplateBlade topics](/portal-sdk/generated/top-blades-advanced.md)

* [Blade with tiles](/portal-sdk/generated/top-blades-legacy.md)

[Ask a question about blades on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-blades-parts)

### Parts

If you want your experience to have a presence on Azure dashboards then you will want to build parts (a.k.a. tiles).

* [Developing parts](/portal-sdk/generated/top-extensions-parts.md)

[Ask a question about parts on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-blades-parts)

### Building UI with HTML templates and Fx controls

Any template based UI in the portal (e.g. template blades or template parts can make use of a rich controls library maintained by the Ibiza team.

* [Controls overview](/portal-sdk/generated/top-extensions-controls.md)

* [Controls playground](/portal-sdk/generated/top-extensions-controls-playground.md)

[Ask a controls related question on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-controls)

### Styling and theming

When using HTML and framework controls you have some control over styling. These documents walk through the relevant topics.

 [Styling and theming](/portal-sdk/generated/top-extensions-style-guide.md)

* [HTML, CSS, and SVG sanitization](/portal-sdk/generated/top-style-guide-html-css-sanitization.md)

* [Adding custom CSS](/portal-sdk/generated/top-style-guide-custom-css.md)

* [Layout classes](/portal-sdk/generated/portalfx-blades-layout.md)

* [Typography](/portal-sdk/generated/top-style-guide-typography.md)

* [Iconography](/portal-sdk/generated/top-style-guide-iconography.md)

* [Theming](/portal-sdk/generated/top-style-guide-theming.md)

### Forms

Many experiences require the user to enter data into a form. The Ibiza controls library provides support for forms. It also provides a TypeScript based section model that lets you build your form in code without expressing all the fields in an html template.

* [Developing forms](/portal-sdk/generated/top-extensions-forms.md)

[Ask a forms related question on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-forms)

### Common scenarios and integration points

* [Blades that create or provision resources and services](/portal-sdk/generated/top-extensions-create.md)

* [Adding your resource or service into the Browse menu](/portal-sdk/generated/top-extensions-browse.md)

* [Common UX for Azure Resource Manager (ARM) based services](/portal-sdk/generated/)

[Ask about browse integration on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-browse)

[Ask about create scenarios on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-create)

### Other UI concepts

* [Context panes](/portal-sdk/generated/top-extensions-context-panes.md)

* [Dialogs](/portal-sdk/generated/)

* [Notifications](/portal-sdk/generated/)

* [Communication between blades](/portal-sdk/generated/)

### Loading and managing data

Since your extension is just web code, you can make **AJAX** calls to various services to load data into your UI. The framework provides a data library you can use to manage this data.

* [Making authenticated calls to Azure Resource Manager (ARM)](/portal-sdk/generated/portalfx-data.md#making-authenticated-ajax-calls)

* [Data context](/portal-sdk/generated/top-extensions-data-modeling.md)

* [Data caches](/portal-sdk/generated/top-extensions-data-caching.md)

* [Data views](/portal-sdk/generated/top-extensions-data-views.md)

* [Auto-refreshing client data](/portal-sdk/generated/top-extensions-data-refreshing.md#auto-refreshing-client-side-data-aka-polling)

* [Shaping and filtering data](/portal-sdk/generated/top-extensions-data-projections.md) 

* [Addressing data merge failures](/portal-sdk/generated/top-extensions-data-refreshing.md#data-merge-failures)

* [Legacy accessing C# model objects](/portal-sdk/generated/top-extensions-data-typemetadata.md#type-metadata)

* [Legacy - data atomization](/portal-sdk/generated/top-extensions-data-atomization.md)

[Ask about data management on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-data-caching)

### Advanced development topics

* [Memory management](/portal-sdk/generated/)

* [Custom domains (e.g. aad.portal.azure.com)](/portal-sdk/generated/)

* [Sharing blades and parts across extensions](/portal-sdk/generated/)

## Debugging

 [Debugging](/portal-sdk/generated/top-extensions-debugging.md)

* [Using developer mode](/portal-sdk/generated/portalfx-extensions-debugging-tool.md)

* [Debugging extension load failures](/portal-sdk/generated/portalfx-extensions-debugging-load-failures.md)

* [Debugging console errors](/portal-sdk/generated/portalfx-extensions-debugging-console-errors.md)

* [Debugging javascript](/portal-sdk/generated/portalfx-extensions-debugging-javascript.md)

* [Debugging knockout](/portal-sdk/generated/portalfx-extensions-debugging-knockout.md)

* [Debugging the data stack](/portal-sdk/generated/portalfx-extensions-debugging-data-stacks.md)

## Performance

* [Performance profiling](/portal-sdk/generated/top-extensions-performance-profiling.md)

## Testing

The Ibiza team provides limited testing support. Due to resource constraints the C# and Node.js framework is open source. This is so that partners can unblock themselves in case the Ibiza team cannot make requested improvements as quickly as you might expect.

* [Unit testing support](/portal-sdk/generated/portalfx-unit-test.md)

* [C# test framework (open source)](/portal-sdk/generated/top-extensions-csharp-test-framework.md)

* [Node.js test framework (open source)](/portal-sdk/generated/)

[Ask a test-related question on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-test)

## Telemetry and alerting

The Ibiza team collects standard telemetry for generic actions like blade opening and commmand execution. It also collects performance, reliability, and user feedback information that facilitate the operation of your extension. You can also write your own events via the telemetry system. Ibiza supports alerting for common operations scenarios.

* [Portal telemetry overview](/portal-sdk/generated/)

* [Getting access to raw portal telemetry data](/portal-sdk/generated/)

* [Consuming telemetry via pre-built Power BI dashboards](/portal-sdk/generated/)

* [Performance and reliability monitoring / alerting](/portal-sdk/generated/)

* [Collecting feedback from your users](/portal-sdk/generated/)

* [Set up and verify telemetry logging from your extension](/portal-sdk/generated/)

[Ask about telemetry on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-telemetry)

[Ask about performance and reliability on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-performance)

## Experimentation and flighting

It is common for teams to want to experiment with new capabilities. We offer two framework features that make this possible.

* [Flighting a new version of your extension in MPAC](/portal-sdk/generated/top-extensions-flighting.md)

* [Feature flags to enable or disable individual features within an environment](/portal-sdk/generated/top-extensions-flags.md)

## Localization and globalization

The Azure portal supports multiple languages and locales. You will need to localize your content.

* [Localization overview and supported languages](/portal-sdk/generated/top-extensions-localization-globalization.md#understanding-localization)

* [Setting up localization for your extension](/portal-sdk/generated/)

* [Setting up localization for your gallery package](/portal-sdk/generated/)

* [Testing localization with side-loading](/portal-sdk/generated/top-extensions-sideloading.md)

* [Formatting numbers, currencies and dates](/portal-sdk/generated/top-extensions-localization-globalization.md#globalization-api)

[Ask about localization / globalization on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-localization-global)

## Accessibility

The Azure portal strives to meet high accessibility standards to ensure the product is accessible to to users of all levels of ability. There is regular testing and a process with SLAs for getting issues addressed quickly.

* [Accessibility guidelines](/portal-sdk/generated/)

* [Accessibility testing and SLAs](/portal-sdk/generated/)

[Ask about accessibility on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-accessibility)

## Deploying your extension

Learn how to deploy your extension to the various clouds and environments.
* [Extension registration, environments (e.g. dogfood, prod), clouds (e.g. Mooncake, BlackForest, Fairfax) and Ibiza team SLAs](/portal-sdk/generated/top-extensions-publishing.md)

* [Extension development phases](/portal-sdk/generated/top-extensions-developmentPhases.md)

[Ask a deployment question on Stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment)

### Deployment using the extension hosting service

[Deployment using the extension hosting service](/portal-sdk/generated/top-hosting-service.md)

The Ibiza team provides and operates a common extension hosting service that makes it easy to get your bits into a globally distributed system without having to manage your own infrastructure.

* [Extension hosting service overview](/portal-sdk/generated/portalfx-extensions-hosting-service-overview.md)

* [Onboarding your extension to the Extension Hosting Service](/portal-sdk/generated/portalfx-extensions-hosting-service-procedures.md)

* [Validating extension registration with hosting service](/portal-sdk/generated/)

* [Versioning your extension](/portal-sdk/generated/portalfx-extensions-versioning.md)

* [Deploying your extension using **Express V2** and the hosting service](/portal-sdk/generated/portalfx-extensions-hosting-service-advanced.md)

* [SLA for registering an extension with the extension hosting service](/portal-sdk/generated/top-extensions-svc-lvl-agreements.md)

### Custom extension deployment infrastructure

You should strive to use the Extension hosting service. If for some reason this is not possible then [learn how to build a custom extension deployment infrastructure](/portal-sdk/generated/portalfx-extensions-custom-deployment.md).

## Upgrading the Ibiza SDK

Extensions are required to be running a version of the Ibiza SDK that has been published withing the past 4 months. 
* [Upgrade policy and alerts](/portal-sdk/generated/portalfx-deploy.md#3-understand-extension-runtime-compatibility)

* [Upgrading Ibiza NuGet packages](/portal-sdk/generated/top-extensions-nuget.md)

* [Updating the C# test framework](/portal-sdk/generated/top-extensions-csharp-test-framework.md)

* [Updating the msportalfx-test framework](/portal-sdk/generated/)

## Legacy features

These features are supported, but have had no recent investment. No additional investment is planned. There are modern capabilities that should be used instead if you are developing new features.

* [PDL based blades and parts](/portal-sdk/generated/)

* [Controls in the MsPortalFx namespace](/portal-sdk/generated/portalfx-extensions-samples-controls-deprecated.md)

* [EditScope](/portal-sdk/generated/top-legacy-editscopes.md)

* [Legacy features](/portal-sdk/generated/portalfx-legacy-blades-template-pdl.md)

## Frequently asked questions

The documents are combinations from all the previous topics. Consequently, there may be some repetition.

* [Best practices](/portal-sdk/generated/portalfx-extensions-bp.md)

* [Frequently asked questions](/portal-sdk/generated/portalfx-extensions-faq.md)

* [Glossary](/portal-sdk/generated/portalfx-extensions-glossary.md)

# Marketplace/Gallery Developer Resources

1. [Gallery Overview](/gallery-sdk/generated/index-gallery.md#gallery-overview)

1. [Gallery Item Specificiations](/gallery-sdk/generated/index-gallery.md#gallery-item-specificiations)

1. [Gallery Item Metadata](/gallery-sdk/generated/index-gallery.md#gallery-item-metadata)

1. [Gallery Item Field to UI Element Mappings](/gallery-sdk/generated/index-gallery.md#gallery-item-field-to-ui-element-mappings)

1. [Gallery Package Development and Debugging](/gallery-sdk/generated/index-gallery.md#gallery-package-development-and-debugging)

1. [Legacy OneBox Development approach](/gallery-sdk/generated/index-gallery.md#legacy-onebox-development-approach)

1. [Using the Add to Resource Blade](/gallery-sdk/generated/index-gallery.md#using-the-add-to-resource-blade)

1. [Your icon tile for the Azure Store](/gallery-sdk/generated/index-gallery.md#your-icon-tile-for-the-azure-store)

1. [Developer tooling and productivity](/gallery-sdk/generated/index-gallery.md#developer-tooling-and-productivity)

1. [Gallery Frequently Asked Questions](/gallery-sdk/generated/index-gallery.md#gallery-frequently-asked-questions)

