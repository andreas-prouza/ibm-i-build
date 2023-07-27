#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/script.cfg


if [ $mode == 'debug' ]
then
  echo -e "\n\n###################################################"
  echo -e "Run ... $SCRIPT"
  echo -e "###################################################\n"


  echo "Mode: $mode"

  echo "Sync_log: $sync_log"
  set -x
fi

rsync -av --rsync-path=/QOpenSys/pkgs/bin/rsync --exclude={'.git','.vscode','.project','.gitignore'} --delete "$workspaceFolder"/ academy:~/myproject4/ > "$temp_dir/sync_log.log"
mv $temp_dir/sync_log.log "$sync_log"

if [ $mode == 'debug' ]
then
  cat $sync_log
fi
