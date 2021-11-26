# MSBuild SDKs

MSBuild SDKs are used to configure and extend your build. MSBuild v15 introduced a concept of an SDK reference (_similar to an Import_). Any project that references one or more SDKs are commonly referred to as an _SDK-style_ project. So, MSBuild v15+ is required for the _SDK-style_ project to work.

## Available SDKs

[![MyGet: MSBuild-SDKs](https://img.shields.io/badge/MyGet-MSBuild--SDKs-brightgreen.svg)](https://myget.org/gallery/msbuild-sdks)
[![NuGet: NIRIN](https://img.shields.io/badge/NuGet-NIRIN-blue.svg)](https://nuget.org/profiles/NIRIN)

### [MSBuild.Core.Sdk](Sources/MSBuild.Core.Sdk)

Supports creating projects that do not compile to an assembly. This is usually the base SDK for other SDKs listed here.

[![MSBuild.Core.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Core.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Core.Sdk)

### [MSBuild.Common.Sdk](Sources/MSBuild.Common.Sdk)

Supports creating projects that do not compile to an assembly. This is usually the base SDK for other SDKs listed here.

[![MSBuild.Common.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Common.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Common.Sdk)

### [MSBuild.Project.Sdk](Sources/MSBuild.Project.Sdk)

Supports creating projects that do not compile to an assembly. This is usually the base SDK for other SDKs listed here.

[![MSBuild.Project.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Project.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Project.Sdk)

### [MSBuild.Sharing.Sdk](Sources/MSBuild.Sharing.Sdk)

Supports creating Shared projects that contain properties and items which are shared between multiple projects.
But they themselves remain a separate non-interactive project in the solution tree.

[![MSBuild.Sharing.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Sharing.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Sharing.Sdk)

### [MSBuild.Solution.Sdk](Sources/MSBuild.Solution.Sdk)

Supports creating MSBuild solutions which are MSBuild projects that indicate what projects to include when building your solution tree.
They are an evolution of the classic Visual Studio solution (_.sln_) files.

[![MSBuild.Solution.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Solution.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Solution.Sdk)

### [MSBuild.NET.DefaultItems](Sources/MSBuild.NET.DefaultItems)

An MSBuild Extension package for including various platforms' (Android, Apple, Tizen, Web, Windows) default build items in .NET projects.
You can use this package in any SDK-style projects that uses `Microsoft.NET.Sdk`. The `MSBuild.NET.Extras.Sdk` already includes these defaults.

[![MSBuild.NET.DefaultItems](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.DefaultItems.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.DefaultItems)
[![MSBuild.NET.DefaultItems](https://img.shields.io/nuget/v/MSBuild.NET.DefaultItems.svg)](https://nuget.org/packages/MSBuild.NET.DefaultItems)

### [MSBuild.NET.Extras.Sdk](Sources/MSBuild.NET.Extras.Sdk)

Adds a few extra extensions to the SDK-style projects that are currently not available in `Microsoft.NET.Sdk` SDK. This feature is being tracked in [dotnet/sdk#491](https://github.com/dotnet/sdk/issues/491)

[![MSBuild.NET.Extras.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Extras.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Extras.Sdk)
[![MSBuild.NET.Extras.Sdk](https://img.shields.io/nuget/v/MSBuild.NET.Extras.Sdk.svg)](https://nuget.org/packages/MSBuild.NET.Extras.Sdk)

### [MSBuild.NET.Sdk](Sources/MSBuild.NET.Sdk)

Supports creating .NET projects that include building for .NET Framework (Windows), .NET Core (Windows, Linux, MacOS), Mono (Windows, Linux, MacOS), Xamarin (based on Mono) runtimes.

[![MSBuild.NET.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Sdk)

### [MSBuild.NET.Inbox.Sdk](Sources/MSBuild.NET.Inbox.Sdk)

Supports only .NET Framework (Windows). Redirects to the original MSBuild files that were included as a part of .NET Framework (Windows). This is for our internal projects only.

[![MSBuild.NET.Inbox.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Inbox.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Inbox.Sdk)
[![MSBuild.NET.Inbox.Sdk](https://img.shields.io/nuget/v/MSBuild.NET.Inbox.Sdk.svg)](https://nuget.org/packages/MSBuild.NET.Inbox.Sdk)

### [MSBuild.NET.Legacy.Sdk](Sources/MSBuild.NET.Legacy.Sdk)

Supports only .NET Framework (Windows). Contains the original .NET Framework Build files that were included with MSBuild. Use them to slowly migrate your legacy projects to SDK-style.

[![MSBuild.NET.Legacy.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Legacy.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Legacy.Sdk)

### [NuGet.Packaging.Sdk](Sources/NuGet.Packaging.Sdk)

Supports NuGet Restore/Pack Tasks and Package authoring. It's basically an SDK wrapper around [NuGet.Build.Packaging](https://github.com/NuGet/NuGet.Build.Packaging) aka NuGetizer-3000 project, with NuGet Restore and Pack targets optimized for SDK-style.

[![NuGet.Packaging.Sdk](https://img.shields.io/myget/msbuild-sdks/v/NuGet.Packaging.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/NuGet.Packaging.Sdk)

## Developing

### [MSBuild.Managed.Sdk](Sources/MSBuild.Managed.Sdk)

Supports creating Managed runtime targeting projects using Managed frameworks and languages (_Annex, Mono (.NET), Swift, Java, etc…_).
This is usually the base SDK for other specific Managed Runtime SDKs listed here.

### [MSBuild.Native.Sdk](Sources/MSBuild.Native.Sdk)

Supports creating Native runtime targeting projects using Native frameworks and languages (_ASM, FORTRAN, C/C++, SLang, Rust, etc…_).
This is usually the base SDK for other specific Native Runtime SDKs listed here.

### [MSBuild.Dependencies.Sdk](Sources/MSBuild.Dependencies.Sdk)

Supports managing Native and Managed references via various sources such as packages from a central repository. Also supports global references and central versioning via Solution SDK.

### [MSBuild.Packaging.Sdk](Sources/MSBuild.Packaging.Sdk)

Supports creating ___any type of package___ for ___any type of project___ with built-in support for basic Archives (_ZIP, 7Z, RAR, IMG, ISO, etc…_), platform-specific (_MSI, MSU, MSP, MSIX, AppX, etc…_) and platform-agnostic (_NuGet, VCPKG, JAR, JSP, DEP, etc…_) packaging.

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

By default, MSBuild requires that the SDKs must be installed prior to using them. But, for MSBuild v15.6+, the SDKs can be referenced as NuGet packages instead.
More documentation is available [here](https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk).

## Contributing

Most of the SDKs in this repository are experimental and in-development. They are used to test-out and validate new ideas and are mostly used for internal projects. Furthermore, they start with bits and pieces of existing logic from other open-source projects, Visual Studio, Windows and other platform SDKs. As such, the code will be definitely breaking and are not recommended for production usage.

Contributions are welcome, but I don't have any strict guidelines for contributors to follow. Just infer the design, style guidelines and general direction of the SDK implementation from the codebase. If you have any questions, feel free to create an issue, and I'll do my best to answer your queries. I'll also create formal guidelines when I start to receive a few public contributions.

At this point, there are a lot missing from the codebase to properly author and maintain production-ready SDKs. First is the testing framework for the SDKs, next is the project/solution templates and finally the docs. Once these are done, the SDKs can be used regularly.

## Disclaimer

As mentioned above, the SDKs are experimental and in-development. This space is used for learning and experimenting with MSBuild. As such, the code published here is only for reference purposes since, it might contain de-compiled sources that may not be open source. The SDKs are published to NuGet only when they are ready for broader usage and has a feature set descriptive of their intended usage. They are also published to MyGet regularly, but it is considered a volatile source.

If possible and allowed, some ideas here will also be contributed back to the original source. One such example is the addition of `BaseOutputPath` to the MSBuild Common targets.
