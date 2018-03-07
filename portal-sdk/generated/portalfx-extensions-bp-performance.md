
<a name="best-practices"></a>
## Best Practices

There are a few patterns that assist in improving browser and Portal performance.

<a name="best-practices-use-amd"></a>
### Use AMD

Azure supports [Asynchronous Module Definition (AMD)](http://requirejs.org/docs/whyamd.html), which is an improvement over bundling scripts into a single file at
compilation time. Now, the Portal downloads only the files needed to display the current UI onto the screen. This makes it faster to unload and reload an extension, and provides for generally better performance in the browser.  

* Old code

The previous coding pattern was relevant for extensions that imported modules using `<reference>` elements. These statements bundlef all scripts into a single file at compilation time, leading to a relatively large file that was downloaded whenever the extension displayed a UI.  The deprecated code is in the following example.

```ts

/// <reference path="../TypeReferences.d.ts" />
/// <reference path="WebsiteSelection.ts" />
/// <reference path="../Models/Website.ts" />
/// <reference path="../DataContexts/DataContexts.ts" />

module RemoteExtension {
    export class WebsitesBladeViewModel extends MsPortalFx.ViewModels.Blade {
    ...
    }
}

```

* New code

By using AMD, the following files are loaded only as required, instead of one large bundle. This results in increased load time, and decreased memory consumption in the browser. The improved code is in the following example.

```ts

import SecurityArea = require("../SecurityArea");
import ClientResources = require("ClientResources");
import Svg = require("../../_generated/Svg");

export class BladeViewModel extends MsPortalFx.ViewModels.Blade {
    ...
}

```

For more information about the TypeScript module loading
system, see the official language specification located at [http://www.typescriptlang.org/docs/handbook/modules.html](http://www.typescriptlang.org/docs/handbook/modules.html).

<a name="best-practices-use-paging-for-large-data-sets"></a>
### Use paging for large data sets

When working with large data sets, developers should use grids and their paging features.
Paging allows deferred loading of rows, so even with large datasets, responsiveness is maintained.

Paging implies that many rows might not need to be loaded at all. For more information about paging with grids, see [portalfx-control-grid.md](portalfx-controls-grid.md)  and the sample located at `<dir>\Client\V1\Controls\Grid\ViewModels\PageableGridViewModel.ts`.

<a name="best-practices-use-paging-for-large-data-sets-use-map-and-filter-to-reduce-size-of-rendered-data"></a>
#### Use &quot;map&quot; and &quot;filter&quot; to reduce size of rendered data

Often, it is useful to use the [Knockout projections](https://github.com/stevesanderson/knockout-projections) to shape and filter model data loaded using QueryView and EntityView (see [Shaping and filtering data](portalfx-data-projections.md)).

Significant performance improvements can achieved by reducing the number and size of the model objects bound to controls like grids, lists, charts:

    `\Client\Controls\Grid\ViewModels\SelectableGridViewModel.ts`

```ts

// Wire up the contents of the grid to the data view.
this._view = dataContext.personData.peopleQuery.createView(container);
var projectedItems = this._view.items
    .filter((person: SamplesExtension.DataModels.Person) => { return person.smartPhone() === "Lumia 520"; })
    .map((person: SamplesExtension.DataModels.Person) => {
        return <MappedPerson>{
            name: person.name,
            ssnId: person.ssnId
        };
    });

var personItems = ko.observableArray<MappedPerson>([]);
container.registerForDispose(projectedItems.subscribe(personItems));


```

In this example, `map` is used to project new model objects containing only those properties required to fill the columns of the grid.  Additionally, `filter` is used to reduce the size of the array to just those items that will be rendered as grid rows.

<a name="best-practices-use-paging-for-large-data-sets-benefits-to-ui-rendering-performance"></a>
#### Benefits to UI-rendering performance

Using the selectable grid SDK sample we can see the benefits to using `map` to project objects with only those properties required by a grid row:

![Using knockout projections to map an array][mapping]
[mapping]: ../media/portalfx-performance/mapping.png

There is almost a 50% reduction in time with these optimizations, but also note that at 300 items it is still over 1.5s. Mapping to just the 2 columns in that selectable grid sample reduces the message size by 2/3 by using the technique described above. This reduces the time needed to transfer the view model as well as reducing memory usage.

