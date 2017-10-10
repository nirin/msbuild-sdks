@echo Off

REM Set Root Path
set WD=%~dp0

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
call %nuget% pack %WD%MSBuild.NET.Extras.Sdk\MSBuild.NET.Extras.Sdk.nuspec -OutputDirectory %WD%Packages %version%

REM Check MyGet
if not "%BuildRunner%" == "MyGet" (
	REM Push Package
	call %nuget% push %WD%Packages\*.nupkg
)