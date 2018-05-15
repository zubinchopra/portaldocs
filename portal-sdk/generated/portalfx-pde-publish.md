
## Sharing your PDE with other teams

The following guidelines have been created to ensure a consistent developer experience across all partner teams that share  PDE's.

To share your PDE with other teams please follow these guidelines: 

1. Create a **NuGet** package
    
    Use the  naming convention `Microsoft.Portal.Extensions.<extensionName>`.  The  *.pde file should be located at  `/Client/_extensions/<extensionName>`.  Customimze the following code to create  your extension's NuGet package. Name it `Microsoft.Portal.Extensions.<extensionName>` to be consistent with the produced package name.
    
    ```xml

    <?xml version="1.0" encoding="utf-8"?>
    <Project ToolsVersion="4.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
    <Import Project="$(EnvironmentConfig)" />
    
    <PropertyGroup>
        <Id>Microsoft.Portal.Extensions.<extensionName></Id>
        <Title>Microsoft Portal Extension <extensionName></Title>
        <Description>Provides the Microsoft Portal <extensionName> PDE</Description>
        <Summary>Provides the Microsoft Portal <extensionName> PDE</Summary>
        <Tags>Microsoft Azure Cloud Portal Framework <extensionName> PDE</Tags>
    </PropertyGroup>
    
    <ItemGroup>
        <!-- update the following to pull the PDE from your official build-->
        <Content Include="$(RepoRoot)\src\SDK\Extensions\HubsExtension\TypeScript\HubsExtension\HubsExtension.pde">
        <TargetPath>Client\_extensions\<extensionName></TargetPath>
        </Content>
        <!-- include an install.ps1 to both set appropriate build action on pde and to pop documents-->
        <File Include="$(REPOROOT)\RDPackages\NuGet\Microsoft.Portal.Extensions.Name\Install.ps1" >
        <TargetPath>Tools\Install.ps1</TargetPath>
        </File>
    </ItemGroup>
    <!-- update the following as needed aka.ms/onebranch -->
    <Import Project="$(PkgNuProj)\NuProj.Targets" />
    <Import Project="..\Portal.Common.NuGet.props" />
    <PropertyGroup>
        <GenerateSymbolPackage>false</GenerateSymbolPackage>
    </PropertyGroup>
    </Project>

    ```
    
1.  Include a Install.ps1 in the NuGet package that will set the correct build action on the PDE and open documentation that specifies how to consume the exposed content.  The following Install.ps1 script
can be customized for this purpose.


    ```powershell

    param($installPath, $toolsPath, $package, $project)
    
    # set the build action for the pde to ExtensionResource
    $item = $project.ProjectItems.Item("Client").ProjectItems.Item("_extensions").ProjectItems.Item("Your Folder Name that nuproj puts the pde in").ProjectItems.Item("SomeExtension.pde") 
    $item.Properties.Item("ItemType").Value = "ExtensionReference"
    # open the documentation for consuming exposed content from the pde. use an aka.ms link so you can change out the target content without having to republish
    $DTE.ItemOperations.Navigate("http://aka.ms/portalfx/somepde")
    
    ```
 
1. After the **NuGet** package is created, create a document that describes how to consume the content exposed by the PDE

    * Check your access to the documentation repository  that is located at [https://github.com/Azure](https://github.com/Azure).  If you do not have access, follow the instructions located at [http://aka.ms/azuregithub](http://aka.ms/azuregithub) to enable 2FA on your github account and link your microsoft account.
	
	* Request access to portalfxdocs  at [http://aka.ms/azuregithub](http://aka.ms/azuregithub). 
	
	* Guidelines for document creation are located at []().

1. Publish the resulting **NuGet** package folder from your official builds to [http://wanuget/Official/](http://wanuget/Official/). 

<!-- TODO:  Determine whereabouts of wanuget official feed. http://wanuget/official does not exist, and  https://msazure.pkgs.visualstudio.com/_packaging/Official/NuGet/v3/index.json does not appear to be the right one. Might it be https://www.nuget.org/profiles/microsoft?  -->

<!-- TODO:  Find aka.ms link for the following site -->

For more information, see  [https://microsoft.sharepoint.com/teams/WAG/EngSys/Implement/OneBranch/Publish%20your%20package.aspx](https://microsoft.sharepoint.com/teams/WAG/EngSys/Implement/OneBranch/Publish%20your%20package.aspx)
