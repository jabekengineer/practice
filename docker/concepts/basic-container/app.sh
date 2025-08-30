#!/bin/sh

# Basic container application example
# This script demonstrates a simple containerized application

echo "🐳 Starting basic container application..."
echo "Container ID: $(hostname)"
echo "Date: $(date)"
echo "Working directory: $(pwd)"

# Simple HTTP server simulation
echo "Starting HTTP server on port 8080..."

# Create a simple HTTP response
create_response() {
    cat << EOF
HTTP/1.1 200 OK
Content-Type: text/plain
Content-Length: 26

Hello from Docker container!
EOF
}

# Health check endpoint
create_health_response() {
    cat << EOF
HTTP/1.1 200 OK
Content-Type: text/plain
Content-Length: 2

OK
EOF
}

# Simple server loop
while true; do
    echo "$(date): Server listening on port 8080..."
    
    # Use netcat to listen for connections (if available)
    if command -v nc >/dev/null 2>&1; then
        echo "GET / HTTP/1.1" | nc -l -p 8080 > /dev/null 2>&1 && create_response
    else
        # Fallback - just keep the container running
        sleep 30
    fi
done
