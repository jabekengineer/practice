FROM ubuntu:22.04 AS base

RUN apt-get update && apt-get install -y \
    gcc-arm-linux-gnueabi \
    && rm -rf /var/lib/apt/lists/*

# Default working directory
WORKDIR /workspace
CMD ["echo", "hi"]