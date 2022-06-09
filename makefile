# General infos
#	- Using TABs instead of Blanks is necessary!
# Tabs: for processing of all targets
# Blanks executing at very first (preprocessing)

#########################################################
# our configuration
#########################################################
SHELL=/QOpenSys/pkgs/bin/bash
#SHELL=/QOpenSys/usr/bin/qsh

# Source directory (!full path!)
SRC_DIR=~/myapp

# Include DIR (e.g. to search for /copy members in RPG sources) (!full path!)
INC_DIR=~/myapp

MAKEFILE_DIR=$(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

# Our Default Binding Directory
BND_DIR=prouzadir

# Target libraries
TGTLIB_PGM=PROUZAPGM
TGTLIB_DBF=PROUZADB

ACTGRP=PROUZAGRP
STGMDL=*SNGLVL

# You can also set other libs if necessary
LIBLIST=$(TGTLIB_PGM) $(TGTLIB_DBF)

DBGVIEW=*SOURCE
TGTRLS=*CURRENT
TGTCCSID=1141

# Directory for compile logs
LOG_DIR=$(SRC_DIR)/logs
# Directory to create a dummy file for each object. (For source timestamp change check)
TGT_DIR=$(SRC_DIR)/build

# Directory/Source-PF where different type of sources are stored
PF_SRCF=$(SRC_DIR)/qddssrc
LF_SRCF=$(SRC_DIR)/qddssrc
CLLE_SRCF=$(SRC_DIR)/qcllesrc
RPGLE_SRCF=$(SRC_DIR)/qrpglesrc
SQLRPGLE_SRCF=$(SRC_DIR)/qrpglesrc
CPYLE_SRCF=$(SRC_DIR)/qcpylesrc
SQL_SRCF=$(SRC_DIR)/qsqlsrc

#########################################################
# Import related makefiles
#########################################################

# Set environment setting
include $(MAKEFILE_DIR)/make_env.mk

# Override settings individually
-include $(MAKEFILE_DIR)/.makeprofile.mk

# Object list and their dependencies
include $(MAKEFILE_DIR)/make_object_list.mk

# Compile rules for each source type
include $(MAKEFILE_DIR)/make_compile_rules.mk


LIBLIST_UNIQUE=$(call uniq,$(LIBLIST))

COUNTER_CL=0
COUNTER_RPG=0
COUNTER_DSPF=0
COUNTER_DB=0

# Default rule (because it's the first one)
# Help output

.PHONY: help
help:
	echo "$(ALL_OBJS)"
	echo "$(ALL_SRCS)"
	echo "Build help."
	echo ""
	echo "\tgmake all                 - Build all objects into $(TGTLIB_PGM)"
	echo "\tgmake clean               - Clear $(TGTLIB_PGM) library and clean temp files"
	echo ""
	echo "\tgmake all TGTLIB_PGM=MYLIB    - Build IBMiUNIT into MYLIB library"
	echo "\tgmake all TARGET=V7R4M0   - Specifify target object version."
	echo ""


# When {init} and all objects are completed:
.PHONY: all
all: init $(OBJS)
	-cat $(LOG_DIR)/*.error.log 2> /dev/null
	$(info ===============================================================)
	$(info Build: RPG($(COUNTER_RPG)), CL($(COUNTER_CL)), DB($(COUNTER_DB)))
	$(info ===============================================================)
	echo "Compile complete"



.PHONY: init
init:
#	| true: returns always success of this command
	-mkdir -p $(LOG_DIR)
	-mkdir -p $(TGT_DIR)
	rm -f $(LOG_DIR)/*
	$(EXC) -i "CHGJOB CCSID(1141)"
	$(EXC) -i "CHGENVVAR ENVVAR(QIBM_PASE_CCSID) VALUE(1208) CCSID(1141)"
#	cl -i "ADDENVVAR ENVVAR(QIBM_CCSID) VALUE(1208) CCSID(1208)"

.PHONY: clean
clean:
	rm -f $(TGT_DIR)/*
	rm -f $(LOG_DIR)/*


.PHONY: cleanBuildFile
%.cleanBuildFile:
	rm $(TGT_DIR)/$* | true
	rm $(LOG_DIR)/$*.*.log | true