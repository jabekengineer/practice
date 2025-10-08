#!/bin/bash

source ~/practice/bash/tap.sh;

CONCEPT=~/practice/bash/concepts/shell.sh;
source $CONCEPT;
# 1.1 Identify the shell
# invoke shell_type() function from concepts/shell
# expect output to say bash
test_shell_process_name () {
    # should return output of
    actual=$(shell_process_name)
    echo "Actual: $actual"
    # In VSCode, $SHELL environment variable is /bin/bash
    # In WT::Ubuntu, $SHELL is /bin/bash
    expected=$0

    is_equal "$actual" "$expected"
}

# 1.2 Confirm shell profile
# invoke display_profile() function from concepts/shell
# expect output to match whoami@hostname




# main
test_shell_process_name