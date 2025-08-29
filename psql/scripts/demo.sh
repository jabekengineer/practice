#!/bin/bash
# Demo script - runs a specific concept and its test

set -e

CONCEPT=${1:-hello}

echo "🚀 Running concept demo: $CONCEPT"
echo "=================================="

# Check if concept file exists
if [ ! -f "/workspace/concepts/${CONCEPT}.sql" ]; then
    echo "❌ Concept file /workspace/concepts/${CONCEPT}.sql not found"
    exit 1
fi

# Check if test file exists
if [ ! -f "/workspace/tests/test_${CONCEPT}.sql" ]; then
    echo "❌ Test file /workspace/tests/test_${CONCEPT}.sql not found"
    exit 1
fi

echo "📖 Running concept: $CONCEPT"
echo "----------------------------"
psql -U postgres -d sql_practice -f "/workspace/concepts/${CONCEPT}.sql"

echo ""
echo "🧪 Running tests for: $CONCEPT"
echo "-------------------------------"
psql -U postgres -d sql_practice -f "/workspace/tests/test_${CONCEPT}.sql"

echo ""
echo "✅ Demo completed successfully!"
