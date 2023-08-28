
#set +o xtrace
#trap - DEBUG

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
print_debug() { 
  echo "#DEBUG-$SCRIPT: "$BASH_COMMAND >> $STD_OUTPUT_TMP
}
#on_exit() {
  #cat $STD_OUTPUT_TMP > $STD_OUTPUT 2>/dev/null
#}

#trap 'on_exit' EXIT
trap 'error_handler' ERR

exec > >(tee -a $STD_OUTPUT_TMP)

if [ -z "$MODE" ] # argument has not been passed
then
  MODE='default' # default value
fi

MODE=${MODE,,}


echo -e "\n$COLOR_MAGENTA_BOLD###################################################  $COLOR_END"
echo -e "$COLOR_CYAN_BOLD`date +"%F %T.%3N"` ... $SCRIPT $COLOR_END"
echo -e "$COLOR_MAGENTA_BOLD################################################### $COLOR_END\n"


#exec > (tee -a stdout.txt.log)  #"$STD_OUTPUT_TMP".log
#set -x
#set -v
#set -o xtrace
trap 'print_debug' DEBUG
