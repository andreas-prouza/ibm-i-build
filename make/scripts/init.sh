
MODE=$1 # debug, ...

# Import global config
source $(dirname $(realpath "$0"))/../global.cfg


if [ -z "$MODE" ] # argument has not been passed
then
  MODE='default' # default value
fi

MODE=${MODE,,}


if [ $MODE == 'debug' ]
then

  echo -e "\n\n$COLOR_MAGENTA_BOLD ###################################################  $COLOR_END"
  echo -e "$COLOR_CYAN_BOLD Run ... $SCRIPT $COLOR_END"
  echo -e "$COLOR_MAGENTA_BOLD ################################################### $COLOR_END\n"

  set -x
  
fi


mkdir -p $WORKSPACE_FOLDER/logs
mkdir -p $WORKSPACE_FOLDER/build