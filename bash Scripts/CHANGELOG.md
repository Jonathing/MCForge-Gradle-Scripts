# MCGradle Scripts Changelog

## 0.4.0

- MCGradle Scripts will now check for updates from the GitHub repository.
- If the update check fails, the scripts will continue as normal. This (in theory) allows MCGradle Scripts to be run offline.
- Rewrite some of the scripts to make them easier to read with consistent usage of casing and comments throughout each of the methods.
- MCGradle Scripts will clear the screen if one of the scripts are run. This gives it its own detatched feel from the normal shell the user would be running.
- MCGradle Scripts will now use the same version number for the Windows Command Prompt, PowerShell, and GNU bash scripts.

## 0.2.0 (bash Only)

- The project name is now pulled *directly* from `src/main/resources/META-INF/mods.toml`.

## 0.1.1 (bash Only)

- Addressed inconsistensies between the PowerShell and cmd script counterparts.
- The script will now return to the directory it started in.

## 0.1.0 (bash Only)

- Initial creation.
