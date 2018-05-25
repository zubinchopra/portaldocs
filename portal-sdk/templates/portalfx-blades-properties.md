
### Blade Properties

Blades use `ViewModels` to manage information like the title, subtitle, icon, and status. To acquire blade `ViewModel` data from a server, often the extension will load an object by Id. Information that is sent to the blade as a `BladeParameter` can be sent to the blade `ViewModel` by using  a `<Property>` element.

**NOTE**: In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory, and  `<dirParent>`  is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. 

 A code sample  is located  at `<dir>\Client\V1\Hubs\Browse\Browse.pdl`, and is also in the following code.

```xml
<Blade Name="RobotBlade" ViewModel="RobotBladeViewModel">
  <Blade.Parameters>
    <Parameter Name="id" Type="Key"/>
  </Blade.Parameters>

  <Blade.Properties>
    <Property Name="name" Source="{BladeParameter Name=id}"/>
  </Blade.Properties>
  ...
</Blade>
```

{"gitdown": "include-section", "file":"../Samples/SamplesExtension/Extension/Client/V1/Hubs\Browse\Browse.pdl", "section": "portalfx-blades-properties#property-element"}


In this example, an `id` property is sent to the blade as a parameter, and then the `name` property is sent as a `ViewModel`. The blade `ViewModel`  may subscribe to changes in this value, and update the blade information as required. An example of blade properties is located in `dir>Client\Hubs\Browse\ViewModels\RobotBladeViewModel.ts`. It is also in the following code.

```ts
module SamplesExtension.Hubs {
    /**
     * Represents the view model used by the robot blade.
     */
    export class RobotBladeViewModel extends MsPortalFx.ViewModels.Blade {

        /**
         * The name property is provided by an input binding to the blade.
         */
        public name = ko.observable("");

        /**
         * When the name is passed, bind it to the blade title. You could also choose
         * to grab the whole robot and use other pieces of its data (see RobotPartViewModel)
         */
        constructor(initialValue: any, dataContext: DataContext) {
            super();
            this.subtitle(SamplesExtension.Resources.Strings.hubsLensTitle);
            this.icon(MsPortalFx.Base.Images.Polychromatic.Gears());

            this.title = ko.computed((): string => {
                var title = SamplesExtension.Resources.Strings.loadingText;

                if (this.name() !== "") {
                    title = SamplesExtension.Resources.Strings.robotTitle + ": " + this.name();
                }

                return title;
            });
        }
    }
}
```

When changes are made to the `name` property on the `ViewModel`, the `title` is updated on the blade.

### Blade Property Bindings

In most cases, parts will bind to `{BladeParameter}` values that are sent to the blade. In some cases, the extension  may bind directly to a value on a blade `ViewModel`. The most common use of this binding is to transform a value from a `{BladeParameter}` into some other form.
    This is demonstrated in  the code located at    
`<dir>\Client\Blades\Properties\ViewModels\BladePropertyViewModels.ts`, and in the following code.

```ts
/**
 * The blade view model for blade Properties.
 */
export class BladePropertiesBladeViewModel extends MsPortalFx.ViewModels.Blade {

    /**
     * The temperature in celcius is calculated as a public property, used by a part.
     */
    public tempInCelcius: KnockoutComputed<number>;

    private _tempInFahrenheit = ko.observable(0);

    /**
     * View model constructor.
     */
    constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: DataContext) {
        super();
        this.title(SamplesExtension.Resources.Strings.bladePropertiesBladeTitle);
        this.icon(MsPortalFx.Base.Images.Polychromatic.Gears());

        this.tempInCelcius = ko.computed<number>(() => {
            return Math.round((this._tempInFahrenheit() - 32) * (5/9));
        });
    }

    /**
     * When the temperature in F is passed in, trigger the computed to calculate it in C
     */
    public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        this._tempInFahrenheit(inputs.tempInFahrenheit);
        this.title(SamplesExtension.Resources.Strings.bladePropertiesBladeTitle + " - " + inputs.tempInFahrenheit + " deg F");
        return null;
    }
}
```

The `viewModel` accepts an input of temperature in degrees Fahrenheit, and projects a new property of temperature in degrees Celsius. A part on this blade can bind to the public `tempInCelcius` property as in the code located at `<dir>\Client\Blades\Properties\BladeProperties.pdl` and in the following example.


```xml
<CustomPart Name="PropertyButtonPart"
            ViewModel="PropertyButtonPart"
            Template="{Html Source='Templates\\Temperature.html'}">
  <CustomPart.Properties>
    <!--
      This part accepts an input via a public property on the blade view model.
      These bindings are called BladeProperty bindings.
    -->
    <Property Name="tempInCelcius"
              Source="{BladeProperty content.tempInCelcius}" />
  </CustomPart.Properties>
</CustomPart>
```
