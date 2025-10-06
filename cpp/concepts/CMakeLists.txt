add_library(char_type_lib char_type.cpp)
add_executable(char_type_demo char_type.cpp)
target_compile_definitions(char_type_demo PRIVATE BUILD_EXECUTABLE)

