#!/usr/bin/env bash
# Copies the skill tok-modelling from a checkout of https://github.com/tok-lang-bpm/tok, where it
# is maintained, into the plugin, and sets the version of the plugin to the version of tok.
# Usage: bash tools/sync.sh PATH/TO/tok
set -euo pipefail
TOK="${1:?usage: tools/sync.sh PATH/TO/tok}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
rm -rf "$ROOT/plugins/tok/skills/tok-modelling"
cp -r "$TOK/skills/tok-modelling" "$ROOT/plugins/tok/skills/"
VERSION="$(sed -n 's/^__version__ = "\(.*\)"/\1/p' "$TOK/python/src/tok/__init__.py")"
sed -i "s/\"version\": \"[^\"]*\"/\"version\": \"$VERSION\"/" "$ROOT/plugins/tok/.claude-plugin/plugin.json"
echo "skill and version $VERSION copied from $TOK"
