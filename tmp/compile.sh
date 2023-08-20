#!/bin/bash

rm -rf ./logs/**/*
mkdir -p ./logs/prouzalib
mkdir -p ./logs/prouzalib2
mkdir -p ./build/prouzalib
mkdir -p ./build/prouzalib2
(   cl "CHGATR OBJ('"'prouzalib2//qrpglesrc/sqltest1.sqlrpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("PROUZAT2/sqltest1") SRCSTMF('./prouzalib2//qrpglesrc/"sqltest1".sqlrpgle') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''./prouzalib2/'')')"    2>> './logs/prouzalib2/sqltest1.sqlrpgle.pgm.error.log'  >> './logs/prouzalib2/sqltest1.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib2/sqltest1.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib2/sqltest1.sqlrpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib2//qrpglesrc/sqltest1.sqlrpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("PROUZAT2/sqltest1") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2>> './logs/prouzalib2/sqltest1.sqlrpgle.pgm.error.log'  >> './logs/prouzalib2/sqltest1.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib2/sqltest1.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib2/sqltest1.sqlrpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib2//qrpglesrc/sqltest1.sqlrpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib2/sqltest1.sqlrpgle.pgm'; date > ./build/prouzalib2/sqltest1.sqlrpgle.pgm
(   cl "CHGATR OBJ('"'prouzalib2//qsqlsrc/sqltest1.sqlproc'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('./prouzalib2//qsqlsrc/"sqltest1".sqlproc') DFTRDBCOL(PROUZAT2) COMMIT(*NONE) ERRLVL(21)"    2>> './logs/prouzalib2/sqltest1.sqlproc.pgm.error.log'  >> './logs/prouzalib2/sqltest1.sqlproc.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib2/sqltest1.sqlproc.pgm.joblog.log' )
if [ -s './logs/prouzalib2/sqltest1.sqlproc.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib2//qsqlsrc/sqltest1.sqlproc\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib2/sqltest1.sqlproc.pgm'; date > ./build/prouzalib2/sqltest1.sqlproc.pgm
cat ./logs/*.error.log 2> /dev/null | true
echo -e "\033[102;97mCompile complete\033[0m"
