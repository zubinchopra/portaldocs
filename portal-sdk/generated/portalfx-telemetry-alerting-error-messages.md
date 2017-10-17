<a name="client-error"></a>
# Client Error

There are two high level types of client error alerts, error percentage and error message. 
1. Error percentage alerts fire when the percentage of users experiencing any error(s) is above the defined threshold.
2. Error message alerts fire on specified error messages. These are broken down into two further types messageLogicalAnd and messageLogicalOr. 

<a name="client-error-configuration"></a>
## Configuration

At a high level you define:

1. An environment for the alerts to run against. See definition [below](#client-error-configuration-what-is-environment)
2. The error configuration for the alerts within that environment

```json
{
    ...
    "environments": [
        {
            "environment": "portal.azure.com", 
            "error": [
                {
                    "type": "affectedUserPercentage", 
                    "criteria": [
                        {
                            ...
                        },
                        ...
                    ]
                },
                {
                    "type": "messageLogicalAnd", 
                    "criteria": [
                        {
                            ...
                        },
                        ...
                    ]
                },
                {
                    "type": "messageLogicalOr", 
                    "criteria": [
                        {
                            ...
                        },
                        ...
                    ]
                },
                ...
             ]
        },
        {
            "environment": "ms.portal.azure.com",
            "error": [
                {
                    ...
                },
                ...
             ],
            ...
        }
    ]
    ...
}
```

Among "affectedUserPercentage", "messageLogicalAnd" and "messageLogicalOr" types, you can choose to have one type, two types or all three types. Per each of those, you can define a set of criteria like the below.

<a name="client-error-configuration-what-is-environment"></a>
### What is environment?

Environment can be "&ast;" or "portal.azure.com" or "ms.portal.azure.com" or "canary.portal.azure.com" or any other legit portal domain name. "&ast;" represents all Azure Portal Production environments(*.portal.azure.com).

<a name="client-error-configuration-what-is-error-configuration"></a>
### What is error configuration?

Error configuration is an array of criteria to run against that environment and safe deployment stage. See definition [below](#client-error-configuration-what-is-safe-deployment-stage).

<a name="client-error-configuration-what-is-safe-deployment-stage"></a>
### What is safe deployment stage?
Safe deployment stage can be 0, 1, 2, 3, or 4. If you don't specify the safe deployment stage property in critera, it's alerting on all safe deployment stages. See below for further examples.

<a name="client-error-configuration-affecteduserpercentage"></a>
### AffectedUserPercentage

An example of an affectedUserPercentage error alert criteria

```json
[
    {
        "type": "affectedUserPercentage",
        "criteria":[
            {
                "minAffectedUserPercentage": 33.33,
                "minAffectedUserCount": 2,
                "safeDeploymentStage": 0,
                "severity": 3,
                "enabled": true
            }
            ...
        ]
    },
   ...
]
```

<a name="client-error-configuration-messagelogicaland"></a>
### MessageLogicalAnd

An example of a 'logical and' message error alert criteria.

> You can specify up to 5 messages in one criteria.

```json
[
    {
        "type": "messageLogicalAnd",
        "criteria":[
            {
                "message1": "Cannot read property",
                "message2": "of null",
                "minAffectedUserCount": 38,
                "severity": 4,
                "enabled": true
            }
            ...
        ]
    },
   ...
]
```

<a name="client-error-configuration-messagelogicalor"></a>
### MessageLogicalOr

An example of a 'logical or' message error alert criteria

> You can specify up to 5 messages in one criteria.

```json
[
    {
        "type": "messageLogicalOr",
        "criteria":[
            {
                "message1": "Cannot read property",
                "message2": "of null",
                "minAffectedUserCount": 58,
                "severity": 4,
                "enabled": true
            }
            ...
        ]
    },
   ...
]
```

<a name="client-error-configuration-what-is-minaffecteduserpercentage"></a>
### What is minAffectedUserPercentage?

This is the minimum number of percentage of users affected by any client error.

<a name="client-error-configuration-what-is-minaffectedusercount"></a>
### What is minAffectedUserCount?

This is the minimum number of users affected by any client error.

<a name="client-error-how-often-do-they-run"></a>
## How often do they run?

Currently error alerts run every 30 minutes assessing the previous 90 minute of data.

<a name="client-error-how-do-i-onboard"></a>
## How do I onboard?

1.	Generate the desired per extension configuration

    - This can be done by manually editing the error JSON file.

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
| Error - AffectedUserPercentage | ErrorAffectedUserPercentage |
| Error - Message | ErrorMessage |

<a name="client-error-what-happens-if-i-need-to-update-alert-configuration"></a>
## What happens if I need to update alert configuration?

1.	Contact [ibizafxhot](mailto:ibizafxhot@microsoft.com) and attached the updated configuration
1.	We will respond as soon as possible and apply the updates

<a name="client-error-how-do-i-know-my-extension-s-current-configuration"></a>
## How do I know my extension&#39;s current configuration?

Within Kusto your configuration will be defined under a function. To find the function use the this [link][alerting-kusto-partner] and replace `ErrorAlert_Ibiza_Framework` with `ErrorAlert_YOUR_EXTENSION_NAME`. The function will only exist once you have onboarded to the alerting infrastructure.


[alerting-onboarding]: https://aka.ms/portalfx/alerting-onboarding
[alerting-kusto-partner]: https://Azportal.kusto.windows.net/Partner?query=ErrorAlert_Ibiza_Framework()&web=1