# tests must be executable

add_executable(test_short test_short_type.cpp)

# test need a main function to run
# ctest runs tests as standalone programs with return codes
target_link_libraries(test_short
short_type
GTest::gtest
GTest::gtest_main
)

add_test(NAME test_short COMMAND test_short)
set_tests_properties(test_short PROPERTIES
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)