# MSBuild SDKs

MSBuild SDKs are used to configure and extend your build. MSBuild 15.0 introduced a concept of an SDK which is an upgraded project XML Schema that we commonly refer as 'SDK-style' project. So MSBuild 15.0 and above is needed for the following SDKs

## Available SDKs

[![MSBuild-SDKs](https://img.shields.io/badge/msbuild--sdks-myget-brightgreen.svg)](https://myget.org/gallery/msbuild-sdks)

### [MSBuild.Core.Sdk](Source/MSBuild.Core.Sdk)

Support projects that do not compile to an assembly. This is usually the base SDK for other SDKs listed here.

[![MSBuild.Core.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Core.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Core.Sdk)

### [MSBuild.Sharing.Sdk](Source/MSBuild.Sharing.Sdk)

Supports creating Shared projects that contain properties and items which are shared between multiple projects.
But they themselves remain a separate non-interactive project in the solution tree.

[![MSBuild.Sharing.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Sharing.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Sharing.Sdk)

### [MSBuild.Solution.Sdk](Source/MSBuild.Solution.Sdk)

Supports creating MSBuild solutions which are MSBuild projects that indicate what projects to include when building your solution tree.
They are an evolution of the classic Visual Studio solution (_.sln_) files.

[![MSBuild.Solution.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Solution.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Solution.Sdk)

### [MSBuild.NET.DefaultItems](Source/MSBuild.NET.DefaultItems)

An MSBuild Extension package for including various platforms' (Android, Apple, Tizen, Web, Windows) default build items in .NET projects.
You can use this package in any SDK-style projects that uses `Microsoft.NET.Sdk`. The `MSBuild.NET.Extras.Sdk` already includes these defaults.

[![MSBuild.NET.DefaultItems](https://img.shields.io/nuget/v/MSBuild.NET.DefaultItems.svg)](https://nuget.org/packages/MSBuild.NET.DefaultItems)
[![MSBuild.NET.DefaultItems](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.DefaultItems.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.DefaultItems)

### [MSBuild.NET.Extras.Sdk](Source/MSBuild.NET.Extras.Sdk)

Adds a few extra extensions to the SDK-style projects that are currently not available in `Microsoft.NET.Sdk` SDK. This feature is being tracked in [dotnet/sdk#491](https://github.com/dotnet/sdk/issues/491)

[![MSBuild.NET.Extras.Sdk](https://img.shields.io/nuget/v/MSBuild.NET.Extras.Sdk.svg)](https://nuget.org/packages/MSBuild.NET.Extras.Sdk)
[![MSBuild.NET.Extras.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Extras.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Extras.Sdk)

### [MSBuild.NET.Sdk](Source/MSBuild.NET.Sdk)

Supports [.NET](Docs/Support.md#net-platform-support) projects that include building for .NET Framework (Windows), .NET Core (Windows, Linux, MacOS), Mono (Windows, Linux, MacOS), Xamarin (based on Mono) runtimes.

[![MSBuild.NET.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Sdk)

### [MSBuild.NET.Legacy.Sdk](Source/MSBuild.NET.Legacy.Sdk)

Supports only .NET Framework (Windows). Contains the original .NET Framework Build files that were included with MSBuild. Use them to slowly migrate your legacy projects to SDK-style.

[![MSBuild.NET.Legacy.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Legacy.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Legacy.Sdk)

### [MSBuild.NET.Inbox.Sdk](Source/MSBuild.NET.Inbox.Sdk)

Supports only .NET Framework (Windows). Redirects to the original MSBuild files that were included as a part of .NET Framework (Windows). This is for our internal projects only.

[![MSBuild.NET.Inbox.Sdk](https://img.shields.io/nuget/v/MSBuild.NET.Inbox.Sdk.svg)](https://nuget.org/packages/MSBuild.NET.Inbox.Sdk)
[![MSBuild.NET.Inbox.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Inbox.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Inbox.Sdk)

### [NuGet.Packaging.Sdk](Source/NuGet.Packaging.Sdk)

Supports NuGet Restore/Pack Tasks and Package authoring. It's basically an SDK wrapper around [NuGet.Build.Packaging](https://github.com/NuGet/NuGet.Build.Packaging) aka NuGetizer-3000 project, with NuGet Restore and Pack targets optimized for SDK-style.

[![NuGet.Packaging.Sdk](https://img.shields.io/myget/msbuild-sdks/v/NuGet.Packaging.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/NuGet.Packaging.Sdk)

## Developing

### [MSBuild.Dependencies.Sdk](Source/MSBuild.Dependencies.Sdk)

Supports centrally managing Native and Managed references directly and via packages. Also allows adding global references via the Solution SDK.

### [MSBuild.Native.Sdk](Source/MSBuild.Native.Sdk)

Supports [Native](Docs/Support.md#native-platform-support) projects that include C/C++ (CLang, GCC, VisualC), ASM, FORTRAN, etc.

### [MSBuild.Packaging.Sdk](Source/MSBuild.Packaging.Sdk)

Supports creating any type of package for any type of project!

## Working

An MSBuild SDK, in a nutshell, is a packaged and versioned set of MSBuild tasks, props and targets that offer a specific set of functionalities to any project/solution build.

These SDK-style projects looks like:

```xml
<Project Sdk="MSBuild.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>net5.0</TargetFramework>
  </PropertyGroup>
</Project>
```

At evaluation time, MSBuild adds implicit imports at the top and bottom of the project like this:

```xml
<Project>
  <Import Project="Sdk.props" Sdk="MSBuild.NET.Sdk"/>

  <PropertyGroup>
    <TargetFramework>net5.0</TargetFramework>
  </PropertyGroup>

  <Import Project="Sdk.targets" Sdk="MSBuild.NET.Sdk"/>
</Project>
```

By default, MSBuild requires that the SDKs must be installed prior to using them. But, for MSBuild 15.6 and above, the SDKs can be referenced as NuGet packages instead.
More documentation is available [here](https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk).

## Contributing (`TBA`)
