# Trae, Cursor & Antigravity Cleanup Tool 🧹

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey.svg)
![Batch](https://img.shields.io/badge/language-Batchfile-orange.svg)

> **One-Click Cleanup Solution for Trae (Intl & CN), Cursor, and Antigravity IDEs**

Trae, Cursor & Antigravity Cleanup Tool is a lightweight, open-source batch script designed to thoroughly remove configuration files, cached data, and registry entries for various AI IDEs. It intelligently distinguishes between different versions and IDEs, allowing for safe and targeted cleaning.

## 🚀 Key Features

- **🎯 Smart Detection**: Automatically scans and identifies existing installations and residue for all supported IDEs.
- **☯️ Multi-IDE Support**: Independently manage **Trae International**, **Trae CN**, **Cursor IDE**, and **Antigravity IDE**.
- **🛡️ Safe Cleaning**: 
  - Auto-terminates relevant processes.
  - Cleans `AppData\Roaming` & `AppData\Local` (User Data).
  - Cleans Installation directories.
  - Cleans Extensions folders (`.trae`, `.trae-cn`, `.cursor`, `.antigravity`).
  - Cleans Desktop Shortcuts.
  - Cleans Registry Keys (Config & Control Panel Uninstall List).
  - Cleans Temporary Files.
- **⚡ Zero Dependencies**: Pure Windows Batch script. No installation required.

## 🛠️ Included Tools

- **`clean_trae.bat`**: The main cleanup tool for removing IDE residue.
- **`download_ides.bat`**: A handy script to quickly download or navigate to the latest installers for Trae, Cursor, and Antigravity.

## 📥 Installation & Usage

1. **Download**: Get the latest `clean_trae.bat` from the [Releases](https://github.com/furina707/Trae_Cleanup/releases) or clone this repo.
   ```bash
   git clone https://github.com/furina707/Trae_Cleanup.git
   ```
2. **Run**: Right-click `clean_trae.bat` and select **Run as Administrator**.
3. **Select**:
   - `[1]` Clean Trae International 🌍
   - `[2]` Clean Trae CN (Chinese Version) 🇨🇳
   - `[3]` Clean Cursor IDE 🖱️
   - `[4]` Clean Antigravity IDE 🌌
   - `[5]` Full Cleanup (Nuke everything) 💥

## 📸 Screenshots

*(Run the script to see the interactive menu with detection status)*

## 🤝 Contributing

Contributions are welcome! If you find a path that isn't being cleaned or have a feature request, please [open an issue](https://github.com/furina707/Trae_Cleanup/issues) or submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
