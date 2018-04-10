# Pinning parts

By default, all blades and parts are 'pinnable'.  Pinning a part creates a copy of that part on the [dashboard](portalfx-ui-concepts.md#ui-concepts-the-dashboard).  The part on the dashboard provides a shortcut for users, allowing them to get their most used blades.

![Dashboard][dashboard]

All parts are pinnable by default, at no (or little) cost to the developer.  Part settings are copied over to the new part, and the current size is maintained.  The part can be independently configured, resized, or moved around on the dashboard.  It is a complete copy of the original part.


## How pinned parts work

When a part is pinned (or moved to another blade), a new view model for that part is created.  This view model will have the same exact contract.  The inputs to the part are stored in the portal's cloud settings, and replayed onto the part when the dashboard loads.  For example, the robots part in this sample takes a single input named `id`, which comes from the blade.  When the part is pinned to the dashboard, the blade will obviously not be available - so the `id` of the part is stored in persistent storage:

`\SamplesExtension\Extension\Client\Hubs\Browse\Browse.pdl`

```xml
<CustomPart Name="RobotSummary"
            ViewModel="{ViewModel Name=RobotSummaryViewModel, Module=./Browse/ViewModels/RobotSummaryViewModel}"
            Template="{Html Source='Templates\\Robot.html'}"
            InitialSize="FullWidthFitHeight"
            AssetType="Robot"
            AssetIdProperty="name">
  <CustomPart.Properties>
    <Property Name="name"
              Source="{BladeParameter Name=id}" />
  </CustomPart.Properties>
</CustomPart>
```

Given this constraint, it's very important to __not pass model data in bindings__.  Only keys and ids which are used to load data from a back end should be passed around as bindings.  If data about the robot changes (such as the name), those changes should be reflected in the part.  This provides the 'live tile' feel of the portal, and ensures the data in the part is not stale.

> [WACOM.NOTE] To learn more about keys and data loading in the portal, read [working with data](top-extensions-data.md).


## Preventing pinning

In some cases, a part should not be pinnable.  This generally occurs when:

* The part is showing an editable form
* The part is expensive (performance wise) to run persistently
* The part should not be displayed in a constrained UX
* The part has no value when pinned

Parts are not individually flagged as not being pinnable.  Rather, a blade that contains those parts is `locked`:

`\SamplesExtension\Extension\Client\extension.pdl`

```xml
<Blade Name="SamplesBlade"
       ViewModel="SamplesBladeViewModel"
       Pinnable="True"
       Locked="True">
```

In the simple example above, all parts in the `SamplesBlade` will not provide the ability to be pinned.  However - the blade itself can still be pinned.  To learn more, check out [pinning blades](portalfx-blades-pinning.md).

Next steps: Learn about [sharing parts](portalfx-extensibility-pde.md).

[dashboard]: ../media/portalfx-ui-concepts/dashboard.png
