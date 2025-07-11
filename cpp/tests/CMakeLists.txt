# cpp/tests/CMakeLists.txt

# Download GoogleTest if needed
if(POLICY CMP0135)
  cmake_policy(SET CMP0135 NEW)
endif()
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/heads/main.zip
)
# For Windows: prevent overriding parent project flags
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

add_executable(char_test char_test.cpp)
target_link_libraries(char_test gtest_main)

include(GoogleTest)
gtest_discover_tests(char_test)
