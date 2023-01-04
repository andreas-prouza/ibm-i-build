# No flags necessary
EXC=cl
CL_FLAG=-v # Print command


#########################################################
# Find the correct target lib for the source
#########################################################
# 1. specific lib
# 2. global target lib
NEW_LIB_TMP = $(if $(TGTLIB_$(TGTLIB_PGM)),$(TGTLIB_$(TGTLIB_PGM)),$(TGTLIB_PGM))
# 3. If *SOURCE is defined ==> source lib
NEW_LIB_TMP2 = $(if $(findstring *SOURCE,$(NEW_LIB_TMP)),$(TGTLIB_SRC),$(NEW_LIB_TMP))
# 4. source lib
NEW_LIB = $(if $(NEW_LIB_TMP2),$(NEW_LIB_TMP2),$(TGTLIB_PGM))


#########################################################
# Special characters in source name
#########################################################
#   * §-sign
#       This sign has differnt character-codes on different OS
#       Therefore it's necessary to rename the file in the IFS
#       And also to escape it in the name for compiling
#   * $-sign
#       This character marks a variable
#       So it has to be $$ for one single $
#   * #-sign
#       This character starts a comment in the command
#       So we need to escape it, otherwise all will be cut after the #
#########################################################
# IBM i creates it like: 
#       touch $'\247'test2.rpgle
# So we need to convert the unix variant to the IBM i variant:
#       mv $'\302\247'test.mbr $'\247'test.mbr

