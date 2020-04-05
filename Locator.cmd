@echo off
setlocal

if "%1" == "/?" goto :H

set filename=%~nx1
set name=if /I "%~x1" neq "" if /I "!pathext:%~x1=!" neq "%pathext%" set name="";

for %%t in (%name%%pathext%) do (
	for %%e in ("%filename%%%t") do (
		if not "%%~$path:e" == "" (
			if not exist "%%~$path:e\" (
			    echo %1 is an external command)
				exit /b
				)
			)
		)
	)

if not "%~1"=="" ( 
	help "%~1" >nul 
	if ERRORLEVEL 1 ( 		
				echo %~1 is an internal command 
				exit/b
		)	
	) 				
) 

for %%a in (%name%%pathext%) do (
	for %%b in ("%cd%\%filename%%%~a") do (
		if exist "%%b" if not exist "%%~b\" (
			echo %%~b
			exit /b
		)
	)
)

if "%1"=="" (
	for %%a in (%pathext%) do (
		for %%b in ("%cd%\%%a") do (
			if exist "%%b" if not exist "%%b\" (
				echo %%b
				exit /b
			)
		)
	)
	echo Arguments not found!
	goto :H
	exit /b
)

set roma=%~f1
if exist %roma% (echo %roma%) else (
echo %filename% is not an internal or an external command.)

endlocal
exit/b

:H
 echo          ^<^<^<Locator.CMD HELP^>^>^>
 echo   Locator.cmd [command/programm]
 echo   Locator.cmd shows type of cmd command (internal/external) and shows path to external command.
 echo   Программа работает не совсем некорректно) sorry.
 exit /b
