#!/bin/bash

# bash Shell Scripts for Minecraft Forge Projects
# Created, updated, and maintained by Jonathing
# Version 0.2.0

cd ../..

MyProjectName=`grep 'displayName=' src/main/resources/META-INF/mods.toml -m 1`
MyProjectName=${MyProjectName#*'"'}; MyProjectName=${MyProjectName%'"'*}
echo "$s"

# Generate the Eclipse run configs
echo "Generating the IntelliJ IDEA run configurations for $MyProjectName..."
echo ""
./gradlew genIntellijRuns --warning-mode none
echo ""

echo "Finished generating the IntelliJ IDEA run configurations for $MyProjectName."

cd Scripts/bash\ Scripts/
read -s -n 1 -p "Press any key to continue . . ."
echo ""
exit 0