@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

set "DOWNLOAD_DIR=%~dp0downloads"
if not exist "!DOWNLOAD_DIR!" mkdir "!DOWNLOAD_DIR!"

:MENU
cls
echo ========================================
echo   AI_IDE_Downloader
echo ========================================
echo.
echo 请选择要下载的软件：
echo.
echo   1. Trae_Intl
echo   2. Trae_CN
echo   3. Cursor_IDE
echo   4. Antigravity_IDE
echo.
echo   0. 返回
echo.
echo ----------------------------------------
echo 下载目录: !DOWNLOAD_DIR!
echo ----------------------------------------
echo.
set "choice="
set /p choice=请输入选项编号: 

if "!choice!"=="1" (
    call :DownloadProcess "Trae 国际版" "Trae-Setup-x64.exe" "https://api.trae.ai/download/stable/windows/x64" "https://www.trae.ai/download"
    goto MENU
)

if "!choice!"=="2" (
    call :DownloadProcess "Trae 中文版" "Trae-CN-Setup-x64.exe" "https://api.trae.cn/download/stable/windows/x64" "https://www.trae.cn/download"
    goto MENU
)

if "!choice!"=="3" (
    call :DownloadProcess "Cursor IDE" "CursorSetup.exe" "https://downloader.cursor.sh/windows/nsis/x64" "https://cursor.com/download"
    goto MENU
)

if "!choice!"=="4" (
    call :DownloadProcess "Antigravity IDE" "Antigravity-Setup-x64.exe" "https://antigravity.google/download" "https://antigravity.google/download"
    goto MENU
)

if "!choice!"=="0" exit /b

if not "!choice!"=="" (
    echo.
    echo [ERROR] 无效的选择: !choice!
    timeout /t 2 >nul
)
goto MENU

:DownloadProcess
set "NAME=%~1"
set "FILENAME=%~2"
set "URL=%~3"
set "PAGE_URL=%~4"

echo.
echo 正在准备下载 !NAME!...
echo 目标文件: !DOWNLOAD_DIR!\!FILENAME!
echo.
echo 正在使用 PowerShell 下载 (请稍候)...

powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { $client = New-Object System.Net.WebClient; $client.Headers.Add('User-Agent', 'Mozilla/5.0'); $client.DownloadFile('!URL!', '!DOWNLOAD_DIR!\!FILENAME!'); exit 0 } catch { Write-Error $_.Exception.Message; exit 1 }"

if !errorlevel! equ 0 (
    echo.
    echo [OK] 下载完成: !DOWNLOAD_DIR!\!FILENAME!
    set /p install=是否现在安装? (Y/N): 
    if /i "!install!"=="Y" start "" "!DOWNLOAD_DIR!\!FILENAME!"
) else (
    echo.
    echo [ERROR] 直接下载失败，正在为您打开官方下载页面...
    start "" "!PAGE_URL!"
    pause
)
goto :eof
