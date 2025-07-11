#include <iostream>

int main()
{
  char c = 'a';
  int ascii_value = c;
  std::cout << "Char: " << c << std::endl;
  std::cout << "ASCII value: " << ascii_value << std::endl;
  
  char c2 = 98;
  std::cout << "Char from int: " << c2 << std::endl;

  // non-printable character
  char newline = '\n';
  std::cout << "Newline char (escaped): " << "\\n" << std::endl;

  if (c != 'a') return 1;
  if (ascii_value != 97) return 1;
  if (c2 != 'b') return 1;
  
  std::cout << "All checks passed." << std::endl;
  return 0;
}
