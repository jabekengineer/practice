#!/bin/bash
# Start PostgreSQL and setup database in DevContainer
# Usage: ./scripts/start-postgres.sh

set -e

echo "🚀 Starting PostgreSQL in devcontainer..."

# Start PostgreSQL in background
docker-entrypoint.sh postgres &
PG_PID=$!

echo "⏳ Waiting for PostgreSQL to start..."
sleep 10

echo "🔧 Setting up SQL practice database..."

# Create database if it doesn't exist
psql -U postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'sql_practice'" | grep -q 1 || psql -U postgres -c "CREATE DATABASE sql_practice"

# Run schema setup
echo "📋 Creating schema..."
psql -U postgres -d sql_practice -f /workspace/data/schema.sql

echo "✅ Setup complete! PostgreSQL is running."
echo ""
echo "💡 Available commands:"
echo "   • Run demo: ./scripts/demo-devcontainer.sh hello"
echo "   • Connect to DB: psql -U postgres -d sql_practice"
echo "   • Stop PostgreSQL: kill $PG_PID"
echo ""
echo "🔄 PostgreSQL will keep running. Use Ctrl+C to stop this script."

# Keep script running so PostgreSQL stays up
wait $PG_PID
