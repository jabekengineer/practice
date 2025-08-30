#!/bin/bash

# Build and Test Script for Docker Practice Repository
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

# Function to check if Docker is available
check_docker() {
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed or not in PATH"
        return 1
    fi
    
    if ! docker info &> /dev/null; then
        print_error "Docker daemon is not running"
        return 1
    fi
    
    print_success "Docker is available"
}

# Function to check if Docker Compose is available
check_docker_compose() {
    if docker compose version &> /dev/null; then
        print_success "Docker Compose is available"
        return 0
    elif command -v docker-compose &> /dev/null; then
        print_success "Docker Compose (legacy) is available"
        return 0
    else
        print_warning "Docker Compose is not available"
        return 1
    fi
}

# Function to run tests for a specific concept
test_concept() {
    local concept_name="$1"
    local concept_dir="$CONCEPTS_DIR/$concept_name"
    
    if [[ ! -d "$concept_dir" ]]; then
        print_error "Concept directory not found: $concept_dir"
        return 1
    fi
    
    print_status "Testing concept: $concept_name"
    
    # Test if there's a specific test script
    local test_script="$TESTS_DIR/test_${concept_name}.sh"
    if [[ -f "$test_script" && -x "$test_script" ]]; then
        print_status "Running specific test script: $test_script"
        if "$test_script"; then
            print_success "Test script passed for $concept_name"
        else
            print_error "Test script failed for $concept_name"
            return 1
        fi
    else
        # Generic Docker tests
        print_status "Running generic Docker tests for $concept_name"
        
        cd "$concept_dir"
        
        # Test if Dockerfile exists and builds
        if [[ -f "Dockerfile" ]]; then
            print_status "Building Docker image for $concept_name"
            if docker build -t "practice-$concept_name" .; then
                print_success "Docker image built successfully"
                
                # Cleanup
                docker rmi "practice-$concept_name" &> /dev/null || true
            else
                print_error "Docker build failed for $concept_name"
                return 1
            fi
        fi
        
        # Test if docker-compose.yml exists
        if [[ -f "docker-compose.yml" ]]; then
            print_status "Testing Docker Compose for $concept_name"
            if docker compose config &> /dev/null; then
                print_success "Docker Compose configuration is valid"
            else
                print_error "Docker Compose configuration is invalid"
                return 1
            fi
        fi
        
        cd "$PROJECT_ROOT"
    fi
}

# Function to run all tests
run_all_tests() {
    local failed_tests=0
    local total_tests=0
    
    print_status "Running all Docker concept tests..."
    
    for concept_dir in "$CONCEPTS_DIR"/*; do
        if [[ -d "$concept_dir" ]]; then
            local concept_name=$(basename "$concept_dir")
            total_tests=$((total_tests + 1))
            
            if ! test_concept "$concept_name"; then
                failed_tests=$((failed_tests + 1))
            fi
            echo # Add spacing between tests
        fi
    done
    
    if [[ $total_tests -eq 0 ]]; then
        print_warning "No concepts found in $CONCEPTS_DIR"
        return 0
    fi
    
    echo "========================="
    if [[ $failed_tests -eq 0 ]]; then
        print_success "All $total_tests concept tests passed!"
        return 0
    else
        print_error "$failed_tests out of $total_tests concept tests failed"
        return 1
    fi
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [concept_name]"
    echo ""
    echo "Arguments:"
    echo "  concept_name  - Name of specific concept to test (optional)"
    echo ""
    echo "Examples:"
    echo "  $0                    # Test all concepts"
    echo "  $0 basic-container    # Test basic-container concept"
    echo "  $0 compose-app        # Test compose-app concept"
}

# Main execution
main() {
    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        show_usage
        exit 0
    fi
    
    print_status "Starting Docker Practice Build and Test"
    print_status "Project root: $PROJECT_ROOT"
    
    # Check prerequisites
    check_docker || exit 1
    check_docker_compose
    
    local concept_name="$1"
    
    # Check if a specific concept was requested
    if [[ -n "$concept_name" ]]; then
        test_concept "$concept_name"
    else
        run_all_tests
    fi
}

# Run main function with all arguments
main "$@"
