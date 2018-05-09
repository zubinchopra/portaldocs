
<a name="using-the-content-delivery-network"></a>
## Using the Content Delivery Network

Developers may use a Content Delivery Network(CDN) to serve static images, scripts, and stylesheets. The Azure Portal SDK does not require the use of a CDN, or the use of a specific CDN. However, extensions that are served from Azure can take advantage of the built-in CDN capabilities in the SDK.

<a name="using-the-content-delivery-network-creating-the-cdn-account"></a>
### Creating the CDN account

Follow the guide located at [http://aka.ms/portalfx/cdn](http://aka.ms/portalfx/cdn) to set up your CDN account.

After creating your CDN, there are a few options that need to be set.

* Click the "Enable HTTPS" command to enable HTTP and HTTPS.

* Click the "Enable Query String" to enable query string status.

<a name="using-the-content-delivery-network-configuring-the-extension"></a>
### Configuring the extension

 There are a few pieces to configure to take advantage of the CDN capabilities in the Portal SDK. After setting up the CDN for the extension, you will receive a URL with which to access  content for the extension. It is in the form:

    `//<CDNNamespace>.vo.msecnd.net/`

This is the prefix for the CDN service. The production service should be configured to use it by using the following `appSetting` in the local `web.config` file.

```xml
<add key="Microsoft.Portal.Extensions.SamplesExtension.ApplicationConfiguration.CdnPrefix" 
     value="//<CDNNamespace>.vo.msecnd.net/" />
```

Neither `http` nor `https` are included in the url, so that the page can request content based on the current protocol. Sometimes, like for a cloud service, this setting is blank in `web.config`, and configured instead in a `cscfg`.

Configuring versioning of your Extension is specified in [portalfx-extensions-versioning.md](portalfx-extensions-versioning.md). 


<a name="using-the-content-delivery-network-reading-the-prefix-from-configuration"></a>
### Reading the prefix from configuration

To read any FX configuration, the extension uses a class which inherits from `ApplicationContext`, as in the following example.

```
\SamplesExtension\Configuration\CustomApplicationContext.cs
```

This class includes a `CdnPrefix` property, as in the following code.

```cs
[Export(typeof(ApplicationContext))]
internal class CustomApplicationContext : ApplicationContext
{
    private ApplicationConfiguration configuration;

    [ImportingConstructor]
    public CustomApplicationContext(ApplicationConfiguration configuration)
    {
        this.configuration = configuration;
    }

    public override bool IsDevelopmentMode
    {
        get
        {
            return this.configuration.IsDevelopmentMode;
        }
    }

    public override string CdnPrefix
    {
        get
        {
            return this.configuration.CdnPrefix;
        }
    }
}
```

This class assigns properties that are located in the `web.config` or `*.cscfg` files. To read the values from those files, the extension uses a C# class that  inherits from `ConfigurationSettings` and exports `ApplicationConfiguration`, as in the following example.

    `\SamplesExtension\Configuration\ApplicationConfiguration.cs`

This class is in the following code.

```cs
[Export(typeof(ApplicationConfiguration))]
public class ApplicationConfiguration : ConfigurationSettings
{
    /// <summary>
    /// Gets a value indicating whether development mode is enabled.
	/// Development mode turns minification off
    /// </summary>
    /// <remarks>
	/// Development mode turns minification off. 
	/// It also disables any caching that be happening.
	/// </remarks>
    [ConfigurationSetting]
    public bool IsDevelopmentMode
    {
        get;
        private set;
    }

    /// <summary>
    /// Gets a value indicating a custom location where browser should 
	/// find cache-able content (rather than from the application itself).
    /// </summary>
    [ConfigurationSetting]
    public string CdnPrefix
    {
        get;
        private set;
    }
}
```

<a name="using-the-content-delivery-network-iis-asp-net-configuration"></a>
### IIS / ASP.NET Configuration

Files are pushed to the CDN using the following process.

1. The browser makes a request to a specific CDN address, for example,  `http://exampleCDN.vo.msecnd.net/Content/jquery.js`.

1. If the file is already cached on the CDN, it is sent to the browser.

1. If the file is not cached, the CDN service makes a request to the origin server for the resource, for example,  `http://myextension.cloudapp.net/CDN/Content/jquery.js`.

1. The file is cached and returned to the client.

To enable this workflow, the CDN makes a HTTP request to the extension. This is typically  not an issue, but some CDNs will make an HTTP 1.0 request. HTTP 1.0 technically does not support gzip/deflated content, therefore IIS does not enable compression by default. To turn compression on, set the `noCompressionForHttp10` setting in `<httpCompression>` to `false`.

The url for the request is in the following form.

`http://myextension.cloudapp.net/CDN/Content/jquery.js`

The literal "/CDN/" is inserted into the url after the host address, and before the rest of the route for requested content. The request handling code in the SDK automatically handles incoming requests of the form `/CDN/Content/...` and `/Content/...`.   

For more information, see [http://www.iis.net/configreference/system.webserver/httpcompression](http://www.iis.net/configreference/system.webserver/httpcompression).

<a name="using-the-content-delivery-network-invalidating-content-on-the-cdn"></a>
### Invalidating content on the CDN

Versioning should be configured when a new release of an extension is made available, to ensure that users are served the latest static content. Invalidating previous or stale content causes the Portal to    .

* AMD  Bundles are invalidated using a hash value that is generated on the file content, as in the following example.

https://hubs-s3-portal.azurecomcdn.net/AzureHubs/Content/Dynamic/AmdBundleDefinition_**83A1A15A39494B7BB1F704FDB5F32596D4498792**.js?root=*HubsExtension/ServicesHealth/ServicesHealthArea

*  Static content is invalidated using the **extension version** that is associated  with a specific version, as in the following example. 

https://hubs-s3-portal.azurecomcdn.net/AzureHubs/Content/**5.0.202.7608987.150717-1541**/Images/HubsExtension/Tour_Tile_Background_Normal.png


