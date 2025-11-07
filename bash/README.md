# Bash learning loop

Specifically focusing on the linux command line, practice one concept at a time.

1. Plan the learning.
2. Write the tests.
3. Write the concept file with demo.


## Navigating the shell
[*] identify the shell

## Navigating the File System Tree

### cd - Directory Navigation, pwd - Present Working Directory

- [*] Goal: Prove cd handles absolute vs relative paths correctly. Test idea: Assert `pwd` output after `cd /tmp` vs `cd ../tmp`.
- [*] Goal: Verify cd without args goes to $HOME. Test idea: Compare `pwd` after bare `cd` with `echo $HOME`.
- [*] Goal: Handle directories with spaces in names. Test idea: Create dir with spaces, cd to it, verify with `pwd`.
- [*] Goal: Understand `-L` follows symlinks logically. Test idea: Create symlink chain, use `cd -L`, compare `pwd` vs `pwd -P`.
- [*] Goal: Understand `-P` resolves symlinks physically. Test idea: Same symlink setup, use `cd -P`, verify physical path.
- [*] Goal: Handle permission denied errors gracefully. Test idea: Create restricted dir, test `cd` exit code and stderr.

### ls - List Directory Contents

- [*] Goal: Show almost all files (exclude . and ..). Test idea: Compare `ls -A` vs `ls -a` output in populated directory.
- [*] Goal: Two methods for viewing nested file. Test idea: Pipe `ls -R` and `tree -a` to `grep .hidden`
- [*] Goal: Two methods to count number of directories. Test idea: Compare `ls -1Ap` and `find . -type d`.
- [*] Goal: Understand different classifiers. Test Idea: Generate all of `*/=>@|` in `ls -F` output.
