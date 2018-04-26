
### Icon incorrectly displayed 

***My icon is black!?!***

DESCRIPTION:

The extension  probably circumvents the  icon pre-processing which happens at build time. This pre-processing  prepares the icon to pass the  html sanitizer, which may be why it appears to be black.  The pre-procesor also minifies it, and prepares the icon to react to different themes. 

**NOTE**: The icon may display incorrectly if it is served by using **json**.

SOLUTION: 

Include the icon in your project normally. Build and  look at the generated file.  Find and copy the  fresh sanitized svg markup, and replace it.

* * *
 
###

SOLUTION:

* * *