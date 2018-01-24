
## Global.asax.cs changes

Enable the `PrecompiledMvcViewEngine` provided in the framework to leverage the functionality in the `ExtensionControllerBase` class for your extension controller. The recommended way for doing this is to derive the MVC HttpApplication from the `ExtensionApplicationBase` class.

By doing this, the aforementioned view engine is automatically registered. After this is complete,  if there was any code in the `Application_Start` handler, you should override the `ApplicationStartHandler` method, and put it in there.

**NOTE**: Keep the call to the base method, because  the enabling of the PrecompiledMvcViewEngine is done there.

So, the Global.asax.cs would look something like this.


```cs
/// <summary>
/// The http application for the extension.
/// </summary>
public class MvcApplication : ExtensionApplicationBase
{
    /// <summary>
    /// This method allows for execution of code on Application_Start.
    /// </summary>
    protected override void ApplicationStartHandler()
    {
        // remove the below call to the base method if you do not want to register the <c>PrecompiledMvcViewEngine</c> view engine.
        base.ApplicationStartHandler();

        AreaRegistration.RegisterAllAreas();
        WebApiConfig.Register(GlobalConfiguration.Configuration);
        FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
        RouteConfig.RegisterRoutes(RouteTable.Routes);
    }
}
```

## HomeController

The home controller of each extension defines the index view used to host the extension in an iframe in the Azure Portal.

The code should now inherit from the `Microsoft.Portal.FrameworkExtensionControllerBase` class to leverage built-in functionality provided by the framework.

The following is an example of a typical controller.

```cs
[Export]
[PartCreationPolicy(CreationPolicy.NonShared)]
public class HomeController : ExtensionControllerBase
{
    /// <summary>
    /// Initializes a new instance of the HomeController class.
    /// </summary>
    [ImportingConstructor]
    public HomeController(ExtensionDefinition definition)
        : base(definition)
    {
    }
}
```

The controller requires an extension definition, which can be provided using MEF.
This extension definition should extend the `ExtensionDefinition` class provided by the framework. Below is a sample of what this would look like.

```cs
[Export(typeof(ExtensionDefinition))]
internal class SamplesExtensionDefinition : ExtensionDefinition
{
    [ImportingConstructor]
    public SamplesExtensionDefinition(ArmConfiguration armConfiguration)
    {
        this.PreInitializeBundles = new[] { new SamplesExtensionScripts() };
        this.ExtensionConfiguration = new Dictionary<string, object>()
        {
            { "armEndpoint", armConfiguration.ArmEndpoint }
        };
    }

    public override string GetTitle(PortalRequestContext context)
    {
        return ClientResources.samples;
    }
}
```

### PreManifestBundles

These are the bundles that are loaded before the manifest is loaded. As an example, the bundles for your non-AMD resources should be added over here, because since they may be required by the extension manifest.

### PreInitializeBundles

These are the bundles that are loaded before the extension is initialized. Any non-AMD scripts that are required for the extension to function properly should be specified here so that they are loaded before the shell tries to initialize the extension.

### ExtensionConfiguration

This is a dictionary for extension-specific configuration. When new items are added to this dictionary,  they will be available on the client-side.

If you can only provide this configuration when the request is being made (e.g. if it is dependent on the request context), you can override this dictionary and provide a getter which is evaluated only when needed, at which point the request context should be available.

## Enabling this functionality in the dev environment

Specify the "scriptoptimze=true" feature flag in the extensions JSON to leverage the performance optimizations in the base controller.
