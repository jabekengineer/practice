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
	@echo "  make test-char     # Run char_test executable"
	@echo "  make clean         # Clean build directory"

# Configure and build (standard CMake workflow)
build:
	cmake -S . -B $(BUILD_DIR)
	cmake --build $(BUILD_DIR)

# Run all tests (standard CTest workflow)
test: build
	ctest --test-dir $(BUILD_DIR) --verbose

# Run specific test executable (development convenience)
test-%: build
	./$(BUILD_DIR)/tests/$*_test

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all build test test-% clean