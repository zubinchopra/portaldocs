<a name="portalfxExtensionsPullRequest"></a>
<!-- link to this document is [portalfx-extensions-pullRequest.md]()
-->

## How to Send the Pull Request
The Portal repository has 4 main branches: dev, dogfood, mpac and production. All the pull requests should be sent to the Dev branch.

Before creating a pull request, create a workitem so that you can associate the workitem with the commit. Use  the site located at [https://aka.ms/portalfx/config/update](https://aka.ms/portalfx/config/update). By associating the workitem with the commit, you will get a notification when the configuration changes are deployed to each environment.

Make sure you have access to make changes to the portal framework repository by joining the Azure Portal Partner Contributors group. For more information about developer prerequisites, see [portalfx-extensions-forDevelopers-procedures.md](portalfx-extensions-forDevelopers-procedures.md]).

To ensure that the changes you have made are correct and will not cause any live-site issues, it is strongly recommended that you wait for the Ibiza team to sign-off and complete the PR. Ibiza team contacts are located at [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md]).

The script for the pull request is the following code.
``` git clone https://msazure.visualstudio.com/DefaultCollection/One/_git/AzureUX-PortalFx
	cd AzureUX-PortalFx\
	init.cmd
	git checkout dev
	cd RDPackages\OneCloud

	//  Modify extension configuration
	//  If enabling an extension then you need to update the enabled 
        //    extension test count in 
        //    %ROOT%\src\StbPortal\Website.Server.Tests\DeploymentSettingsTests.cs
        //

        //  If you are setting the disabled property to false
	disabled=false

	git add <Modified_Files>
	git commit -m "#123456 Add/ Enable the extension"
	git fetch
	git checkout -b myalias/myhotfix origin/dev
	git cherry-pick hotfixcommithashfrommpac
	git push origin myalias/myhotfix
	cd %ROOT%\src\
	buildall
	
        //  Test if all the test cases passed. If any of the test cases fails,
        //    please verify your config again
        testconfig 
    ```
