#!/bin/bash
set -e

WSL_BASE_PATH="$1"
if [[ -z "$WSL_BASE_PATH" ]]; then
    echo "Usage: $0 WSL_BASE_PATH"
    exit 1
fi

docker import "$WSL_BASE_PATH" wsl-base:latest

docker build --target custom-base -t wsl-custom-base:latest .
docker create --name temp wsl-custom-base:latest /bin/true
docker export temp > wsl-custom-base.wsl
docker rm temp

docker build --target custom-cuda -t wsl-custom-cuda:latest .
docker create --name temp wsl-custom-cuda:latest /bin/true
docker export temp > wsl-custom-cuda.wsl
docker rm temp