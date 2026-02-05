@echo off
chcp 65001 >nul
title Trae Cleanup & Download Toolset
setlocal EnableDelayedExpansion

:START_MENU
cls
echo ========================================
echo     Trae, Cursor ^& Antigravity 工具箱
echo ========================================
echo.
echo 请选择要执行的操作：
echo.
echo   1. 清理 IDE 残留 (clean_trae.bat)
echo      - 支持 Trae (Intl/CN), Cursor, Antigravity
echo.
echo   2. 下载最新安装包 (download_ides.bat)
echo      - 自动获取并下载最新版 IDE
echo.
echo   0. 退出
echo.
echo ----------------------------------------
set /p tool_choice=请输入选项编号: 

if "%tool_choice%"=="1" (
    if exist "clean_trae.bat" (
        call clean_trae.bat
    ) else (
        echo [ERROR] 找不到 clean_trae.bat
        pause
    )
    goto START_MENU
)

if "%tool_choice%"=="2" (
    if exist "download_ides.bat" (
        call download_ides.bat
    ) else (
        echo [ERROR] 找不到 download_ides.bat
        pause
    )
    goto START_MENU
)

if "%tool_choice%"=="0" exit /b
goto START_MENU
