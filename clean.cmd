@echo Off

REM Set Paths
call build-env

REM Clear Build Outputs
if exist %BuildDir% rmdir /Q /S %BuildDir%
if exist %PackageDir% rmdir /Q /S %PackageDir%

REM Set Variable
set NUGET_PACKAGES_PATH=%USERPROFILE%\.nuget\packages\

for %%G in (%NUGET_PACKAGES_PATH%msbuild.*.sdk) do (
	REM Display the Path
	echo %%G
	REM Clear Package from Cache
	rmdir /Q /S %%G
)

REM Verify
PAUSE