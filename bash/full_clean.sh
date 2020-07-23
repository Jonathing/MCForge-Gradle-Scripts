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

printf "\e[93mWARNING: THIS ACTION WILL DELETE YOUR BUILD FOLDER, ECLIPSE/INTELLIJ WORKSPACE, AND ANY RUN CONFIGURATIONS!\n"
printf "THE RUN FOLDER WILL NOT BE DELETED BECAUSE IT IS NOT REQUIRED FOR A FULL CLEANUP.\n"
printf "ARE YOU SURE YOU WANT TO DO THIS? \e[91mTHIS ACTION CANNOT BE UNDONE! \e[93m[ y/N ] \e[39m"
read MCReadHost
printf "\n"

case $MCReadHost in
Y | y)
    MCHasConfirmed=1
    ;;
*)
    MCHasConfirmed=0
    ;;
esac

if [ "$MCHasConfirmed" -eq 1 ]; then
    printf "Deleting Eclipse run configs and other cache files...\n"
    if ls ./*.launch 1> /dev/null 2>&1; then
        rm *.launch
    fi
    if [ -d "./.settings" ]; then
        rm -r ./.settings
    fi

    printf "Deleting IntelliJ run configs and other cache files...\n"
    if [ -d "./.idea/runConfigurations" ]; then
        rm -r ./.idea/runConfigurations
    fi
    if [ -d "./out" ]; then
        rm -r ./out
    fi
    if [ -d "./.idea/modules" ]; then
        rm -r ./.idea/modules
    fi
    if [ -f "./.idea/\$CACHE_FILE\$" ]; then
        rm ./.idea/\$CACHE_FILE\$
    fi
    if ls ./.idea/*.xml 1> /dev/null 2>&1; then
        rm ./.idea/*.xml
    fi
    if [ -f "./.idea/.name" ]; then
        rm ./.idea/.name
    fi
    if ls ./*.ipr 1> /dev/null 2>&1; then
        rm ./*.ipr
    fi
    if ls ./*.iws 1> /dev/null 2>&1; then
        rm ./*.iws
    fi
    if ls ./*.iml 1> /dev/null 2>&1; then
        rm ./*.iml
    fi
    
    MCHasBuildFolder=0
    MCHasEclipse=0
    MCHasOneOrOther=0

    if [ -d "./build" ]; then
        MCHasBuildFolder=1
    fi

    if [ -f "./.classpath" ]; then
        MCHasEclipse=1
    fi

    if [ "$MCHasBuildFolder" -eq 1 -a "$MCHasEclipse" -eq 1 ]; then
        # Delete the folders via Gradle
        printf "Calling Gradle to clean up the Eclipse workspace and build output...\n\n"
        ./gradlew clean cleanEclipse --warning-mode none
        printf "\n"
    else
        MCHasOneOrOther=1
    fi

    if [ "$MCHasBuildFolder" -eq 1 -a "$MCHasOneOrOther" -eq 1 ]; then
        # Delete the build folder via Gradle
        printf "Calling Gradle to clean up the build output...\n\n"
        ./gradlew clean --warning-mode none
        printf "\n"
    fi

    if [ "$MCHasEclipse" -eq 1 -a "$MCHasOneOrOther" -eq 1 ]; then
        # Delete the eclipse folder via Gradle
        printf "Calling Gradle to clean up the Eclipse workspace...\n\n"
        ./gradlew cleanEclipse --warning-mode none
        printf "\n"
    fi

    if [ "$MCGradleArgs" != "FromHub" ]; then
        # Return to scripts directory
        cd Scripts/bash/
        read -s -n 1 -p "Press any key to exit MCGradle Scripts..."
        printf "\n\e[91mQuitting MCGradle Scripts...\e[39m"
    else
        read -s -n 1 -p "Press any key to return to the MCGradle Scripts Hub..."
        printf "\n\n"
    fi
fi