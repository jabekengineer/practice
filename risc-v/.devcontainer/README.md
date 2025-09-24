# RISC-V Development Container

This development container provides a complete RISC-V and FPGA development environment with highly optimized build performance.

## Features

- **FPGA Tools**: Yosys, nextpnr-ice40, icestorm (via OSS CAD Suite)
- **RISC-V Toolchain**: GCC cross-compiler and tools
- **Simulation**: Verilator, QEMU, GDB
- **Fast Builds**: Docker Compose + Bake with aggressive caching

## Performance

- **First build**: ~5 minutes (vs 30-60+ minutes building from source)
- **Subsequent rebuilds**: <1 second (with full layer caching)
- **Tool downloads**: Cached in persistent volumes

## Quick Start

### Option 1: VS Code (Recommended)
1. Open this folder in VS Code
2. `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"
3. Wait for container to start (very fast after first build)

### Option 2: Manual Build
```bash
cd .devcontainer
./build.sh
```

## File Structure

```
.devcontainer/
├── Dockerfile           # Optimized with pre-built tools
├── docker-compose.yml   # Volume caching configuration
├── devcontainer.json    # VS Code integration
├── .env                 # Docker Bake optimization
└── build.sh             # Quick build script
```

## Tools Available

- `yosys` - Synthesis
- `nextpnr-ice40` - Place & route for ice40 FPGAs
- `iceprog` - FPGA programming
- `riscv64-unknown-elf-gcc` - RISC-V compiler
- `verilator` - Verilog simulation
- `qemu-system-riscv32` - RISC-V emulation

## Volume Caching

The setup uses persistent Docker volumes to cache:
- `/opt/oss-cad-suite` → `risc-v-tools-cache`
- `/opt/riscv` → `risc-v-riscv-cache` 
- `/tmp/build-cache` → `risc-v-build-cache`

This dramatically speeds up container rebuilds and tool access.

## Advanced Usage

### Manual Docker Compose
```bash
# Build with caching
docker-compose build

# Start development container
docker-compose up -d
docker-compose exec risc-v-dev bash

# Clean up
docker-compose down
```

### Environment Variables
The `.env` file configures Docker Bake optimizations:
- `COMPOSE_BAKE=true` - Use Docker Bake for faster builds
- `BUILDKIT_PROGRESS=plain` - Better build output
- `DOCKER_BUILDKIT=1` - Enable BuildKit features

## Troubleshooting

### Slow initial build
- First build downloads ~2GB of tools - this is normal
- Subsequent builds use cached layers and are <1 second

### Container won't start
- Try: "Dev Containers: Rebuild Container"
- Or manually: `docker-compose build --no-cache`

### Missing tools
- Verify with: `docker-compose run --rm risc-v-dev which yosys`
- All tools should be in `/opt/oss-cad-suite/bin` or `/opt/riscv/bin`