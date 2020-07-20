#!/bin/bash

# Get arguments
MCGradleArgs=$1

if [ "$MCGradleArgs" != "FromHub" ]
then
    # Clear the screen
    clear

    MCGradleAuthor="Jonathing"
    MCGradleVersion="0.5.0"

    # Print script information
    echo "MCGradle Scripts"
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
fi

# Generate the Eclipse run configs
echo "Generating the Eclipse run configurations for $MCProjectName..."
echo ""
./gradlew genEclipseRuns --warning-mode none
echo ""
echo "Finished generating the Eclipse run configurations for $MCProjectName."

if [ "$MCGradleArgs" != "FromHub" ]
then
    # Return to scripts directory
    cd Scripts/bash\ Scripts/
    read -s -n 1 -p "Press any key to exit MCGradle Scripts..."
else
    read -s -n 1 -p "Press any key to return to the MCGradle Scripts Hub..."
fi

# END OF SCRIPT
echo ""
echo ""
