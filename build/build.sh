#!/bin/bash
set -e

UPSTREAM_DIR=$1
VERSION=$2

echo "Building OpenCode $VERSION with musl..."

# 创建输出目录
mkdir -p dist

# 构建x86_64版本
echo "Building x86_64..."
docker buildx build --platform linux/amd64 \
  --build-arg VERSION=$VERSION \
  --build-arg ARCH=x86_64 \
  -t opencode-build-x86_64 \
  -f build/Dockerfile \
  --output type=tar,dest=dist/opencode-x86_64.tar .

# 构建arm64版本
echo "Building arm64..."
docker buildx build --platform linux/arm64 \
  --build-arg VERSION=$VERSION \
  --build-arg ARCH=aarch64 \
  -t opencode-build-arm64 \
  -f build/Dockerfile \
  --output type=tar,dest=dist/opencode-arm64.tar .

# 解压并重新打包成标准tar.gz
cd dist
for arch in x86_64 arm64; do
  mkdir -p opencode-$arch
  tar xf opencode-$arch.tar -C opencode-$arch
  tar czf opencode-$VERSION-portable-linux-$arch.tar.gz -C opencode-$arch .
  rm -rf opencode-$arch opencode-$arch.tar
done

# 生成SHA256校验和
echo "Generating SHA256 checksums..."
sha256sum *.tar.gz > SHA256SUMS

echo "Build complete!"
ls -la
