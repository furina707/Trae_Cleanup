@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

set "DOWNLOAD_DIR=%~dp0downloads"
if not exist "!DOWNLOAD_DIR!" mkdir "!DOWNLOAD_DIR!"

:MENU
cls
echo ========================================
echo   AI IDE 下载助手 (Trae, Cursor, Antigravity)
echo ========================================
echo.
echo 请选择要下载的软件：
echo.
echo   1. Trae 国际版 (Official Website)
echo   2. Trae 中文版 (Official Website)
echo   3. Cursor IDE (Direct Download)
echo   4. Antigravity IDE (Official Website)
echo.
echo   0. 返回
echo.
echo ----------------------------------------
echo 下载目录: !DOWNLOAD_DIR!
echo ----------------------------------------
echo.
set /p choice=请输入选项编号: 

if "%choice%"=="1" (
    call :DownloadProcess "Trae 国际版" "Trae-Setup-x64.exe" "https://lf-cdn.trae.ai/obj/trae-ai-us/pkg/app/releases/stable/1.0.27572/win32/Trae-Setup-x64.exe" "https://www.trae.ai/download"
    goto MENU
)

if "%choice%"=="2" (
    call :DownloadProcess "Trae 中文版" "Trae-CN-Setup-x64.exe" "https://lf-cdn.trae.com.cn/obj/trae-com-cn/pkg/app/releases/stable/1.0.27572/win32/Trae-Setup-x64.exe" "https://www.trae.cn/download"
    goto MENU
)

if "%choice%"=="3" (
    call :DownloadProcess "Cursor IDE" "CursorSetup.exe" "https://downloader.cursor.sh/windows/nsis/x64" "https://cursor.com/download"
    goto MENU
)

if "%choice%"=="4" (
    call :DownloadProcess "Antigravity IDE" "Antigravity-Setup-x64.exe" "https://antigravity.google/download" "https://antigravity.google/download"
    goto MENU
)

if "%choice%"=="0" exit /b
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

powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '!URL!' -OutFile '!DOWNLOAD_DIR!\!FILENAME!' -UserAgent 'Mozilla/5.0' -ErrorAction Stop; exit 0 } catch { exit 1 }"

if !errorlevel! equ 0 (
    echo.
    echo [OK] 下载完成: !DOWNLOAD_DIR!\!FILENAME!
    set /p install=是否现在安装? (Y/N): 
    if /i "!install!"=="Y" start "" "!DOWNLOAD_DIR!\!FILENAME!"
) else (
    echo.
    echo [ERROR] 直接下载失败，正在为您打开官方下载页面...
    start !PAGE_URL!
    pause
)
goto :eof
