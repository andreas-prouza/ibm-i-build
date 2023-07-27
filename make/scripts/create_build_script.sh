#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/script.cfg

printf '#!/QOpenSys/pkgs/bin/bash'"\\n\\n" > $compile_script

if [ $mode == 'debug' -o $mode == 'show-change-debug' ]
then
  echo -e "\n\n###################################################"
  echo -e "Run ... $SCRIPT"
  echo -e "###################################################\n"

  echo "Mode: $mode"

  set -x

  printf 'set -x'"\\n\\n" >> $compile_script
fi



create_object_list() {
  make all -n | grep prod_obj | tee $compile_object_list
}


case $mode in 
  summary|default)
    make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $compile_script) | grep -i 'crtcmd|summary' | cut -d '|' --output-delimiter ': ' -f 2
    ;;
  detailed)
    make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $compile_script) | grep -i crtcmd | cut -d '|' --output-delimiter ': ' -f 2,3 
    ;;
  debug)
    make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $compile_script)
    ;;
  simulate)
    make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $compile_script) | grep -i 'crtcmd|summary' | cut -d '|' --output-delimiter ': ' -f 2
    ;;
  show-change-debug)
    make all -n |grep crtcmd
    ;;
  schow-change-compile)
    make all -n |grep crtcmd | cut -d '|' --output-delimiter ': ' -f 2,3
    ;;
  show-change-object)
    make all -n |grep crtcmd | cut -d '|' --output-delimiter ': ' -f 2
    ;;
  create-object-list)
    create_object_list
    ;;
  *)
    echo "Mode $mode is not valid. Valid options {summary | debug | detailed | simulate | show-change-debug | schow-change-compile | show-change-object | create-object-list}"
esac