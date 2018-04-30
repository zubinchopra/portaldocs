
<a name="creating-the-test-project"></a>
### Creating the Test Project

To create a test project that can use the Portal Test Framework, use the following steps.

1. Create a new **Visual Studio** Unit Test Project.

1. Install the NuGet Package Microsoft.Portal.TestFramework from [https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework](https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework).

1. If your test cases use the Azure Marketplace, also install the Microsoft.Portal.TestFramework.MarketplaceUtilities package from [https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework.marketplaceutilities](https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework.marketplaceutilities), which contains Selenium classes for elements in the Azure Marketplace.

1. Add an `app.config` file to your test project and define the basic Test Framework settings under appSettings, as in the following example.

```xml

<appSettings>
  <!-- Browser type. "Chrome", "IE" -->
  <add key="TestFramework.WebDriver.Browser" value="Chrome" />
  <add key="TestFramework.WebDriver.DirectoryPath" value="packages\WebDriver.ChromeDriver.win32.2.19.0.0\content" />

  <!-- Amount of time to wait for the Portal to load before timing out (seconds) -->
  <add key="TestFramework.Portal.PortalLoadTimeOut" value="60" />
  
  <!-- The uri of the target Portal server -->
  <add key="PortalUri" value="https://portal.azure.com" />
  
  <!-- The uri of your deployed extension -->
  <add key="ExtensionUri" value="https://mscompute2.iaas.ext.azure.com/ComputeContent/ComputeIndex" />
  
  <!-- The default webdriver server timeout for requests to be processed and returned (not the same as the waitUntil timeout) -->
  <add key="TestFramework.WebDriver.DefaultTimeout" value="60"/>
</appSettings>

```

1. Add a new Unit Test class and start writing your test case.

<a name="navigating-to-the-portal"></a>
### Navigating to the Portal

To navigate to the Portal, the extension supplies the Portal's uri.  We recommend setting the value in the `app.config` file as shown in [Creating the Test Project](#creating-the-test-project).  After the extension has the Portal uri, it can use the **WebDriverFactory.Create** method to create an instance of the `WebDriver` object and then use the **PortalAuthentication** class to login and navigate to the Portal in the browser, as in the following example.

   ```csharp

// Get the specified Portal Uri from the configuration file
var portalUri = new Uri(ConfigurationManager.AppSettings["PortalUri"]);
var extensionUri = new Uri(ConfigurationManager.AppSettings["ExtensionUri"]);

// Make sure the servers are available
PortalServer.WaitForServerReady(portalUri);
ExtensionsServer.WaitForServerReady(extensionUri);

// Create a webdriver instance to automate the browser.
var webDriver = WebDriverFactory.Create();

// Create a Portal Authentication class to handle login, note that the portalUri parameter is used to validate that login was successful.
var portalAuth = new PortalAuthentication(webDriver, portalUri);

//config#sideLoadingExtension
// Sign into the portal
portalAuth.SignInAndSkipPostValidation(userName: "", /** The account login to use.  Note Multi Factor Authentication (MFA) is not supported, you must use an account that does not require MFA **/
    password: "", /** The account password **/
    tenantDomainName: string.Empty, /** the tenant to login to, set only if you need to login to a specific tenant **/
    query: "feature.canmodifyextensions=true", /** Query string to use when navigating to the portal.  **/ 
    fragment: "#" /** The hash fragment, use this to optionally navigate directly to your resource on sign in. **/);

```

