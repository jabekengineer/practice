# Multi-stage Dockerfile for C development and demos
FROM ubuntu:22.04 AS base

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential C development tools
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    gdb \
    cmake \
    make \
    git \
    && rm -rf /var/lib/apt/lists/*

# Development stage with full toolchain
FROM base AS development

# Install additional development tools
RUN apt-get update && apt-get install -y \
    valgrind \
    lcov \
    gcovr \
    cppcheck \
    clang-format \
    clang-tidy \
    doxygen \
    vim \
    nano \
    tree \
    htop \
    man-db \
    manpages-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Set up non-root user for development
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

# Demo stage - minimal for running concepts
FROM base AS demo

# Set working directory and copy source
WORKDIR /workspace

# Copy source files (excluding build artifacts)
COPY --chown=root:root concepts/ /workspace/concepts/
COPY --chown=root:root tests/ /workspace/tests/
COPY --chown=root:root scripts/ /workspace/scripts/
COPY --chown=root:root CMakeLists.txt /workspace/
COPY --chown=root:root *.md /workspace/

# Make scripts executable
RUN chmod +x /workspace/scripts/build-and-test.sh

# Default working directory
WORKDIR /workspace