@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:MENU
cls
echo ========================================
echo   Trae, Cursor ^& Antigravity 清理工具 (全能版)
echo ========================================
echo.
echo [1/4] 正在扫描系统...
echo.

REM --- 初始化变量 ---
set "intl_found=0"
set "cn_found=0"
set "cursor_found=0"
set "anti_found=0"

REM --- 扫描逻辑 (与原来一致，保持轻量) ---
if exist "%APPDATA%\Trae" set "intl_found=1"
if exist "%LOCALAPPDATA%\Programs\Trae" set "intl_found=1"
if exist "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Trae.lnk" set "intl_found=1"
reg query "HKCU\Software\Trae" >nul 2>&1
if !errorlevel! equ 0 set "intl_found=1"

if exist "%APPDATA%\Trae CN" set "cn_found=1"
if exist "%LOCALAPPDATA%\Programs\Trae CN" set "cn_found=1"
if exist "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Trae CN.lnk" set "cn_found=1"
reg query "HKCU\Software\Trae CN" >nul 2>&1
if !errorlevel! equ 0 set "cn_found=1"

if exist "%APPDATA%\Cursor" set "cursor_found=1"
if exist "%LOCALAPPDATA%\Programs\cursor" set "cursor_found=1"
if exist "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Cursor.lnk" set "cursor_found=1"
reg query "HKCU\Software\Cursor" >nul 2>&1
if !errorlevel! equ 0 set "cursor_found=1"

if exist "%APPDATA%\Antigravity" set "anti_found=1"
if exist "%LOCALAPPDATA%\Programs\Antigravity" set "anti_found=1"
if exist "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Antigravity.lnk" set "anti_found=1"
reg query "HKCU\Software\Antigravity" >nul 2>&1
if !errorlevel! equ 0 set "anti_found=1"

REM --- 设置显示状态 ---
if "!intl_found!"=="1" (set "msg_intl=[已发现残余]") else (set "msg_intl=[未发现]")
if "!cn_found!"=="1" (set "msg_cn=[已发现残余]") else (set "msg_cn=[未发现]")
if "!cursor_found!"=="1" (set "msg_cursor=[已发现残余]") else (set "msg_cursor=[未发现]")
if "!anti_found!"=="1" (set "msg_anti=[已发现残余]") else (set "msg_anti=[未发现]")

echo 扫描完成。
echo.
echo [2/4] 请选择要清理的项目：
echo.
echo   1. %msg_intl% 清理 Trae 国际版
echo   2. %msg_cn% 清理 Trae 中文版
echo   3. %msg_cursor% 清理 Cursor IDE
echo   4. %msg_anti% 清理 Antigravity IDE
echo   5. 全部清理 (清理以上所有发现的残余)
echo   6. [高级] 彻底重置任务栏固定 - 解决无法删除的幽灵图标
echo.
echo   0. 退出
echo.
set /p choice="请输入选项编号: "

if "%choice%"=="0" exit
set "do_intl=0"
set "do_cn=0"
set "do_cursor=0"
set "do_anti=0"

if "%choice%"=="1" set "do_intl=1"
if "%choice%"=="2" set "do_cn=1"
if "%choice%"=="3" set "do_cursor=1"
if "%choice%"=="4" set "do_anti=1"
if "%choice%"=="5" (
    set "do_intl=1"
    set "do_cn=1"
    set "do_cursor=1"
    set "do_anti=1"
)
if "%choice%"=="6" (
    call :ResetTaskbarPins
    goto MENU
)

if "%do_intl%%do_cn%%do_cursor%%do_anti%"=="0000" goto MENU

echo.
echo [3/4] 正在关闭相关进程...
if "%do_intl%"=="1" taskkill /F /IM "Trae.exe" >nul 2>&1
if "%do_cn%"=="1" taskkill /F /IM "Trae CN.exe" >nul 2>&1
if "%do_cursor%"=="1" taskkill /F /IM "Cursor.exe" >nul 2>&1
if "%do_anti%"=="1" taskkill /F /IM "Antigravity.exe" >nul 2>&1
timeout /t 1 >nul

echo.
echo [4/4] 正在执行清理...
set deleted=0
set failed=0

if "%do_intl%"=="1" call :CleanIntl
if "%do_cn%"=="1" call :CleanCN
if "%do_cursor%"=="1" call :CleanCursor
if "%do_anti%"=="1" call :CleanAnti

REM --- 公共清理 ---
echo --- 清理临时文件 ---
del /f /q "%TEMP%\Trae*.log" >nul 2>&1
del /f /q "%TEMP%\Trae*.tmp" >nul 2>&1
del /f /q "%TEMP%\Cursor*.log" >nul 2>&1
echo [OK] 临时文件已清理

call :RefreshShell

