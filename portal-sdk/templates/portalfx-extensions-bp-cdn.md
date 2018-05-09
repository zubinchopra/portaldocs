
## Best Practices

### Resource menu item

Please use `cdnIntegration` for the resource menu item id. This id is used  to track blade loads and create telemetry on the CDN Integration Blade.

### Localizing text 

 The displayText named "Azure CDN" should  be localized and located in the  `Resources.resx` file of the extension.

### Conditional setting of Integraion 

 To display this blade, set the `visible` property on the `cdnIntegration` menu item to `true`.  Also, the extension can conditionally display this blade based on a feature flag  in the extension, as in the following example.

	```ts
	visible: ko.observable(MsPortalFx.isFeatureEnabled("cdnintegration"))
	```
