#!/usr/bin/env bash

absolute_relative_cd() {
  initDir="$1"
  absPath="$2"
  relPath="$3"
  cd "$initDir" || return 1
  absRes=$(
    cd "$absPath" || return 1
    pwd
  )
  relRes=$(
    cd "$relPath" || return 1
    pwd
  )
  echo "$absRes"
  echo "$relRes"
  return 0
}

bad_navigate_to_space_dir() {
  spaceDir=$1
  cd $spaceDir || return 1
}

navigate_to_space_dir() {
  spaceDir="$1"
  cd "$spaceDir" || return 1
  pwd
  return 0
}
# these shoudl be the same
cd_to_sym_and_print_cdL_cd() {
  sym=$1
  l_act=$(cd -L "$sym" && pwd)
  d_act=$(cd "$sym" && pwd)
  echo "$l_act"
  echo "$d_act"
}

cd_to_sym_and_print_cdP_realpath_pwdP() {
  # given a path, resolve all symlinks in it
  sym=$1
  rp=$(realpath "$sym" || return 1)
  echo "$rp"
  cdP=$(cd -P "$sym" || return 1 && pwd)
  echo "$cdP"
  pwdP=$(cd "$sym" || return 1 && pwd -P)
  echo "$pwdP"
}

script_safe_cd() {
  dir=$1
  cd "$dir" 2>/dev/null || true
}

capture_lsa_lsA() {
  emptyDir=$1
  cd "$emptyDir" || return 1
  ls --format=single-column --all
  ls -1A  # almost-all
}

show_hidden_file_name_ls_tree_grep_awk() {
  dir=$1
  name=$2
  # print the last field or column of each line of input
  ls -1AR "$dir" | grep "$name" | awk '{print $NF}'
  tree -a "$dir" | grep "$name" | awk '{print $NF}'
}

count_number_of_directories_ls_find() {
  cd "$1" || return 1
  ls -1AF | grep -c /
  find . -mindepth 1 -maxdepth 1 -type d | wc -l
}

all_linux_file_classifications_present() {
  # executable *
  touch "$DATA/exec" && chmod +x "$DATA/exec"
  # directory /
  mkdir "$DATA/dir"
  # symlink @
  ln -s -T "$DATA/dir" "$DATA/sym"
  # named pipe/fifo |
  mkfifo "$DATA/pipe"
  # socket =
  local p="$DATA/sock"
  rm -f "$p"
  python3 - "$p" <<-'PY'
import os, socket, sys
p = sys.argv[1]
try: os.unlink(p)
except FileNotFoundError: pass
s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.bind(p)          # creates the socket file
s.close()          # node remains
PY
}
