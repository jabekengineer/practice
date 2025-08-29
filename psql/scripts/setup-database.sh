#!/bin/bash
# Setup database for SQL practice (Docker Compose version)
# Used internally by docker-compose dev service

set -e

echo "🔧 Setting up SQL practice database..."

# Create database if it doesn't exist
psql -h localhost -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'sql_practice'" | grep -q 1 || psql -h localhost -U postgres -c "CREATE DATABASE sql_practice"

# Run schema setup
echo "📋 Creating schema..."
psql -h localhost -U postgres -d sql_practice -f /workspace/data/schema.sql

echo "✅ Database setup complete!"
