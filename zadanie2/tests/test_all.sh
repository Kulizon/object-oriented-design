#!/bin/bash

BASE_URL="http://localhost:8000"

echo "=========================================="
echo "  FULL API TEST SUITE"
echo "=========================================="

echo ""
echo "--- Create Category: Elektronika ---"
curl -s -X POST "$BASE_URL/api/category" \
  -H "Content-Type: application/json" \
  -d '{"name":"Elektronika","description":"Sprzet elektroniczny"}' | python3 -m json.tool

echo ""
echo "--- Create Category: Akcesoria ---"
curl -s -X POST "$BASE_URL/api/category" \
  -H "Content-Type: application/json" \
  -d '{"name":"Akcesoria","description":"Akcesoria komputerowe"}' | python3 -m json.tool

echo ""
echo "--- Create Product: Laptop (category 1) ---"
curl -s -X POST "$BASE_URL/api/product" \
  -H "Content-Type: application/json" \
  -d '{"name":"Laptop","description":"Gaming laptop","price":4999.99,"category_id":1}' | python3 -m json.tool

echo ""
echo "--- Create Product: Mysz (category 2) ---"
curl -s -X POST "$BASE_URL/api/product" \
  -H "Content-Type: application/json" \
  -d '{"name":"Mysz","description":"Bezprzewodowa mysz","price":149.99,"category_id":2}' | python3 -m json.tool

echo ""
echo "--- Create Order with products ---"
curl -s -X POST "$BASE_URL/api/order" \
  -H "Content-Type: application/json" \
  -d '{"customer_name":"Jan Kowalski","product_ids":[1,2]}' | python3 -m json.tool

echo ""
echo "--- List all Products ---"
curl -s -X GET "$BASE_URL/api/product" | python3 -m json.tool

echo ""
echo "--- List all Categories ---"
curl -s -X GET "$BASE_URL/api/category" | python3 -m json.tool

echo ""
echo "--- List all Orders ---"
curl -s -X GET "$BASE_URL/api/order" | python3 -m json.tool

echo ""
echo "--- Update Product 1 ---"
curl -s -X PUT "$BASE_URL/api/product/1" \
  -H "Content-Type: application/json" \
  -d '{"name":"Laptop Pro","price":5999.99}' | python3 -m json.tool

echo ""
echo "--- Update Category 1 ---"
curl -s -X PUT "$BASE_URL/api/category/1" \
  -H "Content-Type: application/json" \
  -d '{"name":"Elektronika i AGD"}' | python3 -m json.tool

echo ""
echo "--- Update Order 1 ---"
curl -s -X PUT "$BASE_URL/api/order/1" \
  -H "Content-Type: application/json" \
  -d '{"status":"completed"}' | python3 -m json.tool

echo ""
echo "--- Show Product 1 ---"
curl -s -X GET "$BASE_URL/api/product/1" | python3 -m json.tool

echo ""
echo "--- Show Category 1 ---"
curl -s -X GET "$BASE_URL/api/category/1" | python3 -m json.tool

echo ""
echo "--- Show Order 1 ---"
curl -s -X GET "$BASE_URL/api/order/1" | python3 -m json.tool

echo ""
echo "--- Delete Product 2 ---"
curl -s -X DELETE "$BASE_URL/api/product/2" | python3 -m json.tool

echo ""
echo "--- Delete Category 2 ---"
curl -s -X DELETE "$BASE_URL/api/category/2" | python3 -m json.tool

echo ""
echo "--- Delete Order 1 ---"
curl -s -X DELETE "$BASE_URL/api/order/1" | python3 -m json.tool

echo ""
echo "--- Final state: Products ---"
curl -s -X GET "$BASE_URL/api/product" | python3 -m json.tool

echo ""
echo "--- Final state: Categories ---"
curl -s -X GET "$BASE_URL/api/category" | python3 -m json.tool

echo ""
echo "--- Final state: Orders ---"
curl -s -X GET "$BASE_URL/api/order" | python3 -m json.tool

echo ""
echo "=========================================="
echo "  ALL TESTS DONE"
echo "=========================================="
