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

# Set up the initial Eclipse workspace
printf "Setting up the initial Eclipse workspace for $MCProjectName...\n\n"
./gradlew eclipse --warning-mode none
printf "\n"

# Generate the Eclipse run configs
printf "Generating the Eclipse run configurations for $MCProjectName...\n\n"
./gradlew genEclipseRuns --warning-mode none
printf "\nInitial set up for Eclipse complete.\n"
printf "If you need to generate the run configurations again, run the \"Make Eclipse Runs.ps1\" script.\n"

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
