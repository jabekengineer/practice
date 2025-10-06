#include <gtest/gtest.h>

#include <limits>

#include "../concepts/char_type.hpp"
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

TEST(BasicTypeAndRanges, SizeofCharIs1Byte)
{
  EXPECT_EQ(sizeof(char), 1);
  EXPECT_EQ(sizeof(char16_t), 2);
  EXPECT_EQ(sizeof(char32_t), 4);

  EXPECT_EQ(sizeOfChar('j'), 8);
}