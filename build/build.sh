#!/bin/bash
set -euo pipefail

# 参数：版本号 架构 版本类型(normal/musl，可选，默认normal)
VERSION="$1"
ARCH="$2"
BUILD_TYPE="${3:-normal}"
OUTPUT_DIR="dist"

# 架构适配
if [ "$ARCH" = "x86_64" ]; then
  ARCH="x64"
fi

# 仅清理临时文件，不删除输出目录
rm -rf tmp extracted opencode
mkdir -p tmp extracted "$OUTPUT_DIR" opencode/bin

echo "========================================"
echo "构建 OpenCode $VERSION | 架构:$ARCH | 类型:$BUILD_TYPE"
echo "========================================"

# 关键修正：强制确保普通版带 -glibc 后缀
if [ "$BUILD_TYPE" = "musl" ]; then
  FILE_URL="https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}-musl.tar.gz"
  FILE_SUFFIX="-musl"
else
  FILE_URL="https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}.tar.gz"
  FILE_SUFFIX="-glibc"  # 普通版强制添加 -glibc 后缀
fi

# 下载 + 解压
wget -q "$FILE_URL" -O tmp/opencode.tar.gz
tar -xzf tmp/opencode.tar.gz -C extracted/

# 自动查找二进制文件
OPCODE_PATH=$(find extracted -type f -name "opencode" -print -quit)
cp "$OPCODE_PATH" opencode/bin/opencode
chmod +x opencode/bin/opencode

# 打包（强制拼接后缀）
FINAL_FILENAME="opencode-${VERSION}-portable-linux-${ARCH}${FILE_SUFFIX}.tar.gz"
tar -czf "${OUTPUT_DIR}/${FINAL_FILENAME}" opencode/

# 清理临时文件
rm -rf tmp extracted opencode

echo "✅ 构建完成！"
echo "📦 输出文件：${FINAL_FILENAME}"
echo "========================================"
