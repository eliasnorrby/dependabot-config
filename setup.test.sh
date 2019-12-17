#!/usr/bin/env bash

set -exo pipefail;

ORIG_DIR=$(pwd)
function finish {
  if [ ! $? -eq 0 ] ; then
    echo "There are failing tests"
  else
    echo "All tests passed!"
  fi
  cd "$ORIG_DIR"
}
trap finish EXIT

function setup {
  local FLAG=$1
  cd "$(mktemp -d)"
  npm init -y
  npx $ORIG_DIR $FLAG
  ls -a
}

function common_test {
  CONFIG_DIR=".dependabot"
  echo "'$CONFIG_DIR' should be a directory"
  [ -d "$CONFIG_DIR" ]

  CONFIG_FILE="$CONFIG_DIR/config.yml"
  echo "'$CONFIG_FILE' should exist"
  [ -e "$CONFIG_FILE" ]
}

function help_test {
  npx $ORIG_DIR --help | grep "Usage"
}

setup

common_test

help_test
