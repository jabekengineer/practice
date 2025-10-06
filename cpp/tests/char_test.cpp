#include <gtest/gtest.h>

#include <cctype>
#include <climits>
#include <limits>

#include "../concepts/char_type.hpp"
/**
 * Basics & Ranges
 */
TEST(BasicTypesAndRanges, SignedCharRangeIsNeg128To127)
{
  int outOfRange = 129;
  auto res = isInRange(outOfRange);
  // 9 bits are needed to represent 129 (0b10000001)
  // outOfRange explicitly cast to signed char, wrapping it around to min
  EXPECT_TRUE(res.first);
  EXPECT_EQ(res.second, -127);

  res = isInRange('a');
  EXPECT_TRUE(res.first);
}

TEST(BasicTypesAndRanges, UnsignedCharRangeIs0To255)
{
  int outOfRange = -1;
  auto res = isInRangeU(outOfRange);
  EXPECT_TRUE(res.first);
  EXPECT_EQ(res.second, static_cast<unsigned char>(255));

  // this cpp uses unsigned char by default
  EXPECT_EQ(static_cast<char>(outOfRange), static_cast<char>(255));

  res = isInRangeU('f');
  EXPECT_TRUE(res.first);
}

/**
 * @brief Name mangling (also called "name decoration") is a technique used by
 C++ compilers to:

  - Encode type information into symbol names
  - Support function overloading - different functions with same name but
    different parameters
  - Enable type-safe linking between object files
*
*/
TEST(BasicTypesAndRanges, MangledNames)
{
  const std::pair<bool, signed char> res = isInRange('j');
  const std::pair<bool, unsigned char> resU = isInRange('j');
  const char c = 'j';
  EXPECT_STREQ(typeid(res.second).name(), "a");
  EXPECT_STREQ(typeid(resU.second).name(), "h");
  EXPECT_STREQ(typeid(c).name(), "c");
}

TEST(BasicTypeAndRanges, SizeofCharIs8Bits)
{
  EXPECT_EQ(sizeof(char), 1);
  EXPECT_EQ(sizeOfChar('j'), 8);
  EXPECT_EQ(CHAR_BIT, 8);
}

TEST(StandardLibraryCharStuff, CLimits)
{
  // wider int type used to hold char limits
  std::vector<int> expected = {-128, 127, 0, 255};
  EXPECT_EQ(getCLimits(), expected);
}
TEST(StandardLibraryCharStuff, StdLimits)
{
  std::vector<int> expected = {-128, 127, 0, 255};
  EXPECT_EQ(getStdLimits(), expected);
}

TEST(StandardLibraryCharStuff, CLimitsVsStdLimits)
{
  EXPECT_EQ(getCLimits(), getStdLimits());
  EXPECT_EQ(getMinChar<unsigned char>(), 0);
  EXPECT_EQ(getMinChar<signed char>(), CHAR_MIN);
  EXPECT_EQ(getMaxChar<unsigned char>(), UCHAR_MAX);
  EXPECT_EQ(getMaxChar<signed char>(), CHAR_MAX);
}

TEST(TypePromotionAndArithmetic, CharPromotesToInt)
{
  char a = 'a';
  char b = 24;
  int sum = addChars(a, b);
  EXPECT_STREQ(typeid(sum).name(), "i");

  int diff = subtractChars(a, b);
  EXPECT_STREQ(typeid(diff).name(), "i");

  int prod = multiplyChars(a, b);
  EXPECT_STREQ(typeid(prod).name(), "i");

  int quot = divideChars(a, b);
  EXPECT_STREQ(typeid(quot).name(), "i");

  int mod = moduloChars(a, b);
  EXPECT_STREQ(typeid(mod).name(), "i");
}

TEST(AsciiValues, Range)
{
  EXPECT_EQ(getAsciiMin(), 0);
  EXPECT_EQ(getAsciiMin(), NULL);

  EXPECT_EQ(getAsciiMax(), 0x7F);
  EXPECT_EQ(getAsciiMax(), 0177);
  EXPECT_EQ(getAsciiMax(), 127);
}

TEST(AsciiValues, AlphabetRange)
{
  EXPECT_EQ(getCharFromInt(0x41), 'A');
  EXPECT_EQ(getCharFromInt(0101), 'A');
  EXPECT_EQ(getCharFromInt(0x5A), 'Z');
  EXPECT_EQ(getCharFromInt(0132), 'Z');

  EXPECT_EQ(getCharFromInt(0x61), 'a');
  EXPECT_EQ(getCharFromInt(0141), 'a');
  EXPECT_EQ(getCharFromInt(0x7A), 'z');
  EXPECT_EQ(getCharFromInt(0172), 'z');
}

TEST(AsciiValues, ToUpperToLower)
{
  char a = 0x61;
  char z = 0172;
  EXPECT_EQ(std::toupper(a), 0101);
  EXPECT_EQ(std::toupper(z), 0x5A);

  EXPECT_EQ(std::tolower(0x5A), z);
  EXPECT_EQ(std::tolower(0x41), a);
}

/** char helpers */
TEST(CharHelpers, IsAlpha)
{
  EXPECT_TRUE(isAlpha('a'));
  EXPECT_FALSE(isAlpha('`'));
}

TEST(CharHelpers, IsAlnum)
{
  EXPECT_TRUE(isAlnum('P'));
  EXPECT_FALSE(isAlnum('_'));
}

TEST(CharHelpers, IsDigit)
{
  EXPECT_TRUE(isDigit(0x32));
  EXPECT_FALSE(isDigit('['));
}

TEST(CharHelpers, IsSpace)
{
  EXPECT_TRUE(isSpace(' '));
  EXPECT_FALSE(isSpace('m'));
}

TEST(CharHelpers, IsPunct)
{
  EXPECT_TRUE(isPunct(';'));
  EXPECT_FALSE(isPunct(4));
}
