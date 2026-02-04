@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:MENU
cls
echo ========================================
echo   Trae ^& Cursor 清理工具 (增强版)
echo ========================================
echo.
echo [1/4] 正在扫描系统...
echo.

REM --- 初始化变量 ---
set "intl_found=0"
set "cn_found=0"
set "cursor_found=0"

REM --- 扫描国际版 ---
if exist "%APPDATA%\Trae" set "intl_found=1"
if exist "%LOCALAPPDATA%\Programs\Trae" set "intl_found=1"
if exist "%USERPROFILE%\.trae" set "intl_found=1"
reg query "HKCU\Software\Trae" >nul 2>&1
if !errorlevel! equ 0 set "intl_found=1"

REM --- 扫描中文版 ---
if exist "%APPDATA%\Trae CN" set "cn_found=1"
if exist "%LOCALAPPDATA%\Programs\Trae CN" set "cn_found=1"
if exist "%USERPROFILE%\.trae-cn" set "cn_found=1"
reg query "HKCU\Software\Trae CN" >nul 2>&1
if !errorlevel! equ 0 set "cn_found=1"

REM --- 扫描 Cursor ---
if exist "%APPDATA%\Cursor" set "cursor_found=1"
if exist "%LOCALAPPDATA%\Cursor" set "cursor_found=1"
if exist "%LOCALAPPDATA%\Programs\cursor" set "cursor_found=1"
if exist "%USERPROFILE%\.cursor" set "cursor_found=1"
reg query "HKCU\Software\Cursor" >nul 2>&1
if !errorlevel! equ 0 set "cursor_found=1"

REM --- 设置显示状态 ---
if "!intl_found!"=="1" (set "msg_intl=[已发现残余]") else (set "msg_intl=[未发现]")
if "!cn_found!"=="1" (set "msg_cn=[已发现残余]") else (set "msg_cn=[未发现]")
if "!cursor_found!"=="1" (set "msg_cursor=[已发现残余]") else (set "msg_cursor=[未发现]")

echo 扫描完成。
echo.

echo [2/4] 请选择要清理的项目：
echo.
echo   1. %msg_intl% 清理 Trae 国际版
echo      (用户数据、安装目录、插件 .trae、注册表)
echo.
echo   2. %msg_cn% 清理 Trae 中文版
echo      (用户数据、安装目录、插件 .trae-cn、注册表)
echo.
echo   3. %msg_cursor% 清理 Cursor IDE
echo      (用户数据、安装目录、插件 .cursor、注册表)
echo.
echo   4. 全部清理 (清理以上所有发现的残余)
echo.
echo   0. 退出
echo.
echo 请输入选项编号 (例如: 1)，按 Enter 键确认：
set /p choice=

if "%choice%"=="" goto MENU
if "%choice%"=="0" goto :eof

set "clean_intl=0"
set "clean_cn=0"
set "clean_cursor=0"

if "%choice%"=="1" set "clean_intl=1"
if "%choice%"=="2" set "clean_cn=1"
if "%choice%"=="3" set "clean_cursor=1"
if "%choice%"=="4" (
    set "clean_intl=1"
    set "clean_cn=1"
    set "clean_cursor=1"
)

if "%clean_intl%"=="0" if "%clean_cn%"=="0" if "%clean_cursor%"=="0" goto MENU

echo.
echo [3/4] 正在关闭相关进程...

if "%clean_intl%"=="1" (
    taskkill /F /IM "Trae.exe" >nul 2>&1
    echo 已尝试关闭 Trae (国际版)
)
if "%clean_cn%"=="1" (
    taskkill /F /IM "Trae CN.exe" >nul 2>&1
    echo 已尝试关闭 Trae CN (中文版)
)
if "%clean_cursor%"=="1" (
    taskkill /F /IM "Cursor.exe" >nul 2>&1
    echo 已尝试关闭 Cursor
)

echo 等待进程释放资源...
timeout /t 2 /nobreak >nul
echo.

echo [4/4] 正在执行清理...
echo.

set deleted=0
set failed=0

REM ==========================================
REM 清理国际版
REM ==========================================
if "%clean_intl%"=="1" (
    echo --- 正在清理国际版 ---
    call :CleanDir "%APPDATA%\Trae" "用户数据"
    call :CleanDir "%LOCALAPPDATA%\Programs\Trae" "安装目录"
    call :CleanDir "%USERPROFILE%\.trae" "插件目录"
    
    echo 检查桌面快捷方式...
    if exist "%USERPROFILE%\Desktop\Trae.lnk" (
        del /f /q "%USERPROFILE%\Desktop\Trae.lnk" >nul 2>&1
        echo [OK] 桌面快捷方式已删除
        set /a deleted+=1
    )
    if exist "%PUBLIC%\Desktop\Trae.lnk" (
        del /f /q "%PUBLIC%\Desktop\Trae.lnk" >nul 2>&1
        echo [OK] 公共桌面快捷方式已删除
        set /a deleted+=1
    )
    
    echo 检查注册表...
    reg query "HKCU\Software\Trae" >nul 2>&1
    if !errorlevel! equ 0 (
        reg delete "HKCU\Software\Trae" /f >nul 2>&1
        echo [OK] 注册表已清理
        set /a deleted+=1
    ) else (
        echo [SKIP] 注册表无残留
    )
    echo.
)

