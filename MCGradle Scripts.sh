#!/bin/bash

# Clear the screen
clear

# Get arguments
MCGradleArgs=$1

MCGradleAuthor="Jonathing"
MCGradleVersion="0.5.1"

# Print script information
MCGradleGreeting1="MCGradle Scripts by $MCGradleAuthor"
MCGradleGreeting2="Version $MCGradleVersion"
printf "$MCGradleGreeting1\n"
printf "$MCGradleGreeting2\n"
printf "\n"

# Go to root project directory
cd ..

# Check for update
. ./Scripts/bash/internal/check_update.sh

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
        if [ "$MCShowOptionsAgain" -eq 1 ]
        then
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

        if [ "$MCHasChosen" -eq 0 -a "$MCShowOptionsAgain" -eq 0 ]
        then
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
exit 0
