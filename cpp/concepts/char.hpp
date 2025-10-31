#pragma once
#include <bitset>
#include <climits>
#include <limits>
#include <optional>
#include <typeinfo>
#include <utility>
#include <vector>

/// @returns pair with 'in signed char range?' and 'input cast to signed char'
const std::pair<bool, signed char> isInRange(const signed char val);

const std::pair<bool, unsigned char> isInRangeU(const unsigned char val);
const std::bitset<8U> binaryFromChar(const char val);
const size_t sizeOfChar(const char val);

/** Standard Library Char stuff */
template <typename CharType> const CharType getMinChar()
{
    return std::numeric_limits<CharType>::min();
}

template <typename CharType> const CharType getMaxChar()
{
    return std::numeric_limits<CharType>::max();
}

const std::vector<int> getCLimits();
const std::vector<int> getStdLimits();

/** TypePromotion and Arithmetic */
const int addChars(char a, char b);
const int subtractChars(char a, char b);
const int multiplyChars(char a, char b);
const int divideChars(char a, char b);
const int moduloChars(char a, char b);

/** ASCII codes decimal, octal, hexadecimal and char representations */
const char getAsciiMin();
const char getAsciiMax();
const char getCharFromInt(int code);

/** char helpers */
const bool isAlpha(char val);
const bool isAlnum(char val);
const bool isDigit(char val);
const bool isSpace(char val);
const bool isPunct(char val);

void demo();
