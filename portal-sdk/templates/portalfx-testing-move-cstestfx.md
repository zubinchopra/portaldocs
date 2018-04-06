
## NOTICE: Changes to C# Test Framework NuGet

<!-- TODO: Determine how much of this has already been moved.  -->

The Ibiza Portal’s C# Test Framework is being moved to a separate repository.  This will empower partners to iterate faster without depending on the Portal Teams SDK ship cycle.  You may contribute directly or creating your own forks of the Test Framework.

The new repository is available for you to enlist extensions into it.   You will receive an email when the `Microsoft.Portal.TestFramework` NuGet contains the changes.

### Getting the new test framework

If you are currently using the OneBranch `Microsoft.Portal.TestFramework` NuGet that is located at  [https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework&packageVersion=5.0.302.542&_a=view](https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework&packageVersion=5.0.302.542&_a=view), then minimal changes are required.  

If you are using **Visual Studio**/NuGet, then the dependencies should automatically be installed by referencing the `Microsoft.Portal.TestFramework` NuGet package.  You may need to update your reference paths, because some of the DLLs, like  `Microsoft.Portal.TestFramework.Core.dll`, have moved to a dependent package, which should also  be automatically included.

If you are using a custom build environment that requires an explicit listing of dependent packages, for example, internal Microsoft CoreXt, please see the list of known package dependencies:

* AzureUX.UserManagement.Client

* Microsoft.Portal.TestFramework.CSharp

* Microsoft.AspNet.WebApi.Client

* Newtonsoft.Json

* Selenium.WebDriver

* Selenium.Support

* WebDriver.ChromeDriver.win32

  Recommended if using Chrome 

* WebDriver.IEDriverServer.win32 

    **NOTE**: Only limited support is available for Internet Explorer 11.

If there are issues, please verify that the correct versions for the matching TestFramework **NuGet** package are being used.

We try to keep the package dependency list up to date. However, the best way to figure out the dependencies and their versions is to use NuGet to install the package and see what dependencies are included.  If you want to manually figure out the dependency list, you can view the `Microsoft.Portal.TestFramework's` nuspec file, and follow its dependencies nuspec files which can be found in their corresponding nupkg.

If you wish to pick up the absolute latest Test Framework bits, there is a NuGet package named `Microsoft.Portal.TestFramework.CSharp`. It is not the same as  `Microsoft.Portal.TestFramework`, and it is located at OneBranch [https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework.csharp&packageVersion=1.0.8.8&_a=view](https://msazure.visualstudio.com/DefaultCollection/One/_apps/hub/ms.feed.feed-hub?feedName=Official&protocolType=NuGet&packageName=microsoft.portal.testframework.csharp&packageVersion=1.0.8.8&_a=view).

The bits are also located at the MsAzure Official feed that is located at [https://msazure.pkgs.visualstudio.com/_packaging/Official/NuGet/v3/index.json](https://msazure.pkgs.visualstudio.com/_packaging/Official/NuGet/v3/index.json) and at the waNuGet official feed located at [http://waNuGet/Official/NuGet](http://waNuGet/Official/NuGet).

This package only contains the necessary DLLs for building the test framework, instead of  running it.  There are additional runtime dependencies on Portal framework DLLs that are automatically included in the `Microsoft.Portal.TestFramework NuGet`. They should be put  in the same directory as the running tests in order to properly run tests.  The specific DLLs are listed in the Microsoft.Portal.TestFramework.CSharp’s readme.txt file.  

### Viewing the source code and contributing

If you wish to view the source code and possibly contribute fixes back to the Test Framework then please see the contribution article located at [portalfx-extensions-csharp-test-framework-overview.md](portalfx-extensions-csharp-test-framework-overview.md).
