
<a name="server-side-caching-of-extension-home-pages"></a>
### Server side caching of extension home pages

As of SDK version 5.0.302.85, extension home pages can be cached to different levels on the server.  This results in better load time, especially from browsers that have high latency. The following is an example of a Portal URL in the production environment.

```
https://yourextension.contoso.com/
    ?extensionName=Your_Extension
    &shellVersion=5.0.302.85%20(production%23444e261.150819-1426)
    &traceStr=
    &sessionId=ece19d8501fb4d2cbe10db84b844c55b
    &l=en.en-us
    &trustedAuthority=portal.azure.com%3A
    #ece19d8501fb4d2cbe10db84b844c55b
```

You will notice that for the extension, the sessionId is sent in the query string part of the URL.
This makes the extension essentially un-cacheable, because a unique URL is generated on each access. This essentially breaks any caching, whether it occurs on the client browser or on the extension server.

If server-side caching of extension home pages is enabled, the URL becomes the following.

```
https://yourextension.contoso.com/
    ?extensionName=Your_Extension
    &shellVersion=5.0.302.85%20(production%23444e261.150819-1426)
    &traceStr=
    &l=en.en-us
    &trustedAuthority=portal.azure.com%3A
    #ece19d8501fb4d2cbe10db84b844c55b
```

Notice that the sessionId is no longer present in the query string. This allows the extension server to serve the same version of the page to a returning browser (HTTP 304).

To enable homepage caching on the extension server, examine the 
implementation of the `Microsoft.Portal.Framework.ExtensionDefinition` class.  
In the implementation of the `Microsoft.Portal.Framework.ExtensionDefinition` class, there is a property named `Cacheability`. By default its value is `ExtensionIFrameCacheability.None`, but the implementation should set it to `ExtensionIFrameCacheability.Server`.

Making this change assumes that the way the home page is rendered dynamically does not change, because there is 
 different output for different requests. 
It assumes that when the output changes, it also increments the value of `Microsoft.Portal.Framework.ApplicationContext.Version`.

**NOTE**: In this mode, if  live updates are made to the  extension without incrementing the version, some subset  of  customers may not see the changes for some time because of what was previously cached.

<a name="client-side-caching-of-extension-home-pages"></a>
### Client-side caching of extension home pages

The above version of the feature only enables server side caching.
More  benefits are derived from caching if an extension can  cache on the client, and omit another network call.

Consequently, the Azure team has added support for caching extension home pages in the browser itself. The performance of an extension can be improved  by changing  how the extension uses caches. This allows the extension to load with as few as  *ZERO* network calls from the browser for a returning user.

It also serves as a basis for further performance and reliability improvements, because fewer network calls also results in fewer network related errors.

Perform the following steps to enable this.

1.  Move to a version of the SDK newer than 5.0.302.121.

1.  Implement [persistent caching of your scripts](portalfx-performance-caching-scripts.md).
    You should do this any way to improve extension reliability.
    If you do not do this, you will see higher impact on reliability as a result of home page caching.

1.  Ensure that your implementation of `Microsoft.Portal.Framework.ApplicationContext.GetPageVersion()` returns a *stable* value per build of your extension.
    We implement this for your extension by default for you by using the version of your assembly.
    If this value changes between different servers of the same deployment, the home page caching will not be very effective.
    Also if this value does not change between updates to your extension, then existing users will continue to load the previous version of your extension even after you update.

1.  In your implementation of `Microsoft.Portal.Framework.ExtensionDefinition` update this property:

    ```cs
    public override ExtensionIFrameCacheability Cacheability
    {
        get
        {
            return ExtensionIFrameCacheability.Manifest;
        }
    }
    ```

