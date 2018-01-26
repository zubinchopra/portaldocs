### Register the extension

Once the name of the extension or service name is finalized, request to have the extension registered in all environments. Registering an extension in Portal requires deployment so it can take almost 10 days in the Production environment. Please plan accordingly.

* Extension names must use standard extension name format, as in the example located at [portalfx-extensions-configuration-overview.md#name](portalfx-extensions-configuration-overview.md#name).

* Extension URLs must use a standard CNAME pattern. For more information about CNAMES, see [portalfx-extensions-cnames.md](portalfx-extensions-cnames.md).

You should enable your extension in all environments, based on its progress through the development phases specified in [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

* For internal partners, the request to register an extension is a pull request, as specified in [portalfx-extensions-publishing.md](portalfx-extensions-publishing.md).
 
* External teams can submit their requests by reaching out to the <a href="mailto:ibizafxpm@microsoft.com?subject=Onboarding Request: Add <extensionName> to the Portal&body=Extension Name:  <br><br>Company:  <br><br>Brand or Suite:  <br><br>Product or Component:  <br><br> URLs: <br><br>Production: main.<extensionName>.ext.<company>.com<br><br>  Contact info: <br><br>Business Contacts <br><br> Dev leads: <br><br> PROD on-call email: <br><br>">ibizafxpm team</a>.

* After deploying the extension to the DOGFOOD (DF) environment, reach out to the <a href="mailto:ibizafxpm@microsoft.com?subject=Onboarding Request: Enable <extensionName> after DOGFOOD deployment&body=Extension Name:  <br><br>Company:  <br><br>Brand or Suite:  <br><br>Product or Component:  <br><br> URLs: <br><br>Production: main.<extensionName>.ext.<company>.com<br><br>  Contact info: <br><br>Business Contacts <br><br> Dev leads: <br><br> PROD on-call email: <br><br>">Fx team</a>  to request that they enable the extension, if applicable. Every extension meets required exit criteria / quality metrics before it will be enabled. The  extension will be enabled in production after all exit criteria have been met.