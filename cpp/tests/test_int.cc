#include <gtest/gtest.h>
#include "../concepts/int.hpp"

TEST(CoreTypes, SignednessModifiers)
{
    EXPECT_NO_THROW(singleModifierDeclarations<signed>());
    auto a = singleModifierDeclarations<signed>();
    EXPECT_STREQ(typeid(a).name(), "i");
    EXPECT_NO_THROW(singleModifierDeclarations<unsigned>());
    auto b = singleModifierDeclarations<unsigned>();
    EXPECT_STREQ(typeid(b).name(), "j");
}
