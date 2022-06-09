#########################################################
# Dient nur dafür, damit beim Check (ob sich was geändert hat), 
# auch die Sourcen gefunden werden können
#########################################################

vpath %.sqlrpgle  $(RPGLE_SRCF):$(CPY_SRCF):$(CPYLE_SRCF)
vpath %.rpgle     $(RPGLE_SRCF):$(CPY_SRCF):$(CPYLE_SRCF)
vpath %.clle      $(CLLE_SRCF)
vpath %.pf        $(PF_SRCF)
vpath %.lf        $(PF_SRCF)
vpath %.sqltable  $(SQL_SRCF)
vpath %.sqlview   $(SQL_SRCF)
vpath %.sqlindex  $(SQL_SRCF)
vpath %.sqlfunc   $(SQL_SRCF)
vpath %.sqlproc   $(SQL_SRCF)
vpath %.sqltrig   $(SQL_SRCF)


VPATH=$(TGT_DIR):$\
      $(INC_DIR):$(SRC_DIR):$\
      $(RPGLE_SRCF):$(CPY_SRCF):$(CPYLE_SRCF):$\
      $(CLLE_SRCF):$(PF_SRCF):$(SQL_SRCF)


#########################################################
# From here, you don't need to care ...
#########################################################

# Set environments variables
.EXPORT_ALL_VARIABLES:

# All created files in IFS schould have CCSID 1208 (UTF-8)
QIBM_CCSID=1208

# All SHELL commands run in same process
# !!! Achtung verhindert Fehler Abbruch!!!
#.ONESHELL:



define uniq =
  $(eval seen :=)
  $(foreach _,$1,$(if $(filter $_,${seen}),,$(eval seen += $_)))
  ${seen}
endef