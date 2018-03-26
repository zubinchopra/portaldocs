
<a name="create"></a>
### Create

<a name="create-opening-the-create-blade-from-a-deployed-gallery-package"></a>
#### Opening the create blade from a deployed gallery package

To open/navigate to the create blade a gallery package previously deployed to the Azure Marketplace you can use `portal.openGalleryCreateBlade`.  The returned promise will resolve with the CreateBlade defined by that gallery package. 

```ts 
import TestFx = require('MsPortalFx-Test');
...
FromLocalPackage
        return testFx.portal.openGalleryCreateBladeFromLocalPackage(
            extensionResources.samplesExtensionStrings.Engine.engineV3,     //title of the item in the marketplace e.g "EngineV3"
            extensionResources.samplesExtensionStrings.Engine.createEngine, //the title of the blade that will be opened e.g "Create Engine"
            10000)                                                          //an optional timeout to wait on the blade
        .then(() => createEngineBlade.checkFieldValidation())
        .then(() => createEngineBlade.fillRequiredFields(resourceName, "600cc", "type1", subscriptionName, resourceName, locationDescription))
        .then(() => createEngineBlade.actionBar.pinToDashboardCheckbox.click())
        .then(() => createEngineBlade.actionBar.createButton.click())
        .then(() => testFx.portal.wait(until.isPresent(testFx.portal.blade({ title: resourceName })), 120000, "The resource blade was not opened, could be deployment timeout."));
        
...
```

<a name="create-opening-the-create-blade-from-a-local-gallery-package"></a>
#### Opening the create blade from a local gallery package

To open/navigate to the create blade a local gallery package that has been side loaded into the Portal along with your extension you can use `portal.openGalleryCreateBladeFromLocalPackage`.  The returned promise will resolve with the CreateBlade defined by that gallery package. 

```ts 
import TestFx = require('MsPortalFx-Test');
...

        return testFx.portal.openGalleryCreateBladeFromLocalPackage(
            extensionResources.samplesExtensionStrings.Engine.engineV3,     //title of the item in the marketplace e.g "EngineV3"
            extensionResources.samplesExtensionStrings.Engine.createEngine, //the title of the blade that will be opened e.g "Create Engine"
            10000)                                                          //an optional timeout to wait on the blade
        .then(() => createEngineBlade.checkFieldValidation())
        .then(() => createEngineBlade.fillRequiredFields(resourceName, "600cc", "type1", subscriptionName, resourceName, locationDescription))
        .then(() => createEngineBlade.actionBar.pinToDashboardCheckbox.click())
        .then(() => createEngineBlade.actionBar.createButton.click())
        .then(() => testFx.portal.wait(until.isPresent(testFx.portal.blade({ title: resourceName })), 120000, "The resource blade was not opened, could be deployment timeout."));
        
...
```

<a name="create-validation-state"></a>
#### Validation State

<a name="create-get-the-validation-state-of-fields-on-your-create-form"></a>
#### Get the validation state of fields on your create form

`FormElement` exposes two useful functions for working with the ValidationState of controls. 

The function `getValidationState` returns a promise that resolves with the current state of the control and can be used as follows

```ts
import TestFx = require('MsPortalFx-Test');
...

            //click the createButton on the create blade to fire validation
            .then(() => this.actionBar.createButton.click())
            //get the validation state of the control
            .then(() => this.name.getValidationState())
            //assert state matches expected
            .then((state) => assert.equal(state, testFx.Constants.ControlValidationState.invalid, "name should have invalid state"));
...

```

<a name="create-wait-on-a-fields-validation-state"></a>
#### Wait on a fields validation state

The function `waitOnValidationState(someState, optionalTimeout)` returns a promise that resolves when the current state of the control is equivalent to someState supplied.  This is particularly useful for scenarions where you may be performing serverside validation and the control remains in a pending state for the duration of the network IO.

```ts
import TestFx = require('MsPortalFx-Test');
...

            //change the value to initiate validation
            .then(() => this.name.sendKeys(nameTxt + webdriver.Key.TAB))
            //wait for the control to reach the valid state
            .then(() => this.name.waitOnValidationState(testFx.Constants.ControlValidationState.valid))
...

```