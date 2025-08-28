#!/bin/bash

# Build and Test Script for C Practice Repository
# Usage: ./build-and-test.sh [concept_name]
# If no concept_name is provided, all concepts will be tested

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
BUILD_DIR="$PROJECT_ROOT/build"

# Create build directory if it doesn't exist
mkdir -p "$BUILD_DIR"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to compile and test a single concept
test_concept() {
    local concept_name="$1"
    local concept_file="$CONCEPTS_DIR/${concept_name}.c"
    local header_file="$CONCEPTS_DIR/${concept_name}.h"
    local test_file="$TESTS_DIR/test_${concept_name}.c"
    local executable="$BUILD_DIR/test_${concept_name}"
    
    print_status "Testing concept: $concept_name"
    
    # Check if concept file exists
    if [[ ! -f "$concept_file" ]]; then
        print_error "Concept file not found: $concept_file"
        return 1
    fi
    
    # Check if test file exists
    if [[ ! -f "$test_file" ]]; then
        print_error "Test file not found: $test_file"
        return 1
    fi
    
    # Compile with warnings and debug info
    local compile_cmd="gcc -std=c17 -Wall -Wextra -Wpedantic -g"
    
    # Add header file to compilation if it exists
    if [[ -f "$header_file" ]]; then
        compile_cmd="$compile_cmd -I$CONCEPTS_DIR"
    fi
    
    # Compile the test
    print_status "Compiling $concept_name..."
    if $compile_cmd -o "$executable" "$test_file" "$concept_file" 2>&1; then
        print_success "Compilation successful"
    else
        print_error "Compilation failed for $concept_name"
        return 1
    fi
    
    # Run the test
    print_status "Running tests for $concept_name..."
    if "$executable"; then
        print_success "Tests passed for $concept_name"
        
        # Optional: Run with Valgrind if available
        if command -v valgrind >/dev/null 2>&1; then
            print_status "Running memory check for $concept_name..."
            if valgrind --leak-check=full --error-exitcode=1 --quiet "$executable" >/dev/null 2>&1; then
                print_success "Memory check passed for $concept_name"
            else
                print_warning "Memory issues detected in $concept_name (check with valgrind manually)"
            fi
        fi
    else
        print_error "Tests failed for $concept_name"
        return 1
    fi
    
    echo ""
}

