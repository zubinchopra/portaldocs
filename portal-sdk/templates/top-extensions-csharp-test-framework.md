
#  C# Portal Test Framework

Please use the following links for info on how to use the C# Portal Test Framework.

## Overview

The C# test framework is a UI test framework built on top of the Selenium Webdriver C# bindings that are described in [https://www.seleniumhq.org/projects/webdriver](https://www.seleniumhq.org/projects/webdriver/).  Its primary goal is testing UI interactions in the Azure Portal.  

The C# test framework provides the following.

* A base for writing UI based Selenium webdriver tests.

* A suite of helpers for logging into, navigating, and manipulating controls, blades, and parts in the Portal

## Writing Tests

### Prerequisites

Prerequisites for using the C# test framework as as follows.

* Understanding of the C# programming language

* Nuget (https://www.nuget.org/) and [top-extensions-nuget.md](top-extensions-nuget.md)

* .NET Framework 4.5 or higher

* Visual Studio 2015 or higher, as specified in [top-extensions-install-software.md](top-extensions-install-software.md)

### Getting Started

The C# Test framework is distributed as a NuGet package that is available in the Azure Official NuGet  feed [https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official](https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official).  There are two primary packages.

1. Microsoft.Portal.TestFramework

    It is located at [https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework&protocolType=NuGet&_a=package](https://msazure.visualstudio.com/DefaultCollection/One/_Packaging?feed=Official&package=Microsoft.Portal.TestFramework&protocolType=NuGet&_a=package)

1. Microsoft.Portal.TestFramework.Csharp

    It is located at [https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official&package=Microsoft.Portal.TestFramework.CSharp&protocolType=NuGet&_a=package](https://msazure.visualstudio.com/DefaultCollection/One/_packaging?feed=Official&package=Microsoft.Portal.TestFramework.CSharp&protocolType=NuGet&_a=package)

    If you are just getting started, it is recommended to use the `Microsoft.Portal.TestFramework` NuGet package because it contains the necessary dependencies.  For more details about the two packages see [#understanding-the-differences-between-the-frameworks](#understanding-the-differences-between-the-frameworks).


{"gitdown": "include-file", "file": "../templates/portalfx-csharp-test-ui-cases.md"}

{"gitdown": "include-file", "file": "../templates/portalfx-csharp-test-parts-and-blades.md"}

{"gitdown": "include-file", "file": "../templates/portalfx-csharp-test-filling-forms.md"}

{"gitdown": "include-file", "file": "../templates/portalfx-csharp-test-commands.md"}

{"gitdown": "include-file", "file": "../templates/portalfx-csharp-test-screenshots.md"}

{"gitdown": "include-file", "file": "../templates/portalfx-csharp-test-publish.md"}

{"gitdown": "include-file", "file": "../templates/portalfx-extensions-bp-csharp-test.md"}

{"gitdown": "include-file", "file": "../templates/portalfx-extensions-glossary-testing.md"}

