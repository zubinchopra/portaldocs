
### Creating the Test Project

To create a test project that can use the Portal Test Framework, use the following steps.

1. Create a new **Visual Studio** Unit Test Project.

1. Install the NuGet Package Microsoft.Portal.TestFramework from [https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework](https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework).

1. If your test cases use the Azure Marketplace, also install the Microsoft.Portal.TestFramework.MarketplaceUtilities package from [https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework.marketplaceutilities](https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework.marketplaceutilities), which contains Selenium classes for elements in the Azure Marketplace.

1. Add an `app.config` file to your test project and define the basic Test Framework settings under appSettings, as in the following example.

{"gitdown": "include-section", "file": "../samples/SampleCSTestsFiles/app.config", "section": "config#appSettings"}

1. Add a new Unit Test class and start writing your test case.

### Navigating to the Portal

To navigate to the Portal, the extension supplies the Portal's uri.  We recommend setting the value in the `app.config` file as shown in [Creating the Test Project](#creating-the-test-project).  After the extension has the Portal uri, it can use the **WebDriverFactory.Create** method to create an instance of the `WebDriver` object and then use the **PortalAuthentication** class to login and navigate to the Portal in the browser, as in the following example.

   {"gitdown": "include-section", "file": "../samples/SampleCSTestsFiles/NavigateToPortalTest.cs", "section": "config#navigateToPortal"}

**NOTE**: Multi-factor authentication (MFA) is not supported.  You must use an account that does not require MFA.  If you are part of the Microsoft Azure organization, see the Azure Security Guidelines located at [https://aka.ms/portalfx/securityguidelines](https://aka.ms/portalfx/securityguidelines) for details on how to request an exception for an MSA/OrgID account.  You can not use a service account to login to the Azure Portal.

For more information about handling credentials, see [Managing authentication credentials](#Managing authentication credentials).

### Side-loading An Extension 

The Portal provides options for side-loading an extension for testing. To side-load an  extension on a `localhost` you can set a query string. To side-load a deployed extension, you can set the appropriate query strings and execute the `registerTestExtension` function.  For more information, see [top-extensions-sideloading.md](top-extensions-sideloading.md).

{"gitdown": "include-section", "file": "../samples/SampleCSTestsFiles/NavigateToPortalTest.cs", "section": "config#sideLoadingExtension"}

Remember to dispose the `WebDriver` to cleanup, as in the following example.

{"gitdown": "include-section", "file": "../samples/SampleCSTestsFiles/NavigateToPortalTest.cs", "section": "config#dispose"}

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

The sample that demonstrates navigating to the Portal for testing is in the following code.


{"gitdown": "include-file", "file": "../samples/SampleCSTestsFiles/NavigateToPortalTest.cs"}

