
## Getting Started

### Installation

1. Install [Node.js](https://nodejs.org) if you have not done so. This will also install npm, which is the package manager for Node.js.  We have only verified support for LTS Node versions 4.5 and 5.1 which can be found in the "previous downloads" section.  Newer versions of Node are known to have compilation errors.  
1. Install [Node Tools for Visual Studio](https://www.visualstudio.com/en-us/features/node-js-vs.aspx)
1. Install [TypeScript](http://www.typescriptlang.org/) 1.8.10 or greater.
1. Verify that your:
    - node version is v4.5 or v5.1 using `node -v`
    - npm version is 3.10.6 or greater using `npm -v`.  To update npm version use `npm install npm -g`
    - tsc version is 1.8.10 or greater using tsc -v.

1. Open a command prompt and create a directory for your test files.

		md e2etests 

1. Switch to the new directory and install the msportalfx-test module via npm:

		cd e2etests
		npm install msportalfx-test --no-optional

1. The msportalfx-test module comes with useful TypeScript definitions and its dependencies. To make them available to your tests, we recommend that you use the [typings](https://www.npmjs.com/package/typings) Typescript Definition Manager.

1. First install the [typings](https://www.npmjs.com/package/typings) Typescript Definition Manager globally:

		npm install typings -g

	Next copy the provided **typings.json** file from the **node_modules/msportalfx-test/typescript** folder to your test root directory and use *typings* to install the provided definitions:

		*copy typings.json to your test root directory*
        *navigate to your test root directory*
		typings install

1. MsPortalFx-Test needs a WebDriver server in order to be able to drive the browser. Currently only [ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver) is supported, so downloaded it and place it in your machine's PATH or just install it from the [chromedriver Node module](https://www.npmjs.com/package/chromedriver).  You may also need a C++ compiler (Visual Studio includes one):

		npm install chromedriver


### Write a test

You'll need an existing cloud service for the test you'll write below, so if you don't have one please go to the Azure Portal and [create a new cloud service](https://ms.portal.azure.com/#create/Microsoft.CloudService). Write down the dns name of your cloud service to use it in your test.

We'll use the [Mocha](https://mochajs.org/) testing framework to layout the following test, but you could use any framework that supports Node.js modules and promises. Let's install Mocha (its typescript definitions are already installed from the typings install earlier):

`npm install mocha`

Now, create a **portaltests.ts** file in your e2etests directory and paste the following:

```ts
/// <reference path="./typings/index.d.ts" />

import assert = require('assert');
import testFx = require('MsPortalFx-Test');
import nconf = require('nconf');
import until = testFx.until;

describe('Cloud Service Tests', function () {
	this.timeout(0);
	
	it('Can Browse To A Cloud Service', () => {

		
        // Load command line arguments, environment variables and config.json into nconf
        nconf.argv()
            .env()
            .file(__dirname + "/config.json");

        //provide windows credential manager as a fallback to the above three
        nconf[testFx.Utils.NConfWindowsCredentialManager.ProviderName] = testFx.Utils.NConfWindowsCredentialManager;
        nconf.use(testFx.Utils.NConfWindowsCredentialManager.ProviderName);
        
		
		testFx.portal.portalContext.signInEmail = 'johndoe@outlook.com';
		testFx.portal.portalContext.signInPassword = nconf.get('msportalfx-test/johndoe@outlook.com/signInPassword');
		
		// Update this variable to use the dns name of your actual cloud service 
		let dnsName = "mycloudservice";
		
		return testFx.portal.openBrowseBlade('microsoft.classicCompute', 'domainNames', "Cloud services (classic)").then((blade) => {
			return blade.filterItems(dnsName);
		}).then((blade) => {
            return testFx.portal.wait<testFx.Controls.GridRow>(() => {
                return blade.grid.rows.count().then((count) => {
                    return count === 1 ? blade.grid.rows.first() : null;
                });
            }, null, "Expected only one row matching '" + dnsName + "'.");
        }).then((row) => {
            return row.click();			
		}).then(() => {            
			let summaryBlade = testFx.portal.blade({ title: dnsName + " - Production" });
            return testFx.portal.wait(until.isPresent(summaryBlade));
		}).then(() => {
			return testFx.portal.quit();
		});
	});
});
```

Write credentials to the windows credential manager.

```
    cmdkey /generic:msportalfx-test/johndoe@outlook.com/signInPassword /user:johndoe@outlook.com /pass:somePassword
```

Remember to replace "mycloudservice" with the dns name of your actual cloud service.

In this test we start by importing the **MsPortalFx-Test** module. Then the credentials are specified for the user that will sign in to the Portal. These should be the credentials of a user that already has an active Azure subscription. 

After that we can use the Portal object to drive a test scenario that opens the Cloud Services Browse blade, filters the list of cloud services, checks that the grid has only one row after the filter, selects the only row and waits for the correct blade to open. Finally, the call to `quit()` closes the browser.

### Add the configuration

Create a file named **config.json** next to portaltests.ts. Paste this in the file:

```json

    {
    "capabilities": {
        "browserName": "chrome"
    },
    "portalUrl": "https://portal.azure.com"
    }

```	

This configuration tells MsPortalFx-Test that Google Chrome should be used for the test session and [https://portal.azure.com](https://portal.azure.com) should be the Portal under test. 

### Compile and run

Compile your TypeScript test file:

	tsc portaltests.ts --module commonjs

Then, run Mocha against the generated JavaScript file (note using an elevated command prompt may cause Chrome to crash.  Use a non-elevated command prompt for best results):

`	node_modules\.bin\mocha portaltests.js`

The following output will be sent to your console as the test progresses:

```
Portal Tests
Opening the Browse blade for the microsoft.classicCompute/domainNames resource type...
Starting the ChromeDriver process...
Performing SignIn...
Waiting for the Portal...
Waiting for the splash screen to go away...
Applying filter 'mycloudservice'...
√ Can Browse To A Cloud Service (37822ms)	

1 passing (38s)
```

If you run into a compilation error with `node.d.ts`, verify that the tsc version you are using is 1.8.x (we do not currently support Typescript 2+).  You can check the version by running:
    
`tsc --version`

If the version is incorrect, then you may need to adjust your path variables or directly call the correct version of tsc.exe.  

### Updating

In order to keep up to date with the latest changes, we recommend that you update whenever a new version of MsportalFx-Test is released.  npm install will automatically pull the latest version of msportalfx-test. 
 
Make sure to copy typescript definition files in your *typings\* folder from the updated version in *\node_modules\msportalfx-test\typescript*.  

### More Examples

More examples can be found
- within this document
- in the [msportalfx-test /test folder] (https://github.com/Azure/msportalfx-test/tree/master/test) 
- and the [Contacts Extension Tests](http://vstfrd:8080/Azure/One/_git/AzureUX-PortalFx#path=%2Fsrc%2FSDK%2FAcceptanceTests%2FExtensions%2FContactsExtension%2FTests). 

If you don't have access, please follow the enlistment instructions below.

### Running tests in Visual Studio
 
1. Install [Node Tools for Visual Studio](https://www.visualstudio.com/en-us/features/node-js-vs.aspx) (Note that we recommend using the Node.js “LTS” versions rather than the “Stable” versions since sometimes NTVS doesn’t work with newer Node.js versions.)

1. Once that’s done, you should be able to open Visual Studio and then create new project: *New -> Project -> Installed, Templates, TypeScript, Node.js -> From Existing Node.js code*.

    ![alt-text](../media/msportalfx-test/NewTypeScriptNodeJsExistingProject.png "NewTypeScriptNodeJsExistingProject")

1. Then open the properties on your typescript file and set the TestFramework property to “mocha”.

    ![alt-text](../media/msportalfx-test/FileSetTestFrameworkPropertyMocha.png "FileSetTestFrameworkPropertyMocha")

1. Once that is done you should be able to build and then see your test in the test explorer.  If you don’t see your tests, then make sure you don’t have any build errors.  You can also try restarting Visual Studio to see if that makes them show up.  
