# cpp/tests/CMakeLists.txt
add_executable(test_char test_char.cpp)

target_link_libraries(test_char
char
GTest::gtest
GTest::gtest_main
)

add_test(NAME test_char COMMAND test_char)
set_tests_properties(test_char PROPERTIES
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)


add_executable(test_int test_int.cc)

# Find LLVM
find_package(LLVM REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")

# Find zstd separately to avoid CMake target issues
find_package(PkgConfig REQUIRED)
pkg_check_modules(ZSTD REQUIRED libzstd)

# Link LLVM libraries
llvm_map_components_to_libnames(llvm_libs core)

target_link_libraries(test_int
    int
    GTest::gtest
    GTest::gtest_main
    ${llvm_libs}
    ${ZSTD_LIBRARIES}
)

# LLVM compile definitions and include directories
target_compile_definitions(test_int PRIVATE ${LLVM_DEFINITIONS})
target_include_directories(test_int PRIVATE ${LLVM_INCLUDE_DIRS})
target_include_directories(test_int PRIVATE ${ZSTD_INCLUDE_DIRS})
target_compile_options(test_int PRIVATE ${ZSTD_CFLAGS_OTHER})

add_test(NAME test_int COMMAND test_int)
