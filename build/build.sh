#!/bin/bash
set -euo pipefail

VERSION="$1"
ARCH="$2"
OUTPUT_DIR="dist"

# 架构名修正
if [ "$ARCH" = "x86_64" ]; then
  ARCH="x64"
fi

# 准备目录
mkdir -p "$OUTPUT_DIR"
mkdir -p opencode/bin

# 下载官方压缩包
wget -q "https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}.tar.gz" -O opencode.tar.gz

# 解压提取二进制
tar -xzf opencode.tar.gz -C opencode/bin --strip-components=1
chmod +x opencode/bin/opencode

# 规范打包（外层目录 = opencode）
tar -czf "${OUTPUT_DIR}/opencode-${VERSION}-portable-linux-${ARCH}.tar.gz" opencode/

# 清理
rm -rf opencode opencode.tar.gz
