
<a name="pricing-tier"></a>
## Pricing Tier

<a name="pricing-tier-consuming-the-spec-picker-blade"></a>
### Consuming the Spec Picker Blade

The spec picker has a three controls (dropdown, infobox, and selector) for getting the data from the spec picker blades. The best way is to use the Spec Picker dropdown in your create blades.

 ```typescript

// The spec picker initial data observable.
const initialDataObservable = ko.observable<SpecPicker.InitialData>({
    selectedSpecId: "A0",
    entityId: "",
    recommendedSpecIds: ["small_basic", "large_standard"],
    recentSpecIds: ["large_basic", "medium_basic"],
    selectRecommendedView: false,
    subscriptionId: "subscriptionId",
    regionId: "regionId",
    options: { test: "DirectEA" },
    disabledSpecs: [
        {
            specId: "medium_standard",
            message: ClientResources.robotPricingTierLauncherDisabledSpecMessage,
            helpBalloonMessage: ClientResources.robotPricingTierLauncherDisabledSpecHelpBalloonMessage,
            helpBalloonLinkText: ClientResources.robotPricingTierLauncherDisabledSpecLinkText,
            helpBalloonLinkUri: ClientResources.robotPricingTierLauncherDisabledSpecLinkUri
        }
    ]
});
this.specDropDown = new SpecsDropDown(container, {
    form: this,
    accessor: this.createEditScopeAccessor((data: CreateEngineDataModel) => {
        return data.spec;
    }),
    initialData: initialDataObservable,
    // This extender should be the same extender view model used for the spec picker blade.
    // You may need to extend your data context or share your data context between your
    // create area and you spec picker area to use the extender with the current datacontext.
    specPickerExtender: new BillingSpecPickerV3Extender(container, initialDataObservable(), dataContext),
    pricingBlade: {
        detailBlade: "BillingSpecPickerV3",
        detailBladeInputs: {},
        hotspot: "EngineSpecDropdown1"
    }
});

```

### Spec Picker Blade

To create a pricing tier blade you'll need to first create the blade in pdl using the `SpecPickerV3` template,

 ```xml

<azurefx:SpecPickerBladeV3 Name="RobotSpecPickerV3"
                        BladeViewModel="RobotSpecPickerV3BladeViewModel"
                        PartExtenderViewModel="RobotSpecPickerV3Extender" />

```

a blade view model,

 ```typescript

/**
* The view model that drives the Virtual Machines specific spec picker blade.
*/
export class RobotSpecPickerV3BladeViewModel extends MsPortalFx.ViewModels.Blade {
   /**
    * Creates the view model for the spec picker blade.
    *
    * @param container The view model for the blade container.
    * @param initialState The initial state for the blade view model.
    * @param dataContext The data context for the Create area.
    */
   constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: HubsArea.DataContext) {
       super();
       this.title(ClientResources.vmSpecPickerBladeTitle);
       this.subtitle(ClientResources.vmSpecPickerBladeSubtitle);
   }
}

```

and an extender viewModel,

 ```typescript

/**
* The sample extender for the robot spec picker blade.
*/
export class RobotSpecPickerV3Extender implements HubsExtension.Azure.SpecPicker.SpecPickerExtender {
   /**
    * See SpecPickerExtender interface.
    */
   public input = ko.observable<SpecPicker.SpecPickerExtenderInput>();

   /**
    * See SpecPickerExtender interface.
    */
   public output = ko.observable<SpecPicker.SpecPickerExtenderOutput>();

   /**
    * See SpecPickerExtender interface.
    */
   public selectionMode: Lists.ListView.SelectionMode;

   /**
    * See SpecPickerExtender interface.
    */
   public filterControls: KnockoutObservableArray<SpecPicker.FilterControl>;

   private _specDataView: MsPortalFx.Data.EntityView<SpecPicker.SpecData, any>;

   private _specData = ko.observable<SpecPicker.SpecData>();

   /**
    * Extender constructor.
    *
    * @param container The view model for the part container.
    * @param initialState The initial state for the part.
    * @param dataContext The data context.
    */
   constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: HubsArea.DataContext, selectionMode?: Lists.ListView.SelectionMode) {
       
```

Inside of the constructor of the extender view model you'll have to setup the input and output observables for the extender.

 ```typescript

// The spec picker can return one or many specs. Specify if you want the user to be able to select multiple specs.
this.selectionMode = selectionMode || Lists.ListView.SelectionMode.Single;

// Perform the initial fetch to load data into the view from your own controllers
//config#specPickerData
this._specDataView = dataContext.robotData.specDataEntity.createView(container);
this._specDataView.fetch({}).then(
    () => {
        const specData = ko.toJS(this._specDataView.item());
        // Pass the spec data into an observable
        this._specData(specData);
    },
    () => {
        // Implement custom error handling logic
        throw new Error("Fetch spec data failed.");
    }
);
//config#specPickerData

// a computed which returns an array of spec ids which will determine what specs will be shown
const filteredSpecIds = ko.computed(container, () => {
    const input = this.input();
    if (!input) {
        return [];
    }
    // Options is a property passed in as part of the blade inputs. Defaults to any type
    const options = input.options;
    const filterFeatures: string[] = options && options.filterFeatures || [];

    // React to the input availableSpecData observable. This observable is updated
    // when billing information returns from the server and contains specs which have not
    // been filtered out by the billing calls.
    return input.availableSpecData().filter((spec) => {
        // This will filter out any spec which contains the feature in input.options.filterFeatures
        return !spec.features.first((feature) => (feature.displayValue !== null && feature.displayValue !== undefined) && !!~filterFeatures.indexOf(feature.displayValue.toString()));
    }).map((spec) => spec.id);
});
ko.reactor(container, () => {
    // react to inputs and specData observables being updated
    const input = this.input(),
        specData = this._specData();

    if (!input || !specData) {
        return;
    }

    const output: SpecPicker.SpecPickerExtenderOutput = {
        specData: specData,
        //disabledSpecs: [],
        //failureMessage: "",
        //recentSpecIds: [],
        filteredSpecIds: filteredSpecIds
    };
    // Update the output observable to give all the spec data back to the spec picker blade
    this.output(output);
});

```

The data fetching part is where you're code will bring all of the spec picker data into the output.

 ```typescript

this._specDataView = dataContext.robotData.specDataEntity.createView(container);
this._specDataView.fetch({}).then(
    () => {
        const specData = ko.toJS(this._specDataView.item());
        // Pass the spec data into an observable
        this._specData(specData);
    },
    () => {
        // Implement custom error handling logic
        throw new Error("Fetch spec data failed.");
    }
);

```

The data in here will have the information that will be shown on the specs and as well as the `ResourceMap` information used to look up pricing from billing.

<a name="pricing-tier-sample-spec-data"></a>
### Sample Spec Data

Sample Spec

 gitdown": "include-section", "file": "../../../src/SDK/Framework.Tests/TypeScript/Tests/HubsExtension/SpecPickerV3/Mock.ts", "section": "config#sampleSpec"}

Sample Features

 gitdown": "include-section", "file": "../../../src/SDK/Framework.Tests/TypeScript/Tests/HubsExtension/SpecPickerV3/Mock.ts", "section": "config#sampleFeature"}

Sample Resource Map

 gitdown": "include-section", "file": "../../../src/SDK/Framework.Tests/TypeScript/Tests/HubsExtension/SpecPickerV3/Mock.ts", "section": "config#sampleResourceMap"}

For the resourceIds in the resource map, you'll need to cooridanate with billing to add any new resource ids in your spec picker.
The `default` resource map will be used if no region is specified as part of the spec picker blade inputs.