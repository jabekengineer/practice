#!/bin/bash

# Build and Test Script for Shell Scripting Practice Repository
# Usage: ./build-and-test.sh [concept_name] [shell_type]
# If no concept_name is provided, all concepts will be tested
# shell_type can be: bash, zsh, powershell, or auto (default)

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
CONCEPTS_DIR="$PROJECT_ROOT/concepts"
TESTS_DIR="$PROJECT_ROOT/tests"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to detect shell type from file extension
detect_shell_type() {
    local file="$1"
    case "$file" in
        *.sh) echo "bash" ;;
        *.zsh) echo "zsh" ;;
        *.ps1) echo "powershell" ;;
        *) echo "bash" ;;  # default
    esac
}

# Function to make scripts executable
make_executable() {
    local dir="$1"
    print_status "Making scripts in $dir executable..."
    
    if [[ -d "$dir" ]]; then
        find "$dir" -name "*.sh" -exec chmod +x {} \;
        find "$dir" -name "*.zsh" -exec chmod +x {} \;
        find "$dir" -name "*.ps1" -exec chmod +x {} \; 2>/dev/null || true
        print_success "Scripts in $dir are now executable"
    else
        print_warning "Directory $dir does not exist"
    fi
}

# Function to run a script with appropriate shell
run_with_shell() {
    local script_file="$1"
    local shell_type="$2"
    
    case "$shell_type" in
        "bash")
            bash "$script_file"
            ;;
        "zsh")
            if command -v zsh >/dev/null 2>&1; then
                zsh "$script_file"
            else
                print_warning "Zsh not available, falling back to bash"
                bash "$script_file"
            fi
            ;;
        "powershell")
            if command -v pwsh >/dev/null 2>&1; then
                pwsh "$script_file"
            else
                print_warning "PowerShell not available, skipping $script_file"
                return 1
            fi
            ;;
        *)
            # Auto-detect or default to making it executable and running directly
            if [[ -x "$script_file" ]]; then
                "$script_file"
            else
                bash "$script_file"
            fi
            ;;
    esac
}

# Function to run a specific test
run_test() {
    local test_file="$1"
    local shell_type="$2"
    local test_name=$(basename "$test_file" .sh)
    
    print_status "Running test: $test_name with $shell_type"
    
    if [[ -f "$test_file" ]]; then
        if run_with_shell "$test_file" "$shell_type"; then
            print_success "Test $test_name passed"
            return 0
        else
            print_error "Test $test_name failed"
            return 1
        fi
    else
        print_error "Test file $test_file not found"
        return 1
    fi
}

# Function to run all tests
run_all_tests() {
    local failed_tests=0
    local total_tests=0
    local shell_type="${1:-auto}"
    
    print_status "Running all tests with shell type: $shell_type"
    
    if [[ ! -d "$TESTS_DIR" ]]; then
        print_error "Tests directory not found: $TESTS_DIR"
        return 1
    fi
    
    for test_file in "$TESTS_DIR"/test_*.sh "$TESTS_DIR"/test_*.zsh "$TESTS_DIR"/test_*.ps1; do
        if [[ -f "$test_file" ]]; then
            total_tests=$((total_tests + 1))
            local detected_shell
            if [[ "$shell_type" == "auto" ]]; then
                detected_shell=$(detect_shell_type "$test_file")
            else
                detected_shell="$shell_type"
            fi
            
            if ! run_test "$test_file" "$detected_shell"; then
                failed_tests=$((failed_tests + 1))
            fi
            echo # Add spacing between tests
        fi
    done
    
    if [[ $total_tests -eq 0 ]]; then
        print_warning "No test files found in $TESTS_DIR"
        return 0
    fi
    
    echo "========================="
    if [[ $failed_tests -eq 0 ]]; then
        print_success "All $total_tests tests passed!"
        return 0
    else
        print_error "$failed_tests out of $total_tests tests failed"
        return 1
    fi
}

# Function to run tests for a specific concept
run_concept_test() {
    local concept_name="$1"
    local shell_type="${2:-auto}"
    local test_file=""
    
    # Find the appropriate test file based on concept name and shell type
    if [[ "$shell_type" == "powershell" ]]; then
        test_file="$TESTS_DIR/test_${concept_name}.ps1"
        if [[ ! -f "$test_file" ]]; then
            test_file="$TESTS_DIR/test_powershell_basics.ps1"
        fi
    elif [[ "$shell_type" == "zsh" ]]; then
        test_file="$TESTS_DIR/test_${concept_name}.zsh"
        if [[ ! -f "$test_file" ]]; then
            test_file="$TESTS_DIR/test_zsh_features.zsh"
        fi
    else
        # Default to .sh files, but also check for shell-specific files
        test_file="$TESTS_DIR/test_${concept_name}.sh"
        if [[ ! -f "$test_file" ]]; then
            test_file="$TESTS_DIR/test_${concept_name}.zsh"
        fi
        if [[ ! -f "$test_file" ]]; then
            test_file="$TESTS_DIR/test_${concept_name}.ps1"
        fi
    fi
    
    print_status "Running tests for concept: $concept_name with shell type: $shell_type"
    
    if [[ -f "$test_file" ]]; then
        local detected_shell
        if [[ "$shell_type" == "auto" ]]; then
            detected_shell=$(detect_shell_type "$test_file")
        else
            detected_shell="$shell_type"
        fi
        run_test "$test_file" "$detected_shell"
    else
        print_error "Test file not found for concept: $concept_name"
        print_error "Searched for: test_${concept_name}.{sh,zsh,ps1}"
        return 1
    fi
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [concept_name] [shell_type]"
    echo ""
    echo "Arguments:"
    echo "  concept_name  - Name of specific concept to test (optional)"
    echo "  shell_type    - Shell to use: bash, zsh, powershell, auto (default: auto)"
    echo ""
    echo "Examples:"
    echo "  $0                     # Run all tests with auto-detected shells"
    echo "  $0 variables           # Run tests for variables concept"
    echo "  $0 variables zsh       # Run variables tests with zsh"
    echo "  $0 '' bash             # Run all tests with bash"
}

# Main execution
main() {
    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        show_usage
        exit 0
    fi
    
    print_status "Starting Shell Scripting Practice Build and Test"
    print_status "Project root: $PROJECT_ROOT"
    
    # Make all scripts executable
    make_executable "$CONCEPTS_DIR"
    make_executable "$TESTS_DIR"
    
    local concept_name="$1"
    local shell_type="${2:-auto}"
    
    # Check if a specific concept was requested
    if [[ -n "$concept_name" ]]; then
        run_concept_test "$concept_name" "$shell_type"
    else
        run_all_tests "$shell_type"
    fi
}

# Run main function with all arguments
main "$@"
