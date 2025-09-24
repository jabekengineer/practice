#!/usr/bin/env bash

set -e

CONCEPT=${1:-thruwire}
BUILD_DIR="build/fpga"
BITSTREAM="$BUILD_DIR/$CONCEPT.bin"

if [[ ! -f "$BITSTREAM" ]]; then
    echo "Error: Bitstream $BITSTREAM not found"
    echo "Run: make fpga-build CONCEPT=$CONCEPT first"
    exit 1
fi

echo "Programming ICEBreaker FPGA with: $BITSTREAM"

# Check if ICEBreaker is connected
if ! lsusb | grep -q "0403:6010"; then
    echo "⚠️  ICEBreaker FPGA not detected in container environment"
    echo "📋 To program your board, use one of these methods:"
    echo ""
    echo "Method 1 - Copy bitstream to host and program:"
    echo "  1. Copy this file to your host: $BITSTREAM"
    echo "  2. Run on host: iceprog $(basename $BITSTREAM)"
    echo ""
    echo "Method 2 - Run container with USB passthrough:"
    echo "  docker run --device=/dev/bus/usb ..."
    echo ""
    echo "Method 3 - Use --privileged flag with USB access"
    echo ""
    echo "🎯 Bitstream is ready at: $BITSTREAM"
    echo "📁 You can copy it with: docker cp <container>:$PWD/$BITSTREAM ."
    exit 0
fi

# Program the FPGA (if USB is available)
iceprog "$BITSTREAM"

echo "✅ FPGA programming complete!"
echo "🔍 Test your design on the ICEBreaker board"