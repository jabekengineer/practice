#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
  echo 'Usage: build-and-test.sh <concept>'
  echo 'Example: build-and-test.sh load'
  exit 1
fi

concept=$1

# Check if concept files exist
if [[ ! -f "concepts/${concept}.s" ]]; then
  echo "Error: concepts/${concept}.s not found"
  exit 1
fi

if [[ ! -f "rtl/${concept}.v" ]]; then
  echo "Error: rtl/${concept}.v not found"
  exit 1
fi

if [[ ! -f "sim/${concept}.c" ]]; then
  echo "Error: sim/${concept}.c not found"
  exit 1
fi

echo "Building and testing concept: ${concept}"

# Verify tools
echo "Checking tools..."
qemu-system-riscv32 --version > /dev/null || { echo "qemu-system-riscv32 not found"; exit 1; }
riscv64-unknown-elf-gcc --version > /dev/null || { echo "riscv64-unknown-elf-gcc not found"; exit 1; }
verilator --version > /dev/null || { echo "verilator not found"; exit 1; }

# Clean and build
echo "Building..."
make clean
make CONCEPT=$concept all

# RunTest QEMU (with timeout)
echo "Running QEMU..."
timeout 5s make CONCEPT=$concept run-qemu > build/${concept}.qemu.out 2>&1 &

# Run simulator
echo "Running simulator..."
make CONCEPT=$concept sim > build/${concept}.sim.out 2>&1

# Rest simulator results
echo "Running tests..."
tests/$concept.qemu.sh > build/${concept}.qemu.out 2>&1 &

sleep 2

emu_result=$(grep -oP 'TEST_RESULT: \K\w+' build/${concept}.qemu.out)
sim_result=$(grep -oP 'TEST_RESULT: \K\w+' build/${concept}.sim.out)
if [[ "$emu_result" == "PASS" && "$sim_result" == "PASS" ]]; then
  echo "All tests passed!"
  exit 0
else
  echo "Tests failed!"
  echo "QEMU result: $emu_result"
  echo "Simulator result: $sim_result"
  exit 1
fi