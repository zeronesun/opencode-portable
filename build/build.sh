#!/bin/bash
set -euo pipefail

UPSTREAM_DIR=$1
VERSION=$2

echo "========================================"
echo "Building OpenCode $VERSION with musl"
echo "========================================"

# 创建输出目录
rm -rf dist
mkdir -p dist

# 构建x86_64版本
echo "Building x86_64 architecture..."
docker buildx build --platform linux/amd64 \
  --build-arg VERSION="$VERSION" \
  --build-arg ARCH=x86_64 \
  -t opencode-build-x86_64 \
  -f build/Dockerfile \
  --output type=tar,dest=dist/opencode-x86_64.tar .

# 构建arm64版本
echo "Building arm64 architecture..."
docker buildx build --platform linux/arm64 \
  --build-arg VERSION="$VERSION" \
  --build-arg ARCH=aarch64 \
  -t opencode-build-arm64 \
  -f build/Dockerfile \
  --output type=tar,dest=dist/opencode-arm64.tar .

# 解压并重新打包成标准tar.gz
echo "Packaging releases..."
cd dist
for arch in x86_64 arm64; do
  echo "Packaging $arch..."
  mkdir -p "opencode-$arch"
  tar xf "opencode-$arch.tar" -C "opencode-$arch" --strip-components=1
  tar czf "opencode-$VERSION-portable-linux-$arch.tar.gz" -C "opencode-$arch" .
  rm -rf "opencode-$arch" "opencode-$arch.tar"
done

echo "========================================"
echo "Build completed successfully!"
echo "Output files:"
ls -lh *.tar.gz
echo "========================================"
