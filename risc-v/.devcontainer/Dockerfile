FROM ubuntu:latest

# Install basic dependencies - minimal set
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    xz-utils \
    git \
    build-essential \
    python3 \
    python-is-python3 \
    verilator \
    gdb-multiarch \
    qemu-system-misc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install OSS CAD Suite (pre-compiled FPGA tools) - MUCH faster than building from source
# This includes Yosys, nextpnr, icestorm, and many other tools
RUN wget -O oss-cad-suite.tgz "https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2024-03-13/oss-cad-suite-linux-x64-20240313.tgz" && \
    tar -xzf oss-cad-suite.tgz -C /opt && \
    rm oss-cad-suite.tgz

# Add OSS CAD Suite tools to PATH
ENV PATH="/opt/oss-cad-suite/bin:${PATH}"

# Install RISC-V toolchain (pre-built)
RUN wget -q https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2023.10.18/riscv64-elf-ubuntu-22.04-gcc-nightly-2023.10.18-nightly.tar.gz && \
    tar -xzf riscv64-elf-ubuntu-22.04-gcc-nightly-2023.10.18-nightly.tar.gz -C /opt && \
    rm riscv64-elf-ubuntu-22.04-gcc-nightly-2023.10.18-nightly.tar.gz

# Add RISC-V tools to PATH
ENV PATH="/opt/riscv/bin:${PATH}"

# Set working directory
WORKDIR /workspaces/practice/risc-v

# Simple healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD [ "which", "yosys" ]