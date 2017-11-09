
<a name="portalfxExtensionsArchitectureIntro"></a>
<!-- link to this document is [portalfx-extensions-architecture-intro.md]()
-->

## Introduction 

The Azure portal is a single page application which can dynamically load a collection of extensions. Extensions are simply web applications written using the Azure Portal SDK. These extensions are loaded in the Azure Portal via an IFrame. This allows extensions to load content securely in an isolated context.