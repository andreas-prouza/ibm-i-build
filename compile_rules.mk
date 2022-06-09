# No flags necessary
EXC=cl
#CL_FLAG=-p

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

PRINT_JOBLOG=$(EXC) $(CL_FLAG) "DSPJOBLOG OUTPUT(*PRINT)" $(CCSID_CONV) > $(LOG_DIR)/$@.joblog.log

# Combine all to one
POST_COMPILE=$(CL_LOG) && $(CHECK_ERROR) && $(TOUCH) || ($(PRINT_JOBLOG) && false)


# Delete build file if exist
#PRE_COMPILE=rm -f $(TGT_DIR)/$@; 
SET_LIBL=$(patsubst %,liblist -a % > /dev/null;,$(LIBLIST_UNIQUE))
PRE_COMPILE=$(SET_LIBL)

HASH_VALUE=$(shell echo "\#")


CRTSRVPGM=  $(patsubst %,liblist -a %;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "CRTSRVPGM SRVPGM($(TGTLIB_PGM)/$*) MODULE($(TGTLIB_PGM)/$*) EXPORT(*ALL) " \
		"ACTGRP($(ACTGRP)) BNDDIR($(BND_DIR)) REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL))"  $(POST_COMPILE)

ADDBNDDIR=	$(patsubst %,liblist -a %;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) -q "ADDBNDDIRE BNDDIR($(TGTLIB_PGM)/$(BND_DIR)) OBJ($(TGTLIB_PGM)/$*)" $(POST_COMPILE)

RMVBNDDIR=	$(patsubst %,liblist -a %;,$(LIBLIST)) \
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) -q "RMVBNDDIRE BNDDIR($(TGTLIB_PGM)/$(BND_DIR)) OBJ($(TGTLIB_PGM)/$*)" $(POST_COMPILE)


# Soll immer als aller erstes laufen, damit die logs gelöscht werden
run_first_of_all=init


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


%.rpglecpy: %.rpgle
	echo "Not necessary"
	touch $(TGT_DIR)/$@



%.sqlrpglemod: %.sqlrpgle $(run_first_of_all)
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "CRTSQLRPGI OBJ($(TGTLIB_PGM)/$*) SRCSTMF('$(SQLRPGLE_SRCF)/$*.sqlrpgle') " \
							"OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS($(TGTRLS)) DBGVIEW($(DBGVIEW)) REPLACE(*YES) " \
							"COMPILEOPT(' INCDIR(''$(INC_DIR)'')')" $(POST_COMPILE)

	$(RMVBNDDIR)
	$(CRTSRVPGM)
	$(ADDBNDDIR)



%.rpglemod: %.rpgle $(run_first_of_all)
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "CRTRPGMOD MODULE($(TGTLIB_PGM)/$*) SRCSTMF('$(RPGLE_SRCF)/$*.rpgle') " \
							"DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(INC_DIR)')"  $(POST_COMPILE)

	$(RMVBNDDIR)
	$(CRTSRVPGM)
	$(ADDBNDDIR)



%.cllemod: %.clle $(run_first_of_all)
	 $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "CRTCLMOD MODULE($(TGTLIB_PGM)/$*) SRCSTMF('$(CLLE_SRCF)/$*.clle') DBGVIEW($(DBGVIEW))"  $(POST_COMPILE)

	$(RMVBNDDIR)
	$(CRTSRVPGM)
	$(ADDBNDDIR)
	


