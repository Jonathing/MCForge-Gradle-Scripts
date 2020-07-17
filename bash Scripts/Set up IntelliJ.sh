#!/bin/bash

# bash Shell Scripts for Minecraft Forge Projects
# Created, updated, and maintained by Jonathing
# Version 0.2.0

cd ../..

MyProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
MyProjectName=${MyProjectName#*'"'}; MyProjectName=${MyProjectName%'"'*}
echo "$s"

echo "The IntelliJ IDEA workspace for Forge is no longer set up through a command."
echo "To import the project to IntelliJ IDEA, simply open the \"build.gradle\" file as a project."
echo "Gradle will do the rest for you as it imports and indexes the project into IntelliJ."
echo ""

cd Scripts/bash\ Scripts/

read -s -n 1 -p "Press any key to continue . . ."
echo ""
exit 0