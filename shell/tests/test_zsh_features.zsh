#!/bin/zsh

# Test file for zsh-specific features concept
# This file contains comprehensive tests for all functions
# defined in zsh_features.zsh

set -e  # Exit on any error

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONCEPTS_DIR="$(dirname "$SCRIPT_DIR")/concepts"

# Source the zsh features script to access its functions
source "$CONCEPTS_DIR/zsh_features.zsh"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counter
TESTS_RUN=0
TESTS_PASSED=0

# Function to run a test
run_test() {
    local test_name="$1"
    local expected="$2"
    local actual="$3"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if [[ "$actual" == "$expected" ]]; then
        echo -e "${GREEN}✓${NC} $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗${NC} $test_name"
        echo -e "  Expected: '$expected'"
        echo -e "  Actual:   '$actual'"
    fi
}

# Function to run a test that should succeed
run_success_test() {
    local test_name="$1"
    shift
    local command=("$@")
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if "${command[@]}" >/dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗${NC} $test_name"
        echo -e "  Command failed: ${command[*]}"
    fi
}

# Test zsh array features
test_zsh_arrays() {
    echo "Testing zsh array features..."
    
    # Test basic array functionality
    local -a test_fruits=(apple banana cherry)
    
    run_test "Array first element (1-indexed)" "apple" "${test_fruits[1]}"
    run_test "Array last element" "cherry" "${test_fruits[-1]}"
    run_test "Array length" "3" "${#test_fruits}"
    
    # Test associative arrays
    typeset -A test_colors
    test_colors[red]="#FF0000"
    test_colors[green]="#00FF00"
    
    run_test "Associative array red" "#FF0000" "${test_colors[red]}"
    run_test "Associative array green" "#00FF00" "${test_colors[green]}"
}

# Test zsh parameter expansions
test_zsh_expansions() {
    echo "Testing zsh parameter expansions..."
    
    local test_text="Hello World"
    
    run_test "Uppercase expansion" "HELLO WORLD" "${(U)test_text}"
    run_test "Lowercase expansion" "hello world" "${(L)test_text}"
    run_test "Length parameter" "11" "${#test_text}"
    
    # Test word splitting
    local words=(${(w)test_text})
    run_test "Word count after splitting" "2" "${#words}"
    run_test "First word" "Hello" "${words[1]}"
    run_test "Second word" "World" "${words[2]}"
}

# Test zsh globbing
test_zsh_globbing() {
    echo "Testing zsh globbing..."
    
    # Create a temporary directory for testing
    local test_dir="/tmp/zsh-glob-test-$$"
    mkdir -p "$test_dir"
    
    # Create test files
    touch "$test_dir/file1.txt"
    touch "$test_dir/file2.log"
    touch "$test_dir/script.sh"
    
    # Test glob patterns
    local txt_files=($test_dir/*.txt(N))
    run_test "Glob .txt files count" "1" "${#txt_files}"
    
    local all_files=($test_dir/*(N))
    run_test "Glob all files count" "3" "${#all_files}"
    
    # Cleanup
    rm -rf "$test_dir"
}

# Test function availability
test_function_availability() {
    echo "Testing function availability..."
    
    run_success_test "demonstrate_zsh_arrays function" demonstrate_zsh_arrays
    run_success_test "demonstrate_zsh_expansions function" demonstrate_zsh_expansions
    run_success_test "demonstrate_zsh_globbing function" demonstrate_zsh_globbing
}

# Test zsh version
test_zsh_version() {
    echo "Testing zsh environment..."
    
    if [[ -n "$ZSH_VERSION" ]]; then
        echo -e "${GREEN}✓${NC} Zsh version available: $ZSH_VERSION"
        TESTS_RUN=$((TESTS_RUN + 1))
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗${NC} Zsh version not available"
        TESTS_RUN=$((TESTS_RUN + 1))
    fi
}

# Main test function
main() {
    echo "=== Running Zsh Features Tests ==="
    echo
    
    test_zsh_version
    echo
    
    test_zsh_arrays
    echo
    
    test_zsh_expansions
    echo
    
    test_zsh_globbing
    echo
    
    test_function_availability
    echo
    
    echo "=== Test Summary ==="
    echo "Tests run: $TESTS_RUN"
    echo "Tests passed: $TESTS_PASSED"
    echo "Tests failed: $((TESTS_RUN - TESTS_PASSED))"
    
    if [[ $TESTS_PASSED -eq $TESTS_RUN ]]; then
        echo -e "${GREEN}All tests passed!${NC}"
        exit 0
    else
        echo -e "${RED}Some tests failed!${NC}"
        exit 1
    fi
}

# Only run main if script is executed directly (not sourced)
if [[ "${ZSH_EVAL_CONTEXT}" == "toplevel" ]]; then
    main "$@"
fi
