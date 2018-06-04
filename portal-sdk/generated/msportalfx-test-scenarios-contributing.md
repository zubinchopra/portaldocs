
<a name="contributing"></a>
## Contributing

To enlist a contribution, use the following code.

`git clone https://github.com/azure/msportalfx-test.git`

Use Visual Studio or Visual Studio Code to build the source, as in the following code.

`Run ./scripts/Setup.cmd`

To setup the tests you need the following.

1. Create a dedicated test subscription that is used for tests only

1. Locate a user that has access to the test subscription only

1. Create an  AAD Application and service principal with access, as in the following code.

    ```powershell 
        msportalfx-test\scripts\Create-AdAppAndServicePrincipal.ps1 
            -TenantId "someguid" 
            -SubscriptionId "someguid" 
            -ADAppName "some ap name" 
            -ADAppHomePage "https://somehomepage" 
            -ADAppIdentifierUris "https://someidentiferuris" 
            -ADAppPassword $someAdAppPassword 
            -SPRoleDefinitionName "Reader" 
    ```

1. Run `setup.cmd` in the portal repo, or run run `powershell.exe -ExecutionPolicy Unrestricted -file "%~dp0\Setup-OneCloud.ps1" -DeveloperType Shell %*`. You will use the details of the created service principal in the next steps.  

**NOTE**: Store the password for the following procedures in **KeyVault**,  the secret store, or some other safe location. It is not retrieveable by using the commandlets. 

1. Open **test\config.json** and enter appropriate values for:

    ```
    "aadAuthorityUrl": "https://login.windows.net/TENANT_ID_HERE",
    "aadClientId": "AAD_CLIENT_ID_HERE",
    "subscriptionId": "SUBSCRIPION_ID_HERE",
    "subscriptionName": "SUBSCRIPTION_NAME_HERE",
    ```

1. The account that corresponds to the specified credentials should have at least contributor access to the subscription specified in the **config.json** file. The account must be a Live Id account. It cannot be an account that requires two factor authentication (like most @microsoft.com accounts). 

1. Install the Portal SDK from [/portal-sdk/generated/downloads.md](/portal-sdk/generated/downloads.md), then open Visual Studio and create a new Portal Extension from File --> New Project --> Azure Portal --> Azure Portal Extension. Name this project **LocalExtension** so that the extension itself is named LocalExtension, which is what many of the tests expect. Then click CTRL+F5 to host the extension in IIS Express.

1. The *Can Find Grid Row* and the *Can Choose A Spec* tests require special configuration described in the tests themselves.

1. Many of the tests currently rely on the CloudService extension. 

<!-- TODO: Determine whether the dependency has been removed."We are working to remove this dependency." -->

For more information about AAD Applications and Service Principals, see [https://aka.ms/portalfx/serviceprincipal](https://aka.ms/portalfx/serviceprincipal).  