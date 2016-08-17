#!/usr/bin/env bash
#title      :sync_projects.sh
#descripton :Syncs up all your project repositories
#author     :Jason Clark <jay.clark@gmail.com>
#date       :20160816
#version    :0.1
#usage      :./sync_projects.sh
#notes      :Make sure the OS_REPO_DIR is set.
#=================================================
GITHUB_DIR=/Users/jasonclar/Code/Repos/git/github
BITBUCKET_DIR=/Users/jasonclar/Code/Repos/git/bitbucket
PODIO_DIR=/Users/jasonclar/Code/Repos/git/github/podio

# Color settings
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

_run_sync() {
  pushd $1

  git_projects=( $(ls -l | awk '{print $9}') )

  for i in "${git_projects[@]}"; do
    echo "${green}Updating $i...${reset}"

    cd $i

    # http://stackoverflow.com/questions/15316601/in-what-cases-could-git-pull-be-harmful/15316602#15316602
    # A Better Alternative: Use git up instead of git pull
    git remote update -p; git merge --ff-only @{u}; cd ..

  done

  popd
}

if [ -d "$GITHUB_DIR" ]
then
    _run_sync $GITHUB_DIR
else
    echo '${red}Your GitHub directory does not exist. Exiting.${reset}'
    exit 1
fi

if [ -d "$BITBUCKET_DIR" ]
then
    _run_sync $BITBUCKET_DIR
else
    echo '${red}Your BitBucket directory does not exist. Exiting.${reset}'
    exit 1
fi
