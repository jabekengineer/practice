#!/bin/bash

if [[ -z ${1} ]]; then
  echo "Must provide tool folder name"
  exit 1
fi

tool=${1}
DIR=~/practice/${tool}

# confirm override of existing dir
if [[ -d $DIR ]]; then
  echo -e "Directory exists already here are its contents: "
  tree "$DIR"
  read -p "Remake dir? (Y/N): " confirm

  if [[ "$confirm" =~ ^[nN][oO]?$ ]]; then
    exit 0
  fi

  if [[ $confirm =~ ^[yY]([eE][sS])?$ ]]; then
    rm -rf "$DIR"
  fi
fi

# path doesn't exist
echo "Setting up tooldir: ${DIR}"
mkdir "$DIR"
cd "$DIR"
mkdir concepts
touch concepts/single-concept.file
mkdir scripts
touch scripts/build-and-test.sh
mkdir tests
touch tests/single-concept-test.file
mkdir .devcontainer
touch .devcontainer/devcontainer.json
touch .devcontainer/Dockerfile
touch README.md
tree "$DIR"
echo "All done! ✌️"
