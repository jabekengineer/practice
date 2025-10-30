# CMake doesn't let you link to modules
add_library(short_type STATIC short_type.c)

# short_type.c needs this to get short_type.h
target_include_directories(short_type PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)