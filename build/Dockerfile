FROM alpine:3.20 AS builder
ARG VERSION
ARG ARCH

RUN apk add --no-cache build-base git go nodejs npm musl-dev

ENV CGO_ENABLED=1
ENV GOOS=linux
ENV GOARCH=$ARCH

COPY upstream /workspace
WORKDIR /workspace

RUN npm install && npm run build
RUN go build -ldflags "-s -w -X main.version=$VERSION" -o opencode ./cmd/opencode

COPY src/ld-preload-cleaner.c /workspace/
RUN gcc -shared -fPIC -o libldpreloadcleaner.so ld-preload-cleaner.c -ldl

FROM alpine:3.20

RUN mkdir -p /opencode/bin /opencode/lib

COPY --from=builder /workspace/opencode /opencode/bin/
COPY --from=builder /workspace/libldpreloadcleaner.so /opencode/lib/

RUN echo -e '#!/bin/sh\nexport LD_PRELOAD="/opencode/lib/libldpreloadcleaner.so"\nexec /opencode/bin/opencode "$@"' > /opencode/bin/opencode-wrapper \
    && chmod +x /opencode/bin/opencode-wrapper \
    && ln -sf opencode-wrapper /opencode/bin/opencode

CMD ["cp", "-r", "/opencode", "/dist/"]
