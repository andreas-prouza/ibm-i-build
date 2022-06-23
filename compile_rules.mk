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

PRINT_JOBLOG=$(EXC) $(CL_FLAG) "DSPJOBLOG" $(CCSID_CONV) > $(LOG_DIR)/$@.joblog.log

# Combine all to one
POST_COMPILE=$(CL_LOG); $(PRINT_JOBLOG); $(CHECK_ERROR)
POST_COMPILE_FINAL=$(CL_LOG); $(PRINT_JOBLOG); $(CHECK_ERROR) && $(TOUCH)


# Delete build file if exist
#PRE_COMPILE=rm -f $(TGT_DIR)/$@; 
SET_LIBL=$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST_UNIQUE))
PRE_COMPILE=$(SET_LIBL)

HASH_VALUE=$(shell echo "\#")




CRTSRVPGM_CMD= CRTSRVPGM SRVPGM($(TGTLIB_PGM)/$*) MODULE($(TGTLIB_PGM)/$*) EXPORT(*ALL) ACTGRP($(ACTGRP)) $(bnddirs) \
			REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL))
CRTSRVPGM=  $(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(CRTSRVPGM_CMD)"  $(POST_COMPILE)

ADDBNDDIR_CMD=ADDBNDDIRE BNDDIR($(frist_bnddir)) OBJ($(TGTLIB_PGM)/$*)
ADDBNDDIR=	$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) -q "$(ADDBNDDIR_CMD)" $(POST_COMPILE_FINAL)

RMVBNDDIR_CMD=RMVBNDDIRE BNDDIR($(frist_bnddir)) OBJ($(TGTLIB_PGM)/$*)
RMVBNDDIR=	$(patsubst %,liblist -a % 2> /dev/null;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) -q "$(RMVBNDDIR_CMD)" $(POST_COMPILE)




#########################################################
# Rules for all objects and their dependencies
#########################################################
# All objects will be checked if their source had been changed.
# Therefore it is necessary to have different naming conventions:
#   - *.cllemod: The module object
#   - *.clle:    The source to the related object cllemod
#
# touch ... will create a dummy file for each object (bnddir, module, program)
#   Make uses these dummy files to compare the timestamp to the related sources
########################################################
# BNDDIR!!
# The first binding directory of the dependency list is the target where the service programm will be added.
# All additional binding directories will be used to create the service programm.
# Example:
#   mysrvpgm.sqlrpglemod:   mod1.rpglemod mybnddir.bnddir anotherdir.bnddir testdir.bnddir
#   #### The service program will be added in MYBNDDIR.

########################################################
# Example:
#   If object setuphip.cllemod needs to be build (because it's necessary for setuphip.pgm),
#   it first checks if the source setuphip.clle has a different timstamp then the 
#   setuphip.cllemod file in the build directory.
#   Is this the case, GNU make will compile this object
#########################################################
# Here is an info which of the content of each automatic variables.
# They will be used to retrieve the parameters (dependencies).
#
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html#Automatic-Variables
#	$(info ^ $^)
#	$(info * $*)
#	$(info % $%)
#	$(info ? $?)
#	$(info @ $@)
#########################################################

%.bnddir:
#	-$(PRE_COMPILE) $(EXC)  $(CL_FLAG) -v "CRTBNDDIR ($(TGTLIB_PGM)/$*)" $(POST_COMPILE_FINAL)
	touch $(TGT_DIR)/$@



%.bnddirtarget:
	touch $(TGT_DIR)/$@

%.bnddirinclude:
	touch $(TGT_DIR)/$@


%.rpglecpy: %.rpgle
	echo "Not necessary"
	touch $(TGT_DIR)/$@



