# C++ Learning

## Concept Learning Cycle

1. Break concept into katas.
2. For each kata, make some google tests. Test coverage.
3. View actual memory layout of concept with LLVM-IR.
4. Debug a failure/exception test with asan and gdb.
5. Measure Test coverage with gcov.

## Char Type

### Core Types & Platform Behavior

- [x] Determine `signed char` range and verify it's always -128-127
- [x] Determine `unsigned char` range and verify it's always 0-255
- [x] Verify `sizeof(char)` is always 1 byte
- [x] Test `CHAR_BIT` defines bits per char (usually 8)
- [x] Test platform differences: default `char` signed vs unsigned

### Standard Library Integration

- [x] Use `<limits>` header with `std::numeric_limits` for char ranges
- [x] Use `<climits>` header constants (CHAR_MIN, CHAR_MAX, UCHAR_MAX)
- [x] Compare `std::numeric_limits` vs `<climits>` constants

### Type Promotion & Arithmetic (Most Common Bug Source)

- [x] Verify `char` promotes to `int` in arithmetic expressions (+ - / * %)

## Character Literals & ASCII

- [x] Verify character literals ('a') produce correct ASCII values
- [x] Test decimal/hex/octal literals assignment to char

## Character Classification (Practical Usage)

- [x] Use `<cctype>` functions: `isalpha`, `isdigit`, `isspace`, `ispunct`
- [x] Use `<cctype>` `toupper` and `tolower` character transformations

## Integer type

### Core Types and Platform Behavior

- [ ] Goal: Verify `signed`/`unsigned` modifiers work independently. Test idea: Template function with both types, verify mangled names differ.
- [ ] Goal: Prove `int` is exactly 32-bit on this platform. Test idea: `sizeof(int) == 4` and LLVM IR shows `i32`.
- [ ] Goal: Verify length modifier hierarchy: `short` ≤ `int` ≤ `long` ≤ `long long`. Test idea: Compare `sizeof()` values.
- [ ] Goal: Catch platform surprise - `long` and `long long` same size. Test idea: LLVM IR shows both as `i64`.

### STL Integration

- [ ] Goal: Use `std::numeric_limits` for integer ranges. Test idea: Verify `min()` and `max()` for each type.
- [ ] Goal: Use `<climits>` constants (INT_MIN, INT_MAX, etc.). Test idea: Compare against `sizeof()` calculations.
- [ ] Goal: Prove `<limits>` vs `<climits>` give same values. Test idea: Direct equality assertions.

### Type Promotion & Conversion Rules

- [ ] Goal: Verify integer promotion rules in arithmetic. Test idea: Check `typeid()` of arithmetic results.
- [ ] Goal: Test signed/unsigned conversion warnings. Test idea: Assignment between signed/unsigned of different sizes.

### Literal Forms & Representation

- [ ] Goal: Verify binary literals work (`0b1010`). Test idea: Assert equality with decimal equivalent.
- [ ] Goal: Test hex literals (`0xFF`). Test idea: Compare with decimal and binary forms.
- [ ] Goal: Test octal literals (`0377`). Test idea: Verify octal 377 equals decimal 255.
- [ ] Goal: Test decimal vs other forms produce identical IR. Test idea: LLVM IR shows same constant values.

## Troubleshooting

`nm <file> | grep <FuncName>` -- find symbols of interest
