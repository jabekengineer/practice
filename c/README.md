# C Programming Practice

A streamlined C development environment using CMake/CTest for professional C programming practice.

## 🚀 Quick Start

### Development Workflow

1. **Open in VS Code**: Use Command Palette → "Dev Containers: Reopen in Container"
2. **Develop**: Write concepts in `concepts/` and tests in `tests/`
3. **Test in Dev Container**: `./scripts/build-and-test.sh`
4. **Demo Clean Run**: `docker-compose run demo ./scripts/build-and-test.sh`

## 📁 Project Structure

```c
c/
├── .devcontainer/              # Development container
├── concepts/                   # C implementations
│   ├── variables.c            # Example concept
│   └── variables.h            # Header file
├── tests/                      # Test files
│   └── test_variables.c       # Tests for variables
├── scripts/
│   └── build-and-test.sh      # Build and test script
├── CMakeLists.txt             # CMake configuration
└── docker-compose.yml         # Container orchestration
```

## � Development Workflow

### 1. Develop C Concepts (Dev Container)

**Open Development Environment:**

```bash
# In VS Code: Command Palette → "Dev Containers: Reopen in Container"
# Or manually:
docker-compose run --rm dev
```

**Create New Concept:**

1. Add implementation: `concepts/new_concept.c`
2. Add header (if needed): `concepts/new_concept.h`
3. Add tests: `tests/test_new_concept.c`

**Test During Development:**

```bash
# Test all concepts
./scripts/build-and-test.sh

# Test specific concept
./scripts/build-and-test.sh variables

# Test with memory checking
./scripts/build-and-test.sh --memcheck

# Test with code coverage
./scripts/build-and-test.sh --coverage
```

### 2. Run Clean Demos

**Quick Demo Run:**

```bash
# Run all tests in clean environment
docker-compose run --rm demo ./scripts/build-and-test.sh

# Test specific concept
docker-compose run --rm demo ./scripts/build-and-test.sh variables
```

**Automated Testing:**

```bash
# Runs tests and exits
docker-compose run --rm test
```

## 🛠 Build Systems

### CMake/CTest (Default - Recommended)

```bash
./scripts/build-and-test.sh                # All concepts
./scripts/build-and-test.sh variables      # Specific concept
./scripts/build-and-test.sh --memcheck     # With memory checking
./scripts/build-and-test.sh --coverage     # With code coverage
```

### Direct Compilation

(Simple Mode)

```bash
./scripts/build-and-test.sh --direct       # Simple compilation
./scripts/build-and-test.sh --direct variables
```

### Manual CMake

```bash
mkdir -p build/cmake && cd build/cmake
cmake ../..
make
ctest --output-on-failure --verbose
```

## 📝 Coding Standards

### File Naming

- **Concepts**: `concept_name.c` and `concept_name.h`
- **Tests**: `test_concept_name.c`

### Test Structure

```c
#include <assert.h>
#include <stdio.h>
#include "concept_name.h"

void test_basic_functionality(void) {
    assert(expected == actual);
    printf("✓ Basic functionality test passed\n");
}

int main(void) {
    printf("=== Running Concept Tests ===\n");
    test_basic_functionality();
    printf("=== All Tests Passed! ===\n");
    return 0;
}
```

## � Debugging

### Using GDB in Dev Container

```bash
# Compile with debug symbols (automatic with build script)
./scripts/build-and-test.sh variables

# Debug the test executable
gdb build/cmake/test_variables
```

### Memory Checking

```bash
# Automatic Valgrind integration
./scripts/build-and-test.sh --memcheck
```

## 🎯 Concept Examples

Each concept should demonstrate:

1. **Core C Feature**:
Variables, pointers, arrays, structs, etc.
2. **Practical Usage**: Real-world applications
3. **Edge Cases**: Error handling and boundary conditions
4. **Best Practices**: Clean, idiomatic C code

## 📚 Learning Path

Recommended concept order:

1. **variables** - Data types, operators, constants
2. **functions** - Declaration, definition, scope
3. **arrays** - Static arrays, multidimensional
4. **pointers** - Basic pointers, pointer arithmetic
5. **strings** - C-style strings, string functions
6. **structs** - User-defined types
7. **memory** - Dynamic allocation, malloc/free
8. **files** - File I/O operations

## 🤝 Contributing New Concepts

1. **Create Implementation**: Add `concepts/concept_name.c` (and `.h` if needed)
2. **Write Tests**: Add comprehensive `tests/test_concept_name.c`
3. **Test in Dev Container**: Ensure all tests pass
4. **Verify Demo**: Run in clean demo environment
5. **Document**: Update this README if adding new categories

The build system automatically discovers and tests new concepts!

## � Container Details

- **Development Container**: Full toolchain (GCC, Valgrind, GDB, CMake, etc.)
- **Demo Container**: Minimal environment (GCC, Make, CMake) for clean runs
- **Both use same Dockerfile** with different build targets for efficiency
