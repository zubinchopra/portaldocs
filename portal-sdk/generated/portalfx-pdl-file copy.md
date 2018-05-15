
<a name="basic-format-of-a-shared-blade"></a>
## Basic format of a shared blade

The PDL file contains the definition of the template blade. The following example contains a typical PDL file.

    ```xml
    <TemplateBlade
                Name="MyTemplateBlade"
                ViewModel="{ ViewModel Name=MyTemplateBladeViewModel, Module=./ViewModels/MyTemplateBladeViewModel }"
                InitialDisplayState="Maximized"
                Template="{ Html Source='Templates\\MyTemplateBlade.html' }">
    </TemplateBlade>
    ```
There are several options that are located in the PDL file. The following is a list of the most relevant parameters.

**Name**: Name of the blade. This name is used later to refer to this blade. 

**ViewModel**: Required field.  The ViewModel that is associated with this blade. 

**Template**: Required field.  The HTML template for the blade. 

**Size**: Optional field. The width of the blade. The default value is `Medium`. 

**InitialDisplayState**: Optional field.  Specifies whether the blade is opened maximized or not. The default value is `Normal`. 

**Style**: Optional field. Visual style for the blade. The default value is `Basic`. 

**Pinnable**: Optional field. Specifies whether the blade can be pinned or not. The default value is `false`.

**ParameterProvider**: Optional field. Specifies whether the blade provides parameters to other blades within the extension.   The default value is  `false`.

**Export**: Optional field.  Specifies whether this blade is exported from your extension and to be opened by other extensions. If this field is `true`, a strongly typed blade reference is created. 