@echo Off

REM Set Paths
set RepoDir=%~dp0
set RepoDir=%RepoDir:~0,-1%

set BuildDir=~Builds
set PackageDir=~Packages
set BuildLog=msbuild.binlog

REM Done