# MSBuild.NET.Sdk

This package contains a few extra extensions to the SDK-style projects that are currently not available
in the main SDK. That feature is tracked in [dotnet/sdk#491](https://github.com/dotnet/sdk/issues/491)

The primary goal is to enable multi-targeting without you having to enter in tons of properties within your
`csproj`, `vbproj`, `fsproj`, thus keeping it nice and clean.

See the [original project](//github.com/onovotny/MSBuildSdkExtras/) and this [blog article](https://oren.codes/2017/01/04/multi-targeting-the-world-a-single-project-to-rule-them-all/) by [Oren Novotny](//github.com/onovotny/) for some background on how to get started.
Installing this package, `MSBuild.NET.Extras.Sdk` adds the missing properties so that you can use any TFM you want.

In short: Create a new .NET Standard class library in VS 2017. Then you can edit the `TargetFramework` to a different TFM (after installing this package), or you can rename `TargetFramework` to `TargetFrameworks` and specify multiple TFM's with a `;` separator.

After building, you can use the `Pack` target to easily create a NuGet package: `msbuild /t:Pack ...`

Few notes:

- This will only work in VS 2017, Visual Studio for Mac. It's possible it will work in Code, but only as an editor.
- To compile, you'll need the desktop build engine -- `msbuild.exe`. Most of the platforms rely on tasks and utilities that are not yet cross platform
- You must install the tools of the platforms you intend to build. For Xamarin, that means the Xamarin Workload; for UWP install those tools as well.

## Package Name: `MSBuild.NET.Extras.Sdk`

NuGet: [![MSBuild.NET.Extras.Sdk](https://img.shields.io/nuget/v/MSBuild.NET.Extras.Sdk.svg)](https://nuget.org/packages/MSBuild.NET.Extras.Sdk)

MyGet: [![MSBuild.NET.Extras.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Extras.Sdk.svg)](https://myget.org/gallery/msbuild-sdks)

## Using the Package

To use this package, add a `PackageReference` to your project file like this (specify whatever version of the package or wildcard):

``` xml
<PackageReference Include="MSBuild.NET.Extras.Sdk" Version="1.0.0" PrivateAssets="All" />
```

Setting `PrivateAssets="All"` means that this build-time dependency won't be added as a dependency to any packages you create by
using the Pack targets (`msbuild /t:Pack` or `dotnet pack`).

Then, at the end of your project file, either `.csproj`, `.vbproj` or `.fsproj`, add the following `Import` just before the closing tag

``` xml
<Import Project="$(MSBuildSdkExtrasDotNet)" Condition="Exists('$(MSBuildSdkExtrasDotNet)')" />
```

This last step is required until [Microsoft/msbuild#1045](https://github.com/Microsoft/msbuild/issues/1045) is resolved.

## Targeting UWP

If you plan to target UWP, then you must include the UWP meta-package in your project as well, something like this:

``` xml
<ItemGroup Condition="'$(TargetFramework)' == 'uap10.0'">
  <PackageReference Include="Microsoft.NETCore.UniversalWindowsPlatform " Version="5.4.0" />
</ItemGroup>
```

Starting with VS 2017 15.4, you can specify the `TargetPlatformMinVersion` with the TFM. The exact value depends on your installed Windows SDK; it may be something like `uap10.0.16278`. You can even multi-target to support older versions too, so have a `uap10.0` and `uap10.0.16278` target with different capabilities.

## Targeting Tizen

If you plan to target Tizen, then you should include the following meta-package:

```xml
<ItemGroup Condition="'$(TargetFramework)' == 'tizen30'">
  <PackageReference Include="Tizen.NET" Version="3.0.0" />
</ItemGroup>
```

## Single or multi-targeting

Once this package is configured, you can now use any supported TFM in your `TargetFramework` or `TargetFrameworks` element. The supported TFM families are:

- `netstandard` (.NET Standard)
- `net` (.NET Framework)
- `net35-client`/`net40-client` (.NET Framework Client profile)
- `netcoreapp` (.NET Core App)
- `wpa` (Windows Phone App 8.1)
- `win` (Windows 8 / 8.1)
- `uap` (UWP)
- `wp` (Windows Phone Silverlight, WP7+)
- `sl` (Silverlight 4+)
- `tizen` (Tizen 3.0+)
- `monoandroid`/`Xamarin.Android`
- `xamarinios` / `Xamarin.iOS`
- `xamarinmac` / `Xamarin.Mac`
- `xamarinwatchos` / `Xamarin.WatchOS`
- `xamarintvos` / `Xamarin.TVOS`
- `portableNN-`/`portable-` (legacy PCL profiles like `portable-net45+win8+wpa81+wp8`)

 For legacy PCL profiles, the order of the TFM's in the list does not matter but the profile must be an exact match
 to one of the known profiles. If it's not, you'll get a compile error saying it's unknown. You can see the full
 list of known profiles here: [Portable Library Profiles by Stephen Cleary](https://portablelibraryprofiles.stephencleary.com/).

 If you try to use a framework that you don't have tools installed for, you'll get an error as well saying to check the tools. In some cases
 this might mean installing an older version of VS (like 2015) to ensure that the necessary targets are installed on the machine.
