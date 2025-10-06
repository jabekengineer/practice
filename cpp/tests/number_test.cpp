#include <gtest/gtest.h>

class NumberTypes : public ::testing::Test {
 protected:
  char minChar, maxChar;
  short int minShort, maxShort;

  void SetUp() override {
    char minChar = std::numeric_limits<char>::min();
    char maxChar = std::numeric_limits<char>::max();

    short int minShort = std::numeric_limits<short>::min();
    short int maxShort = std::numeric_limits<short>::max();
  }
};

/**
 * Char type tests
 */

TEST_F(NumberTypes, CharRange) {
  std::vector<char> range = {minChar, maxChar};
  std::vector<char> expected = {-128, 127};
  EXPECT_EQ(range, expected);
}
TEST_F(NumberTypes, CharOverflow) { EXPECT_EQ(maxChar + 1, minChar); }
TEST_F(NumberTypes, CharUnderflow) { EXPECT_EQ(minChar - 1, maxChar); }
TEST_F(NumberTypes, CharSizeIs1) { EXPECT_EQ(sizeof(char), 1); }

/**
 * Short type tests
 */

TEST_F(NumberTypes, EqualsPermitsNarrowingConversion) {
  int i = 7.2;
  EXPECT_EQ(i, 7);
}

TEST_F(NumberTypes, IntSizeIs4) { EXPECT_EQ(sizeof(int), 4); }

TEST_F(NumberTypes, BracePreventsNarrowingConversion) {
  // This test will not compile if uncommented, as intended.
  // int i{7.2};
  // EXPECT_EQ(i, 7);
}

TEST_F(NumberTypes, AutoDeducesType) {
  auto x = 5.5;
  // Runtime Type Information
  const std::type_info& ti = typeid(x);

  EXPECT_EQ(ti, typeid(double));
}

TEST_F(NumberTypes, AutoWithBracesIsUnnecessary) {
  auto x{5.5};
  const std::type_info& ti = typeid(x);
  EXPECT_EQ(ti, typeid(double));
}