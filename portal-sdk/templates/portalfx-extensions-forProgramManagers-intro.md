<a name="portalfxExtensionsForProgramManagersIntro"></a>
<!-- link to this document is [portalfx-extensions-forProgramManagers-intro.md]()
-->

## Audience

This document is intended for Developer Leads and Project Managers whose teams will be interacting with the Azure Portal and its teams.


## Introduction

Welcome to the Azure portal! We're excited to have you to join the family.

The Azure Portal UI team supports Ibiza and the Portal Framework, and can help you with onboarding a service into the Management UI in the Azure portal.

Onboarding a service, or developing a portal extension, has three phases: private preview, public preview, and GA.  The development of a portal can stop at any one of those steps, depending on content.  A portal can also proceed to the next step when it meets the exit criteria for the current step. These phases are discussed in the sections named Private Preview, Public Preview, and GA. 

Most services that onboard Azure need to use the following three components:
* Marketing content on the Azure Web site or other websites
* Management APIs that are exposed via Azure Resource Manager (ARM) or Microsoft Graph
* Management UI in the Azure portal and/or other tools/websites, like Visual Studio

The Azure onboarding process is streamlined to optimize the delivery of high quality experiences based on hundreds of hours of usability testing that meet Microsoft Common Engineering Criteria (CEC) and compliance requirements. to ensure you're following the latest patterns and practices, Do not start designing UI or management APIs until after you've started the onboarding process. This will better optimize your time and reduce re-working due to anti-patterns and inconsistencies that block usability, performance, and other factors.

The Azure Fundamentals are a set of Tenets each Azure service is expected to adhere to. The Azure Fundamentals program is described in this document 
[Azure Fundamentals](https://microsoft.sharepoint.com/:w:/r/teams/WAG/EngSys/_layouts/15/Doc.aspx?sourcedoc=%7BF5B821BC-31C4-4042-ADB5-5EBF4D8B408D%7D&file=Azure%20Fundamentals%20Proposal.docx&action=edit&mobileredirect=true). The document also identifies the Stakeholders and contacts for each of the Tenets.

Compliance criteria and practices are defined in [Quality Essentials](https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx) throughout our development cycle. These ensure services meet the Trusted Cloud commitments outlined in the [Microsoft Azure Trust Center](http://azure.microsoft.com/en-us/support/trust-center/) for our customers. These are mandatory procedures as Preview and GA requirement, and to be revisited for every release cycle. 

To meet customer expectations and continue to increase customer satisfaction, several quality metrics are tracked for every extension.

Nearly 70% of Azure users are from outside of the United States. Therefore, it is important to make Azure a globalized product. There are a few Internationalization requirements that your service is required to support. This is the same set of languages that are supported by Azure Portal for GA. For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). 

1. [Glossary](portalfx-extensions-forProgramManagers-glossary.md)

1. [References](portalfx-extensions-forProgramManagers-references.md)