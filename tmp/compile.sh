#!/bin/bash

rm -rf ./logs/**/*
mkdir -p ./logs/prouzalib
mkdir -p ./logs/prouzalib2
mkdir -p ./build/prouzalib
mkdir -p ./build/prouzalib2
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/test.rpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("PROUZAT1/test") SRCSTMF('./prouzalib//qrpglesrc/"test".rpgle') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('./prouzalib/')"    2>> './logs/prouzalib/test.rpgle.pgm.error.log'  >> './logs/prouzalib/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/test.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/test.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/test.rpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("PROUZAT1/test") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2>> './logs/prouzalib/test.rpgle.pgm.error.log'  >> './logs/prouzalib/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/test.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/test.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/test.rpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/test.rpgle.pgm'; date > ./build/prouzalib/test.rpgle.pgm
(   cl "CHGATR OBJ('"'prouzalib//qrpglesrc/§test.rpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  mv prouzalib//qrpglesrc/§test.rpgle $(echo prouzalib//qrpglesrc/§test.rpgle | sed -e 's/'$'\302''//g')
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("PROUZAT3/§test") SRCSTMF('./prouzalib//qrpglesrc/"§test".rpgle') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('./prouzalib/')"    2>> './logs/prouzalib/§test.rpgle.pgm.error.log'  >> './logs/prouzalib/§test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/§test.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/§test.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/§test.rpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("PROUZAT3/§test") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2>> './logs/prouzalib/§test.rpgle.pgm.error.log'  >> './logs/prouzalib/§test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib/§test.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib/§test.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib//qrpglesrc/§test.rpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib/§test.rpgle.pgm'; date > ./build/prouzalib/§test.rpgle.pgm
(   cl "CHGATR OBJ('"'prouzalib2//qrpglesrc/test.rpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("PROUZAT2/test") SRCSTMF('./prouzalib2//qrpglesrc/"test".rpgle') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('./prouzalib2/')"    2>> './logs/prouzalib2/test.rpgle.pgm.error.log'  >> './logs/prouzalib2/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib2/test.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib2/test.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib2//qrpglesrc/test.rpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("PROUZAT2/test") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2>> './logs/prouzalib2/test.rpgle.pgm.error.log'  >> './logs/prouzalib2/test.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib2/test.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib2/test.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib2//qrpglesrc/test.rpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib2/test.rpgle.pgm'; date > ./build/prouzalib2/test.rpgle.pgm
(   cl "CHGATR OBJ('"'prouzalib2//qrpglesrc/test1.rpgle'"') ATR(*CCSID) VALUE(1208)" | iconv -f IBM-1252 -t utf-8 
#  
)
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTRPGMOD MODULE("PROUZAT2/test1") SRCSTMF('./prouzalib2//qrpglesrc/"test1".rpgle') DBGVIEW(*SOURCE) REPLACE(*YES) TGTCCSID(*JOB) INCDIR('./prouzalib2/')"    2>> './logs/prouzalib2/test1.rpgle.pgm.error.log'  >> './logs/prouzalib2/test1.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib2/test1.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib2/test1.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib2//qrpglesrc/test1.rpgle\033[0m' 1>&2
exit 1
fi
( liblist -a PROUZAT1 2> /dev/null; cl  -v  "CRTPGM PGM("PROUZAT2/test1") ACTGRP(PROUZAGRP) REPLACE(*YES) TGTRLS(*CURRENT) STGMDL(*SNGLVL) DETAIL(*BASIC) BNDDIR(*LIBL/PROUZADIR)"    2>> './logs/prouzalib2/test1.rpgle.pgm.error.log'  >> './logs/prouzalib2/test1.rpgle.pgm.splf.log' ; cl -v  "DSPJOBLOG" >> './logs/prouzalib2/test1.rpgle.pgm.joblog.log' )
if [ -s './logs/prouzalib2/test1.rpgle.pgm.error.log' ]; then
echo -e '\033[101;31mfailed: prouzalib2//qrpglesrc/test1.rpgle\033[0m' 1>&2
exit 1
fi && touch './build/prouzalib2/test1.rpgle.pgm'; date > ./build/prouzalib2/test1.rpgle.pgm
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
fi && touch './build/prouzalib/date.sqlrpgle.srvpgm'; date > ./build/prouzalib/date.sqlrpgle.srvpgm
touch ./build/prouzalib/prouzadir.bnddir
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
fi && touch './build/prouzalib/testlog.rpgle.pgm'; date > ./build/prouzalib/testlog.rpgle.pgm
cat ./logs/*.error.log 2> /dev/null | true
echo -e "\033[102;97mCompile complete\033[0m"
