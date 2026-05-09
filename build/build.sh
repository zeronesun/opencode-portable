#!/bin/bash
set -euo pipefail

UPSTREAM_DIR="$1"
VERSION="$2"

echo "========================================"
echo "Building OpenCode $VERSION"
echo "========================================"

# 清理并创建输出目录
rm -rf dist
mkdir -p dist

# 构建x86_64
echo "Building x86_64..."
docker buildx build --platform linux/amd64 \
  --build-arg VERSION="$VERSION" \
  --build-arg ARCH=x86_64 \
  -f build/Dockerfile \
  --output type=tar,dest=dist/x86_64.tar .

# 构建arm64
echo "Building arm64..."
docker buildx build --platform linux/arm64 \
  --build-arg VERSION="$VERSION" \
  --build-arg ARCH=aarch64 \
  -f build/Dockerfile \
  --output type=tar,dest=dist/arm64.tar .

# 打包
echo "Packaging releases..."
cd dist
for arch in x86_64 arm64; do
  mkdir -p "$arch"
  tar xf "$arch.tar" -C "$arch" --strip-components=1
  tar czf "opencode-$VERSION-portable-linux-$arch.tar.gz" -C "$arch" .
  rm -rf "$arch" "$arch.tar"
done

echo "========================================"
echo "Build completed successfully!"
ls -lh *.tar.gz
echo "========================================"
