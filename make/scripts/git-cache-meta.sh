#!/bin/bash -e

#git-cache-meta -- simple file meta data caching and applying.
#Simpler than etckeeper, metastore, setgitperms, etc.
#from http://www.kerneltrap.org/mailarchive/git/2009/1/9/4654694
#modified by n1k
# - save all files metadata not only from other users
# - save numeric uid and gid

# 2012-03-05 - added filetime, andris9

# Import global config
source etc/global.cfg

case $@ in
    --store|--stdout)
    case $1 in --store) exec > $GIT_CACHE_META_FILE; esac
    find $(git ls-files) 2> /dev/null \
        \( -printf 'touch -c -d "%TY-%Tm-%Td %TH:%TM:%TS" '"'"'%p'"'"'\n' \) ;;
    --apply) sh -e $GIT_CACHE_META_FILE;;
    *) 1>&2 echo "Usage: $0 --store|--stdout|--apply"; exit 1;;
esac