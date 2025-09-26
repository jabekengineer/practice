#include <gtest/gtest.h>
extern "C" {
    #include "hello.h"
}

TEST(HelloTest, GetHelloMessage) {
    const char* message = get_greeting();
    EXPECT_STREQ(message, "Hello, World");
}

TEST(HelloTest, MessageIsNotNull) {
    const char* message = get_greeting();
    EXPECT_NE(message, nullptr);
}