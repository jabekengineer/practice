#!/usr/bin/env bash

echo "🚀 Testing ICEBreaker Programming"
echo "================================="

# Check USB detection
echo "1. Checking USB devices..."
./scripts/check-usb.sh

echo ""
echo "2. Testing FPGA programming..."
if lsusb | grep -E "0403:(6010|6014)"; then
    echo "✅ ICEBreaker detected! Attempting to program..."
    make fpga-program CONCEPT=thruwire
else
    echo "❌ ICEBreaker not found. Please follow USB setup steps."
    echo ""
    echo "📋 Setup checklist:"
    echo "  □ ICEBreaker connected to Windows USB port"
    echo "  □ usbipd-win installed on Windows"
    echo "  □ USB device attached to WSL with usbipd"
    echo "  □ Container restarted after USB attachment"
fi