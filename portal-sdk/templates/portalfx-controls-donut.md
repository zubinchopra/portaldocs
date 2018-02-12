
## Donut chart

Donut charts are a great way to visualize proportional data.

![alt-text](../media/portalfx-ui-concepts/donut.png "Donut")

Donuts can be added to part templates with the following html:

```xml
<div data-bind='pcDonut: donutVM' style='height:500px; width:500px'></div>
```

The sample located at `<dir>\Client\V2\Controls\Donut\DonutBlade.ts` includes a donut blade.  

<!-- TODO:  Determine why the previous sample, ViewModels\DonutViewModels.ts, no longer exists in what is shipped with the SDK. Also  determine whether the previous xml is still relevant, or if there is a better sample.
-->

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. 
