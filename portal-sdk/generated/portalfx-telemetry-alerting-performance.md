<a name="performance"></a>
# Performance

The alerts can be configured for extension performance, blade performance and part performance.

<a name="performance-configuration"></a>
## Configuration

At a high level you define;

1. An environment for the alerts to run against ("PROD" or "MPAC")
1. The configuration for the alerts within that environment (baseline)

```json
{
    ...
    "performance": [
        "environment": "PROD", 
        "baseline": [
            {
                "type": "extension", 
                "criteria": [
                    {
                        ...
                    },
                    ...
                ]
            },
            {
                "type": "blade", 
                "criteria": [
                    {
                        ...
                    },
                    ...
                ]
            },
            {
                "type": "part", 
                "criteria": [
                    {
                        ...
                    },
                    ...
                ]
            },
            ...
         ],
        "environment": "MPAC",
        "baseline": [
            {
                ...
            },
            ...
         ],
        ...
    ]
    ...
}
```

Per each of those, you can define a set of criteria like the below.

> Only blade or part are required to have a bladeName or partName property.

<a name="performance-configuration-what-is-environment"></a>
### What is environment?

Environment can be either "PROD" or "MPAC"

<a name="performance-configuration-what-is-baseline"></a>
### What is baseline?

A baseline is an array of criteria to run against that environment, see below for further examples.

<a name="performance-configuration-extension"></a>
### Extension

An example of an extension baseline 

```json
[
    { 
        "percentile": 80,
        "percentileThreshold": 4, 
        "minAffectedUserCount": 270, 
        "bottomMinAffectedUserCount": 54, 
        "severity": 3,
        "enabled": true
    },
   ...
]
```

<a name="performance-configuration-blade"></a>
### Blade

An example of a blade baseline

```json
[
    { 
        "percentile": 80, 
        "percentileThreshold": 3.34, 
        "minAffectedUserCount": 65, 
        "bottomMinAffectedUserCount": 13, 
        "bladeName": "ContainersBlade", 
        "severity": 3,
        "enabled": true
    },
   ...
]
```

<a name="performance-configuration-part"></a>
### Part

An example of a part baseline

> partName value is part’s full name.

```json
[
    { 
        "percentile": 95,
        "percentileThreshold": 7.17, 
        "minAffectedUserCount": 65, 
        "bottomMinAffectedUserCount": 13, 
        "partName": "Extension/Microsoft_Azure_Storage/PartType/StorageAccountPart", 
        "severity": 3,
        "enabled": true
    },
   ...
]
```

<a name="performance-configuration-what-is-percentile"></a>
### What is percentile?

This is at which percentile you want to measure the performance. Today the only options are 80 or 95.

<a name="performance-configuration-what-is-percentilethreshold"></a>
### What is percentileThreshold?

This is the minimum duration (in seconds) when {percentile}% of users is above the {percentileThreshold}.

<a name="performance-configuration-what-is-minaffectedusercount"></a>
### What is minAffectedUserCount?

This is the minimum number of users whose load duration is above {percentileThreshold}.

<a name="performance-configuration-what-is-bottomminaffectedusercount"></a>
### What is bottomMinAffectedUserCount?

This is used as a threshold to trigger an alert if the {percentile} defined is greater than or
equal to __double__ of the {percentileThreshold} defined.

> This is defaulted to 20% of {minAffectedUserCount}.

This is used to catch any unusual spikes on the weekends/low traffic periods.

<a name="performance-configuration-when-do-the-alerts-trigger"></a>
### When do the alerts trigger?

Every 5 minutes, we get percentile load duration for the last 90 minutes. We get the most recent 6 sample points and calculate a weighted percentile load duration based on the following formula.

```
Weighted duration = 8/24 * {most recent percentile load duration} + 6/24 * {2nd most recent percentile load duration} + 4/24 * {3rd…} + 3/24 * {4th …} + 2/24 * {5th …} + 1/24 * {6th …}
```

Alerts will only trigger when one of the following criteria is met.

1. Weighted duration is above {percentileThreshold} and affected user count is above {minAffectedUserCount}
1. Weighted duration is above 2 * {percentileThreshold} and affected user count is above {bottomMinAffectedUserCount}

<a name="performance-how-often-do-they-run"></a>
## How often do they run?

Currently performance alerts run every 5 minutes assessing the previous 90 minute of data.

<a name="performance-how-do-i-onboard"></a>
## How do I onboard?

