# Standard practice: explicitly list source files instead of globbing
add_library(concepts STATIC
    hello.c
    numbers/short_type.c
)

# Make headers available to other targets
target_include_directories(concepts PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)