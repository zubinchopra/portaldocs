
## Creating an Extension<a name="portalfxExtensionsDeveloperInitExtension"></a>
<!-- link to this document is [portalfx-extensions-developerInit-extension.md]()
-->


1. Launch Visual Studio and navigate to File -> New -> Project. In the new project dialog, select Installed -> Visual C# -> Azure Portal. Select the Azure Portal Extension project type, and give it a unique name.  The name of the project typically matches the solution name. Make sure you are using the correct location, and click the checkbox next to ```Create directory for solution```.  Then, click the ```OK``` button, as described in the following image.

    ![alt-text](../media/portalfx-overview/new-project-template.png "New Project Dialog")

1.  Use the F5 key to compile and run the new project extension in IIS Express.

1.  On first run you should see a request to install a certificate for localhost for IIS express Accept the certificate to continue, as in the following image.

    ![alt-text](../media/portalfx-overview/enablehttps.png "Security Warning Dialog")

1. The platform may display a "debugging not enabled" warning. You may enable or disable debugging, depending on your preferences.

    ![alt-text](../media/portalfx-overview/first-run-debugging-dialog.png "Debugging Not Enabled Dialog")

1. The platform will side-load your application into the production portal. If the  browser displays the message 'Server Error in '/' Application' instead, it is likely that the NuGet packages are not yet associated with Visual Studio. The Visual Studio Error List dialog may display the error message that is in the following image.

    ![alt-text](../media/portalfx-extensions-NuGetPackagesMissing.png "Missing NuGet Packages")

    If this message is displayed, the missing packages can be installed by using the Nuget Package Manager. The Package Manager can be started by selecting Tools  -> Nuget Package Manager -> Package Manager Console, as in the following image.

     ![alt-text](../media/portalfx-extensions-NugetPackageManagerConsole.png "Nuget Package Manager Console")

     When the Package Manager console is  displayed, click on the Restore button that is associated with the error, as in the following image.
     
     ![alt-text](../media/portalfx-extensions-NugetPackageManagerRestore.png "Nuget Package Manager Restore")

    Click on the F5 button to rebuild the application. When the build is successful, Visual Studio will proceed to the next step and side-load your application into the production portal.

1. The portal will prompt you to allow your side loaded extension. Click the ```allow``` button, as in the following image.

    ![alt-text](../media/portalfx-overview/untrusted-extensions.png "Untrusted Extensions Dialog")
    
Congratulations! You have just created your first extension.
