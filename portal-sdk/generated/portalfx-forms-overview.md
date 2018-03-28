<a name="developing-forms"></a>
# Developing Forms


The Portal SDK includes extensive support for displaying and managing user input through the use of Forms. Forms offer the ability to take advantage of features like consistent form layout styles, form-integrated UI widgets, user input validation, and data change tracking.

Forms are created using `HTML` templates, `ViewModels`, and `EditScopes`. Developers can use standard `HTML` and **Knockout** to build forms, in addition to the following items for which  the SDK Framework includes support.

  * Labels
  * Validation, as in the following image

    ![alt-text](../media/portalfx-forms/forms.png "Forms Example") 
  * Change tracking
  * Form reset
  * Persisting edits across journeys and browser sessions

<a name="developing-forms-form-layout"></a>
### Form Layout

Use form sections to group controls, and other sections, into structured layouts based on rows and columns. Form sections provide the following benefits.

* Predefined forms styles
* Maintains consistency with proven user usability tests
* Retains the flexibility to layout the forms in accordance with team designs.

Some form layout styles are as follows.

* Columns

![alt-text](../media/portalfx-ux-forms/columns.png "Columns")

* Create

![alt-text](../media/portalfx-ux-forms/create.png "Create")

* In-line labels

![alt-text](../media/portalfx-ux-forms/in_line.png "In-line")

* Full width

![alt-text](../media/portalfx-ux-forms/form_style_full_border.png "Full width")

<!--TODO:  Determine what is recommended instead of the custom layouts. -->

**NOTE**: Custom layouts are not recommended.
 
<a name="developing-forms-form-content"></a>
### Form Content

Form-integrated controls are the UI widgets that are compatible with forms. They can be used in a majority of forms scenarios. They automatically enable good form patterns, built-in validation, and auto-tracking of changes.

Some form-integrated controls are as follows.

<!--TODO:  Determine whether this table should still exist. -->

| Button       | Content Cell |
| ------------ | ------------ |
| Content Cell | Content Cell |

* Button

![alt-text](../media/portalfx-ux-forms/Button.png "Button" )

* Checkboxes

![alt-text](../media/portalfx-ux-forms/checkbox.png "Checkbox")

* Copy label

![alt-text](../media/portalfx-ux-forms/copy_label.png "Copy label")

* Date picker

![alt-text](../media/portalfx-ux-forms/dropdown.png "Dropdowns")

* Date - time picker

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

* Date - time range picker

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

* Day picker

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

* Dropdowns (Single-select, Multi-select, Filterable, Groupable, Tokenized)

![alt-text](../media/portalfx-ux-forms/dropdown.png "Dropdowns")

* File download

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

* File upload

![alt-text](../media/portalfx-ux-forms/placeholder-image.png "Under Construction")

<a name="developing-forms-form-topics"></a>
### Form Topics

There are a number of subtopics in the forms topic.  Sample source code is included in subtopics that discuss the various Azure SDK API items.

| API Topic             | Document              | 
| --------------------- | --------------------- | 
| Designing and Arranging the Form | [portalfx-forms-designing.md](portalfx-forms-designing.md)                 |  
| Forms Construction        | [portalfx-forms-construction.md](portalfx-forms-construction.md)      |  
| Integrating Forms with Commands          | [portalfx-forms-integrating-with-commands.md](portalfx-forms-integrating-with-commands.md)        | 
| Form Field Validation       | [portalfx-forms-field-validation.md](portalfx-forms-field-validation.md)      |  

For more information about how forms and parameters interact with an extension, see [portalfx-parameter-collection-overview.md](portalfx-parameter-collection-overview.md).

For more information about forms with editScopes, see  [portalfx-legacy-editscopes.md](portalfx-legacy-editscopes.md).

For more information about forms without editScopes, see  [portalfx-editscopeless-overview.md](portalfx-editscopeless-overview.md).