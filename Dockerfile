FROM alpine:3.19.0 AS builder

RUN apk add --no-cache git build-base pkgconfig openssl-dev gcc musl-dev rust cargo

RUN git clone --depth 1 https://github.com/lnx-search/rewrk.git

WORKDIR /rewrk

RUN cargo build --release

RUN strip target/release/rewrk

FROM meitrix8208/alpinex:lite AS runner

RUN apk add --no-cache libgcc ca-certificates

COPY --from=builder /rewrk/target/release/rewrk /bin
