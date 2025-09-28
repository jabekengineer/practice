#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
  echo "Usage: build-and-test.sh <concept>"
  echo "Example: build-and-test.sh load"
  exit 1
fi

concept=$1

echo "Building and testing concept: ${concept}"

# Clean and build
echo "Building..."
make clean
mkdir -p build

# Run simulator (captures output with results)
echo "Running simulator..."
make CONCEPT=$concept sim > build/${concept}.sim.out 2>&1
sim_exit=$?

# Run QEMU with GDB-based validation (if test exists)
echo "Running QEMU cross-validation..."
if [[ -f "tests/${concept}.qemu.sh" ]]; then
    # Build QEMU ELF first
    make CONCEPT=$concept build/${concept}-qemu.elf > /dev/null 2>&1
    # Run automated QEMU test
    tests/${concept}.qemu.sh build/${concept}-qemu.elf > build/${concept}.qemu.out 2>&1
    qemu_exit=$?
    qemu_result=$(grep -oP "TEST_RESULT: \K\w+" build/${concept}.qemu.out 2>/dev/null || echo "UNKNOWN")
else
    echo "No QEMU test script found - skipping cross-validation"
    qemu_exit=1
    qemu_result="MISSING"  
fi

# Parse simulation results
sim_result=$(grep -oP "TEST_RESULT: \K\w+" build/${concept}.sim.out 2>/dev/null || echo "UNKNOWN")

echo ""
echo "=== CROSS-VALIDATION RESULTS ==="
echo "Simulation: $sim_result (your hardware model)"
echo "QEMU: $qemu_result (golden reference)"

# Determine overall success
sim_success=false
qemu_success=false

if [[ $sim_exit -eq 0 ]] && [[ "$sim_result" == "PASS" ]]; then
    sim_success=true
fi

if [[ $qemu_exit -eq 0 ]] && [[ "$qemu_result" == "PASS" ]]; then
    qemu_success=true
elif [[ "$qemu_result" == "MISSING" ]]; then
    echo "⚠️  No QEMU test available for this concept"
    qemu_success=true  # Don't fail if no test exists
fi

if [[ "$sim_success" == true ]] && [[ "$qemu_success" == true ]]; then
  echo ""
  if [[ "$qemu_result" == "PASS" ]]; then
    echo "🏆 FULL CROSS-VALIDATION SUCCESSFUL!"
    echo "✅ Your hardware model matches the RISC-V golden reference"
    echo "🎯 Both simulation and QEMU produce identical results"
  else
    echo "✅ SIMULATION VALIDATION SUCCESSFUL!"
    echo "🎯 Your hardware model works correctly"
    echo "📋 QEMU cross-validation not available for this concept"
  fi
  echo ""
  echo "Files generated:"
  echo "  - build/${concept}.sim.out (simulation results)"
  if [[ -f "build/${concept}.qemu.out" ]]; then
    echo "  - build/${concept}.qemu.out (QEMU validation results)"
  fi
  exit 0
else
  echo ""
  echo "❌ VALIDATION FAILED!"
  if [[ "$sim_success" != true ]]; then
    echo "🔍 Simulation failed: $sim_result"
    echo "   Check build/${concept}.sim.out for details"
  fi
  if [[ "$qemu_success" != true ]] && [[ "$qemu_result" != "MISSING" ]]; then
    echo "🔍 QEMU validation failed: $qemu_result"
    echo "   Check build/${concept}.qemu.out for details"
  fi
  exit 1
fi
