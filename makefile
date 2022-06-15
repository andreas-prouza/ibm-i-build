# General infos
#	- Using TABs instead of Blanks is necessary!
# Tabs: for processing of all targets
# Blanks executing at very first (preprocessing)

#########################################################
# our configuration
#########################################################

# Source directory (!full path!)
SRC_DIR=/home/prouza/myproject

# Include DIR (e.g. to search for /copy members in RPG sources) (!full path!)
INC_DIR=/home/prouza/myproject


# Target libraries
TGTLIB_PGM=PROUZALIB
TGTLIB_DBF=PROUZALIB

ACTGRP=PROUZAGRP
STGMDL=*SNGLVL

# You can also add other libs if necessary (separated by blanks)
LIBLIST=$(TGTLIB_PGM) $(TGTLIB_DBF)

DBGVIEW=*SOURCE
TGTRLS=*CURRENT
TGTCCSID=*JOB

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

MAKEFILE_DIR=$(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
SHELL=/QOpenSys/pkgs/bin/bash
#SHELL=/QOpenSys/usr/bin/qsh


# Set environment setting
include $(MAKEFILE_DIR)/env.mk

# Override settings individually
-include $(MAKEFILE_DIR)/.makeprofile.mk

# Object list and their dependencies
include $(MAKEFILE_DIR)/object_list.mk

# Compile rules for each source type
include $(MAKEFILE_DIR)/compile_rules.mk


LIBLIST_UNIQUE=$(call uniq,$(LIBLIST))

COUNTER_CL=0
COUNTER_RPG=0
COUNTER_DSPF=0
COUNTER_SRVPGM=0
COUNTER_DB=0

BUILD_RPG=
BUILD_CL=
BUILD_DSPF=
BUILD_SRVPGM=
BUILD_DB=

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
	-cat $(LOG_DIR)/*.error.log 2> /dev/null | true
	$(info crtcmd|summary ===============================================================)
	$(info crtcmd|summary Build RPG: $(COUNTER_RPG) $(BUILD_RPG))
	$(info crtcmd|summary Build CL: $(COUNTER_CL) $(BUILD_CL))
	$(info crtcmd|summary Build DSPF: $(COUNTER_DSPF) $(BUILD_DSPF))
	$(info crtcmd|summary Build SRVPGM: $(COUNTER_SRVPGM) $(BUILD_SRVPGM))
	$(info crtcmd|summary Build DB: $(COUNTER_DB) $(BUILD_DB))
	$(info crtcmd|summary ===============================================================)
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