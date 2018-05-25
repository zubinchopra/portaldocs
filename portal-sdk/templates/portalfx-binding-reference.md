
## PDL Binding Quick Reference


| Binding | Applies To  | Notes | 
| ------- | ----------  | ----- |
| ViewModel="BladeViewModel" | Blade, CustomPart | Binds to filename `BladeViewModel.ts` and class name `BladeViewModel`. | 
| ViewModel="{ViewModel Name=BladeViewModel, Module=./Locked/ViewModels/BladeViewModelFilename}" | Blade, CustomPart    | Binds to `BladeViewModel` defined within `BladeViewModelFilename.ts` located at path `./Locked/ViewModels/` |
| <pre>  `<Blade.Parameters>` `<Parameter Name="id" Type="%Type%" />` `</Blade.Parameters>` </pre>  |  Blade.Parameters    | Blade.Parameters is used to define a collection of Parameter elements that define the parameters the blade is required to receive from the caller. %Type% may be any of the following values {Key, NewEditScope, Output, Supplemental} | <a href="portalfx-blades-parameters.md"> - more detail</a>|
| <pre> `<Blade.Properties>` `<Property Name="idX"                Source="{BladeParameter id}"/> ` `</Blade.Properties>`  </pre> |  Blade.Properties    | Blade parameters defined within `Blade.Parameters` can be sent to the blade `ViewModel` by using  a `Blade.Property` collection of `Property` elements that are bound to a Source BladeParameter.  In this example the blade `ViewModel` `onInputsSet` method `inputs` parameter will have a property `inputs.idX` that contains the value of the supplied `BladeParameter` with name id <a href="portalfx-blades-properties.md">- more detail |
   | `Template="{Html Source='..\\..\\Common\\Templates\\PartWithTitle.html'}"`    | CustomPart    | Defines a html template for CustomPart located at relative path .\\..\\Common\\Templates\\PartWithTitle.html |
   | `Template="{Html Source='..\\..\\Common\\Templates\\PartWithTitle.html'}"` | CustomPart    | Defines a html template for CustomPart located at relative path .\\..\\Common\\Templates\\PartWithTitle.html |
  |   ```  <pre>
<Lens ...>
  <CustomPart ...>
    <CustomPart.Properties>
       <Property Name="resetTriggered" 
 	Source="{ActionBarProperty resetTriggered}" />
    </CustomPart.Properties>
  </CustomPart>
</Lens>
<ActionBar Name="FilterFormActionBar"
       ActionBarKind="Generic"
       ViewModel="FilterFormActionBarViewModel">
</ActionBar>`
```    | CustomPart.Properties    | As FilterFormActionBarViewModel.resetTriggered changes, `onInputsSet` will be called on the CustomPart ViewModel with parameter inputs.resetTriggered defined with the value of FilterFormActionBarViewModel.resetTriggered |


