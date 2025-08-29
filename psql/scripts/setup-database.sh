#!/bin/bash
# Setup database for SQL practice

set -e

echo "🔧 Setting up SQL practice database..."

# Create database if it doesn't exist
psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'sql_practice'" | grep -q 1 || psql -U postgres -c "CREATE DATABASE sql_practice"

# Run schema setup
echo "📋 Creating schema..."
psql -U postgres -d sql_practice -f /workspace/data/schema.sql

echo "✅ Database setup complete!"
