#!/bin/bash

CANNOTUPDATE=0

# Check for curl
if ! command -v curl &> /dev/null
then
    CANNOTUPDATE=1
fi

# Cancel update if curl was not found
if [ $CANNOTUPDATE -eq 1 ]
then
    echo "curl was not found on your Linux system!"
    echo "MCGradle Scripts will not be able to check for updates."
    echo ""
fi

# Continue if curl was found
if [ $CANNOTUPDATE -ne 1 ]
then
    # Download the update file
    MCGradleUpdateVer=`curl --fail --silent https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/VERSIONS.txt | grep 'LATESTVERSION='`

    # Continue if update file was downloaded successfully
    if [ $MCGradleUpdateVer ]
    then
        # Extract string within double quotes
        MCGradleUpdateVer=${MCGradleUpdateVer#*'"'}; MCGradleUpdateVer=${MCGradleUpdateVer%'"'*}

        # Inform the user if MCGradle Scripts can be updated
        if [ $MCGradleVersion != $MCGradleUpdateVer ]
        then
            echo "An update is available for MCGradle Scripts! The latest version is $MCGradleUpdateVer"
            echo "To update, read \"UPDATE.md\" on how to update MCGradle Scripts in your repository."
            echo ""
        fi
    fi

    # Cancel if the update file download failed
    if [ ! $MCGradleUpdateVer ]
    then
        echo "MCGradle Scripts failed to check for updates!"
        echo "If you are connected to the internet without issues, report this to the issue tracker!"
        echo "https://github.com/Jonathing/MCGradle-Scripts/issues"
        echo ""
    fi
fi