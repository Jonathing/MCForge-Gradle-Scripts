#!/bin/bash

# Get arguments
MCGradleArgs=$1

CANNOTUPDATE=0

# Check for curl
if ! command -v curl &> /dev/null; then
    CANNOTUPDATE=1
fi

# Cancel update if curl was not found
if [ $CANNOTUPDATE -eq 1 ]; then
    printf "\e[91mcurl was not found on your Linux system!\n"
    printf "MCGradle Scripts will not be able to check for updates.\e[39m\n\n"
fi

# Continue if curl was found
if [ $CANNOTUPDATE -ne 1 ]; then
    # Download the update file
    MCGradleUpdateVer=`curl --fail --silent https://raw.githubusercontent.com/Jonathing/MCGradle-Scripts/master/VERSIONS.txt | grep 'LATESTVERSION='`

    # Continue if update file was downloaded successfully
    if [ $MCGradleUpdateVer ]; then
        # Extract string within double quotes
        MCGradleUpdateVer=${MCGradleUpdateVer#*'"'}; MCGradleUpdateVer=${MCGradleUpdateVer%'"'*}

        if [ "$MCGradleArgs" = "FromHub" ]; then
            MCHubUpdVer="$MCGradleUpdateVer"
        else
            # Inform the user if MCGradle Scripts can be updated
            if [ $MCGradleVersion != $MCGradleUpdateVer ]; then
                printf "\e[92mAn update is available for MCGradle Scripts! The latest version is $MCGradleUpdateVer\n"
                printf "To update, run the main script and follow through with the update process.\e[39m\n\n"
            fi
        fi

    fi

    # Cancel if the update file download failed
    if [ ! $MCGradleUpdateVer ]; then
        printf "\e[91mMCGradle Scripts failed to check for updates!\n"
        printf "If you are connected to the internet without issues, report this to the issue tracker!\n"
        printf "https://github.com/Jonathing/MCGradle-Scripts/issues\n\n\e[39m"
    fi
fi
