#########################################################
# List obj all objects to build
# 
# Extensions:
#    *.bnddir      		Binding directory
#	 *.bnddirtarget		Binding directory to add the service program
#	 *.bnddirinclude	Binding directory used for compiling a service program object
#    *.rpgpgm      		ILE RPG Program
#    *.sqlrpgpgm   		ILE SQL RPG Program
#    *.clpgm       		ILE CL Program
#    *.cmdobj      		Command
#    *.sqltable   		SQL table
# 
#########################################################

# Summary of all objects to be build
OBJS:= testlog.rpglepgm loggerm.sqlrpglemod testmod.rpglemod logger.sqltableobj testlog2.sqlrpglepgm


#########################################################
# {Object}: list of dependencies (Modules, Binding Directories, Programs, ...)
# With this list GMAKE is able to know which objects needs to build first

# Example:

# projectdir.bnddir:	modul1.sqlrpglemod $\
#						modul2.sqlrpglemod $\
#						modul3.rpglemod

# mod3.rpglemod:		projectdir.bnddirtarget
# mod1.sqlrpglemod:		projectdir.bnddirtarget

# mycmd.cmdobj:			mypgm.clpgm
# pgm1.sqlrpgpgm:		projectdir.bnddir

########################################################
# BNDDIR!!
#   * ".bnddirtarget" 
#				binding directory is the target where the service programm will be added.
#   * ".bnddirinclude" 
#				binding directories will be used to create the service programm.
#   * ".bnddir" 
#				will be used for dependency check AND compile for all program objects
#########################################################

prouzadir.bnddir:		loggerm.sqlrpglemod testmod.rpglemod

loggerm.sqlrpglemod:	logger.sqltableobj prouzadir.bnddirtarget prouzadir.bnddirinclude
testmod.rpglemod:		prouzadir.bnddirtarget prouzadir.bnddirinclude loggerm.sqlrpglemod

# You can use a BNDDIR: But this means you have a dependency to all entries of the BNDDIR
testlog.rpglepgm:			prouzadir.bnddir
# You can also define all used modules (=srvpgm) you are using. This brings better performance for compiling
testlog2.sqlrpglepgm:		testmod.rpglemod loggerm.sqlrpglemod