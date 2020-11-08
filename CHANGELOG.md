# MCGradle Scripts Changelog

## 0.6.0

- Completely rewritten from the ground up with Object-Oriented Programming!
- Forgoing the bash version. This is mainly useful for people on Windows who can double click the batch file to run my program.
- Will add more changelog details later.

## 0.5.5

- Fixed a bug where Windows PowerShell would not prompt to open the `build\libs` folder.

## 0.5.4

- After building your mod, you will be prompted if you want to open the `build\libs` folder. This is only for Windows users.

## 0.5.3

- Ported the auto-updater for the bash scripts. PowerShell superiority is no more.
- Dropped support for using MCGradle Scripts as a Git submodule. It's too risky with the new auto-updater I made.

## 0.5.2

- Added an auto-updater for the PowerShell scripts. Support for the bash scripts coming soon!
- Fixed `genIntellijRuns.bat` crashing on launch.

## 0.5.1

- MCGradle Scripts is now licensed under GNU General Public License Version 2.
- Tweaked PowerShell title change at the end of the script.
  - Windows: The title will revert to what it was before the script ran.
  - macOS and Linux: The title will be set to null.
- The PowerShell script will now detect if you are running Windows PowerShell or PowerShell Core, and whether or not you are running it through Windows Command Prmopt.
- Simplified the greeting screen to take up less space.
- Refactored the scripts to be cli friendly.
- Added an option to do a full cleanup of the workspace.
  - This option will delete your build, eclipse, and .idea folders, along with any other cache files.
- Fixed Gradle deleting the PowerShell title after it finishes running a task.
- Fixed the bash version of MCGradle Scripts not accepting lower case values.
- The colors in the bash version of MCGradle Scripts now match that of the PowerShell version.
- Fixed genIntellijRuns for PowerShell not echoing a message to the console.
- The Windows Command Prompt wrapper for PowerShell will now return to the Windows directory after it finished (for the subscripts).
- General bug fixes and performance improvements (view commit history for more details).

## 0.5.0

- Cleaned up the scripts and made them easier to read.
- Introducing: MCGradle Scripts Hub!
  - Access all the Gradle commands from a single batch file!
  - Features easy-to-read menus.
  - Makes running the scripts 100x easier! Simply launch the main MCGradle Scripts script and get going!
- The scripts are no longer being written for Windows Command Prompt. Windows Command Prompt now simply acts as a wrapper for the PowerShell scripts.

## 0.4.1

- The Windows Command Prompt scripts no longer need admin privileges to get the mod name from `mods.toml`.
- Deleted unused scripts that are no longer needed.
- The Windows Command Prompt scripts now use PowerShell to check for updates.
- Fixed error message displaying a broken link to the issue tracker.

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
