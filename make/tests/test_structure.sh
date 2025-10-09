#!/bin/bash

source /workspaces/practice/make/test_harness.sh

conceptDir=/workspaces/practice/make/concepts/structure
executable_is_created() {
    # setup
    # nonexistent dependencies are recreated too!
    rm -f $conceptDir/executable dep*
    cd $conceptDir
    make executable
    file_exists $conceptDir/executable
}

# the file system is make's cache (targets can't be older than deps)
executable_mtimes_correct() {
    # setup
    # command group to capture multiple mtimes
    # process substitution -- < <(...) is a redirects temporary FIFO
    cd $conceptDir && make executable
    { read -r mtime1_act; read -r mtime2_act; } < <($conceptDir/executable.sh)

    mtime1_exp=$(stat -c %Y $conceptDir/dep1)
    mtime2_exp=$(stat -c %Y $conceptDir/dep2)

    equals $mtime1_act $mtime1_exp
    equals $mtime2_act $mtime2_exp
}

touch_triggers_rebuild() {
    mtimeExec_older=$(stat -c %Y $conceptDir/executable)
    sleep 1
    touch $conceptDir/dep1
    cd $conceptDir && make executable
    mtimeExec_newer=$(stat -c %Y $conceptDir/executable)

    a_greater_than_b $mtimeExec_newer $mtimeExec_older
}


# main
executable_is_created
executable_mtimes_correct
touch_triggers_rebuild
