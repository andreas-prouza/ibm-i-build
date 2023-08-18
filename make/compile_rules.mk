# No flags necessary
EXC=cl
CL_FLAG=-v # Print command


#########################################################
# Find the correct target lib for the source
#########################################################
TGTLIB_SRC = $(call upper_case,$(patsubst %/,%,$(dir $@)))

OBJLIB_UPPER=$(call upper_case,$(OBJLIB))

# 1. specific lib:			OBJLIB
NEW_LIB_TMP1 = $(if $(OBJLIB_UPPER),$(OBJLIB_UPPER),$(TGTLIB_SRC))
NEW_LIB_PROD = $(if $(findstring *SOURCE,$(NEW_LIB_TMP1)),$(TGTLIB_SRC),$(NEW_LIB_TMP1))
PROD_LIBOBJ = $(NEW_LIB_PROD)/$(notdir $(subst §,$$$$'\247',$(subst $$,'$$$$',$(subst #,\#,$*))))

# 2. Lib-Mapping:				TGTLIB_{source-lib} exist ==> take it
NEW_LIB_TMP2 = $(call upper_case,$(if $(TGTLIB_$(NEW_LIB_PROD)),$(TGTLIB_$(NEW_LIB_PROD)),$(NEW_LIB_PROD)))

# 3. global target lib:	TGTLIB_OBJ_GLOBAL
NEW_LIB_TMP3 = $(call upper_case,$(if $(TGTLIB_OBJ_GLOBAL),$(TGTLIB_OBJ_GLOBAL),$(NEW_LIB_TMP2)))

# 4. If *SOURCE is defined ==> source lib
NEW_LIB_TMP4 = $(if $(findstring *SOURCE,$(NEW_LIB_TMP3)),$(TGTLIB_SRC),$(NEW_LIB_TMP3))

# Final Lib for this object
NEW_LIB = $(NEW_LIB_TMP4)


# character convertion
#PGM_NEW=$(notdir $(subst §,$$$$'\247',$(subst $$,'$$$$',$(subst #,\#,$*))))
PGM_NEW=$(notdir $(subst $$,'$$$$',$(subst #,\#,$*)))

# Specified target library + character convertion
LIBOBJ_NEW= $(NEW_LIB)/$(PGM_NEW)


#SOURCE_NAME_NEW=$$(notdir $$(subst §,$$$$'\247',$$(subst $$,'$$$$',$$(subst \#,\\\#,$$*))))
SOURCE_NAME_NEW=$$(notdir $$(subst $$,'$$$$',$$(subst \#,\\\#,$$*)))

LOG_FILE_NAME=$@

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

CHG_ATTR=$(EXC) "CHGATR OBJ('"'$<'"') ATR(*CCSID) VALUE(1208)"
define DOLLAR_SH_REPLACE
  $(CHG_ATTR) $(CCSID_CONV)
# $(if $(findstring §,$*),\
			mv $(subst $$,'$$',$(subst #,\#,$?)) $$(echo $(subst $$,'$$',$(subst #,\#,$?)) | sed -e 's/'$$'\302''//g'),\
	)

endef



#########################################################
# Pre & Post compiles
#########################################################

# if you need to convert the log-output to UTF-8 ... If you have special characters on output ... but also makes problems sometimes
CCSID_CONV= | iconv -f IBM-1252 -t utf-8 
# old CCSID_CONV= | sed -e 's/'$$'\344''/ä/g'
#CONVERT_STDERR_LOG= iconv -f IBM-1252 -t utf-8 $(CL_LOG_ERROR) > $(CL_LOG_ERROR)_tmp && mv $(CL_LOG_ERROR)_tmp $(CL_LOG_ERROR) ;
#CONVERT_STDOUT_LOG= iconv -f IBM-1252 -t utf-8 $(CL_LOG_STDOUT) > $(CL_LOG_STDOUT)_tmp && mv $(CL_LOG_STDOUT)_tmp $(CL_LOG_STDOUT) ;
#CONVERT_JOBLOG_LOG= iconv -f IBM-1252 -t utf-8 $(CL_LOG_JOBLOG) > $(CL_LOG_JOBLOG)_tmp && mv $(CL_LOG_JOBLOG)_tmp $(CL_LOG_JOBLOG) ;

CL_LOG_ERROR='$(LOG_DIR)/$(LOG_FILE_NAME).error.log'
CL_LOG_STDOUT='$(LOG_DIR)/$(LOG_FILE_NAME).splf.log'
CL_LOG_JOBLOG='$(LOG_DIR)/$(LOG_FILE_NAME).joblog.log'

# Redirect STDERR and STDOUT and generate Joblog
CL_LOG= 2>> $(CL_LOG_ERROR)  >> $(CL_LOG_STDOUT)


# Create build file to remember last build timestamp
TOUCH=touch '$(TGT_DIR)/$(LOG_FILE_NAME)'; date > $(TGT_DIR)/$(LOG_FILE_NAME)


# Check if the STDERR (redirected file) is empty
# 	Empty: 		No error
# 	Not empty:	Error
define CHECK_ERROR
if [ -s $(CL_LOG_ERROR) ]; then
 echo -e '$(COLOR_RED)failed: $<$(COLOR_END)' 1>&2
 exit 1
fi
endef

# Generate JOBLOG and save it into a file
PRINT_JOBLOG=$(EXC) $(CL_FLAG) "DSPJOBLOG" >> $(CL_LOG_JOBLOG)

# Combine all to one
define POST_COMPILE
  $(CL_LOG) ; $(PRINT_JOBLOG)
endef
define POST_COMPILE_FINAL
  $(CL_LOG) ; $(PRINT_JOBLOG)
endef
define FINALY
  $(CONVERT_STDERR_LOG)  $(CONVERT_STDOUT_LOG)  $(CONVERT_JOBLOG_LOG)  $(CHECK_ERROR) && $(TOUCH)
	$(info crtcmd|prod_obj|$@|$(LIBOBJ_NEW)|$(PROD_LIBOBJ))
endef

# Set Library List
# Make library needs to be unique in the list
LIBLIST_UNIQUE=$(call uniq,$(LIBLIST))

SET_LIBL=$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST_UNIQUE))
PRE_COMPILE=$(SET_LIBL)


#########################################################
# Commands to create a service program
#########################################################

.SECONDEXPANSION:
RMVBNDDIR_CMD=RMVBNDDIRE BNDDIR($(TGT_BNDDIR)) OBJ("*LIBL/$(PGM_NEW)")
RMVBNDDIR=	$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) -q "$(RMVBNDDIR_CMD)" $(POST_COMPILE)

.SECONDEXPANSION:
CRTSRVPGM_CMD= CRTSRVPGM SRVPGM("$(LIBOBJ_NEW)") MODULE("$(LIBOBJ_NEW)") EXPORT(*ALL) ACTGRP($(ACTGRP)) \
			BNDDIR($(INCLUDE_BNDDIR)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL))
CRTSRVPGM=  $(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(CRTSRVPGM_CMD)"  $(POST_COMPILE)

.SECONDEXPANSION:
ADDBNDDIR_CMD=ADDBNDDIRE BNDDIR($(TGT_BNDDIR)) OBJ("*LIBL/$(PGM_NEW)")
ADDBNDDIR=	$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(ADDBNDDIR_CMD)" $(POST_COMPILE_FINAL)




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



%.rpgle.cpy: $(CPYLE_PREREQ).rpgle
	$(info crtcmd|$@|Not necessary)
	touch $(TGT_DIR)/$@


%.rpg.cpy: $(CPY_PREREQ).rpg
	$(info crtcmd|$@|Not necessary)
	touch $(TGT_DIR)/$@



.SECONDEXPANSION:
%.sqlrpgle.srvpgm: $(SQLRPGLE_PREREQ).sqlrpgle

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd :=CRTSQLRPGI OBJ("$(LIBOBJ_NEW)") SRCSTMF('$(SQLRPGLE_SRCF)/"$(SOURCE_NAME_NEW)".sqlrpgle') \
							OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS($(TGTRLS)) DBGVIEW($(DBGVIEW)) REPLACE(*YES) \
							COMPILEOPT('TGTCCSID($(TGTCCSID)) INCDIR(''$(INC_DIR)'')'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE))

	$(info crtcmd|$@|$(RMVBNDDIR_CMD))
	$(call bash_call,$(RMVBNDDIR))
	$(info crtcmd|$@|$(CRTSRVPGM_CMD))
	$(call bash_call,$(CRTSRVPGM))
	$(info crtcmd|$@|$(ADDBNDDIR_CMD))
	$(call bash_call,$(ADDBNDDIR))

	$(FINALY)
	
	$(eval COUNTER_SRVPGM=$(shell echo $$(($(COUNTER_SRVPGM)+1))))
	$(eval BUILD_SRVPGM := $(subst #,\#,$(BUILD_SRVPGM)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
%.rpgle.srvpgm: $(RPGLE_PREREQ).rpgle

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd :=CRTRPGMOD MODULE("$(LIBOBJ_NEW)") SRCSTMF('$(RPGLE_SRCF)/"$(SOURCE_NAME_NEW)".rpgle') \
							DBGVIEW($(DBGVIEW)) REPLACE(*YES) TGTCCSID($(TGTCCSID)) INCDIR('$(INC_DIR)'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE))

	$(info crtcmd|$@|$(RMVBNDDIR_CMD))
	$(call bash_call,$(RMVBNDDIR))
	$(info crtcmd|$@|$(CRTSRVPGM_CMD))
	$(call bash_call,$(CRTSRVPGM))
	$(info crtcmd|$@|$(ADDBNDDIR_CMD))
	$(call bash_call,$(ADDBNDDIR))
	
	$(FINALY)
	
	$(eval COUNTER_SRVPGM=$(shell echo $$(($(COUNTER_SRVPGM)+1))))
	$(eval BUILD_SRVPGM := $(subst #,\#,$(BUILD_SRVPGM)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
%.clle.srvpgm: $(CLLE_PREREQ).clle

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd :=CRTCLMOD MODULE("$(LIBOBJ_NEW)") SRCSTMF('$(CLLE_SRCF)/"$(SOURCE_NAME_NEW)".clle') DBGVIEW($(DBGVIEW)))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE))

	$(info crtcmd|$@|$(RMVBNDDIR_CMD))
	$(call bash_call,$(RMVBNDDIR))
	$(info crtcmd|$@|$(CRTSRVPGM_CMD))
	$(call bash_call,$(CRTSRVPGM))
	$(info crtcmd|$@|$(ADDBNDDIR_CMD))
	$(call bash_call,$(ADDBNDDIR))
	
	$(FINALY)
	
	$(eval COUNTER_SRVPGM=$(shell echo $$(($(COUNTER_SRVPGM)+1))))
	$(eval BUILD_SRVPGM := $(subst #,\#,$(BUILD_SRVPGM)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
%.clle.pgm: $(CLLE_PREREQ).clle

	$(call bash_call,$(DOLLAR_SH_REPLACE))

# Create command string
	$(eval cmd :=CRTBNDCL PGM("$(LIBOBJ_NEW)")  SRCSTMF('$(CLLE_SRCF)/"$(SOURCE_NAME_NEW)".clle') \
							ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL)) DFTACTGRP(*NO))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL))

	$(FINALY)
	
	$(eval COUNTER_CL=$(shell echo $$(($(COUNTER_CL)+1))))
	$(eval BUILD_CL := $(subst #,\#,$(BUILD_CL)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
%.rpg.pgm: $(RPG_PREREQ).rpg
	$(warning crtcmd|$@|Not yes implemented)

	$(FINALY)
	
	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))
	$(eval BUILD_RPG := $(subst #,\#,$(BUILD_RPG)) $(LIBOBJ_NEW))




.SECONDEXPANSION:
%.clp.pgm: $(CLP_PREREQ).clp

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
		$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(CLLE_SRCF)/"$(SOURCE_NAME_NEW)".clp') TOMBR('/QSYS.LIB/QTEMP.LIB/QSRC.FILE/"$(SOURCE_NAME_NEW)".MBR') MBROPT(*replace)";)
	$(info crtcmd|$@|$(cpystmf))

  # Create object
	$(eval cmd=$(EXC) $(CL_FLAG) "CRTCLPGM PGM("$(LIBOBJ_NEW)") SRCFILE(QTEMP/QSRC) SRCMBR("$(SOURCE_NAME_NEW)") REPLACE(*YES) TGTRLS($(TGTRLS)) " $(CL_LOG))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(cmd)  $(POST_COMPILE_FINAL)

	$(FINALY)
	
	$(eval COUNTER_CL=$(shell echo $$(($(COUNTER_CL)+1))))
	$(eval BUILD_CL := $(subst #,\#,$(BUILD_CL)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
%.rpgle.pgm:$(RPGLE_PREREQ).rpgle

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd :=CRTRPGMOD MODULE("$(LIBOBJ_NEW)") SRCSTMF('$(RPGLE_SRCF)/"$(SOURCE_NAME_NEW)".rpgle') \
							DBGVIEW($(DBGVIEW)) REPLACE(*YES) TGTCCSID($(TGTCCSID)) INCDIR('$(INC_DIR)'))

	$(info crtcmd|$@|$(cmd))

	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE))

    # Create command string
	$(eval cmd := CRTPGM PGM("$(LIBOBJ_NEW)") ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) \
					STGMDL($(STGMDL)) DETAIL(*BASIC) BNDDIR($(INCLUDE_BNDDIR)))
	$(info crtcmd|$@|$(cmd))
	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL))

	$(FINALY)
	
	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))
	$(eval BUILD_RPG := $(subst #,\#,$(BUILD_RPG)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
%.sqlrpgle.pgm: $(SQLRPGLE_PREREQ).sqlrpgle

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd :=CRTSQLRPGI OBJ("$(LIBOBJ_NEW)") SRCSTMF('$(SQLRPGLE_SRCF)/"$(SOURCE_NAME_NEW)".sqlrpgle') \
							OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS($(TGTRLS)) DBGVIEW($(DBGVIEW)) REPLACE(*YES) \
							COMPILEOPT('TGTCCSID($(TGTCCSID)) INCDIR(''$(INC_DIR)'')'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE))

    # Create command string
	$(eval cmd := CRTPGM PGM("$(LIBOBJ_NEW)") ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL)) DETAIL(*BASIC) BNDDIR($(INCLUDE_BNDDIR)))
	$(info crtcmd|$@|$(cmd))
	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL))

	$(FINALY)
	
	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))
	$(eval BUILD_RPG := $(subst #,\#,$(BUILD_RPG)) $(LIBOBJ_NEW))



# Create and change physical file
.SECONDEXPANSION:
%.dspf.file: $(DSPF_PREREQ).dspf

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
		$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(PF_SRCF)/"$(SOURCE_NAME_NEW)".dspf') TOMBR('/QSYS.LIB/QTEMP.LIB/QSRC.FILE/"$(SOURCE_NAME_NEW)".MBR') MBROPT(*replace)";)
	$(info crtcmd|$@|$(cpystmf))

# Save file

# Create object
	$(eval cmd=$(EXC) $(CL_FLAG) "CRTDSPF FILE("$(LIBOBJ_NEW)") SRCFILE(QTEMP/QSRC) SRCMBR("$(SOURCE_NAME_NEW)") REPLACE(*YES)" $(CL_LOG))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(cmd)  $(POST_COMPILE_FINAL)

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))



