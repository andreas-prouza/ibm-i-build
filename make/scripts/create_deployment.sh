#!/bin/bash 

set -x

# Import global config
source $(dirname $(realpath "$0"))/init.sh


git_checkout_release_branch () {

  branch =$(git rev-parse --verify $1)
  if [ $branch != '' ]; then
    git checkout $1
    exit 0
  fi

  echo "Create new branch"
  git checkout -b $1 $2
  git push --set-upstream origin $1

}

# Undo changes
# git restore -s@ -SW -- build

# get current commit-hash
current_branch=`git rev-parse --abbrev-ref HEAD`
current_commit=`git rev-parse HEAD`

# Save all uncommited files
git stash --include-untracked

git pull

# Get version from another branch
#git checkout remotes/origin/production -- build

git checkout production

#-----------------------------------------
# First create a new deployment
#-----------------------------------------
response=$(curl $DEPLOYMENT_UAT_URL/create_deployment/$DEPLOYMENT_UAT_WORKFLOW/$current_commit)
new_release=$(jq -r '.general.release_branch' <<< $response)
deployment_version=$(jq -r '.general.deploy_version' <<< $response)
project=$(jq -r '.general.project' <<< $response)

echo -e "$COLOR_GREEN Created new deployment $COLOR_END"
echo -e "$COLOR_GREEN Workflow: $DEPLOYMENT_UAT_WORKFLOW $COLOR_END"
echo -e "$COLOR_GREEN Version: $deployment_version $COLOR_END"
echo -e "$COLOR_GREEN Commit: $current_commit $COLOR_END"
echo -e "$COLOR_GREEN New branch: $new_release $COLOR_END"
echo -e "$COLOR_GREEN $DEPLOYMENT_UAT_URL/show_details/$project/$deployment_version $COLOR_END"

#-----------------------------------------
# Create a release branch based on current commit for that deplyoment
#-----------------------------------------

git_checkout_release_branch $new_release $current_commit


echo "Get commit hash of release branch"
new_release_commit=$(git show-ref --verify refs/remotes/origin/$new_release | cut -d " " -f1)

echo "Check if commit hash ist the same"
if [ "$new_release_commit" != "$current_commit" ]; then
  echo -e "$COLOR_RED Commit of branch $new_release ($new_release_commit) does not match current commit ($current_commit) $COLOR_END"
  git checkout $current_branch
  git stash pop
  exit 1
fi

#-----------------------------------------
# Create compile script
#-----------------------------------------

echo "Create object list"
make/scripts/create_build_script.sh create-object-list

echo "Create compile script"
make/scripts/create_build_script.sh default

git add .
git commit -m "Object list & build script created"
git push

#-----------------------------------------
# Open deplyoment
#-----------------------------------------


$OS_CMD_2_OPEN_URL $DEPLOYMENT_UAT_URL/show_details/$project/$deployment_version

#-----------------------------------------
# Restore workspace
#-----------------------------------------

echo "Restore workspace"

# Get uncommited files back
git checkout $current_branch
git stash pop