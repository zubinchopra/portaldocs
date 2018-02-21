
## Contributing to C# Test Framework

Contributions that improve the Test Framework are welcome, because they keep the code base healthy.  When you have improvements to contribute back to the Test Framework, use the following steps to enlist into the list of contributors and submit a pull request. The pull request instructions are located at [top-extensions-publishing.md](top-extensions-publishing.md), with the following additions.

1. The Test Framework uses a different `<repoRoot>`
1. The Test Framework is not associated with the production extension branches
1. You may or may not want to set up a new local git repository specifically for test framework improvements 
1. The configuration files must be modified to match the test framework environment

<!-- TODO: Determine which Azure group is represented by the word  "we" -->
* **NOTE**: We may test the improvement changes with our internal repository's test suites before accepting the pull request.

**NOTE**: Please note that the opportunity to contribute to the  test framework is only available to first-party extension developers, i.e., Microsoft employees.

### Enlisting into the list of contributors

The repo uses a build environment named **CoreXt5**.  The instructions for enlisting into an existing repo are located at [https://aka.ms/portalfx/onebranch](https://aka.ms/portalfx/onebranch).

The git repository for first-party developers is located at  [https://aka.ms/portalfx/cstestfx](https://aka.ms/portalfx/cstestfx). In this discussion, `<repoRoot>` is this git repository.

The code can be viewed by using the solution file `<repoRoot>\src\TestFramework\TestFramework.sln` solution file.

### Building the improvement

<!-- TODO:  Verify that the build instructions are correct, including the location of the <repoRoot\out> -->

To build your improvement, initialize your CloudVault environment by using the instructions located at [https://aka.ms/portalfx/opendevelopment](https://aka.ms/portalfx/opendevelopment). After that is complete, you can call "build" at the repository root.  The build output will be available under <repoRoot>\out.

### Testing the improvement

After the build completes successfully, the NuGet package `Microsoft.Portal.TestFramework.CSharp` will be available under the `<repoRoot>\out\debug-AMD64\`.  You can copy the binaries to your local test suites and then run your tests to verify the fix. After the improvement passes all your unit tests, you can submit the pull request.

### Troubleshooting

If issues are encountered while developing the improvement, please search the internal StackOverflow that is located at [http://stackoverflow.microsoft.com](http://stackoverflow.microsoft.com) first.

 If you are unable to find an answer, reach out to the Ibiza team at  [Stackoverflow Ibiza Test](https://stackoverflow.microsoft.com/questions/tagged?tagnames=ibiza-test). 

 For a list of topics and stackoverflow tags, see [portalfx-stackoverflow.md](portalfx-stackoverflow.md).