#include <gtest/gtest.h>

TEST(CharConceptTest, CharLiteralEqualsAscii) {
  char c = 'a';
  EXPECT_EQ(c, 97);
}

TEST(CharConceptTest, IntToCharConversion) {
  char c = 98;
  EXPECT_EQ(c, 'b');
}

TEST(CharConceptTest, NewlineChar) {
  char newline = '\n';
  EXPECT_EQ(newline, 10);
}
