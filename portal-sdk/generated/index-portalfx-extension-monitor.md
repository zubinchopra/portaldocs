* [Telemetry](#telemetry)
    * [Alerting](#telemetry-alerting)
    * [Performance](#telemetry-performance)
    * [Reliability](#telemetry-reliability)
    * [Create](#telemetry-create)


<a name="telemetry"></a>
# Telemetry
* [Getting Started](portalfx-telemetry-getting-started.md#getting-started)

* [Kusto Telemetry](portalfx-telemetry-kusto-databases.md#kusto-telemetry)

* [Portal Telemetry Overview](portalfx-telemetry.md#portal-telemetry-overview)
    * [Logging](portalfx-telemetry.md#logging)
    * [Available Power BI Dashboards](portalfx-telemetry.md#available-power-bi-dashboards)
    * [Collecting Feedback From Your Users](portalfx-telemetry.md#collecting-feedback-from-your-users)

* [How to verify live Telemetry](portalfx-telemetry-live-telemetry.md#how-to-verify-live-telemetry)
    * [Using Console Logs](portalfx-telemetry-live-telemetry.md#using-console-logs)
    * [Using Fiddler](portalfx-telemetry-live-telemetry.md#using-fiddler)


<a name="telemetry-alerting"></a>
## Alerting
* [Overview](portalfx-telemetry-alerting-overview.md#overview)
    * [What are the alerts?](portalfx-telemetry-alerting-overview.md#what-are-the-alerts)
    * [What is configurable?](portalfx-telemetry-alerting-overview.md#what-is-configurable)

* [Availability](portalfx-telemetry-alerting-availability.md#availability)
    * [Configuration](portalfx-telemetry-alerting-availability.md#configuration)
    * [How often do they run?](portalfx-telemetry-alerting-availability.md#how-often-do-they-run)
    * [How do I onboard?](portalfx-telemetry-alerting-availability.md#how-do-i-onboard)
    * [What happens if I need to update them?](portalfx-telemetry-alerting-availability.md#what-happens-if-i-need-to-update-them)
    * [How do I know my extension's current configuration?](portalfx-telemetry-alerting-availability.md#how-do-i-know-my-extension-s-current-configuration)

* [Performance](portalfx-telemetry-alerting-performance.md#performance)
    * [Configuration](portalfx-telemetry-alerting-performance.md#configuration)
    * [How often do they run?](portalfx-telemetry-alerting-performance.md#how-often-do-they-run)
    * [How do I onboard?](portalfx-telemetry-alerting-performance.md#how-do-i-onboard)
    * [How do I use [the tool][alerting-tool]?](portalfx-telemetry-alerting-performance.md#how-do-i-use-the-tool-alerting-tool)
    * [What should I set the thresholds at?](portalfx-telemetry-alerting-performance.md#what-should-i-set-the-thresholds-at)
    * [What happens if I need to update them?](portalfx-telemetry-alerting-performance.md#what-happens-if-i-need-to-update-them)
    * [How do I know my extension's current configuration?](portalfx-telemetry-alerting-performance.md#how-do-i-know-my-extension-s-current-configuration)

* [Client Error](portalfx-telemetry-alerting-error-messages.md#client-error)
    * [Configuration](portalfx-telemetry-alerting-error-messages.md#configuration)
    * [How often do they run?](portalfx-telemetry-alerting-error-messages.md#how-often-do-they-run)
    * [How do I onboard?](portalfx-telemetry-alerting-error-messages.md#how-do-i-onboard)
    * [What happens if I need to update alert configuration?](portalfx-telemetry-alerting-error-messages.md#what-happens-if-i-need-to-update-alert-configuration)
    * [How do I know my extension's current configuration?](portalfx-telemetry-alerting-error-messages.md#how-do-i-know-my-extension-s-current-configuration)

* [Fequently asked questions](portalfx-telemetry-alerting-faq.md#fequently-asked-questions)
    * [How do I onboard?](portalfx-telemetry-alerting-faq.md#how-do-i-onboard)
    * [How do I generated the required configuration?](portalfx-telemetry-alerting-faq.md#how-do-i-generated-the-required-configuration)
    * [How do I know my extension's current configuration?](portalfx-telemetry-alerting-faq.md#how-do-i-know-my-extension-s-current-configuration)
    * [What happens if I need to update my configuration?](portalfx-telemetry-alerting-faq.md#what-happens-if-i-need-to-update-my-configuration)


<a name="telemetry-performance"></a>
## Performance
* [Overview](portalfx-performance.md#overview)
    * [Extension performance](portalfx-performance.md#extension-performance)
    * [Blade performance](portalfx-performance.md#blade-performance)
    * [Part performance](portalfx-performance.md#part-performance)
    * [WxP score](portalfx-performance.md#wxp-score)
    * [How to assess your performance](portalfx-performance.md#how-to-assess-your-performance)
* [Performance Frequently Asked Questions (FAQ)](portalfx-performance.md#performance-frequently-asked-questions-faq)
    * [My Blade 'Revealed' is above the bar, what should I do](portalfx-performance.md#my-blade-revealed-is-above-the-bar-what-should-i-do)
    * [My Part 'Revealed' is above the bar, what should I do](portalfx-performance.md#my-part-revealed-is-above-the-bar-what-should-i-do)
    * [My WxP score is below the bar, what should I do](portalfx-performance.md#my-wxp-score-is-below-the-bar-what-should-i-do)
* [Performance best practices](portalfx-performance.md#performance-best-practices)
    * [Configuring CDN](portalfx-performance.md#configuring-cdn)
    * [Extension HomePage Caching](portalfx-performance.md#extension-homepage-caching)
    * [Persistent Caching of scripts across extension updates](portalfx-performance.md#persistent-caching-of-scripts-across-extension-updates)
    * [Run portalcop to identify and resolve common performance issues](portalfx-performance.md#run-portalcop-to-identify-and-resolve-common-performance-issues)
    * [Optimize number CORS preflight requests to ARM using invokeApi](portalfx-performance.md#optimize-number-cors-preflight-requests-to-arm-using-invokeapi)
    * [Improve part responsiveness with revealContent](portalfx-performance.md#improve-part-responsiveness-with-revealcontent)


<a name="telemetry-reliability"></a>
## Reliability
* [Overview](portalfx-reliability.md#overview)
    * [Extension reliability](portalfx-reliability.md#extension-reliability)
    * [Blade reliability](portalfx-reliability.md#blade-reliability)
    * [Part reliability](portalfx-reliability.md#part-reliability)
    * [Assessing extension reliability](portalfx-reliability.md#assessing-extension-reliability)
    * [Checklist](portalfx-reliability.md#checklist)
* [Reliability Frequently Asked Questions (FAQ)](portalfx-reliability.md#reliability-frequently-asked-questions-faq)
    * [My Extension is below the reliability bar, what should I do](portalfx-reliability.md#my-extension-is-below-the-reliability-bar-what-should-i-do)
    * [My Blade is below the reliability bar, what should I do](portalfx-reliability.md#my-blade-is-below-the-reliability-bar-what-should-i-do)
    * [My Part is below the reliability bar, what should I do](portalfx-reliability.md#my-part-is-below-the-reliability-bar-what-should-i-do)

* [How to analyze client errors](portalfx-telemetry-extension-errors.md#how-to-analyze-client-errors)


<a name="telemetry-create"></a>
## Create
* [Create Telemetry](portalfx-telemetry-create.md#create-telemetry)
    * [Create Flow Telemetry Dashboards](portalfx-telemetry-create.md#create-flow-telemetry-dashboards)
    * [Create Flow table](portalfx-telemetry-create.md#create-flow-table)
    * [Create Flow Functions](portalfx-telemetry-create.md#create-flow-functions)

* [Create Troubleshooting](portalfx-create-troubleshooting.md#create-troubleshooting)
    * [Overview](portalfx-create-troubleshooting.md#overview)
    * [Types of Create Failures](portalfx-create-troubleshooting.md#types-of-create-failures)
    * [Debugging Alerts](portalfx-create-troubleshooting.md#debugging-alerts)
