#!/bin/bash

set -e

echo "Building and testing React concepts..."

# Install dependencies
npm install

# Run linting
echo "Running ESLint..."
npm run lint

# Run formatting check
echo "Checking code formatting..."
npm run format:check

# Run tests
echo "Running tests..."
npm run test:run

# Build the project
echo "Building project..."
npm run build

echo "All checks passed!"
