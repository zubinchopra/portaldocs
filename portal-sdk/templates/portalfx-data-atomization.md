
## Data atomization

Atomization fulfills two main goals: 

1. It enables several data views to be bound to one data entity, thus presenting a smooth and  consistent experience to the user.  In this instance, two views that represent the same asset are always in sync. 
1. It minimizes memory trace.

Atomization can be switched only for entities, which have globally unique IDs (per type) in  the  metadata system. In this case, a third attribute can be added to its `TypeMetadataModel` attribute in C#, as in the following example.

```cs

[TypeMetadataModel(typeof(Robot), "SamplesExtension.DataModels", true /* Safe to unify entity as Robot IDs are globally unique. */)]

```

The Atomization attribute is set to "off" by default. The Atomization attribute is not inherited and has to be set to `true` for all types that should be atomized. 
In the simpliest case, all entities within an extension will use the same atomization context, which defaults to one.
In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>`  is the `SamplesExtension\` directory. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

It is possible to select a different atomization context for a given entity cache/query cache, as in the following example.

```cs

var cache = new MsPortalFx.Data.QueryCache<ModelType, QueryType>({
    ...
    atomizationOptions: {
        atomizationContextId: "string-id"
    }
    ...
});

```
