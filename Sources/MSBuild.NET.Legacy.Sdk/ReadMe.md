# MSBuild.NET.Legacy.Sdk

## Summary

An MSBuild SDK package that has updated __legacy__ props and targets that came inbox with .NET Framework.
This SDK package is mostly used for testing and for compiling exclusively with the X-Platform MSBuild.
Use them to slowly migrate your legacy projects to SDK-style.

### Package Name: `MSBuild.NET.Legacy.Sdk`

[![MSBuild.NET.Legacy.Sdk](https://img.shields.io/myget/msbuild-sdks/v/MSBuild.NET.Legacy.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/MSBuild.NET.Legacy.Sdk)

### Getting started

Visual Studio v15.6+ includes support for SDK's resolved from NuGet. That makes using the custom SDKs much easier.

#### Using the SDK

1. Open your existing MSBuild v12, v14 and v15+ legacy project (_in your code editor of your choice_).

2. Remove the top `Import` element that imports `Microsoft.Common.props`, probably located just below the root `<Project>` element.

3. Remove the bottom `Import` element that imports `Microsoft.{Common/CSharp/FSharp/VisualBasic}.targets`, probably located just above the root `</Project>` element.

4. You can add the SDK import in two ways, either through the `Sdk` attribute in the `Project` element which implicitly imports the `Sdk.{props/targets}` or through explicit top and bottom imports in the project file. Finally, Remove unnecessary attributes like `xmlns`, `DefaultTargets` (_if it's only `Build`_) and `ToolsVersion`. Keep any the other attributes if you have specified.

   Here's the diff between your old and new project file following the above rules should look like...

   **Using the SDK attribute in project element**

   ```diff
   -<Project ToolsVersion="15.0" DefaultTargets="Build">
   +<Project Sdk="MSBuild.NET.Legacy.Sdk">
   -  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')"/>

      <!-- Properties/Items/Targets -->

   -  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets"/>
    </Project>
   ```

   **Using explicit top and bottom imports with auto targets resolution**

   ```diff
   -<Project ToolsVersion="14.0" DefaultTargets="Build" InitialTargets="Validate" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   +<Project InitialTargets="Validate">
   -  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')"/>
   +  <Import Sdk="MSBuild.NET.Legacy.Sdk" Project="Sdk.props"/>

      <!-- Properties/Items/Targets -->

   -  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets"/>
   +  <Import Sdk="MSBuild.NET.Legacy.Sdk" Project="Sdk.targets"/>
      <Target Name="Validate">
      <!-- Your custom target -->
      </Target>
    </Project>
   ```

   **Using explicit top and bottom imports using named targets**

   ```diff
   -<Project ToolsVersion="12.0" DefaultTargets="Build" InitialTargets="Validate" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
   +<Project InitialTargets="Validate">
   -  <Import Project="$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props" Condition="Exists('$(MSBuildExtensionsPath)\$(MSBuildToolsVersion)\Microsoft.Common.props')"/>
   +  <Import Sdk="MSBuild.NET.Legacy.Sdk" Project="Microsoft.Common.props"/>

      <!-- Properties/Items/Targets -->

   -  <Import Project="$(MSBuildToolsPath)\Microsoft.CSharp.targets"/>
   +  <Import Sdk="MSBuild.NET.Legacy.Sdk" Project="Microsoft.CSharp.targets"/>
      <Target Name="Validate">
      <!-- Your custom target -->
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
           "MSBuild.NET.Legacy.Sdk": "1.0.0"
       }
   }
   ```

   Then, all of your project files, from that directory forward, uses the version from the `global.json` file.
   This would be a preferred solution for all the projects in your solution.

   Then again, you might want to override the version for just one project _OR_ if you have only one project in your solution (without adding `global.json`), you can do so like this:

   ```xml
   <Project Sdk="MSBuild.NET.Legacy.Sdk/1.0.0">

     <!-- Properties/Items/Targets -->

   </Project>
   ```

That's it. After that, you can use the `Build` target to build the projects. E.g.: `msbuild -t:Build ...`

#### Important to Note

- It will only work with Visual Studio IDE (Windows/Mac) as it requires the desktop `msbuild` and the target Platform SDKs which are not cross-platform.
- It might work in Visual Studio Code, but you have to configure build tasks in `launch.json` to use desktop `msbuild` to build.

More information on how SDK's are resolved can be found [here](https://docs.microsoft.com/visualstudio/msbuild/how-to-use-project-sdk#how-project-sdks-are-resolved).
