#!/bin/bash

MyBASHAuthor="Jonathing"
MyBASHVersion="0.4.0"

# Print script information
echo "MCGradle Scripts (for GNU bash)"
echo "Version $MyBASHVersion"
echo "Written and Maintained by $MyBASHAuthor"
echo ""

# Check for update
. ./internal/check_update.sh

# Go to root project directory
cd ../..

# Get Forge mod name
MyProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
MyProjectName=${MyProjectName#*'"'}; MyProjectName=${MyProjectName%'"'*}

# Inform user that IntelliJ set up is done by IntelliJ IDEA
echo "The IntelliJ IDEA workspace for Forge is no longer set up through a command."
echo "To import the project to IntelliJ IDEA, simply open the \"build.gradle\" file as a project."
echo "Gradle will do the rest for you as it imports and indexes the project into IntelliJ."
echo ""

# Return to scripts directory
cd Scripts/bash\ Scripts/

# END OF SCRIPT
read -s -n 1 -p "Press any key to exit MCGradle Scripts..."
echo ""
exit 0
