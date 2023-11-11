#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh

ssh "$REMOTE_HOST" "source .profile; mkdir -p $REMOTE_WORKSPACE_FOLDER_NAME; cd $REMOTE_WORKSPACE_FOLDER_NAME; ./$COMPILE_SCRIPT || true" >> $RUN_BUILD_LOG 2> $ERROR_OUTPUT
[[ -s "$ERROR_OUTPUT" ]] &&  error_handler

echo -e "$COLOR_GREEN finished build $COLOR_END"