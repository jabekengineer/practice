cmake_minimum_required(VERSION 3.14)
project(c_concepts C CXX)

# Set C standard
set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Set C++ standard (for GoogleTest)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable testing
enable_testing()

# GoogleTest
find_package(PkgConfig REQUIRED)
find_package(GTest REQUIRED)

add_subdirectory(concepts)
add_subdirectory(tests)