#!/bin/bash 

SCRIPT_VARS=/tmp/script-variables.txt
SCRIPT_VARS2=/tmp/script-variables2.txt
( set -o posix ; set ) > $SCRIPT_VARS

# Import global config
source $(dirname $(realpath "$0"))/init.sh

( set -o posix ; set ) > $SCRIPT_VARS2
diff $SCRIPT_VARS $SCRIPT_VARS2


echo -e "$COLOR_GREEN $MODE $COLOR_END"
echo WORKSPACE_FOLDER: $WORKSPACE_FOLDER
echo Script: $SCRIPT
echo SCRIPT_PATH: $SCRIPT_PATH
echo REMOTE_WORKSPACE_FOLDER_NAME: $REMOTE_WORKSPACE_FOLDER_NAME



echo "output log $TEMP_DIR/SYNC2REMOTE_LOG.log"

cat "$TEMP_DIR/SYNC2REMOTE_LOG.log"
