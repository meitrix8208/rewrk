FROM alpine:3.18.3 AS builder

RUN apk add --no-cache git build-base pkgconfig musl-dev curl openssl-dev 

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

RUN rustup target add x86_64-unknown-linux-musl

RUN git clone --depth 1 https://github.com/lnx-search/rewrk.git

WORKDIR /rewrk

RUN cargo build --target x86_64-unknown-linux-musl --release

FROM alpine:3.18.3 AS runner

RUN apk add --no-cache ca-certificates

COPY --from=builder /rewrk/target/x86_64-unknown-linux-musl/release/rewrk /bin