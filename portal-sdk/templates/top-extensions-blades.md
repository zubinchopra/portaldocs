
# Blades 

## Overview

Blades are the main UI container in the Portal. They are equivalent to `windows` or `pages` in other UX frameworks.  A blade typically takes up the full screen, has a presence in the Portal breadcrumb, and has an 'X' button to close it. The `TemplateBlade` is the recommended development model, which typically contains an import statement, an HTML template for the UI, and a ViewModel that contains the logic that binds to the HTML template. However, a few other development models are supported.     

The following is a list of different types of blades.

| Type                          | Document           | Description |
| ----------------------------- | ---- | ---- |
| TemplateBlade                 | [top-blades-procedure.md](top-blades-procedure.md) | Creating any Portal blade. This is the main and recommended authoring model for UI in the Portal. |
| MenuBlade                     | [top-blades-menublade.md](top-blades-menublade.md)   | Displays a vertical menu at the left of a blade.                                       |  
| Resource MenuBlade       |   [top-blades-resourcemenu.md](top-blades-resourcemenu.md)  | A specialized version of MenuBlade that adds support for standard Azure resource features.  | 
| FrameBlade/AppBlade       | [top-blades-frameblades.md](top-blades-frameblades.md)   | Provides an IFrame to host the UI. Be advised that if you go this route you get great power and responsibility. You will own the DOM, which means you can build any UI you can dream up. You cannot use Ibiza controls meaning you will have an increased responsibility in terms of accessibility, consistency, and theming.  |
| Blade with tiles              | [top-blades-legacy.md](top-blades-legacy.md)         |  Legacy authoring model. Given its complexity, you may want to use TemplateBlades instead. | | 

 {"gitdown": "include-file", "file": "portalfx-extensions-bp-blades.md"}

 {"gitdown": "include-file", "file": "portalfx-extensions-faq-blades.md"}

 {"gitdown": "include-file", "file": "portalfx-extensions-glossary-blades.md"}
