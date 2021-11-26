# NuGet.Packaging.Sdk

## Summary

An MSBuild SDK package that provides NuGet package authoring, reference support and dependency management to the projects.
You use this SDK primarily to author NuGet packages, but it also supports NuGet Pack and Restore for common MSBuild projects.
Thus, you can use it directly on your project (_or via the platform SDKs which refer to this SDK internally_) for NuGet support.

It's basically an SDK wrapper around [NuGet.Build.Packaging](https://github.com/NuGet/NuGet.Build.Packaging) aka NuGetizer-3000 project, with NuGet Restore and Pack targets optimized for SDK-style.

### Package Name: `NuGet.Packaging.Sdk`

[![NuGet.Packaging.Sdk](https://img.shields.io/myget/msbuild-sdks/v/NuGet.Packaging.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/NuGet.Packaging.Sdk)
[![MSBuild-SDKs](https://img.shields.io/badge/msbuild--sdks-myget-brightgreen.svg)](https://myget.org/gallery/msbuild-sdks)

### Getting started (VS 15.6+)

Visual Studio 2017 Update 6 (aka _v15.6_) includes support for SDK's resolved from NuGet. That makes using the custom SDKs much easier.

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

You can put the `global.json` file next to your solution:

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

- It will only work with Visual Studio IDE (Windows/Mac) as it requires the desktop `msbuild` and the target Platform SDKs which are not cross-platform.
- It might work in Visual Studio Code, but you have to configure build tasks in `launch.json` to use desktop `msbuild` to build.
- You must install the tools of the platforms you intend to build. For Xamarin, that means the Xamarin Workload; for UWP install those tools as well.

More information on how SDK's are resolved can be found [here](https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved).
