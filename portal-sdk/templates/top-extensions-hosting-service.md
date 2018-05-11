
# Portal Extension Hosting Service

## Overview

The Ibiza team provides and operates a common extension hosting service that makes it easy to get an extension into a global distribution system without having to manage your own infrastructure.

A hosting service can make your web sites accessible through the World Wide Web by providing server space, Internet connectivity and data center security.

Teams that deploy UI for extensions with the classic cloud service model typically have to invest significant amounts of time to onboard to [MDS](portalfx-extensions-hosting-service-glossary.md), setup compliant deployments across all data centers, and configure [cdn](portalfx-extensions-hosting-service-glossary.md), storage and caching optimizations for each extension.

The cost of setting up and maintaining this infrastructure can be high. By leveraging the extension hosting service, developers can deploy extensions in all data centers without resource-heavy investments in the Web infrastructure.

For less common scenarios, you might need to do a custom deployment. For example, if the extension needs to reach server services using certificate based authentication, then there should be controller code on the server that our hosting service does not support. You should be very sure that a custom hosting solution is the correct solution previous to developing one. For more information, see [top-extensions-custom-deployment.md](top-extensions-custom-deployment.md).

The SLA for onboarding the extension to the hosting service is located at [top-extensions-svc-lvl-agreements.md](top-extensions-svc-lvl-agreements.md).

You can ask questions on Stackoverflow with the tags [ibiza-deployment](https://stackoverflow.microsoft.com/questions/tagged/ibiza-deployment) and [ibiza-hosting-service](https://stackoverflow.microsoft.com/questions/tagged/ibiza-hosting-service).

For more information about Stackoverflow, see [portalfx-stackoverflow.md](portalfx-stackoverflow.md).


The following is a list of hosting service topics.

| Type                          | Document           | Description |
| ----------------------------- | ---- | ---- |
| Basic Hosting Practices                  | [top-extensions-hosting-service-basic.md](top-extensions-hosting-service-basic.md) | How the hosting service serves an extension |
| Checklists                    | [top-extensions-hosting-service-procedures.md](top-extensions-hosting-service-procedures.md) | Procedures for hosting new blades and converting to custom hosting.       |
| Advanced Topics    |   [top-extensions-hosting-service-advanced.md](top-extensions-hosting-service-advanced.md)  | EV2 Integration, WARM Integration, and other features  | 
| Hosting Scenarios    |   [top-extensions-hosting-service-scenarios.md](top-extensions-hosting-service-scenarios.md)  | Varying the contents of  the `config` file for different types of hosting.  | 

{"gitdown": "include-file", "file": "../templates/portalfx-extensions-faq-hosting-service.md"}


{"gitdown": "include-file", "file": "../templates/portalfx-extensions-glossary-hosting-service.md"}
