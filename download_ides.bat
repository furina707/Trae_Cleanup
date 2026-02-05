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
    echo 正在准备下载 Trae 国际版...
    set "filename=Trae-Setup-x64.exe"
    set "url=https://lf-cdn.trae.ai/obj/trae-ai-us/pkg/app/releases/stable/1.0.27572/win32/Trae-Setup-x64.exe"
    echo 目标文件: !DOWNLOAD_DIR!\!filename!
    echo.
    echo 正在使用 PowerShell 下载 (请稍候)...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '!url!' -OutFile '!DOWNLOAD_DIR!\!filename!' -UserAgent 'Mozilla/5.0' -ErrorAction Stop; exit 0 } catch { exit 1 }"
    if !errorlevel! equ 0 (
        echo.
        echo [OK] 下载完成: !DOWNLOAD_DIR!\!filename!
        echo 是否现在安装? (Y/N)
        set /p install=
        if /i "!install!"=="Y" start "" "!DOWNLOAD_DIR!\!filename!"
    ) else (
        echo.
        echo [ERROR] 直接下载失败，正在为您打开官方下载页面...
        start https://www.trae.ai/download
        pause
    )
    goto MENU
)

if "%choice%"=="2" (
    echo.
    echo 正在准备下载 Trae 中文版...
    set "filename=Trae-CN-Setup-x64.exe"
    set "url=https://lf-cdn.trae.com.cn/obj/trae-com-cn/pkg/app/releases/stable/1.0.27572/win32/Trae-Setup-x64.exe"
    echo 目标文件: !DOWNLOAD_DIR!\!filename!
    echo.
    echo 正在使用 PowerShell 下载 (请稍候)...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '!url!' -OutFile '!DOWNLOAD_DIR!\!filename!' -UserAgent 'Mozilla/5.0' -ErrorAction Stop; exit 0 } catch { exit 1 }"
    if !errorlevel! equ 0 (
        echo.
        echo [OK] 下载完成: !DOWNLOAD_DIR!\!filename!
        echo 是否现在安装? (Y/N)
        set /p install=
        if /i "!install!"=="Y" start "" "!DOWNLOAD_DIR!\!filename!"
    ) else (
        echo.
        echo [ERROR] 直接下载失败，正在为您打开官方下载页面...
        start https://www.trae.cn/download
        pause
    )
    goto MENU
)

if "%choice%"=="3" (
    echo.
    echo 正在准备下载 Cursor IDE...
    set "filename=CursorSetup.exe"
    set "url=https://downloader.cursor.sh/windows/nsis/x64"
    echo 目标文件: !DOWNLOAD_DIR!\!filename!
    echo.
    echo 正在使用 PowerShell 下载 (请稍候)...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '!url!' -OutFile '!DOWNLOAD_DIR!\!filename!' -UserAgent 'Mozilla/5.0' -ErrorAction Stop; exit 0 } catch { exit 1 }"
    if !errorlevel! equ 0 (
        echo.
        echo [OK] 下载完成: !DOWNLOAD_DIR!\!filename!
        echo 是否现在安装? (Y/N)
        set /p install=
        if /i "!install!"=="Y" start "" "!DOWNLOAD_DIR!\!filename!"
    ) else (
        echo.
        echo [ERROR] 下载失败，正在为您打开官方下载页面...
        start https://cursor.com/download
        pause
    )
    goto MENU
)

if "%choice%"=="4" (
    echo.
    echo 正在准备下载 Antigravity IDE...
    set "filename=Antigravity-Setup-x64.exe"
    set "url=https://antigravity.google/download"
    echo 目标文件: !DOWNLOAD_DIR!\!filename!
    echo.
    echo 注意: Antigravity 可能会引导至浏览器进行最终下载。
    echo 正在尝试直接获取下载流...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -Uri '!url!' -OutFile '!DOWNLOAD_DIR!\!filename!' -UserAgent 'Mozilla/5.0' -ErrorAction Stop; exit 0 } catch { exit 1 }"
    if !errorlevel! equ 0 (
        echo.
        echo [OK] 下载完成: !DOWNLOAD_DIR!\!filename!
        echo 是否现在安装? (Y/N)
        set /p install=
        if /i "!install!"=="Y" start "" "!DOWNLOAD_DIR!\!filename!"
    ) else (
        echo.
        echo [INFO] 无法直接下载，正在为您打开官方下载页面...
        start https://antigravity.google/download
        pause
    )
    goto MENU
)

if "%choice%"=="0" exit /b
goto MENU
