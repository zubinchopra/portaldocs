{"gitdown": "contents"}

# Performance Overview

Portal performance from a customer's perspective is seen as all experiences throughout the product. 
As an extension author you have a duty to uphold your experience to the performance bar at a minimum.

| Area      | 95th Percentile Bar | Telemetry Action         | How is it measured? |
| --------- | ------------------- | ------------------------ | ------------------- |
| Extension | < 4 secs       | ExtensionLoad            | The time it takes for your extension's home page to be loaded and initial scripts, the `initialize` call to complete within your Extension definition file  |
| Blade     | < 4 secs       | BladeFullReady           | The time it takes for the blade's `onInitialize` or `onInputsSet` to resolve and all the parts on the blade to become ready |
| Part      | < 4 secs       | PartReady                | Time it takes for the part to be rendered and then the part's OnInputsSet to resolve |
| WxP       | > 80       | N/A                      | An overall experience score, calculated by weighting blade usage and the blade full ready time |

## Extension performance

Extension performance effects both Blade and Part performance, as your extension is loaded and unloaded as and when it is required.
In the case a user is visiting your resource blade for the first time, the Fx will load up your extension and then request the view model, consequently your Blade/Part performance is effected.
If the user were to browse away from your experience and browse back before your extension is unloaded obviously second visit will be faster, as they don't pay the cost of loading the extension.

## Blade performance

Blade performance is spread across a couple of main areas:

1. Blade's constructor
1. Blade's onInitialize or onInputsSet
1. Any Parts within the Blade become ready

If your blade is a FrameBlade or AppBlade there is an additional initialization message from your iframe to your viewmodel which is also tracked, see the samples extension [framepage.js](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx?path=%2Fsrc%2FSDK%2FAcceptanceTests%2FExtensions%2FSamplesExtension%2FExtension%2FContent%2FScripts%2Fframepage.js&version=GBproduction&_a=contents) for an example of what messages are required.

All of which are encapsulated under the one 'BladeFullReady' action.

### BladePerformanceIncludingNetwork()

In the case of the `BladePerformanceIncludingNetwork` function, we sample 1% of traffic to measure the number of network requests that are made throughout their session, that sampling does not affect the overall duration that is reported. Within the function we will correlate the count of any network requests, these are tracked in telemetry under the action `XHRPerformance`, made when the user is loading a given blade. It does not impact the markers that measure performance. That said a larger number of network requests will generally result in slower performance.

The subtle difference with the standard `BladeFullReady` marker is that if the blade is opened up within a resource menu blade we will attribute the time it takes to resolve the `getMenuConfig` promise as the resource menu blade is loaded to the 95th percentile of the 'BladeFullReady' duration. This is attributed using a proportional calculation based on the number of times the blade is loaded inside the menu blade.

For example, a blade takes 2000ms to complete its `BladeFullReady` and 2000ms to return its `getMenuConfig`.
It is only loaded once (1) in the menu blade out of it's 10 loads. It's overall reported FullDuration would be 2200ms.

BladePerformanceIncludingNetwork will return a table with the following columns

 - FullBladeName, Extension, BladeName
   - Blade/Extension identifiers
 - BladeCount
   - The number of blade loads within the given date range
 - InMenuLoads
   - The number of in menu blade loads within the given date range
 - PctOfMenuLoads
   - The percentage of in menu blade loads within the given date range
 - Samples
   - The number of loads which were tracking the number of XHR requests
 - StaticMenu
   - If the `getMenuConfig` call returns within < 10ms, only applicable to ResourceMenu cases
 - MenuConfigDuration95
   - The 95th percentile of the `getMenuConfig` call
 - LockedBlade
   - If the blade is locked, ideally blades are now template blades or no-pdl
   - All no-pdl and template blades are locked, pdl blades can be made locked by setting the locked property to true
 - XHRCount, XHRCount95th, XHRMax
   - The 50th percentile (95th or MAX) of XHR requests sent which correlate to that blade load
 - Bytes
   - Bytes transferred to the client via XHR requests
 - FullDuration50, 80, 95, 99
   - The time it takes for the `BladeFullReady` + (`PctOfMenuLoads` * the `getMenuConfig` to resolve)
 - RedScore
   - Number of violations for tracked bars
 - AlertSeverity
   - If the blade has opted to be alerted against via the [alerting infrastructure][1] and what severity the alert will open at.

## Part performance

Similar to Blade performance, Part performance is spread across a couple of areas:

1. Part's constructor
1. Part's onInitialize or onInputsSet

