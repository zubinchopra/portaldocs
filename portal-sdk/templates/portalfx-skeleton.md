# Skeleton

This document contains the skeleton for authoring Azure documents that are stored in gitHub.

<!-- topic name is a level 1 header at the beginning of the doc-->

gitHub files that should be included based on the topic-subtopic relationship are linked to in this document using gitHub.  Because this is a sample document, all gitHub commands are slightly malformed.  To use this skeleton to create a new topic, fill in the parameters that are designated with angle brackets, and then enclose the gitHub command in curly brackets. Remember that the command "gitdown" should be enclosed in double quotes.

 <!--  required Overview document.  -->
gitdown: "include-file", "file": "../templates/portalfx-<major-area>-overview.md"
{"gitdown": "include-file", "file": "../templates/portalfx-skeleton-overview.md"}

<!--  optional subtopic documents. Use these when the topic goes deeper than an overview. The overview may contain a table that links to these sections, in addition to (or instead of) relying on the following links. -->
gitdown: "include-file", "file": "../templates/portalfx-<major-area>-<topic>-<subtopic1>.md"

gitdown: "include-file", "file": "../templates/portalfx-<major-area>-<topic>-<subtopic2>.md"

<!--  optional checklist document. Use this when there are specific steps to follow, or when there are specific tasks that the developer must verify as being completed.  -->
gitdown: "include-file", "file": "../templates/portalfx-<major-area>-<topic>-procedures.md"
{"gitdown": "include-file", "file": "../templates/portalfx-skeleton-procedure.md"}
  
<!--  optional Best Practices document -->
"gitdown: "include-file", "file": "../templates/portalfx-<major-area>-bp-<topic>.md"
{"gitdown": "include-file", "file": "../templates/portalfx-extensions-bp-skeleton.md"}

<!--  optional FAQ document -->
gitdown: "include-file", "file": "../templates/portalfx-<major-area>-faq-<topic>.md"
{"gitdown": "include-file", "file": "../templates/portalfx-extensions-faq-skeleton.md"}
   
<!--  optional FYI document, for links that could not be included in the content within the natural flow of the doc -->

gitdown: "include-file", "file": "../templates/portalfx-<major-area>-<topic>-fyi.md"
{"gitdown": "include-file", "file": "../templates/portalfx-skeleton-fyi.md"}

<!--  required Glossary document.  -->
gitdown: "include-file", "file": "../templates/portalfx-extensions-glossary-<major-area>.md"
{"gitdown": "include-file", "file": "../templates/portalfx-extensions-glossary-skeleton.md"}

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
