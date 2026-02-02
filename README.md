# Trae Cleanup Tool 🧹

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey.svg)
![Batch](https://img.shields.io/badge/language-Batchfile-orange.svg)

> **One-Click Cleanup Solution for Trae IDE (International & CN Versions)**

Trae Cleanup Tool is a lightweight, open-source batch script designed to thoroughly remove configuration files, cached data, and registry entries for the Trae IDE. It intelligently distinguishes between the **International** and **Chinese (CN)** versions, allowing for safe and targeted cleaning.

## 🚀 Key Features

- **🎯 Smart Detection**: Automatically scans and identifies existing Trae installations and residue.
- **☯️ Dual Version Support**: Independently manage **Trae International** and **Trae CN**.
- **🛡️ Safe Cleaning**: 
  - Auto-terminates relevant processes.
  - Cleans `AppData\Roaming` (User Data).
  - Cleans `AppData\Local\Programs` (Installation).
  - Cleans `%USERPROFILE%\.trae` & `.trae-cn` (Extensions).
  - Cleans Registry Keys (`HKCU\Software\Trae`).
  - Cleans Temporary Files.
- **⚡ Zero Dependencies**: Pure Windows Batch script. No installation required.

## 📥 Installation & Usage

1. **Download**: Get the latest `clean_trae.bat` from the [Releases](https://github.com/furina707/Trae_Cleanup/releases) or clone this repo.
   ```bash
   git clone https://github.com/furina707/Trae_Cleanup.git
   ```
2. **Run**: Right-click `clean_trae.bat` and select **Run as Administrator**.
3. **Select**:
   - `[1]` Clean Trae International 🌍
   - `[2]` Clean Trae CN (Chinese Version) 🇨🇳
   - `[3]` Full Cleanup (Nuke everything) 💥

## 📸 Screenshots

*(Run the script to see the interactive menu with detection status)*

## 🤝 Contributing

Contributions are welcome! If you find a path that isn't being cleaned or have a feature request, please [open an issue](https://github.com/furina707/Trae_Cleanup/issues) or submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
