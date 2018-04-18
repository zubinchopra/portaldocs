
### Handling part errors

Occasionally while loading parts, an extension may encounter an unrecoverable error. In that case, the part may be placed into a failure state, as in the following image.

![alt-text](../media/portalfx-debugging/failure.png "Failed part")

Parts should only be placed into a failed state if there was a system fault and no action can be taken by the user to correct the error. If the user can correct the error, then the extension should display guidance about the error, as in the  example located at `<dir>\Client\V1\Parts\Lifecycle\ViewModels\PartLifecycleViewModels.ts`, and in the following code.

```ts
constructor(container: MsPortalFx.ViewModels.PartContainer, initialState: any, dataContext: DataContext) {
    container.fail(SamplesExtension.Resources.Strings.failedToLoad);
}
```

When the error is  fixed,  then the extension can call `container.recover()` to return the part to its normal display state. One example is that the extension is polling for data, and the first poll does not retrieve results, but a subsequent poll returns valid results.
