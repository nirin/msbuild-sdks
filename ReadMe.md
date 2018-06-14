# MSBuild SDKs

MSBuild SDKs are used to configure and extend your build. MSBuild 15.0 introduced a concept of an SDK which is an upgraded project XML Schema that we commonly refer as 'SDK-style' project. So MSBuild 15.0 and above is needed for the following SDKs

## Available SDKs

[![MSBuild-SDKs](https://img.shields.io/badge/msbuild--sdks-myget-brightgreen.svg)](https://myget.org/gallery/msbuild-sdks)

### [MSBuild.Core.Sdk](Source/MSBuild.Core.Sdk)

Supports projects that do not compile to an assembly. This is usually the base SDK for other SDKs listed here.

### [MSBuild.Native.Sdk](Source/MSBuild.Native.Sdk)

Supports [Native](Docs/Support.md#native-platform-support) projects that include C/C++ (CLang, GCC, VisualC), ASM, FORTRAN, etc.

### [MSBuild.NET.Sdk](Source/MSBuild.NET.Sdk)

Supports [.NET Platform](Docs/Support.md#net-platform-support) projects that include building for .NET Framework (Windows), .NET Core (Windows, Linux, MacOS), Mono (Windows, Linux, MacOS), Xamarin (based on Mono) runtimes.

### [MSBuild.NET.Legacy.Sdk](Source/MSBuild.NET.Legacy.Sdk)

Supports only .NET Framework (Windows). Contains the original .NET Framework Build files that were included with MSBuild. Use them to slowly migrate your legacy projects to SDK-style.

### [MSBuild.CodeSharing.Sdk](Source/MSBuild.CodeSharing.Sdk)

Coming Soon. Shared project in SDK-style and more!

### [MSBuild.Dependencies.Sdk](Source/MSBuild.Dependencies.Sdk)

Supports centrally managing NuGet packagea and it's versions in a code base. Also allows adding global package references to all projects.

### [MSBuild.Packaging.Sdk](Source/MSBuild.Packaging.Sdk)

Coming Soon. Create any type of package for any type of project!

### [MSBuild.Solution.Sdk](Source/MSBuild.Solution.Sdk)

Supports creating MSBuild solutions which are MSBuild projects that indicate what projects to include when building your tree. They are an evolution of Visual Studio solution files.

### [NuGet.Packaging.Sdk](Source/NuGet.Packaging.Sdk)

Supports NuGet Restore/Pack Tasks and Package authoring. It's basically an SDK wrappper around [NuGet.Build.Packaging](https://github.com/NuGet/NuGet.Build.Packaging) aka NuGetizer-3000 project, with NuGet Restore and Pack targets optimized for SDK-style.

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
