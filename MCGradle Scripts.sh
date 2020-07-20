#!/bin/bash

# Clear the screen
clear

# Get arguments
MCGradleArgs=$1

MCGradleAuthor="Jonathing"
MCGradleVersion="0.5.0"

# Print script information
MCGradleGreeting1="MCGradle Scripts by $MCGradleAuthor"
MCGradleGreeting2="Version $MCGradleVersion"
echo "$MCGradleGreeting1"
echo "$MCGradleGreeting2"
echo ""

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
MCGradleOptionInfo2="MCGradle Scripts Options"
MCGradleOptionC="C. Clear the screen"
MCGradleOptionR="R. Show the options again"
MCGradleOptionA="A. About MCGradle Scripts"
MCGradleOptionQ="Q. Quit MCGradle Scripts"
echo "What would you like to do today?"
echo ""
MCShowOptionsAgain=1

MCGradleCommand=0
MCHasChosen=0
MCShowOptionsAgain=1

while [ "$MCGradleCommand" -ne 99 ]; do
    while [ "$MCHasChosen" -eq 0 ]; do
        if [ "$MCShowOptionsAgain" -eq 1 ]
        then
            echo "$MCGradleOptionInfo1"
            echo "$MCGradleOption1"
            echo "$MCGradleOption2"
            echo "$MCGradleOption3"
            echo "$MCGradleOption4"
            echo "$MCGradleOption5"
            echo ""
            echo "$MCGradleOptionInfo2"
            echo "$MCGradleOptionC"
            echo "$MCGradleOptionR"
            echo "$MCGradleOptionA"
            echo "$MCGradleOptionQ"
            echo ""
        else
            echo -e "\e[33mPress R to see the options again.\e[39m"
        fi
        
        MCShowOptionsAgain=0
        printf "\e[33mPlease pick an option [ 1-5, R, Q, ... ] \e[39m"

        read MCReadHost
        echo ""

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
        C)
            MCHasChosen=1
            MCGradleCommand=97
            MCShowOptionsAgain=1
            ;;
        A)
            MCHasChosen=1
            MCGradleCommand=98
            ;;
        Q)
            MCHasChosen=1
            MCGradleCommand=99
            ;;
        R)
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
            echo -e "\e[33mThat's not a valid option.\e[39m"
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
    97)
        clear
        MCHasChosen=0
        ;;
    98)
        echo "MCGradle Scripts"
        echo "$MCGradleGreeting2"
        echo "Running on GNU bash"
        echo "Written and Maintained by $MCGradleAuthor"
        echo ""
        echo "Original Windows batch scripts written by Bailey (KingPhygieBoo)"
        echo ""

        read -s -n 1 -p "Press any key to continue..."

        echo ""
        echo ""
        MCHasChosen=0
        ;;
    99)
        echo -e "\e[31mQuitting MCGradle Scripts...\e[39m"
        MCHasChosen=0
        ;;
    *)
        echo -e "\e[31mAn error has occured.\e[39m"
        MCHasChosen=0
        ;;
    esac
done

# Return to scripts directory
cd Scripts/

echo ""
exit 0
