#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/script.cfg


if [ $mode == 'debug' ]
then

  echo -e "\n\n###################################################"
  echo -e "Run ... $SCRIPT"
  echo -e "###################################################\n"

  set -x

fi


rsync -avz --rsync-path=/QOpenSys/pkgs/bin/rsync --include={'logs/***','build/***'} --exclude='*' --delete academy:~/myproject4/  "$workspaceFolder" > $sync_back_log


if [ $mode == 'debug' ]
then
  cat $sync_log
fi