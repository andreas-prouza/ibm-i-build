#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh 0

#set -o xtrace

rsync -chavz --include={'logs/***','build/***'} --exclude='*'  $REMOTE_HOST:$REMOTE_WORKSPACE_FOLDER_NAME/  $WORKSPACE_FOLDER/  2> $ERROR_OUTPUT  >$TEMP_DIR/SYNC_BACK_LOG.log
[[ -s "$ERROR_OUTPUT" ]] &&  error_handler

mv $TEMP_DIR/SYNC_BACK_LOG.log $SYNC_BACK_LOG  2> $ERROR_OUTPUT  
[[ -s "$ERROR_OUTPUT" ]] &&  error_handler


if [ $MODE == 'debug' ]
then
  cat $SYNC_BACK_LOG
fi

echo -e "$COLOR_GREEN finished sync back logs and build files $COLOR_END"