1.  <a href="mailto:ibizafxpm@microsoft.com?subject=[Manifest Caching] on &lt;extensionName&gt; &body=Hi, we have enabled manifest caching on &lt;extensionName&gt; please make the appropriate Portal change.">Contact the Portal team</a>
     or submit a [Work Item Request](https://aka.ms/cachemanifest) so we can update the value from our side.  
    Sorry about this step.
    We added it to ensure backward compatibility.
    When all extensions have moved to newer SDKs, we can eliminate it.

<a name="implications-of-client-side-caching"></a>
### Implications of client side caching

1.  An implication of this change is that when you roll out an update to your extension, it might take a couple of hours for it to reach all your customers.
    But the reality is that this can occur even with the existing deployment process.
    If a user has already loaded your extension in their session, they will not really get your newer version till they F5 anyway.
    So extension caching adds a little more latency to this process.

1.  If you use this mechanism, you cannot use extension versioning to roll out breaking changes to your extension.
    Instead, you should make server side changes in a non-breaking way and keep earlier versions of your server side code running for a few days.

We believe that the benefits of caching and fast load time generally outweigh these concerns.

<a name="how-this-works"></a>
### How this works

We periodically load your extensions (from our servers) to get their manifests.
We call this "manifest cache". The cache is updated every few minutes.
This allows us to start up the Portal without loading every extension to find out very basic information about it (like its name and its browse entry/entries, etc.)
When the extension is actually interacted with, we still load the latest version of its code, so the details of the extension should always be correct (not the cached values).
So this works out as a reasonable optimization.
With the newer versions of the SDK, we include the value of GetPageVersion() of your extension in its manifest.
We then use this value when loading your extension into the Portal (see the pageVersion part of the query string below).
So your extension URL might end up being something like:

```
https://YourExtension.contoso.com/
    ?extensionName=Your_Extension
    &shellVersion=5.0.302.85%20(production%23444e261.150819-1426)
    &traceStr=
    &pageVersion=5.0.202.18637347.150928-1117
    &l=en.en-us
    &trustedAuthority=portal.azure.com%3A
    #ece19d8501fb4d2cbe10db84b844c55b
```

On the server side, we match the value of pageVersion with the current value of ApplicationContext.GetPageVersion().
If those values match, we set the page to be browser cacheable for a long time (1 month).
If the values do not match we set no caching at all on the response.
The no-caching case could happen during an upgrade, or if you had an unstable value of ApplicationContext.GetPageVersion()).
This should provide a reliable experience even when through updates.
When the caching values are set, the browser will not even make a server request when loading your extension for the second time.

You will notice that we include the shellVersion also in the query string of the URL.
This is just there to provide a mechanism to bust extension caches if we needed to.

<a name="how-to-test-your-changes"></a>
### How to test your changes

You can verify the behavior of different caching modes in your extension by launching the Portal with the following query string:

```
https://portal.azure.com/
    ?Your_Extension=cacheability-manifest
    &feature.canmodifyextensions=true
```

This will cause the extension named "Your_Extension" to load with "manifest" level caching (instead of its default setting on the server.
You also need to add "feature.canmodifyextensions=true" so that we know that the Portal is running in test mode.  

To verify that the browser serves your extension entirely from cache on subsequent requests:

- Open F12 developer tools, switch to the network tab, filter the requests to only show "documents" (not JS, XHR or others).
- Then navigate to your extension by opening one of its blades, you should see it load once from the server.
- You will see the home page of your extension show up in the list of responses (along with the load time and size).
- Then F5 to refresh the Portal and navigate back to your extension. This time when your extension is served up, you should see the response served with no network activity. The response will show "(from cache)".  If you see this manifest caching is working as expected.

<a name="co-ordinating-these-changes-with-the-portal"></a>
### Co-ordinating these changes with the Portal

Again, if you do make some of these changes, you still need to coordinate with the Portal team to make sure that we make corresponding changes on our side too.
Basically that will tell us to stop sending your extension the sessionId part of the query string in the URL (otherwise caching does not help at all).
Sorry about this part, we had to do it in order to stay entirely backward compatible/safe.
