# MCGradle Scripts Changelog

## 0.4.0

- This project is now named MCGradle Scripts. It was previously unnamed.
- MCGradle Scripts will now use the same version number for the Windows Command Prompt, PowerShell, and GNU bash scripts.
- MCGradle Scripts will now check for updates from the GitHub repository.
- If the update check fails, the scripts will continue as normal. This (in theory) allows MCGradle Scripts to be run offline.
- Rewrite some of the scripts to make them easier to read with consistent usage of casing and comments throughout each of the methods.
- MCGradle Scripts will clear the screen if one of the scripts are run. This gives it its own detatched feel from the normal shell the user would be running.

## Before MCGradle Scripts

### 0.2.0 (GNU bash)

- The project name is now pulled *directly* from `src/main/resources/META-INF/mods.toml`.

### 0.3.2 (Windows Command Prompt)

- If the Windows PowerShell execution policy is not set to RemoteSigned or Unrestricted, the Windows cmd Script will ask the user if they would like to run an admin script to have it set to RemoteSigned for them.
- Created an internal cmd script to set the Windows PowerShell execution policy to RemoteSigned.

## 0.2.1 (PowerShell)

- Changed how the title of the window is changed to be safer and not reliant on PowerShell 5.1.
- Fixed the `Set up IntelliJ.ps1` not returning to the directory it started in.

### 0.3.1 (Windows Command Prompt)

- Any internal PowerShell scripts will not be called if the execution policy does not allow it.

### 0.3.0 (Windows Command Prompt) and 0.2.0 (PowerShell)

- The project name is now pulled *directly* from `src/main/resources/META-INF/mods.toml`.

### 0.2.2 (Windows Command Prompt) and 0.1.3 (PowerShell)

- Changed the title of the window to be more generic.

## 0.2.1 (Windows Command Prompt), 0.1.2 (PowerShell), and 0.1.1 (GNU Bash)

- Addressed inconsistensies between the scripts counterparts.
- The script will now return to the directory it started in.

## 0.1.0 (GNU bash)

- Initial creation.

### 0.1.1 (PowerShell)

- Added support for PowerShell Core, thus allowing macOS and Linux users with PowerShell Core to run the scripts.

### 0.2.0 (Windows Command Prompt)

- Revamped the Windows batch files to be more consistent, have better structure, and look nicer when the code is viewed.

### 0.1.0 (PowerShell)

- Initial creation.

### 0.1.x (Windows Command Prompt)

- Created and maintained by [Bailey](https://gitlab.com/KingPhygieBoo).
- Occasional updates by [Bailey](https://gitlab.com/KingPhygieBoo) and [Jonathing](https://github.com/Jonathing).
