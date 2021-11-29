# MSBuild.NET.Inbox.Sdk

## Summary

An MSBuild SDK package that redirects to props and targets that comes **inbox** with .NET Framework.
This SDK package is mostly used for testing and for compiling exclusively with the Full Framework MSBuild.

### Package Name: `MSBuild.NET.Inbox.Sdk`

[![MSBuild.NET.Inbox.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Inbox.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Inbox.Sdk)
[![MSBuild.NET.Inbox.Sdk](https://img.shields.io/nuget/v/MSBuild.NET.Inbox.Sdk.svg)](https://nuget.org/packages/MSBuild.NET.Inbox.Sdk)

### Getting started

Visual Studio v15.6+ includes support for SDK's resolved from NuGet.
That makes using the custom SDKs much easier.

See [Using MSBuild project SDKs][msbuild-sdk-usage] guide on [Microsoft Docs](https://docs.ms) for more information on how project SDKs work and [how project SDKs are resolved][msbuild-sdk-resolver].

[msbuild-sdk-usage]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk
[msbuild-sdk-resolver]: https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved

#### Using the SDK

1. Open your existing MSBuild v4 legacy project (_in your code editor of your choice_).

2. Remove the top `Import` element that imports `Microsoft.Common.props`, probably located just below the root `<Project>` element.

3. Remove the bottom `Import` element that imports `Microsoft.{Common/CSharp/FSharp/VisualBasic}.targets`, probably located just above the root `</Project>` element.

4. You can add the SDK import in four ways…

   First, Remove unnecessary attributes like `xmlns`, `DefaultTargets` (_if only `Build`_) and `ToolsVersion` (_if only v15+_).
   Keep any the other attributes if you have specified.
   Then add the SDK reference as per the following diffs.

   **Using the `Sdk` attribute in the `Project` element:**

   ```diff
   -<Project ToolsVersion="4.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   +<Project Sdk="MSBuild.NET.Inbox.Sdk">
   -  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')"/>

      <!-- Properties/Items/Targets -->

   -  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets"/>
    </Project>
   ```

   **Using the `Sdk` element under the `Project` element:**

   ```diff
   -<Project ToolsVersion="4.0" DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   +<Project>

   -  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')"/>
   +  <Sdk Name="MSBuild.NET.Inbox.Sdk">

      <!-- Properties/Items/Targets -->

   -  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets"/>
    </Project>
   ```

   **Using explicit top and bottom imports with auto targets resolution:**

   ```diff
   -<Project ToolsVersion="4.0" DefaultTargets="Build" InitialTargets="DoWork" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   +<Project InitialTargets="DoWork">

   -  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')"/>
   +  <Import Sdk="MSBuild.NET.Inbox.Sdk" Project="Sdk.props"/>

      <!-- Properties/Items/Targets -->

   -  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets"/>
   +  <Import Sdk="MSBuild.NET.Inbox.Sdk" Project="Sdk.targets"/>

      <Target Name="DoWork">
        <!-- Custom target logic -->
      </Target>
    </Project>
   ```

   **Using explicit top and bottom imports with named targets:**

   ```diff
   -<Project ToolsVersion="4.0" DefaultTargets="Build" InitialTargets="DoWork" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   +<Project InitialTargets="DoWork">

   -  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')"/>
   +  <Import Sdk="MSBuild.NET.Inbox.Sdk" Project="Microsoft.Common.props"/>

      <!-- Properties/Items/Targets -->

   -  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets"/>
   +  <Import Sdk="MSBuild.NET.Inbox.Sdk" Project="Microsoft.CSharp.targets"/>

      <Target Name="DoWork">
        <!-- Custom target logic -->
      </Target>
    </Project>
   ```

5. Finally, You have to tell MSBuild that the `Sdk` should resolve from NuGet by
    - Adding a `global.json` containing the SDK name and version.
    - Appending a version info to the `Sdk` attribute value.

   You can put the SDK version in the `global.json` file next to your solution:

   ```json
   {
       "msbuild-sdks": {
           "MSBuild.NET.Inbox.Sdk": "1.0.0"
       }
   }
   ```

   Then, all of your project files, from that directory forward, uses the version from the `global.json` file.
   This would be a preferred solution for all the projects in your solution.

   Then again, you might want to override the version for just one project **OR** if you have only one project in your solution (_without adding `global.json`_), you can do so like this:

   ```xml
   <Project Sdk="MSBuild.NET.Inbox.Sdk/1.0.0">
     <!-- Properties/Items/Targets -->
   </Project>
   ```

That's it! After that, you can use the `Build` target to build the projects: e.g., `msbuild -t:Build ...`.

#### Important to Note

- It will only work with Visual Studio IDE (Windows/Mac) as it requires the desktop `msbuild` and the target Platform SDKs which are not cross-platform.
- It might work in Visual Studio Code, but you have to configure build tasks in `launch.json` to use desktop `msbuild` to build.
