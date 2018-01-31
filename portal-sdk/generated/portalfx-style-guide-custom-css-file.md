
<a name="custom-css-files"></a>
## Custom CSS files

Extension developers can combine commonly used classes into a CSS file. CSS styles that are defined in stylesheets are [sanitized](portalfx-extensions-glossary-style-guide.md) using the same rules as the style attribute (see below). All custom class names begin with the `.ext-` prefix that identifies them as classes that are owned by the extension. 

All developers who install the Portal Framework SDK that is located at [http://aka.ms/portalfx/download](http://aka.ms/portalfx/download) also install the samples on their computers during the installation process. The source for the samples is located in the `Documents\PortalSDK\FrameworkPortal\Extensions\SamplesExtension` folder.

In this discussion, `<dir>` is the `SamplesExtension\Extension\` directory and  `<dirParent>` is the `SamplesExtension\` directory, based on where the samples were installed when the developer set up the SDK. Links to the Dogfood environment are working copies of the samples that were made available with the SDK.

To specify custom styles, add a new CSS file to your extension, as in the sample located at `<dir>\Client\V1\Parts\Custom\Styles\ExampleStyles.css`. This code is also included in the following example.

```css
.ext-too-many-clicks-box {
    color: red;
    border: 2px dotted red;
    padding: 8px;
    text-align: center;
}
```

CSS files can then be referenced from any PDL file, inside of the `Definition` element, as in the  sample located at `<dir>\Client\V1\Parts\Custom\CustomParts.pdl`. This code is also included in the following example.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<Definition xmlns="http://schemas.microsoft.com/aux/2013/pdl" Area="Parts">
  <!--
    The following sample demonstrates the use of custom parts. Custom parts
    supply HTML templates and can be styled with custom style sheets.
  -->
  <StyleSheet Source="{Css Source='Styles\\ExampleStyles.css'}" />
  ...
</Definition>
```

The styles that are included in the CSS file can now be used inside HTML templates, as in the  sample located at `<dir>\Client\V1\Parts\Custom\Templates\ExampleCustomPart.html`.

```html
<div class="ext-too-many-clicks-box" data-bind="visible: !allowMoreClicks()">
    That's too many clicks!
    <button data-bind="click: resetClickCount">Reset</button>
</div>
```