**NOTE**: Multi-factor authentication (MFA) is not supported.  You must use an account that does not require MFA.  If you are part of the Microsoft Azure organization, see the Azure Security Guidelines located at [https://aka.ms/portalfx/securityguidelines](https://aka.ms/portalfx/securityguidelines) for details on how to request an exception for an MSA/OrgID account.  You can not use a service account to login to the Azure Portal.

For more information about handling credentials, see [Managing authentication credentials](#Managing authentication credentials).

### Side-loading An Extension 

The Portal provides options for side-loading an extension for testing. To side-load an  extension on a `localhost` you can set a query string. To side-load a deployed extension, you can set the appropriate query strings and execute the `registerTestExtension` function.  For more information, see [top-extensions-sideloading.md](top-extensions-sideloading.md).

```csharp

// Sign into the portal
portalAuth.SignInAndSkipPostValidation(userName: "", /** The account login to use.  Note Multi Factor Authentication (MFA) is not supported, you must use an account that does not require MFA **/
    password: "", /** The account password **/
    tenantDomainName: string.Empty, /** the tenant to login to, set only if you need to login to a specific tenant **/
    query: "feature.canmodifyextensions=true", /** Query string to use when navigating to the portal.  **/ 
    fragment: "#" /** The hash fragment, use this to optionally navigate directly to your resource on sign in. **/);
//config#navigateToPortal

// Check for and click the Untrusted Extension prompt if its present
Microsoft.Portal.TestFramework.Portal.CheckAndClickExtensionTrustPrompt(webDriver);
var portal = Microsoft.Portal.TestFramework.Portal.FindPortal(webDriver, false);

// Register a deployed extension via javascript and then reload the portal.  Not required if using the query string method to load from localhost
(webDriver as IJavaScriptExecutor).ExecuteScript("MsPortalImpl.Extension.registerTestExtension({ name: \"SamplesExtension\", uri: \"https://df.onecloud.azure-test.net/Samples\"});");
portal.WaitForPortalToReload(() => webDriver.Navigate().Refresh());

// Check for and click the Untrusted Extension prompt if its present
Microsoft.Portal.TestFramework.Portal.CheckAndClickExtensionTrustPrompt(webDriver);
portal = Microsoft.Portal.TestFramework.Portal.FindPortal(webDriver, false);

```

Remember to dispose the `WebDriver` to cleanup, as in the following example.

```csharp

// Clean up the webdriver after
webDriver.Dispose();

```

### Managing authentication credentials 

While the test framework does not provide any support for managing login credentials, the following are some recommendations.

1.  If you are in the Azure org, please see the Azure Security guidelines that are located at [https://aka.ms/portalfx/securityguidelines](https://aka.ms/portalfx/securityguidelines)

1.  Do not store your credentials in the test code.

1.  Do not check in your credentials into your repository.

1.  Some possibilities for storing login credentials include:

   * Using the Windows Credential Store.

   * Using Azure Key Vault.

   * Write your own service for providing credentials.

### Full Sample Code

The  following code demonstrates navigating to the Portal for testing.

```

﻿//------------------------------------------------------------
// Copyright (c) Microsoft Corporation.  All rights reserved.
//------------------------------------------------------------

using System;
using System.Configuration;
using Microsoft.Portal.TestFramework.Core;
using Microsoft.Portal.TestFramework.Core.Authentication;
using Microsoft.Portal.TestFramework.Core.Shell;
using Microsoft.Selenium.Utilities;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenQA.Selenium;

namespace DocSampleTest
{
    [TestClass]
    public class NavigateToPortalTest
    {
        [TestMethod]
        public void NavigateToPortal()
        {
            //config#navigateToPortal
            // Get the specified Portal Uri from the configuration file
            var portalUri = new Uri(ConfigurationManager.AppSettings["PortalUri"]);
            var extensionUri = new Uri(ConfigurationManager.AppSettings["ExtensionUri"]);

            // Make sure the servers are available
            PortalServer.WaitForServerReady(portalUri);
            ExtensionsServer.WaitForServerReady(extensionUri);

            // Create a webdriver instance to automate the browser.
            var webDriver = WebDriverFactory.Create();

            // Create a Portal Authentication class to handle login, note that the portalUri parameter is used to validate that login was successful.
            var portalAuth = new PortalAuthentication(webDriver, portalUri);

            //config#sideLoadingExtension
            // Sign into the portal
            portalAuth.SignInAndSkipPostValidation(userName: "", /** The account login to use.  Note Multi Factor Authentication (MFA) is not supported, you must use an account that does not require MFA **/
                password: "", /** The account password **/
                tenantDomainName: string.Empty, /** the tenant to login to, set only if you need to login to a specific tenant **/
                query: "feature.canmodifyextensions=true", /** Query string to use when navigating to the portal.  **/ 
                fragment: "#" /** The hash fragment, use this to optionally navigate directly to your resource on sign in. **/);
            //config#navigateToPortal

            // Check for and click the Untrusted Extension prompt if its present
            Microsoft.Portal.TestFramework.Portal.CheckAndClickExtensionTrustPrompt(webDriver);
            var portal = Microsoft.Portal.TestFramework.Portal.FindPortal(webDriver, false);

            // Register a deployed extension via javascript and then reload the portal.  Not required if using the query string method to load from localhost
            (webDriver as IJavaScriptExecutor).ExecuteScript("MsPortalImpl.Extension.registerTestExtension({ name: \"SamplesExtension\", uri: \"https://df.onecloud.azure-test.net/Samples\"});");
            portal.WaitForPortalToReload(() => webDriver.Navigate().Refresh());

            // Check for and click the Untrusted Extension prompt if its present
            Microsoft.Portal.TestFramework.Portal.CheckAndClickExtensionTrustPrompt(webDriver);
            portal = Microsoft.Portal.TestFramework.Portal.FindPortal(webDriver, false);
            //config#sideLoadingExtension

            //config#dispose
            // Clean up the webdriver after
            webDriver.Dispose();
            //config#dispose
        }
    }
}

```
