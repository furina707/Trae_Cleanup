# Requires -Version 3.0

function Show-Menu {
    Clear-Host
    Write-Host "========================================"
    Write-Host "  AI IDE Downloader"
    Write-Host "========================================"
    Write-Host ""
    Write-Host "1. Trae Intl"
    Write-Host "2. Trae CN"
    Write-Host "3. Cursor IDE"
    Write-Host "4. Antigravity IDE"
    Write-Host "0. Exit"
    Write-Host ""
    Write-Host "----------------------------------------"
    Write-Host "Save path: $DLD_DIR"
    Write-Host "----------------------------------------"
    Write-Host ""
}

function Start-Download {
    param(
        [string]$S_NAME,
        [string]$S_FILE,
        [string]$S_URL,
        [string]$S_PAGE,
        [string]$DLD_DIR
    )

    Write-Host ""
    Write-Host "Preparing to download $S_NAME..."
    Write-Host "Target: $(Join-Path -Path $DLD_DIR -ChildPath $S_FILE)"
    Write-Host ""

    try {
        Invoke-WebRequest -Uri $S_URL -OutFile (Join-Path -Path $DLD_DIR -ChildPath $S_FILE) -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36" -ErrorAction Stop
        Write-Host ""
        Write-Host "[OK] Download finished: $(Join-Path -Path $DLD_DIR -ChildPath $S_FILE)"
        $install = Read-Host "Install now? (Y/N)"
        if ($install -eq "Y") {
            Start-Process -FilePath (Join-Path -Path $DLD_DIR -ChildPath $S_FILE)
        }
    }
    catch {
        Write-Host ""
        Write-Host "[Error] Download failed. Details:"
        Write-Host $_.Exception.Message
        Write-Host "Opening official page..."
        Start-Process -FilePath $S_PAGE
        Read-Host "Press Enter to continue..."
    }
}

# Main script logic
Set-Location -Path $PSScriptRoot
$DLD_DIR = Join-Path -Path $PSScriptRoot -ChildPath "downloads"

if (-not (Test-Path $DLD_DIR)) {
    New-Item -Path $DLD_DIR -ItemType Directory | Out-Null
}

while ($true) {
    Show-Menu

    $input = Read-Host "Select [0-4]"

    switch ($input) {
        "1" {
            $S_NAME = "Trae_Intl"
            $S_FILE = "Trae-Setup-x64.exe"
            $S_URL = "https://api.trae.ai/download/stable/windows/x64"
            $S_PAGE = "https://www.trae.ai/download"
            Start-Download -S_NAME $S_NAME -S_FILE $S_FILE -S_URL $S_URL -S_PAGE $S_PAGE -DLD_DIR $DLD_DIR
        }
        "2" {
            $S_NAME = "Trae_CN"
            $S_FILE = "Trae-CN-Setup-x64.exe"
            $S_URL = "https://api.trae.cn/download/stable/windows/x64"
            $S_PAGE = "https://www.trae.cn/download"
            Start-Download -S_NAME $S_NAME -S_FILE $S_FILE -S_URL $S_URL -S_PAGE $S_PAGE -DLD_DIR $DLD_DIR
        }
        "3" {
            $S_NAME = "Cursor_IDE"
            $S_FILE = "CursorSetup.exe"
            $S_URL = "https://downloader.cursor.sh/windows/nsis/x64"
            $S_PAGE = "https://cursor.com/download"
            Start-Download -S_NAME $S_NAME -S_FILE $S_FILE -S_URL $S_URL -S_PAGE $S_PAGE -DLD_DIR $DLD_DIR
        }
        "4" {
            $S_NAME = "Antigravity_IDE"
            $S_FILE = "Antigravity-Setup-x64.exe"
            $S_URL = "https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/1.16.5-6703236727046144/windows-x64/Antigravity.exe"
            $S_PAGE = "https://antigravity.google/download"
            Start-Download -S_NAME $S_NAME -S_FILE $S_FILE -S_URL $S_URL -S_PAGE $S_PAGE -DLD_DIR $DLD_DIR
        }
        "0" {
            exit
        }
        default {
            Write-Host ""
            Write-Host "[Error] Invalid input: $input" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}