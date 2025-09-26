FROM ubuntu:22.04 AS base

RUN apt-get update && apt-get install -y \
    gcc-arm-linux-gnueabi \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

CMD ["echo", "hi"]