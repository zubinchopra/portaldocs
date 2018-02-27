# Azure portal extension documentation

This is the home page for all documentation related to onboarding, developing, operating, and anything else to do with owning an Azure portal extension.

Couldn't find what you needed? [Ask about the docs on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-missing-docs).

## Onboarding a new extension

* [Overview / Getting Started](/portal-sdk/generated/top-onboarding.md)
* [Steps that do not involve the Ibiza team](/portal-sdk/generated/portalfx-extensions-onboarding-with-related-teams.md)
* [Manage cloud/environment specific configuration](/portal-sdk/generated/top-extensions-configuration.md)
* [Production-ready metrics](/portal-sdk/generated/top-extensions-production-ready-metrics.md)

Kickoff the onboarding experience by sending mail to <a href="mailto:ibiza-onboarding-kick@microsoft.com?subject=Kickoff Meeting Request&body=My team would like to meet with you to learn about the Azure onboarding process.">Azure Onboarding Team</a>.

## Azure portal architecture

Learn how the framework is structured and how it is designed to run in multiple clouds / environments.
* [Architecture overview](/portal-sdk/generated/top-extensions-architecture.md)

## What's new

* [No-PDL Blades and Parts](http://top-whats-new#no-pdl.md) - *Reduces the number of files and concepts to build UI*
* [Forms without edit scope](/portal-sdk/generated/portalfx-editscopeless-forms.md) - *More intuitive APIs for building forms*
* [Editable Grid V2](http://top-level/editable-grid.md) - *Improved APIs designed to work with new forms*
* [Extension Availability Alerts](http://top-level/availibility-alerts.md) - *Get notified if your extension goes down*
* [Actionable Notifications](http://top-level/availibility-alerts.md) - *Point users to well known next steps*
* [EV2 support for the Extension Hosting Service](http://top-level/hosting-service#ev2.md) - *Nuff said*
* [Multi-Column for Essentials Controls]() - *Better use of screen real estate*
* [TreeView improvements]() - *Checkboxes, commands, and Load More / Virtualization*

## Development guide

Azure portal extension development is supported on the Microsoft Windows 8, Windows Server 2012 R2, and Windows 10.
 [Development guide](/portal-sdk/generated/top-extensions-getting-started.md)

1. [Install the SDK](/portal-sdk/generated/top-extensions-install-software.md)
* [How to use the MSI Installer](/portal-sdk/generated/downloads.md)
* [How to update portal Nuget packages](/portal-sdk/generated/top-extensions-nuget.md)
2. Configure your IDE - *Typescript version / Compile on save*
* [Visual Studio](portalfx-ide-setup.md) *(with Extension project template)*
* [VS Code]()

[Ask an sdk setup question on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-sdkupdate)

## Developing your user interface UI

The next few sections walk through the different types of UI that can be built using the framework. There are [samples](/portal-sdk/generated/top-extensions-samples.md) that show how to do many common development tasks. 

### Blades

The primary UI building block is a called a blade. A blade is like a page. It generally takes up the full screen, has a presence in the portal breadcrumb, and has an 'X' button to close it.

[Developing blades](top-extensions-blades.md)

[Ask a question about blades on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-blades-parts)

### Parts

If you want your experience to have a presence on Azure dashboards then you will want to build parts (a.k.a. tiles).

[Developing parts](portalfx-blades.md#blades)

[Ask a question about parts on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-blades-parts)

### Building UI with HTML templates and Fx controls

Any template based UI in the portal (e.g. [template blades]() or [template parts]() can make use of a rich controls library maintained by the Ibiza team.

* [Controls overview](/portal-sdk/generated/top-extensions-controls.md)
* [Controls playground]()

[Ask a controls related question on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-controls)

### Styling and Theming

When using HTML and framework controls you have some control over styling. These documents walk through the relevant topics.

 [Styling and Theming](/portal-sdk/generated/top-extensions-style.md)

* [CSS Style sanitization](/portal-sdk/generated/portalfx-style-guide-style-sanitization.md)
* [Adding Custom CSS](/portal-sdk/generated/portalfx-style-guide-custom-css-file.md)
* [Layout classes]()
* [Typography]()
* [Iconography]()
* [Theming]()

### Forms

Many experiences require the user to fill out a form. The Ibiza controls library provides support for forms. It also provides a TypeScript based section model that lets you build your form in code without expressing all the fields in an html template.
* [Developing forms](/portal-sdk/generated/top-extensions-forms.md)

[Ask a forms related question on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-forms)

### Common scenarios and integration points

* [Blades that __create__ or provision resources and services]()
* [Adding your resource or service into the __browse__ menu]()
* [Common UX for Azure Resource Manager (ARM) based services]()

[Ask about browse integration on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-browse)

[Ask about create scenarios on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-create)

### Other UI concepts

* [Context panes]()
* [Dialogs]()
* [Notifications]()
* [Blade opening and communication between blades]()

### Loading and managing data

Since your extension is just web code, you can make **AJAX** calls to various services to load data into your UI. The framework provides a data library you can use to manage this data.
* [Making authenticated calls to Azure Resource Manager (ARM)](portalfx-data.md#making-authenticated-ajax-calls)
* [Data Context, data views, and data caches](/portal-sdk/generated/portalfx-data-caching.md)
* [Auto-refreshing client data](portalfx-data-refreshingdata.md#auto-refreshing-client-side-data-aka-polling)
* [Shaping and filtering data](portalfx-data-projections.md) 
* [Adressing Data Merge Failures](portalfx-data.md#data-merging)
* [Legacy accessing C# model objects](portalfx-data-typemetadata.md#type-metadata)
* [Legacy Data Atomization](portalfx-data-atomization.md)

[Ask about data management on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-data-caching)

### Advanced development topics

* [Memory management]()
* [Custom domains (e.g. aad.portal.azure.com)]()
* [Sharing blades and parts across extensions]()

## Debugging

 [Debugging](/portal-sdk/generated/top-debugging.md)

* [Using developer mode](/portal-sdk/generated/portalfx-extensions-debugging-tool.md)
* [Debugging extension load failures](/portal-sdk/generated/portalfx-extensions-debugging-load-failures.md)
* [Debugging console errors](/portal-sdk/generated/portalfx-extensions-debugging-console-errors.md)
* [Debugging javascript](/portal-sdk/generated/portalfx-extensions-debugging-javascript.md)
* [Debugging knockout](/portal-sdk/generated/portalfx-extensions-debugging-knockout.md)
* [Debugging the data stack](/portal-sdk/generated/portalfx-extensions-debugging-data-stacks.md)

## Testing

The Ibiza team provides limited testing support. Due to resource constraints the C# and Node.js framework is open source. This is so that partners can unblock themselves in case the Ibiza team cannot make requested improvements as quickly as you might expect.
* [Unit testing support]()
* [C# Test Framework (Open source)]()
* [Node.js Test Framework (Open source)]()

[Ask a test related question on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-test)

## Telemetry and alerting

The Ibiza team collects standard telemetry for __generic actions__ like blade opening and commmand execution. It also collects __performance__, __reliability__, and __user feedback__ information that facilitate the operation of your extension. You can also write your own events via the telemetry system. Ibiza supports alerting for common operations scenarios.
* [Portal telemetry overview]()
* [Getting access to raw portal telemetry data]()
* [Consuming telemetry via pre-build Power BI Dashboards]()
* [Performance and reliability monitoring / alerting]()
* [Collecting feedback from your users]()
* [Set up and verify telemetry logging from your extension]()

[Ask about telemetry on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-telemetry)

[Ask about performance and reliability on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-performance)

## Localization / Globalization

The Azure portal supports multiple languages and locales. You will need to localize your content.
* [Localization overview and supported languages](https://github.com/Azure/portaldocs/blob/master/portal-sd/portal-sdk/generated/portalfx-localization.md#understanding-localization)
* [Setting up Localization for your extension]()
* [Setting up Localization for your gallery package]()
* [Testing locaization with side-loading]()
* [Formatting numbers, currencies and dates](https://github.com/Azure/portaldocs/blob/master/portal-sd/portal-sdk/generated/portalfx-globalization.md#globalization-api)

[Ask about localization / globalization on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-localization-global)

## Accessibility

The Azure portal strives to meet high accessibility standards to ensure the product is accessible to to users of all levels of ability. There is regular testing and a process with SLAs for getting issues addressed quickly.
* [Accessibility guidelines]()
* [Accessibility testing and SLAs]()

[Ask about accessibility on StackOverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-accessibility)

## Deploying your extension

Learn how to deploy your extension to the various clouds and environments.
* [Extension registration, environments (e.g. dogfood, prod), clouds (e.g. Mooncake, BlackForest, Fairfax) and Ibiza team SLAs](/portal-sdk/generated/top-extensions-publishing.md)
* [Extension Development Phases](/portal-sdk/generated/top-extensions-developmentPhases.md)

[Ask a deployment question on Stackoverflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment)

### Deployment using the Ibiza hosting service

[Deployment using the Ibiza hosting service](/portal-sdk/generated/top-hosting-service.md)

The Ibiza team provides and operates a common extension hosting service that makes it easy to get your bits into a globally distributed system without having to manage your own infrastructure.
* [Hosting service overview](/portal-sdk/generated/portalfx-extensions-hosting-service-overview.md)
* [Onboarding your extension to hosting service](/portal-sdk/generated/portalfx-extensions-hosting-service-procedures.md)
* [Validating extension registration with hosting service]()
* [Versioning your extension](/portal-sdk/generated/portalfx-extensions-versioning.md)
* [Deploying your extension using Express V2 + Hosting Service](/portal-sdk/generated/portalfx-extensions-hosting-service-advanced.md)
* [SLA for registering extension with hosting service](/portal-sdk/generated/portalfx-extensions-svc-lvl-agreements.md)

### Custom extension deployment infrastructure

You should strive to use the Ibiza hosting service. If for some reason this is not possible then [learn how to build a custom extension deployment infrastructure](/portal-sdk/generated/portalfx-extensions-custom-deployment.md).

## Upgrading the Ibiza SDK

Extensions are required to be running a version of the Ibiza SDK that has been published withing the past 4 months. 
* [Upgrade policy and alerts](portalfx-deploy.md#3-understand-extension-runtime-compatibility)
* [Upgrading Ibiza NuGet packages](/portal-sdk/generated/top-extensions-nuget.md)
* [Updating the C# test framework]()
* [Updating the msportalfx-test framework]()

## Legacy features

These features are supported, but have had no recent investment. No additional investment is planned. There are modern capabilities that should be used instead if you are developing new features.
* [PDL based blades and parts]()
* [Controls in the msportalfx namespace]()
* [EditScope](/portal-sdk/generated/portalfx-legacy-editscopes.md)

## Frequently asked questions

The documents are combinations from all the previous topics. Consequently, there may be some repetition.
* [Best Practices](/portal-sdk/generated/portalfx-extensions-bp.md)
* [Frequently asked questions](/portal-sdk/generated/portalfx-extensions-faq.md)
* [Glossary](/portal-sdk/generated/portalfx-extensions-glossary.md)

# Marketplace/Gallery Developer Resources

1. [Gallery Overview](/gallery-sd/portal-sdk/generated/index-gallery.md#gallery-overview)
1. [Gallery Item Specificiations](/gallery-sd/portal-sdk/generated/index-gallery.md#gallery-item-specificiations)
1. [Gallery Item Metadata](/gallery-sd/portal-sdk/generated/index-gallery.md#gallery-item-metadata)
1. [Gallery Item Field to UI Element Mappings](/gallery-sd/portal-sdk/generated/index-gallery.md#gallery-item-field-to-ui-element-mappings)
1. [Gallery Package Development and Debugging](/gallery-sd/portal-sdk/generated/index-gallery.md#gallery-package-development-and-debugging)
1. [Legacy OneBox Development approach](/gallery-sd/portal-sdk/generated/index-gallery.md#legacy-onebox-development-approach)
1. [Using the Add to Resource Blade](/gallery-sd/portal-sdk/generated/index-gallery.md#using-the-add-to-resource-blade)
1. [Your icon tile for the Azure Store](/gallery-sd/portal-sdk/generated/index-gallery.md#your-icon-tile-for-the-azure-store)
1. [Developer tooling and productivity](/gallery-sd/portal-sdk/generated/index-gallery.md#developer-tooling-and-productivity)
1. [Gallery Frequently Asked Questions](/gallery-sd/portal-sdk/generated/index-gallery.md#gallery-frequently-asked-questions)

