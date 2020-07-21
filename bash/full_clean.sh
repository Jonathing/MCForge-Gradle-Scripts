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

if [ "$MCHasConfirmed" -eq 1 ]
then
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
    
fi

# [ -d "${d}" ] &&  echo "Directory $d found." || echo "Directory $d not found."