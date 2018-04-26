
<a name="c-portal-test-framework"></a>
# C# Portal Test Framework

Please use the following links for info on how to use the C# Portal Test Framework.

  
<a name="c-portal-test-framework-overview"></a>
## Overview

The C# test framework is a UI test framework built on top of the Selenium Webdriver C# bindings that are described in [https://www.seleniumhq.org/projects/webdriver](https://www.seleniumhq.org/projects/webdriver/).  Its primary goal is testing UI interactions in the Azure Portal.  

The C# test framework provides the following.

* A base for writing UI based Selenium webdriver tests.

* A suite of helpers for logging into, navigating, and manipulating controls, blades, and parts in the Portal

Writing Tests

<a name="c-portal-test-framework-overview-prerequisites"></a>
### Prerequisites

Prerequisites for using the C# test framework as as follows.

* Understanding of the C# programming language

* Nuget (https://www.nuget.org/) and [top-extensions-nuget.md](top-extensions-nuget.md)

* .NET Framework 4.5 or higher

* Visual Studio 2015 or higher, as specified in [top-extensions-install-software.md](top-extensions-install-software.md)

<a name="c-portal-test-framework-overview-getting-started"></a>
### Getting Started

The C# Test framework is distributed as a nuget package that is available in the Azure Official nuget feed [https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official](https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official).  There are two primary packages.

1. Microsoft.Portal.TestFramework

    It is located at [https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework&protocolType=NuGet&_a=package](https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework&protocolType=NuGet&_a=package)

1. Microsoft.Portal.TestFramework.Csharp

    It is located at [https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official&package=Microsoft.Portal.TestFramework.CSharp&protocolType=NuGet&_a=package](https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official&package=Microsoft.Portal.TestFramework.CSharp&protocolType=NuGet&_a=package)

    It is recommended to use the `Microsoft.Portal.TestFramework` nuget package because it contains the necessary dependencies.  For more details about the two packages see [#understanding-the-differences-between-the-frameworks](#understanding-the-differences-between-the-frameworks).

<a name="c-portal-test-framework-overview-creating-the-test-project"></a>
### Creating the Test Project

To create a test project that can use the Portal Test Framework, use the following steps.

1. Create a new Visual Studio Unit Test Project.

1. Install the NuGet Package Microsoft.Portal.TestFramework that is located at  [https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework&protocolType=NuGet&_a=package](https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework&protocolType=NuGet&_a=package).

1. If your test cases involve the Azure Marketplace, also install the `Microsoft.Portal.TestFramework.MarketplaceUtilities` package that is located at  [https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework.MarketplaceUtilities&protocolType=NuGet&_a=package](https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework.MarketplaceUtilities&protocolType=NuGet&_a=package), which contains Selenium classes for elements in the Azure Marketplace.

1. Add an `app.config` file to your test project and define the basic Test Framework settings under appSettings, as in the following code.
    ```
        <appSettings>
    <!-- Browser type. "Chrome", "IE" -->
    <add key="TestFramework.WebDriver.Browser" value="Chrome" />
    <add key="TestFramework.WebDriver.DirectoryPath" value="<folder that contains chromedriver.exe>" />
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

<a name="c-portal-test-framework-overview-navigating-to-the-portal"></a>
### Navigating to the Portal

To navigate to the Portal in your test, you first must supply the Portal's Uri. We recommend setting the value in the app.config file as shown above. Once you have the Portal Uri, you can use the WebDriverFactory.Create method to create an instance of the WebDriver object and then use the PortalAuthentication class to login, navigate to the Portal in the browser.
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
See [Managing authentication credentials](#Managing authentication credentials) for some FAQs with handling credentials.
Please note that multi factor authentication (MFA) is not supported, you must use an account that does not require MFA. If you are part of the Microsoft Azure organization please see Azure Security Guidelines for details on how to request an exception for an MSA/OrgID account.
Loading your extension from a different URL (side loading)
The Portal provides options for side loading your extension for testing. To side load your extension you need to set the appropriate query strings and execute the registerTestExtension function. An example of side loading a deployed extension can be seen below.  See [Testing in Production](#Testing in production) for details.
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
	// Register a deployed extension via javascript and then reload the portal.  
(webDriver as IJavaScriptExecutor).ExecuteScript("MsPortalImpl.Extension.registerTestExtension({ name: \"SamplesExtension\", uri: \"https://df.onecloud.azure-test.net/Samples\"});");
portal.WaitForPortalToReload(() => webDriver.Navigate().Refresh());
	// Check for and click the Untrusted Extension prompt if its present
Microsoft.Portal.TestFramework.Portal.CheckAndClickExtensionTrustPrompt(webDriver);
portal = Microsoft.Portal.TestFramework.Portal.FindPortal(webDriver, false);
Finally, you should dispose the WebDriver to cleanup:
	// Clean up the webdriver after
webDriver.Dispose();

Managing authentication credentials (unsupported)
While the test framework does not provide any support for managing login credentials, there are some recommendations:
	1. If you are in the Azure org, please see Azure Security guidelines
	2. Do not store your credentials in the test code.
	3. Do not check in your credentials into your repository.
	4. Some possibilities for storing login credentials include:
		1. Using the Windows Credential Store.
		2. Using Azure Key Vault.
		3. Write your own service for providing credentials.

Full Sample Code
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
Testing: Parts and Blades
Once you have an instance of the Portal object you can find parts on the StartBoard using the Portal.StartBoard.FindSinglePartByTitle method. The method will give you a an instance of the Part class that you can use to perform actions on the part, like clicking on it:
var portal = this.NavigateToPortal();
string samplesTitle = "Samples";
var samplesPart = portal.StartBoard.FindSinglePartByTitle<ButtonPart>(samplesTitle);
samplesPart.Click();
You can find blades in a similar way using the Portal.FindSingleBladeByTitle method and then find parts within the blade using the Blade.FindSinglePartByTitle method:
var blade = portal.FindSingleBladeByTitle(samplesTitle);
string sampleName = "Notifications";
blade.FindSinglePartByTitle(sampleName).Click();
blade = portal.FindSingleBladeByTitle(sampleName);
If you need to find parts based on different conditions other than the part's title you can do so by using the FindElement or FindElements methods on any web element:
var errorPart = webDriver.WaitUntil(() => blade.FindElements<Part>()
                                               .FirstOrDefault(p => p.Text.Contains("Send Error")),
									"Could not find a part with a Send Error text.");

Notice the use of the WebDriver.WaitUntil method as a general and recommended mechanism to ask the WebDriver to retry an operation until a condition succeeds. In this case, the test case "waits until it can find a part within the blade that has text that contains the 'Send Error' string". Once it can find such part it is returned to the errorPart variable, or if it can't find it after the default timeout (10 seconds) it will throw an exception with the text specified in the last parameter.  See [Testing Best Practices](#Testing Best Practices)
You can also use classic Selenium WebDriver syntax to find any element based on a By selector. For example, this will find a single button element within the found part:
webDriver.WaitUntil(() => errorPart.FindElement(By.TagName("button")),
					"Could not find the button.")
	     .Click();
Full example
using System;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Portal.TestFramework.Core;
using Microsoft.Selenium.Utilities;
using OpenQA.Selenium;
using Microsoft.Portal.TestFramework.Core.Shell;
namespace SamplesExtensionTests
{
    [TestClass]
    public class PartsAndBlades
    {
        private const string ExtensionUrl = "http://localhost:11998";
        private const string ExtensionWebSitePath = @"d:\Users\julioct\Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension\Extension";
        private static IWebDriver webDriver;
        private static PortalServer portalServer;
        private static WebServer extensionServer;
[TestInitialize]
        public void TestInitialize()
        {
            extensionServer = new WebServer(new Uri(ExtensionUrl), ExtensionWebSitePath);
            if (extensionServer.IsHostedByTestFramework)
            {
                extensionServer.Start();
            }
portalServer = PortalServer.Create();
if (portalServer.IsHostedByTestFramework)
            {
                portalServer.RegisterExtension("Samples", new Uri(extensionServer.Uri));
                portalServer.Start();
            }
webDriver = WebDriverFactory.Create();
            webDriver.Url = "about:blank";
            portalServer.ClearUserSettings();
        }
[TestMethod]
        public void CanFindPartsAndBlades()
        {
            var portal = this.NavigateToPortal();
string samplesTitle = "Samples";
var samplesPart = portal.StartBoard.FindSinglePartByTitle<ButtonPart>(samplesTitle);
            samplesPart.Click();
var blade = portal.FindSingleBladeByTitle(samplesTitle);
string sampleName = "Notifications";
blade.FindSinglePartByTitle(sampleName).Click();
blade = portal.FindSingleBladeByTitle(sampleName);
var errorPart = webDriver.WaitUntil(() => blade.FindElements<Part>()
														   .FirstOrDefault(p => p.Text.Contains("Send Error")),
												"Could not find a part with a 'Send Error' text.");
webDriver.WaitUntil(() => errorPart.FindElement(By.TagName("button")),
								"Could not find the button.")
					 .Click();
        }
[TestCleanup]
        public void TestCleanup()
        {
            webDriver.Dispose();
            portalServer.Dispose();
            extensionServer.Dispose();
        }
    }
}
Testing: Filling Out Forms
Forms are commonly used to wrap textboxes, dropdowns and other types of input (but not always).  The test framework provides helpers to find a form and then find specific input fields in the form by the field's label (also known as fieldName).  The primary way to find form fields is to use the FindField method of the FormSection class.  Here's an example below
First, let's find the form:
var portal = this.NavigateToPortal();
portal.StartBoard.FindSinglePartByTitle<ButtonPart>("New Contact").Click();
string contactName = "John Doe";
string subscriptionName = "Portal Subscription 2";
var blade = portal.FindSingleBladeByTitle("Basic Information");
var form = webDriver.WaitUntil(() => blade.FindElement<FormSection>(), "Could not find the form.");
In this example, the form has 2 fields, a TextBox field and a Selector field. Let's enter some text in the contactName text box field and wait until it is marked as Edited and Valid (since it supports validations):
string fieldName = "contactName";
var field = webDriver.WaitUntil(() => form.FindField<Textbox>(fieldName),
								string.Format("Could not find the {0} textbox.", fieldName));
field.Value = contactName + Keys.Tab;
webDriver.WaitUntil(() => field.IsEdited && field.IsValid,
					string.Format("The {0} field did not pass validations.", fieldName));
Now, let's find the Selector field and click it to open the associated picker blade:
fieldName = "subscriptionField";
form.FindField<Selector>(fieldName).Click();
Let's select an item from the picker's grid and click the OK button to send the selection back to the form:
blade = portal.FindSingleBladeByTitle("Select Subscription");
var grid = webDriver.WaitUntil(blade.FindElement<Grid>, "Could not find the grid in the blade.");
GridRow row = grid.SelectRow(subscriptionName);
PickerActionBar pickerActionBar = webDriver.WaitUntil(() => blade.FindElement<PickerActionBar>(),
													  "Could not find the picker action bar.");
webDriver.WaitUntil(() => pickerActionBar.OkButton.IsEnabled,
					"Expected the OK Button of the Picker Action Bar to be enabled after selecting an item in the picker list.");
pickerActionBar.ClickOk();
Finally, let's click the Create button to complete the form and then look for a blade with the title of the created Contact to verify that it got created successfully:
blade = portal.FindSingleBladeByTitle("Basic Information");
CreateActionBar createActionBar = webDriver.WaitUntil(() => blade.FindElement<CreateActionBar>(),
													  "Could not find the create action bar.");
createActionBar.ClickOk();
portal.FindSingleBladeByTitle(contactName);
Full Example
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
Testing: Commands
The Test Framework provides objects to interact with commands both from the command bar and context menus.
To use commands from the command bar
Use the Blade.FindCommandBar method to get an instance of the Command Bar and then the CommandBar.FindCommandBarItem method to find the relevant command:
var blade = portal.FindSingleBladeByTitle(contactName);
CommandBar commandBar = blade.FindCommandBar();
var command = commandBar.FindCommandBarItem("DELETE");
Once you call Click() on the command it could be that it opens a message box to show some message to the user. You can interact with that message box using the CommandBar.FindMessageBox method and the MessageBox.ClickButton method:
command.Click();
commandBar.FindMessageBox("Delete contact").ClickButton("Yes");
webDriver.WaitUntil(() => !commandBar.HasMessageBox, "There is still a message box in the command bar.");
To use commands from context menus
To do this you can first use Selenium's Actions class to perform a contextual click on the desired web element. Let's first find a grid row where we want to open the context menu:
var portal = this.NavigateToPortal();
string contactName = "Jane Doe";
string subscriptionName = "Portal Subscription 2";
this.ProvisionContact(contactName, subscriptionName, portal);
portal.StartBoard.FindSinglePartByTitle("Contacts").Click();
var blade = portal.FindSingleBladeByTitle("Contacts List");
var grid = webDriver.WaitUntil(() => blade.FindElement<Grid>(), "Could not find the grid.");
GridRow row = webDriver.WaitUntil(() => grid.FindRow(contactName), "Could not find the contact row.");
Now let's open the context menu:
Actions actions = new Actions(webDriver);
actions.ContextClick(row);
actions.Perform();
Then find the context menu and use the ContextMenu.FindContextMenuItemByText method to find the actual command to click:
ContextMenuItem menuItem = webDriver.WaitUntil(() => webDriver.FindElement<ContextMenu>(),
                                               "Could not find the context menu.")
                                    .FindContextMenuItemByText("Delete");
Finally, let's deal with the message box and verify that this Contact got deleted:
menuItem.Click();
portal.FindMessageBox("Delete contact").ClickButton("Yes");
webDriver.WaitUntil(() => !portal.HasMessageBox, "There is still a message box in the Portal.");
portal.StartBoard.FindSinglePartByTitle("Deleted");
Full example
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
Taking Screenshots while Testing
The Test Framework provides built in support for taking screenshots from test cases. You can use the WebDriver.TakeScreenshot method to take the screenshot and save it as a PNG file to the local disk. You can do this at any point within the test case, but a typical approach is to do it at least in the test CleanUp method when the outcome of the test case is not "Passed" or if an assertion fails.
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
Full example
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
Loading a Subset of Extensions
There are some instances during test where you may want to only load your extension or a subset of extensions within the portal. You can do this using the feature.DisableExtensions feature flag.
Usage:
?feature.DisableExtensions=true&HubsExtension=true&Microsoft_Azure_Support=true&MyOtherExtension=true
	• This will make every extension disabled by default.
	• This will enable hubs (which almost everyone needs).
	• This will enable the particular extension you want to test.
	• You can add multiple like the HubsExtension=true and MyOtherExtension=true if you want to test other extensions.
Disabling a specific extension
If you want to disable a single extension, you can use the canmodifyextensions feature flag like below.
?feature.canmodifyextensions=true&ExtensionNameToDisable=false
An example of this is when you want to turn off an old extension and turn on a new one. You can do this as follows: -
?feature.canmodifyextensions=true&MyOldExtension=false&MyNewExtension=true

Testing Best Practices
As you write UI based test cases using the Portal Test Framework it is recommended you follow a few best practices to ensure maximum reliability and to get the best value from your tests.
Always verify that every action completed as expected
In many cases the browser is not as fast as the test execution, so if you don't wait until expected conditions have completed your tests could easily fail. For example:
commandBar.FindMessageBox("Delete contact").ClickButton("Yes");
webDriver.WaitUntil(() => !commandBar.HasMessageBox, "There is still a message box in the command bar.");
Here, the "Yes" button of a message box is clicked and you would expect it to go away as soon as the button is clicked. However this might not happen as fast as you think. Therefore we wait until the CommandBar.HasMessageBox property reports 'false' before proceeding, which ensures the message box is gone and will not interfere with the next action.
Log everything
It can be very difficult to diagnose a failed test case without some good logging. An easy way to write these logs is to use the TestContext.WriteLine method:
TestContext.WriteLine("Starting provisioning from the StartBoard...");
Use built in Test Framework methods
The Portal Test Framework provides many built in methods to perform actions on Portal web elements and it is recommended to use them for maximum test maintainability and reliability. For example, one way to find a StartBoard part by it's title is this:
var part = webDriver.WaitUntil(
    () => portal.StartBoard.FindElements<Part>()
    .FirstOrDefault(p => p.PartTitle.Equals("TheTitle")),
    "Could not find a part with title 'Samples'.");
However this can be greatly simplified by using a built in method:
var part = portal.StartBoard.FindSinglePartByTitle("TheTitle");
Not only this significantly reduces the amount of code to write and maintain but also encapsulates the best practice of waiting until elements are found since FindSinglePartByTitle will internally perform a WaitUntil operation that will retry until the part is found (or the timeout is reached).
BaseElement also contains an extension method that wraps the webDriver.WaitUntil call.
var part = blade.WaitForAndFindElement<Part>(p => p.PartTitle.Equals("TheTitle"));
Use WaitUntil for retrying actions and waiting for conditions
WaitUntil can also be used to retry an action since it just takes a lambda function which could be an action and then a verification step afterwards. WaitUntil will return when a "truthy" (not false or null value) is returned. This can be useful if the particular action is flakey. Please be careful to only use actions that are idempotent when trying to use WaitUntil in this pattern.
Prefer WaitUntil to Assert for non instantaneous conditions
The traditional way to verify conditions within test cases is by using Assert methods. However, when dealing with conditions that won't be satisfied immediately you should instead use WebDriver.WaitUntil:
var field = form.FindField<Textbox>("contactName");
field.Value = contactName + Keys.Tab;
webDriver.WaitUntil(() => field.IsValid, "The 'contactName' field did not pass validations.");
In this example, if we would have instead used Assert to verify the IsValid propery the test would most like have failed since the TextBox field has a custom async validation that will perform a request to the backend server to perform the required validation, and this is expected to take at least a second.
Create proper wrapper/abstractions for commonly used patterns
A good practice is to create wrappers and abstractions for common patterns of code you use (eg when writing a WaitUntil, you may want to wrap it in a function that describes its actual intent). This makes your test code clear in its intent by hiding the actual details to the abstraction's implementation. It also helps with dealing with breaking changes as you can just modify your abstraction rather than every single test.
If you think an abstraction you wrote would be generic and useful to the test framework, feel free to contribute it!
Clear user settings before starting a test
As you may know, the Portal keeps good track of all user customizations via persistent user settings. This behavior might not be ideal for test cases since each test case could potentially find a Portal with different customizations each time. To avoid this you can use the portal.ResetDesktopState method. Note that the method will force a reload of the Portal.
portal.ResetDesktopState();
Use FindElements (plural) to verify the absence of elements
Sometimes you are not trying to find a web element but instead you want to verify that the element is not there. In these cases you can use the FindElements method in combination with Linq methods to verify if the element is there:
webDriver.WaitUntil(() => portal.StartBoard.FindElements<Part>()
                                           .Count(p => p.PartTitle.Equals("John Doe")) == 0,
                    "Expected to not find a part with title 'John Doe' in the StartBoard");
In the example, we are verifying that there is no part with title 'John Doe' in the StartBoard.
Prefer CssSelector to Xpath
You will eventually be faced with the choice of using either CSS selectors or XPath to find some web elements in the Portal. As a general rule the preferred approach is to use CSS selectors because:
	• Xpath engines are different in each browser
	• XPath can become complex and hense it can be harder to read
	• CSS selectors are faster
	• CSS is JQuery's locating strategy
	• IE doesn't have a native XPath engine
Here for a simple example where we are finding the selected row in a grid:
grid.FindElements(By.CssSelector("[aria-selected=true]"))

If you think the element you found would be a useful abstraction, feel free to contribute it back to the test framework!


<a name="c-portal-test-framework-overview-understanding-the-difference-between-the-frameworks"></a>
### Understanding the difference between the frameworks

1. Microsoft.Portal.TestFramework (https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework&protocolType=NuGet&_a=package)

1. Microsoft.Portal.TestFramework.Csharp (https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official&package=Microsoft.Portal.TestFramework.CSharp&protocolType=NuGet&_a=package)

The Microsoft.Portal.TestFramework.CSharp package contains the core test framework DLLs.  It is updated with the latest code as the Portal is being developed and may contain fixes for test issues that were found after release.  It may also contain code that is not compatible with the deployed version of the Portal.

The Microsoft.Portal.TestFramework a reference to the Microsoft.Portal.TestFramework.Csharp package as well as additional dependencies that are required for the C# test framework to run out of the box*.  

*note that some external dependencies may require separate downloads such as ChromeDriver which must match the version of Chrome 

Contributing
Contributions to improve the Test Framework are welcome as they keep the code base healthy. If you have improvements you wish to contribute back to the Test Framework, see below for steps on enlisting and submitting a pull request. Please note that this is currently only available to Microsoft employees.
Enlisting
The repo uses a build environment called CoreXt. Please be sure to follow the Cloud Engineering Service’s instructions for Enlisting into an Existing repo if this is your first time using CoreXt5.
The git repository is available at the following URL (Microsoft employees only):https://msazure.visualstudio.com/DefaultCollection/One/_git/AzureUX-PortalFx-CSTestFx
The code can be viewed via the solution file \src\TestFramework\TestFramework.sln.
Building
In order to build, you will need to initialize the CoreXt environment for the repository. Once that is complete, you can call "build" at the repository root. The build output will be available under \out.
Testing
Once you have a build, the nuget package Microsoft.Portal.TestFramework.CSharp will be available under the \out\debug-AMD64. You can copy the binaries to your local test suites and then run your tests to verify the fix.
Submitting
To contribute back to the Test Framework, please submit a pull request. Note that we may test your code changes with our internal repository's test suites before accepting your pull request.
Troubleshooting
If you run into issues, please search the internal Microsoft stack overflow first. If you are unable to find an answer, ask a new question and tag it with "ibiza-test".






<a name="c-portal-test-framework-c-test-framework-overview"></a>
## C# Test Framework Overview

You can write UI-based test cases using **Visual Studio** and the Portal Test Framework that is part of the Portal SDK.

<a name="c-portal-test-framework-c-test-framework-overview-creating-the-test-project"></a>
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

See [Managing authentication credentials](#Managing authentication credentials) for some FAQs with handling credentials.

<a name="c-portal-test-framework-c-test-framework-overview-side-loading-an-extension"></a>
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

<a name="c-portal-test-framework-c-test-framework-overview-managing-authentication-credentials"></a>
### Managing authentication credentials

While the test framework does not provide any support for managing login credentials, the following are some recommendations.

1.  If you are in the Azure org, please see the Azure Security guidelines that are located at [https://aka.ms/portalfx/securityguidelines](https://aka.ms/portalfx/securityguidelines)

1.  Do not store your credentials in the test code.

1.  Do not check in your credentials into your repository.

1.  Some possibilities for storing login credentials include:

   * Using the Windows Credential Store.

   * Using Azure Key Vault.

   * Write your own service for providing credentials.

<a name="c-portal-test-framework-c-test-framework-overview-full-sample-code"></a>
### Full Sample Code

The sample that demonstrates navigating to the Portal for testing is in the following code.


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







<a name="c-portal-test-framework-entering-data-into-forms"></a>
## Entering Data into Forms

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

<a name="c-portal-test-framework-entering-data-into-forms-full-example"></a>
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

  
<a name="c-portal-test-framework-testing-commands"></a>
## Testing Commands

The Test Framework provides objects to interact with commands both from the command bar and context menus.

<a name="c-portal-test-framework-testing-commands-to-use-commands-from-the-command-bar"></a>
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

<a name="c-portal-test-framework-testing-commands-to-use-commands-from-context-menus"></a>
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

1. Interact with the message box to verify that this Contact was deleted.

    ```cs
    menuItem.Click();

    portal.FindMessageBox("Delete contact").ClickButton("Yes");

    webDriver.WaitUntil(() => !portal.HasMessageBox, "There is still a message box in the Portal.");

    portal.StartBoard.FindSinglePartByTitle("Deleted");
    ```

<a name="c-portal-test-framework-testing-commands-full-example"></a>
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


<a name="c-portal-test-framework-taking-screenshots-while-testing"></a>
## Taking Screenshots while Testing

The Test Framework provides built-in support for taking screenshots from test cases. You can use the **WebDriver.TakeScreenshot** method to take the screenshot and save it as a PNG file to the local disk. You can do this at any point within the test case, but a typical approach is to do it at least in the test `CleanUp` method when the outcome of the test case is not "Passed".

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

<a name="c-portal-test-framework-taking-screenshots-while-testing-full-example"></a>
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


<a name="c-portal-test-framework-contributing-to-c-test-framework"></a>
## Contributing to C# Test Framework

Contributions that improve the Test Framework are welcome, because they keep the code base healthy.  When you have improvements to contribute back to the Test Framework, use the following steps to enlist into the list of contributors and submit a pull request. The pull request instructions are located at [top-extensions-publishing.md](top-extensions-publishing.md), with the following additions.

1. The Test Framework uses a different `<repoRoot>`
1. The Test Framework is not associated with the production extension branches
1. You may or may not want to set up a new local git repository specifically for test framework improvements 
1. The configuration files must be modified to match the test framework environment

<!-- TODO: Determine which Azure group is represented by the word  "we" -->
* **NOTE**: We may test the improvement changes with our internal repository's test suites before accepting the pull request.

**NOTE**: Please note that the opportunity to contribute to the  test framework is only available to first-party extension developers, i.e., Microsoft employees.

<a name="c-portal-test-framework-contributing-to-c-test-framework-enlisting-into-the-list-of-contributors"></a>
### Enlisting into the list of contributors

The repo uses a build environment named **CoreXt5**.  The instructions for enlisting into an existing repo are located at [https://aka.ms/portalfx/onebranch](https://aka.ms/portalfx/onebranch).

The git repository for first-party developers is located at  [https://aka.ms/portalfx/cstestfx](https://aka.ms/portalfx/cstestfx). In this discussion, `<repoRoot>` is this git repository.

The code can be viewed by using the solution file `<repoRoot>\src\TestFramework\TestFramework.sln` solution file.

<a name="c-portal-test-framework-contributing-to-c-test-framework-building-the-improvement"></a>
### Building the improvement

<!-- TODO:  Verify that the build instructions are correct, including the location of the <repoRoot\out> -->

To build your improvement, initialize your CloudVault environment by using the instructions located at [https://aka.ms/portalfx/opendevelopment](https://aka.ms/portalfx/opendevelopment). After that is complete, you can call "build" at the repository root.  The build output will be available under <repoRoot>\out.

<a name="c-portal-test-framework-contributing-to-c-test-framework-testing-the-improvement"></a>
### Testing the improvement

After the build completes successfully, the NuGet package `Microsoft.Portal.TestFramework.CSharp` will be available under the `<repoRoot>\out\debug-AMD64\`.  You can copy the binaries to your local test suites and then run your tests to verify the fix. After the improvement passes all your unit tests, you can submit the pull request.

<a name="c-portal-test-framework-contributing-to-c-test-framework-troubleshooting"></a>
### Troubleshooting

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

