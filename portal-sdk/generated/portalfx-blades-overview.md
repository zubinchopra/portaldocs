
<a name="overview"></a>
## Overview

Blades are the main UI container in the Portal. They are equivalent to `windows` or `pages` in other UX frameworks.      A blade typically takes up the full screen, has a presence in the Portal breadcrumb, and has an 'X' button to close it. The `TemplateBlade` is the recommended development model, which typically contains an import statement, an HTML template for the UI, and  ViewModel that contains the logic that binds to the HTML template. However, some previous development models are still supported.

The following is a list of different types of blades.

| Type                          | Document                                                       | Description |
| ----------------------------- | ---- | ---- |
| TemplateBlade                 | [portalfx-blades-procedure.md](portalfx-blades-procedure.md)   | Creating any Portal blade. This is the main and recommended authoring model for UI in the Portal. | 
| The Blade ViewModel           | [portalfx-blades-viewmodel.md](portalfx-blades-viewmodel.md)   |  The `ViewModel` that associates data that is retrieved from the server with the blade and its controls. |
| Advanced TemplateBlade Topics | [portalfx-blades-advanced.md](portalfx-blades-advanced.md)     | Advanced topics in template blade development.                                                    | 
| MenuBlade                     | [portalfx-blades-menublade.md](portalfx-blades-menublade.md)   | Displays a vertical menu at the left of a blade.                                                  |  
| Blade Kinds                   | [portalfx-blades-bladeKinds.md](portalfx-blades-bladeKinds.md) | A set of built-in blades that encapsulate common patterns.                                        | 
| Blade Settings                | [portalfx-blades-settings.md](portalfx-blades-settings.md)   | Framework settings that allow extensions to opt in or out of interaction patterns.                  | 
| AppBlade                      | [portalfx-blades-appblades.md](portalfx-blades-appblades.md)   | Provides an IFrame to host the UI.                                                                | 
| Blade with tiles              | [portalfx-blades-legacy.md](portalfx-blades-legacy.md)         |  Legacy authoring model. Given its complexity, you may want to use TemplateBlades instead. | | 
| Sample Extensions with Blades | [portalfx-extensions-samples-blades.md](portalfx-extensions-samples-blades.md) |  SDK Samples that demonstrate how to develop extensions with different templates.  | | 

