#!/bin/bash
# Zadanie 9 - Regression tests for zadanie7 (Vapor app) deployed on Azure
set -e

BASE_URL="${APP_URL:-http://localhost:8080}"
PASSED=0
FAILED=0

check() {
  local description="$1"
  local endpoint="$2"
  local expected_code="${3:-200}"

  status=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL$endpoint")
  if [ "$status" -eq "$expected_code" ]; then
    echo "✅ PASS: $description (HTTP $status)"
    PASSED=$((PASSED + 1))
  else
    echo "❌ FAIL: $description (expected $expected_code, got $status)"
    FAILED=$((FAILED + 1))
  fi
}

echo "=== Regression Tests for zadanie7 ==="
echo "Target: $BASE_URL"
echo ""

# Health / homepage
check "Homepage loads" "/"

# Category endpoints
check "GET /categories" "/categories"
check "GET /categories/create" "/categories/create"

# Product endpoints
check "GET /products" "/products"
check "GET /products/create" "/products/create"

# Order endpoints
check "GET /orders" "/orders"
check "GET /orders/create" "/orders/create"

# API JSON endpoints
check "API GET /categories (JSON)" "/categories" 200
check "API GET /products (JSON)" "/products" 200

echo ""
echo "=== Results: $PASSED passed, $FAILED failed ==="

if [ "$FAILED" -gt 0 ]; then
  exit 1
fi
