#!/bin/bash

# Get arguments
MCGradleArgs=$1

if [ "$MCGradleArgs" != "FromHub" ]; then
    # Clear the screen
    clear

    MCGradleAuthor="Jonathing"
    MCGradleVersion="0.5.3"

    # Print script information
    MCGradleGreeting1="MCGradle Scripts by $MCGradleAuthor"
    MCGradleGreeting2="Version $MCGradleVersion"
    printf "$MCGradleGreeting1\n"
    printf "$MCGradleGreeting2\n\n"

    # Check for update
    . ./internal/check_update.sh

    # Go to root project directory
    cd ../..

    # Get Forge mod name
    MCProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
    MCProjectName=${MCProjectName#*'"'}; MCProjectName=${MCProjectName%'"'*}
fi

# Generate the IntelliJ IDEA run configs
printf "Generating the IntelliJ IDEA run configurations for $MCProjectName...\n\n"
./gradlew genIntellijRuns --warning-mode none
printf "\nFinished generating the IntelliJ IDEA run configurations for $MCProjectName.\n"

if [ "$MCGradleArgs" != "FromHub" ]; then
    # Return to scripts directory
    cd Scripts/bash/
    read -s -n 1 -p "Press any key to exit MCGradle Scripts..."
    printf "\n\e[91mQuitting MCGradle Scripts...\e[39m\n"
else
    read -s -n 1 -p "Press any key to return to the MCGradle Scripts Hub..."
    printf "\n"
fi

# END OF SCRIPT
printf "\n"
