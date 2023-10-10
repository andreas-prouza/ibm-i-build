#!/bin/bash

print_debug() {
 echo "#DEBUG-Remote "`date +"%F %T.%3N"`": "$BASH_COMMAND 
}

trap 'print_debug' DEBUG

cl -v "dspjob"

