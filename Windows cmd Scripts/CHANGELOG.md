# Windows Command Prompt Batch Scripts Changelog

## 0.3.2

- If the Windows PowerShell execution policy is not set to RemoteSigned or Unrestricted, the Windows cmd Script will ask the user if they would like to run an admin script to have it set to RemoteSigned for them.
- Created an internal cmd script to set the Windows PowerShell execution policy to RemoteSigned.

## 0.3.1

- Any internal PowerShell scripts will not be called if the execution policy does not allow it.

## 0.3.0

- The project name is now pulled *directly* from `src/main/resources/META-INF/mods.toml`.

## 0.2.2

- Changed the title of the window to be more generic.

## 0.2.1

- Addressed inconsistensies between the PowerShell and cmd script counterparts.
- The script will now return to the directory it started in.

## 0.2.0

- Revamped the Windows batch files to be more consistent, have better structure, and look nicer when the code is viewed.
