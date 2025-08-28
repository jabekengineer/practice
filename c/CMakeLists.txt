cmake_minimum_required(VERSION 3.16)
project(CPractice VERSION 1.0.0 LANGUAGES C)

# Set C standard
set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wextra -Wpedantic")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g -O0")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O3 -DNDEBUG")

# Enable testing
enable_testing()

# Include directories
include_directories(${CMAKE_SOURCE_DIR}/concepts)

# Find all concept source files
file(GLOB CONCEPT_SOURCES "concepts/*.c")
file(GLOB CONCEPT_HEADERS "concepts/*.h")

# Create a library from all concept sources
add_library(concepts STATIC ${CONCEPT_SOURCES})
target_include_directories(concepts PUBLIC concepts)

# Find all test files
file(GLOB TEST_SOURCES "tests/test_*.c")

# Create test executables
foreach(TEST_SOURCE ${TEST_SOURCES})
    # Get the test name from filename
    get_filename_component(TEST_NAME ${TEST_SOURCE} NAME_WE)
    
    # Extract concept name (remove "test_" prefix)
    string(REGEX REPLACE "^test_" "" CONCEPT_NAME ${TEST_NAME})
    
    # Create executable
    add_executable(${TEST_NAME} ${TEST_SOURCE})
    
    # Link with concepts library
    target_link_libraries(${TEST_NAME} concepts)
    
    # Add as test
    add_test(NAME ${CONCEPT_NAME} COMMAND ${TEST_NAME})
    
    # Set test properties
    set_tests_properties(${CONCEPT_NAME} PROPERTIES
        TIMEOUT 30
        LABELS "unit"
    )
endforeach()

# Custom target to run all tests
add_custom_target(check
    COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure --verbose
    DEPENDS ${TEST_TARGETS}
    COMMENT "Running all tests"
)

# Memory check target (if Valgrind is available)
find_program(VALGRIND_EXECUTABLE valgrind)
if(VALGRIND_EXECUTABLE)
    add_custom_target(memcheck
        COMMAND ${CMAKE_CTEST_COMMAND} 
            --output-on-failure 
            --verbose 
            -T memcheck
        DEPENDS ${TEST_TARGETS}
        COMMENT "Running memory checks"
    )
endif()

# Code coverage (if gcov is available)
option(ENABLE_COVERAGE "Enable code coverage" OFF)
if(ENABLE_COVERAGE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} --coverage")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --coverage")
endif()

# Print configuration info
message(STATUS "C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "C Standard: ${CMAKE_C_STANDARD}")
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "Valgrind Found: ${VALGRIND_EXECUTABLE}")

# Installation (optional)
install(TARGETS concepts
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

install(FILES ${CONCEPT_HEADERS}
    DESTINATION include/concepts
)
