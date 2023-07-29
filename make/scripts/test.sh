#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh


echo -e "$COLOR_GREEN $MODE $COLOR_END"
echo $WORKSPACE_FOLDER
echo $SCRIPT
echo $SCRIPT_PATH
echo $REMOTE_WORKSPACE_FOLDER_NAME

{ ERROR=$( echo 'OK2'  2>&1 >&3 3>&-); } 3>"$TEMP_DIR/SYNC_LOG.log"
{ ERROR=$( ls error  2>&1 >&3 3>&-); } 3>"$TEMP_DIR/SYNC_LOG.log"

echo "output log $TEMP_DIR/SYNC_LOG.log"

cat "$TEMP_DIR/SYNC_LOG.log"