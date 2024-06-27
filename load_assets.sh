#!/bin/sh

echo $0
mkdir _temp_
GIT_SKY_URL="https://github.com/rpgwhitelock/AllSkyFree_Godot"

GIT=`which git`
cd _temp_
${GIT} clone ${GIT_SKY_URL}
mv AllSkyFree_Godot/addons/AllSkyFree ../addons/


