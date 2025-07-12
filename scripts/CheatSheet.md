
1. yy - yank to copy line, p - to paste at cursor
1. o - to insert line beneath cursor

1. ^ - to start of line, $ - to end of line
1. b - to start of word, e - to end of word
1. G - move to end of file

1. if [[ -d "$dir" ]]; then fi - if directory exists
1. ~ path won't expand in variable if quoted. 
  should be: PATH_VAR=~/practice && if [[ -d "$PATH_VAR" ]]; then mkdir "$PATH_DIR" fi 
1. always quote variables

# Regex
1. =~ is a regex match 
1. ^ - start of string
1. $ - end of string
1. (<pattern>) - defines a pattern group
1. ? - matches zero or one of modified atom; atom is single char, character class [nN], or group ([aA][bB])
1. ^<pattern>$ - entire pattern must match. e.g.:
  if [[ $input =~ ^[yY]([eE][sS]) ]]; then fi
