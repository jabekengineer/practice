#!/bin/bash

source ~/practice/bash/tap.sh;

CONCEPT=~/practice/bash/concepts/shell.sh;
source $CONCEPT;
# 1.1 Identify the shell
# invoke shell_type() function from concepts/shell
# expect output to say bash
test_current_process_name () {
    # should return output of ~/bash/tests/test_shell.sh
    actual=$(current_process_name)
    # In VSCode, $SHELL environment variable is /bin/bash while $0 is /usr/bin/bash
    # In WT::Ubuntu, $SHELL is /bin/bash
    expected=$0

    is_equal "$actual" "$expected"
}

test_nonlogin_shell_process_name () {
    actual=$(nonlogin_shell_process_name)
    expected="bash"

    is_equal "$actual" "$expected"
}

test_login_shell_process_name () {
    echo "== Manual test =="
    echo "In new windows terminal type echo \$0"
    login_shell_process_name
    echo -n "What did echo \$0 produce? "
    read actual

    expected="-bash"
    is_equal "$actual" "$expected"
}

# 1.2 Confirm shell profile
# invoke display_profile() function from concepts/shell
# expect output to match whoami@hostname




# main
test_current_process_name
test_nonlogin_shell_process_name
test_login_shell_process_name