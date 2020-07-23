#!/bin/bash

# Clear the screen
clear

# Get arguments
MCGradleArgs=$1

MCGradleAuthor="Jonathing"
MCGradleVersion="0.5.3"

# Print script information
MCGradleGreeting1="MCGradle Scripts by $MCGradleAuthor"
MCGradleGreeting2="Version $MCGradleVersion"
printf "$MCGradleGreeting1\n"
printf "$MCGradleGreeting2\n"
printf "\n"

# Check for update
. ./bash/internal/check_update.sh "FromHub"

MCWantsToUpdate=0
MCHasUpdated=0

if [ "$MCHubUpdVer" != "$MCGradleVersion" ]; then
    printf "\e[92mAn update is available for MCGradle Scripts! The latest version is $MCHubUpdVer\e[39m\n"

    MCHasChosen=0
    while [ "$MCHasChosen" -eq 0 ]; do
        printf "\e[93mWould you like to update now? This might take some time. [ y/N ] \e[39m"
        read MCReadHost
        printf "\n"

        case $MCReadHost in
        Y | y)
            MCHasChosen=1
            MCWantsToUpdate=1
            ;;
        N | n)
            MCHasChosen=1
            ;;
        *)
            MCHasChosen=0
            ;;
        esac

        if [ "$MCHasChosen" -eq 0 ]; then
            printf "\e[93mThat's not a valid option.\e[39m\n"
        fi
    done

    if [ "$MCWantsToUpdate" -eq 1 ]; then
        printf "We want to update\n"

        # Check for curl
        if command -v git &> /dev/null; then
            printf "Downloading MCGradle Scripts...\n"
            git clone https://github.com/Jonathing/MCGradle-Scripts.git update -q

            printf "Installing MCGradle Scripts...\n"
            rm -rf ./Windows/
            rm -rf ./PowerShell/
            rm -rf ./bash/
            rm -f ./MCGradle\ Scripts.bat
            rm -f ./MCGradle\ Scripts.ps1
            rm -f ./MCGradle\ Scripts.sh
            rm -f ./CHANGELOG.md
            rm -f ./README.md
            rm -f ./UPDATE.md
            rm -f ./.gitignore

            mv -f ./update/Windows/ ./Windows/
            mv -f ./update/PowerShell/ ./PowerShell/
            mv -f ./update/bash/ ./bash/
            mv -f ./update/MCGradle\ Scripts.bat ./MCGradle\ Scripts.bat
            mv -f ./update/MCGradle\ Scripts.ps1 ./MCGradle\ Scripts.ps1
            mv -f ./update/MCGradle\ Scripts.sh ./MCGradle\ Scripts.sh
            mv -f ./update/CHANGELOG.md ./CHANGELOG.md
            mv -f ./update/README.md ./README.md
            mv -f ./update/UPDATE.md ./UPDATE.md
            mv -f ./update/.gitignore ./.gitignore

            printf "Cleaning up...\n"
            rm -rf ./update/

            printf "\nMCGradle Scripts has been successfully updated!\n"
            printf "Restarting MCGradle Scripts...\n"

            MCHasUpdated=1

            sleep 3s

            ./MCGradle\ Scripts.sh
        else
            printf "We weren't able to find git on your system!\n"
            printf "MCGradle Scripts will not be able to update.\n\n"
        fi
    else
        printf "You have decided not to update MCGradle Scripts.\n"
        printf "If you change your mind, run the main script again.\n"
        printf "Continuing to the hub...\n\n"
    fi
fi