# Create and change physical file
.SECONDEXPANSION:
%.prtf.file: $(PRTF_PREREQ).prtf

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
		$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(PF_SRCF)/"$(SOURCE_NAME_NEW)".prtf') TOMBR('/QSYS.LIB/QTEMP.LIB/QSRC.FILE/"$(SOURCE_NAME_NEW)".MBR') MBROPT(*replace)";)
	$(info crtcmd|$@|$(cpystmf))

  # Save file

  # Create object
	$(eval cmd=$(EXC) $(CL_FLAG) "CRTPRTF FILE("$(LIBOBJ_NEW)") SRCFILE(QTEMP/QSRC) SRCMBR("$(SOURCE_NAME_NEW)") REPLACE(*YES)" $(CL_LOG))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(cmd)  $(POST_COMPILE_FINAL)

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))



# Create and change physical file
.SECONDEXPANSION:
%.pf.file: $(PF_PREREQ).pf

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
		$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(PF_SRCF)/"$(SOURCE_NAME_NEW)".pf') TOMBR('/QSYS.LIB/QTEMP.LIB/QSRC.FILE/"$(SOURCE_NAME_NEW)".MBR') MBROPT(*replace)";)
	$(info crtcmd|$@|$(cpystmf))

# Save file

# Create object
	$(eval cmd=$(EXC) $(CL_FLAG) -q "CRTPF FILE("$(LIBOBJ_NEW)") SRCFILE(QTEMP/QSRC) SRCMBR("$(SOURCE_NAME_NEW)")" $(CL_LOG); \
		$(EXC) $(CL_FLAG) "CHGPF FILE("$(LIBOBJ_NEW)") SRCFILE(QTEMP/QSRC) SRCMBR("$(SOURCE_NAME_NEW)")")
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(cmd)  $(POST_COMPILE_FINAL)

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))



