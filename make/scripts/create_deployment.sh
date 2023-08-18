#!/bin/bash 

# Import global config
source $(dirname $(realpath "$0"))/init.sh

# Undo changes
# git restore -s@ -SW -- build

# get current commit-hash
commit=`git rev-parse HEAD`

# Save all uncommited files
#git stash --include-untracked

#git pull

# Get version from another branch
#git checkout remotes/origin/production -- build

#---git checkout remotes/origin/production


response=$(curl $DEPLOYMENT_UAT_URL/create_deployment/$DEPLOYMENT_UAT_WORKFLOW/$commit)
new_release=$(jq -r '.general.release_branch' <<< $response)
deployment_version=$(jq -r '.general.deploy_version' <<< $response)
project=$(jq -r '.general.project' <<< $response)

echo -e "$COLOR_GREEN Created new deployment $COLOR_END"
echo -e "$COLOR_GREEN Workflow: $DEPLOYMENT_UAT_WORKFLOW $COLOR_END"
echo -e "$COLOR_GREEN Version: $deployment_version $COLOR_END"
echo -e "$COLOR_GREEN Commit: $commit $COLOR_END"
echo -e "$COLOR_GREEN New branch: $new_release $COLOR_END"
echo -e "$COLOR_GREEN $DEPLOYMENT_UAT_URL/show_details/$project/$deployment_version $COLOR_END"

$OS_CMD_2_OPEN_URL $DEPLOYMENT_UAT_URL/show_details/$project/$deployment_version
# Get uncommited files back
#git stash pop
