#!/bin/bash
set -e

# Start Redis if docker is available
if command -v docker &> /dev/null; then
    echo "Starting Redis via Docker..."
    docker run -d --name vapor-redis -p 6379:6379 redis:7-alpine 2>/dev/null || true
fi

echo "Building..."
swift build

echo "Running on http://localhost:8999"
swift run App serve --hostname 0.0.0.0 --port 8999
