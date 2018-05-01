
<a name="c-portal-test-framework"></a>
# C# Portal Test Framework

Please use the following links for info on how to use the C# Portal Test Framework.

  
<a name="c-portal-test-framework"></a>
# C# Portal Test Framework

Please use the following links for info on how to use the C# Portal Test Framework.

<a name="c-portal-test-framework-overview"></a>
## Overview

The C# test framework is a UI test framework built on top of the Selenium Webdriver C# bindings that are described in [https://www.seleniumhq.org/projects/webdriver](https://www.seleniumhq.org/projects/webdriver/).  Its primary goal is testing UI interactions in the Azure Portal.  

The C# test framework provides the following.

* A base for writing UI based Selenium webdriver tests.

* A suite of helpers for logging into, navigating, and manipulating controls, blades, and parts in the Portal

<a name="c-portal-test-framework-writing-tests"></a>
## Writing Tests

<a name="c-portal-test-framework-writing-tests-prerequisites"></a>
### Prerequisites

Prerequisites for using the C# test framework as as follows.

* Understanding of the C# programming language

* Nuget (https://www.nuget.org/) and [top-extensions-nuget.md](top-extensions-nuget.md)

* .NET Framework 4.5 or higher

* Visual Studio 2015 or higher, as specified in [top-extensions-install-software.md](top-extensions-install-software.md)

<a name="c-portal-test-framework-writing-tests-getting-started"></a>
### Getting Started

The C# Test framework is distributed as a NuGet package that is available in the Azure Official NuGet  feed [https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official](https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official).  There are two primary packages.

1. Microsoft.Portal.TestFramework

    It is located at [https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework&protocolType=NuGet&_a=package](https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework&protocolType=NuGet&_a=package)

1. Microsoft.Portal.TestFramework.Csharp

    It is located at [https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official&package=Microsoft.Portal.TestFramework.CSharp&protocolType=NuGet&_a=package](https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official&package=Microsoft.Portal.TestFramework.CSharp&protocolType=NuGet&_a=package)

    If you are just getting started, it is recommended to use the `Microsoft.Portal.TestFramework` NuGet package because it contains the necessary dependencies.  For more details about the two packages see [#understanding-the-differences-between-the-frameworks](#understanding-the-differences-between-the-frameworks).



<a name="c-portal-test-framework-writing-tests-creating-the-test-project"></a>
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

<a name="c-portal-test-framework-writing-tests-navigating-to-the-portal"></a>
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





##  Entering Data into Forms

Forms are commonly used to wrap textboxes, dropdowns and other types of input.  The test framework provides helpers to find a form and then find specific input fields in the form by the field label or fieldName.  The primary way to find form fields is to use the **FindField** method of the **FormSection** class, as in the following example.

1. The extension locates the form, as in the following code. In this example, the form contains two fields: a TextBox field and a Selector field.

    ```cs
    var portal = this.NavigateToPortal();

    portal.StartBoard.FindSinglePartByTitle<ButtonPart>("New Contact").Click();

    string contactName = "John Doe";

    string subscriptionName = "Portal Subscription 2";
    var blade = portal.FindSingleBladeByTitle("Basic Information");
    var form = webDriver.WaitUntil(() => blade.FindElement<FormSection>(), "Could not find the form.");
    ```

1. The following example supports validations. The user can enter text in the contactName `TextBox` field and wait until it is marked as Edited and Valid.

    ```cs
    string fieldName = "contactName";
    var field = webDriver.WaitUntil(() => form.FindField<Textbox>(fieldName),
                                    string.Format("Could not find the {0} textbox.", fieldName));
    field.Value = contactName + Keys.Tab;
    webDriver.WaitUntil(() => field.IsEdited && field.IsValid,
                        string.Format("The {0} field did not pass validations.", fieldName));
    ```

1. Find the Selector field and click it to open the associated picker blade.

    ```cs
    fieldName = "subscriptionField";
    form.FindField<Selector>(fieldName).Click();
    ```

1.  Select an item from the picker's grid and click the OK button to send the selection back to the form.

    ```cs
    blade = portal.FindSingleBladeByTitle("Select Subscription");

    var grid = webDriver.WaitUntil(blade.FindElement<Grid>, "Could not find the grid in the blade.");
    GridRow row = grid.SelectRow(subscriptionName);

    PickerActionBar pickerActionBar = webDriver.WaitUntil(() => blade.FindElement<PickerActionBar>(),
                                                        "Could not find the picker action bar.");
    webDriver.WaitUntil(() => pickerActionBar.OkButton.IsEnabled,
                        "Expected the OK Button of the Picker Action Bar to be enabled after selecting an item in the picker list.");
    pickerActionBar.ClickOk();
    ```

1. Click the Create button to complete the form and then look for a blade with the title of the created Contact to verify that it got created successfully.

    ```cs
    blade = portal.FindSingleBladeByTitle("Basic Information");

    CreateActionBar createActionBar = webDriver.WaitUntil(() => blade.FindElement<CreateActionBar>(),
                                                        "Could not find the create action bar.");
    createActionBar.ClickOk();

    portal.FindSingleBladeByTitle(contactName);
    ```

### Full Example

The entire example is in the following code.

<!-- Determine whether this is in the SDK or in the controls playground, or in the dogfood samples. -->

```cs
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Portal.TestFramework.Core;
using Microsoft.Selenium.Utilities;
using OpenQA.Selenium;
using Microsoft.Portal.TestFramework.Core.Shell;
using Microsoft.Portal.TestFramework.Core.Controls;

namespace SamplesExtensionTests
{
    [TestClass]
    public class Create
    {
        private const string SamplesExtensionUrl = "http://localhost:11997";
        private const string SamplesExtensionWebSitePath = @"d:\Users\julioct\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\Extension";
        private const string HubsExtensionUrl = "http://localhost:11998";
        private const string HubsExtensionWebSitePath = @"d:\Users\julioct\Documents\PortalSDK\FrameworkPortal\Extensions\HubsExtension";
        private static IWebDriver webDriver;
        private static PortalServer portalServer;
        private static WebServer samplesExtensionServer;
        private static WebServer hubsExtensionServer;

        [TestInitialize]
        public void TestInitialize()
        {
            hubsExtensionServer = new WebServer(new Uri(HubsExtensionUrl), HubsExtensionWebSitePath);
            if (hubsExtensionServer.IsHostedByTestFramework)
            {
                hubsExtensionServer.Start();
            }

            samplesExtensionServer = new WebServer(new Uri(SamplesExtensionUrl), SamplesExtensionWebSitePath);
            if (samplesExtensionServer.IsHostedByTestFramework)
            {
                samplesExtensionServer.Start();
            }

            portalServer = PortalServer.Create();

            if (portalServer.IsHostedByTestFramework)
            {
                portalServer.RegisterExtension("Hubs", new Uri(hubsExtensionServer.Uri));
                portalServer.RegisterExtension("Samples", new Uri(samplesExtensionServer.Uri));
                portalServer.Start();
            }

            webDriver = WebDriverFactory.Create();
            webDriver.Url = "about:blank";
            portalServer.ClearUserSettings();
        }

        [TestMethod]
        public void CanCreateContact()
        {
            var portal = this.NavigateToPortal();

            // Open and find the Create Form
            portal.StartBoard.FindSinglePartByTitle<ButtonPart>("New Contact").Click();

            string contactName = "John Doe";
            string subscriptionName = "Portal Subscription 2";

            var blade = portal.FindSingleBladeByTitle("Basic Information");
            var form = webDriver.WaitUntil(() => blade.FindElement<FormSection>(), "Could not find the form.");

            // Fill a textbox field
            string fieldName = "contactName";
            var field = webDriver.WaitUntil(() => form.FindField<Textbox>(fieldName),
                                            string.Format("Could not find the {0} textbox.", fieldName));
            field.Value = contactName + Keys.Tab;
            webDriver.WaitUntil(() => field.IsEdited && field.IsValid,
                                string.Format("The {0} field did not pass validations.", fieldName));

            // Open a picker from a selector field and select an item
            fieldName = "subscriptionField";
            form.FindField<Selector>(fieldName).Click();

            blade = portal.FindSingleBladeByTitle("Select Subscription");

            var grid = webDriver.WaitUntil(blade.FindElement<Grid>, "Could not find the grid in the blade.");
            GridRow row = grid.SelectRow(subscriptionName);

            PickerActionBar pickerActionBar = webDriver.WaitUntil(() => blade.FindElement<PickerActionBar>(),
                                                                "Could not find the picker action bar.");
            webDriver.WaitUntil(() => pickerActionBar.OkButton.IsEnabled,
                                "Expected the OK Button of the Picker Action Bar to be enabled after selecting an item in the picker list.");
            pickerActionBar.ClickOk();

            // Click the Create button
            blade = portal.FindSingleBladeByTitle("Basic Information");

            CreateActionBar createActionBar = webDriver.WaitUntil(() => blade.FindElement<CreateActionBar>(),
                                                                "Could not find the create action bar.");
            createActionBar.ClickOk();

            // There should be an open blade with 'John Doe' as its title
            portal.FindSingleBladeByTitle(contactName);
        }

        [TestCleanup]
        public void TestCleanup()
        {
            webDriver.Dispose();
            portalServer.Dispose();
            samplesExtensionServer.Dispose();
            hubsExtensionServer.Dispose();
        }
    }
}
```


## Testing Commands

The Test Framework provides objects to interact with commands both from the command bar and context menus.

### To use commands from the command bar

Use the **Blade.FindCommandBar** method to get an instance of the Command Bar and then the **CommandBar.FindCommandBarItem** method to find the relevant command, as in the following example.

```cs
var blade = portal.FindSingleBladeByTitle(contactName);

CommandBar commandBar = blade.FindCommandBar();

var command = commandBar.FindCommandBarItem("DELETE");
```

After the  Click() method on the command is called, the extension may display a messageBox to show a message to the user. The extension can interact with the messageBox using the **CommandBar.FindMessageBox** method and the **MessageBox.ClickButton** method, as in the following example.

```cs
command.Click();

commandBar.FindMessageBox("Delete contact").ClickButton("Yes");
webDriver.WaitUntil(() => !commandBar.HasMessageBox, "There is still a message box in the command bar.");
```

### To use commands from context menus

Use the following steps to use Selenium's **Actions** class to perform a contextual click on the desired web element.

1. Find a grid row that has a context menu to open.

    ```cs
    var portal = this.NavigateToPortal();

    string contactName = "Jane Doe";
    string subscriptionName = "Portal Subscription 2";

    this.ProvisionContact(contactName, subscriptionName, portal);

    portal.StartBoard.FindSinglePartByTitle("Contacts").Click();
    var blade = portal.FindSingleBladeByTitle("Contacts List");
    var grid = webDriver.WaitUntil(() => blade.FindElement<Grid>(), "Could not find the grid.");
    GridRow row = webDriver.WaitUntil(() => grid.FindRow(contactName), "Could not find the contact row.");
    ```

1. Open the context menu.

    ```cs
    Actions actions = new Actions(webDriver);
    actions.ContextClick(row);
    actions.Perform();
    ```

1. Find the context menu and use the **ContextMenu.FindContextMenuItemByText** method to find the actual command to click.

    ```cs
    ContextMenuItem menuItem = webDriver.WaitUntil(() => webDriver.FindElement<ContextMenu>(),
                                                "Could not find the context menu.")
                                        .FindContextMenuItemByText("Delete");
    ```

1. Deal with the message box to verify that this Contact was deleted.

    ```cs
    menuItem.Click();

    portal.FindMessageBox("Delete contact").ClickButton("Yes");

    webDriver.WaitUntil(() => !portal.HasMessageBox, "There is still a message box in the Portal.");

    portal.StartBoard.FindSinglePartByTitle("Deleted");
    ```

### Full example

The entire example is in the following code.

```cs
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Portal.TestFramework.Core;
using Microsoft.Selenium.Utilities;
using OpenQA.Selenium;
using Microsoft.Portal.TestFramework.Core.Shell;
using Microsoft.Portal.TestFramework.Core.Controls;
using OpenQA.Selenium.Interactions;

namespace SamplesExtensionTests
{
    [TestClass]
    public class Commands
    {
        private const string SamplesExtensionUrl = "http://localhost:11997";
        private const string SamplesExtensionWebSitePath = @"d:\Users\julioct\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\Extension";
        private const string HubsExtensionUrl = "http://localhost:11998";
        private const string HubsExtensionWebSitePath = @"d:\Users\julioct\Documents\PortalSDK\FrameworkPortal\Extensions\HubsExtension";
        private static IWebDriver webDriver;
        private static PortalServer portalServer;
        private static WebServer samplesExtensionServer;
        private static WebServer hubsExtensionServer;

        [TestInitialize]
        public void TestInitialize()
        {
            hubsExtensionServer = new WebServer(new Uri(HubsExtensionUrl), HubsExtensionWebSitePath);
            if (hubsExtensionServer.IsHostedByTestFramework)
            {
                hubsExtensionServer.Start();
            }

            samplesExtensionServer = new WebServer(new Uri(SamplesExtensionUrl), SamplesExtensionWebSitePath);
            if (samplesExtensionServer.IsHostedByTestFramework)
            {
                samplesExtensionServer.Start();
            }

            portalServer = PortalServer.Create();

            if (portalServer.IsHostedByTestFramework)
            {
                portalServer.RegisterExtension("Hubs", new Uri(hubsExtensionServer.Uri));
                portalServer.RegisterExtension("Samples", new Uri(samplesExtensionServer.Uri));
                portalServer.Start();
            }

            webDriver = WebDriverFactory.Create();
            webDriver.Url = "about:blank";
            portalServer.ClearUserSettings();
        }

        [TestMethod]
        public void CanDeleteContactFromBlade()
        {
            var portal = this.NavigateToPortal();

            string contactName = "John Doe";
            string subscriptionName = "Portal Subscription 2";

            this.ProvisionContact(contactName, subscriptionName, portal);

            var blade = portal.FindSingleBladeByTitle(contactName);

            CommandBar commandBar = blade.FindCommandBar();

            var command = commandBar.FindCommandBarItem("DELETE");
            command.Click();

            commandBar.FindMessageBox("Delete contact").ClickButton("Yes");
            webDriver.WaitUntil(() => !commandBar.HasMessageBox,
								"There is still a message box in the command bar.");

            portal.StartBoard.FindSinglePartByTitle("Deleted");
        }

        [TestMethod]
        public void CanDeleteContactFromGrid()
        {
            var portal = this.NavigateToPortal();

            string contactName = "Jane Doe";
            string subscriptionName = "Portal Subscription 2";

            this.ProvisionContact(contactName, subscriptionName, portal);

            portal.StartBoard.FindSinglePartByTitle("Contacts").Click();
            var blade = portal.FindSingleBladeByTitle("Contacts List");
            var grid = webDriver.WaitUntil(() => blade.FindElement<Grid>(), "Could not find the grid.");
            GridRow row = webDriver.WaitUntil(() => grid.FindRow(contactName), "Could not find the contact row.");

            Actions actions = new Actions(webDriver);
            actions.ContextClick(row);
            actions.Perform();

            ContextMenuItem menuItem = webDriver.WaitUntil(() => webDriver.FindElement<ContextMenu>(),
                                                           "Could not find the context menu.")
                                                .FindContextMenuItemByText("Delete");
            menuItem.Click();

            portal.FindMessageBox("Delete contact").ClickButton("Yes");

            webDriver.WaitUntil(() => !portal.HasMessageBox, "There is still a message box in the Portal.");

            portal.StartBoard.FindSinglePartByTitle("Deleted");
        }

        [TestCleanup]
        public void TestCleanup()
        {
            webDriver.Dispose();
            portalServer.Dispose();
            samplesExtensionServer.Dispose();
            hubsExtensionServer.Dispose();
        }

        private void ProvisionContact(string contactName, string subscriptionName, Portal portal)
        {
            // Open and find the Create Form
            portal.StartBoard.FindSinglePartByTitle<ButtonPart>("New Contact").Click();

            var blade = portal.FindSingleBladeByTitle("Basic Information");
            var form = webDriver.WaitUntil(() => blade.FindElement<FormSection>(), "Could not find the form.");

            // Fill a textbox field
            string fieldName = "contactName";
            var field = webDriver.WaitUntil(() => form.FindField<Textbox>(fieldName),
											string.Format("Could not find the {0} textbox.", fieldName));
            field.Value = contactName + Keys.Tab;
            webDriver.WaitUntil(() => field.IsEdited && field.IsValid,
								string.Format("The {0} field did not pass validations.", fieldName));

            // Open a picker from a selector field and select an item
            fieldName = "subscriptionField";
            form.FindField<Selector>(fieldName).Click();

            blade = portal.FindSingleBladeByTitle("Select Subscription");

            var grid = webDriver.WaitUntil(blade.FindElement<Grid>, "Could not find the grid in the blade.");
            GridRow row = grid.SelectRow(subscriptionName);

            PickerActionBar pickerActionBar = webDriver.WaitUntil(() => blade.FindElement<PickerActionBar>(),
																  "Could not find the picker action bar.");
            webDriver.WaitUntil(() => pickerActionBar.OkButton.IsEnabled,
								"Expected the OK Button of the Picker Action Bar to be enabled after selecting an item in the picker list.");
            pickerActionBar.ClickOk();

            // Click the Create button
            blade = portal.FindSingleBladeByTitle("Basic Information");

            CreateActionBar createActionBar = webDriver.WaitUntil(() => blade.FindElement<CreateActionBar>(),
																  "Could not find the create action bar.");
            createActionBar.ClickOk();

            // There should be an open blade with 'John Doe' as its title
            portal.FindSingleBladeByTitle(contactName);
        }
    }
}

```


## Taking Screenshots while Testing

The Test Framework provides built-in support for taking screenshots from test cases. You can use the **WebDriver.TakeScreenshot** method to take the screenshot and save it as a PNG file to the local disk. You can do this at any point within the test case, but a typical approach is to do it at least in the test `CleanUp` method when the outcome of the test case is not "Passed" or if an assertion fails, as in the following example.

```cs
[TestCleanup]
public void TestCleanup()
{
    if (TestContext.CurrentTestOutcome != UnitTestOutcome.Passed && webDriver != null)
    {
        TestContext.AddResultFile(webDriver.TakeScreenshot(TestContext.TestRunResultsDirectory,
														   TestContext.TestName));
    }

    webDriver.Dispose();
    portalServer.Dispose();
    samplesExtensionServer.Dispose();
}
```

### Full example

The following example contains all the code for the test.

```cs
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Portal.TestFramework.Core;
using Microsoft.Selenium.Utilities;
using OpenQA.Selenium;
using Microsoft.Portal.TestFramework.Core.Shell;

namespace SamplesExtensionTests
{
    [TestClass]
    public class Screenshots
    {
        public TestContext TestContext { get; set; }

        private const string SamplesExtensionUrl = "http://localhost:11997";
        private const string SamplesExtensionWebSitePath = @"d:\Users\julioct\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\Extension";
        private static IWebDriver webDriver;
        private static PortalServer portalServer;
        private static WebServer samplesExtensionServer;

        [TestInitialize]
        public void TestInitialize()
        {
            samplesExtensionServer = new WebServer(new Uri(SamplesExtensionUrl), SamplesExtensionWebSitePath);
            if (samplesExtensionServer.IsHostedByTestFramework)
            {
                samplesExtensionServer.Start();
            }

            portalServer = PortalServer.Create();

            if (portalServer.IsHostedByTestFramework)
            {
                portalServer.RegisterExtension("Samples", new Uri(samplesExtensionServer.Uri));
                portalServer.Start();
            }

            webDriver = WebDriverFactory.Create();
            webDriver.Url = "about:blank";
            portalServer.ClearUserSettings();
        }

        [TestMethod]
        public void CanFindSamplesPart()
        {
            var portal = this.NavigateToPortal();

            // Intentional mistake. There is no part with this title in the StartBoard,
            // so the call to FindSinglePartByTitle will fail
            string samplesTitle = "The Samples";

            var samplesPart = portal.StartBoard.FindSinglePartByTitle<ButtonPart>(samplesTitle);
            samplesPart.Click();
        }

        [TestCleanup]
        public void TestCleanup()
        {
            if (TestContext.CurrentTestOutcome != UnitTestOutcome.Passed && webDriver != null)
            {
                TestContext.AddResultFile(webDriver.TakeScreenshot(TestContext.TestRunResultsDirectory,
																   TestContext.TestName));
            }

            webDriver.Dispose();
            portalServer.Dispose();
            samplesExtensionServer.Dispose();
        }
    }
}
```

### Loading a subset of extensions

There are some instances during test where you may want to only load your extension or a subset of extensions within the Portal. You can do this using the `feature.DisableExtensions` feature flag.
Usage is as follows.

```
?feature.DisableExtensions=true&HubsExtension=true&Microsoft_Azure_Support=true&MyOtherExtension=true
```

*  This will make every extension disabled by default.
*  This will enable hubs, which are used by most developers 
*  This will enable the particular extension you want to test.
*  You can add multiple like the` HubsExtension=true and MyOtherExtension=true` if you want to test other extensions.

### Disabling a specific extension

If you want to disable a single extension, you can use the `canmodifyextensions` feature flag as in the following code.
`?feature.canmodifyextensions=true&ExtensionNameToDisable=false`

For example, you want to turn off an old extension and turn on a new one. You can do this as follows.
```
?feature.canmodifyextensions=true&MyOldExtension=false&MyNewExtension=true
```


<a name="c-portal-test-framework-contributing-to-c-typescript-test-framework"></a>
## Contributing to C# Typescript Test Framework

Contributions that improve the Test Framework are welcome, because they keep the code base healthy.  When you have improvements to contribute back to the Typescript Test Framework, use the following steps to enlist into the list of contributors and submit a pull request. If you are unfamiliar with pull requests in Github, please review the help documentation located at [https://help.github.com/articles/about-pull-requests/](https://help.github.com/articles/about-pull-requests/). The pull request instructions are located at [top-extensions-publishing.md](top-extensions-publishing.md), with the following additions.

1. The Test Framework uses a different `<repoRoot>`
1. The Test Framework is not associated with the production extension branches
1. You may or may not want to set up a new local git repository specifically for test framework improvements 
1. The configuration files must be modified to match the test framework environment

<!-- TODO: Determine which Azure group is represented by the word  "we" -->
* **NOTE**: We may test the improvement changes with our internal repository's test suites before accepting the pull request.

**NOTE**: Please note that the opportunity to contribute to the  test framework is only available to first-party extension developers, i.e., Microsoft employees.

<a name="c-portal-test-framework-contributing-to-c-typescript-test-framework-enlisting-into-the-repository"></a>
### Enlisting into the repository

The repository is hosted in Azure's GitHub organization.  The instructions for requesting access to the Azure Github organization are located at [https://repos.opensource.microsoft.com/](https://repos.opensource.microsoft.com/).

Once you have joined the Azure Github organization, you can request access to the msportalfx-test team by using the site located at [https://repos.opensource.microsoft.com/Azure/teams/msportalfx-test](https://repos.opensource.microsoft.com/Azure/teams/msportalfx-test).

The **GitHub** repository is located at  [https://github.com/Azure/msportalfx-test/](https://github.com/Azure/msportalfx-test/).

 In this discussion, `<repoRoot>` is this git repository.

The test framework code can be viewed at `<repoRoot>/src`.

<a name="c-portal-test-framework-contributing-to-c-typescript-test-framework-making-changes-and-building-the-improvement"></a>
### Making changes and building the improvement

The prerequisites are as follows. 

* Node 4.4, 4.5, or 5.1. Newer versions may not work.

   We recommend that you use Node.js Version Management (NVM) that is located at [https://github.com/coreybutler/nvm-windows](https://github.com/coreybutler/nvm-windows) and [https://github.com/coreybutler/nvm-windows/releases](https://github.com/coreybutler/nvm-windows/releases)  to manage your node versions.

*  Typescript 2.1 for Visual Studio 2015 

    The download is located at [https://www.microsoft.com/en-us/download/details.aspx?id=48593](https://www.microsoft.com/en-us/download/details.aspx?id=48593) for  Visual Studio.

To make changes and build your improvement, first you need to initialize your repository by running "npm install --no-optional" at `<repoRoot>`.   Once your repo is initialized, you can make your changes and then run "npm run build" at the repository root.  The build output will be available under `\lib`.

<a name="c-portal-test-framework-contributing-to-c-typescript-test-framework-testing-the-improvement"></a>
### Testing the improvement

The `MsPortalfx-Test` Typescript Test Framework includes a set of tests for basic verification.  To run the tests, you need to push your improvement to a feature branch, also known as a private branch.  Once your improvement is in a feature branch, you can navigate to PortalFXOnDemand that is located at [https://portalfxod.azure-test.net/view/MsPortalfx-Test/job/OnDemand-MsPortalFxTest/build?delay=0sec](https://portalfxod.azure-test.net/view/MsPortalfx-Test/job/OnDemand-MsPortalFxTest/build?delay=0sec) and fill in your feature branch name in the "MsPortalFxTestBranchName" field to run your tests.  You should get an email when it is complete.  

For more information about feature branches, see [https://gist.github.com/vlandham/3b2b79c40bc7353ae95a](https://gist.github.com/vlandham/3b2b79c40bc7353ae95a).

<a name="c-portal-test-framework-contributing-to-c-typescript-test-framework-troubleshooting"></a>
### Troubleshooting

<a name="c-portal-test-framework-contributing-to-c-typescript-test-framework-troubleshooting-repo-sync-and-auth-errors"></a>
#### Repo sync and auth errors

If you are seeing authentication errors, try creating and using a personal access token as described in [https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/).

<a name="c-portal-test-framework-contributing-to-c-typescript-test-framework-troubleshooting-other-issues"></a>
#### Other issues
If issues are encountered while developing the improvement, please search the internal StackOverflow that is located at [http://stackoverflow.microsoft.com](http://stackoverflow.microsoft.com) first.

 If you are unable to find an answer, reach out to the Ibiza team at  [Stackoverflow Ibiza Test](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza-test). 

 For a list of topics and stackoverflow tags, see [portalfx-stackoverflow.md](portalfx-stackoverflow.md).



<a name="c-portal-test-framework-glossary"></a>
## Glossary
   
This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term                         | Meaning |
| ---                          | --- |
| idempotent         |  An operation whose result does not change after the initial application. For example, if the client needs to retry a request due to intermittent network issues, the same value will be sent to the server.  This allows the server to ignore the retry if it has already been processed. Even if the request is ignored, the same response will be returned if the client needs the values in the response. |
| query string |  `uri` used for accessing the Azure Portal |
| sideloading  | Loading an extension for a specific user session from any source other than the uri` that is registered in the Portal.  The process of transferring data between two local devices, or between the development platform and the local host. Also side load, side-load. |   
| untrusted extension | An extension that is not accompanied by an SSL certificate. |




 
   
   The page you requested has moved to [portalfx-csharp-test-commands.md](portalfx-csharp-test-commands.md). 



  
The page you requested has moved to [portalfx-csharp-test-filling-forms.md](portalfx-csharp-test-filling-forms.md). 

  
   The page you requested has moved to [portalfx-csharp-test-commands.md](portalfx-csharp-test-commands.md). 




   The page you requested has moved to [portalfx-csharp-test-screenshots.md](portalfx-csharp-test-screenshots.md). 







<a name="c-portal-test-framework-glossary"></a>
## Glossary
   
This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).
 
| Term                         | Meaning |
| ---                          | --- |
| idempotent         |  An operation whose result does not change after the initial application. For example, if the client needs to retry a request due to intermittent network issues, the same value will be sent to the server.  This allows the server to ignore the retry if it has already been processed. Even if the request is ignored, the same response will be returned if the client needs the values in the response. |
| query string |  `uri` used for accessing the Azure Portal |
| sideloading  | Loading an extension for a specific user session from any source other than the uri` that is registered in the Portal.  The process of transferring data between two local devices, or between the development platform and the local host. Also side load, side-load. |   
| untrusted extension | An extension that is not accompanied by an SSL certificate. |

