# No flags necessary
EXC=cl
#CL_FLAG=-v # Print command

# Only if you need to convert the output to UTF-8 ... problems with special characters on output
#CCSID_CONV= | iconv -f IBM-1252 -t utf-8 

CL_LOG_ERROR=$(LOG_DIR)/$@.error.log

# Redirect STDERR and STDOUT and generate Joblog
#CL_LOG= > $(LOG_DIR)/$@.log 2> $(CL_LOG_ERROR); $(PRINT_JOBLOG)
CL_LOG=  2>> $(CL_LOG_ERROR) $(CCSID_CONV) >> $(LOG_DIR)/$@.log

# Create build file to remember last build timestamp
TOUCH=touch $(TGT_DIR)/$@

# Check if the STDERR (redirected file) is empty
# 	Empty: 		No error
# 	Not empty:	Error
CHECK_ERROR=(((! $$(stat -c %s "$(CL_LOG_ERROR)") )) )

# Generate JOBLOG and save it into a file
PRINT_JOBLOG=$(EXC) $(CL_FLAG) "DSPJOBLOG" $(CCSID_CONV) > $(LOG_DIR)/$@.joblog.log

# Combine all to one
POST_COMPILE=$(CL_LOG); $(PRINT_JOBLOG); $(CHECK_ERROR)
POST_COMPILE_FINAL=$(CL_LOG); $(PRINT_JOBLOG); $(CHECK_ERROR) && $(TOUCH)

# Set Library List
# Make library needs to be unique in the list
TGTLIB_SRC = $(call upper_case,$(patsubst %/,%,$(dir $@)))

LIBLIST_UNIQUE=$(call uniq,$(LIBLIST))

SET_LIBL=$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST_UNIQUE))
PRE_COMPILE=$(SET_LIBL)

# To escape HASH values in source names
HASH_VALUE=$(shell echo "\#")


#########################################################
# Find the correct target lib for the source
#########################################################
# 1. specific lib
# 2. global target lib
NEW_LIB_TMP = $(if $(TGTLIB_$(TGTLIB_SRC)),$(TGTLIB_$(TGTLIB_SRC)),$(TGTLIB_PGM))
# 3. If *SOURCE is defined ==> source lib
NEW_LIB_TMP2 = $(if $(findstring *SOURCE,$(NEW_LIB_TMP)),$(TGTLIB_SRC),$(NEW_LIB_TMP))
# 4. source lib
NEW_LIB = $(if $(NEW_LIB_TMP2),$(NEW_LIB_TMP2),$(TGTLIB_SRC))

#########################################################
# Commands to create a service program
#########################################################

.SECONDEXPANSION:
CRTSRVPGM_CMD= CRTSRVPGM SRVPGM($(subst $(HASH_VALUE),\#,$*)) MODULE($(subst $(HASH_VALUE),\#,$*)) EXPORT(*ALL) ACTGRP($(ACTGRP)) BNDDIR($(INCLUDE_BNDDIR)) \
			REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL))
