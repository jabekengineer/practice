# C++ Learning

## Concept Learning Cycle

1. For each concept, write a failing test.
2. Modify header and source file to make concept test succeed.
3. Include a nice demo in each concept file.

# Char Type

## Core Types & Platform Behavior (Critical Foundation)
- [x] Determine `signed char` range and verify it's always -128-127
- [x] Determine `unsigned char` range and verify it's always 0-255
- [x] Verify `sizeof(char)` is always 1 byte
- [x] Test `CHAR_BIT` defines bits per char (usually 8)
- [x] Test platform differences: default `char` signed vs unsigned ⭐ Critical!

## Standard Library Integration
- [x] Use `<limits>` header with `std::numeric_limits` for char ranges
- [x] Use `<climits>` header constants (CHAR_MIN, CHAR_MAX, UCHAR_MAX)
- [x] Compare `std::numeric_limits` vs `<climits>` constants

## Type Promotion & Arithmetic (Most Common Bug Source)
- [x] Verify `char` promotes to `int` in arithmetic expressions (+ - / * %) ⭐ Critical!

## Character Literals & ASCII
- [x] Verify character literals ('a') produce correct ASCII values
- [x] Test decimal/hex/octal literals assignment to char

## Character Classification (Practical Usage)
- [x] Use `<cctype>` functions: `isalpha`, `isdigit`, `isspace`, `ispunct`
- [x] Use `<cctype>` `toupper` and `tolower` character transformations