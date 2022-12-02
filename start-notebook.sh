#!/usr/bin/env bash

run() {
  echo "> $@"
  echo

  $@
}

open_in_browser() {
  url=$(docker logs learning-deep-learning | grep http | head -n1 | sed 's/.*http/http/' | sed 's/.*:8888/http:\/\/dev.local:8888/')

  ssh zrl@host open "'$url'"
}

if [[ $(docker ps | grep learning-deep-learning) ]]; then
  echo "Notebook already running"

  open_in_browser
else
  run docker run --name learning-deep-learning -d -it --rm -p 8888:8888 -v "${PWD}":/home/jovyan jupyter/minimal-notebook

  until [[ $(docker logs learning-deep-learning | grep http) ]];
  do
    sleep 1
  done

  open_in_browser
fi