.SECONDEXPANSION:
# Delete and create logical file
%.lf.file: $(LF_PREREQ).lf

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
	$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(LF_SRCF)/"$(SOURCE_NAME_NEW)".lf') TOMBR('/QSYS.LIB/QTEMP.LIB/QSRC.FILE/"$(SOURCE_NAME_NEW)".MBR') MBROPT(*replace)";)

# Create object
	$(eval cmd :=DLTF FILE("$(LIBOBJ_NEW)"))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	-$(EXC) $(CL_FLAG) -v "$(cmd)"

	$(eval cmd :=CRTLF FILE("$(LIBOBJ_NEW)") SRCFILE(QTEMP/QSRC) SRCMBR("$(SOURCE_NAME_NEW)"))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))



# SQL Table
.SECONDEXPANSION:
%.sqltable.file: $(SQL_PREREQ).sqltable

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqltable') DFTRDBCOL($(NEW_LIB)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL))

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL View
%.sqlview.file: $(SQL_PREREQ).sqlview

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqlview') DFTRDBCOL($(NEW_LIB)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL))

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL Index
%.sqlindex.file: $(SQL_PREREQ).sqlindex

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqlindex') DFTRDBCOL($(NEW_LIB)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL))

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL Function
%.sqlfunc.srvpgm: $(SQL_PREREQ).sqlfunc

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqlfunc') DFTRDBCOL($(NEW_LIB)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL))

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL Procedure
%.sqlproc.pgm: $(SQL_PREREQ).sqlproc

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqlproc') DFTRDBCOL($(NEW_LIB)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL))

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))


# SQL Trigger
%.sqltrig.pgm: $(SQL_PREREQ).sqltrig

	$(call bash_call,$(DOLLAR_SH_REPLACE))

	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/"$(SOURCE_NAME_NEW)".sqltrig') DFTRDBCOL($(NEW_LIB)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(call bash_call,$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL))

	$(FINALY)
	
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(subst #,\#,$(BUILD_DB)) $(LIBOBJ_NEW))
