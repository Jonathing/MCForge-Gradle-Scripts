#!/bin/bash

CANNOTUPDATE=0

if ! command -v curl &> /dev/null
then
    CANNOTUPDATE=1
fi

if [ $CANNOTUPDATE -eq 1 ]
then
    echo "We couldn't find curl in your Linux system."
    echo "MCGradle Scripts will not be able to check for updates."
    echo ""
fi

if [ $CANNOTUPDATE -ne 1 ]
then
    MyBASHUpdateVer=`curl --fail --silent https://raw.githubusercontent.com/Jonathing/MCForge-Gradle-Scripts/master/VERSIONS.txt | grep 'BASHVERSION='`
    MyBASHUpdateVer=${MyBASHUpdateVer#*'"'}; MyBASHUpdateVer=${MyBASHUpdateVer%'"'*}

    if [ $MyBASHVersion != $MyBASHUpdateVer ]
    then
        echo "An update is available for MCGradle Scripts! The latest version is $MyBASHUpdateVer"
        echo "To update, read \"UPDATE.md\" on how to update the submodule in your repository."
        echo ""
    fi
fi