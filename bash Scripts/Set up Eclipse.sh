#!/bin/bash

# Clear the screen
clear

MCGradleAuthor="Jonathing"
MCGradleVersion="0.4.1"

# Print script information
echo "MCGradle Scripts (for GNU bash)"
echo "Version $MCGradleVersion"
echo "Written and Maintained by $MCGradleAuthor"
echo ""

# Check for update
. ./internal/check_update.sh

# Go to root project directory
cd ../..

# Get Forge mod name
MCProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
MCProjectName=${MCProjectName#*'"'}; MCProjectName=${MCProjectName%'"'*}

# Set up the initial Eclipse workspace
echo "Setting up the initial Eclipse workspace for $MCProjectName..."
echo ""
./gradlew eclipse --warning-mode none
echo ""

# Generate the Eclipse run configs
echo "Generating the Eclipse run configurations for $MCProjectName..."
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
