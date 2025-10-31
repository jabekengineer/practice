add_library(char STATIC char.cpp)
target_include_directories(char PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_library(int STATIC int.cpp)
target_include_directories(int PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
