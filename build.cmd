@echo Off

REM Set Paths
call build-env

REM Check MyGet
if not "%BuildRunner%" == "MyGet" (
	REM Enable VS DevEnv
	call vsdev
) else (
	set MSBuildSDKsPath=%WD%Source
)

REM Set Vars
set SolutionFile=%WD%MSBuild.Sdks.sln

if "%Configuration%" == "" (
	set Configuration=Release
)

REM Remove Leading Zeros from BuildCounter
for /F "tokens=* delims=0" %%A in ("%BuildCounter%") do set BuildCounter=%%A
if "%BuildCounter%"=="" set BuildCounter=0

set BuildVersion=
if not "%BuildCounter%" == "" (
	set BuildVersion=;VersionMeta=dev.%BuildCounter%
)

REM Build
call msbuild %SolutionFile% /p:Configuration=%Configuration%%BuildVersion%

REM Check MyGet
if not "%BuildRunner%" == "MyGet" (
	REM Push Package
	call nuget push %PackageDir%\%Configuration%\*.nupkg -Source Local
)