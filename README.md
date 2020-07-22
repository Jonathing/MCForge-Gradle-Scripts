# MCGradle Scripts

Welcome to the official repository of MCGradle Scripts! MCGradle Scripts is a folder of scripts to help make building your Minecraft mod easier.

## Purpose

In a nutshell, MCGradle Scripts makes building, running, or setting up your workspace for your mod easier for users and developers alike, since it makes doing some Gradle tasks much easier since all you need to do is point and double click (in most cases).

## Installation

To install MCGradle Scripts, go to [GitHub Releases](https://github.com/Jonathing/MCGradle-Scripts/releases/) and download the latest `MCGradle-Scripts.zip` file! Then, unzip the file as-is in your root project directory. Please don't change any of the folder names, I haven't yet added support for that in the scripts.

## Features

Right now, MCGradle Scripts:

- Is fully compatible with ForgeGradle 3.
- Can get your mod's display name from mods.toml (it only picks up the first occurrence of `displayName=`.
- Can change the title of your terminal shell (if possible, I couldn't find a way to do this for bash).
- Can check for updates from this repo by reading the `VERSIONS.txt` file.
- Has a main script where all the other scripts can be executed through.
- Has a fully-fledged auto-updater.

Some of the planned features for MCGradle Scripts are to:

- Have full compatability with ForgeGradle 2 and Fabric workspaces.
- Be able to decide what to run depending if the workspace is for ForgeGradle 3, ForgeGradle 2, or Fabric.
- And some other things I may not have thought up as of right now!

## How to Run

MCGradle Scripts is written in three different languages for three different shell interpreters: **Batch for Windows Command Prompt**, **PowerShell for Windows PowerShell and PowerShell Core**, and **GNU bash for GNU/Linux**

### Windows Command Prompt

To launch MCGradle Scripts, simply double click the `MCGradle Scripts.bat` file in the Scripts directory.

Windows Command Prompt now acts as a wrapper for the PowerShell scripts! Writing MCGradle Scripts has never been easier for me, and launching MCGradle Scripts has never been easier for you!

### PowerShell

Are you a PowerShell supremecist? Not a problem! To run one of the PowerShell scripts, do one of the following:

- For Windows PowerShell, right click on the script and click on `Run with PowerShell`.
- For PowerShell Core, run the script manually from the command line. It is written to work for both Windows PowerShell and PowerShell Core.

### GNU bash

Tired of Microsft spying on you? I've made MCGradle Scripts for bash as well! To run one of the shell scripts, run the script manually from the command line. If for some reason the shell script is not executable, run `chmod +x [script_name_here].sh` in your terminal, and then run the script.
