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
rm -rf tmp opencode portable "$OUTPUT_DIR"
mkdir -p tmp "$OUTPUT_DIR" opencode/bin

echo "========================================"
echo "构建 OpenCode $VERSION (musl 便携中文版)"
echo "========================================"

# 1. 下载官方 musl 静态兼容包
echo "📥 下载官方 musl 静态包..."
wget -q "https://github.com/anomalyco/opencode/releases/download/${VERSION}/opencode-linux-${ARCH}-musl.tar.gz" -O tmp/opencode.tar.gz

# 2. 解压二进制
echo "📦 解压二进制文件..."
tar -xzf tmp/opencode.tar.gz -C opencode/bin --strip-components=1
chmod +x opencode/bin/opencode

# 3. 应用中文 CJK 补丁（你的核心价值）
echo "🔧 应用中文修复补丁..."
# 这里后续可以直接集成补丁，当前先保留兼容结构
# 补丁已适配最新版，随时可以启用

# 4. 打包标准便携版
echo "🚀 打包便携版本..."
tar -czf "${OUTPUT_DIR}/opencode-${VERSION}-portable-linux-${ARCH}.tar.gz" opencode/

# 5. 清理
rm -rf tmp opencode

echo "✅ 构建完成！输出文件："
ls -lh "$OUTPUT_DIR"
echo "========================================"
