#!/bin/bash
set -e

echo "=== Zadanie 8 - Testy Selenium & Playwright ==="
echo ""

# Install deps
pip install -r requirements.txt -q
playwright install chromium --with-deps 2>/dev/null || playwright install chromium

APP_URL="${APP_URL:-http://localhost:3000}"
echo "Testing app at: $APP_URL"
echo ""

echo "--- Running all tests in parallel ---"
APP_URL=$APP_URL pytest -v -n auto

echo ""
echo "=== Wszystkie testy zakończone ==="


# source venv/bin/activate && APP_URL=http://localhost:3000 pytest -v -n auto
