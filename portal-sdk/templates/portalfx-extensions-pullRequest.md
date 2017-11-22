## How to send a pull request

The Portal repository has four main branches: dev, dogfood, mpac and production. All the pull requests should be sent to the dev branch. 


<!-- TODO:  Determine whether the Github setup procedure is documented elsewhere.  It is not really a part of 
the pull request process.  -->

1. Set up the developer **GitHub** platform so that it can communicate with the remote repository branch. At the command line, type the following commands, without the remarks. 

   ```js
    git clone https://msazure.visualstudio.com/DefaultCollection/One/_git/AzureUX-PortalFx
    cd AzureUX-PortalFx\
    git checkout dev
    init.cmd
    cd RDPackages\OneCloud
  
    REM   fetch down all the branches from the Git remote
    git fetch
   ```
    
    When these commands complete successfully, the developer has a local environment in which they deevelop their extensions.  They can create several extensions without making a pull request. Also, whether there needs to be a one-to-one correspondence between the new extensions and the pull request is team-dependent.
    
    When an extension is ready to be moved to a remote repository other than the dev branch, the process to create a pull request is as follows.

1.  The developer may need to modify the configuration file. To enable the extension, the developer should update the extension test count in the `%ROOT%\src\StbPortal\Website.Server.Tests\DeploymentSettingsTests.cs` file. Otherwise, set the **disabled** property in the `config` file to false.

1.  Stage the changes in GitHub so that the pull request will pick them up from the remote repository. The commands for the staging process are as follows.  Remember to include the Bug Id in the custom commit message.

     ```js
    REM   Add files to the next commit for staging
    git add <Modified_Files>

    REM   Commit the staged content. Include the Bug ID in the custom commit message immediately
    REM     after the pound sign.
    REM     Save the commit hash that is returned from this command for later reference.
    git commit -m "#123456 Add/ Enable the extension"

    REM   Transmit local branch commits to the remote repository branch
    git push origin myalias/myhotfix

    cd %ROOT%\src\
    buildall

    REM   Test if all the test cases passed. If any of the test cases fails,
    REM   please verify the config again
    testconfig 
     ```
    **NOTE**:  For more information, use the commit hash that is returned from the `git commit` command on the site that is located at [https://msazure.visualstudio.com/One/_git/AzureUX-PortalFx/commits](https://msazure.visualstudio.com/One/_git/AzureUX-PortalFx/commits).

1. Create a work item so that you can associate the work item with the commit. Use the site located at [https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/pullrequests?_a=mine](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx/pullrequests?_a=mine) to create the work item. Click the `New pull request` button, then select the branch that contains the staged changes in the first dropdown box.  Select the target branch in the second dropdown box.
In the following  example, the developer is requesting to move changes from the `extensionupdate` branch to the dev branch.

   ![alt-text](../media/portalfx-extensions-pullRequest/pull-request.png "Create Pull Request")

1. To ensure that the changes you have made are correct and will not cause any live-site issues, the Ibiza team will review and complete the pull request.  A list of Ibiza team contacts to select as reviewers is located at [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).  They will do a build time check of the commit message format. The build will break immediately if the commit message is in a different format, and the developer will get a notification to update the commit message previous to receiving any deployment notifications. Otherwise, the developer will receive an email for each environment when the configuration changes are deployed.

<!-- TODO: Validate that this last sentence is accurate.n Is it just configuration changes, or is it also the extension?  -->