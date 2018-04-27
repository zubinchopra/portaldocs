
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