CRTSRVPGM=  $(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(CRTSRVPGM_CMD)"  $(POST_COMPILE)

.SECONDEXPANSION:
ADDBNDDIR_CMD=ADDBNDDIRE BNDDIR($(TGT_BNDDIR)) OBJ($(subst $(HASH_VALUE),\#,$*))
ADDBNDDIR=	$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) -q "$(ADDBNDDIR_CMD)" $(POST_COMPILE_FINAL)

.SECONDEXPANSION:
RMVBNDDIR_CMD=RMVBNDDIRE BNDDIR($(TGT_BNDDIR)) OBJ($(subst $(HASH_VALUE),\#,$*))
RMVBNDDIR=	$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) -q "$(RMVBNDDIR_CMD)" $(POST_COMPILE)




#########################################################
# Rules for all objects and their dependencies
#########################################################
# All objects will be checked if their source had been changed.
# Therefore it is necessary to have different naming conventions.
# See object_list.mk for details!
#
# touch ... will create a dummy file for each object (bnddir, module, program, ...)
#   GNU make uses these dummy files to compare the timestamp to the related sources
########################################################
# Here is an info which of the content of each automatic variables.
# They will be used to retrieve the parameters (dependencies).
#
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables
#	$(info ^ $^) --> /home/prouza/myproject/prouzalib//qrpglesrc/cpysrc.sqlrpgle
#	$(info * $*) --> prouzalib/cpysrc
#	$(info % $%)
#	$(info ? $?) --> /home/prouza/myproject/prouzalib//qrpglesrc/cpysrc.sqlrpgle
#	$(info @ $@) --> prouzalib/cpysrc.sqlrpglepgm
#########################################################

%.bnddir:
	$(info crtcmd|$@|Bnddir init)
	touch $(TGT_DIR)/$@


%.rpglecpy: %.rpgle
	echo "Not necessary"
	touch $(TGT_DIR)/$@


.SECONDEXPANSION:
%.sqlrpglemod: $(SQLRPGLE_SRCF)/$$(basename $$(notdir $$@)).sqlrpgle

	$(info crtcmd|$@|New Lib: $(NEW_LIB))

	$(eval cmd :=CRTSQLRPGI OBJ($(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(SQLRPGLE_SRCF)/$(notdir $(subst $(HASH_VALUE),\#,$*)).sqlrpgle') \
							OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS($(TGTRLS)) DBGVIEW($(DBGVIEW)) REPLACE(*YES) \
							COMPILEOPT('TGTCCSID($(TGTCCSID)) INCDIR(''$(INC_DIR)'')'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)



	$(info crtcmd|$@|$(RMVBNDDIR_CMD))
	$(RMVBNDDIR)
	$(info crtcmd|$@|$(CRTSRVPGM_CMD))
	$(CRTSRVPGM)
	$(info crtcmd|$@|$(ADDBNDDIR_CMD))
	$(ADDBNDDIR)
	
	$(eval COUNTER_SRVPGM=$(shell echo $$(($(COUNTER_SRVPGM)+1))))
	$(eval BUILD_SRVPGM := $(BUILD_SRVPGM) $(subst $(HASH_VALUE),\#,$@))


.SECONDEXPANSION:
%.rpglemod: $(RPGLE_SRCF)/$$(basename $$(notdir $$@)).rpgle

	$(info crtcmd|$@|New Lib: $(NEW_LIB))

	$(eval cmd :=CRTRPGMOD MODULE($(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(RPGLE_SRCF)/$(notdir $(subst $(HASH_VALUE),\#,$*)).rpgle') \
							DBGVIEW($(DBGVIEW)) REPLACE(*YES) TGTCCSID($(TGTCCSID)) INCDIR('$(INC_DIR)'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)


	$(info crtcmd|$@|$(RMVBNDDIR_CMD))
	$(RMVBNDDIR)
	$(info crtcmd|$@|$(CRTSRVPGM_CMD))
	$(CRTSRVPGM)
	$(info crtcmd|$@|$(ADDBNDDIR_CMD))
	$(ADDBNDDIR)
	
	$(eval COUNTER_SRVPGM=$(shell echo $$(($(COUNTER_SRVPGM)+1))))
	$(eval BUILD_SRVPGM := $(BUILD_SRVPGM) $(subst $(HASH_VALUE),\#,$@))



.SECONDEXPANSION:
%.cllemod: $(CLLE_SRCF)/$$(basename $$(notdir $$@)).clle

	$(eval cmd :=CRTCLMOD MODULE($(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(CLLE_SRCF)/$(notdir $(subst $(HASH_VALUE),\#,$*)).clle') DBGVIEW($(DBGVIEW)))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)


	$(info crtcmd|$@|$(RMVBNDDIR_CMD))
	$(RMVBNDDIR)
	$(info crtcmd|$@|$(CRTSRVPGM_CMD))
	$(CRTSRVPGM)
	$(info crtcmd|$@|$(ADDBNDDIR_CMD))
	$(ADDBNDDIR)
	
	$(eval COUNTER_SRVPGM=$(shell echo $$(($(COUNTER_SRVPGM)+1))))
	$(eval BUILD_SRVPGM := $(BUILD_SRVPGM) $(subst $(HASH_VALUE),\#,$@))


.SECONDEXPANSION:
%.cllepgm: $(CLLE_SRCF)/$$(basename $$(notdir $$@)).clle

# Create command string
	$(eval cmd :=CRTBNDCL PGM($(subst $(HASH_VALUE),\#,$*))  SRCSTMF('$(CLLE_SRCF)/$(notdir $(subst $(HASH_VALUE),\#,$*)).clle') \
							ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL)) DFTACTGRP(*NO))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_CL=$(shell echo $$(($(COUNTER_CL)+1))))
	$(eval BUILD_CL := $(BUILD_CL) $(subst $(HASH_VALUE),\#,$@))


.SECONDEXPANSION:
%.rpglepgm: $(RPGLE_SRCF)/$$(basename $$(notdir $$@)).rpgle

	$(info crtcmd|$@|New Lib: $(NEW_LIB))

	$(eval cmd :=CRTRPGMOD MODULE($(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(RPGLE_SRCF)/$(notdir $(subst $(HASH_VALUE),\#,$*)).rpgle') \
							DBGVIEW($(DBGVIEW)) REPLACE(*YES) TGTCCSID($(TGTCCSID)) INCDIR('$(INC_DIR)'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)

    # Create command string
	$(eval cmd := CRTPGM PGM($(subst $(HASH_VALUE),\#,$*)) ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) \
					STGMDL($(STGMDL)) DETAIL(*BASIC) BNDDIR($(INCLUDE_BNDDIR)))
	$(info crtcmd|$@|$(cmd))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)

	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))
	$(eval BUILD_RPG := $(BUILD_RPG) $(subst $(HASH_VALUE),\#,$@))



.SECONDEXPANSION:
%.sqlrpglepgm: $(SQLRPGLE_SRCF)/$$(basename $$(notdir $$@)).sqlrpgle

	$(info crtcmd|$@|New Lib: $(NEW_LIB))

	$(eval cmd :=CRTSQLRPGI OBJ($(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(SQLRPGLE_SRCF)/$(notdir $(subst $(HASH_VALUE),\#,$*)).sqlrpgle') \
							OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS($(TGTRLS)) DBGVIEW($(DBGVIEW)) REPLACE(*YES) \
							COMPILEOPT('TGTCCSID($(TGTCCSID)) INCDIR(''$(INC_DIR)'')'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)

    # Create command string
	$(eval cmd := CRTPGM PGM($(subst $(HASH_VALUE),\#,$*)) ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL)) DETAIL(*BASIC) BNDDIR($(INCLUDE_BNDDIR)))
	$(info crtcmd|$@|$(cmd))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)

	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))
	$(eval BUILD_RPG := $(BUILD_RPG) $(subst $(HASH_VALUE),\#,$@))



.SECONDEXPANSION:
# Create and change physical file
%.pfobj: $(PF_SRCF)/$$(basename $$(notdir $$@)).pf
	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
		$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(PF_SRCF)/$*.pf') TOMBR('/QSYS.lib/QTEMP.lib/QSRC.file/$*.mbr') MBROPT(*replace)";)
	$(info crtcmd|$@|$(cpystmf))

# Save file

# Create object
	$(eval cmd=$(EXC) $(CL_FLAG) -q "CRTPF FILE($(TGTLIB_DBF)/$(subst $(HASH_VALUE),\#,$*)) SRCFILE(QTEMP/QSRC) SRCMBR($(subst $(HASH_VALUE),\#,$*))" $(CL_LOG); \
		$(EXC) $(CL_FLAG) -v "CHGPF FILE($(TGTLIB_DBF)/$(subst $(HASH_VALUE),\#,$*)) SRCFILE(QTEMP/QSRC) SRCMBR($(subst $(HASH_VALUE),\#,$*))")
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(cmd)  $(POST_COMPILE_FINAL)

	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))



.SECONDEXPANSION:
# Delete and create logical file
%.lfobj: $(LF_SRCF)/$$(basename $$(notdir $$@)).lf
	$(eval cpystmf = cl "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
	cl "CPYFRMSTMF FROMSTMF('$(LF_SRCF)/$*.lf') TOMBR('/QSYS.lib/QTEMP.lib/QSRC.file/$*.mbr') MBROPT(*replace)";)

# Create object
	$(eval cmd :=DLTF FILE($(TGTLIB_DBF)/$(subst $(HASH_VALUE),\#,$*)))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	-$(EXC) $(CL_FLAG) -v "$(cmd)"

	$(eval cmd :=CRTLF FILE($(TGTLIB_DBF)/$(subst $(HASH_VALUE),\#,$*)) SRCFILE(QTEMP/QSRC) SRCMBR($(subst $(HASH_VALUE),\#,$*)))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))



# SQL Table
.SECONDEXPANSION:
%.sqltableobj: $(SQL_SRCF)/$$(basename $$(notdir $$@)).sqltable
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(notdir $(subst $(HASH_VALUE),\#,$*)).sqltable') DFTRDBCOL($(subst /,,$(dir $@))) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL View
%.sqlviewobj: $(SQL_SRCF)/$$(basename $$(notdir $$@)).sqlview
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(notdir $(subst $(HASH_VALUE),\#,$*)).sqlview') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL Index
%.sqlindexobj: $(SQL_SRCF)/$$(basename $$(notdir $$@)).sqlindex
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlindex') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL Function
%.sqlfuncobj: $(SQL_SRCF)/$$(basename $$(notdir $$@)).sqlfunc
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlfunc') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL Procedure
%.sqlprocobj: $(SQL_SRCF)/$$(basename $$(notdir $$@)).sqlproc
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlproc') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL Trigger
%.sqltrigobj: $(SQL_SRCF)/$$(basename $$(notdir $$@)).sqltrig
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqltrig') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))
