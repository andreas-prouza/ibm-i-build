#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/script.cfg

if [ $mode == 'debug' ]
then

  echo -e "\n\n###################################################"
  echo -e "Run ... $SCRIPT"
  echo -e "###################################################\n"

  echo "Mode: $mode"
  echo "workspaceFolder: $workspaceFolder"

  set -x

fi

ssh academy "source .profile; cd ~/myproject4; ./$compile_script || true"
