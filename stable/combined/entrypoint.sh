#!/bin/sh

# Function to handle errors and log details
handle_error() {
    echo "Error: $1"
    exit 1
}

# Execute linting
echo "Running linting..."
golangci-lint run || handle_error "Linting failed"

# Execute building
echo "Running building..."
go build -o myapp || handle_error "Building failed"

# Execute testing
echo "Running testing..."
go test ./... || handle_error "Testing failed"

# If all commands executed successfully, exit with success status
exit 0
