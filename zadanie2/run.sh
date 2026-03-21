#!/bin/bash

docker stop zadanie2 2>/dev/null
docker rm zadanie2 2>/dev/null

echo "Building Docker image..."
docker build -t zadanie2 .

echo "Starting container..."
docker run --rm -d -p 8000:8000 --name zadanie2 zadanie2

echo "Waiting for server..."
sleep 3

echo "Application available at: http://localhost:8000"
echo ""
echo "Views:"
echo "  Products:   http://localhost:8000/product"
echo "  Categories: http://localhost:8000/category"
echo "  Orders:     http://localhost:8000/order"
echo ""
echo "Admin panel:  http://localhost:8000/admin"
echo "  Login:      admin / admin123"
echo ""
echo "API endpoints:"
echo "  GET/POST        /api/product"
echo "  GET/PUT/DELETE  /api/product/{id}"
echo "  GET/POST        /api/category"
echo "  GET/PUT/DELETE  /api/category/{id}"
echo "  GET/POST        /api/order"
echo "  GET/PUT/DELETE  /api/order/{id}"
echo ""
echo "To stop: docker stop zadanie2"
