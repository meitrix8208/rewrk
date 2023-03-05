#? crear un dockerfile con varias imagenes de alpine para cada paso clonar el repositorio https://github.com/lnx-search/rewrk y construir el binario con rust 

FROM alpine:3.17.2 AS builder

WORKDIR /app

RUN apk add --no-cache git build-base pkgconfig openssl-dev gcc musl-dev rust cargo

RUN git clone --depth 1 https://github.com/lnx-search/rewrk.git

WORKDIR /app/rewrk

RUN cargo build --release

WORKDIR /app/rewrk/target/release
# copiar el binario a la imagen de alpine a mi computadora
COPY /app/rewrk/target/release/rewrk C:/Users/maurr/workspace/docker/rewrk/src/:C:/Users/maurr/workspace/docker/rewrk/src/

#docker run -it --rm -v C:/Users/maurr/workspace/docker/rewrk/src/:C:/Users/maurr/workspace/docker/rewrk/src/ rewrk-test