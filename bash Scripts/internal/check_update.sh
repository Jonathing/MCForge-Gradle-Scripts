#!/bin/bash

CANNOTUPDATE=0

# Check for curl
if ! command -v curl &> /dev/null
then
    CANNOTUPDATE=1
fi

# Cancel update if curl is not found
if [ $CANNOTUPDATE -eq 1 ]
then
    echo "We couldn't find curl in your Linux system."
    echo "MCGradle Scripts will not be able to check for updates."
    echo ""
fi

# Download the update file and check the current script version
if [ $CANNOTUPDATE -ne 1 ]
then
    MyBASHUpdateVer=`curl --fail --silent https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/VERSIONS.txt | grep 'BASHVERSION='`

    if [ $MyBASHUpdateVer ]
    then
        MyBASHUpdateVer=${MyBASHUpdateVer#*'"'}; MyBASHUpdateVer=${MyBASHUpdateVer%'"'*}

        if [ $MyBASHVersion != $MyBASHUpdateVer ]
        then
            echo "An update is available for MCGradle Scripts! The latest version is $MyBASHUpdateVer"
            echo "To update, read \"UPDATE.md\" on how to update the submodule in your repository."
            echo ""
        fi
    fi

    if [ ! $MyBASHUpdateVer ]
    then
        echo "MCGradle Scripts failed to check for updates!"
        echo "We weren't able to download the update file from GitHub."
        echo "If you are connected to the internet without issues, report this to the issue tracker!"
        echo "https://github.com/Jonathing/MCForge-Gradle-Scripts/issues"
        echo ""
    fi
fi