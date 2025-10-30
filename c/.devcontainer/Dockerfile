FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    gcc-arm-linux-gnueabi \
    build-essential \
    cmake \
    git \
    clang-format \
    pkg-config \
    libgtest-dev \
    libgmock-dev \
    && rm -rf /var/lib/apt/lists/*

RUN cd /usr/src/gtest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib