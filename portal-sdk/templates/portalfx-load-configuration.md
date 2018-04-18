
<tags
    ms.service="portalfx"
    ms.workload="portalfx"
    ms.tgt_pltfrm="portalfx"
    ms.devlang="portalfx"
    ms.topic="get-started-article"
    ms.date="12/26/2015"
    ms.author="lixinxu"/>    

## Exposing configuration settings for the client

Configuration settings are commonly used to control application behavior like timeout values, page size, endpoints, ARM version number, and other items. With the .NET framework, managed code can easily load configurations; however, most of the implementation of a Portal extension is client-side JavaScript.  By allowing the client code in extensions to gain access to configuration settings, the Portal framework provides a way to get the configuration and expose it in `window.fx.environment`, as in the following steps. 

1. The Portal framework initializes the instance of the  `ApplicationConfiguration` class, which is located in the   **Configuration** folder in the VS project for the extension. The instance will try to populate all properties by finding configuration in web.config appSettings section. 

    For each property, Portal framework will use the key "{ApplicationConfiguration class full name}.{property name}" unless you give a different name in the associated `ConfigurationSetting` attribute applied that property in the `ApplicationConfiguration` class.

1. Portal framework will create an instance of `window.fx.environment` for the client script. It uses the mapping in the `ExtensionConfiguration` dictionary in the `Definition.cs` file that is located in the `Controllers` folder.

1. The client script loads the configuration from `window.fx.environment` that implements the `FxEnvironment` interface. To declare the new configuration entry, the file `FxEnvironmentExtensions.d.ts` in the `Definitions` folder should be updated for each property that should be exposed to the client.

# Step by step walkthrough

This procedure assumes that a Portal extension named "MyExtension" is being customized to add a new configuration called "PageSize". The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

1. Open the `ApplicationConfiguration.cs` file that is located in the  `Configuration` folder.

1. Add a new property named `PageSize`, to the sample code that is located at `SamplesExtension\Extension\Configuration\ArmConfiguration.cs`. The sample is included in the following code.

    <!--TODO:  Customize the sample code to match the description -->

      gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Configuration/ArmConfiguration.cs", "section": "config#configurationsettings"}

1. Save the file. 

1. **NOTE**: The namespace is `Microsoft.Portal.Extensions.MyExtension`, therefore the full name of the class is `Microsoft.Portal.Extensions.MyExtension.ApplicationConfiguration`. Because the property is `PageSize`, the configuration key is `Microsoft.Portal.Extensions.MyExtension.ApplicationConfiguration.PageSize`.

1. Open the `web.config` file of the extension.

1. Locate the `appSettings` section. Add a new entry for PageSize.

    ```xml
    ...
      <appSettings>
            ...
            <add key="Microsoft.Portal.Extensions.MyExtension.ApplicationConfiguration.PageSize" value="20"/>
      </appSettings>
      ...
    ```

1. Save and close the `web.config` file.

1. Open the `Definition.cs` file that is located in the `Controllers` folder. Add a new mapping in `ExtensionConfiguration` property.

    ```csharp
        /// <summary>
        /// Initializes a new instance of the <see cref="Definition"/> class.
        /// </summary>
        /// <param name="applicationConfiguration">The application configuration.</param>
        [ImportingConstructor]
        public Definition(ApplicationConfiguration applicationConfiguration)
        {
            this.ExtensionConfiguration = new Dictionary<string, object>()
            {
                ...
                { "pageSize", applicationConfiguration.PageSize },
            };
            ...
        }
    ```

1. Open the `FxEnvironmentExtensions.d.ts` file that is located in the  `Definitions` folder, and add the `pageSize` property in the environment interface.

    ```ts
        interface FxEnvironment {
            ...
            pageSize?: number;
        } 
    ```

1. Now new configuration entry has been defined. To use the configuration, add the code like this in script:

    ```JavaScript
        var pageSize = window.fx.environment && window.fx.environment.pageSize || 10;
    ```
If you have any questions, reach out to Ibiza team on: [https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza).

An extended version of the above is used to transfer domain based configuration (such as correctly formatted FwLinks) to the client.
For details and examples, please see [Domain based configuration](portalfx-domain-based-configuration.md).