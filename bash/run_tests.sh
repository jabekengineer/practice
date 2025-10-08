#!/bin/bash

chmod +x tap.sh

CONCEPT=$1;

TEST_PATH=~/practice/bash/tests/test_$CONCEPT.sh;
chmod +x $TEST_PATH;
$TEST_PATH;