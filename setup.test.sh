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
  # local FLAG=$1
  cd "$(mktemp -d)"
  npm init -y
  npx $ORIG_DIR $@
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

function force_test {
  CONFIG_FILE=".dependabot/config.yml"
  STRING="overwrite me"
  echo "$STRING" > "$CONFIG_FILE"
  npx $ORIG_DIR -f
  grep "$STRING" "$CONFIG_FILE" && return 1 || echo "OK!"
}

function force_reviewer_test {
  CONFIG_FILE=".dependabot/config.yml"
  REVIEWER="a_reviewer"
  npx $ORIG_DIR -f -r $REVIEWER
  grep "$REVIEWER" "$CONFIG_FILE" && echo "OK!"
}

function reviewer_test {
  CONFIG_FILE=".dependabot/config.yml"
  REVIEWER="a_reviewer"
  setup -r $REVIEWER
  grep "$REVIEWER" "$CONFIG_FILE" && echo "OK!"
}

function reviewer_default_test {
  CONFIG_FILE=".dependabot/config.yml"
  setup -r
  grep "eliasnorrby" "$CONFIG_FILE" && echo "OK!"
}

function help_test {
  npx $ORIG_DIR --help | grep "Usage"
}

setup

common_test

force_test

force_reviewer_test

reviewer_test

reviewer_default_test

help_test
