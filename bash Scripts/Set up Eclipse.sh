#!/bin/bash

# bash Shell Scripts for Minecraft Forge Projects
# Created, updated, and maintained by Jonathing
# Version 0.2.0

cd ../..

MyProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
MyProjectName=${MyProjectName#*'"'}; MyProjectName=${MyProjectName%'"'*}
echo "$s"

# Set up the initial Eclipse workspace
echo "Setting up the initial Eclipse workspace for $MyProjectName..."
echo ""
./gradlew eclipse --warning-mode none
echo ""

# Generate the Eclipse run configurations...
echo "Generating the Eclipse run configurations for $MyProjectName..."
echo ""
./gradlew genEclipseRuns --warning-mode none
echo ""

echo "Initial set up for Eclipse complete."
echo "If you need to generate the run configurations again, run the \"Make Eclipse Runs.ps1\" script."

cd Scripts/bash\ Scripts/
read -s -n 1 -p "Press any key to continue . . ."
echo ""
exit 0