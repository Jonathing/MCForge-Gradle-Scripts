#!/bin/bash

MyBASHAuthor="Jonathing"
MyBASHVersion="0.2.0"

# Print script information
echo "MCGradle Scripts (for GNU bash)"
echo "Version $MyBASHVersion"
echo "Written and Maintained by $MyBASHAuthor"
echo ""

# Check for update
. ./internal/check_update.sh

# Go to root directory
cd ../..

# Get Forge mod name
MyProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
MyProjectName=${MyProjectName#*'"'}; MyProjectName=${MyProjectName%'"'*}

# Build the project
echo "Building $MyProjectName..."
echo ""
./gradlew build --warning-mode none
echo ""
echo "Finished building $MyProjectName."
echo "If the build was successful, the output should be located under build\libs"

# Return to scripts directory
cd Scripts/bash\ Scripts/

# END OF SCRIPT
read -s -n 1 -p "Press any key to continue . . . "
echo ""
exit 0
