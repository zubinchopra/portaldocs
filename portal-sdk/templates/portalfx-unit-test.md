# Unit Test Framework preview
Covered in this document:

- File > New Project scaffolding
- Creating a project from scratch
- CI: test results output to CI accepted formats JUNIT, TRX, other.
- Code Coverage: where to find your code coverage output

## Getting Started with Visual Studio

1. To support the Unit Test project in Visual Studio you must first install the `Node Tools for Visual Studio` [from here](https://github.com/Microsoft/nodejstools/releases/tag/v1.3.1) then
1. Launch Visual Studio and click `File > New > Project > Visual C# > Azure Portal`. It will scaffold a Solution with two projects Extension.csproj and Extension.UnitTest.csproj
1. Build the solution `Ctl + Shift + B`
1. Open index.html in a browser

note you can also run  `npm run test` from the commandline.

## Creating a project from scratch with Visual Studio Code

Available from [SDK 5.0.302.1057](https://aka.ms/portalfx/download)

This tutorial will provide you step by step instructions for creating a UnitTest project for your Azure Portal Extension.  The resulting folder structure will look like the following:

```

+-- Extension
+-- Extension.UnitTests
|   +-- test/ResourceOverviewBlade.test.ts
|   +-- test-main.js
|   +-- karma.conf.js
|   +-- msportalfx-ut.config.json
|   +-- package.json
|   +-- tsconfig.json

// The build and code generation will add the following
|   +-- _generated
|     +-- Ext
|     +-- Fx
|   +-- Output

```

NOTE: this document uses relative path syntax to indicate where you should add each file e.g ./index.html indicates adding an index.html at the root of your test project folder Extension.UnitTests/index.html

### to generate FxScripts.js

In the ./index.html the following scripts are imported

- `mocha.js`: this test framework is used in the shipped sample. Note that you may choose to use whatever test framework you wish. msportalfx-ut is test framewwork agnostic.
- `chai.js`: test assertion framework. Note that you may choose to use whatever test framework you wish. msportalfx-ut is test framewwork agnostic.
- `./node_modules/msportalfx-ut/lib/FxScripts.js`: this is an aggregate script that contains all portal scripts required as a pre-req for your test context. This script includes: default setup of window.fx.*, all portal bundles required to successfully load your blades, all requirejs config required to load your blades.
- `./_generated/Ext/ExtensionStringResourcesRequireConfig.js` requirejs mapping for AMD modules generated from from the extension's resx files.
- `./test-main.js` entrypoint to setup your test runner and extensions require config.

To generate `./_generated/Ext/ExtensionStringResourcesRequireConfig.js` and to copy typings local to the test context, msportalfx-ut provides a gulpfile that automates the generation of content under `./_generated/Ext/`. It can be executed as part of the `prereq` script below.

#### Add ./package.json

```json

{"gitdown": "include-file", "file": "../samples/VS/PackageTemplates/Default/Extension.UnitTests/package.json"}

```

Note: In this case we're using mocha and chai but you can choose your own test and assertion framework.
Note: msportalfx-ut.*.tgz ships in the Microsoft.Portal.TestFramework.UnitTest NuGet package.  You can add a reference to it in your ./YourExtension/packages.config and a file:// reference to the path where it will be unpacked.  If you are building using CoreXT there are a number of tips at the end of this document under the `Corext Environments` section.

Save the above to ./package.json and run the following command:

```

npm install --no-optional

```

Before running the `prereq` script you must provide the following config such that the gulp task can correctly locate resources. This is done in msportalfx-ut.config.json.

#### add ./msportalfx-ut.config.json

msportalfx-ut.config.json defines paths to those files needed by the msportalfx-ut node module to generate everything under `./_generated/*`.  The keys are that need to be supplied on the config file are defined as follows:

- `UTNodeModuleRootPath`: the root path to where the msportalfx-ut node module was installed.
- `GeneratedAssetRootPath`: the root path to save all assets that will be generated e.g your resx to AMD modules.
- `ExtensionTypingsFiles`: glob for d.ts files of the extension. these are copied to the `GeneratedAssetRootPath` so  that your d.ts files are not side by side with your extensions .ts files. This ensures that typescript module resolution does not pickup the source .ts file during build of your extension thereby ensuring your UT project does not compile extension *.ts files that are under test.
- `ResourcesResxRootDirectory`: extension client root directory that contains all *.resx files. These will be used to generate js AMD string resource modules into `GeneratedAssetRootPath` and the associated require config.

1. add ./msportalfx-ut.config.json with the following value:

```json

{"gitdown": "include-file", "file": "../samples/VS/PT/Default/Extension.UnitTests/msportalfx-ut.config.json"}

```

1. To ensure that your extension project is producing d.ts files update your extension.csproj `<TypeScriptGeneratesDeclarations>true</TypeScriptGeneratesDeclarations>` and build your Extension.csproj

1. If using Microsoft.Portal.Tools.*V2*.targets in your Extension.csproj update ExtensionTypingsFiles as follows:

    `"ExtensionTypingsFiles": "../Extension/Output/typings/**/*.d.ts",`

NOTE: if your official build environment uses different paths then your dev environment you can override them either by using command line arguments or environmental variables.  The msportalfx-ut gulpfile will search in the following order command line argument > environmental variable > ./msportalfx-ut.config.json file.  An example of overriding an item for an official build via a command line argument `gulp --UTNodeModuleResolutionPath ./some/other/location`

## Add a test

To compile your test and for dev time intellisense you will need a ./tsconfig.json

```json

{"gitdown": "include-file", "file": "../samples/VS/PT/Default/Extension.UnitTests/tsconfig.json"}

```

Add a test to ./test/ResourceOverviewBlade.test.ts.  You can modify this example for your own extension

```typescript
    
{"gitdown": "include-file", "file": "../samples/VS/PT/Default/Extension.UnitTests/test/ResourceOverviewBlade.test.ts"}

````

### Build your test project

run the following command

```

npm run build

```

## Configure Require and Mocha using add test-main.js

requirejs will need to know where all your modules are located for your extension and any frameworks that you are using

```javascript

{"gitdown": "include-file", "file": "../samples/VS/PT/Default/Extension.UnitTests/test-main.js"}

```
### Configure your test runner

In this example we will  using karmajs as a test runner.  It provides a rich plugin ecosystem for compile on save based dev/test cycles, test reporting and code coverage to name a few.

add a file named ./karma.conf.js

```javascript
  
  {"gitdown": "include-file", "file": "../samples/VS/PT/Default/Extension.UnitTests/karma.conf.js"}

```

### Run your tests

Using a browser as a host:
`npm run test-dev` opens index.html in your regular browser.

Using a karmajs to host and run your tests
`npm run test` opens index.html in your regular browser.

Using karmajs for a single test run useful for scenarios such as running in CI 

`npm run test-ci` opens index.html in your regular browser.

you will note that these last two are configured to run in Edge and Chrome. You may also pick and choose additional browsers via the launcher plugins [documented here](https://karma-runner.github.io/2.0/config/browsers.html).

### Test Output for CI

By Default the project template/steps above will generate a project configured to produce JUNIT and TRX output. This should be useful for most CI environments. The content will be output under ./TestResults/**/*.xml|trx.  To configure the output paths update karma.conf.js. For more plugins for outputing in a format your CI environment supports see [karmajs official docs](https://karma-runner.github.io/2.0/index.html).

Note: generated via `npm run test` or `npm run test-ci`
### Code Coverage

By Default the project template/steps above will generate a project configured that also produces code coverage using karma-coverage. The content will be output under ./TestResults/Coverage/**/index.html

Note: generated via `npm run test` or `npm run test-ci`

# FAQ

## When I do File `File > New > Project > Visual C# > Azure Portal` I get the following error

```

Severity    Code    Description Project File    Line    Suppression State
Error       Could not install package 'PortalFx.NodeJS8 10.0.0.125'. You are trying to install this package into a project that targets '.NETFramework,Version=v4.6.1', but the package does not contain any assembly references or content files that are compatible with that framework. For more information, contact the package author

```

Solution: Install the `Node Tools for Visual Studio` [from here](https://github.com/Microsoft/nodejstools/releases/tag/v1.3.1)

## Corext Environments

Build environments which are setup using Corext will need to manually add additional lines in order to specify where to pick up the Unit Test Framework NuGet package.
This NuGet package will be expanded at a different location (CxCache) than the default, so you need to update your Corext config and the npm packages.json in order to
point to the correct location.

### Common Error

If you are a executing the default instructions on your Corext environment, this is the error you will see:

`npm ERR! enoent ENOENT: no such file or directory, stat 'C:\...\ExtensionName\packages\Microsoft.Portal.TestFramework.UnitTest.5.0.302.979\msportalfx-ut-5.302.979.tgz'`

This error indicates that it cannot find the expanded NuGet package for the Unit Test Framework. 

### Fix

1. **Update your Repository's `corext.config`**

    Found under `\<ExtensionRepoName>\.corext\corext.config`

    Under the `<generator>` section add the following to the bottom:

    ```xml
    <!-- Unit Test Framework -->
    <package id="Microsoft.Portal.TestFramework.UnitTest" />
    ```

2. **Update your Extension's `package.config`**

    Found under `\<ExtensionRepoName>\src\<ExtensionName>\packages.config`

    Add the folowing to your `<packages>`:

    ```xml
    <package id="Microsoft.Portal.TestFramework.UnitTest" version="5.0.302.1016" targetFramework="net45" />
    ```

    **Note:** *The version listed above should match the version of the Portal SDK you are using for your extension and will match the `"Microsoft.Portal.Framework"` package in your `packages.config`.*

3. **Update your Unit Test `package.json`**

    Found under `<ExtensionRepoName>\src\<ExtensionName>.UnitTests\package.json`

    If you have the package `msportalfx-ut` in your dependencies, remove it.

    Update your scripts init command to be the following:

    `"init": "npm install --no-optional && npm install %PkgMicrosoft_Portal_TestFramework_UnitTest%\\msportalfx-ut-5.302.1016.tgz --no-save",`

    **Note:** *The version listed above should match the version of the Portal SDK you are using for your extension and will match the `"Microsoft.Portal.Framework"` package in your `packages.config`.*

4. **Run the following commands to finish the setup**

    * Run Corext Init - From the root of your repository run: `init`
    * Run the Npm install - From your Unit Test directory run: `npm run init`

## Simple html test harness for running mocha tests

Even though it is not that useful for gated CI some teams prefer to have a simple index.html for debugging their tests in the browser rather than using the karma Debug view. If you would like this alternative approach use the following.

```html

{"gitdown": "include-file", "file": "../samples/VS/PT/Default/Extension.UnitTests/index.html"}

```