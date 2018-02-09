<a name="setting-up-for-azure-portal-development"></a>
# Setting up for Azure Portal Development

<a name="development-guide"></a>
# Development Guide

<a name="development-guide-getting-started"></a>
## Getting Started

The following procedure specifies how to set up a developer computer for Azure extension development.
   
1. Your computer should have the most recent editions of operating systems and other software installed, as specified in [top-extensions-install-software.md](top-extensions-install-software.md).

1. Build an empty extension, as specified in [portalfx-extensions-create-blank-procedure.md](portalfx-extensions-create-blank-procedure.md).

1. Build a Hello World extension, as specified in [portalfx-extensions-helloWorld.md](portalfx-extensions-helloWorld.md).

1. Samples are part of the downloaded SDK, and the  DOGFOOD (DF) environment displays working copies of the samples. Browse through the samples that are located at [top-extensions-samples.md](top-extensions-samples.md) to explore live examples of APIs.

For more information about key components of an extension, see [portalfx-extensions-key-components.md](portalfx-extensions-key-components.md).

For more information about building extensions with TypeScript decorators, watch the video that is located at [https://aka.ms/portalfx/typescriptdecorators](https://aka.ms/portalfx/typescriptdecorators).

<a name="development-guide-develop-the-extension"></a>
## Develop the extension

1. Build the extension and sideload it for local testing. Sideloading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about sideloading, see [portalfx-extensions-sideloading-overview.md](portalfx-extensions-sideloading-overview.md) and [portalfx-testinprod.md](portalfx-testinprod.md). 

1. Complete the development and unit testing of the extension. For more information on debugging, see [portalfx-debugging.md](portalfx-debugging.md) and [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).

1. Address the production-ready metrics criteria to meet previous to moving the extension to the next development phase. The production-ready metrics are located at [top-extensions-production-ready-metrics.md](top-extensions-production-ready-metrics.md).

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).


 
<a name="development-guide-glossary"></a>
## Glossary

This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

| Term              | Meaning |
| ---               | --- |
| Azure Portal SDK  | Software Development Kit for developing Azure Portal extensions. |
| CDN               | Content Delivery Network |
| IIS Express       | Internet Information Services. A Web server for hosting anything on the Web. |
| localhost         | A hostname that means this computer or this host.  |
| sideload          | The process of transferring data between two local devices, or between the development platform and the local host. Also side load, side-load. |  