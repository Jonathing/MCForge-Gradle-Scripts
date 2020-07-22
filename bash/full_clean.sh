#!/bin/bash

# Get arguments
MCGradleArgs=$1

if [ "$MCGradleArgs" != "FromHub" ]; then
    # Clear the screen
    clear

    MCGradleAuthor="Jonathing"
    MCGradleVersion="0.5.0"

    # Print script information
    MCGradleGreeting1="MCGradle Scripts by $MCGradleAuthor"
    MCGradleGreeting2="Version $MCGradleVersion"
    echo "$MCGradleGreeting1"
    echo "$MCGradleGreeting2"
    echo ""

    # Check for update
    . ./internal/check_update.sh

    # Go to root project directory
    cd ../..

    # Get Forge mod name
    MCProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
    MCProjectName=${MCProjectName#*'"'}; MCProjectName=${MCProjectName%'"'*}
fi

echo -e "\e[33mWARNING: THIS ACTION WILL DELETE YOUR BUILD FOLDER, ECLIPSE/INTELLIJ WORKSPACE, AND ANY RUN CONFIGURATIONS!"
echo "THE RUN FOLDER WILL NOT BE DELETED BECAUSE IT IS NOT REQUIRED FOR A FULL CLEANUP."
printf "ARE YOU SURE YOU WANT TO DO THIS? \e[31mTHIS ACTION CANNOT BE UNDONE! \e[33m[ y/N ] \e[39m"
read MCReadHost
echo ""

case $MCReadHost in
Y | y)
    MCHasConfirmed=1
    ;;
*)
    MCHasConfirmed=0
    ;;
esac

if [ "$MCHasConfirmed" -eq 1 ]; then
    echo "Deleting Eclipse run configs and other cache files..."
    if ls ./*.launch 1> /dev/null 2>&1; then
        rm *.launch
    fi
    if [ -d "./.settings" ]; then
        rm -r ./.settings
    fi

    echo "Deleting IntelliJ run configs and other cache files..."
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
        echo "Calling Gradle to clean up the Eclipse workspace and build output..."
        echo ""
        ./gradlew clean cleanEclipse --warning-mode none
        echo ""
    else
        MCHasOneOrOther=1
    fi

    if [ "$MCHasBuildFolder" -eq 1 -a "$MCHasOneOrOther" -eq 1 ]; then
        # Delete the build folder via Gradle
        echo "Calling Gradle to clean up the build output..."
        echo ""
        ./gradlew clean --warning-mode none
        echo ""
    fi

    if [ "$MCHasEclipse" -eq 1 -a "$MCHasOneOrOther" -eq 1 ]; then
        # Delete the eclipse folder via Gradle
        echo "Calling Gradle to clean up the Eclipse workspace..."
        echo ""
        ./gradlew cleanEclipse --warning-mode none
        echo ""
    fi

    if [ "$MCGradleArgs" != "FromHub" ]
    then
        # Return to scripts directory
        cd Scripts/bash/
        read -s -n 1 -p "Press any key to exit MCGradle Scripts..."
        echo ""
        echo -e "\e[31mQuitting MCGradle Scripts...\e[39m"
    else
        read -s -n 1 -p "Press any key to return to the MCGradle Scripts Hub..."
        echo ""
        echo ""
    fi
fi