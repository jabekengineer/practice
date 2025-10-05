# Standard CMake workflow - this Makefile is just for convenience
# The standard way is to use CMake commands directly:
#   cmake -S . -B build
#   cmake --build build
#   ctest --test-dir build

BUILD_DIR = build

# Default target shows standard CMake usage
help:
	@echo "Standard CMake usage:"
	@echo "  cmake -S . -B $(BUILD_DIR)        # Configure"
	@echo "  cmake --build $(BUILD_DIR)        # Build"
	@echo "  ctest --test-dir $(BUILD_DIR)     # Test"
	@echo ""
	@echo "Development convenience:"
	@echo "  make build         # Configure and build"
	@echo "  make test          # Run all tests"
	@echo "  make test-hello    # Run specific test"
	@echo "  make clean         # Clean build directory"

# Configure and build (standard CMake workflow)
build:
	cmake -S . -B $(BUILD_DIR)
	cmake --build $(BUILD_DIR)

# Run all tests (standard CTest workflow)
test: build
	ctest --test-dir $(BUILD_DIR) --verbose

# Run specific test (development convenience)
test-%: build
	ctest --test-dir $(BUILD_DIR) --verbose -R $*

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all build test test-% clean