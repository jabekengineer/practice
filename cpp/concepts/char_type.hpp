#pragma once
#include <bitset>
#include <typeinfo>
#include <utility>
/** Basic Types & Ranges */
const std::pair<bool, signed char> isInRange(const signed char val);
const std::pair<bool, unsigned char> isInRangeU(const unsigned char val);

const std::bitset<8U> binaryFromChar(const char val);
const size_t sizeOfChar(const char val);
const size_t bitsPerChar(const char val);

const std::type_info& defaultCharType();

void demo();