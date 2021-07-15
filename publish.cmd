@echo Off

REM Set Vars
set BuildCounter=%1
set IsCloudBuild=true
set Configuration=Release

REM Do Build
call build
if ERRORLEVEL 1 exit /b

REM Build Done
PAUSE

REM Set Vars
set PackageSource=%2
set Packages=%PackageDir%\%Configuration%\*.%BuildCounter%.nupkg

REM Push Package
if "%PackageSource%" == "Local" (
	call nuget push %Packages% -Source Local
) elseif "%PackageSource%" == "MyGet" (
	call nuget push %Packages% %MYGET_API_KEY% -Source MyGet
) else (
	echo "The Package source (%PackageSource%) is not recommended! Please use either 'Local' or 'MyGet'."
)

REM Done
PAUSE