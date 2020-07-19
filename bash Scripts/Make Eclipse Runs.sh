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

# Generate the Eclipse run configs
echo "Generating the Eclipse run configurations for $MyProjectName..."
echo ""
./gradlew genEclipseRuns --warning-mode none
echo ""
echo "Finished generating the Eclipse run configurations for $MyProjectName."

# Return to scripts directory
cd Scripts/bash\ Scripts/

# END OF SCRIPT
read -s -n 1 -p "Press any key to continue . . . "
echo ""
exit 0
