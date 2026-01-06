FROM ubuntu:20.04
LABEL maintainer="TuNombre"
ENV DEBIAN_FRONTEND=noninteractive

# Instalamos jp2a y limpiamos caché
RUN apt-get update && apt-get install -y jp2a \
    && rm -rf /var/lib/apt/lists/*

# Usuario no-root
RUN useradd -m appuser
RUN mkdir /datos && chown appuser:appuser /datos

# Volumen
VOLUME /datos

USER appuser
WORKDIR /datos
ENTRYPOINT ["jp2a"]

