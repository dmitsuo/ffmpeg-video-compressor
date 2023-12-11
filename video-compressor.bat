@echo off
setlocal enabledelayedexpansion

echo.
echo   ##################################################################
echo   ##                                                              ##
echo   ##                  FFMPEG VIDEO COMPRESSOR                     ##
echo   ##                                                              ##
echo   ##################################################################
echo.

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

REM Create a folder called "converted_videos" inside the source directory
set "dest_dir=%source_dir%\converted_videos"
mkdir "%dest_dir%" 2>nul

REM Parameters that you can change to fit your needs - BEGIN
set "SOURCE_EXTENSIONS=webm ts mp4 mkv avi mov"
set "CPU_USED=12"
set "VIDEO_CONSTANT_RATE_FACTOR=26"
set "AUDIO_BITRATE=32k"
set "AUDIO_SAMPLING_RATE=32000"
set "AUDIO_CHANNELS=1"
REM Parameters that you can change to fit your needs - END

for %%e in (%SOURCE_EXTENSIONS%) do (

  REM Loop through all video files in the source directory
  for %%a in ("%source_dir%\*%%e") do (
    REM Get the file name and extension
    set "file=%%~na"

    REM Build the output file name
    set "output_file=%dest_dir%\!file!.mp4"

    REM Run the ffmpeg command for each file
    echo Compressing "!file!.%%e" ...
    %FFMPEG_BIN% -n -hide_banner -loglevel error -stats -i "%%a" -cpu-used %CPU_USED% -c:v libx264 -preset fast -crf %VIDEO_CONSTANT_RATE_FACTOR% -c:a aac -b:a %AUDIO_BITRATE% -ar %AUDIO_SAMPLING_RATE% -ac %AUDIO_CHANNELS% "!output_file!"    
  )
)

echo All files converted successfully.

set "PAUSE_FLAG=1"

IF NOT "%~2"=="" (
  IF /i x%2 == xNOT_PAUSE (
    set "PAUSE_FLAG=0"
  )
)

if "%PAUSE_FLAG%" == "1" (
  pause
)

endlocal