#!/bin/bash

BASE_URL="http://localhost:8000"

echo "=== TEST ORDER CRUD ==="

echo ""
echo "--- CREATE Order ---"
curl -s -X POST "$BASE_URL/api/order" \
  -H "Content-Type: application/json" \
  -d '{"customer_name":"Jan Kowalski","product_ids":[1]}' | python3 -m json.tool

echo ""
echo "--- CREATE Order 2 ---"
curl -s -X POST "$BASE_URL/api/order" \
  -H "Content-Type: application/json" \
  -d '{"customer_name":"Anna Nowak","product_ids":[1]}' | python3 -m json.tool

echo ""
echo "--- LIST Orders ---"
curl -s -X GET "$BASE_URL/api/order" | python3 -m json.tool

echo ""
echo "--- SHOW Order 1 ---"
curl -s -X GET "$BASE_URL/api/order/1" | python3 -m json.tool

echo ""
echo "--- UPDATE Order 1 ---"
curl -s -X PUT "$BASE_URL/api/order/1" \
  -H "Content-Type: application/json" \
  -d '{"customer_name":"Jan Kowalski","status":"completed","product_ids":[1]}' | python3 -m json.tool

echo ""
echo "--- SHOW Order 1 (after update) ---"
curl -s -X GET "$BASE_URL/api/order/1" | python3 -m json.tool

echo ""
echo "--- DELETE Order 2 ---"
curl -s -X DELETE "$BASE_URL/api/order/2" | python3 -m json.tool

echo ""
echo "--- LIST Orders (after delete) ---"
curl -s -X GET "$BASE_URL/api/order" | python3 -m json.tool

echo ""
echo "=== ORDER TESTS DONE ==="
