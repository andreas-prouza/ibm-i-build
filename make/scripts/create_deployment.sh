#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh

# Undo changes
# git restore -s@ -SW -- build

# Get version from another branch
git checkout remotes/origin/production -- build


commit=`git rev-parse HEAD`

curl $DEPLOYMENT_URL/$DEPLOYMENT_WORKFLOW/$commit

echo -e "$COLOR_GREEN Created new deployment for workflow: $DEPLOYMENT_WORKFLOW and commit: $commit $COLOR_END"