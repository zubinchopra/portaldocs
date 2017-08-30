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

    2.8 How do extensions work ? WHy can't I write my custom javascript ?
    2.8 Deploying an extension 
    2.9 Registering an extension 
        2.9.1 In public cloud
        2.9.2 In national cloud
3. Upgrading Azure Portal SDK   
    3.1 Updating the NuGet packages
    3.2 Updating the C# test framework
    3.3 Updating the msportalfx-test framework
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
    4.3 Packaging and running for different environments
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
    


