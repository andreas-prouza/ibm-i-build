#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh

printf '#!/QOpenSys/pkgs/bin/bash'"\\n\\n" > $COMPILE_SCRIPT

if [ $MODE == 'debug' -o $MODE == 'show-change-debug' ]
then

  echo "MODE: $MODE"

  printf 'set -x'"\\n\\n" >> $COMPILE_SCRIPT
fi



create_object_list() {
  make all -n | grep prod_obj | tee $COMPILE_OBJECT_LIST
}


case $MODE in 
  summary|default)
    make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT) | grep -i 'crtcmd|summary' | cut -d '|' --output-delimiter ': ' -f 2
    ;;
  detailed)
    make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT) | grep -i crtcmd | cut -d '|' --output-delimiter ': ' -f 2,3 
    ;;
  debug)
    make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT)
    ;;
  simulate)
    make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT) | grep -i 'crtcmd|summary' | cut -d '|' --output-delimiter ': ' -f 2
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
    echo "MODE $MODE is not valid. Valid options {summary | debug | detailed | simulate | show-change-debug | schow-change-compile | show-change-object | create-object-list}"
esac