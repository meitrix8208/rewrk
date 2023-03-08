#? crear un dockerfile con varias imágenes de alpine para cada paso clonar el repositorio https://github.com/lnx-search/rewrk y construir el binario con rust 

FROM alpine:3.17.2 AS builder

WORKDIR /compile
# gcc
RUN apk add --no-cache git build-base pkgconfig musl-dev curl openssl-dev 

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

RUN rustup target add x86_64-unknown-linux-musl

RUN git clone --depth 1 https://github.com/lnx-search/rewrk.git

WORKDIR /compile/rewrk

RUN cargo build --target x86_64-unknown-linux-musl --release

FROM alpine:3.17.2 AS runner

WORKDIR /app

COPY --from=builder /compile/rewrk/target/x86_64-unknown-linux-musl/release/rewrk /app/rewrk-t