#!/bin/bash

# bash Shell Scripts for Minecraft Forge Projects
# Created, updated, and maintained by Jonathing
# Version 0.2.0

cd ../..

MyProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
MyProjectName=${MyProjectName#*'"'}; MyProjectName=${MyProjectName%'"'*}
echo "$s"

# Build Blue Skies
echo "Building $MyProjectName..."
echo ""
./gradlew build --warning-mode none
echo ""

echo "Finished building $MyProjectName."
echo "If the build was successful, the output should be located under build\libs"

cd Scripts/bash\ Scripts/
read -s -n 1 -p "Press any key to continue . . ."
echo ""
exit 0
