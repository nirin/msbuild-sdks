# MSBuild.NET.Extras.Sdk

## Summary

This package contains a few extra extensions to the SDK-style projects that are currently not available in `Microsoft.NET.Sdk` SDK.
Like, support for older frameworks and its profiles. It also enables multi-targeting among them.

The primary goal is to keep your project file simple and clean without you having to enter in tons of properties, item and targets.

This is our fork of the [MSBuild.Sdk.Extras](https://github.com/novotnyllc/MSBuildSdkExtras) which has simplified properties, more default items and support for more legacy projects (e.g., ASP.NET, WCF, WFF, etc…).

### Package Name: `MSBuild.NET.Extras.Sdk`

[![MSBuild.NET.Extras.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Extras.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Extras.Sdk)
[![MSBuild.NET.Extras.Sdk](https://img.shields.io/nuget/v/MSBuild.NET.Extras.Sdk.svg)](https://nuget.org/packages/MSBuild.NET.Extras.Sdk)

### Getting started

Visual Studio v15.6+ includes support for SDK's resolved from NuGet.
That makes using the custom SDKs much easier.

See [Using MSBuild project SDKs][msbuild-sdk-usage] guide on [Microsoft Docs](https://docs.ms) for more information on how project SDKs work and [how project SDKs are resolved][msbuild-sdk-resolver].

[msbuild-sdk-usage]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk
[msbuild-sdk-resolver]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved

#### Using the SDK

1. Create a new project
    - Either Console App or Class Library.
    - With your existing SDK-style project.

2. Replace `Microsoft.NET.Sdk` with `MSBuild.NET.Extras.Sdk` in the project's top-level `Sdk` attribute.

3. You have to tell MSBuild that the `Sdk` should resolve from NuGet by
    - Adding a `global.json` containing the SDK name and version.
    - Appending a version info to the `Sdk` attribute value.

4. Then you can edit the `TargetFramework` property to a different TFM, or you can rename `TargetFramework` to `TargetFrameworks` and specify multiple TFM's with a semi-colon (`;`) separator.

The final project should look like this:

```xml
<Project Sdk="MSBuild.NET.Extras.Sdk">
  <PropertyGroup>
    <TargetFrameworks>net46;uap10.0;tizen40</TargetFrameworks>
  </PropertyGroup>
</Project>
```

You can put the SDK version in the `global.json` file next to your solution:

```json
{
    "msbuild-sdks": {
        "MSBuild.NET.Extras.Sdk": "1.4.1"
    }
}
```

Then, all of your project files, from that directory forward, uses the version from the `global.json` file.
This would be a preferred solution for all the projects in your solution.

Then again, you might want to override the version for just one project **OR** if you have only one project in your solution (_without adding `global.json`_), you can do so like this:

```xml
<Project Sdk="MSBuild.NET.Extras.Sdk/1.4.1">
  <PropertyGroup>
    <TargetFrameworks>net46;uap10.0;tizen40</TargetFrameworks>
  </PropertyGroup>
</Project>
```

That's it! You do not need to specify the .NET or UWP or Tizen framework packages as they'll be automatically included.
After that, you can use the `Restore`, `Build`, `Pack` targets to restore packages, build the project and create NuGet packages: e.g., `msbuild -t:Pack ...`.

#### Important to Note

- It will only work with Visual Studio IDE (Windows/Mac) as it requires the desktop `msbuild` and the target Platform SDKs which are not cross-platform.
- It might work in Visual Studio Code, but you have to configure build tasks in `launch.json` to use desktop `msbuild` to build.
- You must install the tools of the platforms you intend to build.
  For Xamarin, that means the Xamarin Workload; for UWP install those tools as well.

## Single or multi-targeting

Once this package is configured, you can now use any supported TFM in your `TargetFramework` or `TargetFrameworks` element.
The supported short TFM (**T**arget **F**ramework **M**oniker) families are:

- `netstandard` (.NET Standard)
- `netcoreapp` (.NET Core App)
- `net` (.NET Framework)
- `net35-client`/`net40-client` (.NET Framework Client profile)
- `wpa` (Windows Phone App 8.1)
- `win` (Windows 8 / 8.1)
- `uap` (Windows 10 / UWP)
- `wp` (Windows Phone Silverlight, WP7+)
- `sl` (Silverlight 4+)
- `tizen` (Tizen 3+)
- `xamarin.android`
- `xamarin.ios`
- `xamarin.mac`
- `xamarin.watchos`
- `xamarin.tvos`
- `portableNN-`/`portable-` (PCL profiles like `portable-net45+win8+wpa81+wp8`)

For PCL (**P**ortable **C**lass **L**ibrary) profiles, the order of the TFM's in the list does not matter, but the profile must be an exact match to one of the known profiles.
If it's not, you'll get a compile error saying it's unknown.
You can see the full list of known profiles here:
[Portable Library Profiles](https://portablelibraryprofiles.stephencleary.com) by [Stephen Cleary](https://stephencleary.com/).

If you try to use a framework that you don't have tools installed for, you'll get an error as well saying to check the tools.
In some cases, this might mean installing an older version of Visual Studio Build Tools (_like v14, v15_) to ensure that the necessary targets are installed on the machine.
