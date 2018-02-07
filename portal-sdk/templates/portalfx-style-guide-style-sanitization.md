<!--TODO:  This document has been deprecated.  It has been replaced by portalfx-style-guide-overview.md -->

## Style sanitization

Custom Style Sheets (CSS) are analyzed at runtime to filter out disallowed properties or values.
This filtering  ensures a consistent and sandboxed experience in the Portal. A typical example of a disallowed style is `position: fixed;`, which allows developers to move content outside of the borders of the part that is being manipulated.

All CSS properties are allowed, with a few exceptions that are documented at the end of this article. Because the analysis is based on a [whitelist](portalfx-extensions-glossary-style-guide.md), situations may be encountered where CSS properties are erroneously filtered out. When this occurs, developers can report the issue using the `ibiza` tag on [Stack Overflow](https://stackoverflow.microsoft.com/questions/tagged/ibiza).              

The following properties only allow the specified values.

1. `position`

   `static`

   `relative`

   `absolute`

1. `text-transform`

   `none`
     
   `uppercase`
      
   `lowercase`

The following properties are sanitized out:

1. `font`

1. `font-family`

1. `list-style`

Some properties behave inconsistently across browsers, or require vendor prefixes for full support. To enable them in a supported way, use the Framework style class instead, as specified in [](). Some properties are included in the following list.

1. user-select
   
   Use Framework class `msportalfx-unselectable`
