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
    echo.
    echo 正在打开 Trae 国际版下载页面...
    start https://www.trae.ai/download
    echo 如果页面没有自动下载，请点击页面上的 Download 按钮。
    pause
    goto MENU
)

if "%choice%"=="2" (
    echo.
    echo 正在打开 Trae 中文版下载页面...
    start https://www.trae.cn/download
    echo 如果页面没有自动下载，请点击页面上的立即下载按钮。
    pause
    goto MENU
)

if "%choice%"=="3" (
    echo.
    echo 正在准备下载 Cursor IDE...
    set "filename=CursorSetup.exe"
    set "url=https://downloader.cursor.sh/windows/nsis/x64"
    echo 目标文件: !DOWNLOAD_DIR!\!filename!
    echo 下载地址: !url!
    echo.
    echo 正在使用 PowerShell 下载 (请稍候)...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '!url!' -OutFile '!DOWNLOAD_DIR!\!filename!'"
    if !errorlevel! equ 0 (
        echo.
        echo [OK] 下载完成: !DOWNLOAD_DIR!\!filename!
        echo 是否现在安装? (Y/N)
        set /p install=
        if /i "!install!"=="Y" start "" "!DOWNLOAD_DIR!\!filename!"
    ) else (
        echo.
        echo [ERROR] 下载失败，请检查网络连接或手动下载。
        echo 手动下载地址: https://cursor.com/download
        pause
    )
    goto MENU
)

if "%choice%"=="4" (
    echo.
    echo 正在打开 Antigravity IDE 下载页面...
    start https://antigravity.google/download
    echo 请在浏览器中选择适合你架构的版本下载。
    pause
    goto MENU
)

if "%choice%"=="0" exit /b
goto MENU
