#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh

# Undo changes
# git restore -s@ -SW -- build

# Get version from another branch
git checkout remotes/origin/production -- build

ls -d $WORKSPACE_FOLDER/build/*/ | xargs -I {} find {} -type f | while read -r line; do touch $line -d "`cat $line`"; done

echo -e "$COLOR_GREEN finished clean up of folder: \n`ls -d $WORKSPACE_FOLDER/build/*/` $COLOR_END"