## Monitor Chart V2
The Monitor Chart V2 control is the newer version of [MonitorChart Control](portalfx-controls-monitor-chart.md). This allows you to plot the multi-dimensional metrics for your resource in Azure with support for dimension based grouping and filters . It is part of the Ibiza framework, and it inherently knows how to fetch data for your resource.

### Benefits
- **Performance** - The charts are built to render quickly and make efficient network calls for data
- **Multi-dimensional support** - The charts support grouping and filtering on the dimensions from your multi-dimensional metric data.

### Pre-requisites: Onboard to Monitor config
If you are onboarding to Azure Monitor for the first time, please reach out to the [Monitoring team](mailto:monitoringcontrib@microsoft.com).

The Monitoring team will add your resource type to a config which allows the Monitor Control to know how to fetch metrics for your resources.


### Using the control
```typescript
import * as MonitorChartV2 from "Fx/Controls/MonitorChartV2";

...

// Create the MonitorChart options
const chartInputs: MonitorChartV2.Options = {
            metrics: [
                {
                    resourceMetadata: {
                        id: "subscription/resource/id"
                    },
                    name: "exceptions/count",
                    aggregationType: MonitorChartV2.Metric.AggregationType.Sum
                }
            ]
};

const const timespan: MonitorChartV2.Timespan = {
    relative: {
        /* One day in Milliseconds */
        duration: 1 * 24 * 60 * 60 * 1000
    }
};

// Create the MonitorChart viewmodel
const monitorChartViewModel =MonitorChartV2.create(bladeOrPartContainer, monitorChartOptions);
```

> You can plot more than one metric on the chart referencing the control. Also you can specify the dimensions to segment the data by and set of filters to filter the data.

> To see a complete list of the options you can pass to the control, look at the `Fx/Controls/MonitorChartV2` module in Fx.d.ts, or you can [view the interfaces directly in the PortalFx repo][4].

### Try it out in samples extension
You can try out the monitor chart v2 control in the [Samples Extension][1], or view the code directly in the Samples Extension at:

`\Client\V2\Preview\MonitorChartV2\MonitorChartV2Blade.ts`

The sample has a static chart from dummy app on top and a configurable chart below it with various options. You can add a single or multiple metrics to the chart, Add a threshold on the first metric and adjust its value, add grouping/segmentation to the chart on selected dimensions and add filters to the chart.

![Metrics chart control single input][2]

### End-to-end flow for users

#### Overview blade
Once you reference the monitor chart control in your overview blade, it will look similar to the following screenshot:

![Monitor chart control overview blade][3]

<!-- References -->
[1]: https://df.onecloud.azure-test.net/#blade/SamplesExtension/SDKMenuBlade/monitorchartv2
[2]: ../media/portalfx-controls-monitor-chart-v2/monitor-chart-v2-control-sample.png
[3]: ../media/portalfx-controls-monitor-chart-v2/monitor-chart-v2-control-overview-blade.png
[4]: https://msazure.visualstudio.com/DefaultCollection/One/_git/AzureUX-PortalFX?path=%2Fsrc%2FSDK%2FFramework.Client%2FTypeScript%2FFx%2FControls%2FMonitorChartV2.ts&version=GBproduction&_a=contents
