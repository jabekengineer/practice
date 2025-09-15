#!/bin/bash

docker build \
    --check \
    -f ~/practice/docker/concepts/BeforeFrom.Dockerfile \
    ~/practice/docker

exit_code=$?

if [ $exit_code -eq 0 ]; then
    echo $'\e[32m'Directives, Comments, Build-Args are valid$'\e[0m'
else
    echo $'\e[31m'problem!$'\e[0m'
fi