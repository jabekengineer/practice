cmake_minimum_required(VERSION 3.14)
project(CppConcepts C CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3 -fno-omit-frame-pointer -fno-inline")
set(CMAKE_CXX_FLAGS_LLVMIR "-O0 -g -emit-llvm")
set(CMAKE_CXX_FLAGS_ASAN "-O0 -g -fno-omit-frame-pointer -fsanitize=address -fno-optimize-sibling-calls")
set(CMAKE_CXX_FLAGS_COVERAGE "-O0 -g --coverage -fprofile-arcs -ftest-coverage")

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

enable_testing()
find_package(GTest REQUIRED)

find_package(LLVM REQUIRED CONFIG)
find_package(PkgConfig REQUIRED)
pkg_check_modules(ZSTD REQUIRED libzstd)

add_custom_target(llvm-ir
    COMMENT "Generate LLVM IR for inspection"
)

add_custom_target(coverage
    COMMENT "Generate coverage reports"
)

add_subdirectory(concepts)
add_subdirectory(tests)
