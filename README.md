# Trae Cleanup Tool

A powerful and simple batch script to clean up Trae IDE configuration and data files.

## Features

- **Dual Version Support**: Separately manage **Trae International** and **Trae CN (Chinese Version)**.
- **Smart Detection**: Automatically scans your system for existing Trae files and registry entries.
- **Deep Cleaning**: Removes:
  - User Data (`AppData\Roaming`)
  - Installation Directory (`AppData\Local\Programs`)
  - Extensions (`.trae` / `.trae-cn`)
  - Registry Keys (`HKCU\Software\Trae`)
  - Temporary Files
- **Safe Process Management**: Automatically terminates relevant processes before cleaning.

## Usage

1. Download `clean_trae.bat`.
2. Right-click and **Run as Administrator** (recommended for best results).
3. Follow the on-screen menu:
   - Select `1` to clean Trae International.
   - Select `2` to clean Trae CN.
   - Select `3` for a full cleanup.

## Disclaimer

This tool deletes files permanently. Please ensure you have backed up any important configuration or data before running.
