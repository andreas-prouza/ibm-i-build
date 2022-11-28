# General infos
#	- Using TABs instead of Blanks is necessary!
# Tabs: for processing of all targets
# Blanks executing at very first (preprocessing)
SHELL=/QOpenSys/pkgs/bin/bash
#SHELL=/QOpenSys/usr/bin/qsh

#########################################################
# our configuration
#########################################################

# Source directory (!full path!)
SRC_DIR=/home/prouza/myproject4

# Include DIR (e.g. to search for /copy members in RPG sources) (!full path!)
INC_DIR=$(SRC_DIR)/prouzalib


# Target libraries
# Will be taken from qualified source name (can be overwritten in .makeprofile.mk)
#TGTLIB_PGM=PROUZALIB
TGTLIB_PGM=$(dir $@)
TGTLIB_DBF=$(dir $@)

TGT_BNDDIR=*LIBL/PROUZADIR
INCLUDE_BNDDIR=*LIBL/PROUZADIR

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
PF_SRCF=$(SRC_DIR)/$$(dir $$@)/qddssrc
LF_SRCF=$(SRC_DIR)/$$(dir $$@)/qddssrc
CLLE_SRCF=$(SRC_DIR)/$$(dir $$@)/qcllesrc
RPGLE_SRCF=$(SRC_DIR)/$$(dir $$@)/qrpglesrc
SQLRPGLE_SRCF=$(SRC_DIR)/$$(dir $$@)/qrpglesrc
CPYLE_SRCF=$(SRC_DIR)/$$(dir $$@)/qcpylesrc
SQL_SRCF=$(SRC_DIR)/$$(dir $$@)/qsqlsrc

#########################################################
# Import related makefiles
#########################################################

MAKEFILE_DIR=$(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))
MAKEFILE_DIR:=$(MAKEFILE_DIR)/make


# Set environment setting

include $(MAKEFILE_DIR)/env.mk

# Override settings individually
-include $(MAKEFILE_DIR)/.makeprofile.mk

# Object list and their dependencies
include $(MAKEFILE_DIR)/object_list.mk

# Compile rules for each source type
include $(MAKEFILE_DIR)/compile_rules.mk

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
	echo "MAKEFILE_LIST: $(MAKEFILE_LIST)"
	echo "MAKEFILE_DIR: $(MAKEFILE_DIR)"
	echo "RPGLE_SRCF: $(RPGLE_SRCF)"

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
#	>| true: returns always success of this command
	-rm -rf $(LOG_DIR)/*

# Create subdirectory for each library we use for logs
	-mkdir -p $(LOG_DIR)/prouzalib
	-mkdir -p $(LOG_DIR)/prouzalib2

# Create subdirectory for each library we use for builds
	-mkdir -p $(TGT_DIR)/prouzalib
	-mkdir -p $(TGT_DIR)/prouzalib2
	
	cl -i "CHGJOB CCSID(1141)"
	cl -i "CHGENVVAR ENVVAR(QIBM_PASE_CCSID) VALUE(1208) CCSID(1141)"
#	cl -i "ADDENVVAR ENVVAR(QIBM_CCSID) VALUE(1208) CCSID(1208)"

.PHONY: clean
clean:
	rm -rf $(TGT_DIR)/*
	rm -rf $(LOG_DIR)/*


.PHONY: cleanBuildFile
%.cleanBuildFile:
	rm $(TGT_DIR)/$* | true
	rm $(LOG_DIR)/$*.*.log | true