echo.
echo ========================================
if !deleted! equ 0 (
    echo   未发现可清理的有效文件
) else (
    echo   清理完成！已处理 !deleted! 个项目
)
echo ========================================
echo.

if !deleted! neq 0 (
    echo [Check] 如果任务栏图标依然存在 - 幽灵图标 - 建议重启资源管理器。
    set /p "restart_explorer=是否现在重启资源管理器? (Y/N): "
    if /i "!restart_explorer!"=="Y" (
        taskkill /f /im explorer.exe >nul 2>&1
        start explorer.exe
        echo [OK] 资源管理器已重启
    )
)

echo.
echo 按任意键退出...
pause >nul
exit

REM ========================================
REM 各 IDE 的清理子程序 (避免复杂的 if 括号)
REM ========================================

:CleanIntl
echo --- 正在清理 Trae 国际版 ---
call :CleanDir "%APPDATA%\Trae" "用户数据-Roaming"
call :CleanDir "%LOCALAPPDATA%\Trae" "用户数据-Local"
call :CleanDir "%LOCALAPPDATA%\Programs\Trae" "安装目录"
call :CleanDir "%USERPROFILE%\.trae" "插件目录"
call :CleanBroadShortcuts "Trae"
reg delete "HKCU\Software\Trae" /f >nul 2>&1
goto :eof

:CleanCN
echo --- 正在清理 Trae 中文版 ---
call :CleanDir "%APPDATA%\Trae CN" "用户数据"
call :CleanDir "%LOCALAPPDATA%\Programs\Trae CN" "安装目录"
call :CleanDir "%USERPROFILE%\.trae-cn" "插件目录"
call :CleanBroadShortcuts "Trae*CN"
reg delete "HKCU\Software\Trae CN" /f >nul 2>&1
goto :eof

:CleanCursor
echo --- 正在清理 Cursor ---
call :CleanDir "%APPDATA%\Cursor" " roaming数据"
call :CleanDir "%LOCALAPPDATA%\Cursor" "local数据"
call :CleanDir "%LOCALAPPDATA%\Programs\cursor" "安装目录"
call :CleanBroadShortcuts "Cursor"
reg delete "HKCU\Software\Cursor" /f >nul 2>&1
goto :eof

:CleanAnti
echo --- 正在清理 Antigravity ---
call :CleanDir "%APPDATA%\Antigravity" "用户数据"
call :CleanDir "%LOCALAPPDATA%\Programs\Antigravity" "安装目录"
call :CleanDir "%USERPROFILE%\.antigravity" "插件目录"
call :CleanBroadShortcuts "Antigravity"
reg delete "HKCU\Software\Antigravity" /f >nul 2>&1
goto :eof

REM ========================================
REM 通用工具子程序
REM ========================================

:CleanDir
if exist "%~1" (
    echo   删除: %~1 %~2
    rmdir /s /q "%~1" >nul 2>&1
    set /a deleted+=1
)
goto :eof

:CleanBroadShortcuts
echo   正在广域清理快捷方式 包含任务栏: %~1
powershell -ExecutionPolicy Bypass -Command "Get-ChildItem -Path '$env:APPDATA\Microsoft\Windows\Start Menu', '$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu', '$env:APPDATA\Microsoft\Internet Explorer\Quick Launch' -Filter '*%~1*' -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse" >nul 2>&1
set /a deleted+=1
goto :eof

:RefreshShell
echo   正在强制刷新图标缓存...
REM 1. 通知 Shell 刷新
powershell -ExecutionPolicy Bypass -Command "$code = '[DllImport(\"shell32.dll\")] public static extern void SHChangeNotify(int ID, int flags, IntPtr item1, IntPtr item2);'; Add-Type -Safe -MemberDefinition $code -Name Shell32 -Namespace Native; [Native.Shell32]::SHChangeNotify(0x08000000, 0, [IntPtr]::Zero, [IntPtr]::Zero);" >nul 2>&1

REM 2. 清理物理缓存文件 (需要暂时重启 Explorer)
echo   正在清理系统图标数据库...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul
del /a /f /q "%LocalAppData%\IconCache.db" >nul 2>&1
del /a /f /q "%LocalAppData%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1
start explorer.exe
echo [OK] 深度刷新已完成
goto :eof

:ResetTaskbarPins
echo.
echo !!! 警告 !!!
echo 该操作将清除任务栏上 所有 固定的图标 - Chrome - Edge 等都会被取消固定。
set /p "confirm_reset=确定要继续重置任务栏吗? (Y/N): "
if /i "!confirm_reset!"=="Y" (
    echo 正在重置任务栏注册表...
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f >nul 2>&1
    taskkill /f /im explorer.exe >nul 2>&1
    timeout /t 2 >nul
    start explorer.exe
    echo [OK] 任务栏已重置 - 幽灵图标应已消失。
    pause
)
goto :eof
