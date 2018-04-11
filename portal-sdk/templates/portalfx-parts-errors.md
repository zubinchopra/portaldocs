
### Handling part errors

Occasionally while loading parts, an extension may encounter some sort of unrecoverable error. In that case, the part may placed into a failure state, as in the following image.

![alt-text](../media/portalfx-debugging/failure.png "Failed part")

Parts should only be placed into a failed state if there was a system fault and no action can be taken by the user to correct the error. If the user can correct the error, then display guidance about how to do so. An example is located at `<dir>\Client\V1\Parts\Lifecycle\ViewModels\PartLifecycleViewModels.ts`, and in the following code.

```ts
constructor(container: MsPortalFx.ViewModels.PartContainer, initialState: any, dataContext: DataContext) {
    container.fail(SamplesExtension.Resources.Strings.failedToLoad);
}
```

If the error is  fixed, for example, if you are polling for data, and a subsequent poll returns valid results, then the extension can call `container.recover()` to return the part to its normal display state.
