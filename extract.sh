#!/usr/bin/env zsh
set -euo pipefail          # fail fast, catch undefined vars

# 1. Make a throw-away staging directory
TMPDIR=$(mktemp -d /tmp/code-capture-XXXX)

# 2. Copy the project into it, skipping the junk we don’t want
rsync -a --prune-empty-dirs \
      --exclude='.git/' \
      --exclude='.venv/' \
      --exclude='*/__pycache__/' \
      --exclude='*/build' \
      --exclude='frontend/node_modules/' \
      --exclude='frontend/public/' \
      --exclude='frontend/package-lock.json' \
      --exclude='frontend/package.json' \
      "$PWD"/  "$TMPDIR"/

# 3. Start the output file with a directory tree
tree "$TMPDIR" --prune -a --noreport \
     | sed "s|$TMPDIR/||"        \
     >  all_code.txt

# 4. Append the contents of every *regular* file
printf '\n==== BEGIN FILE CONTENTS ====\n' >> all_code.txt

find "$TMPDIR" -type f -print0 | sort -z | while IFS= read -rd '' file; do
    rel="${file#$TMPDIR/}"  
    printf '\n--- %s ---\n' "$rel" >> all_code.txt
    cat -- "$file"           >> all_code.txt
done

# 5. Clean up
rm -rf "$TMPDIR"
echo "Wrote $(wc -l < all_code.txt | tr -d ' ') lines to all_code.txt"