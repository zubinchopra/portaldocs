
<a name="best-practices"></a>
## Best Practices

Portal development patterns or architectures that are recommended based on customer feedback and usability studies may be categorized by the type of part.

<a name="best-practices-loading-indicators"></a>
#### Loading indicators

Loading indicators should be consistently applied across all blades and parts of the extension. For no-PDL, this is demonstrated in the sample located at  [https://df.onecloud.azure-test.net/#blade/SamplesExtension/TemplateBladeWithSettings](https://df.onecloud.azure-test.net/#blade/SamplesExtension/TemplateBladeWithSettings).  The steps for TypeScript and PDL are as follows.

* Call `container.revealContent()` to limit the time when the part displays  **blocking loading** indicators. For more information, see [portalfx-parts-revealContent.md](portalfx-parts-revealContent.md).

* Return a `Promise` from the `onInitialize` method that reflects all data-loading for the part. Return the `Promise` from the blade if it is locked or is of type  `<TemplateBlade>`.

* The extension can return a data-loading Promise directly from `onInitialize`, but it will receive compile errors when it attempts to return the result of a call to `queryView.fetch(...)`, `entityView.fetch(...)`, `Base.Net.ajax2(...)`, as in the following code.

    ```
    public onInitialize() {
        public { container, model, parameters } = this.context;
        public view = model.websites.createView(container);

        // Returns MsPortalFx.Base.PromiseV and not the required Q.Promise<any>.
        return view.fetch(parameters.websiteId).then(...);
    }
    ```

    The FX data-loading APIs return a `MsPortalFx.Base.PromiseV` type that is not compatible with the `Q.Promise` type expected for `onInitialize`.  To workaround this shortcoming of the FX data-loading APIs, use the following code until these APIs are revised. 
    ```
        ...
        return Q(view.fetch(...)).then(...);
        ...
    ```

    This application of `Q(...)`  coerces the data-loading Promise into the return type expected for `onInitialize`.  

* For PDL, do not return a `Promise` from the `onInputSet` method previous to the loading of all part data if it removes loading indicators.   The part will seem to be broken or unresponsive if no **loading** indicator is displayed while the data is loading, as in the following code.

```ts
public onInputsSet(inputs: MyPartInputs): Promise {
    this._view.fetch(inputs.resourceId);
    
    // DO NOT DO THIS!  Removes all loading indicators.
    // Your Part will look broken while the `fetch` above completes.
    return Q();
}
```

**NOTE**: In this discussion, `onInputsSet` is the PDL equivalent of `onInitialize` 

<a name="best-practices-handling-part-errors"></a>
### Handling part errors

The sad cloud UX is displayed when there is no meaningful error to display to the user. Typically this occurs when the error is unexpected and the only option the user has is to try again.

If an error occurs that the user can do something about, then the extension should launch the UX that allows them to correct the issue. Extension developers and domain owners are aware of  how to handle many types of errors.

For example, if the error is caused because the user credentials are not known to the extension, then it is best practice to use one of the following options instead of failing the part.

1. The part can handle the error and change its content to show the credentials input form

1. The part can handle the error and show a message that says ‘click here to enter credentials’. Clicking the part would launch a blade with the credentials form.

 