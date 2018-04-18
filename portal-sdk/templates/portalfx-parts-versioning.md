
## Versioning

When users customize or pin a part, the following states are stored and used the next time the part is loaded from a customized context.

1. Basic part metadata, like part name or extension name
1. Part inputs, like resource id
1. Part settings, like time range for a chart

Because these states are stored, these parts need to be backwards-compatible.

Supporting new functionality may require the modification of the schema of a part's inputs and settings. 

The Azure Portal always calls the most recent edition of an extension, which is specified in the extensions configuration file. However, older versions of inputs and settings that were stored by earlier editions of an extension may still exist, and they may be incompatible with the most recent edition of the extension. Consequently, users may experience unexpected results when the extension or part is called with previous settings.

Likewise, other extensions may have taken dependencies on less-recent editions of the extension or part. For example, another extension may use a .pde file that contains a `<PartReference/>`.  Those other extensions may also experience unexpected results when they call the extension or part with previous inputs.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. If there is a working copy of the sample in the Dogfood environment, it is also included.

This example is based on the sample located at `<dir>\Client\V1\Hubs\Browse\Browse.pdl`. It builds on the ViewModel located at `<dir>\Client\V1\Hubs\Browse\ViewModels\RobotPartViewmodel.ts`.

 The **CanUseOldInputVersion** attribute can be set to `true` to specify that the part can process older versions of inputs. It should be used in conjunction with the  part property named `version`, as in the following example.

<!-- TODO:  Determine whether the following sample is causing GitHub to stop the build. -->
     gitdown": "include-section", "file": "../Samples/SamplesExtension/Extension/Client/V1/Hubs/Browse/Browse.pdl"}

```xml
<Part Name="RobotPart"
      ViewModel="{ViewModel Name=RobotPartViewModel, Module=./Browse/ViewModels/RobotPartViewModel}"
      CanUseOldInputVersions="true"
      PartKind="Button"
      AssetType="Robot"
      AssetIdProperty="name">
    <Part.Properties>
        <Property Name="version"
                  Source="{Constant 2}" />
        <Property Name="name"
                  Source="{DataInput Property=id}" />
    </Part.Properties>
</Part>
```

**NOTE**: Inline parts can specify the current version as a constant.  Although this is the first explicit version, we recommend using  a value of `2` the first time it is used.

Globally-defined parts can not specify constant bindings, but the flow is mostly the same.

```xml
<CustomPart Name="RobotSummary2"
            Export="true"
            ViewModel="RobotSummaryViewModel"
            CanUseOldInputVersions="true"
            Template="{Html Source='Templates\\Robot.html'}"
            InitialSize="FullWidthFitHeight">
    <CustomPart.Properties>
        <Property Name="name"
                  Source="{DataInput Property=name}" />
        <Property Name="version"
                  Source="{DataInput Property=version}" /> <!-- currently 2 -->
    </CustomPart.Properties>
</CustomPart>
```

  The following code demonstrates how to process explicitly-versioned inputs, in addition to the version of the parts that existed previous to the addition of explicit versioning support.

```javascript
public onInputsSet(inputs: Def.InputsContract, settings: Def.SettingsContract): MsPortalFx.Base.Promise {
        var name: string;
        if (inputs.version === "2") {  // this block explicitly handles version 2, which is the latest
            name = inputs.name;
        } else if (inputs.version === "1") { // this block explicitly handles version 1, which is now old, but was an explicit version
            var oldInputs: any = inputs;
             name = oldInputs.oldName;
        } else if (MsPortalFx.Util.isNullOrUndefined(inputs.version)) { // this block handles any version of the inputs
            var oldestInputs: any = inputs;                             //  that existed before the version property was added
            name = oldestInputs.oldestName;
        } else {
            throw new Error("Unexpected version.  This should not happen, but there is one edge case where you temporarily deploy a new version, say version 3, and then roll back your code to version 2.  Any tiles pinned before you roll back will hit this block.");
        }
        return this._view.fetch(name);
    }
```

The same technique can be used for part settings as in the following example.

```javascript
public onInputsSet(inputs: Def.InputsContract, settings: Def.SettingsContract): MsPortalFx.Base.Promise {
        var someSetting: string;
        if (settings.version === "2") {  // this block explicitly handles version 2, which is the latest
            someSetting = settings.someSetting;
        } else if (settings.version === "1") { // this block explicitly handles version 1, which is now old, but was an explicit version
            var oldSettings: any = settings;
            someSetting = oldSettings.oldSetting;
        } else if (MsPortalFx.Util.isNullOrUndefined(settings.version)) { // this block handles any version of the settings
            var oldestSettings: any = string;                             //  that existed before the version property was added
            someSetting = oldestSettings.oldestSetting;
        } else {
            throw new Error("Unexpected version.  This should not happen, but there is one edge case where you temporarily deploy a new version, say version 3, and then roll back your code to version 2.  Any tiles pinned before you roll back will hit this block.");
        }
        return this._view.fetch(name);
    }
```
