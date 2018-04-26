
<a name="icons"></a>
# Icons


The page you requested has moved to [top-extensions-style-guide.md](top-extensions-style-guide.md). 


<a name="icons-best-practices"></a>
## Best Practices

<a name="icons-best-practices-general-best-practices"></a>
### General Best Practices

Do not use JavaScript reserved words, as specified in [https://docs.microsoft.com/en-us/scripting/javascript/reference/javascript-reserved-words](https://docs.microsoft.com/en-us/scripting/javascript/reference/javascript-reserved-words), as names for the icons in your extension.



<a name="icons-best-practices-icon-incorrectly-displayed"></a>
### Icon incorrectly displayed

***My icon is black!?!***

DESCRIPTION:

The extension  probably circumvents the  icon pre-processing which happens at build time. This pre-processing  prepares the icon to pass the  html sanitizer, which may be why it appears to be black.  The pre-procesor also minifies it, and prepares the icon to react to different themes. 

**NOTE**: The icon may display incorrectly if it is served by using **json**.

SOLUTION: 

Include the icon in your project normally. Build and  look at the generated file.  Find and copy the  fresh sanitized svg markup, and replace it.

* * *
 
<a name="icons-best-practices-"></a>
### 

SOLUTION:

* * *


<a name="icons-glossary"></a>
## Glossary

 This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term                 | Meaning |
| ---                  | --- |

