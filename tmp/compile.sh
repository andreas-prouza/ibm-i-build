#!/bin/bash

print_debug() {
 echo "#DEBUG-Remote "`date +"%F %T.%3N"`": "$BASH_COMMAND 
}

trap 'print_debug' DEBUG

cl -v "dspjob"

rm -rf ./logs/**/*
mkdir -p ./logs/prouzalib
mkdir -p ./logs/prouzalib2
mkdir -p ./build/prouzalib
mkdir -p ./build/prouzalib2
rm -rf ./tmp
mkdir -p ./tmp
(   cl "CHGATR OBJ('"'prouzalib//qsqlsrc/logger.sqltable'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('./prouzalib//qsqlsrc/"logger".sqltable') DFTRDBCOL(PROUZAT1) COMMIT(*NONE) ERRLVL(21)"    2>> './logs/prouzalib/logger.sqltable.file.error.log'  >> './logs/prouzalib/logger.sqltable.file.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/logger.sqltable.file.joblog.log' )
if [ -s './logs/prouzalib/logger.sqltable.file.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qsqlsrc/logger.sqltable\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/logger.sqltable.file'; date > './build/prouzalib/logger.sqltable.file'; echo 'prouzalib/logger.sqltable.file|'`date` >> ./tmp/compiled.txt
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/logger.sqlrpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("PROUZAT1/logger") SRCSTMF('./prouzalib//qrpglesrc/"logger".sqlrpgle') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''./prouzalib/'')')"    2>> './logs/prouzalib/logger.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/logger.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/prouzalib/logger.sqlrpgle.srvpgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/logger.sqlrpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"   2>> './logs/prouzalib/logger.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/logger.sqlrpgle.srvpgm.joblog.log' )
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("PROUZAT1/logger") MODULE("PROUZAT1/logger") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2>> './logs/prouzalib/logger.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/logger.sqlrpgle.srvpgm.joblog.log' )
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"   2>> './logs/prouzalib/logger.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/logger.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/prouzalib/logger.sqlrpgle.srvpgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/logger.sqlrpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/logger.sqlrpgle.srvpgm'; date > './build/prouzalib/logger.sqlrpgle.srvpgm'; echo 'prouzalib/logger.sqlrpgle.srvpgm|'`date` >> ./tmp/compiled.txt
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/errhdlsql.sqlrpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("PROUZAT1/errhdlsql") SRCSTMF('./prouzalib//qrpglesrc/"errhdlsql".sqlrpgle') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''./prouzalib/'')')"    2>> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/errhdlsql.sqlrpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"   2>> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("PROUZAT1/errhdlsql") MODULE("PROUZAT1/errhdlsql") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2>> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"   2>> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/errhdlsql.sqlrpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/errhdlsql.sqlrpgle.srvpgm'; date > './build/prouzalib/errhdlsql.sqlrpgle.srvpgm'; echo 'prouzalib/errhdlsql.sqlrpgle.srvpgm|'`date` >> ./tmp/compiled.txt
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/cpysrc2ifs.sqlrpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("PROUZAT1/cpysrc2ifs") SRCSTMF('./prouzalib//qrpglesrc/"cpysrc2ifs".sqlrpgle') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''./prouzalib/'')')"    2>> './logs/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log'  >> './logs/prouzalib/cpysrc2ifs.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/cpysrc2ifs.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/cpysrc2ifs.sqlrpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("PROUZAT1/cpysrc2ifs") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2>> './logs/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log'  >> './logs/prouzalib/cpysrc2ifs.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/cpysrc2ifs.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/cpysrc2ifs.sqlrpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/cpysrc2ifs.sqlrpgle.pgm'; date > './build/prouzalib/cpysrc2ifs.sqlrpgle.pgm'; echo 'prouzalib/cpysrc2ifs.sqlrpgle.pgm|'`date` >> ./tmp/compiled.txt
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/date.sqlrpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("PROUZAT1/date") SRCSTMF('./prouzalib//qrpglesrc/"date".sqlrpgle') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''./prouzalib/'')')"    2>> './logs/prouzalib/date.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/date.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/prouzalib/date.sqlrpgle.srvpgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/date.sqlrpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"   2>> './logs/prouzalib/date.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/date.sqlrpgle.srvpgm.joblog.log' )
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("PROUZAT1/date") MODULE("PROUZAT1/date") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2>> './logs/prouzalib/date.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/date.sqlrpgle.srvpgm.joblog.log' )
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"   2>> './logs/prouzalib/date.sqlrpgle.srvpgm.error.log'  >> './logs/prouzalib/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/date.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/prouzalib/date.sqlrpgle.srvpgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/date.sqlrpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/date.sqlrpgle.srvpgm'; date > './build/prouzalib/date.sqlrpgle.srvpgm'; echo 'prouzalib/date.sqlrpgle.srvpgm|'`date` >> ./tmp/compiled.txt
(   cl "CHGATR OBJ('"'prouzalib//qsqlsrc/logger_hist.sqltable'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('./prouzalib//qsqlsrc/"logger_hist".sqltable') DFTRDBCOL(PROUZAT1) COMMIT(*NONE) ERRLVL(21)"    2>> './logs/prouzalib/logger_hist.sqltable.file.error.log'  >> './logs/prouzalib/logger_hist.sqltable.file.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/logger_hist.sqltable.file.joblog.log' )
if [ -s './logs/prouzalib/logger_hist.sqltable.file.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qsqlsrc/logger_hist.sqltable\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/logger_hist.sqltable.file'; date > './build/prouzalib/logger_hist.sqltable.file'; echo 'prouzalib/logger_hist.sqltable.file|'`date` >> ./tmp/compiled.txt
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/testmod.rpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("PROUZAT1/testmod") SRCSTMF('./prouzalib//qrpglesrc/"testmod".rpgle') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('./prouzalib/')"    2>> './logs/prouzalib/testmod.rpgle.srvpgm.error.log'  >> './logs/prouzalib/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testmod.rpgle.srvpgm.joblog.log' )
if [ -s './logs/prouzalib/testmod.rpgle.srvpgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/testmod.rpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"   2>> './logs/prouzalib/testmod.rpgle.srvpgm.error.log'  >> './logs/prouzalib/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testmod.rpgle.srvpgm.joblog.log' )
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("PROUZAT1/testmod") MODULE("PROUZAT1/testmod") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2>> './logs/prouzalib/testmod.rpgle.srvpgm.error.log'  >> './logs/prouzalib/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testmod.rpgle.srvpgm.joblog.log' )
( liblist -a PROUZAT1 2> /dev/null; liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"   2>> './logs/prouzalib/testmod.rpgle.srvpgm.error.log'  >> './logs/prouzalib/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testmod.rpgle.srvpgm.joblog.log' )
if [ -s './logs/prouzalib/testmod.rpgle.srvpgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/testmod.rpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/testmod.rpgle.srvpgm'; date > './build/prouzalib/testmod.rpgle.srvpgm'; echo 'prouzalib/testmod.rpgle.srvpgm|'`date` >> ./tmp/compiled.txt
touch './build/prouzalib/prouzadir.bnddir'; date > './build/prouzalib/prouzadir.bnddir'; echo 'prouzalib/prouzadir.bnddir|'`date` >> ./tmp/compiled.txt
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/testlog.rpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("PROUZAT3/testlog") SRCSTMF('./prouzalib//qrpglesrc/"testlog".rpgle') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('./prouzalib/')"    2>> './logs/prouzalib/testlog.rpgle.pgm.error.log'  >> './logs/prouzalib/testlog.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testlog.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/testlog.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/testlog.rpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("PROUZAT3/testlog") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2>> './logs/prouzalib/testlog.rpgle.pgm.error.log'  >> './logs/prouzalib/testlog.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testlog.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/testlog.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/testlog.rpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/testlog.rpgle.pgm'; date > './build/prouzalib/testlog.rpgle.pgm'; echo 'prouzalib/testlog.rpgle.pgm|'`date` >> ./tmp/compiled.txt
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/testlog2.sqlrpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("PROUZAT1/testlog2") SRCSTMF('./prouzalib//qrpglesrc/"testlog2".sqlrpgle') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''./prouzalib/'')')"    2>> './logs/prouzalib/testlog2.sqlrpgle.pgm.error.log'  >> './logs/prouzalib/testlog2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testlog2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/testlog2.sqlrpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/testlog2.sqlrpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("PROUZAT1/testlog2") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2>> './logs/prouzalib/testlog2.sqlrpgle.pgm.error.log'  >> './logs/prouzalib/testlog2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testlog2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/testlog2.sqlrpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/testlog2.sqlrpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/testlog2.sqlrpgle.pgm'; date > './build/prouzalib/testlog2.sqlrpgle.pgm'; echo 'prouzalib/testlog2.sqlrpgle.pgm|'`date` >> ./tmp/compiled.txt
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/testsqlerr.sqlrpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("PROUZAT1/testsqlerr") SRCSTMF('./prouzalib//qrpglesrc/"testsqlerr".sqlrpgle') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''./prouzalib/'')')"    2>> './logs/prouzalib/testsqlerr.sqlrpgle.pgm.error.log'  >> './logs/prouzalib/testsqlerr.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testsqlerr.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/testsqlerr.sqlrpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/testsqlerr.sqlrpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("PROUZAT1/testsqlerr") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2>> './logs/prouzalib/testsqlerr.sqlrpgle.pgm.error.log'  >> './logs/prouzalib/testsqlerr.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/testsqlerr.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/testsqlerr.sqlrpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/testsqlerr.sqlrpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/testsqlerr.sqlrpgle.pgm'; date > './build/prouzalib/testsqlerr.sqlrpgle.pgm'; echo 'prouzalib/testsqlerr.sqlrpgle.pgm|'`date` >> ./tmp/compiled.txt
cat ./logs/*.error.log 2> /dev/null | true
echo -e "\033[102;97mCompile complete\033[0m"
