#!/bin/bash
echo "Testing preloaded data (Warsaw)..."
curl -s "http://localhost:8081/weather?locations=Warsaw" | python3 -m json.tool

echo -e "\nTesting Proxy call to external API (London)..."
curl -s "http://localhost:8081/weather?locations=London" | python3 -m json.tool

echo -e "\nTesting Multiple locations (Paris, Berlin, Krakow)..."
curl -s "http://localhost:8081/weather?locations=Paris,Berlin,Krakow" | python3 -m json.tool

echo -e "\nTesting Cache result (London again - should say Cache DB)..."
curl -s "http://localhost:8081/weather?locations=London" | python3 -m json.tool
