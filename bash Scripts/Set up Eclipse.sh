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

# Set up the initial Eclipse workspace
echo "Setting up the initial Eclipse workspace for $MyProjectName..."
echo ""
./gradlew eclipse --warning-mode none
echo ""

# Generate the Eclipse run configs
echo "Generating the Eclipse run configurations for $MyProjectName..."
echo ""
./gradlew genEclipseRuns --warning-mode none
echo ""
echo "Initial set up for Eclipse complete."
echo "If you need to generate the run configurations again, run the \"Make Eclipse Runs.ps1\" script."

# Return to scripts directory
cd Scripts/bash\ Scripts/

# END OF SCRIPT
read -s -n 1 -p "Press any key to exit MCGradle Scripts..."
echo ""
exit 0
