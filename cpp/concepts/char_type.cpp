#include "char_type.hpp"

#include <iostream>
#include <stdexcept>

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

void demo() { sizeOfChar('j'); }

#ifdef BUILD_EXECUTABLE
int main()
{
  demo();
  return 0;
}
#endif
