#? crear un dockerfile con varias imagenes de alpine para cada paso clonar el repositorio https://github.com/lnx-search/rewrk y construir el binario con rust 

FROM alpine:3.17.2 AS builder

WORKDIR /compile

RUN apk add --no-cache git build-base pkgconfig openssl-dev gcc musl-dev rust cargo

# RUN rustup-init -t x86_64-unknown-linux-musl --profile minimal -y

RUN git clone --depth 1 https://github.com/lnx-search/rewrk.git

WORKDIR /compile/rewrk

RUN cargo build --release

#! crear una imagen de alpine para ejecutar el binario

FROM alpine:3.17.2 AS runner

WORKDIR /app

RUN apk add --no-cache gcc 

COPY --from=builder /compile/rewrk/target/release/rewrk /app/rewrk

RUN chmod +x /app/rewrk

# example ./rewrk -d 3s -h http://192.168.224.1:5000/api/users

