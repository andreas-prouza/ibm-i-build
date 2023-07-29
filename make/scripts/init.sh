
MODE=$1 # debug, ...

# Import global config
source $(dirname $(realpath "$0"))/../global.cfg

ERROR=

error_handler() {
  sleep 0 # Only to get stdout first printed and errors at the end of the console
  set +x
  echo -e "\n\n$COLOR_RED Error occured! $COLOR_END\n"
  ERROR=$(<$ERROR_OUTPUT)
  echo -e "$COLOR_RED $ERROR $COLOR_END\n"
  exit 1
}

trap 'error_handler' ERR

if [ -z "$MODE" ] # argument has not been passed
then
  MODE='default' # default value
fi

MODE=${MODE,,}


if [ $MODE == 'debug' ]
then

  set -x

fi

echo -e "\n\n$COLOR_MAGENTA_BOLD ###################################################  $COLOR_END"
echo -e "$COLOR_CYAN_BOLD Run ... $SCRIPT $COLOR_END"
echo -e "$COLOR_MAGENTA_BOLD ################################################### $COLOR_END\n"

mkdir -p $WORKSPACE_FOLDER/logs
mkdir -p $WORKSPACE_FOLDER/build