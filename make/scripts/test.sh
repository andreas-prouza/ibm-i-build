#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh


echo -e "$COLOR_GREEN $MODE $COLOR_END"
echo $WORKSPACE_FOLDER
echo $SCRIPT
echo $SCRIPT_PATH
echo $REMOTE_WORKSPACE_FOLDER_NAME