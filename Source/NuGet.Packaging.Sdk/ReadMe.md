# NuGet.Packaging.Sdk

An MSBuild SDK package that provides NuGet package authoring, reference support and dependency management to the projects.
You use this SDK primarily to author NuGet packages, but it also supports NuGet Pack and Restore for common MSBuild projects.
Thus, you can use it directly on your project (_or via the platform SDKs which refer to this SDK internally_) for NuGet support.

It's basically an SDK wrapper around [NuGet.Build.Packaging](https://github.com/NuGet/NuGet.Build.Packaging) aka NuGetizer-3000 project, with NuGet Restore and Pack targets optimized for SDK-style.

[![NuGet.Packaging.Sdk](https://img.shields.io/myget/msbuild-sdks/v/NuGet.Packaging.Sdk.svg)](https://myget.org/feed/msbuild-sdks/package/nuget/NuGet.Packaging.Sdk)
