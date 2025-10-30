# C Programming Practice

---

`vendor-arch-os-eabi`
gcc-arm-linux-gnueabi
- GNU Compiler Collection
- ARM target architecture
- Linux Operating system (my latest Ubuntu)
- Embedded Application Binary Interface: by standard gnu c library (glibc) for 32-bit ARM Linux systems, like our amp Layerscape 1021A Armv7

`uname -a`
You are cross compiling from your WSL2 linux x86_64 system for an ArmV7 linux target.

cmake --build
ctest --test-dir build

# C Basic Types

## 1 byte - char

- checking your target's representation of char
- signed char range is -128 to 127
- unsigned char is


## Short


## Phase 1: Core Types & Platform Behavior
- [ ] Determine `signed char` range and verify it's always -128-127
- [ ] Determine `unsigned char` range and verify it's always 0-255
- [ ] Verify `sizeof(char)` is always 1 byte
- [ ] Test `CHAR_BIT` from `<limits.h>` (usually 8)
- [ ] **Test platform differences: default `char` signed vs unsigned** ⭐ Critical!

## Phase 2: C Standard Library Integration
- [ ] Use `<limits.h>` constants: `CHAR_MIN`, `CHAR_MAX`, `UCHAR_MAX`
- [ ] Use `SCHAR_MIN`, `SCHAR_MAX` for signed char explicitly
- [ ] Test `<stdint.h>` fixed-width types: `int8_t`, `uint8_t`

## Phase 3: Type Promotion & Arithmetic (C-Specific Behavior)
- [ ] **Verify `char` promotes to `int` in arithmetic expressions** ⭐ Critical!
- [ ] **Test that `char + char` results in `int` type** ⭐ Critical!
- [ ] Test assignment back to char after arithmetic (implementation-defined)
- [ ] Verify character literals ('a') are `int` type in C (vs `char` in C++)

## Phase 4: Character Literals & Representation
- [ ] Test that `'a'` has type `int` in C (different from C++)
- [ ] Verify character literals produce correct ASCII values
- [ ] Test escape sequences (\n, \t, \', \", \\) in char literals
- [ ] Test decimal/hex/octal literals assignment to char

## Phase 5: Character Classification (C Library)
- [ ] Use `<ctype.h>` functions: `isalpha`, `isdigit`, `isspace`, `ispunct`
- [ ] Test `toupper` and `tolower` character transformations
- [ ] Test locale-dependent vs locale-independent behavior
- [ ] Handle implementation-defined behavior for chars > 127

## Phase 6: String Context (C-Specific)
- [ ] Test null-terminated string literals with char arrays
- [ ] Compare `char str[] = "hello"` vs `char *str = "hello"`
- [ ] Test C string functions: `strlen`, `strcpy`, `strncpy`, `strcmp`
- [ ] Verify buffer bounds and safety considerations

## Phase 7: Memory & Pointers (C Focus)
- [ ] Test pointer arithmetic with `char*` vs `void*`
- [ ] Verify memory layout of char arrays
- [ ] Test `char*` as generic byte pointer usage
- [ ] Compare stack vs heap allocation for char arrays

## Phase 8: Compiler Flags & Portability
- [ ] Test `-fsigned-char` and `-funsigned-char` compiler flags
- [ ] Compare behavior across different C compilers (gcc vs clang)
- [ ] Document portable code practices for char usage
- [ ] Test with different optimization levels

## Phase 9: Best Practices (C-Specific Guidelines)
- [ ] Document when to use `char` vs `int8_t` vs `unsigned char`
- [ ] Establish rules for text processing vs byte manipulation
- [ ] Document safe string handling practices
- [ ] Create guidelines for cross-platform char usage

---

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