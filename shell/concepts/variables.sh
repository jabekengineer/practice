#!/bin/bash

# Basic Variables and Data Types in Bash
# 
# This file demonstrates fundamental bash concepts:
# - Variable declarations and assignment
# - String manipulation
# - Numeric operations
# - Arrays
# - Function definitions
# - Command substitution

set -e  # Exit on any error

# Global variables
readonly MAX_ITEMS=100
SCRIPT_NAME="$(basename "$0")"

# Function to demonstrate basic variable operations
add_numbers() {
    local a="$1"
    local b="$2"
    echo $((a + b))
}

# Function to demonstrate string operations
to_uppercase() {
    local input="$1"
    echo "$input" | tr '[:lower:]' '[:upper:]'
}

# Function to demonstrate string concatenation
concatenate_strings() {
    local str1="$1"
    local str2="$2"
    echo "${str1}${str2}"
}

# Function to demonstrate string length
get_string_length() {
    local input="$1"
    echo "${#input}"
}

# Function to demonstrate array operations
demonstrate_arrays() {
    local -a fruits=("apple" "banana" "cherry")
    local last_index=$((${#fruits[@]} - 1))
    
    echo "Array contents:"
    for fruit in "${fruits[@]}"; do
        echo "  - $fruit"
    done
    
    echo "Array length: ${#fruits[@]}"
    echo "First element: ${fruits[0]}"
    echo "Last element: ${fruits[$last_index]}"
}

# Function to demonstrate command substitution
get_current_date() {
    echo "$(date '+%Y-%m-%d %H:%M:%S')"
}

# Function to demonstrate conditional operations
check_file_exists() {
    local filename="$1"
    if [[ -f "$filename" ]]; then
        echo "File exists: $filename"
    else
        echo "File does not exist: $filename"
    fi
    # Always return success to prevent script exit with set -e
    return 0
}

# Function to demonstrate numeric comparisons
compare_numbers() {
    local num1="$1"
    local num2="$2"
    
    if [[ $num1 -gt $num2 ]]; then
        echo "$num1 is greater than $num2"
    elif [[ $num1 -lt $num2 ]]; then
        echo "$num1 is less than $num2"
    else
        echo "$num1 is equal to $num2"
    fi
}

# Function to demonstrate environment variables
show_environment_info() {
    echo "User: ${USER:-unknown}"
    echo "Home: ${HOME:-unknown}"
    echo "Shell: ${SHELL:-unknown}"
    echo "Path: ${PATH}"
}

# Main demonstration function
main() {
    echo "=== Bash Variables and Basic Operations Demo ==="
    echo "Script: $SCRIPT_NAME"
    echo "Max items: $MAX_ITEMS"
    echo
    
    echo "=== Arithmetic Operations ==="
    result=$(add_numbers 15 25)
    echo "15 + 25 = $result"
    echo
    
    echo "=== String Operations ==="
    original="hello world"
    upper=$(to_uppercase "$original")
    echo "Original: '$original'"
    echo "Uppercase: '$upper'"
    
    combined=$(concatenate_strings "Hello " "World!")
    echo "Concatenated: '$combined'"
    
    length=$(get_string_length "$combined")
    echo "Length of '$combined': $length"
    echo
    
    echo "=== Array Operations ==="
    demonstrate_arrays
    echo
    
    echo "=== Command Substitution ==="
    current_time=$(get_current_date)
    echo "Current time: $current_time"
    echo
    
    echo "=== File Operations ==="
    check_file_exists "$0"  # Check if this script exists
    check_file_exists "/nonexistent/file"
    echo
    
    echo "=== Numeric Comparisons ==="
    compare_numbers 10 5
    compare_numbers 3 8
    compare_numbers 7 7
    echo
    
    echo "=== Environment Information ==="
    show_environment_info
}

# Only run main if script is executed directly (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
