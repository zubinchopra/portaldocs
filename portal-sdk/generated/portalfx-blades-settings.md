
<a name="blade-settings"></a>
### Blade Settings

One goal of the Azure Portal is to standardize key interaction patterns across resources, so that customers can learn them once and apply them everywhere. There a few setting items which are consistent across most resources. To make that process easier, the Framework will automatically add specific settings, but also allow extensions to opt in for any settings that the Framework does not automatically add. All the settings that are added by the Framework can always be opted out, by setting  the appropriate enabling option to `false`. 

Only two settings are added automatically: RBAC and Audit logs, or events. They are only added if a valid resource id was specified within the `resourceId()` property on the settingsList viewmodel. The best way to set this property is to use the `onInputsSet` call, as in the following code.

```ts
export class SettingListPartViewModel extends MsPortalFx.ViewModels.Parts.SettingList.ViewModelV2 {
    ...

     public onInputsSet(inputs: any): MsPortalFx.Base.Promise {
        var id = inputs.id;
        this.resourceId(id);

        return null
    }
}
```

<a name="blade-settings-tags-and-rbac"></a>
#### Tags and RBAC

Tags and role-based access (RBAC) for users are the most common settings. Although the Portal does not automatically add Tags, it is extremely easy to opt in if your resource supports tagging. To opt in for tags, set the following in the **options** parameter of the **super** method of the **SettingsList** ViewModel, as in the following example.

```ts
export class SettingListPartViewModel extends MsPortalFx.ViewModels.Parts.SettingList.ViewModelV2 {
    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
         super(container, initialState, this._getSettings(container),
            {
             enableRbac: true,
             enableTags: true,
             groupable: true
            });
    }
}
```

For more information about tags, see [portalfx-tags](portalfx-tags) and [https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags).

<a name="blade-settings-support-settings"></a>
#### Support settings

<!-- TODO:  Determine whether this mailto address is accurate. -->

One key experience is Troubleshooting and Support. Azure provides customers with a consistent UI so that they can assess the health of every resource, check its audit logs, get troubleshooting information, or open a support ticket. Every extension should reach out to the <a href="mailto:AzSFAdoption@microsoft.com?subject=Onboarding with the Support team&body=Hello, I have a new extension that needs to opt in to to the features that Troubleshooting and Support provides.">Support Team at AzSFAdoption@microsoft.com</a> to opt in to the support system and UX integration.

Enabling the coordination between your extension and the support extension takes a little more effort. For each setting, the extension should opt in by using the **options** parameter of the **super** method of the **SettingsList** ViewModel, as in the following example.

```ts
export class SettingListPartViewModel extends MsPortalFx.ViewModels.Parts.SettingList.ViewModelV2 {
    constructor(container: MsPortalFx.ViewModels.PartContainerContract, initialState: any, dataContext: BladesArea.DataContext) {
         super(container, initialState, this._getSettings(container),
            {
             enableSupportHelpRequest: true,
             enableSupportTroubleshoot: true,
             enableSupportResourceHealth: true,
             enableSupportEventLogs: true,
             groupable: true
            });
    }
}
```

To test the coordination, use the following feature flags, depending on which settings you are testing.  **NOTE**: Your extension name is in lower case.

* ?<extensionName>_troubleshootsettingsenabled=true
* ?<extensionName>_healthsettingsenabled=true
* ?<extensionName>_requestsettingsenabled=true

For example, the following query string would enable TroubleShooting and Support for an extension named `microsoft_azure_classic_compute`.

`?microsoft_azure_classic_compute_requestsettingsenabled=true`

For more information about onboarding to support for Product Teams, see [http://aka.ms/portalfx/productteamsupport](http://aka.ms/portalfx/productteamsupport).