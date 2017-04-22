<<<<<<< HEAD
=======
* [Overview](#overview)
* [Calling ARM](#calling-arm)
    * [From client](#calling-arm-from-client)
    * [From server](#calling-arm-from-server)
* [Calling other services](#calling-other-services)
    * [Accessing claims](#calling-other-services-accessing-claims)
    * [FAQs](#calling-other-services-faqs)
    * [Q: How to enable local portal authentication?](#calling-other-services-q-how-to-enable-local-portal-authentication)

<a name="overview"></a>
### Overview

>>>>>>> 6aa1e260bbe9276ddd69af39dd671090d0b489ac
The portal uses an internal provider for authentication and authorization. 

The built-in cloud auth provider uses Azure Active Directory (AAD), which also supports Microsoft Account (MSA, formerly 
Windows Live ID) users. Please refer to _Accessing claims from your server_, if your extension needs to differentiate between
AAD and MSA users.

During sign-in, the portal obtains a token containing claims that identify the signed-in user and retrieves directories and 
subscriptions s/he has access to, if any.

_**NOTE:** Users can sign in without a subscription. Extensions must gracefully handle this case and return 0 assets when queried._

The following is a high-level representation of the sign-in flow provided by the portal:

1. User browses to the portal
2. The portal redirects to AAD to sign in
3. AAD redirects to the portal with a token
4. The portal gets a list of directories the user has access to from ARM
5. The portal gets a list of subscriptions the user has access to from ARM
6. The portal signs the user into the last-used directory, the home directory for AAD accounts, or the first directory it gets from ARM for MSA accounts
7. Finally, the portal loads the Startboard and all extensions

<a name="calling-arm"></a>
## Calling ARM

<a name="calling-arm-from-client"></a>
### From client

The recommended practice is to use cross-origin resource sharing (CORS) for all of your non-aggregated, non-orchestrated calls. If you need to call multiple sources for a single piece of UI, you should use a server API to orchestrate/aggregate those calls.

From the extension client to call any server API , use the built-in `ajax()` function to communicate with your extension server. This function will attach a token targeted at ARM specific to your extension to the HTTP header. 
**Do not use `jQuery.ajax()`** &ndash; it will not properly authorize your requests.

**NOTE:** If you have a scenario that isn't supported by `ajax()`, you can use the `getAuthorizationToken()` function to obtain a token and manually attach it to your own request._

<a name="calling-arm-from-server"></a>
### From server

To call ARM from your extension server, use the `WebApiClient` class. Like the client `ajax()` function, this class attaches a token targeted at ARM to the request on your behalf.

```cs
Uri arm = new Uri("https://management.azure.com/...");  // arm endpoint
using (var client = new Microsoft.Portal.Framework.ClientProxy.WebApiClient())
{
    // ConfigureAwait(false) is recommended to not forcibly resume on the same thread it started on
    // var data = await client.GetAsync<...>(arm).ConfigureAwait(false);
}
```

<a name="calling-other-services"></a>
## Calling other services

In order to call other services, your extension must obtain a custom token with the user's context that has an audience URI for your particular APIs. There are 2 ways to accomplish this:

1. Make AJAX requests for a specific service from the client
2. Exchange Fx tokens for your own from your server

_**NOTE:** Only first-party (internal/Microsoft) extensions that comply with Azure privacy terms and conditions are allowed access to 
tokens due to the embedded personally-identifiable information (PII). All other extensions get an encrypted token that can only be used 
to communicate with ARM. If you are working on internal/Microsoft extension, but are not sure that your extension scenarios comply with 
Azure terms and conditions, please reach out to the [Azure portal legal team](mailto:ibiza-lca@microsoft.com)._

<a name="calling-other-services-calling-other-services-from-the-client"></a>
#### Calling other services from the client
In order to call other services from the client, the Fx team will create a new AAD app for you and will manage that application on your behalf since tokens will be obtained by the Fx. 

1. Create a [security/auth partner request](http://aka.ms/new-ibiza-security-auth-request) including the exact config you need (see 
   below) to start the process of obtaining an AAD application for your extension.
2. The Fx team will submit a request to the AAD onboarding team on your behalf and will CC you on the request (NOTE: AAD onbaording can take 5-6 weeks)
3. The [AAD onboarding team](mailto:aadonboarding@microsoft.com) can provide status on the request.  It is helpful to obtain your App Id from the Fx team when working with the AAD team.
4. Once the app is created, the Fx team will update portal config 
5. Request tokens for the desired service (aka "resource") when using Fx APIs

The following sample shows how an extension can be configured to get tokens for ARM and AAD Graph:

```json
{
    "name": "Contoso_Extension",
    "uri": "//stamp2.extension.contoso.com/Home",
    "uriFormat": "//{0}.extension.contoso.com/Home",
    "feedbackEmail": "extension.admin@contoso.com",
    "resourceAccess": [{
        "name": "",
        "resource": "https://management.core.windows.net/"
    }, {
        "name": "graph",
        "resource": "https://graph.windows.net"
    }]
}
```

Once the config changes are deployed, use one of the following methods to 

```ts
// specify the target service (resource name) in ajax() calls
MsPortalFx.Base.Net.ajax({
    setAuthorizationHeader: { resourceName: "graph" }
});

// specify the target service when using the file download control
new MsPortalFx.ViewModels.Controls.FileDownload.ViewModel(
    container,
    {
        context: ko.observable(new FileDownload.Context({
            ...
            addDefaultAuthorizationToken: {
                resourceName: "graph"
            },
            ...
        })),
    });

// specify the target service when using the file download command
new MsPortalFx.ViewModels.FileDownloadCommand({
    authorizationOptions: {
        resourceName: "graph"
    }
});

// get a token to add to requests manually
MsPortalFx.Base.Security.getAuthorizationToken({ resourceName: "graph" });
```

<a name="calling-other-services-calling-other-services-from-the-server"></a>
#### Calling other services from the server
To call other services from the server, you'll need your own AAD app and exchange the Fx token for your own to call other services.

1. [Create an AAD app](https://aadonboardingsiteppe.cloudapp.net) and contact the [AAD onboarding team](mailto:aadonboarding@microsoft.com) as 
   needed (NOTE: AAD onboarding can take 5-6 weeks)
2. Create a [security/auth partner request](http://aka.ms/new-ibiza-security-auth-request) including the exact config you need (see 
   below)
3. The Fx team will update portal config
4. Request tokens for your extension when calling your server
5. Call AAD to exchange the Fx token for your own
6. Make your calls as you normally would

The following sample shows how an extension can be configured to get tokens for ARM and the extension ("self"):

```json
{
    "name": "Contoso_Extension",
    "name": "Contoso_Extension",
    "uri": "//stamp2.extension.contoso.com/Home",
    "uriFormat": "//{0}.extension.contoso.com/Home",
    "resourceAccess": [{
        "name": "",
        "resource": "https://management.core.windows.net/"
    }, {
        "name": "self",
        "resource": "1a123abc-1234-1a2b-ab01-01ab01a1a1ab"
    }]
}
```

Specify the `self` resource name when calling your server:

```cs 
MsPortalFx.Base.Net2.ajax({
    uri: "MyController/MyAction",
    setAuthorizationHeader: { resourceName: "self" }
}).then((myData) => {
    // do work with data
});
```

Then, exchange the Fx token for your own:
 
```cs
<<<<<<< HEAD
// Get the token passed to the controller
var portalAuthorizationHeader = HttpContext.Current.GetRequestContext().RequestCorrelationContext.GetCorrelationData<AuthorizationCorrelationProvider>();
if (portalAuthorizationHeader == null) {
    // This should never happen, the auth module should have returned 401 if there wasn’t a valid header present
    throw new HttpException(401, "Unauthorized");
}

// Exchange it for the token that should pass to downstream services
var exchangedAuthorizationHeader = GetExchangedToken(portalAuthorizationHeader, intuneClientId, intuneClientCert, "https://graph.windows.net/");

// Call downstream service with exchanged header
var headers = new NameValueCollection();
headers.Add("Authorization", exchangedAuthorizationHeader);
webApiClient.GetAsync(uri, "MyOperation", headers);

// Helper method to exchange tokens
string GetExchangedToken(string portalAuthorizationHeader, string clientId, X509Certificate2 clientCertificate, string resource) {

    // proof that the intune extension is making the token request
    var clientAssertion = new ClientAssertionCertificate(clientId, clientCertificate);

    // proof that the request originated from the portal and is on behalf of a valid user
    var accessToken = GetAccessTokenFromAuthorizationHeader(portalAuthorizationHeader);
    var userAssertion = new UserAssertion(accessToken, "urn:ietf:params:oauth:grant-type:jwt-bearer"); 

    // the actual token exchange
    var exchangedToken = authContext.AcquireToken(resource, clientAssertion, userAssertion); 

    return exchangedToken.GetAuthorizationHeader();
}

string GetAccessTokenFromAuthorizationHeader(string authorizationHeader) {
    // The header will be in the form "Bearer ey……MZ"
    // The access token in the last part of the header
    var separator = new char[] { ' ' };
    var accessToken = authorizationHeader.Split(separator, StringSplitOptions.RemoveEmptyEntries).LastOrDefault();

    return accessToken;
}
=======
    // Get the token passed to the controller
    var portalAuthorizationHeader = PortalRequestContext.Current.GetCorrelationData<AuthorizationCorrelationProvider>();
    if (portalAuthorizationHeader == null) {
        // This should never happen, the auth module should have returned 401 if there wasn�t a valid header present
        throw new HttpException(401, "Unauthorized");
    }
�
    // Exchange it for the token that should pass to downstream services
    var exchangedAuthorizationHeader = GetExchangedToken(portalAuthorizationHeader, intuneClientId, intuneClientCert, "https://graph.windows.net/");
�
    // Call downstream service with exchanged header
    var headers = new NameValueCollection();
    headers.Add("Authorization", exchangedAuthorizationHeader);
    webApiClient.GetAsync(uri, "MyOperation", headers);
�
    // Helper method to exchange tokens
    string GetExchangedToken(string portalAuthorizationHeader, string clientId, X509Certificate2 clientCertificate, string resource) {

        // proof that the intune extension is making the token request
    ��� var clientAssertion = new ClientAssertionCertificate(clientId, clientCertificate);
    �
    ��� // proof that the request originated from the portal and is on behalf of a valid user
    ��� var accessToken = GetAccessTokenFromAuthorizationHeader(portalAuthorizationHeader);
    ��� var userAssertion = new UserAssertion(accessToken, "urn:ietf:params:oauth:grant-type:jwt-bearer"); 
    �
    ��� // the actual token exchange
    ��� var exchangedToken = authContext.AcquireToken(resource, clientAssertion, userAssertion); 
    �
    ��� return exchangedToken.GetAuthorizationHeader();
    }
�
    string GetAccessTokenFromAuthorizationHeader(string authorizationHeader) {
        // The header will be in the form "Bearer ey��MZ"
        // The access token in the last part of the header
        var separator = new char[] { ' ' };
        var accessToken = authorizationHeader.Split(separator, StringSplitOptions.RemoveEmptyEntries).LastOrDefault();
    �
    ��� return accessToken;
    }
>>>>>>> 6aa1e260bbe9276ddd69af39dd671090d0b489ac
```

<a name="calling-other-services-accessing-claims"></a>
### Accessing claims

Tokens received from AAD contain a set of claims (key/value pairs) with information about user, including
personally-identifiable information (PII). Note that PII will only be available to extension who fall under the
[Azure privacy policy](https://www.microsoft.com/TrustCenter/Privacy). Extensions that don't fall under this policy
(e.g. share PII with third-parties) will not have access to the token or its claims. This is due to the fact that
Microsoft can be sued for abuse/misuse of PII as outlined by the privacy policy. Any exceptions need to be approved by
[Ibiza LCA](mailto:ibiza-lca@microsoft.com).

<a name="calling-other-services-accessing-claims-accessing-claims-from-the-client"></a>
#### Accessing claims from the client
Extensions that do have access to claims can use the `getUserInfo()` API to retrieve common claims from the client. Note
that secondary claims, like name and email, may not always be available and cannot be guarranteed. Token claims may
change over time as AAD evolves. Do not make hard dependencies on claims and never extract claims yourself. Instead,
call Graph to get required user information.

```ts
MsPortalFx.Base.Security.getUserInfo() : PromiseV<MsPortalFx.Base.Security.UserInfo>

interface UserInfo {
    email: string;          // Guest accounts not homed in the current directory will have a UPN and not a valid email address
    givenName: string;      // Name may be empty if not provided in the token
    surname: string;        // Name may be empty if not provided in the token
    directoryId: string;
    directoryName: string;  // Directory name may be empty if calling Graph fails
    domainName: string;     // Directory domain may be empty if calling Graph fails
}
```

<a name="calling-other-services-accessing-claims-accessing-claims-from-your-server"></a>
#### Accessing claims from your server
While not recommended, the token used to communicate with your server also contains claims that can be read from the
server using the [ASP.NET claims API](http://msdn.microsoft.com/en-us/library/ee517271.aspx). To simplify development,
the [HttpContext.User](http://msdn.microsoft.com/library/system.web.httpcontext.user.aspx) has been augmented with the
most commonly used claims.

First, reference the following assemblies:

* Microsoft.Portal.AadCore.dll
* System.IdentityModel.Tokens.Jwt.dll

Second, add the following to your **web.config** file:

<!-- INTERNAL NOTE: copy settings from src\StbPortal\Extensions\AzureHubsExtension\Web.config -->

```xml
<!-- deny anonymous users -->
<system.web>
    <authorization>
      <deny users="?" />
    </authorization>
</system.web>

<!-- allow the home page which serves the extension source -->
<!-- TODO: This loads your extension from ~/Index; change path to fit your needs -->
<location path="Index">
  <system.web>
    <authorization>
      <allow users="*" />
    </authorization>
  </system.web>
</location>

<!-- allow images and scripts -->
<location path="Content">
  <system.web>
    <authorization>
      <allow users="*" />
    </authorization>
  </system.web>
</location>
<location path="Scripts">
  <system.web>
    <authorization>
      <allow users="*" />
    </authorization>
  </system.web>
</location>

<configuration>
  <appSettings>
    <!-- For test, use authority="https://login.windows-ppe.net/" -->
    <!-- For PROD, use authority="https://login.windows.net/" -->
    <add key="Microsoft.Portal.Security.AzureActiveDirectory.AadAuthenticationConfiguration.Authority"
         value="https://login.windows-ppe.net/" />
    <add key="Microsoft.Portal.Security.AzureActiveDirectory.AadAuthenticationConfiguration.TenantId"
         value="common" />
    <add key="Microsoft.Portal.Security.AzureActiveDirectory.AadAuthenticationConfiguration.AllowedAudiences"
         value="['https://management.core.windows.net/']" />
    <add key="Microsoft.Portal.Security.AzureActiveDirectory.AadAuthenticationConfiguration.MinValidationCertUpdateInterval"
         value="PT05M" />
    <add key="Microsoft.Portal.Security.AzureActiveDirectory.AadAuthenticationConfiguration.MaxValidationCertUpdateInterval"
         value="PT24H" />
    <add key="Microsoft.Portal.Security.AzureActiveDirectory.AadAuthenticationConfiguration.ForwardDecryptedAuthorizationTokens"
         value="false" />
  </appSettings>
</configuration>
```

Lastly, use [HttpContext.User](http://msdn.microsoft.com/library/system.web.httpcontext.user.aspx) to retrieve the common claims:

```cs
// use IPortalIdentity for email and tenant id
// NOTE: Do not rely on IPortalIdentity.FirstName and LastName properties; they aren't consistenty populated
var portalUser = HttpContext.User.Identity as Microsoft.Portal.Framework.IPortalIdentity;
// portalUser.EmailAddress;
// portalUser.TenantId;

// use IAadIdentity (implements IPortalIdentity) for user id
// and to determine if the user is an MSA or AAD account
var aadUser = portalUser as Microsoft.WindowsAzure.Management.AadAuthentication.IAadIdentity;
if (aadUser != null)
{
    // aadUser.ObjectId;
    // aadUser.PrincipalId;
    // aadUser.IsOrgId
}
```

If you require additional claims, use the [ASP.NET claims API](http://msdn.microsoft.com/en-us/library/ee517271.aspx) to read the desired claims from the token. The [Supported token and claim types](http://msdn.microsoft.com/en-us/library/windowsazure/dn195587.aspx#BKMK_JWT) article on MSDN covers the default claims provided by AAD.

Due to token size constraints, additional information cannot be added to the token. Instead, any additional information required by an extension must be obtained from [AAD Graph API](http://msdn.microsoft.com/en-us/library/windowsazure/hh974482.aspx).


<a name="calling-other-services-faqs"></a>
### FAQs

<a name="calling-other-services-faqs-q-how-do-i-get-the-list-of-subscriptions-or-just-those-selected-by-a-user"></a>
#### Q: How do I get the list of subscriptions? Or just those selected by a user?

A: Call the `MsPortalFx.Azure.getAllSubscriptions()` or `MsPortalFx.Azure.getSelectedSubscriptions()` APIs (see the [subscriptions page](portalfx-subscriptions.md) for more information).

<a name="calling-other-services-faqs-q-when-do-authenticated-sessions-expire"></a>
#### Q: When do authenticated sessions expire?

A: The portal does not automatically log users out after a period of inactivity; it only logs a user out when the user's AAD-issued authentication token expires (because all subsequent operations would fail).
This generally happens after a few hours of usage (8 to 24 hours based on the type of account) or if the token was not refreshed/renewed for a period of time (typically 1 hour).
(Note that if the browser is in a situation where it cannot connect to the network for more than an hour, the user will likely get logged out.)

<a name="calling-other-services-q-how-to-enable-local-portal-authentication"></a>
### Q: How to enable local portal authentication?

By default, authentication is not configured in the local portal to simplify development. Use the following to enable authentication:

1. Install [Internet Information Services (IIS)](http://msdn.microsoft.com/en-us/library/ms181052%28v=vs.80%29.aspx) (not IIS Express)
2. Install the [URL Rewrite module for IIS](http://www.iis.net/downloads/microsoft/url-rewrite)
3. Install the [Azure SDK](http://www.windowsazure.com/en-us/downloads)
4. Execute the **%programfiles(x86)%\Microsoft SDKs\PortalSDK\Tools\Setup-OneCloud.cmd** script

The **Setup-OneCloud.cmd** script creates a new IIS site configured to use the CURRENT test environment, which includes AAD-PPE and MSA-PROD. The new site can be accessed at [http://onestb.cloudapp.net/](http://onestb.cloudapp.net/). This site is located in the following folder on your system:

`%programfiles(x86)%\Microsoft SDKs\PortalSDK\StbPortal`

To change environments to either NEXT or DOGFOOD, update the web.config files for the portal, Hubs extension, and the Billing extension. Each extension has environment config at the top to simplify switching environments.

**NOTE:** This URL is configured within AAD and cannot be changed. A new hosts file entry was added to support loopback._
