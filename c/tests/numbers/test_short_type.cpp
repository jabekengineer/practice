#include <gtest/gtest.h>
extern "C" {
    #include "numbers/short_type.h"
}

class SizeTest : public testing::Test {
public:
    const unsigned short int zero = 0;
    const signed short int upper = 32767;
    const signed short int lower = -32768;
};

TEST_F(SizeTest, ShortIsAtLeast16Bits) {
    EXPECT_GE(sizeof(zero), 2);
}

TEST_F(SizeTest, SignedShortOverflowWrapsAround) {
    signed short int max_val = 32767;
    signed short int overflow_result = max_val + 1;

    // Signed overflow is undefined behavior, but typically wraps to minimum
    // This test documents the typical behavior on most systems
    EXPECT_EQ(overflow_result, -32768);
}

TEST_F(SizeTest, SignedShortUnderflowWrapsAround) {
    signed short int min_val = -32768;
    signed short int underflow_result = min_val - 1;

    // Underflow typically wraps to maximum
    EXPECT_EQ(underflow_result, 32767);
}

TEST_F(SizeTest, UnsignedShortOverflowWrapsToZero) {
    unsigned short int max_val = 65535;
    unsigned short int overflow_result = max_val + 1;

    // Unsigned overflow is well-defined: wraps to 0
    EXPECT_EQ(overflow_result, 0);
}

TEST_F(SizeTest, UnsignedShortUnderflowWrapsToMax) {
    unsigned short int min_val = 0;
    unsigned short int underflow_result = min_val - 1;

    // Unsigned underflow wraps to maximum value
    EXPECT_EQ(underflow_result, 65535);
}

TEST_F(SizeTest, ExceedContainerWithLargerType) {
    int too_large_for_short = 100000;  // Exceeds short range
    signed short int truncated = (signed short int)too_large_for_short;

    // When casting, value gets truncated
    EXPECT_NE(truncated, too_large_for_short);
    EXPECT_EQ(truncated, (signed short int)(too_large_for_short & 0xFFFF));
}

TEST_F(SizeTest, ShortSizeIsSystemDependent) {
    // short is guaranteed to be at least 16 bits (2 bytes) by C standard
    EXPECT_GE(sizeof(short), 2);

    // On most modern systems, short is exactly 2 bytes
    // But this could vary on exotic architectures
    size_t short_size = sizeof(short);
    EXPECT_TRUE(short_size == 2 || short_size == 4 || short_size == 8);

    // Document what we found on this system
    printf("sizeof(short) on this system: %zu bytes\n", short_size);
}

TEST_F(SizeTest, ShortVsIntSizeRelationship) {
    // C standard guarantees: sizeof(short) <= sizeof(int) <= sizeof(long)
    EXPECT_LE(sizeof(short), sizeof(int));
    EXPECT_LE(sizeof(int), sizeof(long));

    // On most systems: short=2, int=4, but this can vary
    printf("Size relationship - short:%zu int:%zu long:%zu\n",
           sizeof(short), sizeof(int), sizeof(long));
}

TEST_F(SizeTest, ShortRangeBasedOnActualSize) {
    // Calculate the actual range based on sizeof(short) for this system
    size_t short_bits = sizeof(short) * 8;

    // For signed short: -(2^(n-1)) to (2^(n-1))-1
    long long expected_max = (1LL << (short_bits - 1)) - 1;
    long long expected_min = -(1LL << (short_bits - 1));

    // Verify our test constants match the actual system
    EXPECT_EQ(static_cast<long long>(upper), expected_max);
    EXPECT_EQ(static_cast<long long>(lower), expected_min);

    printf("Short range on this system: %lld to %lld (%zu bits)\n",
           expected_min, expected_max, short_bits);
}

TEST_F(SizeTest, PortableShortUsage) {
    // Best practice: use sizeof(short) for portable code
    char buffer[sizeof(short) * 3 + 1]; // Enough for any short value as string

    // This works regardless of whether short is 2, 4, or 8 bytes
    snprintf(buffer, sizeof(buffer), "%hd", upper);

    // Verify we can format the maximum value
    EXPECT_STREQ(buffer, "32767"); // Assuming 16-bit short on most systems
}

class PrintTest : public testing::Test {
protected:
    char* out;
    size_t bufSize;
    unsigned short int cShort_u;
    signed short int cShort_s;
    void SetUp() override
    {
        bufSize = 8; // 2 bytes plus null terminator for values under 17
        out = new char[bufSize];
        cShort_u = 1337;
        cShort_s = 1337;
    }

    void TearDown() override
    {
        delete[] out;
    }
};

TEST_F(PrintTest, IAndDFormatSpecifiersAreTheSame) {
    format_short_hd(out, bufSize, cShort_s);
    std::string result_hd(out);

    format_short_hi(out, bufSize, cShort_s);
    std::string result_hi(out);
    EXPECT_STREQ(result_hd.c_str(), result_hi.c_str());
}

TEST_F(PrintTest, HUFormatSpecifier) {
    format_short_hu(out, bufSize, cShort_u);
    EXPECT_STREQ(out, "1337");
}

TEST_F(PrintTest, HXFormatSpecifier) {
    format_short_hx(out, bufSize, cShort_u);
    EXPECT_STREQ(out, "539");  // 1337 in hex is '539'
}

TEST_F(PrintTest, HUWithLargeValue) {
    unsigned short int large_val = 65535;  // Max unsigned short
    format_short_hu(out, bufSize, large_val);
    EXPECT_STREQ(out, "65535");
}

TEST_F(PrintTest, HXWithLargeValue) {
    unsigned short int large_val = 65535;  // Max unsigned short
    format_short_hx(out, bufSize, large_val);
    EXPECT_STREQ(out, "ffff");  // 65535 in hex is 'ffff'
}

TEST_F(PrintTest, HUWithZero) {
    format_short_hu(out, bufSize, 0);
    EXPECT_STREQ(out, "0");
}

TEST_F(PrintTest, HXWithZero) {
    format_short_hx(out, bufSize, 0);
    EXPECT_STREQ(out, "0");
}

TEST_F(PrintTest, HXProducesLowerCaseHex) {
    unsigned short int hex_val = 255;  // Will produce 'ff'
    format_short_hx(out, bufSize, hex_val);
    EXPECT_STREQ(out, "ff");

    // Verify it's lowercase
    for (char* c = out; *c; ++c) {
        if (*c >= 'a' && *c <= 'f') {
            EXPECT_GE(*c, 'a');  // Should be lowercase
            EXPECT_LE(*c, 'f');
        }
    }
}