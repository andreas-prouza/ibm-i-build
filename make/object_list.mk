#########################################################
# List obj all objects to build
#
# The target is based on {source-type}.{object-type}
# 
# Extensions:
# |--------------------------------------------------------------|
# | Source   | Target          | Description                     |
# | type     | object          |                                 |
# |--------------------------------------------------------------|
# | clle     | clle.srvpgm     | CLLE service program object     |
# | clle     | clle.pgm        | CLLE program object             |
# | rpgle    | rpgle.pgm       | RPGLE program object            |
# | rpgle    | rpgle.srvpgm    | RPGLE program object            |
# | rpgle    | rpgle.cpy       | RPGLE copy source (no compile)  |
# | sqlrpgle | sqlrpgle.pgm    | SQLRPGLE service program object |
# | sqlrpgle | sqlrpgle.srvpgm | SQLRPGLE service program object |
# | pf       | pf.file         | Physical file                   |
# | lf       | lf.file         | Logical file                    |
# | sqltable | sqltable.file   | SQL table                       |
# | sqlview  | sqlview.file    | SQL view                        |
# | sqlindex | sqlindex.file   | SQL index                       |
# | sqlfunc  | sqlfunc.srvpgm  | SQL function                    |
# | sqlproc  | sqlproc.pgm     | SQL procedure                   |
# | sqltrig  | sqltrig.pgm     | SQL trigger                     |
# |--------------------------------------------------------------|
# 
#########################################################

# Summary of all objects to be build

			 
OBJS:= prouzalib/cpysrc2ifs.sqlrpgle.pgm \
			 prouzalib/date.sqlrpgle.srvpgm \
			 prouzalib/errhdlrpg.rpgle.srvpgm \
			 prouzalib/errhdlsql.sqlrpgle.srvpgm \
			 prouzalib/logger.sqlrpgle.srvpgm \
			 prouzalib/logger.sqltable.file \
			 prouzalib/testlog.rpgle.pgm \
			 prouzalib/testlog2.sqlrpgle.pgm \
			 prouzalib/testmod.rpgle.srvpgm \
			 prouzalib/testsqlerr.sqlrpgle.pgm \
			 prouzalib/prouzadir.bnddir \
			 prouzalib/testcl.clle.pgm \
			 prouzalib2/test.rpgle


#########################################################
# You can have dependencies to other objects (PGM, SRVPGM, Files, ...)
#
# {target object}: {list of dependencies} 
#
# With this list GMAKE is able to know which objects needs to build first.
# Also which object depends on each other.
#
# Example:
# prouzalib/test1.rpgle.pgm: prouzalib/testmod.rpgle.srvpgm
#
# testmod needs to be build first.
# Also if testmod.rpgle.srvpgm will be changed, GNU make automatically builds test1.rpgle.pgm to.
#########################################################

prouzalib/prouzadir.bnddir: \
		prouzalib/logger.sqlrpgle.srvpgm \
		prouzalib/errhdlsql.sqlrpgle.srvpgm \
		prouzalib/errhdlrpg.rpgle.srvpgm \
		prouzalib/testmod.rpgle.srvpgm \
		prouzalib/date.sqlrpgle.srvpgm

prouzalib/testsqlerr.sqlrpgle.pgm: \
		prouzalib/errhdlsql.sqlrpgle.srvpgm

#########################################################
# Dependency to BNDDIR or single SRVPGM?
#########################################################
#
# You can use a BNDDIR: But this means you have a dependency to all entries of the BNDDIR!!
# Because GNU Make doesn't know which module is necessary
# Pro: No need to check detailed dependencies, can't forget it if they are all in the same BNDDIR
# Cons: If you change a single SRVPGM in BNDDIR, all programs which depend on the BNDDIR will be compiled
prouzalib/testlog.rpgle.pgm: \
		prouzalib/prouzadir.bnddir
#
# You can also define all used modules (=srvpgm) you are using.
# This brings better performance for compiling because of direct dependency
prouzalib/testlog2.sqlrpgle.pgm: \
		prouzalib/testmod.rpgle.srvpgm \
		prouzalib/logger.sqlrpgle.srvpgm \
		prouzalib/errhdlsql.sqlrpgle.srvpgm
#
#########################################################


#########################################################
# Individual compile settings
#########################################################
#
prouzalib/errhdlsql.sqlrpgle.srvpgm:	prouzalib/logger.sqlrpgle.srvpgm
# You can also define custom parameters for an object
prouzalib/errhdlsql.sqlrpgle.srvpgm:	private INCLUDE_BNDDIR=*LIBL/PROUZADIR
prouzalib/errhdlsql.sqlrpgle.srvpgm:	private TGT_BNDDIR=*LIBL/PROUZADIR
#
#########################################################

prouzalib/logger.sqlrpgle.srvpgm:	\
		prouzalib/logger.sqltable.file
prouzalib/logger.sqlrpgle.srvpgm:	private BNDDIR=*LIBL/PROUZADIR
prouzalib/logger.sqlrpgle.srvpgm:	private TGT_BNDDIR=*LIBL/PROUZADIR

prouzalib/cpysrc2ifs.sqlrpgle.pgm: \
		prouzalib/errhdlsql.sqlrpgle.srvpgm

prouzalib/date.sqlrpgle.srvpgm: \
		prouzalib/logger.sqlrpgle.srvpgm \
		prouzalib/errhdlsql.sqlrpgle.srvpgm

prouzalib/testlog.rpgle.pgm: \
		prouzalib/logger.sqlrpgle.srvpgm

prouzalib/testlog2.sqlrpgle.pgm: \
		prouzalib/logger.sqlrpgle.srvpgm \
		prouzalib/errhdlsql.sqlrpgle.srvpgm \
		prouzalib/testmod.rpgle.srvpgm

prouzalib/testmod.rpgle.srvpgm: \
		prouzalib/logger.sqlrpgle.srvpgm

prouzalib/testsqlerr.sqlrpgle.pgm: \
		prouzalib/logger.sqlrpgle.srvpgm \
		prouzalib/errhdlsql.sqlrpgle.srvpgm