%.sqlrpglemod: %.sqlrpgle

    # Get list of all binding directories (*.bnddir)
	$(eval bnddirs := $(filter %.bnddirinclude,$(notdir $^)))
	$(eval frist_bnddir := $(basename $(filter %.bnddirtarget,$(notdir $^))))
	$(eval bnddirs := $(patsubst %.bnddirinclude,*LIBL/%,$(bnddirs)))
	$(eval bnddirs := $(bnddirs:%=BNDDIR($(bnddirs))))

	$(eval cmd :=CRTSQLRPGI OBJ($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(SQLRPGLE_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlrpgle') \
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



%.rpglemod: %.rpgle

    # Get list of all binding directories (*.bnddir)
	$(eval bnddirs := $(filter %.bnddirinclude,$(notdir $^)))
	$(eval frist_bnddir := $(basename $(filter %.bnddirtarget,$(notdir $^))))
	$(eval bnddirs := $(patsubst %.bnddirinclude,*LIBL/%,$(bnddirs)))
	$(eval bnddirs := $(bnddirs:%=BNDDIR($(bnddirs))))

	$(eval cmd :=CRTRPGMOD MODULE($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(RPGLE_SRCF)/$(subst $(HASH_VALUE),\#,$*).rpgle') \
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



%.cllemod: %.clle

    # Get list of all binding directories (*.bnddir)
	$(eval bnddirs := $(filter %.bnddirinclude,$(notdir $^)))
	$(eval frist_bnddir := $(basename $(filter %.bnddirtarget,$(notdir $^))))
	$(eval bnddirs := $(patsubst %.bnddirinclude,*LIBL/%,$(bnddirs)))
	$(eval bnddirs := $(bnddirs:%=BNDDIR($(bnddirs))))

	$(eval cmd :=CRTCLMOD MODULE($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(CLLE_SRCF)/$(subst $(HASH_VALUE),\#,$*).clle') DBGVIEW($(DBGVIEW)))
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



%.cllepgm: %.clle

    # Get list of all binding directories (*.bnddir)
	$(eval bnddirs := $(filter %.bnddirinclude,$(notdir $^)))
	$(eval frist_bnddir := $(basename $(filter %.bnddirtarget,$(notdir $^))))
	$(eval bnddirs := $(patsubst %.bnddirinclude,*LIBL/%,$(bnddirs)))
	$(eval bnddirs := $(bnddirs:%=BNDDIR($(bnddirs))))

# Create command string
	$(eval cmd :=CRTCLPGM PGM($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) MODULE($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) ENTMOD($(subst $(HASH_VALUE),\#,$*)) ACTGRP($(ACTGRP)) " \
					"REPLACE(*YES) TGTRLS($(TGTRLS)) ACTGRP($(ACTGRP)) STGMDL($(STGMDL)) DETAIL(*BASIC))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_CL=$(shell echo $$(($(COUNTER_CL)+1))))
	$(eval BUILD_CL := $(BUILD_CL) $(subst $(HASH_VALUE),\#,$@))



%.rpglepgm: %.rpgle

    # Get list of all modules (*.*LE ... CLLE, RPGLE, SQLRPGLE, etc.)
	$(eval modules := $(filter %mod,$(notdir $^)))
	$(eval modules := $(patsubst %,(*LIBL/%),$(basename $(modules))))
	$(eval modules := BNDSRVPGM($(modules)))

    # Get list of all binding directories (*.bnddir)
	$(eval bnddirs := $(filter %.bnddir,$(notdir $^)))
	$(eval frist_bnddir := $(basename $(filter %.bnddirtarget,$(notdir $^))))
	$(eval bnddirs := $(patsubst %.bnddir,*LIBL/%,$(bnddirs)))
	$(eval bnddirs := $(bnddirs:%=BNDDIR($(bnddirs))))

	$(eval cmd :=CRTRPGMOD MODULE($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(RPGLE_SRCF)/$(subst $(HASH_VALUE),\#,$*).rpgle') \
							DBGVIEW($(DBGVIEW)) REPLACE(*YES) TGTCCSID($(TGTCCSID)) INCDIR('$(INC_DIR)'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)

    # Create command string
	$(eval cmd := CRTPGM PGM($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) \
					STGMDL($(STGMDL)) DETAIL(*BASIC) $(modules) $(bnddirs))
	$(info crtcmd|$@|$(cmd))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)

	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))
	$(eval BUILD_RPG := $(BUILD_RPG) $(subst $(HASH_VALUE),\#,$@))



%.sqlrpglepgm: %.sqlrpgle

    # Get list of all modules (*.*LE ... CLLE, RPGLE, SQLRPGLE, etc.)
	$(eval modules := $(filter %mod,$(notdir $^)))
	$(eval modules := $(patsubst %,(*LIBL/%),$(basename $(modules))))
	$(eval modules := BNDSRVPGM($(modules)))

    # Get list of all binding directories (*.bnddir)
	$(eval bnddirs := $(filter %.bnddir,$(notdir $^)))
	$(eval frist_bnddir := $(basename $(filter %.bnddirtarget,$(notdir $^))))
	$(eval bnddirs := $(patsubst %.bnddir,*LIBL/%,$(bnddirs)))
	$(eval bnddirs := $(bnddirs:%=BNDDIR($(bnddirs))))


	$(eval cmd :=CRTSQLRPGI OBJ($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(SQLRPGLE_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlrpgle') \
							OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS($(TGTRLS)) DBGVIEW($(DBGVIEW)) REPLACE(*YES) \
							COMPILEOPT('TGTCCSID($(TGTCCSID)) INCDIR(''$(INC_DIR)'')'))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)

    # Create command string
	$(eval cmd := CRTPGM PGM($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) ACTGRP($(ACTGRP)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL)) DETAIL(*BASIC) $(modules) $(bnddirs))
	$(info crtcmd|$@|$(cmd))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)

	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))
	$(eval BUILD_RPG := $(BUILD_RPG) $(subst $(HASH_VALUE),\#,$@))




# Create and change physical file
%.pfobj: %.pf
	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
		$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(PF_SRCF)/$*.pf') TOMBR('/QSYS.lib/QTEMP.lib/QSRC.file/$*.mbr') MBROPT(*replace)";)
	$(info crtcmd|$@|$(cpystmf))

# Create object
	$(eval cmd=$(EXC) $(CL_FLAG) -q "CRTPF FILE($(TGTLIB_DBF)/$(subst $(HASH_VALUE),\#,$*)) SRCFILE(QTEMP/QSRC) SRCMBR($(subst $(HASH_VALUE),\#,$*))" $(CL_LOG); \
		$(EXC) $(CL_FLAG) -v "CHGPF FILE($(TGTLIB_DBF)/$(subst $(HASH_VALUE),\#,$*)) SRCFILE(QTEMP/QSRC) SRCMBR($(subst $(HASH_VALUE),\#,$*))")
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(cmd)  $(POST_COMPILE_FINAL)

	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))



# Delete and create logical file
%.lfobj: %.lf
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
%.sqltableobj: %.sqltable
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqltable') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL View
%.sqlviewobj: %.sqlview
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlview') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL Index
%.sqlindexobj: %.sqlindex
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlindex') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL Function
%.sqlfuncobj: %.sqlfunc
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlfunc') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL Procedure
%.sqlprocobj: %.sqlproc
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlproc') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))


# SQL Trigger
%.sqltrigobj: %.sqltrig
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqltrig') DFTRDBCOL($(TGTLIB_DBF)) COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE_FINAL)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
	$(eval BUILD_DB := $(BUILD_DB) $(subst $(HASH_VALUE),\#,$@))
