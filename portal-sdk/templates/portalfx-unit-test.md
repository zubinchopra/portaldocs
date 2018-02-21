
# Unit Test Framework preview

## Getting Started with Visual Studio (Coming Soon)

1. In Visual Studio `File > New > Project > Visual C# > Azure Portal` will scaffold you a Solution with two projects Extension.csproj and Extension.UnitTest.csproj
1. On the Extension.UnitTests project right click on `npm > Install Missing npm Packages`
1. Build Extension.UnitTests.csproj `Ctl + Shift + B`
1. Open index.html in a browser

note you can also run  `npm run test` from the commandline.

## Creating a project from scratch with Visual Studio Code

Available from [SDK 5.0.302.1016](https://aka.ms/portalfx/download)

This tutorial will provide you step by step instructions for creating a UnitTest project for your Azure Portal Extension.  The resulting folder structure will look like the following:

```

+-- Extension
+-- Extension.UnitTests
|   +-- test/ResourceOverviewBlade.test.ts
|   +-- init.js
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
      <script src="./_generated/Fx/FxScriptDependencies.js"></script>
    </body>
  </html>

```

### to generate FxScriptDependencies.js

In the ./index.html the last script imported is `./_generated/Fx/FxScriptDependencies.js`. This generated script:

- correctly references Framework scripts in the required order
- sets up require config for Framework AMD modules.
- generates string resource AMD modules from the extension's resx files.
- sets up require config for string resource AMD modules from resx files

To generate this script and all other dependencies it requires to be able to successfully run tests, msportalfx-ut provides a gulpfile that automates the generation of FxScriptDependencies.js and is executed via the `prereq` script below.

#### Add ./package.json

```json
{
  "name": "extension-ut",
  "version": "1.0.0",
  "description": "",
  "main": "index.html",
  "scripts": {
    "init": "npm install --no-optional",
    "prereq": "gulp --gulpfile=./node_modules/msportalfx-ut/gulpfile.js --cwd ./",
    "build": "npm run prereq && tsc -p tsconfig.json",
    "build-trace": "tsc -p tsconfig.json --diagnostics --listFiles --listEmittedFiles --traceResolution",
    "test": "npm run build && index.html"
  },
  "keywords": [
    "unittest"
  ],
  "author": "Microsoft",
  "license": "MIT",
  "dependencies": {
    "@types/chai": "4.0.4",
    "@types/mocha": "2.2.44",
    "@types/nconf": "0.0.35",
    "@types/sinon": "2.1.3",
    "chai": "4.1.2",
    "gulp": "3.9.1",
    "nconf": "0.10.0",
    "mocha": "2.2.5",
    "msportalfx-ut": "file:../../packages/Microsoft.Portal.TestFramework.UnitTest.5.0.302.979/msportalfx-ut-5.302.979.tgz",
    "sinon": "4.2.1",
    "typescript": "2.3.3"
  }
}

```

Note: In this case we're using mocha and chai but you can choose your own test and assertion framework.
Note: msportalfx-ut.*.tgz ships in the Microsoft.Portal.TestFramework.UnitTest NuGet package.  You can add a reference to it in your ./YourExtension/packages.config and a file:// reference to the path where it will be unpacked.

Save the above to ./package.json and run the following command:

```

npm install --no-optional

```

the reference to the msportalfx-ut gulpfile will provide a default gulp task that will generate FxScriptDependencies.js and its dependencies. To run the script config items must be specified in msportalfx-ut.config.json.

#### add ./msportalfx-ut.config.json

msportalfx-ut.config.json defines paths to those files needed by the msportalfx-ut node module to generate `./_generated/Fx/FxScriptDependencies.js`.  The keys are defined as follows:

- `UTNodeModuleRootPath`: the root path to where the msportalfx-ut node module was installed.
- `GeneratedAssetRootPath`: the root path for all assets, such as FxScriptDependencies.js, that will be generated.
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

## Configure Require and Mocha using add init.js

requirejs will need to know where all your modules are located for your extension and any frameworks that you are using

```typescript

(function () {
    "use strict";

    //setup mocha
    mocha.setup({ ui: 'bdd', timeout: 240000 });

    var rjs = requirejs.config({
        baseUrl: "",
        paths: {
            "_generated": "./../Extension/Client/_generated",
            "Resource": "./../Extension/Client/Resource",
            "Shared": "./../Extension/Client/Shared",
            "sinon": "./node_modules/sinon/pkg/sinon",
            "chai": "./node_modules/chai/chai",
        },
        shim: {
        }
    });

    //run tests comma separated list of test files.
    rjs(["./test/ResourceOverviewBlade.test"], function () {
        mocha.checkLeaks();
        mocha.run();
    });
})();

```

### Run your tests

`npm run test` or open index.html in a browser if you have already performed a build.
