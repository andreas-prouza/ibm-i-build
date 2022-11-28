#########################################################
# List obj all objects to build
# 
# Extensions:
# |----------------------------------------------------------|
# | Source   | Target      | Description                     |
# | type     | object      |                                 |
# |----------------------------------------------------------|
# | clle     | cllemod     | CLLE service program object     |
# | clle     | cllepgm     | CLLE program object             |
# | rpgle    | rpglepgm    | RPGLE program object            |
# | rpgle    | rpglemod    | RPGLE program object            |
# | rpgle    | rpglecpy    | RPGLE copy source (no compile)  |
# | sqlrpgle | sqlrpglepgm | SQLRPGLE service program object |
# | sqlrpgle | sqlrpglemod | SQLRPGLE service program object |
# | pf       | pfobj       | Physical file                   |
# | lf       | lfobj       | Logical file                    |
# | sqltable | sqltableobj | SQL table                       |
# | sqlview  | sqlviewobj  | SQL view                        |
# | sqlindex | sqlindexobj | SQL index                       |
# | sqlfunc  | sqlfuncobj  | SQL function                    |
# | sqlproc  | sqlprocobj  | SQL procedure                   |
# | sqltrig  | sqltrigobj  | SQL trigger                     |
# |----------------------------------------------------------|
# 
#########################################################

# Summary of all objects to be build
OBJS:= prouzalib/cpysrc2ifs.sqlrpglepgm \
			 prouzalib/date.sqlrpglemod \
			 prouzalib/errhdlrpg.rpglemod \
			 prouzalib/errhdlsql.sqlrpglemod \
			 prouzalib/logger.sqlrpglemod \
			 prouzalib/testlog.rpglepgm \
			 prouzalib/testlog2.sqlrpglepgm \
			 prouzalib/testmod.rpglemod \
			 prouzalib/testsqlerr.sqlrpglepgm \
			 prouzalib/prouzadir.bnddir \
			 prouzalib/testcl.cllepgm \
			 \
			 prouzalib2/test1.rpglepgm



#########################################################
# You can have dependencies to other objects (PGM, SRVPGM, Files, ...)
#
# {target object}: {list of dependencies} 
#
# With this list GMAKE is able to know which objects needs to build first.
# Also which object depends on each other.
#
# Example:
# prouzalib/test1.rpglepgm: prouzalib/testmod.rpglemod
#
# testmod needs to be build first.
# Also if testmod.rpglemod will be changed, GNU make automatically builds test1.rpglepgm to.
#########################################################

prouzalib/prouzadir.bnddir: prouzalib/logger.sqlrpglemod prouzalib/errhdlsql.sqlrpglemod prouzalib/errhdlrpg.rpglemod prouzalib/testmod.rpglemod prouzalib/date.sqlrpglemod

prouzalib/testsqlerr.sqlrpglepgm:	prouzalib/errhdlsql.sqlrpglemod

#########################################################
# Dependency to BNDDIR or single SRVPGM?
#########################################################
#
# You can use a BNDDIR: But this means you have a dependency to all entries of the BNDDIR!!
# Because GNU Make doesn't know which module is necessary
# Pro: No need to check detailed dependencies, can't forget it if they are all in the same BNDDIR
# Cons: If you change a single SRVPGM in BNDDIR, all programs which depend on the BNDDIR will be compiled
prouzalib/testlog.rpglepgm:			prouzalib/prouzadir.bnddir
#
# You can also define all used modules (=srvpgm) you are using.
# This brings better performance for compiling because of direct dependency
prouzalib/testlog2.sqlrpglepgm:	prouzalib/testmod.rpglemod prouzalib/logger.sqlrpglemod prouzalib/errhdlsql.sqlrpglemod
#
#########################################################


#########################################################
# Individual compile settings
#########################################################
#
prouzalib/errhdlsql.sqlrpglemod:	prouzalib/logger.sqlrpglemod
# You can also define custom parameters for an object
prouzalib/errhdlsql.sqlrpglemod:	private INCLUDE_BNDDIR=*LIBL/PROUZADIR
prouzalib/errhdlsql.sqlrpglemod:	private TGT_BNDDIR=*LIBL/PROUZADIR
#
#########################################################

prouzalib/logger.sqlrpglemod:	prouzalib/logger.sqltableobj
prouzalib/logger.sqlrpglemod:	private BNDDIR=*LIBL/PROUZADIR
prouzalib/logger.sqlrpglemod:	private TGT_BNDDIR=*LIBL/PROUZADIR

prouzalib/cpysrc2ifs.sqlrpglepgm: prouzalib/errhdlsql.sqlrpglemod

prouzalib/date.sqlrpglemod:				prouzalib/logger.sqlrpglemod prouzalib/errhdlsql.sqlrpglemod

prouzalib/testlog.rpglepgm:				prouzalib/logger.sqlrpglemod

prouzalib/testlog2.sqlrpglepgm:		prouzalib/logger.sqlrpglemod prouzalib/errhdlsql.sqlrpglemod prouzalib/testmod.rpglemod

prouzalib/testmod.rpglemod:				prouzalib/logger.sqlrpglemod

prouzalib/testsqlerr.sqlrpglepgm:	prouzalib/logger.sqlrpglemod prouzalib/errhdlsql.sqlrpglemod