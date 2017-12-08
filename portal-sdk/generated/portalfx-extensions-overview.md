<a name="introduction"></a>
## Introduction

Welcome to the Azure portal! We're excited to have you to join the family. The Azure Portal UI team supports Ibiza and the Portal Framework, and can help you with onboarding a service into the Management UI in the Azure portal.

<a name="overview"></a>
## Overview

The user experience for services that are visible in the Azure Portal are named extensions and blades, or context panes.  Some examples of context panes are in the following image.

![alt-text](../media/portalfx-create/plus-new.png  "Extensions and Context Panes")

Onboarding a service, or developing a portal extension, has three phases: private preview, public preview, and Global Availability (GA). 

Most services that onboard to Azure can leverage the following components of the Azure ecosystem:
1. Management APIs that are exposed via Azure Resource Manager (ARM) or Microsoft Graph
1. Management UI in the Azure portal and/or other tools/websites, like Visual Studio
1. Marketing content on the Azure Web site or other websites

The Azure onboarding process is streamlined to optimize the delivery of high quality experiences based on hundreds of hours of usability testing that meet Microsoft Common Engineering Criteria (CEC) and compliance requirements. Do not start designing UI or management APIs until after the onboarding process begins, to ensure the latest patterns and practices are being followed. This will better optimize developer resources and reduce re-working due to anti-patterns and inconsistencies that block usability, performance, and other factors.

The Azure Fundamentals are a set of Tenets each Azure service is expected to adhere to. The Azure Fundamentals program is described in this document [Azure Fundamentals](https://microsoft.sharepoint.com/:w:/r/teams/WAG/EngSys/_layouts/15/Doc.aspx?sourcedoc=%7BF5B821BC-31C4-4042-ADB5-5EBF4D8B408D%7D&file=Azure%20Fundamentals%20Proposal.docx&action=edit&mobileredirect=true). The document also identifies the stakeholders and contacts for each of the Tenets.

The Azure Fundamentals document is located at [https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d](https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d).

Compliance criteria and practices are defined in Quality Essentials throughout the development cycle. These ensure that services meet the Trusted Cloud commitments outlined in the Microsoft Azure Trust Center for our customers. These are required procedures for preview and Global Availability, and are to be revisited for every release cycle.

The customer has a different set of expectations for the extension in each phase. To meet customer expectations, we have compiled exit criteria for each phase. The development of an extension  can proceed to the next step when it meets the exit criteria for the current step. To meet customer expectations and continue to increase customer satisfaction, several quality metrics are tracked for every extension by the Get1CS team. An overview of Quality Essentials is located at [https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx](https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx). There may be tools to install from thr QE and 1CS sites that are part of the Quality Essentials process. The Azure team only tracks the exit criteria and localization requirements.

Nearly 70% of Azure users are from outside of the United States. Therefore, it is important to make Azure a globalized product. There are a few internationalization requirements that the extension or service is required to support. This is the same set of languages that are supported by Azure Portal for GA.

<a name="for-more-information"></a>
## For More Information

For more information about development phases, see [portalfx-extensions-developmentPhases.md](portalfx-extensions-developmentPhases.md).

For more information about Azure Fundamentals, see [https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d](https://microsoft.sharepoint.com/teams/WAG/EngSys/Shared%20Documents/Argon/Azure%20Fundamentals%20Proposal/Azure%20Fundamentals%20Proposal.docx?d=wf5b821bc31c44042adb55ebf4d8b408d).

For more information about the Microsoft Azure Trust Center, see [http://azure.microsoft.com/en-us/support/trust-center/](http://azure.microsoft.com/en-us/support/trust-center/).

For more information about exit criteria, see [portalfx-extensions-exitCriteria.md](portalfx-extensions-exitCriteria.md).

For more information about Quality Essentials, see [https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx](https://microsoft.sharepoint.com/teams/QualityEssentials/SitePages/GettingStarted.aspx).

 For more information about quality metrics, see the One Compliance System Web site that is located at [https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx](https://microsoft.sharepoint.com/teams/1CS/SitePages/Home.aspx).

For more information about internationalization requirements, see [http://aka.ms/azureintlrequirements](http://aka.ms/azureintlrequirements). 

For more information about localization requirements, see [portalfx-localization.md](portalfx-localization.md). 

For more information about azure.com onboarding, see [http://acomdocs.azurewebsites.net](http://acomdocs.azurewebsites.net).
