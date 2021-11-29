# MSBuild.Solution.Sdk

## Summary

Supports creating MSBuild solutions which are MSBuild projects that indicate what projects to include when building your solution tree.
They are an evolution of the classic Visual Studio solution (_.sln_) files.

### Package Name: `MSBuild.Solution.Sdk`

[![MSBuild.Solution.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Solution.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Solution.Sdk)

### Getting started

Visual Studio v15.6+ includes support for SDK's resolved from NuGet.
That makes using the custom SDKs much easier.

See [Using MSBuild project SDKs][msbuild-sdk-usage] guide on [Microsoft Docs](https://docs.ms) for more information on how project SDKs work and [how project SDKs are resolved][msbuild-sdk-resolver].

[msbuild-sdk-usage]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk
[msbuild-sdk-resolver]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved

#### Using the SDK

1. Create a new project
    - from `dotnet new` templates.
    - With your existing SDK-style project.

2. Replace `Microsoft.NET.Sdk` with `MSBuild.Solution.Sdk` in the project's top-level `Sdk` attribute.

3. You have to tell MSBuild that the `Sdk` should resolve from NuGet by
    - Adding a `global.json` containing the SDK name and version.
    - Appending a version info to the `Sdk` attribute value.

4. Remove the `TargetFramework(s)` and other .NET specific properties from the project file.
   Older versions of VS IDE might require `TargetFramework(s)` property to open the project in IDE successfully.

5. Then you can add properties, items, tasks and targets to customize your solution to your needs.

The final project should look like this:

```xml
<Project Sdk="MSBuild.Solution.Sdk">

    <PropertyGroup>
        <SolutionName>eShopSolution</SolutionName>
        <RootNamespace>Contoso.eShop</RootNamespace>
    </PropertyGroup>

    <!-- Projects under the solution directory are automatically included -->
    <ItemGroup>
      <!-- Project Folders are also supported! -->
      <ProjectFolder Include="Tools\Build\"/>
      <ProjectFolder Include="Tools\Common\"/>
      <ProjectFolder Include="Tools\Publish\"/>
    </ItemGroup>

    <!-- For projects outside of solution you can include it like so… -->
    <ItemGroup Condition="Exists('$(RepoRoot)..\eShopTests\')">
      <ProjectFile Include="$(RepoRoot)..\eShopTests\**\*.*proj"/>
      <ProjectFolder Include="$(RepoRoot)..\eShopTests\ConsoleTests\"/>
    </ItemGroup>

</Project>
```

You can put the SDK version in the `global.json` file next to your solution:

```json
{
    "msbuild-sdks": {
        "MSBuild.Solution.Sdk": "1.0.0"
    }
}
```

Then, all of your project files, from that directory forward, uses the version from the `global.json` file.
This would be a preferred solution for all the projects in your solution.

Then again, you might want to override the version for just one project **OR** if you have only one project in your solution (_without adding `global.json`_), you can do so like this:

```xml
<Project Sdk="MSBuild.Solution.Sdk/1.0.0">

    <PropertyGroup>
        <SolutionName>eShopSolution</SolutionName>
        <RootNamespace>Contoso.eShop</RootNamespace>
    </PropertyGroup>

    <!-- Other properties, items and targets -->

</Project>
```

That's it! You do not need to specify any default properties or items as they'll be automatically defined.
After that, you can use the `Restore`, `Build`, `Pack` targets to restore packages, build the solution and create NuGet packages: e.g., `msbuild -t:Pack ...`.

#### Important to Note

- This SDK does not support Common Project System (**CPS**) protocol.
  As such, it may not open in Visual Studio and other IDEs that require it.
- But code editors such as Visual Studio Code and others will open the project without any issues as they (_OmniSharp_) don't require CPS.
