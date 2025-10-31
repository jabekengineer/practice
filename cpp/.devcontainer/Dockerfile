# cpp/.devcontainer/Dockerfile

FROM mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04

# Enhanced toolchain for learning loop
RUN apt-get update && \
    apt-get install -y \
    clang \
    llvm \
    cmake \
    gdb \
    valgrind \
    lcov \
    gcc \
    llvm-dev \
    libzstd-dev \
    tree \
    less \
    libgtest-dev \
    libgmock-dev \
    && rm -rf /var/lib/apt/lists/*

# Build GoogleTest properly
RUN cd /usr/src/googletest && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install
