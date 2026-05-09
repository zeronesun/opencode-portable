# 多阶段构建：使用musl交叉编译环境
FROM alpine:3.20 AS builder

ARG VERSION
ARG ARCH

# 安装依赖
RUN apk add --no-cache \
  build-base \
  git \
  go \
  nodejs \
  npm \
  python3 \
  py3-pip \
  musl-dev \
  linux-headers

# 设置Go环境变量
ENV CGO_ENABLED=1
ENV GOOS=linux
ENV GOARCH=$ARCH
ENV CC=$ARCH-linux-musl-gcc
ENV CXX=$ARCH-linux-musl-g++

# 复制源代码
COPY upstream /workspace
WORKDIR /workspace

# 构建前端
RUN npm install
RUN npm run build

# 构建后端
RUN go build -ldflags "-s -w -X main.version=$VERSION" -o opencode ./cmd/opencode

# 构建LD_PRELOAD清理器（Abigail的核心技术）
COPY src/ld-preload-cleaner.c /workspace/
RUN $CC -shared -fPIC -o libldpreloadcleaner.so ld-preload-cleaner.c -ldl

# 最终镜像
FROM alpine:3.20

ARG VERSION

# 创建目录结构
RUN mkdir -p /opencode/bin /opencode/lib

# 复制二进制文件和库
COPY --from=builder /workspace/opencode /opencode/bin/
COPY --from=builder /workspace/libldpreloadcleaner.so /opencode/lib/

# 创建包装脚本
RUN echo '#!/bin/sh' > /opencode/bin/opencode-wrapper && \
    echo 'export LD_LIBRARY_PATH="/opencode/lib:$LD_LIBRARY_PATH"' >> /opencode/bin/opencode-wrapper && \
    echo 'export LD_PRELOAD="/opencode/lib/libldpreloadcleaner.so"' >> /opencode/bin/opencode-wrapper && \
    echo 'exec /opencode/bin/opencode "$@"' >> /opencode/bin/opencode-wrapper && \
    chmod +x /opencode/bin/opencode-wrapper && \
    ln -s opencode-wrapper /opencode/bin/opencode

# 设置工作目录
WORKDIR /workspace

# 入口点
ENTRYPOINT ["/opencode/bin/opencode"]
