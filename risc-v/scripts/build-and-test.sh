#!/usr/bin/env bash
set -euo pipefail

concept="${1:-hello}"
shift || true

# Allow per-concept expected output; default is a simple 'Hello' check
case "$concept" in
  hello) expected_regex='Hello, RISC-V World!' ;;
  *)     expected_regex='PASS|Success|OK|Hello' ;;
esac

# Clean & build
echo "🔧 Building concept: ${concept}"
if make -q "${concept}" 2>/dev/null; then
  : # target exists
else
  # fallback to a conventional build if your Makefile expects a var
  make clean || true
  make CONCEPT="${concept}"
fi

elf="build/${concept}.elf"
[[ -f "$elf" ]] || { echo "❌ Expected ELF not found: $elf"; exit 1; }

# Run with a timeout so a non‑exiting program can't hang CI
# -bios default gives you OpenSBI, which many demos expect
echo "▶️  Running under QEMU (concept=${concept})…"
rm -f "build/${concept}.log"
set +e
timeout 10s qemu-system-riscv32 \
  -M virt -nographic -bios default -kernel "$elf" \
  "$@" | tee "build/${concept}.log"
rc=$?
set -e

if [[ $rc -eq 124 ]]; then
  echo "⏱️  QEMU timed out (program may not be exiting)."
  exit 124
fi

# Basic assertion on output
if grep -E -q "$expected_regex" "build/${concept}.log"; then
  echo "✅ Output matched: /$expected_regex/"
  exit 0
else
  echo "❌ Output did not match: /$expected_regex/"
  echo "----- BEGIN OUTPUT -----"
  sed -n '1,200p' "build/${concept}.log"
  echo "------ END OUTPUT ------"
  exit 2
fi
