# Use an Ubuntu base image
FROM ubuntu:20.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    python3 \
    python3-pip \
    autoconf \
    libtool \
    pkg-config \
    curl \
    wget \
    libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /usr/src/RediSearch

# Copy the local RedisSearch repo into the container
COPY . .

# Ensure submodules are initialized and updated
RUN git submodule update --init --recursive

RUN make setup

RUN /usr/src/RediSearch/.install/install_script.sh

# Build RedisSearch
RUN make

# Copy the compiled RedisSearch module to an output directory
RUN mkdir -p /output && \
    cp bin/linux-arm64v8-release/search-community/redisearch.so /output/

# Define an entrypoint to keep the container running after build
CMD ["sleep", "86400"]