1.	Generate the desired per extension configuration

    - This can be done by either manually editing the performance JSON file or making use of [the tool][alerting-tool]  provided.

1.	Fill out the following work item [https://aka.ms/portalfx/alerting-onboarding][alerting-onboarding]
1.	Set up correlation rules in ICM


| Field | Value |
| -----  | ----- |
| Routing ID | For all others 'AIMS://AZUREPORTAL\Portal\\{ExtensionName}' |
| Correlation ID | Specific to alert, use table below to map |
| Mode | Hit count (recommended) |
| Match Slice | Checked |
| Match Severity | Checked |
| Match Role | Checked |
| Match Instance/Cluster | Checked |


| Alert | Correlation ID |
| ----- | -------------- |
| Performance - Extension | ExtensionLoadPerformance |
| Performance - Blade | BladeLoadPerformance |
| Performance - Part | PartLoadPerformance|

<a name="performance-what-should-i-set-the-thresholds-at"></a>
## What should I set the thresholds at?

There are two ways advised to decide how to set your thresholds.

1. Use the out of box baselines determined by the [tool][alerting-tool].
1. Run one of the kusto functions below to determine what would cause your alerts to fire.
    - [Extension][alerting-performance-extension-function]) 
    - [Blade][alerting-performance-blade-function]) 
    - [Part][alerting-performance-part-function]) 

<a name="performance-what-happens-if-i-need-to-update-them"></a>
## What happens if I need to update them?

1.	Contact [ibizafxhot](mailto:ibizafxhot@microsoft.com) and attached the updated configuration
1.	We will respond as soon as possible and apply the updates

<a name="performance-how-do-i-know-my-extension-s-current-configuration"></a>
## How do I know my extension&#39;s current configuration?

Within kusto your configuration will be defined under a function. To find the function use the this [link][alerting-kusto-partner] and replace `PerfBaseline_HubsExtension` with `PerfBaseline_YOUR_EXTENSION_NAME`. The function will only exist once you have onboarded to the alerting infrastructure. Or visit the tool to view a read only version of your config, again this is only available once you have onboarded.


[alerting-onboarding]: https://aka.ms/portalfx/alerting-onboarding
[alerting-tool]: https://microsoft.sharepoint.com/teams/azureteams/docs/PortalFx/Alert/AlertCustomizationTool.zip
[alerting-kusto-partner]: https://ailoganalyticsportal-privatecluster.cloudapp.net/clusters/azportal.kusto.windows.net/databases/Partner?q=H4sIAAAAAAAEAAtILUpzSixOzcnMS433KE0qdq0oSc0rzszP09BUAABSeYgPHQAAAA%3d%3d
[alerting-performance-extension-function]: https://aka.ms/kwe?cluster=azportal.kusto.windows.net&database=AzurePortal&q=H4sIAAAAAAAAA3NPLXGtKEnNK87Mz%2FPJT0wJSC1Kc8xJLSrxyCzRSEzP1zA0SdHUycsv19DUUfLNTC7KL85PK4l3rCotSo0PLskvSkxPVdJRCgjyd1HSsTTVMTc1MNAxNdAxNNBU4OUCANmD5aJeAAAA
[alerting-performance-blade-function]: https://aka.ms/kwe?cluster=azportal.kusto.windows.net&database=AzurePortal&q=H4sIAAAAAAAAAy3MsQrCMBAA0F3wJzIlcNAU2sExouhQsergWEJyraElB8kFxa8X1PEt74C8XazHjqzvMY1mwcTHwNJOJOvGK4j0lArE%2FsUYc6BYnYJLlGnkwbxLwuHGlOyE1fep%2FjLOUYm%2F%2Bx74cSnBzV2IcxYg%2But5J2DTQqO1hlpDq9arD7xzGJ6KAAAA
[alerting-performance-part-function]: https://aka.ms/kwe?cluster=azportal.kusto.windows.net&database=AzurePortal&q=H4sIAAAAAAAAA3NPLQlILCrxyU9MCUgtSnPMSS0q8cgs0UhMz9cwNEnR1MnLL9fQ1FFyrShJzSvOzM%2FT981MLsovzk8riXesKi1KjQ8uyS9KTE%2FVBxkTUlmQqg8VcExOzi%2FNA5uupKMUEOTvoqRjYaBjbmpgoGMIxKaavFwAuRiNBX4AAAA%3D