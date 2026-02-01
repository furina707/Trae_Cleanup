# Trae 安装包分析与残留检查报告

## 一、安装包基本信息

### 1. 文件属性
- **文件名**: Trae-Setup-x64.exe
- **大小**: 224,751,624 字节 (约 214 MB)
- **版本**: 3.5.25
- **SHA256 哈希**: 31edeb8a8e7698bb90f602eda90328fdcca257a82a39a46a28a9882fc77f20fd
- **最后修改时间**: 2026-02-01 05:31:18 AM

### 2. 文件类型
- **魔术字节**: 4D-5A-50-00 (标准 Windows PE 文件)
- **格式**: 64 位 Windows 可执行安装程序

## 二、系统残留检查

### 1. 文件系统
通过对系统关键目录的搜索，发现了以下 Trae 相关文件和目录：

#### 用户数据目录（关键发现）
- **C:\Users\cytFu\AppData\Roaming\Trae** - Trae 用户数据目录
- **C:\Users\cytFu\AppData\Roaming\Trae CN** - Trae CN 用户数据目录

#### 程序文件目录
- **C:\Users\cytFu\AppData\Local\Programs\Trae** - Trae 程序文件
- **C:\Users\cytFu\AppData\Local\Programs\Trae CN** - Trae CN 程序文件

### 2. 用户数据目录结构分析

#### Trae 用户数据目录包含：
- **Local Storage/leveldb/** - 本地存储数据库（包含登录相关数据）
- **Network/Cookies** - Cookie 数据（包含会话令牌）
- **Session Storage/** - 会话存储
- **ModularData/ai-agent/database.db** - AI 代理数据库（6.5 MB）
- **User/globalStorage/** - 全局存储数据
- **Preferences** - 用户偏好设置

#### Trae CN 用户数据目录包含：
- **ModularData/ai-agent/database.db** - AI 代理数据库（6.5 MB）
- **ModularData/ai-agent/database.db-wal** - 数据库预写日志（8.2 MB）
- **ModularData/ckg_server/env_codekg.db** - 代码知识图谱数据库
- **User/globalStorage/** - 全局存储数据
- **Network/Cookies** - Cookie 数据

### 3. 注册表
通过对注册表的全面搜索，未发现 Trae 相关的卸载信息和配置项。检查范围包括：
- HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall
- HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
- HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall
- HKLM:\Software\*Trae*

## 三、为什么重新安装后登录还在？

### 原因分析
Trae 使用 Electron 框架开发，其用户数据存储机制如下：

1. **用户数据持久化**
   - Electron 应用将用户数据存储在 %APPDATA% 目录下
   - 卸载程序通常不会删除用户数据目录，以保护用户数据

2. **登录状态存储位置**
   - **Cookie 数据**：`Network/Cookies` 文件包含会话令牌
   - **本地存储**：`Local Storage/leveldb/` 包含登录状态和用户信息
   - **会话存储**：`Session Storage/` 保存会话数据
   - **全局存储**：`User/globalStorage/` 存储用户配置和认证信息

3. **重新安装行为**
   - 安装程序检测到现有的用户数据目录
   - 直接使用现有数据，不会覆盖或删除
   - 登录状态、Cookie、会话信息都被保留

## 四、彻底清理 Trae 的方法

### 方法一：手动清理（推荐）

#### 1. 关闭 Trae 应用
确保 Trae 和 Trae CN 完全关闭

#### 2. 删除用户数据目录
```powershell
# 删除 Trae 用户数据
Remove-Item -Path "$env:APPDATA\Trae" -Recurse -Force

# 删除 Trae CN 用户数据
Remove-Item -Path "$env:APPDATA\Trae CN" -Recurse -Force
```

#### 3. 删除程序文件
```powershell
# 删除 Trae 程序文件
Remove-Item -Path "$env:LOCALAPPDATA\Programs\Trae" -Recurse -Force

# 删除 Trae CN 程序文件
Remove-Item -Path "$env:LOCALAPPDATA\Programs\Trae CN" -Recurse -Force
```

### 方法二：使用清理脚本

创建 PowerShell 脚本 `clean_trae.ps1`：
```powershell
Write-Host "正在清理 Trae 残留数据..."

$paths = @(
    "$env:APPDATA\Trae",
    "$env:APPDATA\Trae CN",
    "$env:LOCALAPPDATA\Programs\Trae",
    "$env:LOCALAPPDATA\Programs\Trae CN"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        Write-Host "删除: $path"
        Remove-Item -Path $path -Recurse -Force
    }
}

Write-Host "清理完成！"
```

运行脚本：
```powershell
.\clean_trae.ps1
```

## 五、结论

### 1. 安装包状态
这是一个完整的 Trae AI 3.5.25 版本的 64 位 Windows 安装程序，文件完整性良好。

### 2. 系统残留情况
**发现了完整的 Trae 用户数据和程序文件**，包括：
- 两个用户数据目录（Trae 和 Trae CN）
- 两个程序文件目录
- 大量的用户配置、登录状态、Cookie 和会话数据

### 3. 重新安装后登录保留的原因
Trae 使用 Electron 框架，用户数据存储在 %APPDATA% 目录下，卸载和重新安装都不会删除这些数据，因此登录状态得以保留。

### 4. 建议
如果需要彻底清理 Trae 并重新开始：
1. 使用上述方法手动删除用户数据和程序文件
2. 然后重新安装 Trae
3. 重新登录账户

## 六、附录

### 1. 搜索命令
```powershell
# 检查程序文件目录
Get-ChildItem -Path "C:\Program Files" -Name "*Trae*" -Recurse -ErrorAction SilentlyContinue

# 检查用户数据目录
Get-ChildItem -Path $env:APPDATA -Directory -Name "*trae*" -ErrorAction SilentlyContinue

# 检查本地程序目录
Get-ChildItem -Path $env:LOCALAPPDATA -Directory -Name "*trae*" -ErrorAction SilentlyContinue
```

### 2. 哈希验证
```
SHA256: 31edeb8a8e7698bb90f602eda90328fdcca257a82a39a46a28a9882fc77f20fd
```

### 3. 关键数据文件大小
- ModularData/ai-agent/database.db: 6.5 MB
- ModularData/ai-agent/database.db-wal: 8.2 MB
- Network/Cookies: 20 KB
- Local Storage/leveldb/000005.ldb: 265 KB