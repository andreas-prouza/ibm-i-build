#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh


rsync -avz --rsync-path=/QOpenSys/pkgs/bin/rsync --include={'logs/***','build/***'} --exclude='*' --delete "$REMOTE_HOST":"$REMOTE_WORKSPACE_FOLDER_NAME"  "$WORKSPACE_FOLDER" > "$TEMP_DIR/SYNC_BACK_LOG.log"
mv $TEMP_DIR/SYNC_BACK_LOG.log "$SYNC_BACK_LOG"


if [ $MODE == 'debug' ]
then
  cat $SYNC_BACK_LOG
fi