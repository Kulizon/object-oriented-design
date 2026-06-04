#!/bin/bash
set -e
curl -s http://localhost:8080/api/info
echo
curl -s http://localhost:8080/api/users
echo
curl -s -X POST http://localhost:8080/api/login -H "Content-Type: application/json" -d '{"username":"admin","password":"admin123"}'
echo
curl -s -X POST http://localhost:8080/api/login -H "Content-Type: application/json" -d '{"username":"user","password":"password"}'
echo
curl -s -X POST http://localhost:8080/api/login -H "Content-Type: application/json" -d '{"username":"editor","password":"edit456"}'
echo
curl -s -X POST http://localhost:8080/api/login -H "Content-Type: application/json" -d '{"username":"admin","password":"badpass"}'
echo
curl -s -X POST http://localhost:8080/api/login -H "Content-Type: application/json" -d '{"username":"ghost","password":"x"}'
echo
