#!/bin/zsh

# Zsh-specific features demonstration
# This script showcases features unique to zsh

# Zsh array features
demonstrate_zsh_arrays() {
    echo "=== Zsh Array Features ==="
    
    # Zsh arrays are 1-indexed by default
    local -a fruits=(apple banana cherry)
    
    echo "Array contents: ${fruits[*]}"
    echo "First element: ${fruits[1]}"  # Note: 1-indexed!
    echo "Last element: ${fruits[-1]}"
    echo "Array length: ${#fruits}"
    
    # Zsh supports associative arrays
    typeset -A colors
    colors[red]="#FF0000"
    colors[green]="#00FF00"
    colors[blue]="#0000FF"
    
    echo "Colors:"
    for color in ${(k)colors}; do
        echo "  $color: ${colors[$color]}"
    done
}

# Zsh parameter expansion features
demonstrate_zsh_expansions() {
    echo "=== Zsh Parameter Expansions ==="
    
    local text="Hello World"
    
    echo "Original: $text"
    echo "Uppercase: ${(U)text}"
    echo "Lowercase: ${(L)text}"
    echo "Length: ${#text}"
    echo "Words: ${(w)text}"
}

# Zsh globbing features
demonstrate_zsh_globbing() {
    echo "=== Zsh Globbing Features ==="
    
    # Create some test files
    mkdir -p /tmp/zsh-test
    touch /tmp/zsh-test/{file1.txt,file2.log,script.sh,readme.md}
    
    echo "All files in /tmp/zsh-test:"
    echo ${~"/tmp/zsh-test/*"}
    
    echo "Only .txt files:"
    echo /tmp/zsh-test/*.txt(N)  # (N) prevents error if no matches
    
    # Cleanup
    rm -rf /tmp/zsh-test
}

# Main function
main() {
    echo "Zsh version: $ZSH_VERSION"
    echo
    
    demonstrate_zsh_arrays
    echo
    
    demonstrate_zsh_expansions
    echo
    
    demonstrate_zsh_globbing
}

# Only run main if script is executed directly
if [[ "${ZSH_EVAL_CONTEXT}" == "toplevel" ]]; then
    main "$@"
fi
