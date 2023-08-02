#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh


ls -d $WORKSPACE_FOLDER/build/*/ | xargs -I {} find {} -type f | while read -r line; do touch $line -d "`cat $line`"; done

echo -e "$COLOR_GREEN finished clean up of folder: \n`ls -d $WORKSPACE_FOLDER/build/*/` $COLOR_END"