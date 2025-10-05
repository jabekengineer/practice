# Standard practice: explicitly list test files and link against the concepts library
add_executable(test_hello test_hello.cpp)

# Link against GoogleTest and our concepts library
target_link_libraries(test_hello 
PRIVATE
gtest_main
concepts
)

# Register test with CTest
add_test(NAME test_hello COMMAND test_hello)

add_subdirectory(numbers)