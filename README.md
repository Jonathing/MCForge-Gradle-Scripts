# MCGradle Scripts

Welcome to the official repository of MCGradle Scripts! MCGradle Scripts is a folder of scripts to help make building your Minecraft mod easier.

## Purpose

In a nutshell, MCGradle Scripts makes building, running, or setting up your workspace for your mod easier for users and developers alike, since it makes doing some Gradle tasks much easier since all you need to do is point and double click (in most cases).

## Installation

To install MCGradle Scripts, go to [GitHub Releases](https://github.com/Jonathing/MCGradle-Scripts/releases/) and download the latest `MCGradle-Scripts.zip` file! Then, unzip the file as-is in your root project directory. Please don't change any of the folder names, I haven't yet added support for that in the scripts. You'll notice that the only thing there is a file called "MCGradle Scripts.bat". The program now self-installs itself by downloading the files from this repository, so all you need to do is run that batch script and it will install itself. It will even download a .gitignore for you which ignores all files except for the main batch script, so all you need to do is commit the `MCGradle Scripts.bat` file.

## Features

Right now, MCGradle Scripts:

- Is fully compatible with ForgeGradle 3.
- Can detect ForgeGradle 2 and Fabric workspaces but is not yet compatible with them.
- Can get your mod's display name from mods.toml (it only picks up the first occurrence of `displayName=` on ForgeGradle 3 workspaces.
- Can change the title of your window depending on the current action.
- Can check for updates and has a fully-fledged auto-updater that will use the `update.ps1` script from this repo to update the program for you.
- Has a main script where all the other scripts can be executed through.
- Has seperate wrapper batch scripts if you only need to execute a single task and don't have the patience to go through the main script.

Some of the planned features for MCGradle Scripts are to:

- Have full compatability with ForgeGradle 2 and Fabric workspaces.
- Change the tasks on the main menu depending on what workspace you have.

## How to Run

Because MCGradle Scripts is now written using Object-Oriented Programming in PowerShell, the main demographic for this program is users on Windows who want to double click a batch script to have it run a gradle task for them without needing to type it out themselves. All you need to do to run the program is double click the main `MCGradle Scripts.bat` file or run of the single task batch scripts.
