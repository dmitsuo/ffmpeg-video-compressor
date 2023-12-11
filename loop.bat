@echo off
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "FFMPEG_BIN=%SCRIPT_DIR%ffmpeg.exe"

if not exist "%FFMPEG_BIN%" (
    echo The FFmpeg command line tool is missing. Please download it and copy it to the same folder of this script, then try again.
    pause
    exit /b
)

if not "%~1"=="" (
    set "source_dir=%~1"
) else (
  REM Prompt the user for the source folder
  set /p source_dir=Videos source folder: 
)

REM Check if the source directory exists
if not exist "%source_dir%" (
  echo Source directory does not exist.
  pause
  exit /b
)

REM Checks if there is already an instance of ffmpeg.exe running.
set "programToCheck=ffmpeg.exe"

for /f "tokens=*" %%a in ('tasklist ^| find /i "%programToCheck%"') do (
    set "task=%%a"
)

if not "!task!"=="" (
    ECHO There is already a FFmpeg instance running. Exiting...
    exit /b
)

:loop
REM Calling the actual conversion script
call "%SCRIPT_DIR%video-compressor.bat" "%source_dir%" NOT_PAUSE

REM Wait X segundos (e.g., 5 secs)
timeout /t 5 /nobreak

REM Go back to the beginning
goto loop

endlocal