# Function to find all concepts
find_concepts() {
    local concepts=()
    
    # Look for .c files in concepts directory
    for file in "$CONCEPTS_DIR"/*.c; do
        if [[ -f "$file" ]]; then
            local basename=$(basename "$file" .c)
            # Check if corresponding test exists
            if [[ -f "$TESTS_DIR/test_${basename}.c" ]]; then
                concepts+=("$basename")
            else
                print_warning "No test file found for concept: $basename"
            fi
        fi
    done
    
    echo "${concepts[@]}"
}

# Function to clean build directory
clean_build() {
    print_status "Cleaning build directory..."
    rm -rf "$BUILD_DIR"/*
    print_success "Build directory cleaned"
}

# Function to clean CMake build
clean_cmake_build() {
    local cmake_build_dir="$BUILD_DIR/cmake"
    if [[ -d "$cmake_build_dir" ]]; then
        print_status "Cleaning CMake build directory..."
        rm -rf "$cmake_build_dir"
        print_success "CMake build directory cleaned"
    fi
}

# Function to build and test with CMake/CTest
cmake_build_and_test() {
    local specific_concept="$1"
    local enable_memcheck="$2"
    local enable_coverage="$3"
    
    print_status "Using CMake/CTest build system"
    
    # Create build directory
    local cmake_build_dir="$BUILD_DIR/cmake"
    mkdir -p "$cmake_build_dir"
    
    # Configure CMake
    print_status "Configuring CMake..."
    local cmake_args="-DCMAKE_BUILD_TYPE=Debug"
    
    if [[ "$enable_coverage" == "true" ]]; then
        cmake_args="$cmake_args -DENABLE_COVERAGE=ON"
    fi
    
    if ! (cd "$cmake_build_dir" && cmake "$PROJECT_ROOT" $cmake_args); then
        print_error "CMake configuration failed"
        return 1
    fi
    
    # Build
    print_status "Building with CMake..."
    if ! (cd "$cmake_build_dir" && make -j$(nproc 2>/dev/null || echo 4)); then
        print_error "CMake build failed"
        return 1
    fi
    
    # Run tests
    if [[ -n "$specific_concept" ]]; then
        print_status "Running tests for $specific_concept with CTest..."
        if (cd "$cmake_build_dir" && ctest -R "$specific_concept" --output-on-failure --verbose); then
            print_success "CTest passed for $specific_concept"
        else
            print_error "CTest failed for $specific_concept"
            return 1
        fi
    else
        print_status "Running all tests with CTest..."
        if (cd "$cmake_build_dir" && ctest --output-on-failure --verbose); then
            print_success "All CTests passed"
        else
            print_error "Some CTests failed"
            return 1
        fi
    fi
    
    # Memory check if requested
    if [[ "$enable_memcheck" == "true" ]]; then
        if command -v valgrind >/dev/null 2>&1; then
            print_status "Running memory checks with CTest..."
            if (cd "$cmake_build_dir" && ctest -T memcheck --output-on-failure); then
                print_success "Memory checks passed"
            else
                print_warning "Memory check issues detected"
            fi
        else
            print_warning "Valgrind not available for memory checking"
        fi
    fi
    
    # Coverage report if enabled
    if [[ "$enable_coverage" == "true" ]]; then
        if command -v gcov >/dev/null 2>&1; then
            print_status "Generating coverage report..."
            (cd "$cmake_build_dir" && find . -name "*.gcda" -exec gcov {} \;)
            print_success "Coverage report generated"
        else
            print_warning "gcov not available for coverage"
        fi
    fi
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS] [CONCEPT_NAME]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -c, --clean    Clean build directory before testing"
    echo "  -l, --list     List all available concepts"
    echo "  --direct       Use direct compilation instead of CMake (simple mode)"
    echo "  --memcheck     Run with memory checking (requires Valgrind)"
    echo "  --coverage     Enable code coverage"
    echo ""
    echo "Examples:"
    echo "  $0                    # Test all concepts with CMake/CTest"
    echo "  $0 variables          # Test only the 'variables' concept"
    echo "  $0 --direct           # Test all concepts with direct compilation"
    echo "  $0 --memcheck         # Test with memory checking"
    echo "  $0 --clean            # Clean and test all concepts"
    echo "  $0 --list             # List all available concepts"
}

# Function to list all concepts
list_concepts() {
    local concepts=($(find_concepts))
    
    if [[ ${#concepts[@]} -eq 0 ]]; then
        print_warning "No concepts found with corresponding test files"
        return
    fi
    
    print_status "Available concepts:"
    for concept in "${concepts[@]}"; do
        echo "  - $concept"
    done
}

# Main script logic
main() {
    local specific_concept=""
    local clean_first=false
    local list_only=false
    local use_direct=false
    local enable_memcheck=false
    local enable_coverage=false
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            -c|--clean)
                clean_first=true
                shift
                ;;
            -l|--list)
                list_only=true
                shift
                ;;
            --direct)
                use_direct=true
                shift
                ;;
            --memcheck)
                enable_memcheck=true
                shift
                ;;
            --coverage)
                enable_coverage=true
                shift
                ;;
            -*)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
            *)
                if [[ -n "$specific_concept" ]]; then
                    print_error "Multiple concept names provided. Please specify only one."
                    exit 1
                fi
                specific_concept="$1"
                shift
                ;;
        esac
    done
    
    # Handle list option
    if [[ "$list_only" == true ]]; then
        list_concepts
        exit 0
    fi
    
    # Clean if requested
    if [[ "$clean_first" == true ]]; then
        if [[ "$use_direct" == true ]]; then
            clean_build
        else
            clean_cmake_build
        fi
    fi
    
    print_status "C Practice Repository - Build and Test"
    print_status "Project root: $PROJECT_ROOT"
    echo ""
    
    # Choose build system - default to CMake/CTest
    if [[ "$use_direct" == true ]]; then
        print_status "Using direct compilation (simple mode)"
        
        # Use direct compilation (original logic)
        if [[ -n "$specific_concept" ]]; then
            if test_concept "$specific_concept"; then
                print_success "All tests passed for $specific_concept!"
            else
                print_error "Tests failed for $specific_concept"
                exit 1
            fi
        else
            local concepts=($(find_concepts))
            
            if [[ ${#concepts[@]} -eq 0 ]]; then
                print_warning "No concepts found with corresponding test files"
                print_status "Create .c files in $CONCEPTS_DIR and test_.c files in $TESTS_DIR"
                exit 0
            fi
            
            local failed_concepts=()
            local total_concepts=${#concepts[@]}
            
            print_status "Found $total_concepts concepts to test"
            echo ""
            
            for concept in "${concepts[@]}"; do
                if ! test_concept "$concept"; then
                    failed_concepts+=("$concept")
                fi
            done
            
            echo ""
            print_status "Test Summary:"
            print_status "Total concepts: $total_concepts"
            print_status "Passed: $((total_concepts - ${#failed_concepts[@]}))"
            
            if [[ ${#failed_concepts[@]} -eq 0 ]]; then
                print_success "All tests passed! 🎉"
            else
                print_status "Failed: ${#failed_concepts[@]}"
                print_error "Failed concepts: ${failed_concepts[*]}"
                exit 1
            fi
        fi
    else
        # Use CMake/CTest (default)
        if ! command -v cmake >/dev/null 2>&1; then
            print_error "CMake not found. Please install CMake or use --direct flag."
            exit 1
        fi
        
        if cmake_build_and_test "$specific_concept" "$enable_memcheck" "$enable_coverage"; then
            print_success "CMake/CTest completed successfully! 🎉"
        else
            print_error "CMake/CTest failed"
            exit 1
        fi
    fi
}

# Run main function with all arguments
main "$@"