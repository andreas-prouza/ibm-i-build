#############################################################
#
# Set up your own development environment
#
# Here you can override your specific environment values
# which will not be synchronized to Git
#
#    * IFS path to your own project path
#    * Target lib
#    * ...
#
#############################################################

#############################################################
### Source directory
#############################################################
#SRC_DIR=/home/prouza/myproject
#ACTGRP=PROUZAGRP
#BNDDIR_LIB=PROUZALIB

#############################################################
### Include DIR (e.g. to search for /copy members in RPG sources)
#############################################################
#INC_DIR=/home/prouza/myproject

#############################################################
### Directory for compile logs
#############################################################
#LOG_DIR=$(SRC_DIR)/logs

#############################################################
### Directory to create a dummy file for each object. (For source timestamp change check)
#############################################################
#TGT_DIR=$(SRC_DIR)/build

#############################################################
### Target library - Global
## Global target lib
#############################################################
#TGTLIB_OBJ_GLOBAL=PROUZALIB
## If global target lib is empty ==> Source-Lib will be used
#TGTLIB_OBJ_GLOBAL=

#############################################################
### Target library - Specific
## Replace map specific libs to a separate target
## TGTLIB_{SRC-LIB} := {new-compile-lib}
#############################################################
TGTLIB_PROUZALIB := PROUZAT1
TGTLIB_PROUZALIB2 := PROUZAT2
TGTLIB_PROUZA4 := PROUZAT3
TGTLIB_PROUZA2 := PROUZAT3
#TGTLIB_PROUZA4 := *source
#TGTLIB_OBJ_GLOBAL=Hansi


OBJS:= prouzalib/file1.pf.file \
			 prouzalib/$$$$test.rpgle.pgm \
			 prouzalib/\#test.rpgle.pgm \
			 prouzalib/\#test2.rpgle.pgm \
			 prouzalib/test.rpgle.pgm \
			 prouzalib/§test.rpgle.pgm \
			 prouzalib/$$$$t§§x\#y.rpgle.pgm \
			 \
			 prouzalib2/test.rpgle.pgm \
			 prouzalib2/test1.rpgle.pgm \
			 \
			 prouzalib/cpysrc2ifs.sqlrpgle.pgm \
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
			 prouzalib2/sqltest1.sqlrpgle.pgm \
			 prouzalib2/sqltest1.sqlproc.pgm \
			 prouzalib2/sqltest2.sqlrpgle.pgm \
			 prouzalib2/sqltest2.sqlproc.pgm

#OBJS:= prouzalib/test.rpgle.pgm \
			 prouzalib2/test.rpgle.pgm \
			 prouzalib2/test1.rpgle.pgm \

prouzalib2/sqltest1.sqlproc.pgm: prouzalib2/sqltest1.sqlrpgle.pgm

prouzalib2/sqltest2.sqlproc.pgm: prouzalib2/sqltest2.sqlrpgle.pgm




prouzalib2/test.rpgle.pgm: prouzalib/test.rpgle.pgm

prouzalib/testlog.rpgle.pgm: private OBJLIB=prouza2

prouzalib/\#test.rpgle.pgm:	private OBJLIB=*SOURCE
prouzalib/\#test2.rpgle.pgm:	private OBJLIB=PROUZA4
prouzalib/§test.rpgle.pgm:	private OBJLIB=PROUZA2

