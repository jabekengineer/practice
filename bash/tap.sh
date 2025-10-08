#!/usr/bin/env bash

pass() {
    echo "${FUNCNAME[2]} -- Pass"
}

fail() {
    echo "${FUNCNAME[2]} -- Fail"
}

is_equal() {
    actual=$1;
    expected=$2;
    if [ "$actual" == "$expected" ]; then
        echo "Actual $actual"
        echo "Expected $expected"
        pass
        echo
    else
        echo "Actual $actual"
        echo "Expected $expected"
        fail
        echo
    fi
}
