@echo Off

REM Set Paths
set WD=%~dp0
set BuildDir=%WD%~Builds
set PackageDir=%WD%~Packages
set BuildLog=%WD%msbuild.binlog

REM Done