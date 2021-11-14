# MSBuild.Common.Sdk

## Summary

Support projects that do not compile to an assembly. This is usually the base SDK for other SDKs in this repository.

### Package Name: `MSBuild.Common.Sdk`

[![MSBuild.Common.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.Common.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.Common.Sdk)
[![MSBuild-SDKs](https://img.shields.io/badge/msbuild--sdks-myget-brightgreen.svg)](https://myget.org/gallery/msbuild-sdks)

### Getting started (VS 15.6+)

Visual Studio 2017 Update 6 (aka _v15.6_) includes support for SDK's resolved from NuGet. That makes using the custom SDKs much easier.

#### Using the SDK

1. Create a new project
    - from `dotnet new` templates.
    - With your existing SDK-style project.

2. Replace `Microsoft.NET.Sdk` with `MSBuild.Common.Sdk` to the project's top-level `Sdk` attribute.

3. You have to tell MSBuild that the `Sdk` should resolve from NuGet by
    - Adding a `global.json` containing the SDK name and version.
    - Appending a version info to the `Sdk` attribute value.

4. Remove the `TargetFramework(s)` and other .NET specific properties from the project file. Older versions of VS IDE might require `TargetFramework(s)` property to open the project in IDE successfully.

5. Then you can add custom properties, items, tasks and targets and use the project for various purposes other than building a .NET assembly.

The final project should look like this:

```xml
<Project Sdk="MSBuild.Common.Sdk" DefaultTargets="Greet">

    <PropertyGroup>
        <Greeting>Hello, World!</Greeting>
    </PropertyGroup>

    <Target Name="Greet">
      <Message Importance="High" Text="$(Greeting)"/>
    </Target>

</Project>
```

You can put the `global.json` file next to your solution:

```json
{
    "msbuild-sdks": {
        "MSBuild.Common.Sdk": "1.0.0"
    }
}
```

Then, all of your project files, from that directory forward, uses the version from the `global.json` file.
This would be a preferred solution for all the projects in your solution.

Then again, you might want to override the version for just one project _OR_ if you have only one project in your solution (without adding `global.json`), you can do so like this:

```xml
<Project Sdk="MSBuild.Common.Sdk/1.0.0" DefaultTargets="Greet">

    <PropertyGroup>
        <Greeting>Hello, World!</Greeting>
    </PropertyGroup>

    <Target Name="Greet">
      <Message Importance="High" Text="$(Greeting)"/>
    </Target>

</Project>
```

That's it. You do not need to specify any default properties or items as they'll be automatically defined.
After that, you can use the `Greet` to display the greeting message (_in my example_) or roll your own targets to do things that you want. E.g.: `msbuild -t:DoWork ...`

#### Important to Note

- It will only work with Visual Studio IDE (Windows/Mac) as it requires the desktop `msbuild` and the target Platform SDKs which are not cross-platform.
- It might work in Visual Studio Code, but you have to configure build tasks in `launch.json` to use desktop `msbuild` to build.
- You must install the tools of the platforms you intend to build. For Xamarin, that means the Xamarin Workload; for UWP install those tools as well.

More information on how SDK's are resolved can be found [here](https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved).
