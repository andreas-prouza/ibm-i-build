#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh 0


if [ $MODE == 'debug' ]
then

  echo "MODE: $MODE"
  echo "SYNC2REMOTE_LOG: $SYNC2REMOTE_LOG"

fi

rsync -av   --exclude={'.git','.vscode','.project','.gitignore','boot','dev','etc','home','lib*','media','mnt','opt','proc','root','run','sbin','sys','srv','usr','var','Q*','www'} \
  --delete $WORKSPACE_FOLDER/ $REMOTE_HOST:$REMOTE_WORKSPACE_FOLDER_NAME/  > $TEMP_DIR/SYNC2REMOTE_LOG.log  2> $ERROR_OUTPUT
[[ -s "$ERROR_OUTPUT" ]] &&  error_handler

mv $TEMP_DIR/SYNC2REMOTE_LOG.log "$SYNC2REMOTE_LOG"  2> $ERROR_OUTPUT  
[[ -s "$ERROR_OUTPUT" ]] &&  error_handler

if [ $MODE == 'debug' ]
then
  cat $SYNC2REMOTE_LOG
fi


echo -e "$COLOR_GREEN finished sync to $REMOTE_HOST $COLOR_END"