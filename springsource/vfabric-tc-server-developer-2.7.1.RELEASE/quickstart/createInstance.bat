@echo off
rem ---------------------------------------------------------------------------
rem tc Runtime Quick start script
rem
rem Copyright (c) 2012 VMware, Inc.  All rights reserved.
rem ---------------------------------------------------------------------------

rem createInstance.bat  This Win32 script creates an instance with the user input.
rem                     It will also install and start the service, if indicated by user.
rem version: 2.7.1.RELEASE
rem build date: 20120709182635

setlocal


if "%OS%"=="Windows_NT" GOTO nt
echo This script only works with NT-based versions of Windows.
GOTO eof

:nt
rem
rem Find the application home.
rem
rem %~dp0 is location of current script under NT
SET SCRIPT_DIR=%~dp0%..\
cd "%SCRIPT_DIR%"
SET SCRIPT_DIR=%CD%\

set RUNTIME_DIR=%SCRIPT_DIR:~0,-1%
set INSTANCE_DIR=%CD%

set CLASSPATH=

PUSHD "%SCRIPT_DIR%"lib
FOR %%G IN (*.*) DO CALL:APPEND_TO_CLASSPATH lib %%G
POPD
GOTO :get_JAVAHOME

: APPEND_TO_CLASSPATH
set filename=%~2
set suffix=%filename:~-4%
if %suffix% equ .jar set CLASSPATH=%CLASSPATH%;%SCRIPT_DIR%%~1\%filename%
GOTO eof


:get_JAVAHOME
if NOT "%JAVA_HOME%"=="" GOTO verifyJava

rem Check for Java in registry

:checkRegistry
set KeyName=HKLM\SOFTWARE\JavaSoft\Java Runtime Environment
set VERSION=1.5
reg query "%KeyName%\%VERSION%" > NUL 2>&1
GOTO result%ERRORLEVEL%

:after1.5
set VERSION=1.6
reg query "%KeyName%\%VERSION%" > NUL 2>&1 
GOTO result%ERRORLEVEL%

:after1.6
set VERSION=1.7
reg query "%KeyName%\%VERSION%" > NUL 2>&1
GOTO result%ERRORLEVEL%

:after1.7
echo "Could not find JAVA_HOME variable or in the registry."
GOTO eof

:result0
for /f "tokens=2*" %%i in ('reg query "%KeyName%\%VERSION%" /s ^| find "JavaHome"') do set JAVA_HOME=%%j
GOTO exitRegistry

:result1
GOTO after%VERSION%

:exitRegistry

:verifyJava
rem Check that the correct version of java is being used.
set REQUIRED_VERSION_STRING=1.5
"%JAVA_HOME%/bin/java" -version 2> tmp_java_version.txt
set /p JAVA_VERSION= < tmp_java_version.txt
del tmp_java_version.txt
set JAVA_VERSION=%JAVA_VERSION:~14,3%
set REQUIRED_VERSION=%REQUIRED_VERSION_STRING:~0,3%
if %JAVA_VERSION% LSS %REQUIRED_VERSION% (
  echo Java version must be at least %REQUIRED_VERSION_STRING%
  pause
  GOTO eof
)
GOTO startScript

:startScript

echo JAVA_HOME is set to: %JAVA_HOME%

rem Start the quick start application
"%JAVA_HOME%\bin\java" %JAVA_OPTS% -Druntime.directory="%RUNTIME_DIR%" -Ddefault.instance.directory="%INSTANCE_DIR%" -classpath "%CLASSPATH%" com.springsource.tcruntime.instance.TcQuickstartRunner

rem Check for file, if exists need to start instance.
for /F "tokens=4*" %%d in ('dir ^|find "-install.tmp"') do set FILE_NAME=%%e

if "%FILE_NAME%"=="" GOTO eof


rem Prepare instance to start
set INSTANCE_NAME=%FILE_NAME:~0,-12%

for /F %%n in ('more %FILE_NAME%') DO (
  set USER_INSTANCE_DIR=%%n
  del %FILE_NAME%
)


echo Installing %INSTANCE_NAME% with command: 
echo    %CD%\tcruntime-ctl.bat  %INSTANCE_NAME% install -n %USER_INSTANCE_DIR%
call "%CD%\tcruntime-ctl.bat"  %INSTANCE_NAME% install -n "%USER_INSTANCE_DIR%"


echo Starting %INSTANCE_NAME% with command: 
echo    %CD%\tcruntime-ctl.bat  %INSTANCE_NAME% start -n %USER_INSTANCE_DIR%
call "%CD%\tcruntime-ctl.bat"  %INSTANCE_NAME% start -n "%USER_INSTANCE_DIR%"


:eof
