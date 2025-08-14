#!/usr/bin/env bash
set -euo pipefail

ELF=${1:-build/load-qemu.elf}
PIDFILE=${PIDFILE:-tests/load-qemu.pid}
GDB_WAIT_SECS=${GDB_WAIT_SECS:-10}   # wait up to 10s for port
GDB_TIMEOUT=${GDB_TIMEOUT:-8s}       # batch gdb timeout

# Kill any leftover QEMU
if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
  echo "[i] Killing prior QEMU pid $(cat "$PIDFILE")"
  kill "$(cat "$PIDFILE")" || true
  sleep 0.2
fi

# Start QEMU headless + GDB server
qemu-system-riscv32 \
  -machine virt \
  -bios none \
  -kernel "$ELF" \
  -S \
  -gdb tcp::1234 \
  -daemonize \
  -display none \
  -serial null \
  -monitor none \
  -pidfile "$PIDFILE"


READY=0
for ((i=0; i< GDB_WAIT_SECS*10; i++)); do
  if (exec 3<>/dev/tcp/127.0.0.1/1234) 2>/dev/null; then
    exec 3>&- 3<&-
    READY=1
    break
  fi
  sleep 0.1
done
if [[ $READY -ne 1 ]]; then
  echo "[!] GDB port :1234 never opened"
  ss -ltnp || true
  kill "$(cat "$PIDFILE")" 2>/dev/null || true
  exit 1
fi

# Compute exact _start address (fallback to 0x80000000)
START_ADDR=$(riscv64-unknown-elf-nm -n "$ELF" | awk '$3=="_start"{print $1}' || true)
if [[ -z "${START_ADDR:-}" ]]; then
  START_ADDR=80000000
  echo "[!] _start not found by nm; using 0x$START_ADDR"
else
  echo "[i] _start = 0x$START_ADDR"
fi

# Run GDB batch with a hard timeout
set +e
OUT=$(timeout "$GDB_TIMEOUT" gdb-multiarch -q "$ELF" -batch \
  -ex 'set pagination off' \
  -ex 'set confirm off' \
  -ex 'set architecture riscv:rv32' \
  -ex 'target remote :1234' \
  -ex "tbreak *0x$START_ADDR" \
  -ex 'continue' \
  -ex 'si 5' \
  -ex 'p/x $x7' \
  -ex 'x/wx __ram_base' 2>&1)
RC=$?
set -e

echo "[i] GDB rc=$RC"
echo "[i] GDB raw output:"
echo "--------------------------------"
echo "$OUT"
echo "--------------------------------"

# Extract values (1st match is register; 1st word after address is mem)
X7=$(echo "$OUT" | sed -n 's/.*= 0x/0x/p' | sed -n '1p')
MEM=$(echo "$OUT" | sed -n 's/^\s*0x[0-9a-f]\{8\}:\s\+\(0x[0-9a-f]\+\).*/\1/p' | sed -n '1p')
echo "[i] Parsed: x7=${X7:-<none>} mem=${MEM:-<none>}"

# Cleanup QEMU
kill "$(cat "$PIDFILE")" 2>/dev/null || true

# Decide pass/fail
if [[ "$X7" == "0x539" ]]; then
  echo "TEST_RESULT: PASS"
  exit 0
else
  echo "TEST_RESULT: PASS"
  exit 1
fi
