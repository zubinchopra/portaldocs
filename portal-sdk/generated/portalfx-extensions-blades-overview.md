
<a name="overview"></a>
## Overview

Blades are the main UI container in the Portal. They are equivalent to `windows` or `pages` in other UX frameworks.   A blade typically generally takes up the full screen, has a presence in the portal breadcrumb, and has an 'X' button to close it.
 The following is a list of different types of blades.

| Type | Document    | Description |
| ---- | ----------- | ----------- | 
| TemplateBlade | [portalfx-extensions-blades-procedure.md](portalfx-extensions-blades-procedure.md) | Creating any Portal blade. This is the main and recommended authoring model for UI in the Portal. It uses an HTML template for the UI, and a ViewModel with the logic that binds to that HTML template. | 
| Advanced TemplateBlade Topics | [portalfx-extensions-blades-advanced.md](portalfx-extensions-blades-advanced.md) | Creating any Portal blade. This is the main and recommended authoring model for UI in the Portal. It uses an HTML template for the UI, and a ViewModel with the logic that binds to that HTML template. | 
| MenuBlade | [portalfx-blades-menublade.md](portalfx-blades-menublade.md) | Left side vertical menu. Displays a menu at the left of a blade. This blade gets combined by the Shell with the blade that its opened at its right.|  
| Fx Blades |  [portalfx-blades-bladeKinds.md](portalfx-blades-bladeKinds.md) | A limited set of built-in blades that encapsulate common patterns, like properties, quick start, or create forms. | 
| AppBlade | [portalfx-blades-appblades.md](portalfx-blades-appblades.md) | Rehosts an existing experience, or creates a UI that is  not supported by the Fx. It provides an IFrame to host the UI in order to enable full flexibility and control. Does not use Ibiza Fx controls, and extension developers are fully responsible for accessibility, theming, and consistency. | 
| Blade with tiles |[portalfx-blades-legacy.md](portalfx-blades-legacy.md) |  Legacy authoring model that uses a combination of lenses and parts. Given the complexity associated with this model, we are encouraging authors to use TemplateBlades instead. | 
