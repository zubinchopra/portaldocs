
# Migrating to the latest Browse API

Browse v2 introduces paging and a greatly-simplified API for ARM resources. It does not  support non-ARM assets. However, if you have an ARM resource, you can start with no-code Browse and build out based on your needs. 

Browse v1 used the standard grid `Column` interface. In Browse v2, we created a separate interface, specific to Browse. The following grid `Column` properties are not supported in Browse v2.

* `sortFormatter`
* `filterFormatter`
* `cssClass`
* `enableEllipse`
* `fullHeight`

## Migration Process

The migration to Browse V2 is as follows.

1. Replace the `Browse` and `GridColumns` nodes on your asset type definition with a new `Browse` node.  Its  `Type` should be set to `ResourceType`, as in the following example.

    ```xml
    <AssetType Name="MyAsset" Text="{Resource MyAsset.text, Module=ClientResources}" ...>
      <Browse Type="ResourceType" />
      <ResourceType
          ResourceTypeName="Resource.Provider/types"
          ServiceViewModel="MyAssetServiceViewModel"
          MappingViewModel="MyAssetMappingViewModel" />
    </AssetType>
    ```

1. Change the display name for the asset type to include singular/plural and uppercase/lowercase variants. These will help ensure that the correct text is displayed at the right time throughout the Portal, as in the following code.

    ```xml
    <AssetType
        Name="MyAsset"
        SingularDisplayName="{Resource MyAsset.singular, Module=ClientResources}"
        PluralDisplayName="{Resource MyAsset.plural, Module=ClientResources}"
        LowerSingularDisplayName="{Resource MyAsset.lowerSingular, Module=ClientResources}"
        LowerPluralDisplayName="{Resource MyAsset.lowerPlural, Module=ClientResources}"
        ...>
      <Browse Type="ResourceType" />
      <ResourceType
          ResourceTypeName="Resource.Provider/types"
          ServiceViewModel="MyAssetServiceViewModel"
          MappingViewModel="MyAssetMappingViewModel" />
    </AssetType>
    ```

1. Display the asset type as a resource type in the Browse hub. No-code Browse shows the resource name, group, location, and subscription by default. To change the default columns, your extension should opt in to custom configuration, and define an asset `ViewModel`, as in the following example.

    ```xml
    <AssetType Name="MyAsset" ViewModel="MyAssetViewModel" ...>
      <Browse Type="ResourceType" UseCustomConfig="true" />
      ...
    </AssetType>
    ```

1. The asset `ViewModel` class implements a generated interface to help enforce the declared functionality, as in the following example.

    ```ts
    class MyAssetViewModel implements ExtensionDefinition.ViewModels.ResourceTypes.MyAssetViewModel.Contract {
        public getBrowseConfig(): PromiseV<MsPortalFx.Assets.BrowseConfig> {
            return Q.resolve({
                ...
            });
        }
    }
    ```

1. Copy the column config from the grid column service `ViewModel`.

    ```ts
    this.columns([{
        id: "name",
        name: ko.observable<string>(ClientResources.myAssetNameColumn),
        itemKey: "name"
    },{
        id: "resourceGroup",
        name: ko.observable<string>(ClientResources.myAssetGroupColumn),
        itemKey: "resourceGroup"
    },{
        id: "type",
        name: ko.observable<string>(ClientResources.type),
        itemKey: "type",
        format: MsPortalFx.ViewModels.Controls.Lists.Grid.Format.HtmlBindings,
        formatOptions: {
            htmlBindingsTemplate: "<div data-bind='text: type'></div> (<div data-bind='text: subtype'></div>)"
        }
    },{
        id: "sku",
        name: ko.observable<string>(ClientResources.myAssetSkuColumn),
        itemKey: "sku",
        format: MsPortalFx.ViewModels.Controls.Lists.Grid.Format.TextLookup,
        formatOptions: {
            textLookup: {
                0: ClientResources.myAssetSkuFree,
                1: ClientResources.myAssetSkuStandard,
                2: ClientResources.myAssetSkuEnterprise
            }
        }
    },{
        id: "subscription",
        name: ko.observable<string>(ClientResources.myAssetSubscriptionColumn),
        itemKey: "subscription"
    }]);
    ```

