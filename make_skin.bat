@echo off
setlocal

:: Set variables for current date
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
    set "day=%%a"
    set "month=%%b"
    set "year=%%c"
)

:: Format the day and month without leading zeros if needed
set "day=%day:~0,2%"
set "month=%month:~0,2%"
if "%day:~0,1%"=="0" set "day=%day:~1%"
if "%month:~0,1%"=="0" set "month=%month:~1%"

:: Set output filename with formatted date
set "outputName=Shige Seoul - %day%_%month%_%year%"

:: Create a temporary file listing all files except the batch file
dir /b /a-d > temp_file_list.txt
findstr /v /i "%~nx0" temp_file_list.txt > files_to_zip.txt

:: Create zip file excluding the batch file
powershell -command "$files = Get-Content -Path 'files_to_zip.txt'; Compress-Archive -Path $files -DestinationPath '%outputName%.zip' -Force"

:: Rename from .zip to .osk
ren "%outputName%.zip" "%outputName%.osk"

:: Clean up temporary files
del temp_file_list.txt
del files_to_zip.txt

echo Done! Created "%outputName%.osk"
pause