# MSBuild.NET.DefaultItems

## Summary

An MSBuild Extension package for including various platforms' (Android, Apple, Tizen, Web, Windows) default build items etc... in .NET projects.

### Package Name: `MSBuild.NET.DefaultItems`

[![MSBuild.NET.DefaultItems](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.DefaultItems.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.DefaultItems)
[![MSBuild.NET.DefaultItems](https://img.shields.io/nuget/v/MSBuild.NET.DefaultItems.svg)](https://nuget.org/packages/MSBuild.NET.DefaultItems)

### Getting started

Visual Studio v15.6+ includes support for SDK's resolved from NuGet. That makes using the custom SDKs much easier.

See [Using MSBuild project SDKs][msbuild-sdk-usage] guide on [Microsoft Docs](https://docs.ms) for more information on how project SDKs work and [how project SDKs are resolved][msbuild-sdk-resolver].

[msbuild-sdk-usage]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk
[msbuild-sdk-resolver]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved

#### Using the SDK

1. Create a new project
    - from `dotnet new` templates.
    - With your existing SDK-style project.

2. Add `<Import Sdk="MSBuild.NET.DefaultItems" Project="Items.{props|targets}" />` to the top and bottom of the file between the `<Project>` root elements.

3. You have to tell MSBuild that the `Sdk` should resolve from NuGet by
    - Adding a `global.json` containing the SDK name and version.
    - Appending a version info to the `Sdk` attribute value.

4. Then you can enable the default items through a set of properties for each supported project types.

The final project should look like this:

```xml
<Project Sdk="Microsoft.NET.Sdk">

    <Import Sdk="MSBuild.NET.DefaultItems" Project="Items.props"/>

    <PropertyGroup>
        <TargetFrameworks>net48;net5.0</TargetFrameworks>
        <EnableDefaultXamlItems>true</EnableDefaultXamlItems>
    </PropertyGroup>

    <Import Sdk="MSBuild.NET.DefaultItems" Project="Items.targets"/>

</Project>
```

You can put the SDK version in the `global.json` file next to your solution:

```json
{
    "msbuild-sdks": {
        "MSBuild.NET.DefaultItems": "0.8.0"
    }
}
```

Then, all of your project files, from that directory forward, uses the version from the `global.json` file.
This would be a preferred solution for all the projects in your solution.

Then again, you might want to override the version for just one project _OR_ if you have only one project in your solution (without adding `global.json`), you can do so like this:

```xml
<Project Sdk="Microsoft.NET.Sdk">

    <Import Sdk="MSBuild.NET.DefaultItems/0.8.0" Project="Items.props"/>

    <PropertyGroup>
        <TargetFrameworks>net48;net5.0</TargetFrameworks>
        <EnableDefaultXamlItems>true</EnableDefaultXamlItems>
    </PropertyGroup>

    <Import Sdk="MSBuild.NET.DefaultItems/0.8.0" Project="Items.targets"/>

</Project>
```

That's it. You do not need to specify the .NET or UWP or Tizen framework packages as they'll be automatically included.
After that, you can use the `Restore`, `Build`, `Pack` targets to restore packages, build the project and create NuGet packages. E.g.: `msbuild -t:Pack ...`

#### Important to Note

- This SDK is an Extension/Support SDK that should be in conjunction with other .NET SDKs. Be sure to disable their automatic Default items.
