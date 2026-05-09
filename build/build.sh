#!/bin/bash
set -euo pipefail

VERSION="$1"
ARCH="$2"
OUTPUT_DIR="dist"

# 架构适配
if [ "$ARCH" = "x86_64" ]; then
  ARCH="x64"
fi

# 只清理临时文件，不删除输出目录
rm -rf tmp extracted opencode
mkdir -p "$OUTPUT_DIR" opencode/bin

echo "========================================"
echo "构建 OpenCode $VERSION (musl 便携中文版)"
echo "========================================"

# 1. 下载官方 musl 静态包
echo "📥 下载官方 musl 静态包..."
wget -q "https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}-musl.tar.gz" -O tmp/opencode.tar.gz

# 2. 解压并探测二进制文件
echo "📦 解压并探测二进制文件..."
tar -xzf tmp/opencode.tar.gz -C extracted/
OPCODE_PATH=$(find extracted -type f -name "opencode" -print -quit)
if [ -z "$OPCODE_PATH" ]; then
  echo "❌ 错误：未找到 opencode 二进制文件！"
  exit 1
fi

# 3. 复制到目标目录
cp "$OPCODE_PATH" opencode/bin/opencode
chmod +x opencode/bin/opencode

# 4. 打包标准便携版（不删除输出目录，直接追加）
echo "🚀 打包便携版本..."
tar -czf "${OUTPUT_DIR}/opencode-${VERSION}-portable-linux-${ARCH}.tar.gz" opencode/

# 5. 清理临时文件
rm -rf tmp extracted opencode

echo "✅ 构建完成！输出文件："
ls -lh "$OUTPUT_DIR"
echo "========================================"
