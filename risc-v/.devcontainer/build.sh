#!/bin/bash
# Quick build script for the RISC-V dev container

set -e

echo "Building RISC-V development container with Docker Bake..."

# Source environment variables
source .env

# Run the optimized build
time docker-compose build "$@"

echo "Build complete! Container ready for VS Code dev containers."
echo ""
echo "Next steps:"
echo "1. In VS Code: Ctrl+Shift+P → 'Dev Containers: Reopen in Container'"
echo "2. Or: Ctrl+Shift+P → 'Dev Containers: Rebuild Container'"