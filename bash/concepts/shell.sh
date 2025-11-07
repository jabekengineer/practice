#!/bin/bash

current_process_name() {
  # in VScode bash and gitbash, $0 returns /usr/bin/bash
  # in WT::Ubuntu, the first shell opened in WT $0 returns -bash, hyphen means it is the login shell
  # these are different because $0 just returns the name of the currently running process
  echo "$0"
}

nonlogin_shell_process_name() {
  bash -c 'echo $0'
}

login_shell_process_name() {
  # start shell as a login shell
  # bash --login -c 'echo $0' doesn't actually work
  # true login shell must be invoked by system
  wt.exe
}
