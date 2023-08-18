#!/bin/bash

rm -rf ./logs/**/*
mkdir -p ./logs/prouzalib
mkdir -p ./logs/prouzalib2
mkdir -p ./build/prouzalib
mkdir -p ./build/prouzalib2
cat ./logs/*.error.log 2> /dev/null | true
echo -e "\033[102;97mCompile complete\033[0m"
