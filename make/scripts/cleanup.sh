#!/bin/bash 

SCRIPT_VARS=/tmp/script-variables.txt
SCRIPT_VARS2=/tmp/script-variables2.txt
( set -o posix ; set ) > $SCRIPT_VARS


# Only to clean up the output file
source $(dirname $(realpath "$0"))/../global.cfg
echo '' > $STD_OUTPUT_TMP

# Import global config
source $(dirname $(realpath "$0"))/init.sh


# Print all script variables
if [ $MODE == 'debug' -o $MODE == 'show-change-debug' ]
then
  ( set -o posix ; set ) > $SCRIPT_VARS2
  diff $SCRIPT_VARS $SCRIPT_VARS2 >> $STD_OUTPUT_TMP || true
  #diff $SCRIPT_VARS $SCRIPT_VARS2 2>$ERROR_OUTPUT
fi


echo WORKSPACE_FOLDER $WORKSPACE_FOLDER


mkdir -p $WORKSPACE_FOLDER/tmp/logs
mkdir -p $WORKSPACE_FOLDER/logs
mkdir -p $WORKSPACE_FOLDER/build

find $WORKSPACE_FOLDER/logs -maxdepth 1 -type f -delete
rm $WORKSPACE_FOLDER/logs/**/* || true 2>/dev/null
rm $WORKSPACE_FOLDER/tmp/* || true 2>/dev/null
