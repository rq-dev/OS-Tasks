@echo off

if "%1" == "/?" goto :H

if "%1" == "" goto :H
 
if not exist %1 (
       echo Error! Directory doesn't exist. Select another one.
	   echo for more info use /?
       exit /b 
)

for /R %1 %%f in (*.txt) do ( 
setlocal
set tmpnametxt=%username%%date%%RANDOM%%RANDOM%%RANDOM%%COMPUTERNAME%
      win_iconv -f  CP866 -t UTF-8 %%f > %%f%tmpnametxt%-utf8.txt
      copy %%f%tmpnametxt%-utf8.txt %%f > nul
	  del %%f%tmpnametxt%-utf8.txt
endlocal
)

echo Done!
exit /b

:H 
    echo encovert.cmd [directory]
    echo Convert txt files from cp866 to utf-8 in full directory.
	echo win_iconv.exe need to be installed.
    exit /b
