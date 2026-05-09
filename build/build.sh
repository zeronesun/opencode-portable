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

# 2. 修正架构名和文件名（官方真实文件名）
if [ "$ARCH" = "x86_64" ]; then
  ARCH="x64"
fi

# 3. 下载官方预编译压缩包（匹配用户提供的正确URL）
echo "Downloading official binary..."
URL="https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}.tar.gz"
echo "URL: $URL"

if ! wget -v "$URL" -O opencode-linux-${ARCH}.tar.gz; then
  echo "❌ Download failed! Check if the URL is correct."
  echo "Exit code: $?"
  exit 1
fi
echo "✓ Download completed"

# 4. 解压压缩包，提取二进制
echo "Extracting binary..."
tar -xzf opencode-linux-${ARCH}.tar.gz
mv opencode-linux-${ARCH}/opencode portable/bin/
chmod +x portable/bin/opencode
echo "✓ Extracted and made executable"

# 5. 打包
echo "Creating archive..."
TAR_NAME="opencode-${VERSION}-portable-linux-${ARCH}.tar.gz"
tar -czf "${OUTPUT_DIR}/${TAR_NAME}" -C portable .
echo "✓ Created ${TAR_NAME}"

# 6. 清理
rm -rf opencode-linux-${ARCH} opencode-linux-${ARCH}.tar.gz portable
echo "✓ Cleanup completed"

echo "========================================"
echo "✅ Build successful!"
echo "Output file: ${OUTPUT_DIR}/${TAR_NAME}"
echo "========================================"
