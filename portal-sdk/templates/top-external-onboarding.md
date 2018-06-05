# Onboarding outside of Ibiza

## Overview

It is important to read this guide carefully, as we rely on you to manage the extension registration / configuration management process  in the Portal repository. External partners should also read this guide to understand the capabilities that Portal can provide for  extensions by using configuration. However, external partner requests should be submitted by sending an email to <a href="mailto:ibizafxpm@microsoft.com?subject=<Onboarding Request ID> Add <extensionName> extension to the Portal&body=Extension name: <Company>_<BrandOrSuite>_<ProductOrComponent> <br><br> URLs: <br><br> PROD:  <extensionprefix>.ext.contoso.com <br><br> Contact info: <br><br> Business Contacts:<br><br> Dev leads: <br><br> PROD on-call email: <br><br>">ibizafxpm@microsoft.com</a> instead of using the internal sites that are in this document. 

The subject of the email should contain the following.

**\<Onboarding Request ID> Add <extensionName> extension to the Portal**

where 

**Onboarding Request**: the unique identifier for the request, without the angle brackets

**extensionName**: the name of the extension

 The body of the email should contain the following information.

```json
Extension name: <Company>_<BrandOrSuite>_<ProductOrComponent>  
URLs:  (must adhere to pattern)
PROD:   <extensionprefix>.hosting.portal.azure.net
Contact info:_________
Business Contacts:_________
Dev leads: _________
PROD on-call email: _________
```

**NOTE**: The name of the extension is the same for both the PROD version and the custom deployment version, as specified in [top-extensions-custom-deployment.md](top-extensions-custom-deployment.md).  For the hosting service, the request should include the name of the extension as `<prefix>.hosting.portal.azure.net/<prefix>`, as specified in [portalfx-cdn.md#configuring-your-extension](portalfx-cdn.md#configuring-your-extension). The email may also contain the extension config file, as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).

## One Compliance System (1CS)
  
One Compliance System (1CS) is Microsoft's platform to provide a single compliance system for engineering groups across the organization. 1CS is a component of the One Engineering System, 1ES. The platform is the work of the Developer Division as a part of Visual Studio Team Services (VSTS).

  The One Compliance System (1CS) is located at [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx).

Some of the procedures such as Accessibility, GB Certificate, Privacy, and Security are also measured in the Service Health Review Scorecard that is located at [http://aka.ms/s360](http://aka.ms/s360), and in the production-ready metrics for management review and tracking. 

These requirements apply to both the Portal fx and extensions. Since Fx provides the common infrastructure and UI controls that govern the data handling and UX, hence some of the compliance work for extensions would be identical across in Ibiza, and rationally be mitigated by the Framework. For example, Accessibility support on keyboard navigation and screen reader recognition, as well as the regional format and text support to meet globalization requirements, are implemented at the controls that Framework distributed.  The same is true for Security threat modeling, extension authentication to ARM, postMessage/RPC layer and UserSettings, etc. are handled by Framework. To minimize the duplicate efforts on those items, Fx provides some level of "blueprint" documentation that can be used as a reference for compliance procedures. You are still responsible to review the tools and submit the results for approval previous to shipping the extension. 

| Policy            | Location  | Fx coverage |
| ---               | ---       | --- |
| Accessibility     | [portalfx-accessibility.md](portalfx-accessibility.md) | Generic control supports on keyboard, focus handling, touch, screen reader, high contrast, and theming |
| Global Readiness  | [portalfx-localization-globalization.md](portalfx-localization-globalization.md) | Localizability, regional format, text support, China GB standard |
| Privacy           |  [portalfx-authentication.md](portalfx-authentication.md) | User settings data handling, encryption, and authentication |
| SDL               |  [https://microsoft.sharepoint.com/ teams/QualityEssentials/SitePages/ SDL_SecurityDevelopmentLifecycleOverview.aspx](https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/SDL_SecurityDevelopmentLifecycleOverview.aspx)         | Security Development Lifecycle Threat modeling |

For more information and any questions about Fx coverage, reach out to the Fx Coverage contact that is located in [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).

## Communication
   
Plan ahead for all the outbound communication, blogging, and marketing work that publicizes new services during the time that they are being deployed to customers.  This coordination is important, particularly when software release commitments are aligned with the Azure events and conferences. This coordination may be optional for preview releases, but the localized azure.com content and service updates plan are required for stakeholder signoff, if the extension will be deployed to GA.
 
## For More Information
   
For more information about the Microsoft Azure Trust Center, see [http://azure.microsoft.com/en-us/support/trust-center/](http://azure.microsoft.com/en-us/support/trust-center/).

 For more information about quality metrics, see the One Compliance System Web site that is located at [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx).

For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). 

For more information about azure.com onboarding, see [http://acomdocs.azurewebsites.net](http://acomdocs.azurewebsites.net).

{"gitdown": "include-file", "file": "../templates/portalfx-extensions-glossary-onboarding.md"}
