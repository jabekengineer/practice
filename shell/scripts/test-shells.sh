#!/bin/bash

# Test script to verify all shell environments work

echo "=== Testing Shell Environments ==="

# Test bash
echo "Testing bash..."
bash -c 'echo "✓ Bash version: $BASH_VERSION"'

# Test zsh
echo "Testing zsh..."
zsh -c 'echo "✓ Zsh version: $ZSH_VERSION"'

# Test dash
echo "Testing dash..."
dash -c 'echo "✓ Dash available"'

# Test PowerShell (if available)
if command -v pwsh &> /dev/null; then
    echo "Testing PowerShell..."
    pwsh -c 'Write-Host "✓ PowerShell version: $($PSVersionTable.PSVersion)"'
else
    echo "⚠️  PowerShell not available"
fi

# Test shellcheck
if command -v shellcheck &> /dev/null; then
    echo "✓ ShellCheck available: $(shellcheck --version | head -1)"
else
    echo "⚠️  ShellCheck not available"
fi

# Test bats
if command -v bats &> /dev/null; then
    echo "✓ Bats available: $(bats --version)"
else
    echo "⚠️  Bats not available"
fi

echo "=== Shell Environment Test Complete ==="