REM ==========================================
REM 清理 Cursor
REM ==========================================
if "%clean_cursor%"=="1" (
    echo --- 正在清理 Cursor ---
    call :CleanDir "%APPDATA%\Cursor" "用户数据(Roaming)"
    call :CleanDir "%LOCALAPPDATA%\Cursor" "用户数据(Local)"
    call :CleanDir "%LOCALAPPDATA%\Programs\cursor" "安装目录"
    call :CleanDir "%USERPROFILE%\.cursor" "插件目录"
    
    echo 检查桌面快捷方式...
    if exist "%USERPROFILE%\Desktop\Cursor.lnk" (
        del /f /q "%USERPROFILE%\Desktop\Cursor.lnk" >nul 2>&1
        echo [OK] 桌面快捷方式已删除
        set /a deleted+=1
    )
    if exist "%PUBLIC%\Desktop\Cursor.lnk" (
        del /f /q "%PUBLIC%\Desktop\Cursor.lnk" >nul 2>&1
        echo [OK] 公共桌面快捷方式已删除
        set /a deleted+=1
    )
    
    echo 检查注册表...
    reg query "HKCU\Software\Cursor" >nul 2>&1
    if !errorlevel! equ 0 (
        reg delete "HKCU\Software\Cursor" /f >nul 2>&1
        echo [OK] 注册表已清理
        set /a deleted+=1
    ) else (
        echo [SKIP] 注册表无残留
    )
    echo.
)

REM ==========================================
REM 清理中文版
REM ==========================================
if "%clean_cn%"=="1" (
    echo --- 正在清理中文版 ---
    call :CleanDir "%APPDATA%\Trae CN" "用户数据"
    call :CleanDir "%LOCALAPPDATA%\Programs\Trae CN" "安装目录"
    call :CleanDir "%USERPROFILE%\.trae-cn" "插件目录"
    
    echo 检查桌面快捷方式...
    if exist "%USERPROFILE%\Desktop\Trae CN.lnk" (
        del /f /q "%USERPROFILE%\Desktop\Trae CN.lnk" >nul 2>&1
        echo [OK] 桌面快捷方式已删除
        set /a deleted+=1
    )
    if exist "%PUBLIC%\Desktop\Trae CN.lnk" (
        del /f /q "%PUBLIC%\Desktop\Trae CN.lnk" >nul 2>&1
        echo [OK] 公共桌面快捷方式已删除
        set /a deleted+=1
    )
    
    echo 检查注册表...
    reg query "HKCU\Software\Trae CN" >nul 2>&1
    if !errorlevel! equ 0 (
        reg delete "HKCU\Software\Trae CN" /f >nul 2>&1
        echo [OK] 注册表已清理
        set /a deleted+=1
    ) else (
        echo [SKIP] 注册表无残留
    )
    echo.
)

REM ==========================================
REM 清理公共临时文件 (只要清理任意版本就尝试清理临时文件)
REM ==========================================
echo --- 清理临时文件 ---
del /f /q "%TEMP%\Trae*.log" >nul 2>&1
del /f /q "%TEMP%\Trae*.tmp" >nul 2>&1
rmdir /s /q "%TEMP%\Trae Crashes" >nul 2>&1
del /f /q "%TEMP%\Cursor*.log" >nul 2>&1
del /f /q "%TEMP%\Cursor*.tmp" >nul 2>&1
rmdir /s /q "%TEMP%\Cursor Crashes" >nul 2>&1
echo [OK] 临时文件清理尝试完成
echo.

echo ========================================
if %deleted%==0 (
    echo   未进行任何有效清理
) else (
    echo   清理完成！共执行 %deleted% 项主要清理操作
)
if %failed% gtr 0 (
    echo   注意：有 %failed% 项清理失败，可能需要管理员权限或手动删除
)
echo ========================================
echo.
echo 按任意键退出...
pause >nul
goto :eof

REM ========================================
REM 子程序: 清理目录
REM 参数: %1=路径, %2=描述
REM ========================================
:CleanDir
set "targetPath=%~1"
set "desc=%~2"

if exist "!targetPath!" (
    echo 删除: !targetPath! ^(!desc!^)
    rmdir /s /q "!targetPath!" >nul 2>&1
    
    if exist "!targetPath!" (
        echo [FAILED] 无法完全删除: !targetPath!
        echo          可能文件正在使用或权限不足
        set /a failed+=1
    ) else (
        echo [OK] 已删除
        set /a deleted+=1
    )
) else (
    echo [SKIP] 不存在: !targetPath! ^(!desc!^)
)
goto :eof
