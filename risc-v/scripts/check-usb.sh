#!/usr/bin/env bash

echo "🔍 USB Device Detection Check"
echo "=============================="

echo "📋 All USB devices:"
lsusb

echo ""
echo "🎯 Looking for ICEBreaker (FTDI 0403:6010 or 0403:6014):"
if lsusb | grep -E "0403:(6010|6014)"; then
    echo "✅ ICEBreaker detected!"
else
    echo "❌ ICEBreaker not found"
fi

echo ""
echo "📁 USB device files:"
ls -la /dev/bus/usb/001/ /dev/bus/usb/002/ 2>/dev/null || echo "No USB device files found"

echo ""
echo "🔧 Testing iceprog:"
if command -v iceprog >/dev/null 2>&1; then
    echo "✅ iceprog available at: $(which iceprog)"
    echo "🧪 Testing iceprog detection:"
    iceprog 2>&1 | head -5
else
    echo "❌ iceprog not found"
fi