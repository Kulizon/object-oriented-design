#!/bin/bash

docker build -t zadanie2 .
docker run --rm -p 8000:8000 --name zadanie2 zadanie2