If you part is a FramePart there is an additional initialization message from your iframe to your viewmodel which is also tracked, see the samples extension [framepage.js](https://msazure.visualstudio.com/One/Azure%20Portal/_git/AzureUX-PortalFx?path=%2Fsrc%2FSDK%2FAcceptanceTests%2FExtensions%2FSamplesExtension%2FExtension%2FContent%2FScripts%2Fframepage.js&version=GBproduction&_a=contents) for an example of what messages are required.

All of which are encapsulated under the one 'PartReady' action.

## WxP score

The WxP score is a per extension Weight eXPerience score (WxP). It is calculated by the as follows:

```txt

WxP = (BladeViewsMeetingTheBar * 95thPercentileBar) / ((BladeViewsMeetingTheBar * 95thPercentileBar) + ∑(BladeViewsNotMeetingTheBar * ActualLoadTimePerBlade))

```

| Blade   | 95th Percentile Times | Usage Count | Meets 95th Percentile Bar? |
| ------- | --------------------- | ----------- | -------------------------- |
| Blade A | 1.2                   | 1000        | Yes                        |
| Blade B | 5                     | 500         | No                         |
| Blade C | 6                     | 400         | No                         |

```txt

WxP = (BladeViewsMeetingTheBar * 95thPercentileBar) / ((BladeViewsMeetingTheBar * 95thPercentileBar) + ∑(BladeViewsNotMeetingTheBar * ActualLoadTimePerBlade)) %
    = (4 * 1000) / ((4 * 1000) + ((5 * 500) + (6 * 400))) %
    = 44.94%

```

As you can see the model penalizes the number of views which don’t meet the bar and also the count of those.

## How to assess your performance

There is two methods to assess your performance:

1. Visit the IbizaFx provided PowerBi report*
1. Run Kusto queries locally to determine your numbers

    (*) To get access to the PowerBi dashboard reference the [Telemetry onboarding guide][TelemetryOnboarding], then access the following [Extension performance/reliability report][Ext-Perf/Rel-Report]

The first method is definitely the easiest way to determine your current assessment as this is maintained on a regular basis by the Fx team.
You can, if preferred, run queries locally but ensure you are using the Fx provided Kusto functions to calculate your assessment.

# Performance Frequently Asked Questions (FAQ)

## My Extension 'load' is above the bar, what should I do

1. Profile what is happening in your extension load. [Profile your scenario](#performance-profiling)
1. Are you using the Portal's ARM token? If no, verify if you can use the Portal's ARM token and if yes, follow: [Using the Portal's ARM token](http://NEED_LINK.com)
1. Are you on the hosting service? If no, migrate to the hosting service: [Hosting service documentation](portalfx-extension-hosting-service.md#extension-hosting-service)
1. Are you using obsolete bundles? If yes, remove your dependency to them and then remove the obsolete bitmask. See below for further details.
1. Do you see any waterfalling or serialized bundle requests? If yes, ensure you have the proper bundling hinting in place. [Optimize bundling](http://NEED_LINK.com) 

## My Blade 'FullReady' is above the bar, what should I do

1. Assess what is happening in your Blades's `onInitialize` or constructor and `onInputsSet`. [Profile your scenario](#performance-profiling)
    1. Can that be optimized?
1. If there are any AJAX calls;
    1. Can they use batch? If so, migrate over to use the batch api.
    1. Wrap them with custom telemetry and ensure they you aren't spending a large amount of time waiting on the result. If you are to do this, please only log one event per blade load, this will help correlate issues but also reduce unneccesary load on telemetry servers.
1. How many parts are on the blade?
    - If there is only a single part, if you're not using a no-pdl blade or `<TemplateBlade>` migrate your current blade to a no-pdl blade.
    - If there are multiple parts, migrate over to use a no-pdl blade
1. See our [best practices](#performance-best-practices)
    
## My Part 'Ready' is above the bar, what should I do

1. Assess what is happening in your Part's `onInitialize` or constructor and `onInputsSet`. [Profile your scenario](#performance-profiling)
    1. Can that be optimized?
1. If there are any AJAX calls;
    1. Can they use batch? If so, migrate over to use the batch api.
    1. Wrap them with custom telemetry and ensure they you aren't spending a large amount of time waiting on the result. If you are to do this, please only log one event per part load, this will help correlate issues but also reduce unneccesary load on telemetry servers.
1. See our [best practices](#performance-best-practices)

## My WxP score is below the bar, what should I do

Using the [Extension performance/reliability report][Ext-Perf/Rel-Report] you can see the WxP impact for each individual blade. Although given the Wxp calculation,
if you are drastically under the bar its likely a high usage blade is not meeting the performance bar, if you are just under the bar then it's likely it's a low usage
blade which is not meeting the bar.

## Is there any way I can get further help

Sure! Book in some time in the Azure performance office hours.

- __When?__  Wednesdays from 1:00 to 3:30
- __Where?__ B42 (Conf Room 42/46)
- __Contacts:__ Sean Watson (sewatson)
- __Goals__
    - Help extensions to meet the performance bar
    - Help extensions to measure performance 
    - Help extensions to understand their current performance status
- __How to book time__: Send a meeting request with the following
    - TO: sewatson;
    - Subject: YOUR_EXTENSION_NAME: Azure performance office hours
    - Location: Conf Room 42/46 (It is already reserved)

# Performance best practices

## Operational best practices

- Enable performance alerts
    - To ensure your experience never regresses unintentionally, you can opt into configurable alerting on your extension, blade and part load times. See [performance alerting](index-portalfx-extension-monitor.md#performance)
- Move to [hosting service](portalfx-extension-hosting-service.md#extension-hosting-service)
    - If you are not on the hosting service ensure;
        1. Homepage caching is enabled
        1. Persistent content caching is enabled
        1. Compression is enabled
        1. Your service is efficiently geo-distributed (Note: we have seen better performance from having an actual presence in a region vs a CDN)
- Compression (Brotli)
    - Move to V2 targets to get this by default
- Remove controllers 
    - Don't proxy ARM through your controllers
- Don't require full libraries to make use of a small portion
    - Is there another way to get the same result?
- If your using iframe experiences
    1. Ensure you have the correct caching enabled
    1. Ensure you have compression enabled
    1. Are you serving your iframe experience geo-distributed efficiently?

## Coding best practices

- Reduce network calls
    - Ideally 1 network call per blade
    - Utilise `batch` to make network requests, see our [batch documentation](http://aka.ms/portalfx/docs/batch)
- Remove automatic polling
    - If you need to poll, only poll on the second request and ensure `isBackgroundTask: true` in the batch call
- Optimize bundling (Avoiding the waterfall)

    ```typescript
    /// <amd-bunding root="true" priority="0" />

    import ClientResources = require("ClientResources");
    ```

- Remove all dependencies on obsoleted code
    - Loading any required obsoleted bundles is a blocking request during your extension load times
    - See https://aka.ms/portalfx/obsoletebundles for further details
- Use the Portal's ARM token
- Don't use old PDL blades composed of parts: [hello world template blade](portalfx-no-pdl.md#building-a-hello-world-template-blade-using-decorators)
    - Each part on the blade has it's own viewmodel and template overhead, switching to a no-pdl template blade will mitigate that overhead
- Use the latest controls available: see https://aka.ms/portalfx/playground
    - This will minimise your observable usage
    - The newer controls are AMD'd reducing what is required to load your blade
- Remove Bad CSS selectors
    - Build with warnings as errors and fix them
    - Bad CSS selectors are defined as selectors which end in HTML elements for example `.class1 .class2 .class3 div { background: red; }`
        - Since CSS is evaluated from right-to-left the browser will find all `div` elements first, this is obviously expensive
- Fix your telemetry
    - Ensure you are returning the relevant blocking promises as part of your initialization path (`onInitialize` or `onInputsSet`), today you maybe cheating the system but that is only hurting your users.
    - Ensure your telemetry is capturing the correct timings

## General best practices

- Test your scenarios at scale
    - How does your scenario deal with 100s of subscriptions or 1000s of resources?
    - Are you fanning out to gather all subscriptions, if so do not do that.
        - Limit the default experience to first N subscriptions and have the user determine their own scope.
- Develop in diagnostics mode
    - Use https://portal.azure.com?trace=diagnostics to detect console performance warnings
        - Using too many defers
        - Using too many ko.computed dependencies
- Be wary of observable usage
    - Try not to use them unless necessary
    - Don't aggreesively update UI-bound observables
        - Accumulate the changes and then update the observable
        - Manually throttle or use `.extend({ rateLimit: 250 });` when initializing the observable
- Run portalcop to identify and resolve common performance issues

# Performance profiling 

## How to profile your scenario

1. Open a browser and load portal using https://portal.azure.com/?clientoptimizations=bundle&feature.nativeperf=true​
    - `clientOptimizations=bundle` will allow you to assess which bundles are being downloaded in a user friendly manner
    - `feature.nativeperf=true` will expose native performance markers within your profile traces, allowing you to accurately match portal telemetry markers to the profile
1. Go to a blank dashboard​
1. Clear cache (hard reset) and reload the portal​
1. Use the browsers profiling timeline to throttle both network and CPU, this best reflects the 95th percentile scenario, then start the profiler
1. Walk through your desired scenario
    - Switch to the desired dashboard
    - Deep link to your blade, make sure to keep the feature flags in the deep link. Deeplinking will isolate as much noise as possible from your profile
1. Stop the profiler
1. Assess the profile

## Idenitifying common slowdowns

1. Blocking network calls
    - Fetching data - We've seen often that backend services don't have the same performance requirements as the front end experience, because of which you may need to engage your backend team/service to ensure your front end experience can meet the desired performance bar. 
    - Required files - Downloading more than what is required, try to minimise your total payload size. 
1. Heavy rendering and CPU from overuse of UI-bound observables
    - Are you updating the same observable repeatedly in a short time frame? Is that reflected in the DOM in any way? Do you have computeds listening to a large number of observables?

## Verifying a change

To correctly verify a change you will need to ensure the before and after are instrumented correctly with telemetry. Without that you cannot truly verify the change was helpful.
We have often seen what seems like a huge win locally transition into a smaller win once it's in production, we've also seen the opposite occur too.
The main take away is to trust your telemetry and not profiling, production data is the truth. 


[TelemetryOnboarding]: <portalfx-telemetry-getting-started.md>
[Ext-Perf/Rel-Report]: <http://aka.ms/portalfx/dashboard/extensionperf>