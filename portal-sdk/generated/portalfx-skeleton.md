<a name="skeleton"></a>
# Skeleton

This document contains the skeleton for authoring Azure documents that are stored in gitHub.

<!-- topic name is a level 1 header at the beginning of the doc-->

GitHub files that should be included based on the topic-subtopic relationship are linked to in this document using gitHub.  Because this is a sample document, all gitHub commands are slightly malformed.  To use this skeleton to create a new topic, fill in the parameters that are designated with angle brackets, and then enclose the gitHub command in curly brackets. Remember that the command "gitdown" is at the beginning of the line and is enclosed in double quotes.

<!--  required Overview MARKDOWN document.  -->
<!--                                   "../templates/portalfx-==major-area==-overview.md" -->
   ## Skeleton Overview
<!-- topic name is a level 2 at the beginning of the doc>

<!--  required document.  -->

This document describes the topic at a general level.  If portions of the topic lend itself to further discussion, a subtopic document is a good idea. If so, the subtopics are not included in this document; instead, they are included in the overarching document that contains a gitHub link to this overview.  This method reduces gitHub commands to one document per topic.

Subtopic documents can authored along the same lines.

<!-- A list of documents that might be linked to as a part of the discussion of the topic are as follows.
There documents do not have a major area.

portalfx-extensions-branches.md
portalfx-extensions-cnames.md
portalfx-extensions-contacts.md
portalfx-extensions-developmentPhases.md
portalfx-extensions-exitCriteria.md
portalfx-extensions-publishing.md
portalfx-extensions-qualityEssentials.md
portalfx-extensions-stackoverflow.md
portalfx-extensions-status-codes.md
-->

<!--  optional subtopic documents. Use these when the topic goes deeper than an overview. The overview may contain a table that links to these sections, in addition to (or instead of) relying on the following gitHub includes. -->
<!--                                  "../templates/portalfx-==major-area==-==topic==-==subtopic1==.md"  -->
<!--                                  "../templates/portalfx-==major-area==-==topic==-==subtopic2==.md"  -->

<!--  optional checklist document. Use this when there are specific steps to follow, or when there are specific tasks that the developer must verify as being completed. 
                                    "../templates/portalfx-==major-area==-==topic==-procedures.md"  -->
<a name="skeleton-skeleton-procedure"></a>
## Skeleton Procedure
<!-- topic name is a level 2 at the beginning of the doc>

<!--  required document.  -->

This document describes procedures or checklists that are associated with a topic.  These are the types of items that must all be completed, sometimes in a specific order, in order to accomplish a specific developer task.

For the most part, procedures do not include phrases like "as specified in. . ."; references to other topics should have been included in the main topic, or in the overarching document that contains all of the gitHub links.

<a name="skeleton-name-of-process"></a>
## Name of Process

This process validates that [state purpose of checklist]. Include images as appropriate, as in the following diagram.

   ![alt-text](../media/partner-request-flow.png "New Project Dialog")

1. Step 1 of procedure

   If possible, make screenshots that include what the screen should look like, or the changes that the developer should make, as in the following image.
    
    ![alt-text](../media/portalfx-overview/new-project-template.png "Step Validation")

1. Step 2 of procedure

1. Step 3 of procedure, and so on until the entire procedure or checklist is specified.

1. Optional.  A compliment that indicates that the procedure is complete.


  
<!--  optional Best Practices document
                                    "../templates/portalfx-==major-area==-bp-==topic==.md"  -->

<a name="skeleton-best-practices"></a>
## Best Practices
<!-- Title is required, as a level 2 heading.  If appropriate, the phrase ' for <topic>' can be appended. -->

