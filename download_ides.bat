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
    set "NAME=Trae_Intl"
    set "FILENAME=Trae-Setup-x64.exe"
    set "URL=https://api.trae.ai/download/stable/windows/x64"
    set "PAGE_URL=https://www.trae.ai/download"
    goto StartDownload
)

if "!choice!"=="2" (
    set "NAME=Trae_CN"
    set "FILENAME=Trae-CN-Setup-x64.exe"
    set "URL=https://api.trae.cn/download/stable/windows/x64"
    set "PAGE_URL=https://www.trae.cn/download"
    goto StartDownload
)

if "!choice!"=="3" (
    set "NAME=Cursor_IDE"
    set "FILENAME=CursorSetup.exe"
    set "URL=https://downloader.cursor.sh/windows/nsis/x64"
    set "PAGE_URL=https://cursor.com/download"
    goto StartDownload
)

if "!choice!"=="4" (
    set "NAME=Antigravity_IDE"
    set "FILENAME=Antigravity-Setup-x64.exe"
    set "URL=https://antigravity.google/download"
    set "PAGE_URL=https://antigravity.google/download"
    goto StartDownload
)

if "!choice!"=="0" exit /b

if not "!choice!"=="" (
    echo.
    echo [ERROR] 无效的选择: !choice!
    timeout /t 2 >nul
)
goto MENU

:StartDownload
echo.
echo 正在准备下载 !NAME!...
echo 目标文件: !DOWNLOAD_DIR!\!FILENAME!
echo.
echo 正在尝试下载 (请稍候)...
echo.

curl -L -A "Mozilla/5.0" -o "!DOWNLOAD_DIR!\!FILENAME!" "!URL!"

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
goto MENU
