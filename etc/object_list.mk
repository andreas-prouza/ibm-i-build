#########################################################
# List obj all objects to build
#
# The target is based on {source-type}.{object-type}
# 
# Extensions:
# |------------------------------------------------------------------|
# | Source   | Target              | Description                     |
# | type     | object              |                                 |
# |------------------------------------------------------------------|
# | clle     | clle.srvpgm.obj     | CLLE service program object     |
# | clle     | clle.pgm.obj        | CLLE program object             |
# | rpgle    | rpgle.pgm.obj       | RPGLE program object            |
# | rpgle    | rpgle.srvpgm.obj    | RPGLE program object            |
# | rpgle    | rpgle.cpy           | RPGLE copy source (no compile)  |
# | sqlrpgle | sqlrpgle.pgm.obj    | SQLRPGLE service program object |
# | sqlrpgle | sqlrpgle.srvpgm.obj | SQLRPGLE service program object |
# | pf       | pf.file.obj         | Physical file                   |
# | lf       | lf.file.obj         | Logical file                    |
# | sqltable | sqltable.file.obj   | SQL table                       |
# | sqlview  | sqlview.file.obj    | SQL view                        |
# | sqlindex | sqlindex.file.obj   | SQL index                       |
# | sqlfunc  | sqlfunc.srvpgm.obj  | SQL function                    |
# | sqlproc  | sqlproc.pgm.obj     | SQL procedure                   |
# | sqltrig  | sqltrig.pgm.obj     | SQL trigger                     |
# |------------------------------------------------------------------|
# 
#########################################################

# Summary of all objects to be build

#------------------
# Hard-coded
#------------------

OBJS:= prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.obj \
			 prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.obj \
			 prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.obj \
			 prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj \
			 prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj \
			 prouzalib/qrpglesrc/logger.sqltable.file \
			 prouzalib/qrpglesrc/testlog.rpgle.pgm.obj \
			 prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.obj \
			 prouzalib/qrpglesrc/testmod.rpgle.srvpgm.obj \
			 prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.obj \
			 prouzalib/qrpglesrc/prouzadir.bnddir \
			 prouzalib/qrpglesrc/testcl.clle.pgm.obj \
			 prouzalib2/test.rpgle \
			 prouzalib2/sqltest1.sqlrpgle.pgm.obj \
			 prouzalib2/sqltest1.sqlproc.pgm.obj


#------------------
# Dynamically
#------------------

# Currently we search for all SRVPGM, PGM, FILE

OBJS:= $(shell find prouzalib* -type f \( -iname \*.pgm -o -iname \*.srvpgm -o -iname \*.file \) | sed 's/$$/.obj/' | sed 's/\$$/\$$\$$/' )



#########################################################
# You can have dependencies to other objects (PGM, SRVPGM, Files, ...)
#
# {target object}: {list of dependencies} 
#
# With this list GMAKE is able to know which objects needs to build first.
# Also which object depends on each other.
#
# Example:
# prouzalib/qrpglesrc/test1.rpgle.pgm.obj: prouzalib/qrpglesrc/testmod.rpgle.srvpgm.obj
#
# testmod needs to be build first.
# Also if testmod.rpgle.srvpgm.obj will be changed, GNU make automatically builds test1.rpgle.pgm.obj to.
#########################################################

prouzalib/qrpglesrc/prouzadir.bnddir.obj: \
		prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj \
		prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj \
		prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.obj \
		prouzalib/qrpglesrc/testmod.rpgle.srvpgm.obj \
		prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.obj

prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.obj: \
		prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj

#########################################################
# Dependency to BNDDIR or single SRVPGM?
#########################################################
#
# You can use a BNDDIR: But this means you have a dependency to all entries of the BNDDIR!!
# Because GNU Make doesn't know which module is necessary
# Pro: No need to check detailed dependencies, can't forget it if they are all in the same BNDDIR
# Cons: If you change a single SRVPGM in BNDDIR, all programs which depend on the BNDDIR will be compiled
#prouzalib/qrpglesrc/testlog.rpgle.pgm.obj: \
		prouzalib/qrpglesrc/prouzadir.bnddir.obj
#
# You can also define all used modules (=srvpgm) you are using.
# This brings better performance for compiling because of direct dependency
prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.obj: \
		prouzalib/qrpglesrc/testmod.rpgle.srvpgm.obj \
		prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj \
		prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj
#
#########################################################


#########################################################
# Individual compile settings
#########################################################
#
prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj:	prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj
# You can also define custom parameters for an object
prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj:	private INCLUDE_BNDDIR=*LIBL/PROUZADIR
prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj:	private TGT_BNDDIR=*LIBL/PROUZADIR
#
#########################################################

#########################################################
# Dependency list
#########################################################
#

prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj:	\
		prouzalib/qsqlsrc/logger.sqltable.file
prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj:	private BNDDIR=*LIBL/PROUZADIR
prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj:	private TGT_BNDDIR=*LIBL/PROUZADIR

prouzalib/qsqlsrc/logger_hist.sqltable.file.obj:	\
		prouzalib/qsqlsrc/logger.sqltable.file.obj

prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.obj: \
		prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj

prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.obj: \
		prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj \
		prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj

prouzalib/qrpglesrc/testlog.rpgle.pgm.obj: \
		prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj

prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.obj: \
		prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj \
		prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj \
		prouzalib/qrpglesrc/testmod.rpgle.srvpgm.obj

prouzalib/qrpglesrc/testmod.rpgle.srvpgm.obj: \
		prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj

prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.obj: \
		prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj \
		prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj


prouzalib2/sqltest1.sqlproc.pgm: prouzalib2/sqltest1.sqlrpgle.pgm

prouzalib2/sqltest2.sqlproc.pgm: prouzalib2/sqltest2.sqlrpgle.pgm

prouzalib2/sqlsrv1.sqlproc.pgm: prouzalib2/sqlsrv1.sqlrpgle.srvpgm

prouzalib2/test.rpgle.pgm: prouzalib/test.rpgle.pgm

prouzalib/testlog.rpgle.pgm: private OBJLIB=prouza2

prouzalib/\#test.rpgle.pgm:	private OBJLIB=*SOURCE

prouzalib/\#test2.rpgle.pgm:	private OBJLIB=PROUZA4

prouzalib/§test.rpgle.pgm:	private OBJLIB=PROUZA2