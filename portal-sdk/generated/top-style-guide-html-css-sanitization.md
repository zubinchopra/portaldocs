
<a name="overview"></a>
## Overview

Extension writers provide their own HTML templates and associated Cascading Style Sheets (CSS) to render and style their experiences. Those files are analyzed at runtime to filter out disallowed HTML tags, attribute names, attribute values, CSS properties, or CSS property values that are known to have potential negative impact on the Portal. This filtering ensures a consistent and sandboxed experience in the Portal. Similar sanitization is also applied to SVG markup provided from the extension.

The sanitization philosophy is to allow as much CSS as possible for the extension to use based on a  [whitelist](portalfx-extensions-glossary-style-guide.md). As such, developers may encounter items filtered out that are not mentioned in this document. Should this occur,  developers should report the issue by using the  [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza) tag on Stack Overflow.

For more information, see [portalfx-stackoverflow.md](portalfx-stackoverflow.md).

The criteria that determine whether a css or an html element might have a negative impact on an extension are as follows.

1. Usage allows an element to escape the tile or blade container boundaries
1. Usage significantly impacts browser performance during  layout or repainting
1. Usage can be exploited as a possible security threat
1. Usage is non-standard across IE11, Microsoft Edge, Chrome, Firefox, or Safari.
1. Usage resets defaults font-family branding that is enforced for typographic consistency.
1. Usage assigns or relies on unique identifiers. Identifier allocation is reserved in the Portal for accessibility purposes.

<a name="html-sanitization"></a>
## HTML sanitization

HTML sanitization is divided between HTML tags and their attributes.

<a name="html-sanitization-html-tags"></a>
### HTML tags

The `iframe` tag is not allowed based on criterion 3.

<a name="html-sanitization-html-attributes"></a>
### HTML attributes

The `id` attribute is not allowed based on criterion 6.

<a name="html-sanitization-attribute-data-bind-sanitization"></a>
### Attribute data-bind sanitization

The `data-bind` value is sanitized to allow simple binding and logics, but no complex JavaScript is allowed.

<a name="html-sanitization-css-sanitization"></a>
### CSS sanitization

All CSS properties are allowed, with a few exceptions based on the criteria listed previously. The following properties are sanitized as described.

| Property | Criterion | Reason |
| -------- | --------- | ------- |
| position | Criterion 1 |  Only a subset of the possible values are allowed: static, relative, absolute |
| font | Criterion 5 |  Disallowed. Instead use expanded properties, like font-size, font-style, etc. |
| font-family |Criterion 5 |  Disallowed. Instead, use the portal classes that assign font-family: msportalfx-font-regular, msportalfx-font-bold, msportalfx-font-semibold, msportalfx-font-light, msportalfx-font-monospace |
| list-style | Criterion 3 |  Disallowed. Use expanded properties instead of the shorthand (list-style-type, etc) |
| user-select | Criterion 4 |  Disallowed. Use Framework class msportalfx-unselectable to achieve the same result. |

CSS media queries are not supported, and are filtered out. The most common scenario for media queries is responding to container size. Extensions support this feature by subscribing to the container ViewModel tile size property as specified  in [portalfx-no-pdl-programming.md](portalfx-no-pdl-programming.md), [top-legacy-parts.mdd](top-legacy-parts.md), and [top-extensions-forms.md](top-extensions-forms.md).

<a name="svg-sanitization"></a>
## SVG sanitization

SVG sanitization follows the rules applied to HTML sanitization, as they are both DOM structures. Before using SVGs directly in the Portal, convert them first using the build tools that are located at []().

Some SVG functionality, like certain filters, and gradients, are known to cause significant browser rendering slowdowns, as specified in Criterion 2.  As such, they are sanitized out. The build tools should detect those early and mitigate them when possible. Extension writers should rely on  [StackOverflow](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza) if the sanitization of SVG elements causes a blocking issue.

For more information about SVG sanitization, see [top-style-guide-iconography.md](top-style-guide-iconography.md).