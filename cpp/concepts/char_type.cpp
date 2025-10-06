#include "char_type.hpp"

#include <iostream>
#include <stdexcept>

/**
 * Basics & Ranges
 */

const std::pair<bool, signed char> isInRange(const signed char val)
{
  return {val <= 127 && val >= -128, val};
}

const std::pair<bool, unsigned char> isInRangeU(const unsigned char val)
{
  return {val <= 255 && val >= 0, val};
}

const std::bitset<8U> binaryFromChar(const char val)
{
  const std::bitset<8U> binary(val);
  auto bitsetString = binary.to_string();
  // std::cout << bitsetString << std::endl;

  std::string binaryString = "";
  for (int i = 7; i >= 0; i--)
  {
    binaryString += ((val >> i) & 1) ? '1' : '0';
  }
  // std::cout << binaryString << std::endl;

  if (bitsetString != binaryString)
  {
    throw new std::runtime_error("Expected Strcmp to work");
  }
  return binary;
}

const size_t sizeOfChar(const char val)
{
  auto seq = binaryFromChar(val);
  return seq.size();
}

/**
 * Char Standard Library
 */

const std::vector<int> getStdLimits()
{
  return {std::numeric_limits<signed char>::min(),
          std::numeric_limits<signed char>::max(), 0,
          std::numeric_limits<unsigned char>::max()};
}

const std::vector<int> getCLimits()
{
  return {CHAR_MIN, CHAR_MAX, 0, UCHAR_MAX};
}

/** Char Type Promotion */
const int addChars(char a, char b) { return a + b; }
const int subtractChars(char a, char b) { return a - b; }
const int multiplyChars(char a, char b) { return a * b; }
const int divideChars(char a, char b) { return a / b; }
const int moduloChars(char a, char b) { return a % b; }

/** ASCII codes decimal, octal, hexadecimal and char representations */
const char getAsciiMin() { return std::numeric_limits<unsigned char>::min(); }
const char getAsciiMax() { return std::numeric_limits<signed char>::max(); }
const char getCharFromInt(int code) { return static_cast<unsigned char>(code); }

/** Char Helpers */
const bool isAlpha(char val) { return isalpha(val); }
const bool isAlnum(char val) { return isalnum(val); }
const bool isDigit(char val) { return isdigit(val); }
const bool isSpace(char val) { return isspace(val); }
const bool isPunct(char val) { return ispunct(val); }

void demo() { sizeOfChar('j'); }

#ifdef BUILD_EXECUTABLE
int main()
{
  demo();
  return 0;
}
#endif
