#!/usr/bin/env bats
# shellcheck source=../concepts/directories.sh
source "$CONCEPTS"/directories.sh


@test "relative and absolute paths result in same destination" {
  cd "$TESTS" && mkdir -p parent/child
  local rel="${TESTS}/parent/child/../child"
  local abs="${TESTS}/parent/child"
  run absolute_relative_cd "$TESTS" "$rel" "$abs"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "$abs" ]
  [ "${lines[1]}" = "$abs" ]
  if [[ -d "$TESTS" ]]; then
    rm -r "${TESTS}"/parent 2>/dev/null || true
  fi
}

@test "cd takes you home" {
  local exp
  local act
  exp=$(cd ~ || exit && pwd);
  act=$(cd && pwd);
  [ "$exp" == "$act" ]
}

@test "navigate to dir with space" {
  bats_require_minimum_version 1.5.0
  local exp
  exp="My Dir"
  mkdir "$exp"
  run -1 bad_navigate_to_space_dir $exp
  [ "$status" -eq 1 ]  # path expansion fails without quotes
  run navigate_to_space_dir "$exp"
  [ "$status" -eq 0 ]

  rm -r My\ Dir # unquoted paths need escape before spaces
}

function symlink_setup() {
  mkdir -p "$DATA" && cd "$DATA" || return 1
  mkdir -p "$1"
}

function symlink_teardown() {
  rm -r "${DATA:?DataDirNotFound}"/*
}
# readlink and realpath utilities help resolve links
@test "cd follows logical paths by default, cd -L preserving symbolic links" {
  local dest="$DATA/actual/actual"
  symlink_setup "$dest"
  ln --symbolic --no-target-directory --force "$dest" src

  run cd_to_sym_and_print_cdL_cd src
  [ "$status" -eq 0 ]
  local cdL_actual="${lines[0]}"
  local cd_actual="${lines[1]}"
  [ "$cdL_actual" == "$cd_actual" ]
  [ "$cdL_actual" == "$DATA/src" ]

  symlink_teardown
}

@test "cd -P, realpath, pwdP all resolve symbolic links" {
  local dest="$DATA/real/physical/actual"
  symlink_setup "$dest"
  ln -s -T -f "$dest" src
  run cd_to_sym_and_print_cdP_realpath_pwdP src
  [ "$status" -eq 0 ]

  local cdP="${lines[0]}"
  local realpath="${lines[1]}"
  local pwdP="${lines[2]}"
  [ "$cdP" == "$dest" ]
  [ "$realpath" == "$dest" ]
  [ "$pwdP" == "$dest" ]

  symlink_teardown
}

@test "cd to bad dir in script-safe way" {

  run script_safe_cd nonexistentDir
  [ "$status" -eq 0 ]
  [ ! "${lines[0]}" ]  # stderr redirected
}


@test "lsa shows . .. while lsA doesnt" {
  # assumes data is empty
  rm -rf "${DATA:?}"/.??* && rm -rf "${DATA:?}"/*
  run capture_lsa_lsA "$DATA"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" == "." ]
  [ "${lines[1]}" == ".." ]
  [ "${#lines[@]}" == 2 ]  # lsA produced now lines of output
}

@test "hidden file or dir starts with ." {
  local dir="$DATA/.hiddenDir"
  mkdir -p "$dir" && touch "$dir/.hiddenFile"

  local should_be_empty
  should_be_empty=$(ls "$dir")
  [ ! "$should_be_empty" ]

  rm -r "$DATA"/.??*
}

@test "Two methods for viewing nested hidden file" {
  local dir="$DATA/.hiddenDir"
  local file=".hiddenFile"
  mkdir -p "$dir" && touch "$dir/$file"


  run show_hidden_file_name_ls_tree_grep_awk "$dir" "$file"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" == "$file" ]
  [ "${lines[1]}" == "$file" ]

  rm -r "$DATA"/.??*
}

@test "Directory count with ls and find" {

  run count_number_of_directories_ls_find "$DATA/.."
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" == 2 ]
  local lsCount="${lines[0]}"
  local findCount="${lines[1]}"
  [ "$lsCount" == "$findCount" ]
}

@test "All linux file type symbols present" {

  run all_linux_file_classifications_present
  [ "$status" -eq 0 ]
  symbols=('/' '*' '|' '=' '@')
  for symbol in "${symbols[@]}"; do
    symbol_found=$(ls -1AF "$DATA" | grep -c "$symbol")
    if [[ ! "$symbol_found" -eq 1 ]]; then
      echo "couldn't find symbol $symbol"
    else
      [ "$symbol_found" -eq 1 ]
    fi
  done

  rm -rf "${DATA:?}"/* && rm -rf "${DATA:?}"/.??*
}


