#!/bin/bash

BASE_URL="http://localhost:8000"

echo "=== TEST CATEGORY CRUD ==="

echo ""
echo "--- CREATE Category ---"
curl -s -X POST "$BASE_URL/api/category" \
  -H "Content-Type: application/json" \
  -d '{"name":"Elektronika","description":"Sprzet elektroniczny"}' | python3 -m json.tool

echo ""
echo "--- CREATE Category 2 ---"
curl -s -X POST "$BASE_URL/api/category" \
  -H "Content-Type: application/json" \
  -d '{"name":"Akcesoria","description":"Akcesoria komputerowe"}' | python3 -m json.tool

echo ""
echo "--- LIST Categories ---"
curl -s -X GET "$BASE_URL/api/category" | python3 -m json.tool

echo ""
echo "--- SHOW Category 1 ---"
curl -s -X GET "$BASE_URL/api/category/1" | python3 -m json.tool

echo ""
echo "--- UPDATE Category 1 ---"
curl -s -X PUT "$BASE_URL/api/category/1" \
  -H "Content-Type: application/json" \
  -d '{"name":"Elektronika i AGD","description":"Elektronika i sprzet AGD"}' | python3 -m json.tool

echo ""
echo "--- SHOW Category 1 (after update) ---"
curl -s -X GET "$BASE_URL/api/category/1" | python3 -m json.tool

echo ""
echo "--- DELETE Category 2 ---"
curl -s -X DELETE "$BASE_URL/api/category/2" | python3 -m json.tool

echo ""
echo "--- LIST Categories (after delete) ---"
curl -s -X GET "$BASE_URL/api/category" | python3 -m json.tool

echo ""
echo "=== CATEGORY TESTS DONE ==="