Best practices often result in improved performance, smaller software footprint, increased reusability, or similar factors. Some practices are documented in industry practice, like the ***Testing Computer Software*** textbook that is located at [https://www.researchgate.net/publication/220689439_Testing_computer_software_2_ed](https://www.researchgate.net/publication/220689439_Testing_computer_software_2_ed). Although Stackoverflow contains good ideas, it is a forum centered more around answering questions than providing best practices.

This document contains best practices, that are related to the topic whose name is a node in the filename. These practices did not fit in the overview discussion of the topic or subtopic, for whatever reasons. They also did not belong in a procedure document for the topic. If there are no best practices for a topic, this optional  document can be added when appropriate.

In the discussion, mention why these practices are considered best practices, or are good practice for the industry or within software development.  If some of these practices are results of usability studies, a sentence like the following is appropriate.

"This section also includes practices that are recommended based on customer feedback and usability studies."

Descriptions that are in other ***Best Practices*** documents should not be copied into this document.  Instead, summarize the procedure here and use a link to the content that is in the other document. These links are usually called out with the phrase "For more information, see . . . " and are the last sentence in the section.  

For more information, see [portalfx-extensions-bp-debugging.md](portalfx-extensions-bp-debugging.md).

* * * 

<a name="skeleton-best-practices-best-practice-description"></a>
### Best Practice Description

The title of the practice should be less than about five words long. The titles, which are level 3 headings in HTML, do not need to be numbered.

The description or procedure should be no more than about 5 paragraphs long, where a paragraph is no less than 4 sentences.

Each best practice section ends with three asterisks, as in '* * *' to include a dividing line between topics.

* * * 

<a name="skeleton-best-practices-best-practice-example"></a>
### Best Practice Example

<a name="skeleton-best-practices-onebox-stb-has-been-deprecated"></a>
### Onebox-stb has been deprecated

Onebox-stb is no longer available. Please do not use it. Instead, migrate extensions to sideloading. For more information about sideloading, see [portalfx-extensions-testing-in-production-overview.md#sideloading](portalfx-extensions-testing-in-production-overview.md#sideloading). For help on migration, send an email to [ibiza-onboarding@microsoft.com](mailto:ibiza-onboarding@microsoft.com).

* * * 


<!--  optional FAQ document
                                    "../templates/portalfx-==major-area==-faq-==topic==.md"  -->
<a name="skeleton-frequently-asked-questions-for-authoring-azure-documents"></a>
## Frequently asked questions for Authoring Azure Documents
<!-- Title is required, as a level 2 heading.  If appropriate, the phrase ' for <topic>' can be appended. -->

FAQ's are items that are encountered many times, and developer teams appreciate the opportunity to answer the question only once and then refer individuals to this best answer.

Best practices often result in improved performance, smaller software footprint, increased reusability, or similar factors. Some practices are documented in industry practice, like the ***Testing Computer Software*** textbook that is located at [https://www.researchgate.net/publication/220689439_Testing_computer_software_2_ed](https://www.researchgate.net/publication/220689439_Testing_computer_software_2_ed). Although Stackoverflow contains good ideas, it is a forum centered more around answering questions than providing best practices.

This document contains best practices, that are related to the topic whose name is a node in the filename. These practices did not fit in the overview discussion of the topic or subtopic, for whatever reasons. They also did not belong in a procedure document for the topic. If there are no best practices for a topic, this optional  document can be added when appropriate.

In the discussion, mention why these practices are considered best practices, or are good practice for the industry or within software development.  If some of these practices are results of usability studies, a sentence like the following is appropriate.

"This section also includes practices that are recommended based on customer feedback and usability studies."

Descriptions that are in other ***Best Practices*** documents should not be copied into this document.  Instead, summarize the procedure here and use a link to the content that is in the other document. These links are usually called out with the phrase "For more information, see . . . " and are the last sentence in the section.  



The format for a FAQ item is 
*  ###Link
*  ***title***
*  Description
* The word "SOLUTION:" followed by the Solution
*  3 Asterisks 
   

   ### SAS Tokens

***Can I provide a SAS token instead of keyvault for EV2 to access the storage account ?***

The current rolloutspec generated by **ContentUnbundler** only provides support for using keyvault. If you would like to use SAS tokens, please submit a request on [user voice](https:\\aka.ms\portalfx\uservoice)

* * *

***When will support for friendly names become available ?***

Azure support for friendly names became available in SDK release 5.0.302.834.

* * *

<a name="skeleton-frequently-asked-questions-for-authoring-azure-documents-ssl-certificates"></a>
### SSL certificates

***How do I use SSL certs?***

[portalfx-extensions-faq-onboarding.md#sslCerts](portalfx-extensions-faq-onboarding.md#sslCerts)

* * *

<a name="skeleton-frequently-asked-questions-for-authoring-azure-documents-loading-different-versions-of-an-extension"></a>
### Loading different versions of an extension

***How do I load different versions of an extension?***

Understanding which extension configuration to modify is located at [portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify](portalfx-extensions-configuration-overview.md#understanding-which-extension-configuration-to-modify).

* * *

<a name="skeleton-frequently-asked-questions-for-authoring-azure-documents-other-debugging-questions"></a>
### Other debugging questions

***How can I ask questions about debugging ?***

You can ask questions on Stackoverflow with the tag [ibiza](https://stackoverflow.microsoft.com/questions/tagged/ibiza).


   
<!--  optional FYI document, for links that could not be included in the content within the natural flow of the doc 
                                    "../templates/portalfx-==major-area==-==topic==-fyi.md"  -->


<!--  required Glossary document. 
                                    "../templates/portalfx-extensions-glossary-==major-area==.md"  -->
<a name="skeleton-skeleton-glossary"></a>
## Skeleton Glossary

<!-- topic name is a level 2 at the beginning of the doc.  Including the major area in the name is optional. -->

<a name="skeleton-major-area-topic"></a>
## <major-area> <topic>

<!--  The Glossary is a required document.  -->

This document contains all terms that are in the topic, with the following exceptions.
* Standard English Language
* Standard Computing terms, like the ones found in This section contains a glossary of terms and acronyms that are used in this document. For common computing terms, see [https://techterms.com/](https://techterms.com/). For common acronyms, see [https://www.acronymfinder.com](https://www.acronymfinder.com).

 that are describes the topic at a general level.  If portions of the topic lend itself to further discussion, starting a subtopic document is a good idea.

If so, the subtopics are not included in this document; instead, they are included in the overarching document that contains a gitHub link to  this overview.  This method reduces gitHub commands to one document per topic.

Subtopic documents can authored along the same lines.


| Term              | Meaning |
| -------- | -------- |


A partial list of documents that are might be useful inline (instead of linked to) is as follows.
portalfx-extensions-branches.md
portalfx-extensions-cnames.md
portalfx-extensions-contacts.md
portalfx-extensions-developmentPhases.md
portalfx-extensions-exitCriteria.md
portalfx-extensions-publishing.md
portalfx-extensions-qualityEssentials.md
portalfx-extensions-stackoverflow.md
portalfx-extensions-status-codes.md

Any sections from other documents that are not this generic should probably be linked to within the subtopics.
