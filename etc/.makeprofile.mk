#############################################################
#
# Set up your own development environment
#
# Here you can override your specific environment values
# which will not be synchronized to Git
#
#    * IFS path to your own project path
#    * Target lib
#    * ...
#
#############################################################

#############################################################
### Source directory
#############################################################
#SRC_DIR=/home/prouza/myproject
#ACTGRP=PROUZAGRP
#BNDDIR_LIB=PROUZALIB

#############################################################
### Include DIR (e.g. to search for /copy members in RPG sources)
#############################################################
#INC_DIR=/home/prouza/myproject

#############################################################
### Directory for compile logs
#############################################################
#LOG_DIR=./logs

#############################################################
### Directory to create a dummy file for each object. (For source timestamp change check)
#############################################################
#TGT_DIR=./build

#############################################################
### Target library - Global
## Global target lib
#############################################################
#TGTLIB_OBJ_GLOBAL=PROUZALIB
## If global target lib is empty ==> Source-Lib will be used
#TGTLIB_OBJ_GLOBAL=

#############################################################
### Target library - Specific
## Replace map specific libs to a separate target
## TGTLIB_{SRC-LIB} := {new-compile-lib}
#############################################################
TGTLIB_PROUZALIB := PROUZAT1
TGTLIB_PROUZALIB2 := PROUZAT2
TGTLIB_PROUZA4 := PROUZAT3
TGTLIB_PROUZA2 := PROUZAT3
#TGTLIB_PROUZA4 := *source
#TGTLIB_OBJ_GLOBAL=Hansi




