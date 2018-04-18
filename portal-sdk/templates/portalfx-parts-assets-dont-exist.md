
## Handling assets that no longer exist

Many parts represent assets like ARM resources that can be deleted from the UI, PowerShell, or the calling REST APIs.  A stateless UI system handles this deletion by loading only assets that exist at the time the UI starts up.  Because Ibiza contains the state for all user customizations, this 'Not Found' case is handled in a few specific places. Some examples are as follows.

* A VM part that was pinned to the startboard represents an asset that no longer exists

* The CPU chart for a VM part that was pinned to the startboard depends on information provided by an asset that no longer exists

### Automatic HTTP 404 handling

The Portal's built-in data layer automatically detects HTTP 404 responses from **AJAX** calls, in order to cover the most common scenarios.  When a part depends on data and a 404 has been detected, Ibiza automatically makes the part non-interactive and displays a message of 'Not Found'.  The effect is that in most "not found" scenarios, extensions will display the more accurate 'Not found' message instead of the sad cloud UX that is reserved for unexpected errors.

This distinction allows the Portal telemetry system to differentiate between bugs and deleted assets when parts  fail to render.

Extensions should allow the Portal to handle 404 responses by default. However, there are exceptions where this behavior may not be the best action.  In those cases, the extension can opt out of automatic 404 handling by setting the `showNotFoundErrors` flag to `false` when creating the extension's `dataViews`. The following code makes 404s result in rejected promises, which allows individual extensions to apply special handling.

```js
this._dataView = dataContext.createView(container, { interceptNotFound: false });
```

**NOTE**: Instances of 'Not Found' do not count against a part's reliability KPI.