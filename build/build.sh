#!/bin/bash
set -euo pipefail

VERSION="$1"
ARCH="$2"
OUTPUT_DIR="dist"

echo "========================================"
echo "Building OpenCode $VERSION for $ARCH"
echo "========================================"

# 1. 准备目录
mkdir -p "$OUTPUT_DIR"
mkdir -p portable/bin
echo "✓ Created directories"

# 2. 下载官方预编译二进制（带错误检查）
echo "Downloading official binary..."
URL="https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}"
echo "URL: $URL"

if ! wget -v "$URL" -O portable/bin/opencode; then
  echo "❌ Download failed! Check if the URL is correct."
  echo "Exit code: $?"
  exit 1
fi
echo "✓ Download completed"

# 3. 设置权限
chmod +x portable/bin/opencode
echo "✓ Made binary executable"

# 4. 打包
echo "Creating archive..."
TAR_NAME="opencode-${VERSION}-portable-linux-${ARCH}.tar.gz"
tar -czf "${OUTPUT_DIR}/${TAR_NAME}" -C portable .
echo "✓ Created ${TAR_NAME}"

# 5. 清理
rm -rf portable
echo "✓ Cleanup completed"

echo "========================================"
echo "✅ Build successful!"
echo "Output file: ${OUTPUT_DIR}/${TAR_NAME}"
echo "========================================"
