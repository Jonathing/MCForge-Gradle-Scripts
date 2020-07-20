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
printf "ARE YOU SURE YOU WANT TO DO THIS? \e[31mTHIS ACTION CANNOT BE UNDUNE! \e[33m[ y/N ] \e[39m"
read MCReadHost
echo ""

case $MCReadHost in
Y)
    MCHasConfirmed=1
    ;;
*)
    MCHasConfirmed=0
    ;;
esac

if [ "$MCHasConfirmed" -eq 1 ]
then
    if ls "./*.launch" 1> /dev/null 2>&1; then
        echo "files do exist"
    else
        echo "files do not exist"
    fi
fi

# [ -d "${d}" ] &&  echo "Directory $d found." || echo "Directory $d not found."