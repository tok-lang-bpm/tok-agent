#!/usr/bin/env bash
# Copies the skills tok-modelling and bpmn-modelling from a checkout of
# https://github.com/tok-lang-bpm/tok, where they are maintained, into the plugin, and sets the
# version of the plugin to the version of tok, or to the version given as the second argument
# (a fourth number, e.g. 1.0.3.1, when only the skills changed since the release of tok).
# Usage: bash tools/sync.sh PATH/TO/tok [VERSION]
set -euo pipefail
TOK="${1:?usage: tools/sync.sh PATH/TO/tok [VERSION]}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
for skill in tok-modelling bpmn-modelling; do
  rm -rf "$ROOT/plugins/tok/skills/$skill"
  cp -r "$TOK/skills/$skill" "$ROOT/plugins/tok/skills/"
done
VERSION="${2:-$(sed -n 's/^__version__ = "\(.*\)"/\1/p' "$TOK/python/src/tok/__init__.py")}"
sed -i "s/\"version\": \"[^\"]*\"/\"version\": \"$VERSION\"/" "$ROOT/plugins/tok/.claude-plugin/plugin.json"
echo "skills and version $VERSION copied from $TOK"
