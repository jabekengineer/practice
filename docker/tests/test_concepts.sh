#!/bin/bash

# Test script for Docker concepts
# This script runs comprehensive tests for all Docker concepts

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

echo "=== Testing Docker Environment ==="
echo

# Test Docker availability
print_status "Testing Docker..."
if command -v docker &> /dev/null; then
    docker_version=$(docker --version)
    print_success "Docker available: $docker_version"
else
    print_error "Docker not available"
    exit 1
fi

# Test Docker daemon
print_status "Testing Docker daemon..."
if docker info &> /dev/null; then
    print_success "Docker daemon is running"
else
    print_error "Docker daemon is not running"
    exit 1
fi

# Test Docker Compose
print_status "Testing Docker Compose..."
if docker compose version &> /dev/null; then
    compose_version=$(docker compose version)
    print_success "Docker Compose available: $compose_version"
elif command -v docker-compose &> /dev/null; then
    compose_version=$(docker-compose --version)
    print_success "Docker Compose (legacy) available: $compose_version"
else
    print_warning "Docker Compose not available"
fi

echo
print_status "Testing basic Docker functionality..."

# Test basic Docker commands
print_status "Testing docker run with hello-world..."
if docker run --rm hello-world &> /dev/null; then
    print_success "Basic docker run works"
else
    print_error "Basic docker run failed"
fi

# Test image operations
print_status "Testing image operations..."
if docker pull alpine:latest &> /dev/null; then
    print_success "Image pull works"
    
    # Test image listing
    if docker images alpine:latest &> /dev/null; then
        print_success "Image listing works"
    fi
    
    # Cleanup
    docker rmi alpine:latest &> /dev/null || true
fi

echo
print_status "Environment information:"
echo "  Docker version: $(docker --version 2>/dev/null || echo 'Not available')"
echo "  Docker Compose version: $(docker compose version --short 2>/dev/null || docker-compose --version 2>/dev/null || echo 'Not available')"
echo "  Available images: $(docker images --format 'table {{.Repository}}:{{.Tag}}' | wc -l) images"
echo "  Running containers: $(docker ps --format 'table {{.Names}}' | wc -l) containers"

echo
print_success "Docker environment test complete!"
