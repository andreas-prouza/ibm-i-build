#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh


if [ $MODE == 'debug' ]
then

  echo "MODE: $MODE"

  echo "SYNC_LOG: $SYNC_LOG"

fi

rsync -av --rsync-path=/QOpenSys/pkgs/bin/rsync --exclude={'.git','.vscode','.project','.gitignore'} --delete "$WORKSPACE_FOLDER"/ "$REMOTE_HOST":"$REMOTE_WORKSPACE_FOLDER_NAME"/   2> $ERROR_OUTPUT   >"$TEMP_DIR/SYNC_LOG.log"
[[ -s "$ERROR_OUTPUT" ]] &&  error_handler

mv $TEMP_DIR/SYNC_LOG.log "$SYNC_LOG"  2> $ERROR_OUTPUT  
[[ -s "$ERROR_OUTPUT" ]] &&  error_handler

if [ $MODE == 'debug' ]
then
  cat $SYNC_LOG
fi


echo -e "$COLOR_GREEN finished sync to $REMOTE_HOST $COLOR_END"