1. Move the columns from your grid columns service to `BrowseConfig.columns` in your `getBrowseConfig()` function. Then,  remove unnecessary standard columns, for example,  name, group, location, and subscription.

    ```ts
    public getBrowseConfig(): PromiseV<MsPortalFx.Assets.BrowseConfig> {
        return Q.resolve({
            columns: [{
                id: "type",
                name: ko.observable<string>(ClientResources.type),
                itemKey: "type",
                format: MsPortalFx.ViewModels.Controls.Lists.Grid.Format.HtmlBindings,
                formatOptions: {
                    htmlBindingsTemplate: "<div data-bind='text: type'></div> (<div data-bind='text: subtype'></div>)"
                }
            },{
                id: "sku",
                name: ko.observable<string>(ClientResources.myAssetSkuColumn),
                itemKey: "sku",
                format: MsPortalFx.ViewModels.Controls.Lists.Grid.Format.TextLookup,
                formatOptions: {
                    textLookup: {
                        0: ClientResources.myAssetSkuFree,
                        1: ClientResources.myAssetSkuStandard,
                        2: ClientResources.myAssetSkuEnterprise
                    }
                }
            }]
        });
    }
    ```

1. In Browse v1, the columns to show were all defined by  default. In Browse v2, developers  can specify additional columns that the user can include in the grid. In this example, however, the  default columns are specified.

    ```ts
    public getBrowseConfig(): PromiseV<MsPortalFx.Assets.BrowseConfig> {
        return Q.resolve({
            columns: [...],
            defaultColumns: [ResourceColumns.resourceGroup, "type", "sku"]
        });
    }
    ```

    **NOTE**: You can include any of the standard columns, in addition to the custom columns, by referencing their id. The asset type icon, resource name, and subscription are all required and included by default.

1. If HTML-formatted columns are included that require properties that are not columns, those additional properties must be specified or they will not be populated in the grid. Declare those  property names separately, as in the following example.

    ```ts
    public getBrowseConfig(): PromiseV<MsPortalFx.Assets.BrowseConfig> {
        return Q.resolve({
            columns: [...],
            defaultColumns: [ResourceColumns.resourceGroup, "type", "sku"],
            properties: ["subtype"]
        });
    }
    ```

1. Customized columns can now be populated with supplemental data. Change the PDL to indicate that there will be supplemental data instead of just custom configuration, as in the folowing example.

    ```xml
    <AssetType Name="MyAsset" ViewModel="MyAssetViewModel" ...>
      <Browse Type="ResourceType" UseSupplementalData="true" />
      ...
    </AssetType>
    ```

    **NOTE**: Please use the supplemental data API until RP properties can be supported by using Browse config.

1. Because  the  asset `ViewMmodel` implements a generated interface, a property and  a method will be missing on the next compile unless they are added, as in the following code.

    ```ts
    class MyAssetViewModel implements ExtensionDefinition.ViewModels.ResourceTypes.MyAssetViewModel.Contract {
        private _container: MsPortalFx.ViewModels.ContainerContract;
        private _dataContext: any;

        public supplementalDataStream = ko.observableArray<MsPortalFx.Assets.SupplementalData>([]);

        constructor(container: MsPortalFx.ViewModels.ContainerContract, initialState: any, dataContext: ResourceTypesArea.DataContext) {
            this._container = container;
            this._dataContext = dataContext;
        }

        public getSupplementalData(resourceIds: string[], columns: string[]): Promise {
            ...
        }

        ...
    }
    ```

1. The most efficient way to obtain and update data is to use a single query view that aggregates data on the  controller. If data comes from multiple sources, also send the required data to avoid querying for more data than is actually necessary. Your extension should query only for the data for the visible resources and columns. The Browse v2 extension controls the paging, and will call `getSupplementalData()` with the resource ids and columns that are currently visible, as in the following example.

    ```ts
    public getSupplementalData(resourceIds: string[], columns: string[]): Promise {
        // NOTE: Do not create the view in the constructor. Initialize here to create only when needed.
        this._view = this._view || this._dataContext.myAssetQuery.createView(this._container);

        // connect the view to the supplemental data stream
        MsPortalFx.Assets.SupplementalDataStreamHelper.ConnectView(
            this._container,
            view,
            this.supplementalDataStream,
            (myAsset: MyAsset) => {
                return resourceIds.some((resourceId) => {
                    return ResourceTypesService.compareResourceId(resourceId, myAsset.id());
                });
            },
            (myAsset: MyAsset) => {
                // save the resource id so Browse knows which row to update
                var data = <MsPortalFx.Assets.SupplementalData>{ resourceId: myAsset.id() };

                // only save sku if column is visible
                if (columns.indexOf("sku") !== -1) {
                    data.sku = robot.sku();
                }

                // if the type column is visible, also add the subtype property
                if (columns.indexOf("type") !== -1) {
                    data.type = robot.type;
                    data.subtype = robot.subtype;
                }

                return data;
            });

        // send resource ids to a controller and aggregate data into one client request
        return view.fetch({ resourceIds: resourceIds });
    }
    ```

**NOTE**: Do not query all data for all resources.