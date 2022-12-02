#!/usr/bin/env bash

run() {
  echo "> $@"
  echo

  $@
}

run docker stop learning-deep-learning
