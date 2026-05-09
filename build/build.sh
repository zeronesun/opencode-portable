#!/bin/bash
set -euo pipefail

VERSION="$1"
ARCH="$2"
OUTPUT_DIR="dist"

mkdir -p "$OUTPUT_DIR"
mkdir -p portable/bin

# 直接下载官方预编译二进制 (核心：不编译！)
wget -q "https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}" -O portable/bin/opencode
chmod +x portable/bin/opencode

# 打包
tar -czf "${OUTPUT_DIR}/opencode-${VERSION}-portable-linux-${ARCH}.tar.gz" -C portable .

# 清理
rm -rf portable
