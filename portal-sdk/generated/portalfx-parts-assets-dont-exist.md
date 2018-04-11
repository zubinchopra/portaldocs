
<a name="handling-assets-that-no-longer-exist"></a>
### Handling assets that no longer exist

Many parts represent assets such as ARM resources that can be deleted from the UI, PowerShell, or calling REST APIs directly.  A stateless UI system would handle this by loading only assets that exist at the time the UI starts up.  Since Ibiza holds the state for all user customizations, this 'Not Found' case needs to be handled in a few specific places. 

* A part that has been pinned to the startboard represents an asset that no longer exists
  * Example: The VM part
* A part that has been pinned to the startboard depends on information provided by an asset that no longer exists
  * Example: The CPU chart for a VM part

<a name="handling-assets-that-no-longer-exist-automatic-http-404-handling"></a>
#### Automatic HTTP 404 handling

In an attempt to cover the most common scenarios, the Portal's built-in data layer automatically detects HTTP 404 responses from **AJAX** calls.  When a part depends on data and a 404 has been detected, Ibiza automatically makes the part non-interactive and displays a message of 'Not Found'.

The effect is that in most "not found" scenarios, most extensions will display the more accurate 'Not found' message instead of the sad cloud UX that is reserved for  unexpected errors.

This distinction also allows the Portal telemetry system differentiate between a part that fails to render because of bugs and a part that fails to render because the user's asset has been deleted.

**NOTE**: Instances of 'Not Found' do not count against a part's reliability KPI.

<a name="handling-assets-that-no-longer-exist-how-to-opt-out-of-automatic-http-404-handling"></a>
#### How to opt out of automatic HTTP 404 handling

We strongly encourage teams to develop extensions that allow the Portal to  handle 404 responses by default. However, there may be some valid exceptions where this standard behavior may not be the best action an extensinon can perform.  In those very rare cases you can opt out of automatic 404 handling by setting the `showNotFoundErrors` flag to `false` when creating the extension's `dataViews`, as in the following example.

```js
this._dataView = dataContext.createView(container, { interceptNotFound: false });
```

The preceding code makes 404s result in rejected promises, and individual extensions apply special handling of 404 responses.
