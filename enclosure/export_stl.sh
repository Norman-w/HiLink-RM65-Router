#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
MODEL="$SCRIPT_DIR/rm65_kit_enclosure.scad"
OUT="$SCRIPT_DIR/build"

mkdir -p "$OUT"

for PART in bottom top foot_pad
do
  openscad -o "$OUT/rm65_kit_${PART}.stl" \
    -D "part=\"$PART\"" "$MODEL"
done

# Browser-only mesh in native SCAD assembly coordinates. The downloadable
# top STL above remains in its print orientation.
openscad -o "$OUT/rm65_kit_top_assembly.stl" \
  -D 'part="top_assembly"' "$MODEL"

openscad -o "$OUT/rm65_kit_preview.png" \
  --imgsize=1200,850 --viewall --autocenter \
  -D 'part="assembly"' "$MODEL"

openscad -o "$OUT/rm65_kit_top_inner.png" \
  --imgsize=1200,850 --viewall --autocenter \
  --camera=0,0,0,0,0,0,200 \
  -D 'part="top"' "$MODEL"

echo "Wrote STL and preview assets to $OUT"
