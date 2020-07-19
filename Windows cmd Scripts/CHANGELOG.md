# MCGradle Scripts Changelog

## 0.4.0

- MCGradle Scripts will now check for updates from the GitHub repository.
- If the update check fails, the scripts will continue as normal. This (in theory) allows MCGradle Scripts to be run offline.
- Rewrite some of the scripts to make them easier to read with consistent usage of casing and comments throughout each of the methods.
- MCGradle Scripts will clear the screen if one of the scripts are run. This gives it its own detatched feel from the normal shell the user would be running.
- MCGradle Scripts will now use the same version number for the Windows Command Prompt, PowerShell, and GNU bash scripts.

## 0.3.2 (Windows Command Prompt Only)

- If the Windows PowerShell execution policy is not set to RemoteSigned or Unrestricted, the Windows cmd Script will ask the user if they would like to run an admin script to have it set to RemoteSigned for them.
- Created an internal cmd script to set the Windows PowerShell execution policy to RemoteSigned.

## 0.3.1 (Windows Command Prompt Only)

- Any internal PowerShell scripts will not be called if the execution policy does not allow it.

## 0.3.0 (Windows Command Prompt Only)

- The project name is now pulled *directly* from `src/main/resources/META-INF/mods.toml`.

## 0.2.2 (Windows Command Prompt Only)

- Changed the title of the window to be more generic.

## 0.2.1 (Windows Command Prompt Only)

- Addressed inconsistensies between the PowerShell and cmd script counterparts.
- The script will now return to the directory it started in.

## 0.2.0 (Windows Command Prompt Only)

- Revamped the Windows batch files to be more consistent, have better structure, and look nicer when the code is viewed.
