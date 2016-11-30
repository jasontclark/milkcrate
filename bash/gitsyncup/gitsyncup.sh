#!/usr/bin/env bash
#title      :gitsyncup.sh
#descripton :Syncs up all your git projects
#author     :Jay Clark <jay.clark@gmail.com>
#date       :20161027
#version    :0.1
#usage      :./gitsyncup.sh
#notes      :Make sure your .gitsyncuprc file is set.
#====================================================


# Read the gitsyncup config file.
if [ -r ~/.gitsyncuprc ]; then
  echo "Reading user config...." >&2
  . ~/.gitsyncuprc
else
  echo "Error: gitsyncuprc configuration file not found. Copy gitsyncuprc.example to ~/.gitsyncuprc and modify as needed."
  exit 1
fi

# Variables for color settings.
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

run_sync() {
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

run_github_sync() {
  if [ -d "$GITHUB_DIR" ]
  then
      run_sync $GITHUB_DIR
  else
      echo "${red}Your GitHub git directory does not exist. Exiting.${reset}"
      exit 1
  fi
}

run_bitbucket_sync() {
  if [ -d "$BITBUCKET_DIR" ]
  then
      run_sync $BITBUCKET_DIR
  else
      echo "${red}Your BitBucket git directory does not exist. Have you set the directory in your config file? Exiting.${reset}"
      exit 1
  fi
}

run_hyperledger_sync() {
  if [ -d "$HYPERLEDGER_DIR" ]
  then
      run_sync $HYPERLEDGER_DIR
  else
      echo "${red}Your HyperLedger git directory does not exist. Have you set the directory in your config file? Exiting.${reset}"
      exit 1
  fi
}

run_openstack_sync() {
  if [ -d "$OPENSTACK_DIR" ]
  then
      run_sync $OPENSTACK_DIR
  else
      echo "${red}Your OpenStack git directory does not exist. Have you set the directory in your config file? Exiting.${reset}"
      exit 1
  fi
}

run_ibm_sync() {
  if [ -d "$IBM_DIR" ]
  then
      run_sync $IBM_DIR
  else
      echo "${red}Your IBM git directory does not exist. Have you set the directory in your config file? Exiting.${reset}"
      exit 1
  fi
}

run_github_sync
run_bitbucket_sync
run_hyperledger_sync
run_openstack_sync
run_ibm_sync
