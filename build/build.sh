#!/bin/bash
set -euo pipefail

VERSION="$1"
ARCH="$2"
OUTPUT_DIR="dist"

echo "========================================"
echo "Building OpenCode $VERSION for $ARCH"
echo "========================================"

# 架构名修正：x86_64 → x64
if [ "$ARCH" = "x86_64" ]; then
  ARCH="x64"
fi

# 1. 准备目录
mkdir -p "$OUTPUT_DIR"
mkdir -p portable/bin
echo "✓ Created directories"

# 2. 下载官方预编译压缩包
echo "Downloading official binary..."
URL="https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}.tar.gz"
echo "URL: $URL"

if ! wget -v "$URL" -O opencode.tar.gz; then
  echo "❌ Download failed!"
  exit 1
fi
echo "✓ Download completed"

# 3. 解压并探测二进制文件路径
echo "Extracting and probing files..."
mkdir -p temp
tar -xzf opencode.tar.gz -C temp
echo "Files in temp directory:"
ls -la temp/
echo "Files in subdirectories:"
find temp -type f -name "opencode"

# 自动找到opencode二进制文件路径
OPCODE_PATH=$(find temp -type f -name "opencode" -print -quit)
if [ -z "$OPCODE_PATH" ]; then
  echo "❌ Could not find opencode binary in the archive!"
  exit 1
fi
echo "Found binary at: $OPCODE_PATH"

# 4. 复制到目标目录
cp "$OPCODE_PATH" portable/bin/opencode
chmod +x portable/bin/opencode
echo "✓ Copied binary to portable/bin"

# 5. 打包
echo "Creating archive..."
TAR_NAME="opencode-${VERSION}-portable-linux-${ARCH}.tar.gz"
tar -czf "${OUTPUT_DIR}/${TAR_NAME}" -C portable .
echo "✓ Created ${TAR_NAME}"

# 6. 清理
rm -rf temp opencode.tar.gz portable
echo "✓ Cleanup completed"

echo "========================================"
echo "✅ Build successful!"
echo "Output file: ${OUTPUT_DIR}/${TAR_NAME}"
echo "========================================"
