#!/usr/bin/env zsh
set -euo pipefail

OUT="all_code.txt"

# 1. Get a list of all files git knows about (tracked + untracked-but-not-ignored)
#    -c: cached (committed)
#    -o: others (untracked)
#    --exclude-standard: respects .gitignore
FILES=$(git ls-files -c -o --exclude-standard)

# 2. Write the file tree first
echo "$FILES" | tree --fromfile -a --noreport > "$OUT"

# 3. Append content, but ONLY for valid source code files
printf '\n==== BEGIN FILE CONTENTS ====\n' >> "$OUT"

echo "$FILES" | while IFS= read -r file; do
    # --- SAFETY FILTERS ---
    
    # 1. Skip if directory (git ls-files sometimes lists dirs in submodules)
    [[ -d "$file" ]] && continue

    # 2. Skip specific noise files
    [[ "$file" == *"package-lock.json"* ]] && continue
    [[ "$file" == *"yarn.lock"* ]] && continue
    [[ "$file" == *".svg" ]] && continue
    [[ "$file" == *".png" ]] && continue
    
    # 3. Skip if file is larger than 100KB (Protects against binaries/huge data)
    fsize=$(wc -c < "$file" | tr -d ' ')
    if [[ "$fsize" -gt 102400 ]]; then
        echo "Skipping large file ($((fsize/1024))KB): $file"
        continue
    fi
    
    # 4. Skip if file is binary (grep -I checks for binary characters)
    if grep -Iq . "$file" 2>/dev/null; then
         : # It is text, proceed
    else
         echo "Skipping binary file: $file"
         continue
    fi

    # --- OUTPUT ---
    printf '\n--- %s ---\n' "$file" >> "$OUT"
    cat -- "$file" >> "$OUT"
done

echo "------------------------------------------------"
echo "Success! Wrote $(wc -l < "$OUT" | tr -d ' ') lines to $OUT"