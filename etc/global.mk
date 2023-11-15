# Source directory
SRC_DIR=./src

# Include DIR (e.g. to search for /copy members in RPG sources)
#INC_DIR=$(SRC_DIR)/$$(dir $$@)
INC_DIR='$(SRC_DIR)/$$(dir $$(patsubst %/,%,$$(dir $$(subst ',,$$@))))' '$(SRC_DIR)/prouzalib/'


# Target libraries
# Will be taken from qualified source name (can be overwritten in .makeprofile.mk)
#TGTLIB_OBJ_GLOBAL=PROUZALIB

TGT_BNDDIR=*LIBL/PROUZADIR
INCLUDE_BNDDIR=*LIBL/PROUZADIR

ACTGRP=PROUZAGRP
STGMDL=*SNGLVL

# You can also add other libs if necessary (separated by blanks)
LIBLIST=$(TGTLIB_OBJ_GLOBAL) PROUZAT1

DBGVIEW=*SOURCE
TGTRLS=*CURRENT
TGTCCSID=*JOB