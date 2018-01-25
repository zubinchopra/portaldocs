## Development Procedures
   
The items that are being developed extend functionality to an Azure Portal, and therefore are named extensions. Perform the following tasks to become part of Azure Portal extension developer community.

1. [Review Technical Guidance](#review-technical-guidance)

1. [Network with support teams](#network-with-support-teams)

1. [Develop the extension](#develop-the-extension)

You can ask developer community questions on Stackoverflow with the tag [ibiza-onboarding](https://stackoverflow.microsoft.com/questions/tagged/ibiza-onboarding).

### Review Technical Guidance

You may want to review the following documents from the Azure Portal UI team site. These provide technical guidance for use while you are building an extension.

| Function                                      | Title and Link |
| --------------------------------------------- | -------------- |
| Guidance for Program Managers and Dev Leads   | Portal Extensions for Program Managers, located at [portalfx-extensions-forProgramManagers.md](portalfx-extensions-forProgramManagers.md) |
| Private Preview, Public Preview, and GA       | Portal Extension Development Phases, located at [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md) |
| How it Works	                                | Getting Started, located at [portalfx-howitworks.md#getting-started](portalfx-howitworks.md#getting-started)
| Build an empty extension                      | Creating An Extension, located at [portalfx-extensions-create-blank-procedure.md](portalfx-extensions-create-blank-procedure.md) |
| Portal environments and extension configurations | [portalfx-extensions-branches.md](portalfx-extensions-branches.md) | 
| Experiment with sample code	                  | Sample Extensions, located at [portalfx-extensions-samples.md](portalfx-extensions-samples.md) |

### Network with support teams 
 
1. To ensure that the business goals of the new extension or service are aligned with Azure's business strategy, please reach out to the Integrated Marketing Team or the L&R - Operations - GD&F team at [mailto:ibiza-bmr@microsoft.com?subject=Azure%20Business%20model%20review](mailto:ibiza-bmr@microsoft.com?subject=Azure%20Business%20model%20review). Brian Hillger’s team and Stacey Ellingson’s team will guide you through the business model review process. The extension or service is not ready to be onboarded to Azure until its business model has received approval from those teams. Do not proceed with the next step until the business model has received approval.

1. Schedule a UX feasibility review with the Ibiza team UX contact by emailing [mailto:ibiza-onboarding@microsoft.com?subject=Extension%20Feasibility%20Review](mailto:ibiza-onboarding@microsoft.com?subject=Extension%20Feasibility%20Review).  Many extensions have been made more successful by setting up early design reviews with the Azure Portal team. Taking the time to review the design gives extension owners an opportunity to understand how they can leverage Azure Portal design patterns, and ensure that the desired outcome is feasible. 

1. If the extension requires additional built-in support for standard Graph or ARM APIs, submit a partner request at the site located at [https://aka.ms/portalfx/uservoice](https://aka.ms/portalfx/uservoice).  For information about other components that the new service needs, see [portalfx-extensions-contacts.md](portalfx-extensions-contacts.md).

1. Start the CSS onboarding process with the CSS team at least three months previous to public preview. This process may coincide with the following step. For more information about development phases, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

### Develop the extension

1. Build the extension and sideload it for local testing. Sideloading allows the testing and debugging of the extension locally against any environment. This is the preferred method of testing. For more information about sideloading, see [portalfx-extensions-sideloading-overview.md](portalfx-extensions-sideloading-overview.md) and [portalfx-testinprod.md](portalfx-testinprod.md). 

1. Complete the development and unit testing of the extension. For more information on debugging, see [portalfx-debugging.md](portalfx-debugging.md) and [portalfx-extensions-testing-in-production.md](portalfx-extensions-testing-in-production.md).

1. Address the exit criteria to meet previous to moving the extension to the next development phase. The exit criteria are located at [top-exit-criteria.md](top-exit-criteria.md).

1. Create configuration files for the extension as specified in [portalfx-extensions-configuration-overview.md](portalfx-extensions-configuration-overview.md).