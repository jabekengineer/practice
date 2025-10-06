# cpp/.devcontainer/Dockerfile

FROM mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04

# Install extra packages if you want:
# Clang, CMake, Ninja, Valgrind, GDB, etc.
RUN apt-get update && \
    apt-get install -y \
      clang \
      cmake \
      ninja-build \
      gdb \
      valgrind \
      lcov

# If you want GoogleTest system-wide, you could build/install it here,
# but your CMake FetchContent is good enough for now.
