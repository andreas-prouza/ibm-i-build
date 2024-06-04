#!/bin/bash

print_debug() {
 echo "#DEBUG-Remote "`date +"%F %T.%3N"`": "$BASH_COMMAND 
}

trap 'print_debug' DEBUG

cl -v "dspjob"

rm -rf ./logs/*/*/*.log
mkdir -p ./tmp
rm -rf ./tmp/logs
rm -rf ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/testcl.clle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/testcl.clle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testcl.clle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTBNDCL PGM("'BUILD/testcl'")  SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testcl.clle.pgm'"') ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DFTACTGRP(*NO)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTBNDCL PGM("'BUILD/testcl'")  SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testcl.clle.pgm'"') ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DFTACTGRP(*NO)"    2> >(tee -a './logs/build/prouzalib/testcl.clle.pgm.error.log')  >> './logs/build/prouzalib/testcl.clle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testcl.clle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/testcl.clle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/testcl.clle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/testcl.clle.pgm\n\nSpool: './logs/build/prouzalib/testcl.clle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/testcl.clle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/testcl.clle.pgm.obj'; date > './build/build/prouzalib/testcl.clle.pgm.obj'; echo "build/prouzalib/testcl.clle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/testsqlerr.sqlrpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/testsqlerr.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testsqlerr.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'BUILD/testsqlerr'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testsqlerr.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'BUILD/testsqlerr'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testsqlerr.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/testsqlerr.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/testsqlerr'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/testsqlerr'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/testsqlerr.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/testsqlerr.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/testsqlerr.sqlrpgle.pgm.obj'; date > './build/build/prouzalib/testsqlerr.sqlrpgle.pgm.obj'; echo "build/prouzalib/testsqlerr.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/test.rpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/test.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/test.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib/test.rpgle.pgm.error.log')  >> './logs/build/prouzalib/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/test.rpgle.pgm\n\nSpool: './logs/build/prouzalib/test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/test.rpgle.pgm.error.log')  >> './logs/build/prouzalib/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/test.rpgle.pgm\n\nSpool: './logs/build/prouzalib/test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/test.rpgle.pgm.obj'; date > './build/build/prouzalib/test.rpgle.pgm.obj'; echo "build/prouzalib/test.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/#test.rpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/#test.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/#test.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/#test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/#test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/#test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/#test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib/#test.rpgle.pgm.error.log')  >> './logs/build/prouzalib/#test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/#test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/#test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/#test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/#test.rpgle.pgm\n\nSpool: './logs/build/prouzalib/#test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/#test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/#test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/#test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/#test.rpgle.pgm.error.log')  >> './logs/build/prouzalib/#test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/#test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/#test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/#test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/#test.rpgle.pgm\n\nSpool: './logs/build/prouzalib/#test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/#test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/#test.rpgle.pgm.obj'; date > './build/build/prouzalib/#test.rpgle.pgm.obj'; echo "build/prouzalib/#test.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/$test.rpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/$test.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/$test.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/$test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/$test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/$test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/$test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib/$test.rpgle.pgm.error.log')  >> './logs/build/prouzalib/$test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/$test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/$test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/$test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/$test.rpgle.pgm\n\nSpool: './logs/build/prouzalib/$test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/$test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/$test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/$test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/$test.rpgle.pgm.error.log')  >> './logs/build/prouzalib/$test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/$test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/$test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/$test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/$test.rpgle.pgm\n\nSpool: './logs/build/prouzalib/$test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/$test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/$test.rpgle.pgm.obj'; date > './build/build/prouzalib/$test.rpgle.pgm.obj'; echo "build/prouzalib/$test.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/$t§§x#y.rpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/$t§§x#y.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/$t§§x#y.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  mv /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/'$'t§§x\#y.rpgle.pgm $(echo /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/'$'t§§x\#y.rpgle.pgm | sed -e 's/'$'\302''//g')
echo "CRTRPGMOD MODULE("'BUILD/$t§§x#y'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/$t§§x#y.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/$t§§x#y'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/$t§§x#y.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib/$t§§x#y.rpgle.pgm.error.log')  >> './logs/build/prouzalib/$t§§x#y.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/$t§§x#y.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/$t§§x#y.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/$t§§x#y.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/$t§§x#y.rpgle.pgm\n\nSpool: './logs/build/prouzalib/$t§§x#y.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/$t§§x#y.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/$t§§x#y'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/$t§§x#y'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/$t§§x#y.rpgle.pgm.error.log')  >> './logs/build/prouzalib/$t§§x#y.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/$t§§x#y.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/$t§§x#y.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/$t§§x#y.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/$t§§x#y.rpgle.pgm\n\nSpool: './logs/build/prouzalib/$t§§x#y.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/$t§§x#y.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/$t§§x#y.rpgle.pgm.obj'; date > './build/build/prouzalib/$t§§x#y.rpgle.pgm.obj'; echo "build/prouzalib/$t§§x#y.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/file1.pf.file` ; mkdir -p `dirname ./build/build/prouzalib/file1.pf.file` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/file1.pf.file'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
( liblist -a PROUZAT1 2> /dev/null; cl -v  "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; cl -v  "CPYFRMSTMF FROMSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/file1.pf.file'"') TOMBR('/QSYS.LIB/QTEMP.LIB/QSRC.FILE/"'file1'".MBR') MBROPT(*replace)"; cl -v  -q "CRTPF FILE("'BUILD/file1'") SRCFILE(QTEMP/QSRC) SRCMBR("'file1'")" 2> >(tee -a './logs/build/prouzalib/file1.pf.file.error.log')  >> './logs/build/prouzalib/file1.pf.file.splf.log'; cl -v  "CHGPF FILE("'BUILD/file1'") SRCFILE(QTEMP/QSRC) SRCMBR("'file1'")"    2> >(tee -a './logs/build/prouzalib/file1.pf.file.error.log')  >> './logs/build/prouzalib/file1.pf.file.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/file1.pf.file.joblog.log' )
if [ -s './logs/build/prouzalib/file1.pf.file.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/file1.pf.file.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/file1.pf.file\n\nSpool: './logs/build/prouzalib/file1.pf.file.splf.log'\nJoblog: './logs/build/prouzalib/file1.pf.file.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/file1.pf.file.obj'; date > './build/build/prouzalib/file1.pf.file.obj'; echo "build/prouzalib/file1.pf.file.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/testlog2.sqlrpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/testlog2.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testlog2.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'BUILD/testlog2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testlog2.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'BUILD/testlog2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testlog2.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/build/prouzalib/testlog2.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib/testlog2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testlog2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/testlog2.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/testlog2.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/testlog2.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib/testlog2.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/testlog2.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/testlog2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/testlog2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/testlog2.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib/testlog2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testlog2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/testlog2.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/testlog2.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/testlog2.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib/testlog2.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/testlog2.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/testlog2.sqlrpgle.pgm.obj'; date > './build/build/prouzalib/testlog2.sqlrpgle.pgm.obj'; echo "build/prouzalib/testlog2.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm` ; mkdir -p `dirname ./build/build/prouzalib/errhdlsql.sqlrpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/errhdlsql.sqlrpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'BUILD/errhdlsql'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/errhdlsql.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'BUILD/errhdlsql'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/errhdlsql.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"    2> >(tee -a './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/errhdlsql.sqlrpgle.srvpgm\n\nSpool: './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"   2> >(tee -a './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'BUILD/errhdlsql'") MODULE("'BUILD/errhdlsql'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'BUILD/errhdlsql'") MODULE("'BUILD/errhdlsql'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"   2> >(tee -a './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/errhdlsql.sqlrpgle.srvpgm\n\nSpool: './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.obj'; date > './build/build/prouzalib/errhdlsql.sqlrpgle.srvpgm.obj'; echo "build/prouzalib/errhdlsql.sqlrpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/testlog.rpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/testlog.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testlog.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/testlog'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testlog.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/testlog'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testlog.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib/testlog.rpgle.pgm.error.log')  >> './logs/build/prouzalib/testlog.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testlog.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/testlog.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/testlog.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/testlog.rpgle.pgm\n\nSpool: './logs/build/prouzalib/testlog.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/testlog.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/testlog'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/testlog'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/testlog.rpgle.pgm.error.log')  >> './logs/build/prouzalib/testlog.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testlog.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/testlog.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/testlog.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/testlog.rpgle.pgm\n\nSpool: './logs/build/prouzalib/testlog.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/testlog.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/testlog.rpgle.pgm.obj'; date > './build/build/prouzalib/testlog.rpgle.pgm.obj'; echo "build/prouzalib/testlog.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/#test2.rpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/#test2.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/#test2.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/#test2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/#test2.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/#test2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/#test2.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib/#test2.rpgle.pgm.error.log')  >> './logs/build/prouzalib/#test2.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/#test2.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/#test2.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/#test2.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/#test2.rpgle.pgm\n\nSpool: './logs/build/prouzalib/#test2.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/#test2.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/#test2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/#test2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/#test2.rpgle.pgm.error.log')  >> './logs/build/prouzalib/#test2.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/#test2.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/#test2.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/#test2.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/#test2.rpgle.pgm\n\nSpool: './logs/build/prouzalib/#test2.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/#test2.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/#test2.rpgle.pgm.obj'; date > './build/build/prouzalib/#test2.rpgle.pgm.obj'; echo "build/prouzalib/#test2.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/logger.sqlrpgle.srvpgm` ; mkdir -p `dirname ./build/build/prouzalib/logger.sqlrpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/logger.sqlrpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'BUILD/logger'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/logger.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'BUILD/logger'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/logger.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"    2> >(tee -a './logs/build/prouzalib/logger.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/logger.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/logger.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/logger.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/logger.sqlrpgle.srvpgm\n\nSpool: './logs/build/prouzalib/logger.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/logger.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"   2> >(tee -a './logs/build/prouzalib/logger.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/logger.sqlrpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'BUILD/logger'") MODULE("'BUILD/logger'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'BUILD/logger'") MODULE("'BUILD/logger'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/build/prouzalib/logger.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/logger.sqlrpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"   2> >(tee -a './logs/build/prouzalib/logger.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/logger.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/logger.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/logger.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/logger.sqlrpgle.srvpgm\n\nSpool: './logs/build/prouzalib/logger.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/logger.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/logger.sqlrpgle.srvpgm.obj'; date > './build/build/prouzalib/logger.sqlrpgle.srvpgm.obj'; echo "build/prouzalib/logger.sqlrpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/testmod.rpgle.srvpgm` ; mkdir -p `dirname ./build/build/prouzalib/testmod.rpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testmod.rpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/testmod'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testmod.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/testmod'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/testmod.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib/testmod.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testmod.rpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/testmod.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/testmod.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/testmod.rpgle.srvpgm\n\nSpool: './logs/build/prouzalib/testmod.rpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/testmod.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"   2> >(tee -a './logs/build/prouzalib/testmod.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testmod.rpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'BUILD/testmod'") MODULE("'BUILD/testmod'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'BUILD/testmod'") MODULE("'BUILD/testmod'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/build/prouzalib/testmod.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testmod.rpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"   2> >(tee -a './logs/build/prouzalib/testmod.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/testmod.rpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/testmod.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/testmod.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/testmod.rpgle.srvpgm\n\nSpool: './logs/build/prouzalib/testmod.rpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/testmod.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/testmod.rpgle.srvpgm.obj'; date > './build/build/prouzalib/testmod.rpgle.srvpgm.obj'; echo "build/prouzalib/testmod.rpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/errhdlrpg.rpgle.srvpgm` ; mkdir -p `dirname ./build/build/prouzalib/errhdlrpg.rpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/errhdlrpg.rpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/errhdlrpg'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/errhdlrpg.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/errhdlrpg'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/errhdlrpg.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/errhdlrpg.rpgle.srvpgm\n\nSpool: './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlrpg")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlrpg")"   2> >(tee -a './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'BUILD/errhdlrpg'") MODULE("'BUILD/errhdlrpg'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'BUILD/errhdlrpg'") MODULE("'BUILD/errhdlrpg'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlrpg")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlrpg")"   2> >(tee -a './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/errhdlrpg.rpgle.srvpgm\n\nSpool: './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/errhdlrpg.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/errhdlrpg.rpgle.srvpgm.obj'; date > './build/build/prouzalib/errhdlrpg.rpgle.srvpgm.obj'; echo "build/prouzalib/errhdlrpg.rpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/logger_hist.sqltable.file` ; mkdir -p `dirname ./build/build/prouzalib/logger_hist.sqltable.file` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/logger_hist.sqltable.file'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/logger_hist.sqltable.file'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/logger_hist.sqltable.file'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"    2> >(tee -a './logs/build/prouzalib/logger_hist.sqltable.file.error.log')  >> './logs/build/prouzalib/logger_hist.sqltable.file.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/logger_hist.sqltable.file.joblog.log' )
if [ -s './logs/build/prouzalib/logger_hist.sqltable.file.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/logger_hist.sqltable.file.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/logger_hist.sqltable.file\n\nSpool: './logs/build/prouzalib/logger_hist.sqltable.file.splf.log'\nJoblog: './logs/build/prouzalib/logger_hist.sqltable.file.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/logger_hist.sqltable.file.obj'; date > './build/build/prouzalib/logger_hist.sqltable.file.obj'; echo "build/prouzalib/logger_hist.sqltable.file.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'BUILD/cpysrc2ifs'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'BUILD/cpysrc2ifs'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/cpysrc2ifs.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/cpysrc2ifs'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/cpysrc2ifs'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/cpysrc2ifs.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.obj'; date > './build/build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.obj'; echo "build/prouzalib/cpysrc2ifs.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/§test.rpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib/§test.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/§test.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  mv /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/§test.rpgle.pgm $(echo /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/§test.rpgle.pgm | sed -e 's/'$'\302''//g')
echo "CRTRPGMOD MODULE("'BUILD/§test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/§test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/§test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/§test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib/§test.rpgle.pgm.error.log')  >> './logs/build/prouzalib/§test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/§test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/§test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/§test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/§test.rpgle.pgm\n\nSpool: './logs/build/prouzalib/§test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/§test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/§test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/§test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib/§test.rpgle.pgm.error.log')  >> './logs/build/prouzalib/§test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/§test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib/§test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/§test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/§test.rpgle.pgm\n\nSpool: './logs/build/prouzalib/§test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib/§test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/§test.rpgle.pgm.obj'; date > './build/build/prouzalib/§test.rpgle.pgm.obj'; echo "build/prouzalib/§test.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/date.sqlrpgle.srvpgm` ; mkdir -p `dirname ./build/build/prouzalib/date.sqlrpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/date.sqlrpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'BUILD/date'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/date.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'BUILD/date'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/date.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"    2> >(tee -a './logs/build/prouzalib/date.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/date.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/date.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/date.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/date.sqlrpgle.srvpgm\n\nSpool: './logs/build/prouzalib/date.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/date.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"   2> >(tee -a './logs/build/prouzalib/date.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/date.sqlrpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'BUILD/date'") MODULE("'BUILD/date'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'BUILD/date'") MODULE("'BUILD/date'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/build/prouzalib/date.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/date.sqlrpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"   2> >(tee -a './logs/build/prouzalib/date.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/date.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib/date.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/date.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/date.sqlrpgle.srvpgm\n\nSpool: './logs/build/prouzalib/date.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib/date.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/date.sqlrpgle.srvpgm.obj'; date > './build/build/prouzalib/date.sqlrpgle.srvpgm.obj'; echo "build/prouzalib/date.sqlrpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib/logger.sqltable.file` ; mkdir -p `dirname ./build/build/prouzalib/logger.sqltable.file` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/logger.sqltable.file'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/logger.sqltable.file'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib/logger.sqltable.file'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"    2> >(tee -a './logs/build/prouzalib/logger.sqltable.file.error.log')  >> './logs/build/prouzalib/logger.sqltable.file.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib/logger.sqltable.file.joblog.log' )
if [ -s './logs/build/prouzalib/logger.sqltable.file.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib/logger.sqltable.file.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib/logger.sqltable.file\n\nSpool: './logs/build/prouzalib/logger.sqltable.file.splf.log'\nJoblog: './logs/build/prouzalib/logger.sqltable.file.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib/logger.sqltable.file.obj'; date > './build/build/prouzalib/logger.sqltable.file.obj'; echo "build/prouzalib/logger.sqltable.file.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib2/test.rpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib2/test.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/test.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib2/test.rpgle.pgm.error.log')  >> './logs/build/prouzalib2/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/test.rpgle.pgm\n\nSpool: './logs/build/prouzalib2/test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib2/test.rpgle.pgm.error.log')  >> './logs/build/prouzalib2/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/test.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/test.rpgle.pgm\n\nSpool: './logs/build/prouzalib2/test.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib2/test.rpgle.pgm.obj'; date > './build/build/prouzalib2/test.rpgle.pgm.obj'; echo "build/prouzalib2/test.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib2/test1.rpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib2/test1.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/test1.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/test1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/test1.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/test1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/test1.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib2/test1.rpgle.pgm.error.log')  >> './logs/build/prouzalib2/test1.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/test1.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/test1.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/test1.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/test1.rpgle.pgm\n\nSpool: './logs/build/prouzalib2/test1.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/test1.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/test1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/test1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib2/test1.rpgle.pgm.error.log')  >> './logs/build/prouzalib2/test1.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/test1.rpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/test1.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/test1.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/test1.rpgle.pgm\n\nSpool: './logs/build/prouzalib2/test1.rpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/test1.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib2/test1.rpgle.pgm.obj'; date > './build/build/prouzalib2/test1.rpgle.pgm.obj'; echo "build/prouzalib2/test1.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm` ; mkdir -p `dirname ./build/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'BUILD/sqlsrv1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'BUILD/sqlsrv1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"    2> >(tee -a './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm\n\nSpool: './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqlsrv1")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqlsrv1")"   2> >(tee -a './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'BUILD/sqlsrv1'") MODULE("'BUILD/sqlsrv1'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'BUILD/sqlsrv1'") MODULE("'BUILD/sqlsrv1'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqlsrv1")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqlsrv1")"   2> >(tee -a './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.error.log')  >> './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm\n\nSpool: './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.obj'; date > './build/build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.obj'; echo "build/prouzalib2/sqlsrv1.sqlrpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib2/sqltest1.sqlproc.pgm` ; mkdir -p `dirname ./build/build/prouzalib2/sqltest1.sqlproc.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest1.sqlproc.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest1.sqlproc.pgm'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest1.sqlproc.pgm'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"    2> >(tee -a './logs/build/prouzalib2/sqltest1.sqlproc.pgm.error.log')  >> './logs/build/prouzalib2/sqltest1.sqlproc.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest1.sqlproc.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqltest1.sqlproc.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqltest1.sqlproc.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqltest1.sqlproc.pgm\n\nSpool: './logs/build/prouzalib2/sqltest1.sqlproc.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqltest1.sqlproc.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib2/sqltest1.sqlproc.pgm.obj'; date > './build/build/prouzalib2/sqltest1.sqlproc.pgm.obj'; echo "build/prouzalib2/sqltest1.sqlproc.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib2/sqltest2.sqlrpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib2/sqltest2.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest2.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'BUILD/sqltest2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest2.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'BUILD/sqltest2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest2.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqltest2.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/sqltest2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/sqltest2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqltest2.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqltest2.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib2/sqltest2.sqlrpgle.pgm.obj'; date > './build/build/prouzalib2/sqltest2.sqlrpgle.pgm.obj'; echo "build/prouzalib2/sqltest2.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib2/sqltest3.rpgle.srvpgm` ; mkdir -p `dirname ./build/build/prouzalib2/sqltest3.rpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest3.rpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'BUILD/sqltest3'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest3.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'BUILD/sqltest3'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest3.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/build/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqltest3.rpgle.srvpgm\n\nSpool: './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqltest3")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqltest3")"   2> >(tee -a './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'BUILD/sqltest3'") MODULE("'BUILD/sqltest3'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'BUILD/sqltest3'") MODULE("'BUILD/sqltest3'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqltest3")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqltest3")"   2> >(tee -a './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.error.log')  >> './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqltest3.rpgle.srvpgm\n\nSpool: './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqltest3.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib2/sqltest3.rpgle.srvpgm.obj'; date > './build/build/prouzalib2/sqltest3.rpgle.srvpgm.obj'; echo "build/prouzalib2/sqltest3.rpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib2/sqltest1.sqlrpgle.pgm` ; mkdir -p `dirname ./build/build/prouzalib2/sqltest1.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest1.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'BUILD/sqltest1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest1.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'BUILD/sqltest1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest1.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/build/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqltest1.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'BUILD/sqltest1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'BUILD/sqltest1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.error.log')  >> './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqltest1.sqlrpgle.pgm\n\nSpool: './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqltest1.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib2/sqltest1.sqlrpgle.pgm.obj'; date > './build/build/prouzalib2/sqltest1.sqlrpgle.pgm.obj'; echo "build/prouzalib2/sqltest1.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib2/sqltest2.sqlproc.pgm` ; mkdir -p `dirname ./build/build/prouzalib2/sqltest2.sqlproc.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest2.sqlproc.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest2.sqlproc.pgm'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqltest2.sqlproc.pgm'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"    2> >(tee -a './logs/build/prouzalib2/sqltest2.sqlproc.pgm.error.log')  >> './logs/build/prouzalib2/sqltest2.sqlproc.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqltest2.sqlproc.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqltest2.sqlproc.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqltest2.sqlproc.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqltest2.sqlproc.pgm\n\nSpool: './logs/build/prouzalib2/sqltest2.sqlproc.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqltest2.sqlproc.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib2/sqltest2.sqlproc.pgm.obj'; date > './build/build/prouzalib2/sqltest2.sqlproc.pgm.obj'; echo "build/prouzalib2/sqltest2.sqlproc.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/build/prouzalib2/sqlsrv1.sqlproc.pgm` ; mkdir -p `dirname ./build/build/prouzalib2/sqlsrv1.sqlproc.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqlsrv1.sqlproc.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqlsrv1.sqlproc.pgm'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/build/prouzalib2/sqlsrv1.sqlproc.pgm'"') DFTRDBCOL(BUILD) COMMIT(*NONE) ERRLVL(21)"    2> >(tee -a './logs/build/prouzalib2/sqlsrv1.sqlproc.pgm.error.log')  >> './logs/build/prouzalib2/sqlsrv1.sqlproc.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/build/prouzalib2/sqlsrv1.sqlproc.pgm.joblog.log' )
if [ -s './logs/build/prouzalib2/sqlsrv1.sqlproc.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/build/prouzalib2/sqlsrv1.sqlproc.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//build/prouzalib2/sqlsrv1.sqlproc.pgm\n\nSpool: './logs/build/prouzalib2/sqlsrv1.sqlproc.pgm.splf.log'\nJoblog: './logs/build/prouzalib2/sqlsrv1.sqlproc.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/build/prouzalib2/sqlsrv1.sqlproc.pgm.obj'; date > './build/build/prouzalib2/sqlsrv1.sqlproc.pgm.obj'; echo "build/prouzalib2/sqlsrv1.sqlproc.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/testsqlerr'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/testsqlerr'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/testsqlerr'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/testsqlerr'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/testsqlerr.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/test.rpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/test.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/test.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/test.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/test.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/test.rpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/test.rpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/test.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/errhdlsqlp'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/errhdlsqlp'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/errhdlsqlp'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/errhdlsqlp'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/errhdlsqlp.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/§test1.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/§test1.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  mv /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/§test1.rpgle.pgm $(echo /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/§test1.rpgle.pgm | sed -e 's/'$'\302''//g')
echo "CRTRPGMOD MODULE("'SRC/§test1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/§test1.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/§test1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/§test1.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/§test1.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/§test1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/§test1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/§test1.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/§test1.rpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/§test1.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  mv /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/'$'t§§x\#y.rpgle.pgm $(echo /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/'$'t§§x\#y.rpgle.pgm | sed -e 's/'$'\302''//g')
echo "CRTRPGMOD MODULE("'SRC/$t§§x#y'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/$t§§x#y'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/$t§§x#y'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/$t§§x#y'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/$t§§x#y.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/testlog2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/testlog2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/testlog2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/testlog2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/testlog2.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/$test11.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/$test11.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/$test11'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/$test11.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/$test11'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/$test11.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/$test11.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/$test11'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/$test11'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/$test11.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/$test11.rpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/$test11.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/errhdlsql'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/errhdlsql'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'SRC/errhdlsql'") MODULE("'SRC/errhdlsql'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'SRC/errhdlsql'") MODULE("'SRC/errhdlsql'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlsql")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj'; date > './build/src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj'; echo "src/prouzalib/qrpglesrc/errhdlsql.sqlrpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/testlog.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testlog.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/testlog'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testlog.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/testlog'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testlog.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/testlog.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/testlog'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/testlog'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/testlog.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/testlog.rpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/testlog.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/#test2.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/#test2.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/#test2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/#test2.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/#test2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/#test2.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/#test2.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/#test2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/#test2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/#test2.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/#test2.rpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/#test2.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/#test3.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/#test3.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/#test3'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/#test3.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/#test3'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/#test3.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/#test3.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/#test3'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/#test3'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/#test3.rpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/#test3.rpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/#test3.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/logger'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/logger'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'SRC/logger'") MODULE("'SRC/logger'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'SRC/logger'") MODULE("'SRC/logger'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/logger")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj'; date > './build/src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj'; echo "src/prouzalib/qrpglesrc/logger.sqlrpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/testmod'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/testmod'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'SRC/testmod'") MODULE("'SRC/testmod'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'SRC/testmod'") MODULE("'SRC/testmod'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/testmod")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.obj'; date > './build/src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.obj'; echo "src/prouzalib/qrpglesrc/testmod.rpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/errhdlrpg'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/errhdlrpg'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlrpg")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlrpg")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'SRC/errhdlrpg'") MODULE("'SRC/errhdlrpg'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'SRC/errhdlrpg'") MODULE("'SRC/errhdlrpg'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlrpg")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/errhdlrpg")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.obj'; date > './build/src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.obj'; echo "src/prouzalib/qrpglesrc/errhdlrpg.rpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/cpysrc2ifs'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/cpysrc2ifs'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/cpysrc2ifs'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/cpysrc2ifs'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.obj'; date > './build/src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.obj'; echo "src/prouzalib/qrpglesrc/cpysrc2ifs.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm` ; mkdir -p `dirname ./build/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/date'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/date'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'SRC/date'") MODULE("'SRC/date'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'SRC/date'") MODULE("'SRC/date'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/date")"   2> >(tee -a './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm\n\nSpool: './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.obj'; date > './build/src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.obj'; echo "src/prouzalib/qrpglesrc/date.sqlrpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qsqlsrc/lager_hist.sqltable.file` ; mkdir -p `dirname ./build/src/prouzalib/qsqlsrc/lager_hist.sqltable.file` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qsqlsrc/lager_hist.sqltable.file'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qsqlsrc/lager_hist.sqltable.file'"') DFTRDBCOL(SRC) COMMIT(*NONE) ERRLVL(21)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qsqlsrc/lager_hist.sqltable.file'"') DFTRDBCOL(SRC) COMMIT(*NONE) ERRLVL(21)"    2> >(tee -a './logs/src/prouzalib/qsqlsrc/lager_hist.sqltable.file.error.log')  >> './logs/src/prouzalib/qsqlsrc/lager_hist.sqltable.file.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qsqlsrc/lager_hist.sqltable.file.joblog.log' )
if [ -s './logs/src/prouzalib/qsqlsrc/lager_hist.sqltable.file.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qsqlsrc/lager_hist.sqltable.file.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qsqlsrc/lager_hist.sqltable.file\n\nSpool: './logs/src/prouzalib/qsqlsrc/lager_hist.sqltable.file.splf.log'\nJoblog: './logs/src/prouzalib/qsqlsrc/lager_hist.sqltable.file.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qsqlsrc/lager_hist.sqltable.file.obj'; date > './build/src/prouzalib/qsqlsrc/lager_hist.sqltable.file.obj'; echo "src/prouzalib/qsqlsrc/lager_hist.sqltable.file.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qsqlsrc/lager.sqltable.file` ; mkdir -p `dirname ./build/src/prouzalib/qsqlsrc/lager.sqltable.file` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qsqlsrc/lager.sqltable.file'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qsqlsrc/lager.sqltable.file'"') DFTRDBCOL(SRC) COMMIT(*NONE) ERRLVL(21)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qsqlsrc/lager.sqltable.file'"') DFTRDBCOL(SRC) COMMIT(*NONE) ERRLVL(21)"    2> >(tee -a './logs/src/prouzalib/qsqlsrc/lager.sqltable.file.error.log')  >> './logs/src/prouzalib/qsqlsrc/lager.sqltable.file.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qsqlsrc/lager.sqltable.file.joblog.log' )
if [ -s './logs/src/prouzalib/qsqlsrc/lager.sqltable.file.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qsqlsrc/lager.sqltable.file.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qsqlsrc/lager.sqltable.file\n\nSpool: './logs/src/prouzalib/qsqlsrc/lager.sqltable.file.splf.log'\nJoblog: './logs/src/prouzalib/qsqlsrc/lager.sqltable.file.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qsqlsrc/lager.sqltable.file.obj'; date > './build/src/prouzalib/qsqlsrc/lager.sqltable.file.obj'; echo "src/prouzalib/qsqlsrc/lager.sqltable.file.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qsqlsrc/logger.sqltable.file` ; mkdir -p `dirname ./build/src/prouzalib/qsqlsrc/logger.sqltable.file` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qsqlsrc/logger.sqltable.file'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qsqlsrc/logger.sqltable.file'"') DFTRDBCOL(SRC) COMMIT(*NONE) ERRLVL(21)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "RUNSQLSTM SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qsqlsrc/logger.sqltable.file'"') DFTRDBCOL(SRC) COMMIT(*NONE) ERRLVL(21)"    2> >(tee -a './logs/src/prouzalib/qsqlsrc/logger.sqltable.file.error.log')  >> './logs/src/prouzalib/qsqlsrc/logger.sqltable.file.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qsqlsrc/logger.sqltable.file.joblog.log' )
if [ -s './logs/src/prouzalib/qsqlsrc/logger.sqltable.file.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qsqlsrc/logger.sqltable.file.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qsqlsrc/logger.sqltable.file\n\nSpool: './logs/src/prouzalib/qsqlsrc/logger.sqltable.file.splf.log'\nJoblog: './logs/src/prouzalib/qsqlsrc/logger.sqltable.file.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qsqlsrc/logger.sqltable.file.obj'; date > './build/src/prouzalib/qsqlsrc/logger.sqltable.file.obj'; echo "src/prouzalib/qsqlsrc/logger.sqltable.file.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qcllesrc/testcl.clle.pgm` ; mkdir -p `dirname ./build/src/prouzalib/qcllesrc/testcl.clle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qcllesrc/testcl.clle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTBNDCL PGM("'SRC/testcl'")  SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qcllesrc/testcl.clle.pgm'"') ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DFTACTGRP(*NO)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTBNDCL PGM("'SRC/testcl'")  SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qcllesrc/testcl.clle.pgm'"') ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DFTACTGRP(*NO)"    2> >(tee -a './logs/src/prouzalib/qcllesrc/testcl.clle.pgm.error.log')  >> './logs/src/prouzalib/qcllesrc/testcl.clle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qcllesrc/testcl.clle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib/qcllesrc/testcl.clle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qcllesrc/testcl.clle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qcllesrc/testcl.clle.pgm\n\nSpool: './logs/src/prouzalib/qcllesrc/testcl.clle.pgm.splf.log'\nJoblog: './logs/src/prouzalib/qcllesrc/testcl.clle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qcllesrc/testcl.clle.pgm.obj'; date > './build/src/prouzalib/qcllesrc/testcl.clle.pgm.obj'; echo "src/prouzalib/qcllesrc/testcl.clle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib/qddssrc/file1.pf.file` ; mkdir -p `dirname ./build/src/prouzalib/qddssrc/file1.pf.file` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qddssrc/file1.pf.file'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
( liblist -a PROUZAT1 2> /dev/null; cl -v  "CRTSRCPF FILE(QTEMP/QSRC) RCDLEN(112)"; cl -v  "CPYFRMSTMF FROMSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib/qddssrc/file1.pf.file'"') TOMBR('/QSYS.LIB/QTEMP.LIB/QSRC.FILE/"'file1'".MBR') MBROPT(*replace)"; cl -v  -q "CRTPF FILE("'SRC/file1'") SRCFILE(QTEMP/QSRC) SRCMBR("'file1'")" 2> >(tee -a './logs/src/prouzalib/qddssrc/file1.pf.file.error.log')  >> './logs/src/prouzalib/qddssrc/file1.pf.file.splf.log'; cl -v  "CHGPF FILE("'SRC/file1'") SRCFILE(QTEMP/QSRC) SRCMBR("'file1'")"    2> >(tee -a './logs/src/prouzalib/qddssrc/file1.pf.file.error.log')  >> './logs/src/prouzalib/qddssrc/file1.pf.file.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib/qddssrc/file1.pf.file.joblog.log' )
if [ -s './logs/src/prouzalib/qddssrc/file1.pf.file.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib/qddssrc/file1.pf.file.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib/qddssrc/file1.pf.file\n\nSpool: './logs/src/prouzalib/qddssrc/file1.pf.file.splf.log'\nJoblog: './logs/src/prouzalib/qddssrc/file1.pf.file.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib/qddssrc/file1.pf.file.obj'; date > './build/src/prouzalib/qddssrc/file1.pf.file.obj'; echo "src/prouzalib/qddssrc/file1.pf.file.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib2/qrpglesrc/test.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/test.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib2/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/test'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/test.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib2/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/test.rpgle.pgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/test'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/test.rpgle.pgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/test.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib2/qrpglesrc/test.rpgle.pgm.obj'; date > './build/src/prouzalib2/qrpglesrc/test.rpgle.pgm.obj'; echo "src/prouzalib2/qrpglesrc/test.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib2/qrpglesrc/test1.rpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/test1.rpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/test1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/test1.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib2/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/test1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/test1.rpgle.pgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib2/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/test1.rpgle.pgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/test1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/test1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/test1.rpgle.pgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.obj'; date > './build/src/prouzalib2/qrpglesrc/test1.rpgle.pgm.obj'; echo "src/prouzalib2/qrpglesrc/test1.rpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm` ; mkdir -p `dirname ./build/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/sqlsrv1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib2/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/sqlsrv1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib2/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'')')"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqlsrv1")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqlsrv1")"   2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'SRC/sqlsrv1'") MODULE("'SRC/sqlsrv1'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'SRC/sqlsrv1'") MODULE("'SRC/sqlsrv1'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqlsrv1")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqlsrv1")"   2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.obj'; date > './build/src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.obj'; echo "src/prouzalib2/qrpglesrc/sqlsrv1.sqlrpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/sqltest2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib2/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/sqltest2'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib2/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/sqltest2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/sqltest2'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.obj'; date > './build/src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.obj'; echo "src/prouzalib2/qrpglesrc/sqltest2.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm` ; mkdir -p `dirname ./build/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTRPGMOD MODULE("'SRC/sqltest3'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib2/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("'SRC/sqltest3'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm'"') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('/home/prouzat1/ibm-i-build/src/src/prouzalib2/' '/home/prouzat1/ibm-i-build/src/prouzalib/' '/home/prouzat1/ibm-i-build/src')"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi
echo "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqltest3")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  -q "RMVBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqltest3")"   2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.joblog.log' )
echo "CRTSRVPGM SRVPGM("'SRC/sqltest3'") MODULE("'SRC/sqltest3'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSRVPGM SRVPGM("'SRC/sqltest3'") MODULE("'SRC/sqltest3'") EXPORT(*ALL) ACTGRP(PROUZAGRP) BNDDIR(*LIBL/PROUZADIR) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL)"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.joblog.log' )
echo "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqltest3")"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "ADDBNDDIRE BNDDIR(*LIBL/PROUZADIR) OBJ("*LIBL/sqltest3")"   2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.obj'; date > './build/src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.obj'; echo "src/prouzalib2/qrpglesrc/sqltest3.rpgle.srvpgm.obj|"`date` >> ./tmp/compiled.txt
mkdir -p `dirname ./logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm` ; mkdir -p `dirname ./build/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm` 
cl -v  "CHGATR OBJ('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
echo "CRTSQLRPGI OBJ("'SRC/sqltest1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib2/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTSQLRPGI OBJ("'SRC/sqltest1'") SRCSTMF('"'/home/prouzat1/ibm-i-build/src/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm'"') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) TGTRLS(*CURRENT) DBGVIEW(*SOURCE) REPLACE(*YES) COMPILEOPT('TGTCCSID(*JOB) INCDIR(''/home/prouzat1/ibm-i-build/src/src/prouzalib2/'' ''/home/prouzat1/ibm-i-build/src/prouzalib/'' ''/home/prouzat1/ibm-i-build/src'') PPMINOUTLN(500)')"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi
echo "CRTPGM PGM("'SRC/sqltest1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("'SRC/sqltest1'") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2> >(tee -a './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.error.log')  >> './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.joblog.log' )
if [ -s './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.error.log' ]; then
echo -en "\033[101;31m$(cat './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.error.log')\033[0m" 1>&2
echo    '\n\nSource: /home/andreas/projekte/opensource/ibm-i-build/make/..//src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm\n\nSpool: './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.splf.log'\nJoblog: './logs/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.joblog.log'' 1>&2
exit 1
fi && touch './build/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.obj'; date > './build/src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.obj'; echo "src/prouzalib2/qrpglesrc/sqltest1.sqlrpgle.pgm.obj|"`date` >> ./tmp/compiled.txt
cat ./logs/*.error.log 2> /dev/null | true
echo -e "\033[102;97mCompile complete\033[0m"
