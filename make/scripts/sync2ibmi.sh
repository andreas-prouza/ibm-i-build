#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh


if [ $MODE == 'debug' ]
then

  echo "MODE: $MODE"

  echo "SYNC_LOG: $SYNC_LOG"

fi

rsync -av --rsync-path=/QOpenSys/pkgs/bin/rsync --exclude={'.git','.vscode','.project','.gitignore'} --delete "$WORKSPACE_FOLDER"/ "$REMOTE_HOST":"$REMOTE_WORKSPACE_FOLDER_NAME"/ > "$TEMP_DIR/SYNC_LOG.log"
mv $TEMP_DIR/SYNC_LOG.log "$SYNC_LOG"

if [ $MODE == 'debug' ]
then
  cat $SYNC_LOG
fi