if [ "$MCHasUpdated" -ne 1 ]; then
    # Go to root project directory
    cd ..

    # Get Forge mod name
    MCProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
    MCProjectName=${MCProjectName#*'"'}; MCProjectName=${MCProjectName%'"'*}

    MCGradleOptionInfo1="Gradle Commands"
    MCGradleOption1="1. Build $MCProjectName"
    MCGradleOption2="2. Set up your Eclipse workspace"
    MCGradleOption3="3. Set up your IntelliJ IDEA workspace"
    MCGradleOption4="4. Generate the Eclipse run configurations"
    MCGradleOption5="5. Generate the IntelliJ IDEA run configurations"
    MCGradleOption6="6. Do a full cleanup of the workspace"
    MCGradleOptionInfo2="MCGradle Scripts Options"
    MCGradleOptionC="C. Clear the screen"
    MCGradleOptionR="R. Show the options again"
    MCGradleOptionA="A. About MCGradle Scripts"
    MCGradleOptionQ="Q. Quit MCGradle Scripts"
    printf "What would you like to do today?\n\n"
    MCShowOptionsAgain=1

    MCGradleCommand=0
    MCHasChosen=0
    MCShowOptionsAgain=1

    while [ "$MCGradleCommand" -ne 99 ]; do
        while [ "$MCHasChosen" -eq 0 ]; do
            if [ "$MCShowOptionsAgain" -eq 1 ]; then
                printf "$MCGradleOptionInfo1\n"
                printf "$MCGradleOption1\n"
                printf "$MCGradleOption2\n"
                printf "$MCGradleOption3\n"
                printf "$MCGradleOption4\n"
                printf "$MCGradleOption5\n"
                printf "$MCGradleOption6\n"
                printf "\n"
                printf "$MCGradleOptionInfo2\n"
                printf "$MCGradleOptionC\n"
                printf "$MCGradleOptionR\n"
                printf "$MCGradleOptionA\n"
                printf "$MCGradleOptionQ\n\n"
            else
                printf "\e[93mPress R to see the options again.\e[39m\n"
            fi
            
            MCShowOptionsAgain=0
            printf "\e[93mPlease pick an option [ 1-6, R, Q, ... ] \e[39m"

            read MCReadHost
            printf "\n"

            case $MCReadHost in
            1)
                MCHasChosen=1
                MCGradleCommand=1
                ;;
            2)
                MCHasChosen=1
                MCGradleCommand=2
                ;;
            3)
                MCHasChosen=1
                MCGradleCommand=3
                ;;
            4)
                MCHasChosen=1
                MCGradleCommand=4
                ;;
            5)
                MCHasChosen=1
                MCGradleCommand=5
                ;;
            6)
                MCHasChosen=1
                MCGradleCommand=6
                ;;
            C | c)
                MCHasChosen=1
                MCGradleCommand=97
                MCShowOptionsAgain=1
                ;;
            A | a)
                MCHasChosen=1
                MCGradleCommand=98
                ;;
            Q | q)
                MCHasChosen=1
                MCGradleCommand=99
                ;;
            R | r)
                MCHasChosen=0
                MCShowOptionsAgain=1
                ;;
            *)
                MCHasChosen=0
                MCGradleCommand=0
                ;;
            esac

            if [ "$MCHasChosen" -eq 0 -a "$MCShowOptionsAgain" -eq 0 ]; then
                printf "\e[93mThat's not a valid option.\e[39m\n"
            fi
        done

        case $MCGradleCommand in
        1)
            . ./Scripts/bash/build.sh FromHub
            MCHasChosen=0
            ;;
        2)
            . ./Scripts/bash/setup_eclipse.sh FromHub
            MCHasChosen=0
            ;;
        3)
            . ./Scripts/bash/setup_intellij.sh FromHub
            MCHasChosen=0
            ;;
        4)
            . ./Scripts/bash/genEclipseRuns.sh FromHub
            MCHasChosen=0
            ;;
        5)
            . ./Scripts/bash/genIntellijRuns.sh FromHub
            MCHasChosen=0
            ;;
        6)
            . ./Scripts/bash/full_clean.sh FromHub
            MCHasChosen=0
            ;;
        97)
            clear
            MCHasChosen=0
            ;;
        98)
            printf "MCGradle Scripts\n"
            printf "$MCGradleGreeting2\n"
            printf "Running on GNU bash\n"
            printf "Written and Maintained by $MCGradleAuthor\n\n"

            printf "Original Windows batch scripts written by Bailey (KingPhygieBoo)\n\n"

            read -s -n 1 -p "Press any key to continue..."

            printf "\n\n"
            MCHasChosen=0
            ;;
        99)
            printf "\e[91mQuitting MCGradle Scripts...\e[39m\n"
            MCHasChosen=0
            ;;
        *)
            printf "\e[91mAn error has occured.\e[39m\n"
            MCHasChosen=0
            ;;
        esac
    done

    # Return to scripts directory
    cd Scripts/

    printf "\n"
fi

exit 0
