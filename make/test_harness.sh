#!/bin/bash

pass() {
    echo "PASS"
}

fail() {
    echo "FAIL"
}

file_exists() {
    path=$1
    echo $path should exist
    if [ -f "$path" ]; then
        pass
    else
        fail
    fi
}

equals() {
    actual=$1
    expected=$2
    echo $actual should equal $expected
    if [ $1 == $2 ]; then
        pass
    else
        fail
    fi
}

a_greater_than_b() {
    a=$1
    b=$2
    echo $a should be greater than $b
    if [ $a -gt $b ]; then
        pass
    else
        fail
    fi
}