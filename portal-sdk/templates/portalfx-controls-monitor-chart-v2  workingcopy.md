## Monitor Chart V2
The Monitor Chart V2 control is the newer version of [MonitorChart Control](portalfx-controls-monitor-chart.md). This allows you to plot the multi-dimensional metrics for your resource in Azure with support for dimension based grouping and filters .
 It is part of the Ibiza framework, and it inherently knows how to fetch data for your resource.

### Benefits


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