%.cllepgm: %.clle $(run_first_of_all)
# Create command string
	$(eval cmd :=CRTCLPGM PGM($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) MODULE($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) ENTMOD($(subst $(HASH_VALUE),\#,$*)) ACTGRP($(ACTGRP)) " \
					"REPLACE(*YES) TGTRLS($(TGTRLS)) STGMDL($(STGMDL)) DETAIL(*BASIC) $(bnddirs))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)
	$(eval COUNTER_CL=$(shell echo $$(($(COUNTER_CL)+1))))



%.rpgpgm: %.rpgle $(run_first_of_all)

	$(eval cmd :=CRTBNDRPG PGM($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(RPGLE_SRCF)/$(subst $(HASH_VALUE),\#,$*).rpgle') \
		DBGVIEW($(DBGVIEW)) TGTCCSID($(TGTCCSID)) REPLACE(*YES) TGTRLS($(TGTRLS)) INCDIR('$(INC_DIR)'))
	$(info crtcmd|$@|$(cmd))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)" $(POST_COMPILE)
	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))



%.sqlrpgpgm: %.sqlrpgle $(run_first_of_all)
	$(info ^ $(notdir $^))
	$(info * $*)
	$(info % $%)
	$(info ? $?)
	$(info @ $@)
# Get list of all modules (*.*LE ... CLLE, RPGLE, SQLRPGLE, etc.)
	$(eval modules := $(filter %mod,$(notdir $^)))
	$(eval modules := $(patsubst %,$(TGTLIB_PGM)/%,$(basename $(modules))))
	$(eval modules := $(modules:%=$(modules)))

    # Get list of all binding directories (*.bnddir)
	$(eval bnddirs := $(filter %.bnddir,$(notdir $^)))
	$(eval bnddirs := $(patsubst %.bnddir,*LIBL/%,$(bnddirs)))
	$(eval bnddirs := $(bnddirs:%=BNDDIR($(bnddirs))))

	$(eval cmd :=CRTSQLRPGI OBJ($(TGTLIB_PGM)/$(subst $(HASH_VALUE),\#,$*)) SRCSTMF('$(SQLRPGLE_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlrpgle') \
		OBJTYPE(*PGM) RPGPPOPT(*LVL2) TGTRLS($(TGTRLS)) DBGVIEW($(DBGVIEW)) REPLACE(*YES) \
		COMPILEOPT('TGTCCSID($(TGTCCSID)) INCDIR(''$(INC_DIR)'')'))
	$(info crtcmd|$@|$(cmd))

	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)" $(POST_COMPILE)
	$(eval COUNTER_RPG=$(shell echo $$(($(COUNTER_RPG)+1))))




# Create and change physical file
%.pfobj: %.pf $(run_first_of_all)
	$(eval cpystmf = $(EXC) $(CL_FLAG) "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; \
		$(EXC) $(CL_FLAG) "CPYFRMSTMF FROMSTMF('$(PF_SRCF)/$*.pf') TOMBR('/QSYS.lib/QTEMP.lib/QSRC.file/$*.mbr') MBROPT(*replace)";)
	$(info crtcmd|$@|$(cpystmf))

# Create object
	$(eval cmd=$(EXC) $(CL_FLAG) -q "CRTPF FILE($(TGTLIB_DBF)/$(subst $(HASH_VALUE),\#,$*)) SRCFILE(QTEMP/QSRC) SRCMBR($(subst $(HASH_VALUE),\#,$*))" $(CL_LOG); \
		$(EXC) $(CL_FLAG) -v "CHGPF FILE($(TGTLIB_DBF)/$(subst $(HASH_VALUE),\#,$*)) SRCFILE(QTEMP/QSRC) SRCMBR($(subst $(HASH_VALUE),\#,$*))")
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(cpystmf) $(PRE_COMPILE) $(cmd)  $(POST_COMPILE)

	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))



# Delete and create logical file
%.lfobj: %.lf $(run_first_of_all)
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
	$(cpystmf) $(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))



# SQL Table
%.sqltableobj: %.sqltable $(run_first_of_all)
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqltable') COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))


# SQL View
%.sqlviewobj: %.sqlview $(run_first_of_all)
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlview') COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))


# SQL Index
%.sqlindexobj: %.sqlindex $(run_first_of_all)
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlindex') COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))


# SQL Function
%.sqlfuncobj: %.sqlfunc $(run_first_of_all)
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlfunc') COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))


# SQL Procedure
%.sqlprocobj: %.sqlproc $(run_first_of_all)
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqlproc') COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))


# SQL Trigger
%.sqltrigobj: %.sqltrig $(run_first_of_all)
	$(eval cmd:=RUNSQLSTM SRCSTMF('$(SQL_SRCF)/$(subst $(HASH_VALUE),\#,$*).sqltrig') COMMIT(*NONE) ERRLVL(21))
	$(info crtcmd|$@|$(cmd))
	$(eval cmd:=$(subst \,,$(cmd)))
	$(PRE_COMPILE) $(EXC)  $(CL_FLAG) "$(cmd)"  $(POST_COMPILE)
	$(eval COUNTER_DB=$(shell echo $$(($(COUNTER_DB)+1))))
