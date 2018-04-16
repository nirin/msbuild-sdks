# MSBuild.NET.Extras.Sdk

## Summary

This package contains a few extra extensions to the SDK-style projects that are currently not available in `Microsoft.NET.Sdk` SDK. This feature is tracked in [dotnet/sdk#491](/dotnet/sdk/issues/491)

The primary goal of this project is to enable multi-targeting without you having to enter in tons of properties within your `csproj`, `vbproj`, `fsproj`, thus keeping it nice and clean.

See the [original project](/onovotny/MSBuildSdkExtras/) by [Oren Novotny](/onovotny) for more information.

### Package Name: `MSBuild.NET.Extras.Sdk`

[![MSBuild.NET.Extras.Sdk](https://img.shields.io/nuget/v/MSBuild.NET.Extras.Sdk.svg)](https://nuget.org/packages/MSBuild.NET.Extras.Sdk)
[![MSBuild.NET.Extras.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Extras.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Extras.Sdk)
[![MSBuild-SDKs](https://img.shields.io/badge/msbuild--sdks-myget-brightgreen.svg)](https://myget.org/gallery/msbuild-sdks)

### Getting started (VS 15.6+)

Visual Studio 2017 Update 6 (aka _v15.6_) includes support for SDK's resolved from NuGet. That makes using the custom Sdks much easier.

#### Using the SDK

1. Create a new project
    - .NET Core console app or .NET Standard class library.
    - With your exisiting SDK-style project.
    - With the templates in the repo's [Tests](../../Tests) folder.

2. Replace `Microsoft.NET.Sdk` with `MSBuild.NET.Extras.Sdk` to the project's top-level `Sdk` attribute.
3. Then you can edit the `TargetFramework` to a different TFM, or you can rename `TargetFramework` to `TargetFrameworks` and specify multiple TFM's with a `;` separator.

That's it. You do not need to specify the UWP or Tizen meta-packages as they'll be automatically included.
After that, you can use the `Restore`, `Build`, `Pack` targets to restore packages, build the project and create NuGet packages. E.g.: `msbuild /t:Pack ...`

#### Important to Note

- It will only work with Visual Studio IDE (Windows/Mac) as it requires the desktop `msbuild` and the target Platform SDKs which are not cross platform.
- It might work in Visual Studio Code, but you have to configure build tasks in `launch.json` to use desktop `msbuild` to build.
- You must install the tools of the platforms you intend to build. For Xamarin, that means the Xamarin Workload; for UWP install those tools as well.

If you want to use a specific version of the Sdk, you can do so like this:

```xml
<Project Sdk="MSBuild.NET.Extras.Sdk/1.1.0">
  <PropertyGroup>
    <TargetFramework>net46</TargetFramework>
  </PropertyGroup>
</Project>
```

Then again, you might not want to do that for every project in your solution. So, you can put the version in a `global.json` file next to your solution like this:

```json
{
    "msbuild-sdks": {
        "MSBuild.NET.Extras.Sdk": "1.1.0"
    }
}
```

Then, all of your project files, from that directory forward, uses the version from the `global.json` file.

More information on how SDK's are resolved can be found [here](https://docs.microsoft.com/en-us/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved).

### The old way (VS pre-15.6)

For those who are using in a `PackageReference` style, you can't do that with v2.0+ of this package. So update VS to 15.6+ and manually upgrade your projects as shown below:

1. The same as above, replace the Sdk attribute's value.
2. Remove the workaround import specified with the old way. The import property should be `MSBuildSdkExtrasDotNet`.
3. Do a trial build and then compare your project with the templates in the repo's [Tests](../../Tests) folder to troubleshoot any issues if you encounter them.
4. Please file a issue if you can't troubleshoot on your own. So, that I can help you with the issue you are facing.

Your previous project:

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <!-- OTHER PROPERTIES -->
  <PropertyGroup>
    <TargetFramework>net46</TargetFramework>
  </PropertyGroup>

  <!-- OTHER PACKAGES/INCLUDES -->
  <ItemGroup>
    <PackageReference Include="MSBuild.NET.Extras.Sdk" Version="1.0.0" PrivateAssets="All"/>
  </ItemGroup>

  <!-- OTHER IMPORTS -->
  <Import Project="$(MSBuildSdkExtrasDotNet)" Condition="Exists('$(MSBuildSdkExtrasDotNet)')" />
  <!-- OTHER IMPORTS -->
</Project>
```

Migrated project:

```xml
<Project Sdk="MSBuild.NET.Extras.Sdk">
  <!-- OTHER PROPERTIES -->
  <PropertyGroup>
    <TargetFramework>net46</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
  <!-- OTHER PACKAGES/INCLUDES -->
  </ItemGroup>

  <!-- OTHER IMPORTS -->
</Project>
```

## Single or multi-targeting

Once this package is configured, you can now use any supported TFM in your `TargetFramework` or `TargetFrameworks` element. The supported TFM families are:

- `netstandard` (.NET Standard)
- `netcoreapp` (.NET Core App)
- `net` (.NET Framework)
- `net35-client`/`net40-client` (.NET Framework legacy Client profile)
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
- `portableNN-`/`portable-` (legacy PCL profiles like `portable-net45+win8+wpa81+wp8`)

 For legacy PCL profiles, the order of the TFM's in the list does not matter but the profile must be an exact match to one of the known profiles. If it's not, you'll get a compile error saying it's unknown. You can see the full list of known profiles here: [Portable Library Profiles by Stephen Cleary](https://portablelibraryprofiles.stephencleary.com/).

 If you try to use a framework that you don't have tools installed for, you'll get an error as well saying to check the tools. In some cases this might mean installing an older version of Visual Studio IDE (_like 2015_) to ensure that the necessary targets are installed on the machine.
