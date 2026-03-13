#!/bin/bash
cd "$(dirname "$0")"
docker run --rm -v "$PWD":/app -w /app frolvlad/alpine-fpc sh -c "fpc main.pas > /dev/null && ./main"
