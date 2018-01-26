# Azure

## Introduction

Azure Portal is a single page web application. The parts of the page in the Portal are loaded by referencing web applications, known as extensions, that are dynamically accessed based on a customer’s action on the Portal. For example, when a customer clicks on virtual machine icon then the Portal will automatically load Virtual Machine management extension. 

Partners can instantaneously gain access to Azure Portal’s large customer base by developing and registering extensions that provide unified and consistent look and feel.  

The success of Azure Portal is dependent on the success of our partners. For our partners to succeed we provide them access to necessary tools and an ecosystem where they can seek help and collaborate. 

**Extension developers** can leverage Azure Portal SDK and extension hosting service to rapidly develop and ship extensions. Also, Azure Portal has a strong developer community to help you build the extensions. 

**Program / Product Managers** can gather deeper understanding of extension’s health and customer behavior using the Power BI reports and Kusto telemetry. 

### Azure Portal Library

This repository contains the documents that specify how to interact with Azure portal development.  This includes how to onboard an organization that wants to build extensions, how to develop the extensions, where to find sample code, and other topics. Developers can increase their knowledge of extensions, publish them for world use, and interact with other developers through Stackoverflow and other support forums. 

Developers can locate information through the gitHub link located at [https://github.com/Azure/portaldocs/tree/master/portal-sdk/generated](https://github.com/Azure/portaldocs/tree/master/portal-sdk/generated) or through the index located at [portalfx.md](./generated/portalfx.md). THey may also use links to individual topics or subtopics as appropriate.

### Topic Naming Convention

The naming convention for all topics can assist individuals who would rather navigate via GitHub than through a menu. It is as follows.
* All topics use 'portalfx' in the first node of the name.
* Major areas use a different second node, for example, 'extensions', 'style', or 'parameters'. 
* All related docs have the same name prefix.  The last node is the one that best describes the topic name.  
* The document whose name ends with the topic name, the one without a suffix is the main topic doc.  
* All subtopics are displayed in the topic doc in a meaningful order. 
* Any subtopic that could be included in several topics does not include the topic name.  For example, [portalfx-extensions-qualityEssentials.md](./generated/portalfx-extensions-qualityEssentials.md) or [portalfx-extensions-contacts.md](./generated/portalfx-extensions-contacts.md) are both included in the portalfx-extensions-onboarding topic, but are not specific to onboarding, therefore  "onboarding" is omitted from the name.

The exceptions to this naming convention are the Best Practices, FAQ, and glossary documents, which have 'bp' 'faq', and 'glossary' in their names, just previous to the node that describes the topic name. This allows them to sort together in an index instead of with the topic.

### Topic Organization
 
The Azure documents are modularized, using the naming conventions in [#topic-naming-convention](#topic-naming-convention), in a way that assists navigation. For example, the [portalfx-extensions-flags.md](./generated/portalfx-extensions-flags.md) document is comprised of the following subtopics.

| File Name                              | Comments | 
| -------------------------------------- | -------- | 
| [portalfx-extensions-flags.md](./generated/portalfx-extensions-flags.md) | Topic document.  GitHub uses this to generate the full topic.  | 
| [portalfx-extensions-flags-overview.md](./generated/portalfx-extensions-flags-overview.md) | Required. First document in the topic.  General description of topic. |
| [portalfx-extensions-flags-trace.md](./generated/portalfx-extensions-flags-trace.md) | Subtopic. Worth its own link, which is easier than relying on GitHub navigation. |
| [portalfx-extensions-flags-extension.md](./generated/portalfx-extensions-flags-extension.md) | Subtopic. Final node describes the subtopic within the topic. |
| [portalfx-extensions-flags-shell.md](./generated/portalfx-extensions-flags-shell.md)      | Subtopic. |
| [portalfx-extensions-flags-glossary.md](./generated/portalfx-extensions-flags-glossary.md)  | Required document. It contains any term used within the context of the topic that is not a common English term, not a common computing term, as specified in sources like [https://techterms.com/](https://techterms.com/). Acronyms may be expanded in the glossary, with or without a definition of term.   |

Other subtopics are most easily located when they use the following subtopic naming nodes, regardless of major area or topic.

| Node         | Purpose                               | Example | 
| ------------ | ------------------------------------- | ------- | 
| advanced     | For larger or more complex extensions | [portalfx-extensions-hosting-service-advanced.md](./generated/portalfx-extensions-hosting-service-advanced.md)   |
| procedure(s) | Checklist                             | [portalfx-extensions-developerInit-procedure.md](./generated/portalfx-extensions-developerInit-procedure.md) |
| fyi          | For Your Information.  Relevant links  which were not used inline within the context of the topic. | [portalfx-extensions-debugging-fyi.md](./generated/portalfx-extensions-debugging-fyi.md) |

### GitHub Navigation

GitHub performs its own linking when documents are generated or are displayed in a browser.  This may cause navigating with hyperlinks to be somewhat confusing.  For example, the [portalfx-extensions-flags.md](./generated/portalfx-extensions-flags.md) document is comprised of the following subtopics.

| File Name                              | Comments | 
| -------------------------------------- | -------- | 
| [portalfx-extensions-flags.md](./generated/portalfx-extensions-flags.md)            | Topic document.  GitHub uses this to generate the full topic.  | 
| [portalfx-extensions-flags-overview.md](./generated/portalfx-extensions-flags-overview.md)   | Required document.  General description of topic. |
| [portalfx-extensions-flags-trace.md](./generated/portalfx-extensions-flags-trace.md)   | Subtopic. Worth its own link, which is easier than relying on GitHub navigation. |
| [portalfx-extensions-flags-extension.md](./generated/portalfx-extensions-flags-extension.md) | Subtopic. |
| [portalfx-extensions-flags-shell.md](./generated/portalfx-extensions-flags-shell.md])     | Subtopic. |
| [portalfx-extensions-flags-glossary.md](./generated/portalfx-extensions-flags-glossary.md)   | Required document. It contains any term used within the context of the topic that is not a common English term, not a common computing term, as specified in sources like [https://techterms.com/](https://techterms.com/). Acronyms may be expanded in the glossary, with or without a definition of term.   |

The following images describe what happens to the link, based on the amount of the topic document that  GitHub is displaying.
1. When the [portalfx-extensions-flags.md](./generated/portalfx-extensions-flags.md) document is selected from the gitHub index, and the reader scrolls down, the [portalfx-extensions-flags-extension.md](./generated/portalfx-extensions-flags-extension.md) subtopic is displayed with the following information in the address bar.

    ![alt-text](./media/portalfx/github-topic.png "Topic selected from gitHub index")

1. When the mouse hovers next to or on the subtopic header, the following icon is displayed to the left of the subtopic name.

    ![alt-text](./media/portalfx/github-link.png "Link icon")

1. When the link icon is clicked, GitHub switches to the subtopic document with the following information in the address bar.

    ![alt-text](./media/portalfx/github-subtopic-from-topic.png "Subtopic selected from previous document")

    **NOTE**: The link that points to the document is different from the link that is displayed when the subtopic is selected from the GitHub index, as in the following example.

    ![alt-text](./media/portalfx/github-subtopic-from-github.png "Subtopic selected from gitHub index")

Azure developers will become familiar with the difference in links as they navigate through GitHub using the main index, the GitHub index, and the links in the topics.

## Code of Conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.