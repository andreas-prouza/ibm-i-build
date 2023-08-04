#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh

printf '#!/bin/bash'"\\n\\n" > $COMPILE_SCRIPT
chmod +x $COMPILE_SCRIPT

if [ $MODE == 'debug' -o $MODE == 'show-change-debug' ]
then
  printf "print_debug() {\\n"' echo "#DEBUG-Remote: "$BASH_COMMAND '"\\n}\\n\\n" >> $COMPILE_SCRIPT
  printf "trap 'print_debug' DEBUG\\n\\n" >> $COMPILE_SCRIPT
fi



create_object_list() {
  make all -n  2> $ERROR_OUTPUT  | grep prod_obj | tee $COMPILE_OBJECT_LIST
}


case $MODE in 
  summary|default)
    make all -n  2> $ERROR_OUTPUT | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT) | grep -i 'crtcmd|summary' | cut -d '|' --output-delimiter ': ' -f 2
    ;;
  detailed)
    #make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT) | grep -i crtcmd | cut -d '|' --output-delimiter ': ' -f 2,3 
    make all -n  2> $ERROR_OUTPUT | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT) | grep -i crtcmd | cut -d '|' --output-delimiter ': ' -f 2,3
    ;;
  debug)
    #make all -n | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT)
    make all -n  2> $ERROR_OUTPUT  | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT)
    #$({ make all -n > >(tee > >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT)); } > stdout.txt 2> stderr.txt )
    # OK ERROR=$( { make all -n > >(tee > >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT)) ; } 2>&1 )
    #ERROR=$( { make all -n > >(tee > >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT)) ; } 2>&1 )
    #ERROR=$($(make all -n  > >(tee > >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT))  2> >(tee stderr.txt >&2) 2>&3) 3>&1)  #(tee stderr.log >&2) # 2>&1)
    ;;
  simulate)
    make all -n  2> $ERROR_OUTPUT  | tee >(grep -ivE 'crtcmd|prod_obj' >> $COMPILE_SCRIPT) | grep -i 'crtcmd|summary' | cut -d '|' --output-delimiter ': ' -f 2
    ;;
  show-change-debug)
    make all -n  2> $ERROR_OUTPUT  |grep crtcmd
    ;;
  schow-change-compile)
    make all -n  2> $ERROR_OUTPUT  |grep crtcmd | cut -d '|' --output-delimiter ': ' -f 2,3
    ;;
  show-change-object)
    make all -n  2> $ERROR_OUTPUT  |grep crtcmd | cut -d '|' --output-delimiter ': ' -f 2
    ;;
  create-object-list)
    create_object_list
    ;;
  *)
    echo "MODE $MODE is not valid. Valid options {summary | debug | detailed | simulate | show-change-debug | schow-change-compile | show-change-object | create-object-list}"
esac

[[ -s "$ERROR_OUTPUT" ]] &&  error_handler

echo -e "$COLOR_GREEN \nfinished creation of build script $COLOR_END\n"