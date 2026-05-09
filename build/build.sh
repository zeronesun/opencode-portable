#!/bin/bash
set -euo pipefail

VERSION="$1"
ARCH="$2"
OUTPUT_DIR="dist"

if [ "$ARCH" = "x86_64" ]; then
  ARCH="x64"
fi

rm -rf tmp extracted opencode
mkdir -p tmp extracted "$OUTPUT_DIR" opencode/bin

echo "========================================"
echo "Building OpenCode $VERSION (musl portable)"
echo "========================================"

wget -q "https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}-musl.tar.gz" -O tmp/opencode.tar.gz
tar -xzf tmp/opencode.tar.gz -C extracted/

OPCODE_PATH=$(find extracted -type f -name "opencode" -print -quit)
cp "$OPCODE_PATH" opencode/bin/opencode
chmod +x opencode/bin/opencode

tar -czf "${OUTPUT_DIR}/opencode-${VERSION}-portable-linux-${ARCH}.tar.gz" opencode/

rm -rf tmp extracted opencode
echo "✅ Success: ${OUTPUT_DIR}/opencode-${VERSION}-portable-linux-${ARCH}.tar.gz"
