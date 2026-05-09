#!/bin/bash
set -euo pipefail

VERSION="$1"
ARCH="$2"
OUTPUT_DIR="dist"

# 架构适配
if [ "$ARCH" = "x86_64" ]; then
  ARCH="x64"
fi

# 清理环境
rm -rf tmp extracted opencode "$OUTPUT_DIR"
mkdir -p tmp extracted "$OUTPUT_DIR" opencode/bin

echo "========================================"
echo "构建 OpenCode $VERSION (musl 便携中文版)"
echo "========================================"

# 1. 下载官方 musl 静态包
echo "📥 下载官方 musl 静态包..."
wget -q "https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}-musl.tar.gz" -O tmp/opencode.tar.gz

# 2. 解压到临时目录，自动探测二进制文件
echo "📦 解压并探测二进制文件..."
tar -xzf tmp/opencode.tar.gz -C extracted/
echo "解压后的文件结构："
find extracted -type f -name "opencode"

# 自动找到 opencode 二进制文件路径
OPCODE_PATH=$(find extracted -type f -name "opencode" -print -quit)
if [ -z "$OPCODE_PATH" ]; then
  echo "❌ 错误：未找到 opencode 二进制文件！"
  exit 1
fi
echo "✅ 找到二进制文件：$OPCODE_PATH"

# 3. 复制到目标目录
cp "$OPCODE_PATH" opencode/bin/opencode
chmod +x opencode/bin/opencode
echo "✅ 已复制并设置可执行权限"

# 4. 打包标准便携版
echo "🚀 打包便携版本..."
tar -czf "${OUTPUT_DIR}/opencode-${VERSION}-portable-linux-${ARCH}.tar.gz" opencode/

# 5. 清理
rm -rf tmp extracted opencode

echo "========================================"
echo "✅ 构建完成！输出文件："
ls -lh "$OUTPUT_DIR"
echo "========================================"
