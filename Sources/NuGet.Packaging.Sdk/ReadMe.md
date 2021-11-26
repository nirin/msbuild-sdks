# NuGet.Packaging.Sdk

## Summary

An MSBuild SDK package that provides NuGet package authoring, reference support and dependency management to the projects.
You use this SDK primarily to author NuGet packages, but it also supports NuGet Pack and Restore for common MSBuild projects.
Thus, you can use it directly on your project (_or via the platform SDKs which refer to this SDK internally_) for NuGet support.

It's basically an SDK wrapper around [NuGet.Build.Packaging](https://github.com/NuGet/NuGet.Build.Packaging) aka NuGetizer-3000 project, with NuGet Restore and Pack targets optimized for SDK-style.

### Package Name: `NuGet.Packaging.Sdk`

[![NuGet.Packaging.Sdk](https://img.shields.io/myget/msbuild-sdks/v/NuGet.Packaging.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/NuGet.Packaging.Sdk)

### Getting started

Visual Studio v15.6+ includes support for SDK's resolved from NuGet. That makes using the custom SDKs much easier.

See [Using MSBuild project SDKs][msbuild-sdk-usage] guide on [Microsoft Docs](https://docs.ms) for more information on how project SDKs work and [how project SDKs are resolved][msbuild-sdk-resolver].

[msbuild-sdk-usage]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk
[msbuild-sdk-resolver]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved

#### Using the SDK

1. Create a new project
    - from `dotnet new` templates.
    - With your existing SDK-style project.

2. Replace `Microsoft.NET.Sdk` with `NuGet.Packaging.Sdk` to the project's top-level `Sdk` attribute.

3. You have to tell MSBuild that the `Sdk` should resolve from NuGet by
    - Adding a `global.json` containing the SDK name and version.
    - Appending a version info to the `Sdk` attribute value.

4. Remove the `TargetFramework(s)` and other .NET specific properties from the project file. Older versions of VS IDE might require `TargetFramework(s)` property to open the project in IDE successfully.

5. Then you can add package specific properties and items (_though some are included by default_) and use the project for building a NuGet package.

The final project should look like this:

```xml
<Project Sdk="NuGet.Packaging.Sdk">

    <PropertyGroup>
        <PackageId>Vendor.Awesome.Package</PackageId>
        <!-- Other Package-specific properties -->
    </PropertyGroup>

    <!-- Some files in the project and files outside of project cone should be included manually -->
    <ItemGroup>
        <PackageFile Include="$(RepoRoot)ReadMe.md" TargetPath="\">
        <PackageFile Include="SomeBuildCustom.props" TargetPath="\build\$(PackageId).props">
        <PackageFile Include="SomeBuildCustom.targets" TargetPath="\build\$(PackageId).targets">
    </ItemGroup>

</Project>
```

You can put the SDK version in the `global.json` file next to your solution:

```json
{
    "msbuild-sdks": {
        "NuGet.Packaging.Sdk": "1.0.0"
    }
}
```

Then, all of your project files, from that directory forward, uses the version from the `global.json` file.
This would be a preferred solution for all the projects in your solution.

Then again, you might want to override the version for just one project _OR_ if you have only one project in your solution (without adding `global.json`), you can do so like this:

```xml
<Project Sdk="NuGet.Packaging.Sdk/1.0.0">

    <PropertyGroup>
        <PackageId>Vendor.Awesome.Package</PackageId>
        <!-- Other Package-specific properties -->
    </PropertyGroup>

    <!-- Other properties, items and targets -->

</Project>
```

That's it. You do not need to specify any default properties or items as they'll be automatically defined.
After that, you can use the `Restore`, `Build`, `Pack` targets to restore packages, build the project and create NuGet packages. E.g.: `msbuild -t:Pack ...`

#### Important to Note

- As the project support in the SDK is based on an experimental NuGet project, it requires the NuGet Packaging Visual Studio extension to load `.nuproj` project types.
- Since the extension hasn't been updated in a while, newer VS IDE can't install the extension and thus can't open the project. So, either use internally published VS IDE extension or just use VS Code with _OmniSharp_ extension.
