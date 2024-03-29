#########################################################
# Dient nur dafür, damit beim Check (ob sich was geändert hat), 
# auch die Sourcen gefunden werden können
#########################################################

vpath %.sqlrpgle  $(RPGLE_SRCF):$(CPY_SRCF):$(CPYLE_SRCF)
vpath %.rpgle     $(RPGLE_SRCF):$(CPY_SRCF):$(CPYLE_SRCF)
vpath %.clle      $(CLLE_SRCF)
vpath %.pf        $(PF_SRCF)
vpath %.lf        $(LF_SRCF)
vpath %.sqltable  $(SQL_SRCF)
vpath %.sqlview   $(SQL_SRCF)
vpath %.sqlindex  $(SQL_SRCF)
vpath %.sqlfunc   $(SQL_SRCF)
vpath %.sqlproc   $(SQL_SRCF)
vpath %.sqltrig   $(SQL_SRCF)
vpath %.bnddir    $(TGT_DIR)


VPATH=$(TGT_DIR):$\
      $(INC_DIR):$(SRC_DIR):$\
      $(RPGLE_SRCF):$(CPY_SRCF):$(CPYLE_SRCF):$\
      $(CLLE_SRCF):$(PF_SRCF):$(SQL_SRCF)


#########################################################
# From here, you don't need to care ...
#########################################################

# Set environments variables
#.EXPORT_ALL_VARIABLES:

# All created files in IFS schould have CCSID 1208 (UTF-8)
# ... has no effekt
#QIBM_CCSID=1208

# All SHELL commands run in same process
# Will not end if an exception occurs!!
#.ONESHELL:

# Colors for terminal
COLOR_GREEN=\033[102;97m
COLOR_RED=\033[101;31m
COLOR_END=\033[0m


define uniq =
  $(eval seen :=)
  $(foreach _,$1,$(if $(filter $_,${seen}),,$(eval seen += $_)))
  ${seen}
endef

upper_case = $(shell echo '$1' | tr '[:lower:]' '[:upper:]')

define bash_call
  $1
endef