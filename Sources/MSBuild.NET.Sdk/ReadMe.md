# MSBuild.NET.Sdk

## Summary

Supports creating [.NET](#platform-support) projects that include building for .NET Framework (Windows), .NET Core (Windows, Linux, MacOS), Mono (Windows, Linux, MacOS), Xamarin (based on Mono) runtimes.

### Package Name: `MSBuild.NET.Sdk`

[![MSBuild.NET.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Sdk)

### Getting started

Visual Studio v15.6+ includes support for SDK's resolved from NuGet.
That makes using the custom SDKs much easier.

See [Using MSBuild project SDKs][msbuild-sdk-usage] guide on [Microsoft Docs](https://docs.ms) for more information on how project SDKs work and [how project SDKs are resolved][msbuild-sdk-resolver].

[msbuild-sdk-usage]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk
[msbuild-sdk-resolver]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved

### Platform support

- .NET Framework (Windows):
  - WinForms
  - WorkFlow
  - WPF
  - WCF
  - ASP.NET
  - EF

- .NET Core (Windows, Linux, MacOS):
  - ASP.NET Core
  - EF Core

- .NET Core (Application Platforms):
  - UWP (Windows)
  - Tizen (w/ Xamarin.Forms)

- Mono (based on .NET Framework)
  - [Supported Platforms](http://www.mono-project.com/docs/about-mono/supported-platforms/)
  - [Compatibility](https://www.mono-project.com/docs/about-mono/compatibility)

- Xamarin (based on Mono):
  - Android
  - iOS
  - MacOS
  - TVOS
  - WatchOS
