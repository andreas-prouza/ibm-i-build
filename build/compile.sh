#!/bin/bash

rm -rf ./logs/**/*
mkdir -p ./logs/prouzalib
mkdir -p ./logs/prouzalib2
mkdir -p ./build/prouzalib
mkdir -p ./build/prouzalib2
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
cat ./logs/*.error.log 2> /dev/null | true
echo -e "\033[102;97mCompile complete\033[0m"
