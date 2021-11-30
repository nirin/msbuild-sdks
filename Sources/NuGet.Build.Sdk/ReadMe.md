# NuGet.Build.Sdk

## Summary

An MSBuild SDK package that provides package reference support and dependency management to the projects.
It adds a `Restore` target which facilitates downloading and referencing shared libraries from a remote server.
It also adds a `Pack` target which facilitates creation of such packages using project outputs with pre-determined layouts.
Furthermore, it can be used either directly on your project (_via the `<Sdk/>` element_) or in-directly (_via other SDKs which refer to it internally_).

It's basically an SDK wrapper around Restore targets ([`NuGet.Build.Tasks`][nuget-restore]) and Pack targets ([`NuGet.Build.Tasks.Pack`][nuget-pack]) optimized for SDK-style projects.

[nuget-restore]: https://github.com/NuGet/NuGet.Client/blob/dev/src/NuGet.Core/NuGet.Build.Tasks
[nuget-pack]: https://github.com/NuGet/NuGet.Client/tree/dev/src/NuGet.Core/NuGet.Build.Tasks.Pack

### Package Name: `NuGet.Build.Sdk`

[![NuGet.Build.Sdk](https://img.shields.io/myget/msbuild-sdks/v/NuGet.Build.Sdk?style=flat-square&logo=nuget)](https://myget.org/feed/msbuild-sdks/package/nuget/NuGet.Build.Sdk)

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

2. Either keep the default or replace `Microsoft.NET.Sdk` with `MSBuild.NET.Sdk`.
   This is usually done in the project's top-level `Sdk` attribute.

3. Then, Add an SDK reference to `NuGet.Build.Sdk` through `<Sdk Name="..."/>` element
   directly under the `<Project>` element. If there are any properties, needed to be set
   before the imports, those can be placed just above the `<Sdk/>` element.

4. You have to tell MSBuild that the `Sdk` should resolve from NuGet by
    - Adding a `global.json` containing the SDK name and version.
    - Adding a `Version` attribute with version info to the `Sdk` element.

5. Then you can add package specific properties and items (_though some are included by default_) and pack the project into a NuGet package.

The final project should look like this:

```xml
<Project Sdk="MSBuild.NET.Sdk">

    <PropertyGroup>
        <!-- Any Sdk-specific overridden properties -->
        <ImportDirectoryPackagesProps>false</ImportDirectoryPackagesProps>
    </PropertyGroup>

    <Sdk Name="NuGet.Build.Sdk">

    <PropertyGroup>
        <PackageId>Vendor.Awesome.Package</PackageId>
        <!-- Other Package-specific properties -->
    </PropertyGroup>

    <!-- Other properties, items and targets -->

</Project>
```

You can put the SDK version in the `global.json` file next to your solution:

```json
{
    "msbuild-sdks": {
        "MSBuild.NET.Sdk": "1.0.0",
        "NuGet.Build.Sdk": "1.0.0"
    }
}
```

Then, all of your project files, from that directory forward, uses the version from the `global.json` file.
This would be a preferred solution for all the projects in your solution.

Then again, you might want to override the version for just one project **OR** if you have only one project in your solution (_without adding `global.json`_), you can do so like this:

```xml
<Project Sdk="MSBuild.NET.Sdk/1.0.0">

    <PropertyGroup>
        <!-- Any Sdk-specific overridden properties -->
        <ImportDirectoryPackagesProps>false</ImportDirectoryPackagesProps>
    </PropertyGroup>

    <Sdk Name="NuGet.Build.Sdk" Version="1.0.0">

    <PropertyGroup>
        <PackageId>Vendor.Awesome.Package</PackageId>
        <!-- Other Package-specific properties -->
    </PropertyGroup>

    <!-- Other properties, items and targets -->

</Project>
```

That's it! You do not need to specify any default properties or items as they'll be automatically defined.
After that, you can use the `Restore`, `Build`, `Pack` targets to restore packages, build the project and create NuGet packages: e.g., `msbuild -t:Pack ...`.

#### Important to Note

- Please note that these targets are not exactly same as the ones that ship with Visual Studio or .NET SDK.
  There are few tweaks applied on top of them to ensure some long-standing issues are fixed that weren't possible before due to compatibility.
- As such there's slight behavioral differences between the official version and this one.
  It mostly applies to projects that didn't override the defaults.
