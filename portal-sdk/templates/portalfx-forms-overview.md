
## Overview

Form controls are a subset of controls that allow users to input information.  These controls provide a consistent API surface for managing validation, variable states, and user input.  They also provide a consistent layout structure.
  
Forms offer the ability to take advantage of features like consistent layout styles and form-integrated UI widgets. They are created using `HTML` templates and `ViewModels`. 

**NOTE**:  EditScopes are becoming obsolete.  It is recommended that extensions and forms be developed without edit scopes, as specified in [portalfx-editscopeless-procedure.md](portalfx-editscopeless-procedure.md).

Developers can use standard `HTML` and **Knockout** to build forms, in addition to the following items for which the SDK Framework includes support.

  * Labels
  
  * Validation, as in the following image

    ![alt-text](../media/portalfx-forms/forms.png "Forms Example") 

  * Change tracking

  * Form reset

  * Persisting edits across journeys and browser sessions

Everything that applies to controls also applies to form controls, as specified in [top-extensions-controls.md](top-extensions.controls.md).

### Form control view model contract properties

**value**: The value property is bound to the value shown in the control. You can subscribe to it in order to respond to user input, and you can set it to update the widget's value programmatically. This property is configurable.

**disabled**: Setting this property to `true` stops the user from entering data into the control.  It will also prevent validation from running, because if validation fails, there is no way for the user to correct the value of this control.  This property also shows the user that the control is disabled by changing the styling and aria attributes.

**dirty**: The dirty property is bound to the edit state of the control.  It is changed from `false` to `true` if the user changes the `value` property by interacting with the control.  Setting the `value` property programmatically will not affect the `dirty` state of the control. Additionally, when a blade is closed, and there are dirty fields present, a popup is displayed that warns the user that they might lose their input.  This alert is suppressed when the blade is closed programmatically with the blade close APIs, and data is sent back to the parent blade.  Additionally, developers can control the behavior of this alert by using the `Context.Form.ConfigureAlertOnClose` method, where context is the blade context object. This property is configurable.

  **NOTE**: The framework never resets this property from `true` back to `false`, because the framework does not track the original values of the control.  To set or reset this property programmatically, just write to it as you would any other observable.

**validations**: Validations are run whenever the control value changes, when the validations array changes, or whenever the extension calls `triggerValidation` programmatically.  If the validations fail, the control will be marked as invalid, and the validation message will be shown below the control.  In addition, if this collection contains a "Required" validation, a red asterisk will be displayed next to the label of the control that signifies to users that a value is required to proceed. This property is configurable.

**NOTE**: The extension can programmatically trigger validation on all visible form fields by using  `context.Form.TriggerValidation`, where context is the blade context object.

**validationResults**: This property is a reflection over the current state of all validations on the control.

**valid**: The valid property is a read-only property that reflects the current validation state of the control. 

**label, sublabel, infoBalloonContent**: These properties allow the extension to display information that describes the control.  These properties will only appear in the widget if their values were set.  The label property is displayed above or to the right of the control.  The sublabel is typically shown below and to the left of the control.  The info balloon will be shown next to the label.  See the [Form Layout](#form-layout) on how to change layout.  Configuring these properties will also display information in accessible ways by using aria attributes.

**triggerValidation**: This method runs all validations on the control.  It will return a `promise` with the overall valid state of the control after validation has completed.

## Form control input options

<!-- TODO: Determine which other properties are not configurable. -->

All configurable properties on the control, like `value`, `validations`, or `dirty`, are options that can be sent as either observables or non-observables.  Observable values are best used when one observable is already present and you do not want to set up the two-way binding. For example, you could send the same observable as the `disabled` property to multiple forms, and then disable all of the forms at once by setting that observable only once. For more information about observables, see [portalfx-blades-viewmodel.md#observable-and-non-observable-values](portalfx-blades-viewmodel.md#observable-and-non-observable-values).

**NOTE**:  For the most part, sending in non-observables is recommended because it makes extension code more readable and less verbose.

**suppressDirtyBehavior**: This is used when the form control is not being used for saving data. When this flag is set to true, the control will not mark itself as `dirty` when the value is changed.  This will prevent dirty styling, and prevent this control from triggering the alert when blades are closed.  For example, if you have a slider that controls the zoom level of a view, no information is lost when the blade is closed.

**NOTE**: This property is not configurable after creation of the control.

### Form Layout

Because form controls are often grouped together, it is important to keep the layout of the controls consistent. Consequently, most form layout is controlled by using sections. They allow developers to group controls and other sections, into structured layouts. For more information about sections at [http://aka.ms/portalfx/playground](http://aka.ms/portalfx/playground).

The section has two properties that allow for layout control. They are as follows.

**leftLabelPosition**: When this property is set to true, the labels of child form controls are placed to the left of the control, instead of above the control.  The controls themselves are aligned vertically, a few pixels to the right of the longest label.

**LeftLabelWidth**: When this property is set to true, the labels of the child form controls are placed to the left of the control, instead of above the control.  The control labels have a fixed width that is set to the number of pixels that was sent to the control. 

<!--TODO:  Determine what was meant by 

"**NOTE**: Custom layouts are not recommended."
Or, determine what is recommended instead of the custom layouts. -->

### Legacy Integration

If you are working with blades that use legacy concepts like `editScope`, you can still use the new form controls by sending the `editScope` observable to the blade options as the `value` property. This results in the `editScope` being updated when the control is updated, and vice versa.

### Form Content

Form-integrated controls are the UI widgets that are compatible with forms. They can be used in a majority of forms scenarios. They automatically enable good form patterns, built-in validation, and auto-tracking of changes. The controls playground is located at  [https://aka.ms/portalfx/playground](https://aka.ms/portalfx/playground), and it allows developers to build their own code instead of using the provided samples.

### Form Topics

There are a number of subtopics in the forms topic.  Sample source code is included in subtopics that discuss the various Azure SDK API items.

| API Topic                        | Document                                                                                     | 
| -------------------------------- | -------------------------------------------------------------------------------------------- | 
| Designing and Arranging the Form | [portalfx-forms-designing.md](portalfx-forms-designing.md)                                   |  
| Forms Construction               | [portalfx-forms-construction.md](portalfx-forms-construction.md)                             |  
| Integrating Forms with Commands  | [portalfx-forms-integrating-with-commands.md](portalfx-forms-integrating-with-commands.md)   | 
| Form Field Validation            | [portalfx-forms-field-validation.md](portalfx-forms-field-validation.md)                     | 
| Sample Extensions with Forms     | [portalfx-extensions-samples-forms.md](portalfx-extensions-samples-forms.md)                 |

For more information about how forms and parameters interact with an extension, see [portalfx-parameter-collection-overview.md](portalfx-parameter-collection-overview.md).

For more information about forms with editScopes, see [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md).

For more information about forms without editScopes, see [portalfx-editscopeless-overview.md](portalfx-editscopeless-overview.md).