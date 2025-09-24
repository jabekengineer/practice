#!/usr/bin/env bash

set -e

CONCEPT=${1:-thruwire}
BUILD_DIR="build/fpga"
RTL_DIR="rtl"
CONSTRAINTS_DIR="constraints"

echo "Building FPGA bitstream for: $CONCEPT"

# Create build directory
mkdir -p "$BUILD_DIR"

# Check if files exist
if [[ ! -f "$RTL_DIR/$CONCEPT.v" ]]; then
    echo "Error: $RTL_DIR/$CONCEPT.v not found"
    exit 1
fi

if [[ ! -f "$CONSTRAINTS_DIR/$CONCEPT.pcf" ]]; then
    echo "Error: $CONSTRAINTS_DIR/$CONCEPT.pcf not found"
    exit 1
fi

echo "Step 1: Synthesis with Yosys..."
yosys -p "
    read_verilog $RTL_DIR/$CONCEPT.v;
    synth_ice40 -top $CONCEPT -json $BUILD_DIR/$CONCEPT.json;
"

echo "Step 2: Place & Route with nextpnr..."
nextpnr-ice40 \
    --up5k \
    --package sg48 \
    --json "$BUILD_DIR/$CONCEPT.json" \
    --pcf "$CONSTRAINTS_DIR/$CONCEPT.pcf" \
    --asc "$BUILD_DIR/$CONCEPT.asc"

echo "Step 3: Generate bitstream with icepack..."
icepack "$BUILD_DIR/$CONCEPT.asc" "$BUILD_DIR/$CONCEPT.bin"

echo "✅ Bitstream generated: $BUILD_DIR/$CONCEPT.bin"
echo "📦 Ready to program ICEBreaker FPGA!"