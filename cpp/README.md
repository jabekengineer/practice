# C++ Learning

## Concept Learning Cycle

1. For each concept, write a failing test.
2. Modify header and source file to make concept test succeed.
3. Include a nice demo in each concept file.

# C++ Char Type Learning Path (Essential Focus)

## Phase 1: Core Types & Platform Behavior (Critical Foundation)
- [x] Determine `signed char` range and verify it's always -128-127
- [x] Determine `unsigned char` range and verify it's always 0-255
- [x] Verify `sizeof(char)` is always 1 byte
- [ ] Test `CHAR_BIT` defines bits per char (usually 8)
- [ ] **Test platform differences: default `char` signed vs unsigned** ⭐ Critical!

## Phase 2: Standard Library Integration
- [ ] Use `<limits>` header with `std::numeric_limits` for char ranges
- [ ] Use `<climits>` header constants (CHAR_MIN, CHAR_MAX, UCHAR_MAX)
- [ ] Compare `std::numeric_limits` vs `<climits>` constants

## Phase 3: Type Promotion & Arithmetic (Most Common Bug Source)
- [ ] **Verify `char` promotes to `int` in arithmetic expressions** ⭐ Critical!
- [ ] **Test that `char + char` results in `int` type** ⭐ Critical!
- [ ] Test assignment back to char after arithmetic (narrowing warnings)
- [ ] Test mixed signed/unsigned char arithmetic behavior

## Phase 4: Character Literals & ASCII
- [ ] Verify character literals ('a') produce correct ASCII values
- [ ] Test escape sequences (\n, \t, \', \", \\) in char literals
- [ ] Test decimal/hex/octal literals assignment to char
- [ ] Confirm no literal suffix exists for `char` type

## Phase 5: Character Classification (Practical Usage)
- [ ] Use `<cctype>` functions: `isalpha`, `isdigit`, `isspace`, `ispunct`
- [ ] Test `toupper` and `tolower` character transformations
- [ ] Test ASCII vs extended character behavior (128-255)

## Phase 6: Type Selection Guidelines (Design Decisions)
- [ ] **Compare `char` vs `int8_t` vs `uint8_t` - when to use each** ⭐ Critical!
- [ ] Document text data vs byte manipulation use cases
- [ ] Test fixed-width types for portable numeric storage

## Phase 7: Advanced Topics (Time Permitting)
- [ ] Test bitwise operations on char types
- [ ] Verify sign extension behavior with signed char
- [ ] Test struct padding with char members
- [ ] Compare C++ vs C behavior differences

## Key Differences: C++ vs C

### **Type System**
- **C++**: `'a'` is `char` type, stricter type checking
- **C**: `'a'` is `int` type, more permissive conversions

### **Standard Library**
- **C++**: `<limits>`, `<climits>`, `std::numeric_limits`
- **C**: `<limits.h>`, `<stdint.h>`, macros only

### **Safety**
- **C++**: Better type safety, const correctness
- **C**: More manual memory management, fewer safety guarantees

### **Modern Features**
- **C++**: `char8_t` (C++20), template support
- **C**: More limited, focus on simplicity