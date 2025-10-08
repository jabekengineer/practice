#!/bin/bash

shell_process_name () {
    # in VScode bash and gitbash, $0 returns /usr/bin/bash
    # in WT::Ubuntu, $0 returns -bash, hyphen means it is the login shell
    # these are different because
    echo $0
}