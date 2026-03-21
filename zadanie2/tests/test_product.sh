#!/bin/bash

BASE_URL="http://localhost:8000"

echo "=== TEST PRODUCT CRUD ==="

echo ""
echo "--- CREATE Product ---"
curl -s -X POST "$BASE_URL/api/product" \
  -H "Content-Type: application/json" \
  -d '{"name":"Laptop","description":"Gaming laptop","price":4999.99}' | python3 -m json.tool

echo ""
echo "--- CREATE Product 2 ---"
curl -s -X POST "$BASE_URL/api/product" \
  -H "Content-Type: application/json" \
  -d '{"name":"Mysz","description":"Bezprzewodowa mysz","price":149.99}' | python3 -m json.tool

echo ""
echo "--- LIST Products ---"
curl -s -X GET "$BASE_URL/api/product" | python3 -m json.tool

echo ""
echo "--- SHOW Product 1 ---"
curl -s -X GET "$BASE_URL/api/product/1" | python3 -m json.tool

echo ""
echo "--- UPDATE Product 1 ---"
curl -s -X PUT "$BASE_URL/api/product/1" \
  -H "Content-Type: application/json" \
  -d '{"name":"Laptop Pro","price":5999.99}' | python3 -m json.tool

echo ""
echo "--- SHOW Product 1 (after update) ---"
curl -s -X GET "$BASE_URL/api/product/1" | python3 -m json.tool

echo ""
echo "--- DELETE Product 2 ---"
curl -s -X DELETE "$BASE_URL/api/product/2" | python3 -m json.tool

echo ""
echo "--- LIST Products (after delete) ---"
curl -s -X GET "$BASE_URL/api/product" | python3 -m json.tool

echo ""
echo "=== PRODUCT TESTS DONE ==="
