
## Configuration

This document will describe the behavior and list common configuration settings used by the MsPortalFx-Test framework.

### Behavior

The test framework will search for a config.json in the current working directory (usually the directory the test is invoked from).  If no config.json is found then it will check the parent folder for a config.json (and so on...).

### PortalContext

This file contains a list of configuration values used by the test framework for context when running tests against the portal.
These values are mutable to allow test writers to set the values in cases where they prefer not to store them in the config.json.
We strongly recommend that passwords should not be stored in the config.json file.

```ts
﻿import TestExtension = require("./TestExtension");
import Feature = require("./Feature");
import BrowserResolution = require("./BrowserResolution");
import Timeout = require("./Timeout");

/**
 * Represents The set of options used to configure a Portal instance.
 */
interface PortalContext {
    /**
     * The set of capabilities enabled in the webdriver session. 
     * For a list of available capabilities, see https://github.com/SeleniumHQ/selenium/wiki/DesiredCapabilities
     */    
    capabilities: {
        /**
         * The name of the browser being used; should be one of {chrome} 
         */
        browserName: string;

        /**
         * Chrome-specific supported capabilities. 
         */
        chromeOptions: {
            /**
             * List of command-line arguments to use when starting Chrome.
             */
            args: string[]
        };

        /**
         * The desired starting browser's resolution in pixels.
         */
        browserResolution: BrowserResolution;
    },
    /**
     * The path to the ChromeDriver binary. 
     */
    chromeDriverPath?: string;
    /**
     * The url of the Portal.
     */
    portalUrl: string;
    /**
     * The url of the page where signin is performed.
     */
    signInUrl?: string;
    /**
     * Email of the user used to sign in to the Portal.
     */
    signInEmail?: string;
    /**
     * Password of the user used to sign in to the Portal.
     */
    signInPassword?: string;    
    /**
     * The set of features to enable while navigating within the Portal.
     */
    features?: Feature[];
    /**
     * The list of patch files to load within the Portal.
     */
    patches?: string[];
    /**
     * The set of extensions to side load while navigating within the Portal.
     */
    testExtensions?: TestExtension[];
    /**
     * The set of timeouts used to override the default timeouts.
     * e.g. 
     * timeouts: {
     *      timeout: 15000  //Overrides the default short timeout of 10000 (10 seconds).
     *      longTimeout: 70000 //Overrides the default long timetout of 60000 (60 seconds).
     * }
     */
    timeouts?: Timeout;
}

export = PortalContext;
```

### Running tests against the Dogfood environment

In order to run tests against the Dogfood test environment, you will need to update the follow configuration settings in the config.json:

```json
{
  portalUrl: https://df.onecloud.azure-test.net/,
  signInUrl: https://login.windows-ppe.net/
}
```