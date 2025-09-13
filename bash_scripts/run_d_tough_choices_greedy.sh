#!/usr/bin/env bash
# Runs cpp_scripts/d_tough_choices_greedy.cpp on all instances/*.txt
# Usage: ./run_d_tough_choices_greedy.sh [SEED]
set -o pipefail

SEED="${1:-42}"

# Resolve repository paths relative to this script (which lives in bat_scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CPP_SRC="$ROOT_DIR/cpp_scripts/d_tough_choices_greedy.cpp"
BIN="$ROOT_DIR/cpp_scripts/d_tough_choices_greedy"
INST_DIR="$ROOT_DIR/instances"
OUT_DIR="$ROOT_DIR/output/d_tough_choices_greedy"

echo "========================================"
echo "Running D Tough Choices Greedy Solution"
echo "========================================"

# Compile
echo "Compiling d_tough_choices_greedy.cpp..."
if ! g++ -std=c++17 -O2 -o "$BIN" "$CPP_SRC"; then
  echo "ERROR: Compilation failed!"
  exit 1
fi
echo "Compilation successful."
echo

# Ensure output directory exists
mkdir -p "$OUT_DIR"

echo "Processing instances with seed: $SEED"
shopt -s nullglob
found_any=false
for f in "$INST_DIR"/*.txt; do
  found_any=true
  filename="$(basename "$f")"
  base="${filename%.*}"
  echo "Processing: $f"
  echo "  > Running algorithm..."
  if "$BIN" "$SEED" < "$f" > "$OUT_DIR/$base.out" 2> "$OUT_DIR/$base.log"; then
    echo "  > SUCCESS: $OUT_DIR/$base.out"
  else
    echo "  > ERROR: Algorithm failed for $f (see $OUT_DIR/$base.log)"
  fi
  echo
done

if [ "$found_any" = false ]; then
  echo "No instance files found in $INST_DIR (*.txt)."
fi

# Clean up executable
rm -f "$BIN"

echo "========================================"
echo "All instances processed!"
echo "Results saved in: $OUT_DIR"
echo "========================================"
