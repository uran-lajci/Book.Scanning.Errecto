#!/usr/bin/env bash
# Runs cpp_scripts/two_phase_approach.cpp on all instances/*.txt (now passes a seed)
# Usage: ./run_two_phase_no_seed.sh [SEED]   # default 101
set -o pipefail

SEED="${1:-101}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CPP_SRC="$ROOT_DIR/cpp_scripts/two_phase_approach.cpp"
BIN="$ROOT_DIR/cpp_scripts/two_phase_approach"
INST_DIR="$ROOT_DIR/instances"
OUT_DIR="$ROOT_DIR/output/two_phase_approach_1010_seed"

echo "========================================"
echo "Running Two Phase Approach Solution (seed=$SEED)"
echo "========================================"

echo "Compiling two_phase_approach.cpp..."
if ! g++ -std=c++17 -O2 -o "$BIN" "$CPP_SRC"; then
  echo "ERROR: Compilation failed!"
  exit 1
fi
echo "Compilation successful."
echo

mkdir -p "$OUT_DIR"
echo "Processing instances... (local search may take a while)"
echo

shopt -s nullglob
found_any=false
for f in "$INST_DIR"/*.txt; do
  found_any=true
  base="$(basename "${f%.txt}")"
  echo "Processing: $f"
  start_hms="$(date +%T)"; start_ts="$(date +%s)"

  if "$BIN" "$SEED" < "$f" > "$OUT_DIR/$base.out" 2> "$OUT_DIR/$base.log"; then
    end_hms="$(date +%T)"; end_ts="$(date +%s)"; dur=$((end_ts - start_ts))
    echo "  > SUCCESS: $OUT_DIR/$base.out"
    echo "  > Runtime: $start_hms to $end_hms (${dur}s)"
  else
    echo "  > ERROR: Algorithm failed for $f (see $OUT_DIR/$base.log)"
  fi
  echo
done

if [ "$found_any" = false ]; then
  echo "No instance files found in $INST_DIR (*.txt)."
fi

rm -f "$BIN"

echo "========================================"
echo "All instances processed!"
echo "Results saved in: $OUT_DIR"
echo "========================================"
