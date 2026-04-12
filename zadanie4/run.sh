#!/bin/bash
cd "$(dirname "$0")" || exit 1

go mod tidy
go run main.go
