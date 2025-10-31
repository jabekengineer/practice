#pragma once
#include <typeinfo>

template <typename SignedUnsigned>
const SignedUnsigned singleModifierDeclarations()
{
    signed sVal = -2;
    unsigned uVal = 1;
    return typeid(SignedUnsigned).name() == "i" ? sVal : uVal;
}

struct IntegerSizes
{
    short s;
    int i;
    long l;
    long long ll;
};

void createObjects();
