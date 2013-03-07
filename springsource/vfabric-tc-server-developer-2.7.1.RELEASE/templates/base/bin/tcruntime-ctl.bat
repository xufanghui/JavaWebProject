@echo off

rem ---------------------------------------------------------------------------
rem Copyright (c) 2010 VMware, Inc.  All rights reserved.
rem ---------------------------------------------------------------------------

rem Stub for case when C.B == C.H
rem The "instance" name is the actual Tomcat install
rem location

setlocal

rem %~dp0 is location of current script under NT
set _REALPATH=%~dp0
cd %_REALPATH%
cd ..\..
set TOP_LEVEL=%cd%

cd %_REALPATH%
cd ..
set INSTANCE_LEVEL=%cd%


set INSTALL_BASE=${runtime.directory}

if "%INSTANCE_BASE%" == "" (
  set INSTANCE_BASE=%TOP_LEVEL%
)

rem Guess the instance name here

:guess
  If "%INSTANCE_LEVEL%" == "" GoTo :doneguess
  For /F "tokens=1* delims=\" %%a in ("%INSTANCE_LEVEL%") Do set INSTANCE_NAME=%%a
  For /F "tokens=1* delims=\" %%a in ("%INSTANCE_LEVEL%") Do set INSTANCE_LEVEL=%%b
  GoTo :guess

:doneguess
  echo Derived instance name:  %INSTANCE_NAME%
  goto endguess
  
:endguess  


set PROGRAM1=%INSTALL_BASE%\tcruntime-ctl.bat
set PROGRAM2=%TOP_LEVEL%\tcruntime-ctl.bat

if EXIST "%PROGRAM1%" (
    set PROGRAM=%PROGRAM1%
) else if EXIST "%PROGRAM2%" (
    set PROGRAM=%PROGRAM2%
) else (
    echo ERROR Cannot find "%PROGRAM1%" to execute or
    echo ERROR Cannot find "%PROGRAM2%" to execute 
    endlocal
    set INSTANCE_BASE=
    exit /b 1
) 

"%PROGRAM%" %INSTANCE_NAME% %1
