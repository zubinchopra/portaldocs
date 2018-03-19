# Unit Test Framework preview
Covered in this document:

- File > New Project scaffolding
- Creating a project from scratch
- CI: test results output to CI accepted formats JUNIT, TRX, other.
- Code Coverage: where to find your code coverage output

## Getting Started with Visual Studio (Coming Soon)

1. To support the Unit Test project in Visual Studio you must first install the `Node Tools for Visual Studio` [from here](https://github.com/Microsoft/nodejstools/releases/tag/v1.3.1) then
1. Launch Visual Studio and click `File > New > Project > Visual C# > Azure Portal`. It will scaffold a Solution with two projects Extension.csproj and Extension.UnitTest.csproj
1. Build the solution `Ctl + Shift + B`
1. Open index.html in a browser

note you can also run  `npm run test` from the commandline.

## Creating a project from scratch with Visual Studio Code

Available from [SDK 5.0.302.1016](https://aka.ms/portalfx/download)

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

### Add ./index.html for running tests

```html

<html>
<head>
  <meta charset="utf-8">
  <title>Mocha Tests</title>
  <link href="./node_modules/mocha/mocha.css" rel="stylesheet" />
</head>
<body>
  <div id="mocha"></div>
  <!-- mocha prereq -->
  <script type="text/javascript" charset="utf-8" src="./node_modules/mocha/mocha.js"></script>
  <script type="text/javascript" charset="utf-8" src="./node_modules/chai/chai.js"></script>
  <!-- fx prereq -->
  <script src="./node_modules/msportalfx-ut/lib/FxScripts.js"></script>
  <!-- extension scripts -->
  <script src="./_generated/Ext/ExtensionStringResourcesRequireConfig.js"></script>
  <script src="./test-main.js"></script>
</body>
</html>

```

### to generate FxScriptDependencies.js

In the ./index.html the following scripts are imported

- `mocha.js`: this test framework is used in the shipped sample. Note that you may choose to use whatever test framework you wish. msportalfx-ut is test framewwork agnostic.
- `chai.js`: test assertion framework. Note that you may choose to use whatever test framework you wish. msportalfx-ut is test framewwork agnostic.
- `./node_modules/msportalfx-ut/lib/FxScripts.js`: this is an aggregate script that contains all portal scripts required as a pre-req for your test context. This script includes: default setup of window.fx.*, all portal bundles required to successfully load your blades, all requirejs config required to load your blades.
- `./_generated/Ext/ExtensionStringResourcesRequireConfig.js` requirejs mapping for AMD modules generated from from the extension's resx files.
- `./test-main.js` entrypoint to setup your test runner and extensions require config.

To generate `./_generated/Ext/ExtensionStringResourcesRequireConfig.js` and to copy typings local to the test context, msportalfx-ut provides a gulpfile that automates the generation of content under `./_generated/Ext/`. It can be executed as part of the `prereq` script below.

#### Add ./package.json

```json
{
  "name": "extension-ut",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "init": "npm install --no-optional",
    "prereq": "npm run init && gulp --gulpfile=./node_modules/msportalfx-ut/gulpfile.js --cwd ./",
    "build": "npm run prereq && tsc -p tsconfig.json",
    "test": "npm run build && karma start",
    "test-ci": "npm run build && karma start --single-run",
    "test-dev": "npm run build && index.html"
  },
  "keywords": [
    "unittest"
  ],
  "author": "Microsoft",
  "license": "MIT",
  "dependencies": {
    "@types/chai": "4.1.2",
    "@types/mocha": "2.2.48",
    "@types/nconf": "0.0.37",
    "@types/sinon": "4.3.0",
    "chai": "4.1.2",
    "gulp": "3.9.1",
    "gulp-concat": "2.6.1",
    "karma": "2.0.0",
    "karma-chai": "0.1.0",
    "karma-chrome-launcher": "2.2.0",
    "karma-coverage": "1.1.1",
    "karma-edge-launcher": "0.4.2",
    "karma-mocha": "1.3.0",
    "karma-junit-reporter": "1.2.0",
    "karma-requirejs": "1.1.0",
    "karma-trx-reporter": "0.2.9",
    "mocha": "5.0.4",
    "msportalfx-ut": "file:../../packages/Microsoft.Portal.TestFramework.UnitTest.5.0.302.979/msportalfx-ut-5.302.979.tgz",
    "nconf": "0.10.0",
    "requirejs": "2.3.5",
    "sinon": "4.4.3",
    "typescript": "2.3.3"
  },
  "devDependencies": {
  }
}

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

    {
        "UTNodeModuleRootPath" : "./node_modules/msportalfx-ut",
        "GeneratedAssetRootPath" : "./_generated",
        "ExtensionTypingsFiles": "../Extension/**/*.d.ts",
        "ResourcesResxRootDirectory": "../Extension/Client"
    }

    ```

1. To ensure that your extension project is producing d.ts files update your extension.csproj `<TypeScriptGeneratesDeclarations>true</TypeScriptGeneratesDeclarations>` and build your Extension.csproj

1. If using Microsoft.Portal.Tools.*V2*.targets in your Extension.csproj update ExtensionTypingsFiles as follows:

    `"ExtensionTypingsFiles": "../Extension/Output/typings/**/*.d.ts",`

NOTE: if your official build environment uses different paths then your dev environment you can override them either by using command line arguments or environmental variables.  The msportalfx-ut gulpfile will search in the following order command line argument > environmental variable > ./msportalfx-ut.config.json file.  An example of overriding an item for an official build via a command line argument `gulp --UTNodeModuleResolutionPath ./some/other/location`

## Add a test

To compile your test and for dev time intellisense you will need a ./tsconfig.json

```json

{
  "compilerOptions": {
    "experimentalDecorators": true,
    "module": "amd",
    "sourceMap": false,
    "baseUrl": ".",
    "rootDir": ".",
    "target": "es5",
    "paths": {
      "msportalfx-ut/*": ["./node_modules/msportalfx-ut/lib/*"],
      "*": [
        "./_generated/Ext/typings/Client/*",
        "./node_modules/@types/*/index"
      ]
    }
  },
  "include": [
    "./_generated/Ext/typings/Definitions/*",
    "test/**/*"
  ]
}

```

Add a test to ./test/ResourceOverviewBlade.test.ts.  You can modify this example for your own extension

```typescript

import { assert } from "chai";
import { DataContext } from "Resource/ResourceArea";
import { Parameters, ResourceOverviewBlade } from "Resource/ResourceOverviewBlade";
import ClientResources = require("ClientResources");
import * as sinon from "sinon";
import { TemplateBladeHarness } from "msportalfx-ut/Harness";

describe("Resource Overview Blade Tests", () => {
  let server: sinon.SinonFakeServer;

  beforeEach(function () {
    server = sinon.fakeServer.create();
    server.respondImmediately = true;
  });

  afterEach(function () {
    server.restore();
  });

  it("title populated with content from ARM", (done) => {
    // arrange
    const resourceId = "/subscriptions/0c82cadf-f711-4825-bcaf-44189e8baa9f/resourceGroups/sdfsdfdfdf/providers/Providers.Test/statefulIbizaEngines/asadfasdff";
    server.respondWith((request) => {
      switch (request.requestHeaders["x-ms-path-query"].split("?")[0]) {
        case resourceId:
          request.respond(200, { "Content-Type": "application/json" }, JSON.stringify({ id: "foo", name: "bar", location: "eastus" }));
          break;
        default:
          request.respond(404, null, "not mocked");
      }
    });

    const bladeParameters = { id: resourceId };
    // options for the blade under test. optional callbacks beforeOnInitializeCalled, afterOnInitializeCalled and afterRevealContentCalled
    // can be supplied to execute custom test code
    const options = {
      parameters: bladeParameters,
      dataContext: new DataContext(),
    };

    // get blade instance with context initialized and onInitialized called
    return TemplateBladeHarness.initializeBlade(ResourceOverviewBlade, options).then((resourceBlade) => {
      assert.equal(resourceBlade.title(), "bar");
      assert.equal(resourceBlade.subtitle, ClientResources.resourceOverviewBladeSubtitle);
    }).then(
      () => done(),
      (e) => done(e));
  });
});

````

### Build your test project

run the following command

```

npm run build

```

## Configure Require and Mocha using add test-main.js

requirejs will need to know where all your modules are located for your extension and any frameworks that you are using

```typescript

  window.fx.environment.armEndpoint = "https://management.azure.com";
  window.fx.environment.armApiVersion = "2014-04-01";

  const allTestFiles = []
  if(window.__karma__) {
    const TEST_REGEXP = /^\/base\/Extension.UnitTests\/Output\/.*(spec|test)\.js$/i;
    // Get a list of all the test files to include
    Object.keys(window.__karma__.files).forEach(function (file) {
      if (TEST_REGEXP.test(file)) {
        // Normalize paths to RequireJS module names.
        // If you require sub-dependencies of test files to be loaded as-is (requiring file extension)
        // then do not normalize the paths
        const normalizedTestModule = file.replace(/^\/base\/Extension.UnitTests\/|\.js$/g, "")
        allTestFiles.push(normalizedTestModule)
      }
    });
  } else {
    // if using index.html rather than the perferred above karmajs as the test host then add files here.
    allTestFiles.push("./Output/test/ResourceOverviewBlade.test");
  }

  mocha.setup({
    ui: "bdd",
    timeout: 60000,
    ignoreLeaks: false,
    globals: [] });

  rjs = require.config({
    // Karma serves files under /base, which is the basePath from your config file
    baseUrl: window.__karma__ ? "/base/Extension.UnitTests" : "",
    paths: {
      "_generated": "../Extension/Client/_generated",
      "Resource": "../Extension/Client/Resource",
      "Shared": "../Extension/Client/Shared",
      "sinon": "node_modules/sinon/pkg/sinon",
      "chai": "node_modules/chai/chai",
  },
    // dynamically load all test files
    deps: allTestFiles,

    // kickoff karma or mocha
    callback: window.__karma__ ? window.__karma__.start : function () { return mocha.run(); }
  });

```
### Configure your test runner

In this example we will  using karmajs as a test runner.  It provides a rich plugin ecosystem for compile on save based dev/test cycles, test reporting and code coverage to name a few.

add a file named ./karma.conf.js

```

  // Karma configuration

  module.exports = function (config) {
    config.set({

      // base path that will be used to resolve all patterns (eg. files, exclude)
      basePath: "../",

      // frameworks to use
      // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
      frameworks: ["mocha"],

      plugins: [
        require("karma-mocha"),
        require("karma-edge-launcher"),
        require("karma-coverage"), // Include if you want coverage
        require("karma-chrome-launcher"),
        require("karma-junit-reporter"),  // Include if you want junit reporting
        require("karma-trx-reporter")   // Include if you want trx reporting
      ],
      // list of files / patterns to load in the browser
      files: [
        // chai assertion framework.
        { pattern: "Extension.UnitTests/node_modules/chai/**/*.js", included: false },
        // sinonjs used for mocking xhr.
        { pattern: "Extension.UnitTests/node_modules/sinon/**/*.js", included: false },
        // aggregate script of portal bundles required for test.
        "Extension.UnitTests/node_modules/msportalfx-ut/lib/FxScripts.js",
        // karma requirejs adapter required to successfully load requirejs in karma.
        "Extension.UnitTests/node_modules/karma-requirejs/lib/adapter.js",
        // generated require configs for extension resx files.
        { pattern: "Extension.UnitTests/_generated/Ext/**/*RequireConfig.js", included: true },
        // msportalfx-ut test harness and other test scripts you may load within a unit test.
        { pattern: "Extension.UnitTests/node_modules/msportalfx-ut/lib/*.js", included: false },
        // portal framework scripts.
        { pattern: "Extension.UnitTests/node_modules/msportalfx-ut/lib/fx/Content/Scripts/**/*.js", included: false },
        // reserved directory for generated content for framework.
        { pattern: "Extension.UnitTests/_generated/Fx/**/*.js", included: false },
        // generated content for extension.
        { pattern: "Extension.UnitTests/_generated/Ext/**/*.js", included: false },
        // make available compiled tests from tsconfig.json outDir
        { pattern: "Extension.UnitTests/Output/**/*.test.js", included: false },
        // make available all client extension code that unit tests will use.
        { pattern: "Extension/Client/**/*.js", included: false },
        // the entrypoint for running unit tests.
        "Extension.UnitTests/test-main.js",
      ],

      client: {
        mocha: {
          reporter: "html",
          ui: "bdd"
        }
      },

      // list of files / patterns to exclude
      exclude: [
      ],

      // preprocess matching files before serving them to the browser
      // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
      preprocessors: {
        "./Extension/Client/**/*.js": "coverage"
      },

      // available reporters: https://npmjs.org/browse/keyword/karma-reporter
      reporters: ["progress", "trx", "junit", "coverage"],

      // the default trx configuration
      trxReporter: { outputFile: "./TestResults/test-results.trx", shortTestName: false },

      junitReporter: {
        outputDir: "./Extension.UnitTests/TestResults", // results will be saved as $outputDir/$browserName.xml
        outputFile: "test-results.xml", // if included, results will be saved as $outputDir/$browserName/$outputFile
        suite: "Extension.UnitTests", // suite will become the package name attribute in xml testsuite element
        useBrowserName: true, // add browser name to report and classes names
        nameFormatter: undefined, // function (browser, result) to customize the name attribute in xml testcase element
        classNameFormatter: undefined, // function (browser, result) to customize the classname attribute in xml testcase element
        properties: {} // key value pair of properties to add to the <properties> section of the report
      },

      coverageReporter: {
        type: "html",
        dir: "./Extension.UnitTests/TestResults/coverage/"
      },

      // web server port
      port: 9876,

      // enable / disable colors in the output (reporters and logs)
      colors: true,

      // level of logging
      // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
      logLevel: config.LOG_INFO,

      // enable / disable watching file and executing tests whenever any file changes
      autoWatch: true,

      // start these browsers
      // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
      browsers: ["Chrome", "Edge"],

      // Continuous Integration mode
      // if true, Karma captures browsers, runs the tests and exits
      singleRun: false,

      // Concurrency level
      // how many browser should be started simultaneous
      concurrency: Infinity,
    })
}
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
