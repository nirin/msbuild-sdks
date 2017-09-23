@echo Off

REM Check MyGet
if not "%BuildRunner%" == "MyGet" (
	set PackageVersion=%1
	set nuget=nuget.exe
)

REM Set Version
set version=
if not "%PackageVersion%" == "" (
	set version=-Version %PackageVersion%
)

REM Generate Package
call %nuget% pack MSBuild.NET.Extras.Sdk\MSBuild.NET.Extras.Sdk.nuspec -OutputDirectory Packages %version%

REM Check MyGet
if not "%BuildRunner%" == "MyGet" (
	REM Push Package
	call %nuget% push Packages\*.nupkg
)