#? crear un dockerfile con varias imágenes de alpine para cada paso clonar el repositorio https://github.com/lnx-search/rewrk y construir el binario con rust 

FROM alpine:3.17.2 AS builder

WORKDIR /compile

RUN apk add --no-cache git build-base pkgconfig openssl-dev gcc musl-dev rust cargo

RUN git clone --depth 1 https://github.com/lnx-search/rewrk.git

WORKDIR /compile/rewrk

RUN cargo build --release

FROM alpine:3.17.2 AS runner

WORKDIR /app

COPY --from=builder /compile/rewrk/target/release/rewrk /app/rewrk




