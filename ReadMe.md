# MSBuild SDKs

MSBuild SDKs are used to configure and extend your build. MSBuild 15.0 introduced a concept of an SDK which is an upgraded project XML Schema that we commonly refer as 'SDK-style' project. So MSBuild 15.0 and above is needed for the following SDKs

## Available SDKs

[![MSBuild-SDKs](https://img.shields.io/badge/msbuild--sdks-myget-brightgreen.svg)](https://myget.org/gallery/msbuild-sdks)

### [MSBuild.NET.Extras.Sdk](Source/MSBuild.NET.Extras.Sdk)

Adds a few extra extensions to the SDK-style projects that are currently not available in `Microsoft.NET.Sdk` SDK. This feature is being tracked in [dotnet/sdk#491](/dotnet/sdk/issues/491)

[![MSBuild.NET.Extras.Sdk](https://img.shields.io/nuget/v/MSBuild.NET.Extras.Sdk.svg)](https://nuget.org/packages/MSBuild.NET.Extras.Sdk)
[![MSBuild.NET.Extras.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Extras.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Extras.Sdk)

## Working

An MSBuild SDK, in a nutshell, is a packaged and versioned set of MSBuild tasks, props and targets that offer a specific set of functionalities to any project/solution build.

These SDK-style projects looks like:

```xml
<Project Sdk="MSBuild.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net46</TargetFramework>
  </PropertyGroup>
</Project>
```

At evaluation time, MSBuild adds implicit imports at the top and bottom of the project like this:

```xml
<Project>
  <Import Project="Sdk.props" Sdk="MSBuild.NET.Sdk"/>

  <PropertyGroup>
    <TargetFramework>net46</TargetFramework>
  </PropertyGroup>

  <Import Project="Sdk.targets" Sdk="MSBuild.NET.Sdk"/>
</Project>
```

By default, MSBuild requires that the SDKs must be installed prior to using them. But, for MSBuild 15.6 and above, the SDKs can be referenced as NuGet packages instead.
More documentation is available [here](https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk).

## Contributing (`TBA`)
