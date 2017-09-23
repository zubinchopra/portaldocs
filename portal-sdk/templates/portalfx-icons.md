
# Icons

When you're ready to start adding icons in parts, commands, or blades, the portal places some special requirements on the types of icons you can use.  All icons are required to be SVG files - this allows for icons that will scale on high resolution devices, and for automatic theming.

In many cases, you will not need to provide your own icons, as the SDK framework includes a large library of icons that can be used off the shelf.

## [Using built-in icons](portalfx-icons-builtin.md)
## [Creating icons](portalfx-icons-creation.md)
## [FAQs](portalfx-icons-faq.md)

### Special MsPortalFx.Base.Images Calls

  * **MsPortalFx.Base.Images.Blank()** \- Doesn't render any SVG element, overrides the default icon.
  * **MsPortalFx.Base.Images.Custom** \- Triggers loading a custom SVG's from your project, this is built into your SVG bundle definition. So you shouldn't normally need to call it.
  * **MsPortalFx.Base.Images.ImageUri()** \- Used to add non SVG images. *Not recommended*

### Using the built in SVG's (Command Bar Example).

Here is a simple example of using a build in SVG on the command bar:

```ts
export class DeleteCommandViewModel implements MsPortalFx.ViewModels.CommandContract {
    public icon = ko.observable<MsPortalFx.Base.Image>();

    constructor(dataContext: WebsitesDataContext) {
        this.icon(MsPortalFx.Base.Images.Delete());
    }
}
```

### Setting up your project file to use Custom SVG's.

1. Add this to your .csproj :

```xml
<SvgTypeScriptCompile Include="Client\_generated\Svg.ts">
  <Namespace>SamplesExtension</Namespace>
  <IsAmd>true</IsAmd>
</SvgTypeScriptCompile>
```

2. Add your SVG's to your project and assign their build action to 'Svg' like so:
```xml
<Svg Include="Content\SamplesExtension\Images\sample.svg" />
```

3. Then you can import the **Svg** module (or whatever you named it above) in any file you need to use custom images:

```ts
import Svg = require ("./../_generated/Svg");
...
this.icon(Svg.Content.SamplesExtension.Images.robot);
```

You now you will be able to reference your SVG's images

Be sure not to check the generated Svg.ts file in source control, as it updates whenever you add/remove/change an svg.

### Tips & Tricks

- Do not name your SVG's <a href="http://msdn.microsoft.com/en-us/library/ie/0779sbks(v=vs.94).aspx" target="_blank">JavaScript reserved words</a> (ie delete).

#### Using custom SVG's in PDL.
  This is the common pattern when using icons in PDL, see the Icon attribute below:
  ```xml
     <AssetType Name="Engine"
                Text="{Resource engineSearchProviderKey, Module=ClientResources}"
                Icon="{Resource Content.SamplesExtension.Images.engine, Module=./../Generated/SvgDefinitions}"
                BladeName="EngineBlade"
                PartName="EnginePart">
  ```

#### Using custom SVG's in the command bar.

  1. Add SVGS's to your project and include the generated file as described above.
  2. AMD example (Assuming we have `<Svg Include="Content\Images\Commandbar_Trash.svg" />` included in the project file):
  3. ```ts
    import CustomSvgImages = require("./SvgDefinitions.js");
    export class DeleteCommandViewModel implements MsPortalFx.ViewModels.CommandContract {
        public icon = ko.observable<MsPortalFx.Base.Image>();

        constructor(dataContext: WebsitesDataContext) {
            this.icon(CustomSvgImages.Content.MsPortalFx.Images.commandbar_Trash);
        }
    }
    ```

#### Using PNG's/ with the custom data binding 'image'.(for command bar)

This lets you switch between SVG's and normal images while using the same data binding.

```ts
export class DeleteCommandViewModel implements MsPortalFx.ViewModels.CommandContract {
    public icon = ko.observable<MsPortalFx.Base.Image>();

    constructor(dataContext: WebsitesDataContext) {
        //SVG version
        //this.icon(MsPortalFx.Base.Images.Start());

        //PNG Version
        this.icon(MsPortalFx.Base.Images.ImageUri(MsPortalFx.Base.Resources.getContentUri("Content/RemoteExtension/Images/Website_Commandbar_Play.png")));
    }
}
```

#### Using Palettes

You can change the color of most icons provided by the framework (All the ones at the root namespace ie
`MsPortalFx.Base.Images.Add()` but not `MsPortalFx.Base.Images.Polychromatic.PowerUp()`)

To do so all you need to do is add {palette: MsPortalFx.Base.ImagePalette.*} inside the function

```ts
import CustomSvgImages = require("./SvgDefinitions.js");
...
export class DeleteCommandViewModel implements MsPortalFx.ViewModels.CommandContract {
    public icon = ko.observable<MsPortalFx.Base.Image>();

    constructor(dataContext: WebsitesDataContext) {
        this.icon(MsPortalFx.Base.Images.Delete({palette: MsPortalFx.Base.ImagePalette.Blue}));
    }
}
```

#### Preserving icon coloring when user changes theme

For any [built-in monochromatic icon (a.k.a. flat icon)](https://df.onecloud.azure-test.net/#blade/SamplesExtension/IconsMonochromaticBlade), its color changes relative to the portal's background color as the user changes themes.

In light theme, monochromatic icon is presented with color black:

![Flat icons with light theme][icon-light-theme]

In dark theme, monochromatic icon is presented with color white:

![Flat icons with dark theme][icon-dark-theme]

If you would like to have color of your icon ***NOT*** be impacted by theme changes, you can supply the `{ isLogo: true }` option to the icon's factory method.
In the following example, the Delete icon remains **black** in all portal themes.

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/UI/ViewModels/Blades/IconBladeViewModels.ts","section":"icon#flatIconWithLogoFlat"}

Or, you can also add custom color and use `{isLogo: true}` to preserve it.
In the following example, the Delete icon keeps **blue** in all portal themes.

{"gitdown":"include-section","file":"../Samples/SamplesExtension/Extension/Client/V1/UI/ViewModels/Blades/IconBladeViewModels.ts","section":"icon#flatIconWithPaletteAndLogoFlat"}

Next steps: [Using built-in icons](portalfx-icons-builtin.md)

[icon-light-theme]: ../media/portalfx-icons/icon-light-theme.PNG
[icon-dark-theme]: ../media/portalfx-icons/icon-dark-theme.PNG