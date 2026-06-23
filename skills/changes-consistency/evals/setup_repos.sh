#!/usr/bin/env bash
# Recreates the isolated git repos used as fixtures for the changes-consistency evals.
# Run once before executing evals: ./evals/setup_repos.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE="$SCRIPT_DIR/workspace"

echo "Setting up eval repos in $WORKSPACE..."

# Eval 1: main.js + xpto.js staged — perfect match, all expected
mkdir -p "$WORKSPACE/repo-eval-1" && cd "$WORKSPACE/repo-eval-1"
git init -q && git commit --allow-empty -m "init" -q
echo 'console.log("Hello, world!");' > main.js
echo '// Placeholder xpto script.' > xpto.js
git add main.js xpto.js

# Eval 2: main.js + xpto.js + unexpected.js staged — one extra file
mkdir -p "$WORKSPACE/repo-eval-2" && cd "$WORKSPACE/repo-eval-2"
git init -q && git commit --allow-empty -m "init" -q
echo 'console.log("Hello, world!");' > main.js
echo '// Placeholder xpto script.' > xpto.js
echo 'export const PASSWORD = "SensitiveInformationHere"' > unexpected.js
git add main.js xpto.js unexpected.js

# Eval 3: main.js + xpto.js + unexpected.js staged — missing config.json, one extra
mkdir -p "$WORKSPACE/repo-eval-3" && cd "$WORKSPACE/repo-eval-3"
git init -q && git commit --allow-empty -m "init" -q
echo 'console.log("Hello, world!");' > main.js
echo '// Placeholder xpto script.' > xpto.js
echo 'export const PASSWORD = "SensitiveInformationHere"' > unexpected.js
git add main.js xpto.js unexpected.js

# Eval 4: main.js + xpto.js + unexpected.js staged — user only wanted main.js
mkdir -p "$WORKSPACE/repo-eval-4" && cd "$WORKSPACE/repo-eval-4"
git init -q && git commit --allow-empty -m "init" -q
echo 'console.log("Hello, world!");' > main.js
echo '// Placeholder xpto script.' > xpto.js
echo 'export const PASSWORD = "SensitiveInformationHere"' > unexpected.js
git add main.js xpto.js unexpected.js

# Eval 5: nothing staged — empty diff scenario
mkdir -p "$WORKSPACE/repo-eval-5" && cd "$WORKSPACE/repo-eval-5"
git init -q && git commit --allow-empty -m "init" -q
echo 'console.log("Hello, world!");' > main.js
# intentionally not staged

echo "Done. Repos ready in $WORKSPACE/"
