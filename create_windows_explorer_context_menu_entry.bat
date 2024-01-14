@echo off
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_PATH=%SCRIPT_DIR%video-compressor.bat"
set "SCRIPT_PATH=!SCRIPT_PATH:\=\\!"
set "REGEDIT_FILE=%SCRIPT_DIR%add_to_windows_explorer_context_menu.reg"

echo Windows Registry Editor Version 5.00> %REGEDIT_FILE%
echo [HKEY_CLASSES_ROOT\Directory\shell\CompressVideosDaviShibaAPBR]>> %REGEDIT_FILE%
echo @="Compress Videos in this Folder">> %REGEDIT_FILE%
echo [HKEY_CLASSES_ROOT\Directory\shell\CompressVideosDaviShibaAPBR\command]>> %REGEDIT_FILE%
echo @="\"%SCRIPT_PATH%\" \"%%1\"">> %REGEDIT_FILE%

regedit /s "%REGEDIT_FILE%"

set "SCRIPT_PATH=%SCRIPT_DIR%loop.bat"
set "SCRIPT_PATH=!SCRIPT_PATH:\=\\!"
set "REGEDIT_FILE=%SCRIPT_DIR%add_to_windows_explorer_context_menu_loop.reg"

echo Windows Registry Editor Version 5.00> %REGEDIT_FILE%
echo [HKEY_CLASSES_ROOT\Directory\shell\CompressVideosDaviShibaAPBR_LOOP]>> %REGEDIT_FILE%
echo @="Compress Videos in this Folder - LOOP">> %REGEDIT_FILE%
echo [HKEY_CLASSES_ROOT\Directory\shell\CompressVideosDaviShibaAPBR_LOOP\command]>> %REGEDIT_FILE%
echo @="\"%SCRIPT_PATH%\" \"%%1\"">> %REGEDIT_FILE%

regedit /s "%REGEDIT_FILE%"

endlocal

echo. 
echo Windows Explorer context menu items created successfully!
echo.
pause


