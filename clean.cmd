@echo Off

REM Set Paths
call build-env

REM Clear Build Outputs
if exist %BuildLog% del /Q /F %BuildLog%
if exist %BuildDir% rmdir /Q /S %BuildDir%
if exist %PackageDir% rmdir /Q /S %PackageDir%

REM Set Variable
set NUGET_PACKAGES_PATH=%USERPROFILE%\.nuget\packages

set MSBUILD_SDKS_NUGET_PATH=%NUGET_PACKAGES_PATH%\msbuild.*.sdk
set NUGET_SDKS_NUGET_PATH=%NUGET_PACKAGES_PATH%\nuget.*.sdk
set MSBUILD_ITEMS_SDKS_NUGET_PATH=%NUGET_PACKAGES_PATH%\msbuild.*.defaultitems

for /d %%G in (%MSBUILD_SDKS_NUGET_PATH%, %NUGET_SDKS_NUGET_PATH%, %MSBUILD_ITEMS_SDKS_NUGET_PATH%) do (
	REM Display the Path
	echo Deleting %%G ...
	REM Clear Package from Cache
	rmdir /Q /S %%G
)

REM Verify
PAUSE

REM Done