<properties title="" pageTitle="Graph Control nuget" description="" authors="rickweb" />

<a name="graph"></a>
## Graph

Applications that need a stand-alone graph control can use the `Microsoft.Portal.Controls.Graph` package. This package is published on **MSNuget** and should not be shared externally. It contains all the **Javascript** and **CSS** files needed to render the control, in addition to the definitions needed to use it in **Typescript**.

<!--TODO: Determine whether the above paragraph includes the Viva.Controls directory -->

<a name="graph-requirements"></a>
### Requirements

The web page must statically include the following scripts previous to the `data-main` paragraph.

1. **jquery**
1. **knockout.js** version 3.2.0
1. **Q** version 1
1. **hammerjs**

**NOTE**: **hammerjs** version 1.1.3 has been tested. If **hammer** is not included, the extension will not get multi-touch, but everything else should work correctly.

The **requirejs** is used to load the graph control, with the program entry that is specified in `data-main`. There are three modules that should be explicitly brought in as dependencies. 

<!-- TODO: Determine whether there is a sample for this. -->

* `Viva.Controls/Controls/Visualization/Graph/GraphWidget` 

    Contains the widget

*` Viva.Controls/Controls/Visualization/Graph/GraphViewModel`

    Contains the ViewModel that supports the widget

* `Viva.Controls/Controls/Visualization/Graph/GraphEntityViewModel` 

    Defines graph node and edges classes

A module that uses the control is in the following example.

```ts
import Widget = require("./Viva.Controls/Controls/Visualization/Graph/GraphWidget");
import ViewModel = require("./Viva.Controls/Controls/Visualization/Graph/GraphViewModel");
import Entities = require("./Viva.Controls/Controls/Visualization/Graph/GraphEntityViewModel");

export = Main;

module Main {
    var viewModel = new ViewModel.ViewModel();
    var widget = new Widget.Widget($("#container"), viewModel);

    viewModel.editorCapabilities(ViewModel.GraphEditorCapabilities.MoveEntities);

    // Add graph nodes.
    for (var i = 0; i < 6; i++) {
        var graphNode = new Entities.GraphNode({
            x: (i % 3) * 100,
            y: Math.floor(i / 3) * 100,
            height: 40,
            width: 40
        });

        graphNode.id(i.toString());
        graphNode.extensionTemplate = "<div data-bind='text:$data,azcGraphNodeContent'></div>";
        graphNode.extensionViewModel = i.toString();

        viewModel.graphNodes.put(i.toString(), graphNode);
    }

    // Add graph edges
    for (var i = 1; i < 6; i++) {
        var start = viewModel.graphNodes.lookup((i - 1).toString());
        var end = viewModel.graphNodes.lookup(i.toString());

        viewModel.edges.put((i - 1).toString() + "-" + i.toString(), new Entities.GraphEdge(start, end));
    }
}

```
