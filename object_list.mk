#########################################################
# List obj all objects to build
# 
# Extensions:
#    *.bnddir      Binding directory
#    *.rpgpgm      ILE RPG Program
#    *.sqlrpgpgm   ILE SQL RPG Program
#    *.clpgm       ILE CL Program
#    *.cmdobj      Command
# 
#########################################################

# Summary of all objects to be build
 OBJS:= testlog.rpglemod logger.sqlrpglemod logger.sqltable



#########################################################
# {Object}: list of dependencies (Modules, Binding Directories, Programs, ...)
# With this list GMAKE is able to know which objects needs to build first
# Example:
# mycmd.cmdobj:			mypgm.clpgm
# pgm1.sqlrpgpgm:		$(BND_DIR).bnddir
# $(BND_DIR).bnddir:	modul1.sqlrpglemod $\
#						modul2.sqlrpglemod $\
#						modul3.rpglemod
#########################################################

logger.sqlrpglemod:		logger.sqltable prouzadir.bnddir
testlog.rpglemod:		prouzadir.bnddir logger.sqlrpglemod