CHG_ATTR=cl "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1208)"
DOLLAR_SH_REPLACE = $(CHG_ATTR); $(if $(findstring §,$*),\
                         mv $(subst $$,'$$',$(subst #,\#,$?)) $$(echo $(subst $$,'$$',$(subst #,\#,$?)) | sed -e 's/'$$'\302''//g'),\
                     )

# Specified target library + character convertion
LIBOBJ_NEW= $(NEW_LIB)/$(notdir $(subst §,$$$$'\247',$(subst $$,'$$$$',$(subst #,\#,$*))))

# character convertion
PGM_NEW=$(notdir $(subst §,$$$$'\247',$(subst $,'$$$$',$(subst #,\#,$*))))

SOURCE_NAME_NEW=$$(notdir $$(subst §,$$$$'\247',$$(subst $$,'$$$$',$$(subst \#,\\\#,$$*))))

LOG_FILE_NAME=$@


#########################################################
# Pre & Post compiles
#########################################################

# if you need to convert the log-output to UTF-8 ... If you have special characters on output
CCSID_CONV= | iconv -f IBM-1252 -t utf-8 

CL_LOG_ERROR='$(LOG_DIR)/$(LOG_FILE_NAME).error.log'

# Redirect STDERR and STDOUT and generate Joblog
CL_LOG=  2>> $(CL_LOG_ERROR) $(CCSID_CONV) >> '$(LOG_DIR)/$(LOG_FILE_NAME).log'

# Create build file to remember last build timestamp
TOUCH=touch '$(TGT_DIR)/$(LOG_FILE_NAME)'

# Check if the STDERR (redirected file) is empty
# 	Empty: 		No error
# 	Not empty:	Error
CHECK_ERROR=(((! $$(stat -c %s $(CL_LOG_ERROR)) )) )

# Generate JOBLOG and save it into a file
PRINT_JOBLOG=$(EXC) $(CL_FLAG) "DSPJOBLOG" $(CCSID_CONV) >> '$(LOG_DIR)/$(LOG_FILE_NAME).joblog.log'

# Combine all to one
POST_COMPILE=$(CL_LOG); $(PRINT_JOBLOG); $(CHECK_ERROR)
POST_COMPILE_FINAL=$(CL_LOG); $(PRINT_JOBLOG); $(CHECK_ERROR) && $(TOUCH)

# Set Library List
# Make library needs to be unique in the list
TGTLIB_SRC = $(call upper_case,$(patsubst %/,%,$(dir $@)))

LIBLIST_UNIQUE=$(call uniq,$(LIBLIST))

SET_LIBL=$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST_UNIQUE))
PRE_COMPILE=$(SET_LIBL)


#########################################################
# Commands to create a service program
#########################################################

.SECONDEXPANSION:
CRTSRVPGM_CMD= CRTSRVPGM SRVPGM("$(LIBOBJ_NEW)") MODULE("$(LIBOBJ_NEW)") EXPORT(*ALL) ACTGRP($(ACTGRP)) \
			BNDDIR($(INCLUDE_BNDDIR)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL))
CRTSRVPGM=  $(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(CRTSRVPGM_CMD)"  $(POST_COMPILE)

.SECONDEXPANSION:
ADDBNDDIR_CMD=ADDBNDDIRE BNDDIR($(TGT_BNDDIR)) OBJ("$(LIBOBJ_NEW)")
ADDBNDDIR=	$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) -q "$(ADDBNDDIR_CMD)" $(POST_COMPILE_FINAL)

.SECONDEXPANSION:
RMVBNDDIR_CMD=RMVBNDDIRE BNDDIR($(TGT_BNDDIR)) OBJ("$(LIBOBJ_NEW)")
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



%.rpgle.cpy: %.rpgle
	echo "Not necessary"
	touch $(TGT_DIR)/$@



.SECONDEXPANSION:
%.sqlrpgle.srvpgm: $(SQLRPGLE_PREREQ).sqlrpgle

	$(DOLLAR_SH_REPLACE)

	$(info crtcmd|$@|New Lib: $(NEW_LIB))

	$(eval cmd :=CRTSQLRPGI OBJ("$(LIBOBJ_NEW)") SRCSTMF('$(SQLRPGLE_SRCF)/"$(SOURCE_NAME_NEW)".sqlrpgle') \
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
	$(eval BUILD_SRVPGM := $(BUILD_SRVPGM) $(subst #,\#,$@))



.SECONDEXPANSION:
%.rpgle.srvpgm: $(RPGLE_PREREQ).rpgle

	$(DOLLAR_SH_REPLACE)

	$(info crtcmd|$@|New Lib: $(NEW_LIB))

	$(eval cmd :=CRTRPGMOD MODULE("$(LIBOBJ_NEW)") SRCSTMF('$(RPGLE_SRCF)/"$(SOURCE_NAME_NEW)".rpgle') \
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
	$(eval BUILD_SRVPGM := $(BUILD_SRVPGM) $(subst #,\#,$@))



.SECONDEXPANSION:
%.clle.srvpgm: $(CLLE_PREREQ).clle

	$(DOLLAR_SH_REPLACE)

	$(eval cmd :=CRTCLMOD MODULE("$(LIBOBJ_NEW)") SRCSTMF('$(CLLE_SRCF)/"$(SOURCE_NAME_NEW)".clle') DBGVIEW($(DBGVIEW)))
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
	$(eval BUILD_SRVPGM := $(BUILD_SRVPGM) $(subst #,\#,$@))



.SECONDEXPANSION:
%.clle.pgm: $(CLLE_PREREQ).clle

	$(DOLLAR_SH_REPLACE)

# Create command string
	$(eval cmd :=CRTBNDCL PGM("$(LIBOBJ_NEW)")  SRCSTMF('$(CLLE_SRCF)/"$(SOURCE_NAME_NEW)".clle') \
							ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL)) DFTACTGRP(*NO))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_CL=$(shell echo $$(($(COUNTER_CL)+1))))
	$(eval BUILD_CL := $(BUILD_CL) $(subst #,\#,$@))



.SECONDEXPANSION:
%.rpgle.pgm:$(RPGLE_PREREQ).rpgle

	$(DOLLAR_SH_REPLACE)

	$(eval cmd :=CRTRPGMOD MODULE("$(LIBOBJ_NEW)") SRCSTMF('$(RPGLE_SRCF)/"$(SOURCE_NAME_NEW)".rpgle') \
							DBGVIEW($(DBGVIEW)) REPLACE(*YES) TGTCCSID($(TGTCCSID)) INCDIR('$(INC_DIR)'))

	$(info crtcmd|$@|$(cmd))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)

    # Create command string
	$(eval cmd := CRTPGM PGM("$(LIBOBJ_NEW)") ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) \
					STGMDL($(STGMDL)) DETAIL(*BASIC) BNDDIR($(INCLUDE_BNDDIR)))
	$(info crtcmd|$@|$(cmd))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)

	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))
	$(eval BUILD_RPG := $(subst #,\#,$(BUILD_RPG)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
%.sqlrpgle.pgm: $(SQLRPGLE_PREREQ).sqlrpgle

	$(DOLLAR_SH_REPLACE)

	$(info crtcmd|$@|New Lib: $(NEW_LIB))

	$(eval cmd :=CRTSQLRPGI OBJ("$(LIBOBJ_NEW)") SRCSTMF('$(SQLRPGLE_SRCF)/"$(SOURCE_NAME_NEW)".sqlrpgle') \
							OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS($(TGTRLS)) DBGVIEW($(DBGVIEW)) REPLACE(*YES) \
							COMPILEOPT('TGTCCSID($(TGTCCSID)) INCDIR(''$(INC_DIR)'')'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)

    # Create command string
	$(eval cmd := CRTPGM PGM("$(LIBOBJ_NEW)") ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL)) DETAIL(*BASIC) BNDDIR($(INCLUDE_BNDDIR)))
	$(info crtcmd|$@|$(cmd))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)

	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))
	$(eval BUILD_RPG := $(subst #,\#,$(BUILD_RPG)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
# Create and change physical file
%.pf.file: $(PF_PREREQ).pf

	$(DOLLAR_SH_REPLACE)

	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
		$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(PF_SRCF)/"$(SOURCE_NAME_NEW)".pf') TOMBR('/QSYS.lib/QTEMP.lib/QSRC.file/$*.mbr') MBROPT(*replace)";)
	$(info crtcmd|$@|$(cpystmf))

# Save file

# Create object
	$(eval cmd=$(EXC) $(CL_FLAG) -q "CRTPF FILE("$(LIBOBJ_NEW)") SRCFILE(QTEMP/QSRC) SRCMBR("$(SOURCE_NAME_NEW)")" $(CL_LOG); \
		$(EXC) $(CL_FLAG) > "CHGPF FILE("$(LIBOBJ_NEW)") SRCFILE(QTEMP/QSRC) SRCMBR("$(SOURCE_NAME_NEW)")")
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(cmd)  $(POST_COMPILE_FINAL)

	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
# Delete and create logical file
%.lf.file: $(LF_PREREQ).lf

	$(DOLLAR_SH_REPLACE)

	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
	$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(LF_SRCF)/"$(SOURCE_NAME_NEW)".lf') TOMBR('/QSYS.lib/QTEMP.lib/QSRC.file/$*.mbr') MBROPT(*replace)";)

# Create object
	$(eval cmd :=DLTF FILE("$(LIBOBJ_NEW)"))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	-$(EXC) $(CL_FLAG) -v "$(cmd)"

	$(eval cmd :=CRTLF FILE("$(LIBOBJ_NEW)",\#,$*)) SRCFILE(QTEMP/QSRC) SRCMBR($(subst #,\#,$*)))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))



# SQL Table
.SECONDEXPANSION:
%.sqltable.file: $(SQL_PREREQ).sqltable

	$(DOLLAR_SH_REPLACE)

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqltable') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL View
%.sqlview.file: $(SQL_PREREQ).sqlview

	$(DOLLAR_SH_REPLACE)

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqlview') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL Index
%.sqlindex.file: $(SQL_PREREQ).sqlindex

	$(DOLLAR_SH_REPLACE)

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqlindex') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL Function
%.sqlfunc.srvpgm: $(SQL_PREREQ).sqlfunc

	$(DOLLAR_SH_REPLACE)

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqlfunc') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL Procedure
%.sqlproc.pgm: $(SQL_PREREQ).sqlproc

	$(DOLLAR_SH_REPLACE)

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqlproc') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL Trigger
%.sqltrig.pgm: $(SQL_PREREQ).sqltrig

	$(DOLLAR_SH_REPLACE)

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqltrig') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))
